Return-Path: <linux-iio+bounces-9714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 001A697E400
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 00:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C18C1F21507
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 22:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B180383A19;
	Sun, 22 Sep 2024 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHtM3Hsg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4028126BE1;
	Sun, 22 Sep 2024 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727043488; cv=none; b=SswS0Mrh1SAdQx/Tgn66+dvMaiNqq3lqvyS2MksCnJnuZzrYdQRJpJD0m50uDTWHA4cwzng3TVgC/uRMxeGZLv/164a0JD1l2wpRze7bCL/y10OAU2RTuNCQrNKZ4dS/uLtTRToN61UieXwPdibWxkwdL2Y0xr55mtQcYGVxMIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727043488; c=relaxed/simple;
	bh=tDaUVg0BO4msxm0LbS9GostkIi08rcQCmv3UdbaUyQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MnuinOP4yabl3VBnfM4S1C7hBywjriLPmOWZebljC/sYy24kFnAfl2bz5l6cCIsM53YpyvyjOyQsM938G1iEwzo8HnF0CUHLXtaxS4nr8OMikLsmd3qNn3vXOEzk4MiCODaxOkmE1aCOKOuLHI7y3u0dt0T/doM/p0BmoYpcgBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHtM3Hsg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7b28so4795947a12.2;
        Sun, 22 Sep 2024 15:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727043485; x=1727648285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nInp/K4yJhIwI+rcGwOoZteoQ/fjrAElQVflHLtCmd8=;
        b=KHtM3HsgxPbUyzlu9OMrP0X+bgOFZyfdVBk0OBJV0+ByjcXiGzCbRCVTEbj9cIVvof
         Ld8IeT4boQclQMlzIYVcbFZAchm12MR5h/lWF+rCST5c6ebWC+uNRGUyvxBxqohu1hTD
         BkWBzMx9oaRmrLdgClDxCqwvda9wZnpfn4Yo8k4ppGb3BKhpcLBfm2+UPzwa0Le9jkg/
         E3h/X0hUVVkMWPH6zz/ClEG+Jo4rg6lehJx1PtTGRJAMDTDnL2x2wTwdHS7bnt3iIT6g
         gewU75dp3OvSUSY4tI1xKx8WenHVmuiWQxdZq9GaF2Kj4PVawEqhD90fOTD1oAHYJbt/
         C3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727043485; x=1727648285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nInp/K4yJhIwI+rcGwOoZteoQ/fjrAElQVflHLtCmd8=;
        b=rNHD0XhmHJm+gdAUHZqURflxGtzBciANKKXpwGpp6Z001MDRt7+JZ3BX29h+isvgtP
         D0sSXGRTNqn+2PG8Qe4nrYfHXwmsER+IjuwCskOsVfTiGezIkzHpPoMt9ZoeSiiVIOkS
         0br3hsZ84gALCacpRZbMuNTTnHRXt4Dg2yuM1UZos/5DRcxumHQXmlJCOxxL1XE60pds
         fdy3YPqFVCJuHX46hgpxbZJcOQQPOwshILUPNQ1Fcr9ORDX/CvwGU/ijHYNUr1OOR/Fe
         lGgUrTlZ92FlqJmRrqdc7A3A9iEQSLl/SvdBi97q2bTL7Qrx9uV/w4+6I5KfH++ZoSPh
         xwQw==
X-Forwarded-Encrypted: i=1; AJvYcCUvkPEMIXXcWdE08J0C/X0Pyou09RsZHEp/UFJ7xelhpB2rY2ht4DKFTDfuD1LSlFTHSxX7oat/GVUmQg5x@vger.kernel.org, AJvYcCXoOGq4Kv83LkbfYTtlps94MyTdjFV7nkSiwHaAT3TbxR6/YJaR44vsc99jbTwHD6GcFUpM5rGuUWCv@vger.kernel.org
X-Gm-Message-State: AOJu0YxDmnt/A5iCmcjwYk9He7Sje1WdZ2lFoltUz3onppef0UUQQbYB
	1eNfCfix7Elz0v51WxY1vITXfcNdDvquDVgzbH6PLLhaRtYOBtxC
X-Google-Smtp-Source: AGHT+IGbqT7vfDpc9Jps9TmGYTUPyMBGbDAZa68ACBrMqx7tSkeQwU4ABzL3/FV8JL+aju7RvLKvAg==
X-Received: by 2002:a17:906:d264:b0:a86:c1ff:c973 with SMTP id a640c23a62f3a-a90d5804819mr946297966b.47.1727043484818;
        Sun, 22 Sep 2024 15:18:04 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90611164d0sm1126202066b.91.2024.09.22.15.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 15:18:04 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 23 Sep 2024 00:17:54 +0200
