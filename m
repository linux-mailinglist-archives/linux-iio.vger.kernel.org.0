Return-Path: <linux-iio+bounces-19750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF24ABE785
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 00:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319671B67EAB
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 22:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E4925F976;
	Tue, 20 May 2025 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdQVsnZ1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E102459DD;
	Tue, 20 May 2025 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781442; cv=none; b=eIDrCOsNaO5BhKeQPz88I0Y0mIhbixsLw/HUeJaLWQKyGNEU5Tr+HpbkhAamWyJEmVw6h4l7Qa4YBhpjz2hf7gul10iWkEqAZPur74tZYz7no/4He47bEH/bvlk1VmQlxQJAOpaDKD0xxI+83tzrT4OAqELMUTHnibfgso0oKko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781442; c=relaxed/simple;
	bh=4VcxMc2O+7O6Wyrf7uyGzg6cQv5sJpNtCm62qAyK1Ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3rCbq5iLO3xSyFWL3x1gA11D3A7ZPtDJwkqI+gDzE64YimW8ywoaYifaAbuCT2D8dIaEbaDH2pq5QXSP1guqlfZaW7GN+Hls5zTLw3zp9LPvtpHaPypSUIUZPjlbqE3weVr7ffzwUegYZeQnVLRJ59BIT0VAi3/nhj8q/cx6aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdQVsnZ1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43f106a3591so5758845e9.3;
        Tue, 20 May 2025 15:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747781439; x=1748386239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIP0vkmItWQF91gizrE7KsbrwzYmte6B1xKBxPYNS5c=;
        b=MdQVsnZ1GlNz+oVoCf+hOWpShc3tp0pzXlSVXaveS8W6yhr6rJ2QC4NpRgYOVWlvBC
         g1Y+g1OjxXFm53sqMe0ZfqwaCL/g94kNxOp3C5RsnVvSthqRyljDk+obfSKQQqwVqwXX
         RUv0t4o/9iKkyVRzz93yGYcHZDFM7OZopFq3bv+hrQgOCd52of0XUzqHn/CD+PVun51G
         MuJjEvlD6VTiEcGrBngAmUWQngowMWzp33ERNAEA5VdFenJcFomg46poZLcG3C3KSAV3
         zjrZYwjPcXicE8yxfYyYRYYcqCUr+61/Lgg4A0UXcGx033UZmSnwjOepKFrQmG0Lu3UJ
         d54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747781439; x=1748386239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIP0vkmItWQF91gizrE7KsbrwzYmte6B1xKBxPYNS5c=;
        b=dwKn3XyBJLgIcbSL8XB5Y1DfROI1qofjkR+1JMV0RII/jy+kqJSDOiOJ8SSdMP/p3Z
         ymXmedjJHW4WYELT6nBPAl129a8/O1XZuXefJf84rgXUrv+ntS7x7l+Npgl/e+xMUdao
         akkdPYgsa8PbtmS/2P3ZeJg0XezbyNSzYkpUuFe+EsTNf6+Y9+gHWMVqB/uKleN1S5zD
         2WTQIH8sFXNHoHZkMtTDrUqIHxGOVzogpO2incJJxC63AWZFCIxTA+WuMDM6ND3XxBoi
         K+1jRetvZ0LcCTxTB9FfbQfKaBmn0gm2l+WFYlZ+/tnpqwMSW/orMIOzP1DW++sofbKc
         Pesg==
X-Forwarded-Encrypted: i=1; AJvYcCUTHEiyfcWNCJaUrzhOQPGsQcbvu+gTz94RMPyJjwifWx+tqUkkvNDFRZmDhYfDx51DaaGlD7o8ojo=@vger.kernel.org, AJvYcCWRon7zxm8BUOzQbXDE4sE6p4Sg/hd9jNHtuj4riEkW1auDM7MMZCMlYjL+Ay+h/U3NOVZAKpvg8nPlm0Bw@vger.kernel.org
X-Gm-Message-State: AOJu0YzOPIxkV//Ds7co6WvgcUs3ZnWqQ8ehbo/sK7W8VglavVVRtlIF
	LpmfGdfaWcsB962X+fRDa0mNnzVVdmeuZ6jhYPuBZ29/hw8xA4BC6a3+
