Return-Path: <linux-iio+bounces-23692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F145B426E3
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 18:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAB13A58E1
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BA02F0C5F;
	Wed,  3 Sep 2025 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rap7OZnB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231FB2DCF6A;
	Wed,  3 Sep 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916883; cv=none; b=Tw68MfGM34kuPiP29w7Jm2uQFhMj+VTEfMyo54eg3hgZVfxqbGK0/w4OA6uidJ65lh3LH7F6cOduoocN9MDGhBcGEDM5/J3jcQWsFcy9swfX/1BumOnS75IPCFHkgulrRBa+4J6YyYysaEBt4eXhqkg1kugJUXLMA0bFGIcnEMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916883; c=relaxed/simple;
	bh=EBohViFOa+dsXa4yyop0Bt5H7z7JZZZrsgz7QvPUJ/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tym4nJ6Sh+vamWvTwIxzYKrdri/6COdpZ0NXRFiEQrTGoiynWyunWMuX4dLQ0Dtp/X7uIrxFcIB53zGkxkRBfk355R5XreA89yuW7rEe0y/skV0KZ5bTTp/C3bKlAqC71fCvNFBnQoFKV/PV/krQwSiYr+6dM4uLsL55bPauv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rap7OZnB; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f646b1db8so30814e87.0;
        Wed, 03 Sep 2025 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756916880; x=1757521680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKwY4DhElzmLAW44tC2u8BXph+snXe7hdxovk055nXI=;
        b=Rap7OZnBfV11F8QjOCvFhL7pTrwl6ELtOxYcpkIcgAJiF6pTJ3Md3o+a66dYdbIVpn
         AVzveGOrD2oBBiXVtM4FAI7+4ynqmuciKlvjfd4heZUAqugnZi0wzdkBjw45bgEf8t2i
         ABiwqLvAgCrbK8rhUBBGioTGZeZZz5M45Uu4/Ps2C4wtljbGZaMXCPfa98SfKqnSTiCN
         soOnVLpmfMXHo4PtD0fbDNMLCDKpmH+wu3X0BB7Ie5IMwDftgjvzcdCEzGJ77uu9z6xz
         hOMZmAflJs/i7vq6vtFWRUWesuHOUKwtD4vQ51V9/aVbRQnOMfcT/RLlhQ3t3zz5bHG1
         AcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916880; x=1757521680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKwY4DhElzmLAW44tC2u8BXph+snXe7hdxovk055nXI=;
        b=vG87iBiE0FY4upxEabOf7756V7iYxxmkC4rZT8ZYDPWE5XKMCSURmFS00IuGuz1fMC
         mRuTCfhv3FcqWwo9z+wOohl+p/uL45bUPqMcol6n+rsHEuUuBpW7l5V7mCvej6WlG3E+
         t/Yq5ojG1QfzgxY1uVKnZiTJwq7Dl5Q4jhZu9YrtDBSi8FnRx2IBi10OAKjr4AtOwaYS
         Nw8V4ZW3kHFXrqMqxnQIC1qfsnP+BPHsOSZmobKcOjeWU7/QVT0qiXcXSiSgNo0tH3GB
         srabAI3k+7A4+4hBMkFT1MD4g2Wlf0UdhAp68SW1UCXBlTprnUx55s8O9aTbShoi8Uh9
         7/nw==
X-Forwarded-Encrypted: i=1; AJvYcCUC+u1nCWlQvnsnexx8tsMz0jJe9xsCG9CpE1ohFg/sglViAB/CtKtVHg7Kkg/3x+jEGyOTTE4ske9kfiZL@vger.kernel.org, AJvYcCXDu1v5WHkAbY+Nni94B8B9Z+JclSC++0Bryzs5HDUtZAbaCnytA2UUCT1TeILwrRmE7a2J9pQ0X2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyymWtxahszyyWL/ww5nwS4kRu2TxHoXOtGqfHlGZJ4TgMg8qJ
	89brf8Jk303sPh2WD7wyKeJKXgPCtkyvj//G6eZp8aKGQcp5lkkLcyRD8BcZQA==
