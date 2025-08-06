Return-Path: <linux-iio+bounces-22331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8215B1C2B0
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 11:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAE03BF856
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7204928A1F9;
	Wed,  6 Aug 2025 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpg3U43y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6652E289353;
	Wed,  6 Aug 2025 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470940; cv=none; b=nmNUbyTDUyr/xRErhux43adMLqEFrLfN0G3XSmsneb+l7SZoxS+PjllGUXaa3ZJvbinazMOHbYMkoKsAKSWyhDDTBd2ahprTLXS7xRV+cnkBDplWmKOGMx1Q6hhZwlg7tfBcpmmIms4miSllhKwOlAEPfo/42JBbso09ej6fgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470940; c=relaxed/simple;
	bh=/DNGcxiKAw1fg4gRHTXFKMpOrFxh5Sa5I3XHzr+cErY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2gTMTXa3hYg56z5X81WHCdrLa1ViXUBw0U1MOgYcoNyieBJ/bwv7mGhy58pOmiL1hmCKgtSMCzM7X2FJzOsB6qPjeYuIl4F9OB6+v9WcBAwns5SaerhlXx2NKpoaWxl9Sf5/QvdLlS4vmP/cpRoQ7xauhDjsAaZB02X4UJ76i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpg3U43y; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b7892609a5so4302319f8f.1;
        Wed, 06 Aug 2025 02:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754470936; x=1755075736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUahVJaql/MOXtsi2s6MfehjhweRWnN71gaAELjTqU0=;
        b=hpg3U43yjDe0RoMX5IdRdE7SXH9/KBwwvpXCQGSPh5XlYcju4Rn0x3s540ANcJcPP8
         NtnjmUvWe9m85Pn6RE2zwgrePYcR6TjzDN+qcEqKBtobsJnU9iwROUtxbswPjWDR7K7c
         0eTT3q4n/e9CD7l/zfphzrG5UVWahwKsQ6VWjfKZotwUc0ekuw5rUidXJ9jgSXrk0HyP
         x70q6Y4cdMMLBg+nSA4Adncpmu2xDqctk56G/7fIj6nFc5Uqk5dkE+s9xMkTsZ3z8Fs9
         UOGKM56MMSRUd8i4DAarDZeRyzlCsWXHbBUjl/hs54PUH4dgaQldbJr9Mpgtm0dr/uwf
         6+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754470936; x=1755075736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUahVJaql/MOXtsi2s6MfehjhweRWnN71gaAELjTqU0=;
        b=g+wjTeWBH/eoMbqqttDA2fd/3Wn/f7qpRZ8BERmRl+OcmgWg7ufVHoxjXgNDvI0shp
         llDTfDqCXq6XYvNdrx/PHpnhiSZMiux/zf7KLn5pdezL20mk/zD82WXAHf07smez2WmO
         6Ks8Gsu8cgr5F29Rd5PFgclFgXHWHEpU8p22Av1/yk0TC/C0SYRo1+HuWe8crXDMHzti
         XDSn3EA6jczIetjXnBs8HYKfD+6us2+2PX7UtiUR/rzGBqNwwYjoW3XavfcEhG9rZiZe
         N6VFKEqH5evugJsSLPuyozvLl/jpOkGAsqS10WAQof46xLw54MWD/0sJKak+4fVMup5x
         NSzg==
X-Forwarded-Encrypted: i=1; AJvYcCXlWnkejiBuu+dJ9jHlu8NDGSCL01/m+5A/cl6i2d+rSPQ/00+fHyWVG0/A9gcBi1Jr7ARBU6XDplhDTdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1VJjVb4L9cXMb4QXHzEUMxPxwxneZBh7YTrLIPIX8eLCfaTPq
	FfmK2EjN1WKbBdBiNpCDtpTyBDN6MhlJC4R81SPsJ/c5Zr2FdO+lK3kX
X-Gm-Gg: ASbGncuEGInS3D8yysWSvNAZPb0HQGClEnMlb6ckC6cykBB9Rtqj0UsbzgzzX0WdosO
	9FSfKmpOifVbZxGuUbWHY8Jj3jIu2WRjXTcLwg/M+FaCUHgV20F+x1mM6351VmL1DWuOfa+PN+4
	MVogO1PkGyakbMN4eQ7QgD0lXkortfMqXn8EvJwmqjIaLcuyhec2cWlk31p9dF9FtJSQNWQxS/L
	VO/rUm2ubmiFlOyv78LWRVeBn6DZLDDnCgSxkL89cQBdiYMAHG3KCu9kZTR6yE6ojJ/dknZbU46
	Vy7NpFzTohPZJGXdbC2YOXCTXACDdldFvAM3XcBLR9E9xq36x25iE9cjTl0EF7A510h+x/BVD60
	FJBDbWuxmMejwFuh0r5+ncWwaFQgHMe4yOlFvh+xshEXFPiTAM+s4YX3l
X-Google-Smtp-Source: AGHT+IGrlP7T/vI9qgpnSvquO2zghAFJlBcEyRlLBqQSoenzlCtOEyU089UmZ1xRQCehoJI12eBZnA==
X-Received: by 2002:a05:6000:4029:b0:3b7:8fcc:a1e3 with SMTP id ffacd0b85a97d-3b8f421057fmr1645004f8f.48.1754470936418;
        Wed, 06 Aug 2025 02:02:16 -0700 (PDT)