Subject: [PATCH v2 06/10] iio: light: veml6030: use read_avail() for
 available attributes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-veml6035-v2-6-58c72a0df31c@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
In-Reply-To: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727043474; l=4406;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=tDaUVg0BO4msxm0LbS9GostkIi08rcQCmv3UdbaUyQE=;
 b=7hrucQ3w6dzqJl8YFzbbuZ0xgKwWm591zSTnKF+ORmSxIUP44ngIflpdXBCPsbUntJp9xTqKa
 /BKvPoqRgKVB6xkWog6OzxvD3D4vAL17vft5yEejQCfoc5xzijTipa3
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Drop custom attributes by using the standard read_avail() callback to
read scale and integration time. When at it, define these attributes as
available by all channels, as they affect the values of both the ALS and
the WHITE channel.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 64 +++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 89c98bfc5191..a3190fab3add 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -58,25 +58,24 @@ struct veml6030_data {
 	int cur_integration_time;
 };
 
-/* Integration time available in seconds */
-static IIO_CONST_ATTR(in_illuminance_integration_time_available,
-				"0.025 0.05 0.1 0.2 0.4 0.8");
+static const int veml6030_it_times[][2] = {
+	{0, 25000},
+	{0, 50000},
+	{0, 100000},
+	{0, 200000},
+	{0, 400000},
+	{0, 800000},
+};
 
 /*
  * Scale is 1/gain. Value 0.125 is ALS gain x (1/8), 0.25 is
  * ALS gain x (1/4), 1.0 = ALS gain x 1 and 2.0 is ALS gain x 2.
  */
-static IIO_CONST_ATTR(in_illuminance_scale_available,
-				"0.125 0.25 1.0 2.0");
-
-static struct attribute *veml6030_attributes[] = {
-	&iio_const_attr_in_illuminance_integration_time_available.dev_attr.attr,
-	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group veml6030_attr_group = {
-	.attrs = veml6030_attributes,
+static const int veml6030_scale_vals[][2] = {
+	{0, 125000},
+	{0, 250000},
+	{1, 0},
+	{2, 0},
 };
 
 /*
@@ -197,9 +196,11 @@ static const struct iio_chan_spec veml6030_channels[] = {
 		.type = IIO_LIGHT,
 		.channel = CH_ALS,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				BIT(IIO_CHAN_INFO_PROCESSED) |
-				BIT(IIO_CHAN_INFO_INT_TIME) |
-				BIT(IIO_CHAN_INFO_SCALE),
+				BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					       BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SCALE),
 		.event_spec = veml6030_event_spec,
 		.num_event_specs = ARRAY_SIZE(veml6030_event_spec),
 	},
@@ -210,6 +211,10 @@ static const struct iio_chan_spec veml6030_channels[] = {
 		.channel2 = IIO_MOD_LIGHT_BOTH,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					       BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SCALE),
 	},
 };
 
@@ -567,6 +572,27 @@ static int veml6030_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int veml6030_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*vals = (int *)&veml6030_it_times;
+		*length = 2 * ARRAY_SIZE(veml6030_it_times);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)&veml6030_scale_vals;
+		*length = 2 * ARRAY_SIZE(veml6030_scale_vals);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int veml6030_write_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int val, int val2, long mask)
@@ -684,19 +710,19 @@ static int veml6030_write_interrupt_config(struct iio_dev *indio_dev,
 
 static const struct iio_info veml6030_info = {
 	.read_raw  = veml6030_read_raw,
+	.read_avail  = veml6030_read_avail,
 	.write_raw = veml6030_write_raw,
 	.read_event_value = veml6030_read_event_val,
 	.write_event_value	= veml6030_write_event_val,
 	.read_event_config = veml6030_read_interrupt_config,
 	.write_event_config	= veml6030_write_interrupt_config,
-	.attrs = &veml6030_attr_group,
 	.event_attrs = &veml6030_event_attr_group,
 };
 
 static const struct iio_info veml6030_info_no_irq = {
 	.read_raw  = veml6030_read_raw,
+	.read_avail  = veml6030_read_avail,
 	.write_raw = veml6030_write_raw,
-	.attrs = &veml6030_attr_group,
 };
 
 static irqreturn_t veml6030_event_handler(int irq, void *private)

-- 
2.43.0


