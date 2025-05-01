Return-Path: <linux-iio+bounces-18934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2AAAA5F0E
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 15:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7147C1BA6D77
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F041898E9;
	Thu,  1 May 2025 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="NstJ8hfJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080017B505;
	Thu,  1 May 2025 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746105232; cv=none; b=M8JmM/qPFEhhhtnzETJ+iwlkoF1/Lx4LJUqftVBFuotSh74jWBlj/NkPInT7or4XL7+mF6ZJLxgkwB+FtwoFEN62/lJj0ueOXnewS7mFM5LaWACh1e2wJ7NcGl3wGTjNJLCSOe6uFz+VI8/UPMuAcLNm3kVqULAnXCr+/xRNhnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746105232; c=relaxed/simple;
	bh=HLwLMswNQWcQF+fGyhqQZLtlLiWI5k1+8chFZwLpWfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OtCwczmE7QrcUinlYAY/7HPXN7Z6NLmYSz34d8pt8dWVcSYCaobLnKGFfdwhFhXJ+pOan5Y5DhN+opN7ZwSCCzm29E+eX4jWFeUMh/mhi3cvTsJJN5hCbScvG5ZKwY2fHuhZeO2BZal4eAdPvjgeVmqOElO5UjAix5V2jgzoE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=NstJ8hfJ; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1746105211; x=1746364411;
	bh=4wPipCRhHlyPVuzZYAxl1lTAXENsLRiey+v9ICeii4c=;
	h=From:Date:Subject:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector:List-Unsubscribe:
	 List-Unsubscribe-Post;
	b=NstJ8hfJZj0DJmTBThM2Awi/uthY1uu4LOwnwA5bRZ9KyuIQWyTx9ztWQjYrp7fDA
	 GcLnZmOpLNS+BXDVJu2pe+kyqrn63R1BYcP3IglOApd7Mf6cH48PeZvoZ5M7+Gllc8
	 xSMPQ0Tt8Ni4wpWvQQT0MM9PoY879hbZdGrPp/27qcvy+4H/uob6oNyyCSDSt3TmBw
	 i2MSI8LYsh5PUYN1OyrHP5MFEuh29TTN9XmVEhhdkV6/lCfA3bWvgSM1C1gjg0sJ1t
	 l88XKTKSwmjNt+YGWCFuv3+OnpJo2d96SXVhLSEYzDdYNmbVCEsIf7HS54i5AIfzk4
	 1IrkdnPpD5mkw==
X-Pm-Submission-Id: 4ZpDyJ3j10zLT
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 01 May 2025 15:13:27 +0200
Subject: [PATCH] iio: accel: fxls8962af: Fix temperature calculation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-fxls-v1-1-f54061a07099@geanix.com>
X-B4-Tracking: v=1; b=H4sIAHZzE2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUwND3bSKnGJdYwPz1DTjFLMUAzNTJaDSgqLUtMwKsDHRsbW1AFWL1sF
 WAAAA
X-Change-ID: 20250501-fxls-307ef3d6d065
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

According to spec temperature should be returned in milli degrees Celsius.
Add in_temp_scale to calculate from Celsius to milli Celsius.

Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/accel/fxls8962af-core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index bf1d3923a181798a1c884ee08b62d86ab5aed26f..30f08160eecdd1f9574c86baeeb17cc0ef1e7c60 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -133,7 +133,9 @@
 #define FXLS8967AF_DEVICE_ID			0x87
 
 /* Raw temp channel offset */
-#define FXLS8962AF_TEMP_CENTER_VAL		25
+#define FXLS8962AF_TEMP_CENTER_VAL		25000
+/* Raw temp channel scale */
+#define FXLS8962AF_TEMP_SCALE			1000
 
 #define FXLS8962AF_AUTO_SUSPEND_DELAY_MS	2000
 
@@ -439,8 +441,16 @@ static int fxls8962af_read_raw(struct iio_dev *indio_dev,
 		*val = FXLS8962AF_TEMP_CENTER_VAL;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		return fxls8962af_read_full_scale(data, val2);
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = FXLS8962AF_TEMP_SCALE;
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
@@ -736,6 +746,7 @@ static const struct iio_event_spec fxls8962af_event[] = {
 	.type = IIO_TEMP, \
 	.address = FXLS8962AF_TEMP_OUT, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE) | \
 			      BIT(IIO_CHAN_INFO_OFFSET),\
 	.scan_index = -1, \
 	.scan_type = { \

---
base-commit: 609bc31eca06c7408e6860d8b46311ebe45c1fef
change-id: 20250501-fxls-307ef3d6d065

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