X-Gm-Gg: ASbGncvPBMcP8CZZjDnN+0bK72Kbif9YiFlz4s6DMpO7eU2sGzVs8nk8N7XiGU2lB13
	m7R9Uvitso2M+JB8OTns1bKNjuz/4up6Ptq+zNNM2C9ZMwD9eD4E85fJE7764ozDsOv/HltkEZy
	Tkmo7550dZFs6FdiwiwkvcRKkj88k6aBv6drD9swCC3hiNN6GHsjmUSehfb5PdI23I9EOBLomK/
	o0TCc+2Skc7QNAm0Wmw+P6FMwbsA3jAOMQXzvWVQI7DA1j3eDdipZhQZ8m7hdGlBa9VoRIsrqYR
	3hRaQl8Dy7rRAD8KfOZkUsgPsn+oeQ5WklCDjw4006HlDhaDTLPyvVoMKcaAxkrQlUHlmzEHYdD
	n6FaygMUmfIIQqYBgKjbPrXwX
X-Google-Smtp-Source: AGHT+IHj3SgFaGchsUOft9OXgYR7Y+TN/YuP+QCJMCjTUO6YbeYAfxIj5WXG+eqiQKKKgXaivyyiMg==
X-Received: by 2002:a05:6512:eaa:b0:55f:6f76:418 with SMTP id 2adb3069b0e04-55f70948ae4mr5186334e87.44.1756916880061;
        Wed, 03 Sep 2025 09:28:00 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ace9fddsm604665e87.78.2025.09.03.09.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:27:59 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v5 1/1 RESEND] thermal: thermal-generic-adc: add temperature sensor channel
Date: Wed,  3 Sep 2025 19:27:49 +0300
Message-ID: <20250903162749.109910-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903162749.109910-1-clamor95@gmail.com>
References: <20250903162749.109910-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid duplicating sensor functionality and conversion tables, this
design allows converting an ADC IIO channel's output directly into a
temperature IIO channel. This is particularly useful for devices where
hwmon isn't suitable or where temperature data must be accessible through
IIO.

One such device is, for example, the MAX17040 fuel gauge.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/thermal/thermal-generic-adc.c | 55 ++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index ee3d0aa31406..7c844589b153 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -7,6 +7,7 @@
  * Author: Laxman Dewangan <ldewangan@nvidia.com>
  */
 #include <linux/iio/consumer.h>
+#include <linux/iio/iio.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -73,6 +74,58 @@ static const struct thermal_zone_device_ops gadc_thermal_ops = {
 	.get_temp = gadc_thermal_get_temp,
 };
 
+static const struct iio_chan_spec gadc_thermal_iio_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	}
+};
+
+static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int *val, int *val2, long mask)
+{
+	struct gadc_thermal_info *gtinfo = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = gadc_thermal_get_temp(gtinfo->tz_dev, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info gadc_thermal_iio_info = {
+	.read_raw = gadc_thermal_read_raw,
+};
+
+static int gadc_iio_register(struct device *dev, struct gadc_thermal_info *gti)
+{
+	struct gadc_thermal_info *gtinfo;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*gtinfo));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	gtinfo = iio_priv(indio_dev);
+	memcpy(gtinfo, gti, sizeof(*gtinfo));
+
+	indio_dev->name = dev_name(dev);
+	indio_dev->info = &gadc_thermal_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = gadc_thermal_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(gadc_thermal_iio_channels);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
 static int gadc_thermal_read_linear_lookup_table(struct device *dev,
 						 struct gadc_thermal_info *gti)
 {
@@ -153,7 +206,7 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 
 	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
 
-	return 0;
+	return gadc_iio_register(&pdev->dev, gti);
 }
 
 static const struct of_device_id of_adc_thermal_match[] = {
-- 
2.48.1