X-Gm-Gg: ASbGncvayZTy/3UOHcVd5QzStjR8pcEwfjzV5mh5Qty26rat4GmeKmcAj3QKxWjy2/C
	ClGJOLHls5FeL1/8HZJg2PENgEytzzYE/6TBzvo+mwglIgG+mUNqBr9Vdy3jGf5euRjbDQWTuCx
	E5tEkAtd6a/5K/bnZQqN6+r5nEzpg1RZuKx/VRkACR8bLCpg5OrcdvQNxzT7IjJS7+fxPPebZf4
	76Mbp/6r6HowjwSFLwwol7iAyPYacE05Vq/AtofUR9IrAQIfKon9tJ0NrXQSIe9mvBY6kMWWPk6
	PUmemSiAZ7qG5jJSBrzpVFkeyONcBMrQm64EREVXM6IXBLfqoFIgmuD8ufU8bGQlbe3nmfXTSUB
	/IdG7BSZfnvHOQUVNn/MVSg==
X-Google-Smtp-Source: AGHT+IHwLa0NcSSdWhqZ6yHv5XeFrvRfhVdmgBL+4ub/1G1DwGAI9ZJnbfhCxg9Yah4O6beOhmlH0w==
X-Received: by 2002:a05:6000:4202:b0:3a3:7bbc:d938 with SMTP id ffacd0b85a97d-3a37bbcdb8cmr1257093f8f.4.1747781439025;
        Tue, 20 May 2025 15:50:39 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm18101588f8f.11.2025.05.20.15.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 15:50:38 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	l.rubusch@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/12] iio: accel: adxl313: introduce channel scan_index
Date: Tue, 20 May 2025 22:49:57 +0000
Message-Id: <20250520225007.10990-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520225007.10990-1-l.rubusch@gmail.com>
References: <20250520225007.10990-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a scan_mask and scan_index to the iio channel. The scan_index
prepares the buffer usage.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 2f26da5857d4..9c2f3af1d19f 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -171,9 +171,10 @@ static const int adxl313_odr_freqs[][2] = {
 	[9] = { 3200, 0 },
 };
 
-#define ADXL313_ACCEL_CHANNEL(index, axis) {				\
+#define ADXL313_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
-	.address = index,						\
+	.scan_index = (index),						\
+	.address = (reg),						\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
@@ -187,10 +188,19 @@ static const int adxl313_odr_freqs[][2] = {
 	},								\
 }
 
+enum adxl313_chans {
+	chan_x, chan_y, chan_z,
+};
+
 static const struct iio_chan_spec adxl313_channels[] = {
-	ADXL313_ACCEL_CHANNEL(0, X),
-	ADXL313_ACCEL_CHANNEL(1, Y),
-	ADXL313_ACCEL_CHANNEL(2, Z),
+	ADXL313_ACCEL_CHANNEL(0, chan_x, X),
+	ADXL313_ACCEL_CHANNEL(1, chan_y, Y),
+	ADXL313_ACCEL_CHANNEL(2, chan_z, Z),
+};
+
+static const unsigned long adxl313_scan_masks[] = {
+	BIT(chan_x) | BIT(chan_y) | BIT(chan_z),
+	0
 };
 
 static int adxl313_set_odr(struct adxl313_data *data,
@@ -419,6 +429,7 @@ int adxl313_core_probe(struct device *dev,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl313_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl313_channels);
+	indio_dev->available_scan_masks = adxl313_scan_masks;
 
 	ret = adxl313_setup(dev, data, setup);
 	if (ret) {
-- 
2.39.5


