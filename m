Return-Path: <linux-iio+bounces-10972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300539AC3C5
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 11:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D68EB2698C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 09:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790F319F464;
	Wed, 23 Oct 2024 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CsMjOjtH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3456F199E94
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675188; cv=none; b=X8ySfTjHzXEu+j4+vcibsuFc/P2T0sUixtfK3F4Aunj5vwAldNSx5FbAmqQQqvxUDHLyUOkDelEgThfz8jaoxNrQ4EHCP0nhwhf+dEoa34nCcl5a3VDg5WrbBzdwa0L8915I/yasRGCxnDmyXCvMmj0NrWCdj+SbUZ50Uk7Pl3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675188; c=relaxed/simple;
	bh=5SRDC9p9MKxswYnd7y6LZi2xIt2zZS6yBwCYc+hydFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lsyFI4hcTjJnF43NiNJqa7oXVCmojRvXvbiNmgmfhQeGGgeyHX9UpLybPRxnzFmbLssknlLMI2sxH5CbTXfG9fQ93dzu6FOEz+HddHmkLe7MKx6uPkp9iPrqXoM5pX4Ey6Dx+JhomHQv7pyuPA+mbraPKJsHclI/vVtDKBJiY6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CsMjOjtH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43159c9f617so63456415e9.2
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729675184; x=1730279984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUAWPNA4323qWrX/2WYrVLftIYuIj6SGZHxAGWq4jNw=;
        b=CsMjOjtHvRXQRmEf5IvFY1TN/CQOSTPCIwET47Y9gQm3bkudfjMSmdEC9NnnlcflBy
         3Ok5H7nB/taNEeIEtDgsthVVGbFu1ptCy2IAAZWVz2ghMJ3n+VNR/mpxiwL9GVAJr8af
         vBUck34qnR/2T51eXzg+mjJkTw4t1YkGLNbgsKLijqB0kdQWqsple1vFcE6VtEDEThJo
         5Dqzy7gtSL8rlEbhu7dvC18a+QF6uGOPVPDlkyZAGxrypuBUiI119qj7eAWuWlBDoQuY
         kQ6TM0VD2Q2qYwoZHoUtzfiwHCjBp4AV2yZfM8S3CfccSHtPQQgdgeQslsWM/EXt+Jxx
         szxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675184; x=1730279984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUAWPNA4323qWrX/2WYrVLftIYuIj6SGZHxAGWq4jNw=;
        b=r3gx9h5IM9+sfOqjNWowsdgT3LW8ir49xU9xaCDYe0h+F9SY+1HZ2FcMtUVVM2e18d
         YLfuPrv4wcRxEt1m6bGOD8p2Vbveawtuvw00iG8BmPml+xGjymwJm4MNMALY1Ohl6G4I
         ztKIE82rtoXcbWyuuuU5VJ3Gp/qHjKLUE/3r+R8ChA0o0S+yLvlpavCi872XsTXMV5W0
         KPUgzts4Aoe/NeOy3j3Wfl1eQrpyuzoYZrE2EiOMMRmAWXwNRPvms6TpLPyUiP1jrZgw
         snpstGwOIpHOqt9A7GsIZxb+qj22jLB6Un68YwCRNcb31wmRxKiVVoCcyDydkJyAJOuI
         zOaA==
X-Gm-Message-State: AOJu0YzP3F+24FXN4CuwNJBwFUO0ccGx3q2O7WVNWTGizCe8kYlGnvDG
	t2BJzEHQISXjV8ViPUZEx6bMjChENhSo2JugY8pYAY2HjzeRb8Zv6p1MwapqQ6o=
X-Google-Smtp-Source: AGHT+IG/VNM8c02tydtDKFpvCLc9ekaOX1xJn8EkpeM34xOF4e3DBVakwkBUmUTvjMsgb3ifjqeRGQ==
X-Received: by 2002:a05:600c:4f43:b0:431:3bf9:3ebb with SMTP id 5b1f17b1804b1-431841860eemr18352885e9.24.1729675184343;
        Wed, 23 Oct 2024 02:19:44 -0700 (PDT)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94363sm8515796f8f.73.2024.10.23.02.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:19:43 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 23 Oct 2024 11:19:34 +0200
Subject: [PATCH v2 2/4] iio: adc: ad7380: fix oversampling formula
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-ad7380-add-adaq4380-4-support-v2-2-d55faea3bedf@baylibre.com>
References: <20241023-ad7380-add-adaq4380-4-support-v2-0-d55faea3bedf@baylibre.com>
In-Reply-To: <20241023-ad7380-add-adaq4380-4-support-v2-0-d55faea3bedf@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

The formula in the datasheet for oversampling time conversion seems to
be valid when device is at full speed using the maximum number of SDO
lines. The driver currently support only 1 SDO line. The formula will
produce larger delays than what is currently set, but some devices
actually require it.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index fb728570debe6432d5f991595cb35e9e7af8b740..d57e17f38925da5fb7c8a0a2320a21474ba04b37 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -77,6 +77,12 @@
 #define T_CONVERT_X_NS 500		/* xth conversion start time (oversampling) */
 #define T_POWERUP_US 5000		/* Power up */
 
+/*
+ * AD738x support several SDO lines to increase throughput, but driver currently
+ * supports only 1 SDO line (standard SPI transaction)
+ */
+#define AD7380_NUM_SDO_LINES		1
+
 struct ad7380_timing_specs {
 	const unsigned int t_csh_ns;	/* CS minimum high time */
 };
@@ -649,7 +655,8 @@ static int ad7380_set_ch(struct ad7380_state *st, unsigned int ch)
 
 	if (st->oversampling_ratio > 1)
 		xfer.delay.value = T_CONVERT_0_NS +
-			T_CONVERT_X_NS * (st->oversampling_ratio - 1);
+			T_CONVERT_X_NS * (st->oversampling_ratio - 1) *
+			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
 
 	return spi_sync_transfer(st->spi, &xfer, 1);
 }
@@ -667,12 +674,13 @@ static void ad7380_update_xfers(struct ad7380_state *st,
 
 	/*
 	 * In the case of oversampling, conversion time is higher than in normal
-	 * mode. Technically T_CONVERT_X_NS is lower for some chips, but we use
-	 * the maximum value for simplicity for now.
+	 * mode: t_convert = T_CONVERT_0_NS + T_CONVERT_X_NS*(x - 1)*num_channel/number_of_sdo_lines
+	 * where x is the oversampling ratio
 	 */
 	if (st->oversampling_ratio > 1)
 		t_convert = T_CONVERT_0_NS + T_CONVERT_X_NS *
-			(st->oversampling_ratio - 1);
+			(st->oversampling_ratio - 1) *
+			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
 
 	if (st->seq) {
 		xfer[0].delay.value = xfer[1].delay.value = t_convert;
@@ -1021,7 +1029,8 @@ static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 	/* SPI 1-wire mode */
 	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
 				  AD7380_CONFIG2_SDO,
-				  FIELD_PREP(AD7380_CONFIG2_SDO, 1));
+				  FIELD_PREP(AD7380_CONFIG2_SDO,
+					     AD7380_NUM_SDO_LINES));
 }
 
 static int ad7380_probe(struct spi_device *spi)

-- 
2.47.0


