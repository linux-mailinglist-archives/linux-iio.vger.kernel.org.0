Return-Path: <linux-iio+bounces-16907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E878A635DE
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 14:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB10B16E14F
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF841A83F7;
	Sun, 16 Mar 2025 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="Rf1esN3p"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-16.pe-a.jellyfish.systems (out-16.pe-a.jellyfish.systems [198.54.127.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DF025771;
	Sun, 16 Mar 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742133133; cv=none; b=o+t0p9FY9e0KmSXS98gNg5D90z8x2DAUjs4RnEc4H4z5PvE2GADIaIDWE5iPUe9hc8yYS7SPbHl8CHuBTxAECZSQCuZk+s5JiQgMzzhxU8ET8BtTBX4jCD3EzStv3Pu9DvMkRldUrxBw4GaIf2Y3pGmUXtdTEGLupN/2JmIiRYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742133133; c=relaxed/simple;
	bh=1SiD7gk+5xuC4ORw4uMLtYSs0AGjK7z7UEPewOOQSLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVGbKOZdrMBkgWCZXpdRu5SIs4gWRUlO2rq/EKuu9lysEgn5VAFU0Dzmac/+ZyspLrXLupL0P9iNvoEjztFpO1XxtCk3W8TrBG77PSDWygaxW7l4zqjBGgkjuzEqOzbP0cKwuslbIrwSO0w9Dsk9HRZTrTAnD3LV66oxOYCx2Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=Rf1esN3p; arc=none smtp.client-ip=198.54.127.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZG0086Jr2z4wSq;
	Sun, 16 Mar 2025 13:52:08 +0000 (UTC)
Received: from MTA-12.privateemail.com (unknown [10.50.14.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZG0085ygZz2Sd0Q;
	Sun, 16 Mar 2025 09:52:08 -0400 (EDT)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
	by mta-12.privateemail.com (Postfix) with ESMTP id 4ZG0084mNqz3hhV5;
	Sun, 16 Mar 2025 09:52:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1742133128;
	bh=1SiD7gk+5xuC4ORw4uMLtYSs0AGjK7z7UEPewOOQSLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rf1esN3piRyXtg+VzuzssDJokUZP+TSrlTQrJqoRcO7Y8f7MVwn4OU1SPc+2SJQ87
	 4WJzEGjbK/kqGoKsXbrjRF0Yvx5S32EkforDG+8xqB+Q140HcvMoI8+b/W14Xb8f1x
	 ma3qoInV9nwegtYOsM/GD0SOzjzilgR8bDu6TIPT53RQIWNFTwTe6WTiNEsVENQdzy
	 RO5blupLRRSzX2PI141/TxEvcLmrTqiLKQgL7mPccVJRbM4j1i1+LyrM9rb5dy7s89
	 4QwJgK7FgMwWAbRznjLUBQueS2Fan6RtA/1pPt4NODfhvqVQU0R0MP7+aDSW6fob6q
	 HmwJHrOtQmKEw==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-12.privateemail.com (Postfix) with ESMTPA;
	Sun, 16 Mar 2025 09:51:52 -0400 (EDT)
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
Subject: [PATCH v7 6/6] iio: filter: admv8818: Support frequencies >= 2^32
Date: Sun, 16 Mar 2025 09:50:08 -0400
Message-ID: <20250316135008.155304-6-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316135008.155304-1-sam.winchenbach@framepointer.org>
References: <20250316135008.155304-1-sam.winchenbach@framepointer.org>
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
index 380e119b3cf5..cc8ce0fe74e7 100644
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
2.48.1


