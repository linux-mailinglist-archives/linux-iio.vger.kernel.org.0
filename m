Return-Path: <linux-iio+bounces-12461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C599D4AAE
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 11:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0675528242C
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 10:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F2D1D6DDD;
	Thu, 21 Nov 2024 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Fmoj9FCx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF2C1D363D
	for <linux-iio@vger.kernel.org>; Thu, 21 Nov 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184317; cv=none; b=PwRZ/A0yuAAgcYLu2RsJcOpLllxQfue7mV3EJG6q8XU72rvGtMTZvmEr65gZH1XaIYDFagvgJ5S5vpjDhYvXoPFJSNZrnKqazvgLK8+/NFCP76iTXHwcd8n95PcZCjbg8jXZFNiE6itCciM8fLNnTtEAiqbXqsY/5hRakjmJp8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184317; c=relaxed/simple;
	bh=Rm7fdKwuILN1wABcMwtBOX8LaUe3ccIFEyDzCkBVoDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SHiFfBTuLYOc0sHgCXp+Mbh0iTWt/tLHAvcFfa10HJ6D8SOINqNeBPWyd6dp2vWAwge/aOj0MFylpD5sRx0bsoRqnBeBRfIlDtJ1W24g9wfhNFXw/7CoPkdbAcH7GoH3DjYsNY6DuDeHfXnYXHjCEBOIA3RFJmTN8APakx4pdM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Fmoj9FCx; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3823f1ed492so1005135f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 21 Nov 2024 02:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732184313; x=1732789113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHaSxL3+Y30jYFHs/JHdzuANlkeArnNpuo2+kK7YYpY=;
        b=Fmoj9FCxo9XRZKTpii/pRYEd71/sPatc9Euyh13M1fesvmOlzIh1DQEM8w/BEUckJq
         yAhv/HePjRcKKHaOyJi2YwNw/a2up90wh1WNPieAOKsf4s2xGtmrHyJgXDCgmrZHW7hW
         Ds6PvzZEVyRq9SfE0wFvngby8Sl9UIsrrgIdrnReRQiiKDj0oPiiy+ucYTTu7NxsPt1F
         blDiJFGGHDFNR3LbcC29uCk+S2CfuiTFebbbtPHnPML0dEGav6+EPM8a1yAqDoUmhhrO
         ENCjpRoATkUPkEg4BKwThBiSkqxOpygU2B6aXpqT+nrfKTcn7RJVs1wQyush7MaDBp7d
         WPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184313; x=1732789113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHaSxL3+Y30jYFHs/JHdzuANlkeArnNpuo2+kK7YYpY=;
        b=vUw1nf4+6RgayUt44UB00Nm5x7ju09/0J0+bXbcFpesJmw0x41uxb/2EbPU4Fqewlb
         tXj69tlxvnhxJOGjQ71JnXRHaCyFBacdNUkpjIFG7j8s3lvV9P1p3XeCWR1du+z/scqv
         fmM73HUqQEJS4e/o3Y8/rQ4XeMs1KWpFlMdgHa+5Lwyu9w6bvs1g2OfO2DpEKWdSGQYd
         ol76MKo2KXHwRkyOhRk52uBVFost5LNDPaqqW93Lvs482ISMR39Qs7/bklGNXlrPnyeT
         mmkeiAidG+M9wFmTN8DKLpAK8bJRx8WY9ojIhEQPoXmvtj7pYBDVKzU5Qs5ar6vfY9ae
         Xqaw==
X-Forwarded-Encrypted: i=1; AJvYcCUuobPpdEcvkLJw769xlVwV3FUqRtYIltKIE5ZNLG/95mazkLGgwtcYsVg3HsUYn7uFfPA3/nKRCO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDXCUiyYeJfr3HgSGj7BRCWtd9eboU0C4//S/neWLi75e/ndZV
	QxuOjmcCeUxtN1E6bPvKHuis9/d7yG9qId6Fx5gqxLueig+nToI0O5m9VVoZp04=
