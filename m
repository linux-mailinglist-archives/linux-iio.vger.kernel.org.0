Return-Path: <linux-iio+bounces-19074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43964AA8C31
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 08:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656053B2425
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 06:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4DB1B87C0;
	Mon,  5 May 2025 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="miOMU+rH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7661414A4F9;
	Mon,  5 May 2025 06:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746426035; cv=none; b=AWzbZ952ytB+QP0b90kW6xlYPpCTPljemYvo001Pwv0MUuKkkRRmqUDI4vaFNFC2vSuOp7FzshciylB+OiChDsbhtfSENQPnadGs2zV/VIzorO3hh9BDD/ltNn+QOhVOHn8Uv2BrAaXqvaJv5B4ni7rD/CYCUw7MQSW5HI+5Z6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746426035; c=relaxed/simple;
	bh=WRbxXhF5jzD6HpXtSzphU2DbxmoM1jzyCMvp9GcqV0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WfWkAXz32CLd3jFKRF2aowhCCGpVrg6am47DGcy76u5LoO6W1xA1ag0K5yKqSAlVnjXg0cc5Ph8A+XHbszrSpkIzXu485nLwkpFcg9/zIyFs4rV9ynmwDQfIO01HHqIAuMpBiB3JHSGrvcTOCykhWvFo7OnZKPnJI0RHzOjjG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=miOMU+rH; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1746426024; x=1746685224;
	bh=/pl/RqbeblDhs24K7ns24ijDcFav3tDgNErZZsXTCD4=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=miOMU+rH4KqqpkGSo8vMx1zw0G60EixhhRFKCmhDMJt7tl8KObuTBJbeCY+q02r95
	 xtWZhJX48cJFRTOEwBihReI2kbIijbGpRqwg7CpET/cz4zSSPx03oFytogky/yIbXr
	 zphSW6Xv+J6Fb22FU8qccpMw/Q+/mPb48nBDp0OtojW4Q8BYGU9M+LKBcjUN8DFT2z
	 bJB/QCTzVJUnqjlPvWgq+5SEgpv8KrQ4ZhhmTT4ebTEZDdXqpvxSFbGbAQ4rzWA4E2
	 WCfcP63M/oNk7/rgyFbG4etqfGa2Jv5yaWATnPMVaGYCbuIeHqtKHnu09dMNMoc+fj
	 NwFt3ar2M1ygQ==
X-Pm-Submission-Id: 4ZrWbp5jHRzLR
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 05 May 2025 08:20:19 +0200
Subject: [PATCH v3 1/2] iio: accel: fxls8962af: Fix temperature calculation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-fxls-v3-1-8c541bf0205c@geanix.com>
References: <20250505-fxls-v3-0-8c541bf0205c@geanix.com>
In-Reply-To: <20250505-fxls-v3-0-8c541bf0205c@geanix.com>
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
index bf1d3923a181798a1c884ee08b62d86ab5aed26f..27165a14a4802bdecd9a89c38c6cda294088c5c8 100644
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
+			*val = 2 * MSEC_PER_SEC;
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


