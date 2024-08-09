Return-Path: <linux-iio+bounces-8356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC83094D023
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 14:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77402284046
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 12:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A349B1940B3;
	Fri,  9 Aug 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TXQbh/R8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB44919408B
	for <linux-iio@vger.kernel.org>; Fri,  9 Aug 2024 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206518; cv=none; b=RtU1HearsvzqbWSisIgkeGtQQSscuoTqpXqdqgz/DaCj4gY09CgAvah+kQPPU6gfvQm/VCQ1SwUbPr1ANM/okjbQ1s4yjvtUGBwxJEaB4WLwMZ81wcrkL8U4h2xcHJKIZ0cYE4wCDfB7c86C69HJhL9D2mFyrOqxtdDLCmqx02Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206518; c=relaxed/simple;
	bh=WTJchTACFfF0mgG9BvMoLf345L2toTwrGpG2d6j2sKI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y0YBO9b/dLfjBv7OZWxVdwuD+osqHVKGlMjMnHkKBFipm3zM78WgPrM4u626mne2G2W0lcAohK1SeHtGHnawYJ9PdcoJxAok4/qPPdHP35j0eoOWOPh1RknMymO5YYmLYVjlDPSb6vq4l+Q6yhic4CEvwcoHHuI6O2VfA044WgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TXQbh/R8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a91cdcc78so70266166b.3
        for <linux-iio@vger.kernel.org>; Fri, 09 Aug 2024 05:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723206515; x=1723811315; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPNE3LYTzfOr9xnzL4XgQhlciyEiRjVlcUsL9IXDC2A=;
        b=TXQbh/R8CbvT9B5bv1NNHtKw/El4iAcoWDQOCflpUn3svM4JxfOhNb7i6S0wV3BZMv
         IDbjG7POB15FtkDbFJWLJ+9ODaidBWSbKJBnRhKLvYByQT1Mv2Wp3Bk1+O1mIVCzQywY
         mhkzaxKsYMMbbu7ZiDtaVUDDbKmYvT80Acugt3fgg9pP5rSbMn1ix9rg5Odfw5RqZoVs
         ypTD5KPvyWOzXqVQAi66FjUBVXQFastKF7E1a2ac1qP55UkVXarb13lT3Zmd+qGKkUUP
         Bz8u0IBPb/rsuSBvm2B7Cx8O4MIotKH/6aUW4mLV7pVpUUwwcyqRUvCyI1mAsfGEpA53
         LXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723206515; x=1723811315;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPNE3LYTzfOr9xnzL4XgQhlciyEiRjVlcUsL9IXDC2A=;
        b=gDxyMrcNirVXUNPLlRW9mlZdglFiteRCADEyuH5NfNP7F356kBSOyNsOmYwyWoHN/w
         1mddn0AJj9gVTPrIEjZ0Vl5BbzE0A+yPB2Af/3JBKkdaR/+lt1yzmVlLUta2pkBSmbPv
         iTVJFTNNPwVos1CmdbE9xuzSshVp76R3lk43rW95Msxs0y6Tu5KP/WuUXJNfk6W1tSg6
         zSFCzW0+hyWQOpyi44ZZre+y522mFta3DgChqKdMKCziFAWq3l/Gp6Kv/7TYqoUPJ0ii
         yc1qbYrE47wDt04JIdgyXbxa4SKKWBo04Yxq7A+NF9JLccDFnZv9FpS1CjhFXuzJTAbJ
         o/Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXqICcB+FxI8xadWHFky9ZtX2JzEUH2i2yqUbB1/7K0OTGBiITUAJUsR0fmTs7IRpp2JU95arMtfrdlEyrxCKB+S1Q7eZSc6OYC
X-Gm-Message-State: AOJu0YyZX7Mm0HTNG/h4El4hLXYzik44tic4Vqfs2MVX+V2/aufHjETB
	16XMR1NSU2YYfVu8GN+Dfb2GhcSB28i43jqIGFIjz76VetvPN22nTUhrBZQEb0GlMnBcM/pyUOy
	E
X-Google-Smtp-Source: AGHT+IHA3gHe6QowP5BFUwIqbqka7d7Ush/Dv+zY+06NT7lYfHcBRJrUte01orPcNeHqhOadMXetwA==
X-Received: by 2002:a05:6402:4345:b0:5a2:8f7d:aff4 with SMTP id 4fb4d7f45d1cf-5bd0a56cd2amr1153405a12.20.1723206515029;
        Fri, 09 Aug 2024 05:28:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf8e52sm1476324a12.4.2024.08.09.05.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 05:28:34 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:28:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: dac: ltc2664: Fix off by one in ltc2664_channel_config()
Message-ID: <5727ab54-6280-466e-b107-1b6006e5ab29@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This comparison should be >= ARRAY_SIZE() instead of >.  The "mspan"
variable is later used as an array index into ltc2664_mspan_lut[] so
this is an off by one bug.

Fixes: 4cc2fc445d2e ("iio: dac: ltc2664: Add driver for LTC2664 and LTC2672")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iio/dac/ltc2664.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
index 666ecdeb5f96..5be5345ac5c8 100644
--- a/drivers/iio/dac/ltc2664.c
+++ b/drivers/iio/dac/ltc2664.c
@@ -526,7 +526,7 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
 			return dev_err_probe(dev, -EINVAL,
 			       "adi,manual-span-operation-config not supported\n");
 
-		if (mspan > ARRAY_SIZE(ltc2664_mspan_lut))
+		if (mspan >= ARRAY_SIZE(ltc2664_mspan_lut))
 			return dev_err_probe(dev, -EINVAL,
 			       "adi,manual-span-operation-config not in range\n");
 	}
-- 
2.43.0


