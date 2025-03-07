Return-Path: <linux-iio+bounces-16534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC5DA56B26
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 16:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD0C189BAFF
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F86021CC7C;
	Fri,  7 Mar 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="nmLZo5pC"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-10.pe-a.jellyfish.systems (out-10.pe-a.jellyfish.systems [198.54.127.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434B121CC5A;
	Fri,  7 Mar 2025 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359844; cv=none; b=PN7J2olRZ10XPi3Fj73syip7/ncI7kZ73Ru5N+5Bm1caIHr3X1+K+OdCYt9muyYd2wLaSpj06usKoRDMYucSENw1hXZyNtjXlCOo/OpFbecnbi279Mty0iw+zRFL3ou1As/fT574cXSGPTV9LNuaZbIrtQFESdZ08K+MBqEHVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359844; c=relaxed/simple;
	bh=LgaKgJu/MCtJHok+RAh9Dc2Wuk1pWqxI2QVLD4SvM7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXyYK24iiSwcR8HpVRnkOc2pF8bteYvO8FbqjbvXmqFxy5O50t5tTsjikRNvBSAt0wliNc7qtb2fYDzSYEFTqcTm3dXtiBsG/1I0ycnx0r3TFM2ehz3+GhVoJ7Gp1c/Dtxe399VgmaafR4q6cy9IGA8iPUq2XUEGDTAnAcRwOP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=nmLZo5pC; arc=none smtp.client-ip=198.54.127.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4Z8V1B1XHNz9ty5;
	Fri, 07 Mar 2025 15:03:58 +0000 (UTC)
Received: from MTA-09.privateemail.com (unknown [10.50.14.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4Z8V1B0Phvz2Sd0V;
	Fri,  7 Mar 2025 10:03:58 -0500 (EST)
Received: from mta-09.privateemail.com (localhost [127.0.0.1])
	by mta-09.privateemail.com (Postfix) with ESMTP id 4Z8V1968Hwz3hhSx;
	Fri,  7 Mar 2025 10:03:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1741359837;
	bh=LgaKgJu/MCtJHok+RAh9Dc2Wuk1pWqxI2QVLD4SvM7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nmLZo5pCsWh4xxu5P+WuJXO3tgG/1dRDJ7XbwvAePFGCJo0zpDZAi5io0nEYUY9P8
	 sfXKf9sfJwR0Uh7n3kaUB6mmR2vVi+hBHSD6iHErVNASkKwMjqjiI9ngVtIUnCRT3d
	 cX5vcIY/nk9zdCTbtZyGx1YvH33pD3hq4XrVOaGtL6D+/D8Cg4i8MEmxoOWQyYAt5+
	 x+H69i++FfE6Enmy8OQVPh4zTDLdccg0fes3cPK1Lx606HdvtK7TXDSyK5ohuconFA
	 BEG8MWcPTOzGYFzZm3wVf0MYdlzykwV5+rIP5+2cz9BAZg4ezskw8ufY/dOaIxsUoF
	 Z5xCyRZKoc/0A==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-09.privateemail.com (Postfix) with ESMTPA;
	Fri,  7 Mar 2025 10:03:43 -0500 (EST)
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
	bpellegrino@arka.org
Subject: [PATCH v6 6/6] iio: filter: admv8818: Support frequencies >= 2^32
Date: Fri,  7 Mar 2025 10:02:16 -0500
Message-ID: <20250307150216.374643-6-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307150216.374643-1-sam.winchenbach@framepointer.org>
References: <20250307150216.374643-1-sam.winchenbach@framepointer.org>
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
Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
---
 drivers/iio/filter/admv8818.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index e9602bfd4af7..9785533d0cdd 100644
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


