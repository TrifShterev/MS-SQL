--Delete all Feedbacks which relate to Customer with Id 14 or to Product with Id 5
DELETE FROM Feedbacks 
where Feedbacks.CustomerId=14 or Feedbacks.ProductId=5