X-Google-Smtp-Source: AGHT+IHG6NXlIBhSHjBBI33tsOYshaSt/FYtyInlElG+QJyXqLXRCysPCVrrRaxPhu/BywhhESHpQQ==
X-Received: by 2002:a5d:64ce:0:b0:37d:34e7:6d24 with SMTP id ffacd0b85a97d-38259d2b848mr2047885f8f.18.1732184312352;
        Thu, 21 Nov 2024 02:18:32 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254910796sm4598065f8f.47.2024.11.21.02.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 02:18:31 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Date: Thu, 21 Nov 2024 10:18:30 +0000
Subject: [PATCH 8/9] iio: adc: ad7606: Simplify channel macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-ad7606_add_iio_backend_software_mode-v1-8-8a693a5e3fa9@baylibre.com>
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
In-Reply-To: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 aardelean@baylibre.com, adureghello@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732184304; l=3067;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=Rm7fdKwuILN1wABcMwtBOX8LaUe3ccIFEyDzCkBVoDQ=;
 b=PeM+F7Unq5hw0qEHvjQSXhzdr0HCrmaP/6KBbQl3LVfPREko98epnF7/FmSX40NPefdf3wTE+
 XW38P2aduRIASA6qwyuPT6eMhTvxk8EiUcwME6QBmz28QFQzYAZTZ9e
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

This is a preparation to add the new channels for software mode and
hardware mode in iio backend mod more easily.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.h | 51 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index eca7ea99e24d..74896d9f1929 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -40,37 +40,19 @@
 #define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
 #define AD7606_OS_MODE			0x08
 
-#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {	\
+#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all,	\
+		mask_sep_avail, mask_all_avail, bits) {		\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
 		.channel = num,					\
 		.address = num,					\
 		.info_mask_separate = mask_sep,			\
+		.info_mask_separate_available =			\
+			mask_sep_avail,				\
 		.info_mask_shared_by_type = mask_type,		\
 		.info_mask_shared_by_all = mask_all,		\
-		.scan_index = num,				\
-		.scan_type = {					\
-			.sign = 's',				\
-			.realbits = (bits),			\
-			.storagebits = (bits) > 16 ? 32 : 16,	\
-			.endianness = IIO_CPU,			\
-		},						\
-}
-
-#define AD7606_SW_CHANNEL(num, bits) {				\
-		.type = IIO_VOLTAGE,				\
-		.indexed = 1,					\
-		.channel = num,					\
-		.address = num,					\
-		.info_mask_separate =				\
-			BIT(IIO_CHAN_INFO_RAW) |		\
-			BIT(IIO_CHAN_INFO_SCALE),		\
-		.info_mask_separate_available =			\
-			BIT(IIO_CHAN_INFO_SCALE),		\
-		.info_mask_shared_by_all =			\
-			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.info_mask_shared_by_all_available =		\
-			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+			mask_all_avail,				\
 		.scan_index = num,				\
 		.scan_type = {					\
 			.sign = 's',				\
@@ -82,12 +64,28 @@
 
 #define AD7605_CHANNEL(num)				\
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
-		BIT(IIO_CHAN_INFO_SCALE), 0, 16)
+		BIT(IIO_CHAN_INFO_SCALE), 0, 0, 0, 16)
 
 #define AD7606_CHANNEL(num, bits)			\
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
 		BIT(IIO_CHAN_INFO_SCALE),		\
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		0, 0, bits)
+
+#define AD7606_SW_CHANNEL(num, bits)			\
+	AD760X_CHANNEL(num,				\
+		/* mask separate */			\
+		BIT(IIO_CHAN_INFO_RAW) |		\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+		/* mask type */				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		/* mask all */				\
+		0,					\
+		/* mask separate available */		\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+		/* mask all available */		\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		bits)
 
 #define AD7616_CHANNEL(num)	AD7606_SW_CHANNEL(num, 16)
 
@@ -95,7 +93,8 @@
 	AD760X_CHANNEL(num, 0,				\
 		BIT(IIO_CHAN_INFO_SCALE),		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), 16)
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),  \
+		0, 0, 16)
 
 struct ad7606_state;
 

-- 
2.34.1


