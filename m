Return-Path: <linux-iio+bounces-13889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D60A014EA
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 14:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F3F162901
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 13:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C3C17BB3F;
	Sat,  4 Jan 2025 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEve08OB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65632F5E;
	Sat,  4 Jan 2025 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735996090; cv=none; b=dwwl/cRqdAQ81itXxw+cLg1NQGgY7EL/QdY78mA1KzrJUWX1nsLZHAmQu0B9QEh7LThoaiAlEdnCYG0JEwaaai2j27XmMw2moGy28zca0NHYjJoTqDrIz51dzQITumYvJFWFgPzE3bcymYtfxjm2FujtV3Xlp1K7Bhl+A5wXGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735996090; c=relaxed/simple;
	bh=Oy3/v2XHqv7gWxUNq13lXL/Zr5aQsHEE4yE+I8eP44Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpkAkfJ4OmCUjy0AHXBDyoZ9RA65nJcl6d5VTeNBW3d7WVhs+RbhUIfsqRZUyRW/QXLT1IGRUfEq8CjFNGq/oVzGkmH9JS9jjzvN7Ie1EpRg/YGJtS7rDaODNfCM4i8n3mUNGbvaXd3WBbijQdRTzSX079lrMDxgYTW7t5BoydQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEve08OB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73FAC4CED1;
	Sat,  4 Jan 2025 13:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735996090;
	bh=Oy3/v2XHqv7gWxUNq13lXL/Zr5aQsHEE4yE+I8eP44Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GEve08OB1umh3VGiOIQISFUxXlsxcdQl7zGfHnW2oFbqssBERlZeENw96jXq8fRQq
	 JkZRdDGgU0/lwBVUnUJaB8uV9YnSRxOA6H5RZfelB6TptFUd64ZNLuD5u32V23Ys3v
	 uo5+jWClF07X8U7Ml+QndoW3POy9e9GSbQIZlFZDLY5TCYTqvJuuBF9U/YxMoWw1rE
	 bTyMCqTGa6g2WuDSeg32vZJM1l2BCNWiGyLRr75memIltBcw4S5bSeV9DK3IPEVC6G
	 zvvem52MOKyRKfSre1Zz2iUcIUim7ZDOrNwBZxh0bXjEA5EuVQ3yWswbg9SB3dc7em
	 5311jlTF43eRw==
Date: Sat, 4 Jan 2025 13:08:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v9 3/4] iio: accel: adxl345: add FIFO with watermark
 events
Message-ID: <20250104130802.17026d85@jic23-huawei>
In-Reply-To: <20241228232949.72487-4-l.rubusch@gmail.com>
References: <20241228232949.72487-1-l.rubusch@gmail.com>
	<20241228232949.72487-4-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Dec 2024 23:29:48 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add a basic setup for FIFO with configurable watermark. Add a handler
> for watermark interrupt events and extend the channel for the
> scan_index needed for the iio channel. The sensor is configurable to use
> a FIFO_BYPASSED mode or a FIFO_STREAM mode. For the FIFO_STREAM mode now
> a watermark can be configured, or disabled by setting 0. Further features
> require a working FIFO setup.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar,

Applied with a tweak. See below and please check my testing branch
to see if I messed this mechanical change up (wouldn't be the first time!)

Thanks,

Jonathan

>  
> +#define ADXL345_FIFO_CTL_SAMPLES(x)	FIELD_PREP(GENMASK(4, 0), x)
> +/* 0: INT1, 1: INT2 */
> +#define ADXL345_FIFO_CTL_TRIGGER(x)	FIELD_PREP(BIT(5), x)
> +#define ADXL345_FIFO_CTL_MODE(x)	FIELD_PREP(GENMASK(7, 6), x)

Ah.  I now realize I subtly misread your reply to v8.

What I want to see the masks defined with the rest of the fields and
the FIELD_PREP used with those masks inline.

Rather than go around again, I've applied the following tweak.
diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index b78b4973a4d4..9fcf6756768e 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -25,6 +25,10 @@
 	(ADXL345_REG_XYZ_BASE + (index) * sizeof(__le16))
 
 #define ADXL345_REG_FIFO_CTL		0x38
+#define ADXL345_FIFO_CTL_SAMPLES_MSK	GENMASK(4, 0)
+/* 0: INT1, 1: INT2 */
+#define ADXL345_FIFO_CTL_TRIGGER_MSK	BIT(5)
+#define ADXL345_FIFO_CTL_MODE_MSK	GENMASK(7, 6)
 #define ADXL345_REG_FIFO_STATUS	0x39
 #define ADXL345_REG_FIFO_STATUS_MSK	0x3F
 
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index d33e3c6528a9..d1b2d3985a40 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -31,11 +31,6 @@
 #define ADXL345_INT1			0
 #define ADXL345_INT2			1
 
-#define ADXL345_FIFO_CTL_SAMPLES(x)	FIELD_PREP(GENMASK(4, 0), x)
-/* 0: INT1, 1: INT2 */
-#define ADXL345_FIFO_CTL_TRIGGER(x)	FIELD_PREP(BIT(5), x)
-#define ADXL345_FIFO_CTL_MODE(x)	FIELD_PREP(GENMASK(7, 6), x)
-
 struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
@@ -269,9 +264,12 @@ static int adxl345_set_fifo(struct adxl345_state *st)
 		return ret;
 
 	ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL,
-			   ADXL345_FIFO_CTL_SAMPLES(st->watermark) |
-			   ADXL345_FIFO_CTL_TRIGGER(st->intio) |
-			   ADXL345_FIFO_CTL_MODE(st->fifo_mode));
+			   FIELD_PREP(ADXL345_FIFO_CTL_SAMPLES_MSK,
+				      st->watermark) |
+			   FIELD_PREP(ADXL345_FIFO_CTL_TRIGGER_MSK,
+				      st->intio) |
+			   FIELD_PREP(ADXL345_FIFO_CTL_MODE_MSK,
+				      st->fifo_mode));
 	if (ret < 0)
 		return ret;
 
@@ -500,7 +498,6 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					 ADXL345_DATA_FORMAT_JUSTIFY |
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
-	u8 fifo_ctl;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -583,9 +580,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		if (ret)
 			return ret;
 	} else {
-		/* FIFO_BYPASS mode */
-		fifo_ctl = ADXL345_FIFO_CTL_MODE(ADXL345_FIFO_BYPASS);
-		ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL, fifo_ctl);
+		ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL,
+				   FIELD_PREP(ADXL345_FIFO_CTL_MODE_MSK,
+					      ADXL345_FIFO_BYPASS));
 		if (ret < 0)
 			return ret;
 	}





