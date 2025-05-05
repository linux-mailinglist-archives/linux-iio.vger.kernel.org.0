Return-Path: <linux-iio+bounces-19152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B154AAA9C62
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 21:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C4B17E300
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8552701BD;
	Mon,  5 May 2025 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="HnYCQsZ5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F992701A0;
	Mon,  5 May 2025 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472824; cv=none; b=hiOce+L5RkQVA9An5B50uNsyWGX2Z+8OcBq/upjitWlvgdHzFcrfkaytPXmeDZ2d7YmEpF8VvOMVO8hRaZRURW94X2PrbT6um6gEbZwsEBvBOwFowZS3HAmtd/4mPxY3NHKIUGSJ3jXzokRApFNUpPlhCOCNk4qca+HVQ1rkcvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472824; c=relaxed/simple;
	bh=+d8tniBcw4iQZBqdUy3M4jejJxgWy7tKaRDD9lEZtHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=foM62WdljiPaNonruVBJTWqy5/zb3thAsJeXxdRMyarbduW2XGEVV0pkcSIrr6IR5/OTcSYW+4GYbZ6Yea5jrC+zNfNgN4Av8IJ9TntvVb966+7jSiHzZ3HnVJCpZNPYBR9AIdgEf5p4S3i3DjV3+92IN8tRFunQEe6RqR7VHgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=HnYCQsZ5; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1746472818; x=1746732018;
	bh=1O24BfelhZ9DVYbWzph2yMsqMQ0dqOUQjVvsT2MqzQU=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=HnYCQsZ5mKO2VNBA67w7vV/vd+EAf6+Ye7IyIYC5t9Us7m7bcAGgXkUNXldKO7H4Q
	 xCecxKro3SZrHiYlGPaSdo9JluE9F6iWyYhcxmq+d9W2gZOgyjTwcCJdV794LhdbCc
	 JBE27erBHHm3kPnBfPXDaEAdYjUeSGEqIogm0mfL8TvFfBJr0iYolgDYMnBK0qmoM4
	 S80haGZWs23cycO5oal1SzQdM1/EFmecbMcyh85iNwXcIUvonZgnj7/tVPf0Z8lMFK
	 z1Y2CgiWMKMBm8yEhjZ2tT05F+jtrwqV/sDeV1op7bG6nDyJ8MWqhXxt56UaywK40b
	 IQuPMJR0tjneA==
X-Pm-Submission-Id: 4Zrrvd5bmTz452
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 05 May 2025 21:20:07 +0200
Subject: [PATCH v4 1/2] iio: accel: fxls8962af: Fix temperature calculation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-fxls-v4-1-a38652e21738@geanix.com>
References: <20250505-fxls-v4-0-a38652e21738@geanix.com>
In-Reply-To: <20250505-fxls-v4-0-a38652e21738@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

According to spec temperature should be returned in milli degrees Celsius.
Add in_temp_scale to calculate from Celsius to milli Celsius.

Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
Cc: stable@vger.kernel.org
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/accel/fxls8962af-core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index bf1d3923a181798a1c884ee08b62d86ab5aed26f..5f5e917f7aa53912448ba078027183c63bc0cd7d 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -23,6 +23,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -439,8 +440,16 @@ static int fxls8962af_read_raw(struct iio_dev *indio_dev,
 		*val = FXLS8962AF_TEMP_CENTER_VAL;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		return fxls8962af_read_full_scale(data, val2);
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = MILLIDEGREE_PER_DEGREE;
+			return IIO_VAL_INT;
+		case IIO_ACCEL:
+			*val = 0;
+			return fxls8962af_read_full_scale(data, val2);
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return fxls8962af_read_samp_freq(data, val, val2);
 	default:
@@ -736,6 +745,7 @@ static const struct iio_event_spec fxls8962af_event[] = {
 	.type = IIO_TEMP, \
 	.address = FXLS8962AF_TEMP_OUT, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE) | \
 			      BIT(IIO_CHAN_INFO_OFFSET),\
 	.scan_index = -1, \
 	.scan_type = { \

-- 
2.47.1


