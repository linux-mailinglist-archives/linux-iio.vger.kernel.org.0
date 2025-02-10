Return-Path: <linux-iio+bounces-15271-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A390A2F2BE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 17:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32E4167A24
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 16:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46058252913;
	Mon, 10 Feb 2025 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b9y3MuMF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5424FBE9
	for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203972; cv=none; b=FjHH+9x65gmUum3/lnDaEjoNdt80oZd6nK+/4IG5ZCirnk8bXlJLO6kYtru0aAYvjzOFOTdwE+PGwQlYyixfk62vQ2HPqUz4leB7JegZ+lWEnfaCFGB7u7cUC/eV0JQe0dChd8CKkHzxeYfxMBjuhVrqHRuCg7doRyORHAdd+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203972; c=relaxed/simple;
	bh=dioqZv2txBsr2G2NsI3KTjuvSsHBK1WMQvxJwpSgCpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwGa1TTnSxsgRjbjpwqXRDGAcbjiL8ru6ku/ZIhMq8sFj3A36gObdOYjaKFedWpxfWje+fMmgZXdCOhDZozp/FFKACuol50Ch8K7ba3tEpeUPbM2j9+Jf9Mk0ODIjYxT0YKgUTn0fSpIv6817tF2gu/zcnznKwkQYpke9J9/CNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b9y3MuMF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-439473da55aso6259935e9.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 08:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739203969; x=1739808769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlrP600R/ci5wFmyR+m1ecPzb5qUkdneDDlwcUEYxOc=;
        b=b9y3MuMFXdZk5UnwGNkzL3tGF/UoguHHXLfUTzvSVsX3Z+eXGBM6cMqME+9CxFlEzF
         fKfuWy5VdEs5/+vZXnMVsSKxzqQ1s4zbMGIZozZyfSzY/sIo+WPGsR90me2vjhRZwzmA
         otljs5BZR4bFEfYmXUh39yhIO8QwBREXOYTFF4P4kWBmXG8xU2zSGTfwlheccqBUSs81
         5LtR5Dd+BY3425MXiqANpHcBoNoHADAqfyJNYQiTc+FDQ890bIThjMxELGhLQQvf9lmq
         fJal8c3qgAeAfif2zwBvOx6OeCZvqUeZJ0pUCrGnpaSC2Zvifo858zHBUuML9MZ5pQtk
         YSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739203969; x=1739808769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlrP600R/ci5wFmyR+m1ecPzb5qUkdneDDlwcUEYxOc=;
        b=X3opnLi5h1EHkNz1vsVu8S2bFMq2bSLHxPPeQLNXZgUC0ofLxXYCGh0rbaaWW4a3v7
         l0RGOMoPTpvE1RswJtUrQHFqn6OUJQ+DjtdT8whl9+idkCtewbJFuCYOXWyRZoTTwWsq
         1oWrsxPLReOxKkTU6h4JpPtCHKiyJC57bbsVyvUpm5ynatX8FAtuzgt61+MlesDD7xoT
         ySSgmYPnwZna+7q3rL2iJsCfIEeOvbnSQj45Wn3MxNuyUJwtkuB4HfgDDQV0tGGUbSVh
         T80bEYRc8ijUFP60t9LPOfhyWFQ8EXVcvWYh8oZyrCgPIuXTjsN+Ue5ebYV0yZw+xUEs
         u5HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy5twcV3vEK1QNpb/n/yE3XKfhBvcgZ1sJmBuZ9pqTT8NZ68VeVxBFf9E9YENLTzXRx8Wp+PVj/Es=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsorwghT9/QMMo0TF32qwljWG6NBXazW0RM40j5pXd4ueLx4IS
	/O7YbRTZJ6TMLEhgHlCp9W00BFtaEaE0QvhZ5hAONPBnhxjloQoTOZMdfQfepU8=
X-Gm-Gg: ASbGncuul+zUstLbjAGXb6gm7Rc4Kcn0jsOeQP2CqUn/yldooRk3z/GHsC3TIqrukto
	SvQZ1Sbe/BwWHCYXB4QHh84nxAP8sHLwkNqsgLM6LYZdLme0jOnPvETfchfp8JdK/LAlknS+S41
	rjsc07oUosZDQQoDric1OUNbQpr0H/lNVpcuCPrnZOEW1C6A6gefdP+X6Z7H65QrLrB2x7xeOf3
	5NGY895AHgOBq9Y2mAJXOm47Med/cIe1qpKcsv2gMqZV9J1wBGwq2Cqna0KRs823ghai7ZBp4s4
	cDD7JOmk8J7wMMRstoSZLcR+1DZ/bOcVIPnsD293jDCEMO0cj3WJH2EBzlLoHGo=
X-Google-Smtp-Source: AGHT+IGQ20TR8IqLo3bvMy0IcaAnfycl4PjoyxaTBZPLOGAxAxi90IcCYacmnO7KRYC2/BYvJFVsqQ==
X-Received: by 2002:a05:600c:6dd7:b0:439:31e0:d9a2 with SMTP id 5b1f17b1804b1-43931e0dfeamr74180395e9.3.1739203968869;
        Mon, 10 Feb 2025 08:12:48 -0800 (PST)
Received: from [127.0.1.1] (host-87-8-15-130.retail.telecomitalia.it. [87.8.15.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dc9ffcdsm146637945e9.15.2025.02.10.08.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:12:48 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 10 Feb 2025 17:10:52 +0100
Subject: [PATCH v4 2/9] iio: adc: ad7606: move the software mode
 configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-2-160df18b1da7@baylibre.com>
References: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
In-Reply-To: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Guillaume Stols <gstols@baylibre.com>

This is a preparation for the intoduction of the sofware functions in
the iio backend version of the driver.
The software mode configuration must be executed once the channels are
configured, and the number of channels is known. This is not the case
before iio-backend's configuration is called, and iio backend version of
the driver does not have a timestamp channel.
Also the sw_mode_config callback is configured during the iio-backend
configuration.
For clarity purpose, I moved the entire block instead of just the
concerned function calls.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d39354afd539..376c808df11c 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1246,17 +1246,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 			return -ERESTARTSYS;
 	}
 
-	st->write_scale = ad7606_write_scale_hw;
-	st->write_os = ad7606_write_os_hw;
-
-	ret = ad7606_sw_mode_setup(indio_dev);
-	if (ret)
-		return ret;
-
-	ret = ad7606_chan_scales_setup(indio_dev);
-	if (ret)
-		return ret;
-
 	/* If convst pin is not defined, setup PWM. */
 	if (!st->gpio_convst) {
 		st->cnvst_pwm = devm_pwm_get(dev, NULL);
@@ -1334,6 +1323,17 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 			return ret;
 	}
 
+	st->write_scale = ad7606_write_scale_hw;
+	st->write_os = ad7606_write_os_hw;
+
+	ret = ad7606_sw_mode_setup(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad7606_chan_scales_setup(indio_dev);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad7606_probe, "IIO_AD7606");

-- 
2.47.0


