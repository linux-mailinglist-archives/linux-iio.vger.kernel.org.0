Return-Path: <linux-iio+bounces-22997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7DEB2C7FF
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 17:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FFD1C2576B
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 15:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AAF27AC21;
	Tue, 19 Aug 2025 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lM46UYUv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA7C1FBCA1
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615781; cv=none; b=M+tkh4p7lnOgLrBMNO16lYXKE0IQsSQv6VsHjfsmgx+VTWG2iJRxdKydlAH4TK3ZGlVsd7Ue5CHPJnmDDc4WTeF4Th2eEppD9fiTpRom4IBPLTrH2ky3YVeWoOZG3nynJ0CnXSVIqhr+60k44JDSJFT476GAPRRHNn81nTgvHsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615781; c=relaxed/simple;
	bh=nDsBN31ZPTJxWv5+xI/XKIMoevKJa238JoEMH3TkX7g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nePLFm5dGiG9ecg4pvK7o//1ukZZmcRfbxcxfSSIpRAaFnz0fS5CHh+lVqClOQX5YCVQDLsbIV1HsCz9StxlyzS3vWFuJfRQVFg2unyQqTDdxEVSqiI2oHejaBOddExp85X0o0K5XPyCs02iyCUXQmSNQDWZz/lDhMZsV9pHEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lM46UYUv; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9e414252dso2616740f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755615777; x=1756220577; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7444yQJ0rbL29maRl29fRLR2UuJK6Q0bhtUk89IdD0=;
        b=lM46UYUvzuwBGRf6sqgIXwzjuOMkbQsnmFtz2+R8hLhfxzivfroRVDUEcjweD5prk8
         bRg1SE5HuXpjI9KO2/heIhzQ0cFW4ERxBT+XWl5NnmvXQMf6mXfdQVDHh53JBAInmrsU
         l8+jGse2VJZgbvo3TKpl9Tm+VBwzDf/T6vZgFh8tp/J1nSwEsvU+BmESCJtvoObHa6Ne
         RLXel9FqWM4NdtD55ZPEzxNPnbzvuNZizhIV3oXGcKtrEpP/Twlas1K+63+HVF/4Gtpw
         hCq1nrkIso071vnzo6LU1BuVtwcBZpkUv7sFskQpq/HJeVTUETNYiqcsoxs9d29PVSyf
         9bOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615777; x=1756220577;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7444yQJ0rbL29maRl29fRLR2UuJK6Q0bhtUk89IdD0=;
        b=MFgs7gb3yDnjJyWRTan8g+TxI2zmtVQk+Iy8XuXrGV/6cFiVGzXNiLebxIh7mhFB9H
         s8CtH0tvKUCdf0LYZemgVyQ/anuzs2EBuMwF8wGPu0W9Z+JnRznkR3eiq3m3To7r0YUw
         tj6WQQlP2CVX8u9wR9ARkkoTqXGspupriFiDuA6Gg19xfRPx5hO2aiPlmQ9ynAGiZmYs
         k3zFOwYG3wLA6R79S+vaAbwXEznyiZupPu2M98FF4p3VHZp90rtwuCGQginirNrLoYCA
         H3DQJ4ZFuIPB9liGCx95N3rqEnMBczPifXrmepDDZh1dinbmjdkrpWTOHiJs7yyktk6g
         BQng==
X-Forwarded-Encrypted: i=1; AJvYcCXd9BXRIQLAQdXdOlzkNWheDPB8I/SJGkoZdHUyII2B21QiTsG8PazTxRIhAN+jzpi74bAWqJ6ptlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfz8Km6+q2ftXELYvFDYMAkh+vOGY38po0xnd3soExpvFtT97H
	Azvf2+zDMaEv4MfbKBL6SSthb6y2pM0mcSZgpSpN6S0Qe0hgm/eYW6KeHBBPKQ1zOy4=
X-Gm-Gg: ASbGncuxcn7bGzeLaXEx49dQz/XcVLkPQN/4DFyOBTXMXpaKCvyuRgzUC+DRXWRticA
	hyUIdRt61NfNBJh9I3Za4bQzSSkJwjWu7XCTiiLuLZ7g8smpHCAjta4ywlIAPW/1Y9VQB0Zq9tU
	ikuJ3Jl5seqTXV7tKEKvXJzRMdztKofysG2HBUL8o/EaibSVSZNEUqNiYjOfArb3QuG0TX15W+4
	N0nNEqOXb3fqx3Zi9xgAWOQV8zgMQdqQf827K9h0OyxoHFvmKrzPsWOniIHPKprQ9cWKDH1CS0l
	PqoIZ54iZju+N3ckK55IyoM2WPk2RMJ7bCBoD9fN3sb7zu+/ZRuX3xM0hfZBkzQOeU9j4bNqA/L
	y8Grx7PocRq+R3R+pVZdolYBa2l/1UwfI0M4VTg==
X-Google-Smtp-Source: AGHT+IFWnJ6Oo82ofz39gNSEwN0Z3yDLui3rTcpuA0COSeut86mLsEFA0jwdaleJOlWjIR41+mglKw==
X-Received: by 2002:a05:6000:2404:b0:3b7:9d99:c0cc with SMTP id ffacd0b85a97d-3c0ed6c38ecmr2311284f8f.51.1755615776853;
        Tue, 19 Aug 2025 08:02:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c074879864sm4134355f8f.13.2025.08.19.08.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:02:56 -0700 (PDT)
Date: Tue, 19 Aug 2025 18:02:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Song Qiang <songqiang1304521@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2 next] iio: proximity: vl53l0x-i2c: Fix error code in
 probe()
Message-ID: <aKSSHTdJf5QoYiRx@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 65e8202f0322 ("iio: Remove error prints for
devm_add_action_or_reset()") accidentally introduced a bug where we
returned "ret" but the error code was stored in "error" if
devm_add_action_or_reset() failed.  Using two variables to store error
codes is unnecessary and confusing.  Delete the "error" variable and use
"ret" everywhere instead.

Fixes: 65e8202f0322 ("iio: Remove error prints for devm_add_action_or_reset()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
v2: Fix typos.  Add Andy's r-b tag.

 drivers/iio/proximity/vl53l0x-i2c.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 696340ec027a..ad3e46d47fa8 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -311,7 +311,6 @@ static int vl53l0x_probe(struct i2c_client *client)
 {
 	struct vl53l0x_data *data;
 	struct iio_dev *indio_dev;
-	int error;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
@@ -344,13 +343,13 @@ static int vl53l0x_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),
 				     "Cannot get reset GPIO\n");
 
-	error = vl53l0x_power_on(data);
-	if (error)
-		return dev_err_probe(&client->dev, error,
+	ret = vl53l0x_power_on(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
 				     "Failed to power on the chip\n");
 
-	error = devm_add_action_or_reset(&client->dev, vl53l0x_power_off, data);
-	if (error)
+	ret = devm_add_action_or_reset(&client->dev, vl53l0x_power_off, data);
+	if (ret)
 		return ret;
 
 	indio_dev->name = "vl53l0x";
-- 
2.47.2


