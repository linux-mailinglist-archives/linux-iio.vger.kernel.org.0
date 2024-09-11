Return-Path: <linux-iio+bounces-9441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A2E974BE7
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 09:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93001281B67
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 07:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2193A13D8AC;
	Wed, 11 Sep 2024 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jf7mYAfT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDBF13A884
	for <linux-iio@vger.kernel.org>; Wed, 11 Sep 2024 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041299; cv=none; b=FfmpWtyKdd+ZbEeTxElY3H2ihBDpsBTL2mG+CadxtWqJSBRpYuSuNCsyynO7eJbbASelyf2BP6yWlfdDaP0eUPhaZoYg1kWWRwHTPb3FBUWf3kW9gxIy7IAPbiSPD7B4/cc49K4YjB9Gca8GnY5UUpboAppIdQar234mXwY/1CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041299; c=relaxed/simple;
	bh=FCNL3enQMB9b9oZ6WMqPum3crBISQcFGFq3X5va//7g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q8ikoyp3jdVdG1IWe1KZbU+8bIwOPlM28FC4bA1Ri8WioRrcT/RiuYQyEjAs9MiFZYcuNVUtGgAUtdvxtBydMCG7HpJhODjyvupBpQWnHBfiA1gjAVp9ujiuq59IjRrc9WXOexbctwxOwXQbDWLrk/G+4yNRcYmS20gHYp4J4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jf7mYAfT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so219295e9.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Sep 2024 00:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726041297; x=1726646097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6g1B5VNTS3oGUnmfFgas2SEgEdUHJ25qE4oeaeVF28=;
        b=Jf7mYAfTK+7+nLfpBRrzt0teLyOUOBMRtPJ/i1G7CgGswcZhh463d3hCCkYh5M567s
         p6GEiQUSDDt7Uo7ywZ6VogEQKaOA1vfDtuAYqBAs/qHXPveUcBkXipIzoqO50ZYwbxKP
         4ox9vNR6RWmXfvM7p2xN7QferFy5wu0d03IrFWNdIWuf6wqdtewS4MXsN6hBdb606mS3
         XByXBe99T7wxDTiconDnKE4JHTP/7PEPqCJ4PIrz+sU7R6+Gs0t7jSY9zqMA8CsY1/6L
         PwYGVg8RwY8dUp4aAwNTDROesiBEZXLzcdqDseEwFz/4HcoV4rblNAnfn8513YNYs0Rg
         0Yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041297; x=1726646097;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6g1B5VNTS3oGUnmfFgas2SEgEdUHJ25qE4oeaeVF28=;
        b=jy+1583ql7CZLtrSlKZMmg2c2hCDl49KuLP756svZKU/r9RA2Pk4Jh0vhY9uCXwCg9
         9GGY+U4zFnjivRtQwyGEL2OfteN7VkAkbn04mxuq78pVus8pGo7uVbVCY5DIk6Ol0txt
         yWflpaiGWk+FU+DpbOGJBapuhTKLQpgvONeNcwOjhj8gqALVcdenYYmG/43Khm36bCk2
         m6g7PzsUi6OdzUrVLxTcoGJr6e8Qd4+GQ3qdFsxlaKd67cUD30zj2822XqFcHjUHG7Td
         URPXgVi/R2C4iyfUGa9mRWI45KYxdIRUNGgsuadusGtqB3XUZroWv6eU172T+2GhHwoU
         n7ew==
X-Forwarded-Encrypted: i=1; AJvYcCW8hQT1Nj6+vFaP7PAfviVZS2Mh6rWj+8P1hRQwRuhXR8owouYqFgiFR7LHX1gPvENt5rjc6Zi7XGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzivKeP04UAG0kPX54cvQ9iffvRd0Cnl+a4oKs4C2Z+w0HzuNax
	DjiVh+AqEVTdgFL3AfnA0IKapVX4A1eXCngZ/xgdwvy12NSgREmF5q7Gb10v8ig=
X-Google-Smtp-Source: AGHT+IGMaGtd5pusGWK5gC/LDrjf44vrtvtmz1nIDEiCzD9gkk+z8vd9V1M7P304PtExRrT4QkP1sw==
X-Received: by 2002:a05:600c:1906:b0:42c:bae0:f066 with SMTP id 5b1f17b1804b1-42ccd325863mr17424475e9.13.1726041296559;
        Wed, 11 Sep 2024 00:54:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc137556esm42959305e9.1.2024.09.11.00.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:54:56 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:54:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jagath Jog J <jagathjog1996@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: bmi323: fix reversed if statement in
 bmi323_core_runtime_resume()
Message-ID: <273b8f96-0d32-4913-bc6b-e91b391e7d7c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2efd1dd8-5a4f-4df0-8acf-972c91b7c9a0@stanley.mountain>

This reversed if statement means that the function just returns success
without writing to the registers.

Fixes: 16531118ba63 ("iio: bmi323: peripheral in lowest power state on suspend")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index d415b6542089..a56259c6434e 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -2232,7 +2232,7 @@ static int bmi323_core_runtime_resume(struct device *dev)
 	 * after being reset in the lower power state by runtime-pm.
 	 */
 	ret = bmi323_init(data);
-	if (!ret)
+	if (ret)
 		return ret;
 
 	/* Register must be cleared before changing an active config */
-- 
2.45.2


