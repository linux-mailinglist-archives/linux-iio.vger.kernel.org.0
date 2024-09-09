Return-Path: <linux-iio+bounces-9379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4842971570
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 12:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8E21C21AF5
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 10:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50C61B532A;
	Mon,  9 Sep 2024 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqJA9smc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253451B531E;
	Mon,  9 Sep 2024 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878246; cv=none; b=jMrxiw1GaAzd3WamS8hpx27fFBvDdOVGLEdtq/8kb+S9nU0P8wSeoUruBH6H6twlB3bDaCJjKJ6wIk8m2EZ7S0qnqnoIfEvjwzljo3+vngYIezFpzS3RUNsXNCVbXn522xDyOXf8cPWKwrXtWmGwl5H+NJGiud8nbTrntsTSX3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878246; c=relaxed/simple;
	bh=ZY51vahykKTtxNfMnqXqfEr+7j9AXVcEUZUVgG8ugUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulcJyqDOUQOb/Bkn1PUkSUE9UWLMu8kVeUQ3fK4wu4m0Alpzxd6D2BB2AWxI2eWHc22crhNjf85+Pevmo6zfkQ2TOxAvEGlrDir00ZowUm/S76tAIRtjKSbhJC0BcWBRKY2NzW/pEIn4hNTB+ALHf7SDN7R09Injp5yc4L830e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqJA9smc; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2689e7a941fso2644959fac.3;
        Mon, 09 Sep 2024 03:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725878243; x=1726483043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq1aRor6Vaho4Co3OEdp8Mb4+CwARpFfzv0gXPyBQ1k=;
        b=VqJA9smcwC/jTdaVOXFLkBJNQRXL3J63TujEKx3/hQn1dVFhKKp8w4Uf0OiowCLPLI
         iv43dfQfUakBTuRgKnPAhJCbuXWqebwPomYIgOdwg/fhlOrhpNBb6KBSAKMI13sVLnsJ
         NLbCVY5Rq5PbAtOqdg928bSwZq58cNU6lqEOrmulja9Lqb0X9LH6xbRLVe0gSoS/kYX7
         J8W5r6Cuv5x7z6JBFL+lL8DBZODzIIfkz5FSiTQn8S9hoz3ToGqPEli2g7Rhhaj7wQUD
         WAZ88HLkCdzEXCjVrBhcEqIaPpvGH/0S4MTWQAs/XvevNAi0uk12oZn+h9vRpH6Wo5e8
         0fdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725878243; x=1726483043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq1aRor6Vaho4Co3OEdp8Mb4+CwARpFfzv0gXPyBQ1k=;
        b=Sn/r4oZLkrQBHdFO2mOWU6wJEVmM0Ijsmyp7qHOsvTcs8kw9ZHOC1ouhMNCxdEWIZy
         wxpBPvdAEYaPn1LcwSC9ZhsuUloLQa8S8Chz+4IniPiyPONpUaF/F5wnTnzRGwLa3coW
         ICjD+mSC+bwHzkIVTQR1rkLM+h+rxumeL3NqQQHqs1igsdojdPv2WVKr1i659DIW1rBK
         7mrCPUPWBE94Xp/CIch+gBv2PHlWldEyLQmR5smQe2BPAUzJzEZBcFrlViXhebDaN3Sc
         QR5HQgMs1bhofV/RButN5PlYSx5duLJSbOAivyEC8a9FojuW8kgL3BrydFBX3R1E/kKf
         bF8w==
X-Forwarded-Encrypted: i=1; AJvYcCUlwRwsuxhR2sTgVOm2PLFAS8qjTncf/HhqXVLbpRbWAGeMgEjPtd/tkG7IyfBzcVIfuGvsXsr4pXe1tqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyny4oL6O4E91F6b9Xes51rwUjZIpcXp8hGBgz8bnrF7018YxJf
	zeaC7XEHXQXcVfVyXx6IcEGzspXQSguWLdDXj1El8g6Q5UaKaV9DkIH4awol8X4=
X-Google-Smtp-Source: AGHT+IEwTsgkU2Lka+SuMUBV2K2e8TUqEQbAfxHJ+/+tGd3hOlmM1ZXFd31VKISc0Iew1g6pg0iK9Q==
X-Received: by 2002:a05:6870:1c8:b0:270:1850:f898 with SMTP id 586e51a60fabf-27b82e1203amr12552164fac.12.1725878243192;
        Mon, 09 Sep 2024 03:37:23 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e5897b3fsm3258032b3a.25.2024.09.09.03.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 03:37:22 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH 2/4] iio: light: ltr390: Suspend and Resume support
Date: Mon,  9 Sep 2024 16:06:21 +0530
Message-ID: <20240909103623.264113-3-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909103623.264113-1-abhashkumarjha123@gmail.com>
References: <20240909103623.264113-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added support for suspend and resume PM ops.
We suspend the sensor by clearing the ALS_UVS_EN bit in the MAIN CONTROL
register. And we resume it by setting that bit.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 73ef4a5a0..c4ff26d68 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -432,6 +432,24 @@ static int ltr390_probe(struct i2c_client *client)
 	return devm_iio_device_register(dev, indio_dev);
 }
 
+static int ltr390_suspend(struct device *dev)
+{
+	struct ltr390_data *data = iio_priv(i2c_get_clientdata(
+						to_i2c_client(dev)));
+
+	return regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
+}
+
+static int ltr390_resume(struct device *dev)
+{
+	struct ltr390_data *data = iio_priv(i2c_get_clientdata(
+						to_i2c_client(dev)));
+
+	return regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ltr390_pm_ops, ltr390_suspend, ltr390_resume);
+
 static const struct i2c_device_id ltr390_id[] = {
 	{ "ltr390" },
 	{ /* Sentinel */ }
@@ -448,6 +466,7 @@ static struct i2c_driver ltr390_driver = {
 	.driver = {
 		.name = "ltr390",
 		.of_match_table = ltr390_of_table,
+		.pm	= pm_sleep_ptr(&ltr390_pm_ops),
 	},
 	.probe = ltr390_probe,
 	.id_table = ltr390_id,
-- 
2.43.0


