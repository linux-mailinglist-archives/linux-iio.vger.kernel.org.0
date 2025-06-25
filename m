Return-Path: <linux-iio+bounces-20961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35995AE8B25
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 19:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE663BC2A7
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 17:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990DC2BF009;
	Wed, 25 Jun 2025 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMxfQk+F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BAD1C3F36;
	Wed, 25 Jun 2025 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870955; cv=none; b=PUm3KP9oo8gWbr6JOT7ekFJp+pvJGZYowgaEZ1QhG9ai76I0vuYV5L1HqIW7OCiCMyBWXhigY1OzpMqvZdtMmHyuJ4U62tbeRi0U/ns/+0PK7yjT5C18P7Nr5rmLmUzxb7aP61wiLl7kNTsO8iXZqU7BiYYyTgwS4aMARNP3BrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870955; c=relaxed/simple;
	bh=O6TxtYJ9isG6nFpvkCTjBLH///ykYGCELf+WqBH4wBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=owI/Ttu71gX61Fmr5TjzDNSwCdM0E5KW+zHsYqV6+Frzmdzv1VLWjR/u/GYqOdJIYOHt05mdec5cgdykdu2wYo5V1l77TjezTEsZXp3yOfWyilBLTzQC8p4+AhN7aEtFy34v4KyQ2l0tg4YEcCoDkt2st1rfvqg7/ASegPKusKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMxfQk+F; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ade6ef7e72fso3319566b.0;
        Wed, 25 Jun 2025 10:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750870952; x=1751475752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHBwr3SqXoIiURxPvaZ4cubCxyGiDoMqqqMe508pP3Q=;
        b=mMxfQk+Fw4upa37CkzsniZT/UrdxnhPOnUNn4O3js/WE66p60CetJWbzgKhruvINKI
         MxEA1R+86FBrHlgEE7zELKX5LEsIp68Mh93sRsUd5vjYFOn/rtAMfv1HBDc5K0pxGeGp
         A8GkHpsvApm/POQSBVCWaLQMyF/+61Ef5W9e2+nbJcOFKnenIRhEgcEW7tYR23+kT9xK
         GEqL3tvDVZf6APosoo6f1OFTSbMZTtABBEgfKAYfB/vHy9jFUcnrCNwGEqhPdDVb/YOr
         u6XehMlnrTwSr8a4uTU3XBNwQL95T3zr7x/x6nKtq4H+oU8rkYU0zoPKFNY2hViim1gD
         V/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750870952; x=1751475752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHBwr3SqXoIiURxPvaZ4cubCxyGiDoMqqqMe508pP3Q=;
        b=GXdOnm/IfTnje9LOKgnb+cjFhiJ8L965KoRmMo8ANI38RUwenPJTJjXsE3nvE73+yY
         B2fp2dzQYgKodOOQ7qsoOLZApqGBYyfsHjJ8YqfvcQ4Re2KT2C5HvSeLAQJGxb7+fjaJ
         YE/UN8LEeMSSi5kqjaJiwEE2p9UTQ6ZsoX3A6mdBd0V3YY1rWYHKGVLNQVvmjHghZUtO
         kUJ5K/sziPLqsDp4y6yz9cI5ORA2MFVk3UCD2UXjPtmlRi3VWrwjn0WvfQ/3yHlZSwuq
         J9Fx0vR3NvvmIqEmnmx89pFKFiJpnQpiluy5j2rnYqxsRlThfgT6jWeCpXpVgegEhz23
         sojw==
X-Forwarded-Encrypted: i=1; AJvYcCWp5f3/xOa63Bqf6Xt5QCfwcXBa6SdBNfWTZWI9T017FHwLiaI6AAMAuBQVh3yL7eJ0fig7CePiUVZ7h+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05dw/jvwVk0usGOcXJFbM0PrwuKUyqWen6veEmP8MOUI5jrA4
	FyMsw1VSvkphyU5NlFUiydvSC+BdPp5q5PMqRO4nraF0UHhHQQQJSD8S
