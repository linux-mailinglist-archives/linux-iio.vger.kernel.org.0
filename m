Return-Path: <linux-iio+bounces-23276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D30B34FFE
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 02:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B8584E3A95
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 00:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7481DE8BF;
	Tue, 26 Aug 2025 00:10:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8081C84B8
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167021; cv=none; b=EqB+cE9K5wWJM/wfe1xbJGtNfVxSH8DZEyGOaPnfqt+RZ+ZIyJKaqOZI07Jzor09FDVkKrMp/Hm9cn1S35vnSQXAb8s7x9bKhwVoqWr1F0V7tpcXN1UUyrLJEV3a/B+Lc+kox/GoYf3pUoU5kJ5Zti9H+Q2AQRRPqnXLlfQQ8nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167021; c=relaxed/simple;
	bh=LaEU8eD4+oPJdKQmwQsYgoZaN/CtBhdsRi6A/cby/us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=auQk+wV7uoQWUy1JMgDhYSYsZS5fFbvpCoKG0APVeLm2dN0AJWufT243x9xbpM8U2yFat4JhP5SKsi0peKZmaH04uKtP3VUI6bCQzE0NASaA8Fu3POpwvbU3BLcZVkRQwf1i5OZ3bM2gWXdkVyeVdm+FMkLlUjcfP8DVktE/mzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
Date: Mon, 25 Aug 2025 20:10:07 -0400
Subject: [PATCH v7 5/5] iio: ad4080: Rework filter_type "none" logic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-mcp9600-iir-v7-5-2ba676a52589@kernel.org>
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
In-Reply-To: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ben Collins <bcollins@kernel.org>
X-Migadu-Flow: FLOW_OUT

The filter_type logic for "none" needed to be reworked to be more
general.

As documented, return IIO_VAL_EMPTY for sampling rates in "none" type
and EINVAL when there's an attempt to write a rate for "none" type.

Signed-off-by: Ben Collins <bcollins@kernel.org>
---
 drivers/iio/adc/ad4080.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 6e61787ed3213fe4332bd92b938a7a717dada99f..c7408b9703731ee5d4229a85ffa91ea64b233cd9 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -154,8 +154,6 @@ static const int ad4080_dec_rate_avail[] = {
 	2, 4, 8, 16, 32, 64, 128, 256, 512, 1024,
 };
 
-static const int ad4080_dec_rate_none[] = { 1 };
-
 static const char * const ad4080_power_supplies[] = {
 	"vdd33", "vdd11", "vddldo", "iovdd", "vrefin",
 };
@@ -268,13 +266,13 @@ static int ad4080_read_raw(struct iio_dev *indio_dev,
 			*val = st->clk_rate;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		if (st->filter_type == FILTER_NONE) {
-			*val = 1;
-		} else {
-			*val = ad4080_get_dec_rate(indio_dev, chan);
-			if (*val < 0)
-				return *val;
-		}
+		if (st->filter_type == FILTER_NONE)
+			return IIO_VAL_EMPTY;
+
+		*val = ad4080_get_dec_rate(indio_dev, chan);
+		if (*val < 0)
+			return *val;
+
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -289,7 +287,7 @@ static int ad4080_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		if (st->filter_type == FILTER_NONE && val > 1)
+		if (st->filter_type == FILTER_NONE)
 			return -EINVAL;
 
 		return ad4080_set_dec_rate(indio_dev, chan, val);
@@ -376,17 +374,16 @@ static int ad4080_read_avail(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (st->filter_type) {
 		case FILTER_NONE:
-			*vals = ad4080_dec_rate_none;
-			*length = ARRAY_SIZE(ad4080_dec_rate_none);
+			*type = IIO_VAL_EMPTY;
 			break;
 		default:
 			*vals = ad4080_dec_rate_avail;
 			*length = st->filter_type >= SINC_5 ?
 				  (ARRAY_SIZE(ad4080_dec_rate_avail) - 2) :
 				  ARRAY_SIZE(ad4080_dec_rate_avail);
+			*type = IIO_VAL_INT;
 			break;
 		}
-		*type = IIO_VAL_INT;
 		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;

-- 
2.39.5


