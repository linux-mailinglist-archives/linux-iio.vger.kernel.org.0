Return-Path: <linux-iio+bounces-12346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA329D0507
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D98281958
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95751DC068;
	Sun, 17 Nov 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUHXYuXp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63A11DB548;
	Sun, 17 Nov 2024 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868100; cv=none; b=bEQuFl+ld0Zd2vn9pLQDvUOM8sZm/8vo1W6Thg3kpw9EvsSXei7qSTO9k4jJnKtVeMzwQog22p6zHewfzXyvFa5EI9KQhrDdyPDSOYagaISipg9T+OL/NcBii5/Dap3cQRBaPXMrYvRaLt9/cDolxyLgk50ppTskagENNUkjfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868100; c=relaxed/simple;
	bh=M7AmXApmuf6gfTw5V6gmYwXfmU2w2K7nTpX7mMO5UBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lxg/9rFDQwsZTLhOgmnO3ZI8hWKq/AHcBQMCB34i2yfJR2TTa4KuUSO9jmSz+o2nf25KEabKNz6BVT1KOC6TN7lMd2bQivU9h+EidX1g6BCxhRb60xU5NR97g0bmro8jdje6dcrH0Df3fSECmloLFEk/42VWK4a1QGzuu3u0vFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUHXYuXp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38235ecd7b4so70984f8f.0;
        Sun, 17 Nov 2024 10:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868097; x=1732472897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3LwylrLeCnvqkOwJ5T67HbtRloWHBNMvqG4QkO2RiE=;
        b=fUHXYuXpVGZ2tLgrgs33dAIP3EKC9TUiPOcaEg0KOmpI6agj574VWj9jlkZvVpQABZ
         nPYS0mCc0+7Tw7ASTgDLlO/yE1NCUQieSyXd2DQyW9xOpTPi3swgeyK76xgwPxuRKw+4
         PB4NXeKAb+pCWUcKFFMH4MwPp/fL6yCVviW7K87KOUvPmRKwjSU6VjQK9yIoCKHeSUq3
         /Yc0aAwDkroyhgEOYTjJL+kEazsqcKszkAMCNEJ7Jx36SGZSILb2sFtSgabxfw1ivRKB
         0sr/juml72kISF767wkYn9m/LHtSRjqNYJU0aeGC529nswqDRF+xFmjvaWc2IkUlXopx
         Mchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868097; x=1732472897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3LwylrLeCnvqkOwJ5T67HbtRloWHBNMvqG4QkO2RiE=;
        b=PIbM9qVj52psEejDWUHaALNHTNI4Wv5csakOtV26e0mvls3gcgVEH9l8V2gWrZD+bL
         klu9FOGHTG7ZPTmFEZIztT/fNhPtv73jdfEgfdP4zOIwdrnwQBJ9RA8aJ3Zj5CAZr3yy
         x5sSPEVNshmPatD5ggqbHOAk/nntBjue9BPwrynVdpENSDOmpTuHMpTFgxTUkpHf9Tfc
         TAfA+CkXWuf4KmUNBSCI4Eej+yQsQfehpovKjl+CY/PObGtAaQ+8rb/pd6O3nJXwQDxz
         44p/gUaj5UTRibnutE5p10i9E2xRD5gGwVeI4C/o0ltqcHBabYE3iiVEDKxmvyj/vWc8
         i5QA==
X-Forwarded-Encrypted: i=1; AJvYcCXOSNiL8jFytmDYsMNsqKIIh78g1Po2lOZhWceLzrEaUGZ6zQeyno/bqkeXAdA9ZSezRkGPDfXhcgQWUNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwg8Mq5kPo88rh6dZT12fN6ho+dGvdpJ1lWn56yWpCdEhxTvuR
	96BZ784wX7aTz+QpSDBbrw9m2w32V8WAzmVRDGBSORjVJ+FP745L
X-Google-Smtp-Source: AGHT+IHUC+id2XwEiadB8CxQIGE2A3DL8ax031c8GiDxZJW6sSHu2nnWbkIAljdtM5IPwryw9ju+Dg==
X-Received: by 2002:a5d:59af:0:b0:382:4300:34d2 with SMTP id ffacd0b85a97d-3824300707cmr578426f8f.5.1731868097090;
        Sun, 17 Nov 2024 10:28:17 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:16 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 03/22] iio: accel: adxl345: rename struct adxl34x_state
Date: Sun, 17 Nov 2024 18:26:32 +0000
Message-Id: <20241117182651.115056-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241117182651.115056-1-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the struct "adxl345_data" to "adxl34x_state". First, the
data structure is supposed to be extended to represent state rather than
only hold sensor data. The data will be a separate member pointer.
Second, the driver not only covers the adxl345 accelerometer, it also
supports the adxl345, adxl346 and adxl375. Thus "adxl34x_" is a choice
for a common prefix.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 3fb7a7b1b7..30896555a4 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -17,7 +17,7 @@
 
 #include "adxl345.h"
 
-struct adxl345_data {
+struct adxl34x_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
 };
@@ -43,7 +43,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
-	struct adxl345_data *st = iio_priv(indio_dev);
+	struct adxl34x_state *st = iio_priv(indio_dev);
 	__le16 accel;
 	long long samp_freq_nhz;
 	unsigned int regval;
@@ -99,7 +99,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
-	struct adxl345_data *st = iio_priv(indio_dev);
+	struct adxl34x_state *st = iio_priv(indio_dev);
 	s64 n;
 
 	switch (mask) {
@@ -181,7 +181,7 @@ static void adxl345_powerdown(void *regmap)
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		       int (*setup)(struct device*, struct regmap*))
 {
-	struct adxl345_data *st;
+	struct adxl34x_state *st;
 	struct iio_dev *indio_dev;
 	u32 regval;
 	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
-- 
2.39.5


