Return-Path: <linux-iio+bounces-17319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B68A74FBD
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 18:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4E818976E3
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 17:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD771DEFCD;
	Fri, 28 Mar 2025 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="sojH8WbF"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-14.pe-a.jellyfish.systems (out-14.pe-a.jellyfish.systems [198.54.127.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CAA1DE3AC;
	Fri, 28 Mar 2025 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184234; cv=none; b=l9Ttf+LKuNkiVDIO6i7vjqeMPkWzerUXn7zRhxDthtHHTd5Tk5ldGOgHN+ai8Z19hxFBBAVcmAOT7CZuYXyMOBr5dR1xihwC+Jj28cQhxms4jUQF3+f6bzDyP8ojhmh6OrMzh2pFz9/uat2moaB52ll0axAuU4FsI3IT7Carqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184234; c=relaxed/simple;
	bh=a4wb0o07elSzfnSvnFun1jxLv/nj4dn1gQgFhZ1pABk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPQAiIUzALKWEQECB2JB6vgQ7icdUVXLenkVQrULICUTBL/wnFlrDMpQJDHzIqjEZA0PLGSFRmw9hwvm/H0VQcOEqxH69iXjGMwblcxc2X158ovG2lTE/26p/snEToUXqNDdNmQMqsBNADTVne9UYwH9Tux+0wp4Oy6uQ8Q1598=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=sojH8WbF; arc=none smtp.client-ip=198.54.127.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZPSjg5Z9Sz3xGq;
	Fri, 28 Mar 2025 17:50:31 +0000 (UTC)
Received: from MTA-14.privateemail.com (unknown [10.50.14.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZPSjg4ykKz2Sd0Q;
	Fri, 28 Mar 2025 13:50:31 -0400 (EDT)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
	by mta-14.privateemail.com (Postfix) with ESMTP id 4ZPSjg3fP8z3hhVQ;
	Fri, 28 Mar 2025 13:50:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1743184231;
	bh=a4wb0o07elSzfnSvnFun1jxLv/nj4dn1gQgFhZ1pABk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sojH8WbFRP8Fhm85PrwsdsTjLQJOwxvIejbgV6Ta2AWed4O3iLe0EQbECGPzgzGCL
	 ZESH2FYChFjvXYJQEkfZ4cYui1FWJEX98BURQpdg3Wct9P57FZhlibXpAsefBkH6hO
	 XCSi4xiCwMMBfS3iwpI0m5JZX0nkC9n786Q4yi3EFiY2YHH28WN+q9B7q6KGBj5ocT
	 FC63yssBa89aI2F/ninuAqckq0+vHu/YXD2JWHlQCsFcwkzCQK8R7q5cMHPD8AGHu4
	 1OoTooaNfxkxNINn1g5z4kIL67ryHfC1cFukqnBRGl3JB4+b98PUEcU0Xk2Fae1knO
	 m8cPoq7h6jNag==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-14.privateemail.com (Postfix) with ESMTPA;
	Fri, 28 Mar 2025 13:50:15 -0400 (EDT)
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	antoniu.miclaus@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	sam.winchenbach@framepointer.org,
	bpellegrino@arka.org,
	Sam Winchenbach <swinchenbach@arka.org>
Subject: [PATCH v8 6/6] iio: filter: admv8818: Support frequencies >= 2^32
Date: Fri, 28 Mar 2025 13:48:31 -0400
Message-ID: <20250328174831.227202-7-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328174831.227202-1-sam.winchenbach@framepointer.org>
References: <20250328174831.227202-1-sam.winchenbach@framepointer.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

From: Brian Pellegrino <bpellegrino@arka.org>

This patch allows writing u64 values to the ADMV8818's high and low-pass
filter frequencies. It includes the following changes:

- Rejects negative frequencies in admv8818_write_raw.
- Adds a write_raw_get_fmt function to admv8818's iio_info, returning
  IIO_VAL_INT_64 for the high and low-pass filter 3dB frequency channels.

Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
Signed-off-by: Brian Pellegrino <bpellegrino@arka.org>
Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
---
 drivers/iio/filter/admv8818.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 380e119b3cf54..cc8ce0fe74e7c 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -402,6 +402,19 @@ static int admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
 	return ret;
 }
 
+static int admv8818_write_raw_get_fmt(struct iio_dev *indio_dev,
+								struct iio_chan_spec const *chan,
+								long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		return IIO_VAL_INT_64;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int admv8818_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int val, int val2, long info)
@@ -410,6 +423,9 @@ static int admv8818_write_raw(struct iio_dev *indio_dev,
 
 	u64 freq = ((u64)val2 << 32 | (u32)val);
 
+	if ((s64)freq < 0)
+		return -EINVAL;
+
 	switch (info) {
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		return admv8818_lpf_select(st, freq);
@@ -571,6 +587,7 @@ static int admv8818_set_mode(struct iio_dev *indio_dev,
 
 static const struct iio_info admv8818_info = {
 	.write_raw = admv8818_write_raw,
+	.write_raw_get_fmt = admv8818_write_raw_get_fmt,
 	.read_raw = admv8818_read_raw,
 	.debugfs_reg_access = &admv8818_reg_access,
 };
-- 
2.49.0