Received: from fedora.. (93-38-186-193.ip71.fastwebnet.it. [93.38.186.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm22309399f8f.39.2025.08.06.02.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:02:15 -0700 (PDT)
From: Stefano Manni <stefano.manni@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefano Manni <stefano.manni@gmail.com>
Subject: [PATCH 1/2] iio: adc: ad799x: add reference voltage capability to chip_info
Date: Wed,  6 Aug 2025 11:01:57 +0200
Message-ID: <20250806090158.117628-2-stefano.manni@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250806090158.117628-1-stefano.manni@gmail.com>
References: <20250806090158.117628-1-stefano.manni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the chip supports an external reference voltage
on REFIN pin then the "vref-supply" regulator may be used.

This commit partially refactors 6b104e7895ab16b9b7f466c5f2ca282b87f661e8
to add the capability of the chip to have an external
voltage reference and then remove the ugly conditional check
on chip id.

Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
---
 drivers/iio/adc/ad799x.c | 45 +++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 9c02f9199139..955d845407b9 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -114,11 +114,13 @@ struct ad799x_chip_config {
  * @num_channels:	number of channels
  * @noirq_config:	device configuration w/o IRQ
  * @irq_config:		device configuration w/IRQ
+ * @has_vref:		device supports external reference voltage
  */
 struct ad799x_chip_info {
 	int				num_channels;
 	const struct ad799x_chip_config	noirq_config;
 	const struct ad799x_chip_config	irq_config;
+	bool has_vref;
 };
 
 struct ad799x_state {
@@ -604,6 +606,7 @@ static const struct iio_event_spec ad799x_events[] = {
 static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	[ad7991] = {
 		.num_channels = 5,
+		.has_vref = true,
 		.noirq_config = {
 			.channel = {
 				AD799X_CHANNEL(0, 12),
@@ -617,6 +620,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7995] = {
 		.num_channels = 5,
+		.has_vref = true,
 		.noirq_config = {
 			.channel = {
 				AD799X_CHANNEL(0, 10),
@@ -630,6 +634,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7999] = {
 		.num_channels = 5,
+		.has_vref = true,
 		.noirq_config = {
 			.channel = {
 				AD799X_CHANNEL(0, 8),
@@ -643,6 +648,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7992] = {
 		.num_channels = 3,
+		.has_vref = false,
 		.noirq_config = {
 			.channel = {
 				AD799X_CHANNEL(0, 12),
@@ -663,6 +669,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7993] = {
 		.num_channels = 5,
+		.has_vref = false,
 		.noirq_config = {
 			.channel = {
 				AD799X_CHANNEL(0, 10),
@@ -687,6 +694,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7994] = {
 		.num_channels = 5,
+		.has_vref = false,
 		.noirq_config = {
 			.channel = {
 				AD799X_CHANNEL(0, 12),
@@ -711,6 +719,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7997] = {
 		.num_channels = 9,
+		.has_vref = false,
 		.noirq_config = {
 			.channel = {
 				AD799X_CHANNEL(0, 10),
@@ -743,6 +752,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7998] = {
 		.num_channels = 9,
+		.has_vref = false,
 		.noirq_config = {
 			.channel = {
 				AD799X_CHANNEL(0, 12),
@@ -809,34 +819,31 @@ static int ad799x_probe(struct i2c_client *client)
 		return ret;
 
 	/* check if an external reference is supplied */
-	st->vref = devm_regulator_get_optional(&client->dev, "vref");
-
-	if (IS_ERR(st->vref)) {
-		if (PTR_ERR(st->vref) == -ENODEV) {
-			st->vref = NULL;
-			dev_info(&client->dev, "Using VCC reference voltage\n");
-		} else {
-			ret = PTR_ERR(st->vref);
-			goto error_disable_reg;
+	if (chip_info->has_vref) {
+		st->vref = devm_regulator_get_optional(&client->dev, "vref");
+
+		if (IS_ERR(st->vref)) {
+			if (PTR_ERR(st->vref) == -ENODEV) {
+				st->vref = NULL;
+				dev_info(&client->dev, "Using VCC reference voltage\n");
+			} else {
+				ret = PTR_ERR(st->vref);
+				goto error_disable_reg;
+			}
 		}
-	}
 
-	if (st->vref) {
-		/*
-		 * Use external reference voltage if supported by hardware.
-		 * This is optional if voltage / regulator present, use VCC otherwise.
-		 */
-		if ((st->id == ad7991) || (st->id == ad7995) || (st->id == ad7999)) {
+		if (st->vref) {
 			dev_info(&client->dev, "Using external reference voltage\n");
 			extra_config |= AD7991_REF_SEL;
 			ret = regulator_enable(st->vref);
 			if (ret)
 				goto error_disable_reg;
-		} else {
-			st->vref = NULL;
-			dev_warn(&client->dev, "Supplied reference not supported\n");
 		}
 	}
+	else {
+		st->vref = NULL;
+		dev_dbg(&client->dev, "Supplied reference not supported\n");
+	}
 
 	st->client = client;
 
-- 
2.48.1


