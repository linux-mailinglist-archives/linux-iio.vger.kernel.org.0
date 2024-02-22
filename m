Return-Path: <linux-iio+bounces-2888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E4685F158
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 07:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC88B238F8
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 06:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBF6171C2;
	Thu, 22 Feb 2024 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tqHv6mvb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782FC16439
	for <linux-iio@vger.kernel.org>; Thu, 22 Feb 2024 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708582473; cv=none; b=FvP/kPfSE51UcQyk4F7qcTneJ/6tjasqtohgKE+1Xjxjab2Jrsu4jY+L4kL0cadMpLwXqycYCbXTQlmT5dAVgrD/EOJ3M/yNOGO3DaoPYuPBqq0tbbb/ykEmaX/bK6zk+u4AooyIiZ7LlzCnnNS0EL98lu/Uxet1QXlOMSdEr+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708582473; c=relaxed/simple;
	bh=eronbDz8hniFpG4P8U1NjCuXIc5mT2H0q1+vHe4QvZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qfDJz5Ya1ZkZywoDqmhwxflAxGWgcVaoFuDOnv9TLQ4XuAOcBSX+gvFuBAHz5NI7rKtWDvgOEyPQFznr8K7gh6QYVfiudgbldry2tze5de/jGWVCCAKlplllMyCHrFvfUep9Q9q7iJt6iwWKzm+0rBfSb6npydtpE5evQl54Umo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tqHv6mvb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so10478805e9.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Feb 2024 22:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708582469; x=1709187269; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihJpziOlMuDcSvTLuJ/gU0Hae3a368M+b9HMO37f99A=;
        b=tqHv6mvbEQESR6TN0fWmiYp95YTLBbXV0HW/8XpTFbJokG75u9vku9tiZy+qEmaEDn
         m0UnFrKessgtla2iX1TVY8SK7qMJidIjCCqFoXFuyEHy6DvVJHS67Os2QGUmdRwA1+7R
         V8aBXwezYOGqQ/Vhg2Ynf9lTvYqWcuSM5S4TssexsqHBZ6ZbMWm0pgL9T3jjlj1+vWQo
         ZqG7hcZ20xlxcq8shbXZkw/ZT9vhsUgEsu2a/Zs/25/U28F2lAE676BJDi+3kgi2aFtL
         OwJFBy0fWUE80TdxrWsDO9xj7qU6dkorGxglyV7DsoorOZD3Km07LQTgCIIiMPZcmISm
         LjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708582469; x=1709187269;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihJpziOlMuDcSvTLuJ/gU0Hae3a368M+b9HMO37f99A=;
        b=foBLdw2QdKVwIZfLZskw7w3G0YgptLp9JKxrQK5ERu+3pUClXQwMr4AO2I1rSiDRDx
         uvzISBTLJX9PLvf+peMIUFyhkhX0OpMjB/TGpnXmSQWvELQRidhipl2uwQ/SLec3W23C
         cLfGPweEaoVPa0VFX7DRgop7guK0sDJ06cFbgTDVLbcVXtlLyoUq6YatPFE/4ULAU6Q2
         zGe3y7v4wcLttanz8X4kYT7UmrtIza1kZCuTQKfpAnjyulhAgYr22cqOJp7u88sJ/Y3w
         K7HkPg8K+1aLiuNv6EA8eiA+MVY82OWRuUe1C/P7HVG40977bCTG8pi7OjfdPZSSkCEU
         M7RA==
X-Forwarded-Encrypted: i=1; AJvYcCVf7ObETl/LTCV6/kpB4OGu0h8UsdINOj2Hzule4VwRhzpePMHx+mMm9FfpJkwt07Qngmv3dX8GvlS+OoF/NCi7xX4aaWr8znLf
X-Gm-Message-State: AOJu0YyD1QhPqhI9o0j8gTMhYLBWzIXIdGAsIgnBeajrnpX2Z86wKScb
	HSG7RYPKaSY87X3VAZUqAtnIKVTvqXJr8zh1QmFyHi0SFtV2Mw+LUFPAl+5s0wc=
X-Google-Smtp-Source: AGHT+IGopM8CATzEXKdXm/OXCkYnC4ug5JZs7YcBQ+FJg2FL6Lca7YApWQZuoAl0Xt1vK64K14teSg==
X-Received: by 2002:adf:ea82:0:b0:33d:29d3:1aa2 with SMTP id s2-20020adfea82000000b0033d29d31aa2mr8014703wrm.12.1708582469338;
        Wed, 21 Feb 2024 22:14:29 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id cc18-20020a5d5c12000000b0033d67791dc0sm8215530wrb.43.2024.02.21.22.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 22:14:29 -0800 (PST)
Date: Thu, 22 Feb 2024 09:14:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] iio: adc: ti-ads1298: Fix error code in probe()
Message-ID: <5f393a87-ca8b-4e68-a6f4-a79f75a91ccb@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a copy and paste bug here, it should be "reg_vref" instead of
"reg_avdd".  The "priv->reg_avdd" variable is zero so it ends up
returning success.

Fixes: 00ef7708fa60 ("iio: adc: ti-ads1298: Add driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iio/adc/ti-ads1298.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index ed895a30beed..67637f1abdc7 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -657,7 +657,7 @@ static int ads1298_probe(struct spi_device *spi)
 	priv->reg_vref = devm_regulator_get_optional(dev, "vref");
 	if (IS_ERR(priv->reg_vref)) {
 		if (PTR_ERR(priv->reg_vref) != -ENODEV)
-			return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
+			return dev_err_probe(dev, PTR_ERR(priv->reg_vref),
 					     "Failed to get vref regulator\n");
 
 		priv->reg_vref = NULL;
-- 
2.43.0