X-Gm-Gg: ASbGncunEBtilpDaVivXLvV99z98qiAaZO6wiUU4UVVMH68CDY3Kvd7+1p9sXPxS0CM
	Oe01Z+wMiVo1+OmSZFOhikIb+2iCg6m8y2LetJO1f3q6F06f+Eo4+UGCB/io/qqZceMZbqsVukg
	JxwlS43GGjILV8pE04UByCfCCVzMIp3W8V92CWhW4J3uyXnkWuC7ZTmGLxB3DH+5cTKMZ2D1CF+
	Ytif4kx9Fzx3zcZeMDzh/pj25904S/IjtvIjoSY7omvOJO5UN9pI5Ax9oVY2ssozGL+Mi+uMkVr
	Rul+UKRuftQq+NfIoSJBz2/N3jeHETnIdIyoFvwgk5+HIISYP4mObp5PfDIAt7PRdS8rhlY1y10
	ohn90pKIC/6CCBfot0EG5QSoJB31f6nGL
X-Google-Smtp-Source: AGHT+IEg40mq+i/QHdnVo9juPcnmLB8UjNFB5/KkYoqgmgZZuEvWGdJaqdqPgd5uOVWq0wvvJauvRQ==
X-Received: by 2002:a17:907:1b1f:b0:adb:2f16:7ba1 with SMTP id a640c23a62f3a-ae0bec3af40mr137767966b.6.1750870950910;
        Wed, 25 Jun 2025 10:02:30 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0cb358618sm69249766b.102.2025.06.25.10.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 10:02:30 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: mazziesaccount@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	l.rubusch@gmail.com
Subject: [PATCH v1 1/2] iio: adc: ti-adc128s052: add support for adc121s021
Date: Wed, 25 Jun 2025 17:02:17 +0000
Message-Id: <20250625170218.545654-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250625170218.545654-1-l.rubusch@gmail.com>
References: <20250625170218.545654-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the single channel variant(s) of this ADC.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/adc/ti-adc128s052.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 1b46a8155803..cf271c39e663 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -7,6 +7,7 @@
  * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
  * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
  * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
+ * https://www.ti.com/lit/ds/symlink/adc121s021.pdf
  */
 
 #include <linux/cleanup.h>
@@ -110,6 +111,10 @@ static const struct iio_chan_spec adc128s052_channels[] = {
 	ADC128_VOLTAGE_CHANNEL(7),
 };
 
+static const struct iio_chan_spec adc121s021_channels[] = {
+	ADC128_VOLTAGE_CHANNEL(0),
+};
+
 static const struct iio_chan_spec adc122s021_channels[] = {
 	ADC128_VOLTAGE_CHANNEL(0),
 	ADC128_VOLTAGE_CHANNEL(1),
@@ -143,6 +148,10 @@ static const struct adc128_configuration adc128_config[] = {
 		.refname = "vdd",
 		.other_regulators = &bd79104_regulators,
 		.num_other_regulators = 1,
+	}, {
+		.channels = adc121s021_channels,
+		.num_channels = ARRAY_SIZE(adc121s021_channels),
+		.refname = "vref",
 	},
 };
 
@@ -207,7 +216,10 @@ static const struct of_device_id adc128_of_match[] = {
 	{ .compatible = "ti,adc124s051", .data = &adc128_config[2] },
 	{ .compatible = "ti,adc124s101", .data = &adc128_config[2] },
 	{ .compatible = "rohm,bd79104", .data = &adc128_config[3] },
-	{ }
+	{ .compatible = "ti,adc121s021", .data = &adc128_config[4] },
+	{ .compatible = "ti,adc121s051", .data = &adc128_config[4] },
+	{ .compatible = "ti,adc121s101", .data = &adc128_config[4] },
+	{ },
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
 
@@ -220,6 +232,9 @@ static const struct spi_device_id adc128_id[] = {
 	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
 	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
 	{ "bd79104", (kernel_ulong_t)&adc128_config[3] },
+	{ "adc121s021", (kernel_ulong_t)&adc128_config[4] },
+	{ "adc121s051", (kernel_ulong_t)&adc128_config[4] },
+	{ "adc121s101", (kernel_ulong_t)&adc128_config[4] },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
-- 
2.39.5


