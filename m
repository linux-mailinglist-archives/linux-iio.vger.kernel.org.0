Return-Path: <linux-iio+bounces-16489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D8DA5565C
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 20:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FAB1723A3
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 19:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F288626FA5B;
	Thu,  6 Mar 2025 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="FQFeUlT2"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-09.pe-a.jellyfish.systems (out-09.pe-a.jellyfish.systems [198.54.127.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076641A2391;
	Thu,  6 Mar 2025 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288502; cv=none; b=GrzteGhNMrlSaw5VT6KmDegDZY3YRbYB7fEkQcQTbgKizqizL0hrAXrRQ43hNTivu12X3pzh9DTM/YYt/tgrOLl0h+W0hiINenO7pQ65OpUEdBhNYzT+hwUiPYsbSGIbCP+yjGzqTFjoaLaUd2zf2RlVifHOG1mjcLsFtmFmxg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288502; c=relaxed/simple;
	bh=nBPkoZ8vNwJqp4riykZFnLWtVfneXz+CoQhXP02bOL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCf0gsDT9EG9XVSmMdBa7sG8dVWnhL2dCt+gTZmlS0U72Mdp5mblgZrI1a2t5V8WbmjN9DrE4bJlIg3Qc7b7aJGjEM55cObjrQ6IKW1hB+sVEFduuUkHFhSDMLmIG6ZfAPAmx3FZdaWl/2jHzqPHQeQ1rT8Zo2kdS0u3OfiRdYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=FQFeUlT2; arc=none smtp.client-ip=198.54.127.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4Z7zR61wghz9sx5;
	Thu, 06 Mar 2025 19:06:10 +0000 (UTC)
Received: from MTA-07.privateemail.com (unknown [10.50.14.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4Z7zR6174Sz2Sd0V;
	Thu,  6 Mar 2025 14:06:10 -0500 (EST)
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
	by mta-07.privateemail.com (Postfix) with ESMTP id 4Z7zR56rNMz3hhVN;
	Thu,  6 Mar 2025 14:06:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1741287970;
	bh=nBPkoZ8vNwJqp4riykZFnLWtVfneXz+CoQhXP02bOL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQFeUlT28eIzW2YlCPlppE14abMY3SeLk1Tj1JXWghxfljlIK5Jl0+MUUdO9zSs3c
	 1kwn2dI0z7XHjJqSaYUDmxQr1ry5cuPpO8rjQNE0Hx665rQNrK3hCGDD42LYYLTA4G
	 LktsomKq/QO3kE3fXjTMoLiSK0v3yU7Es7ee6o23fxdRnwX5d2njSeWA0HLmMt3Nl4
	 QN2eOJnJWKm2WjyjKBxjJiEZfu8UYFIPGiPK1M5rypui0PZgoq/t50klpzq5FBhA1C
	 qXetHZ+ud8lwZMA8HBe+FDy1O27vWB8C6GYsgVAt5x+zU3vYeTI8e0rmbu7kC9IZsR
	 MSV3kK8S6WAiA==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-07.privateemail.com (Postfix) with ESMTPA;
	Thu,  6 Mar 2025 14:05:55 -0500 (EST)
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
Subject: [PATCH 6/6] iio: filter: admv8818: Support frequencies >= 2^32
Date: Thu,  6 Mar 2025 14:05:28 -0500
Message-ID: <20250306190528.152133-2-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306190528.152133-1-sam.winchenbach@framepointer.org>
References: <20250306183314.150253-1-sam.winchenbach@framepointer.org>
 <20250306190528.152133-1-sam.winchenbach@framepointer.org>
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
index 8cdfae56199b..1228dd5ddb36 100644
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


