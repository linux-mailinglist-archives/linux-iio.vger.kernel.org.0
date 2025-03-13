Return-Path: <linux-iio+bounces-16789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AF8A5FC95
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59842189F6E4
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC00226A0CC;
	Thu, 13 Mar 2025 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzEOZXzD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83B3269B1C;
	Thu, 13 Mar 2025 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884672; cv=none; b=adTNB1lfXRAD3Id0MvHvuQJ2F+iDLnDy5dF/lwtPftu9mUOJIrpu44m7eCPIAZsSHj+XLQwchi9GW30zE1P4RjZu2Bu4RGHQjCfcKpNIffvd2lspsWCHWzwI+ccSTdzpCv0FLvFOngv5n1gYpr1iWACHygZRnccCPaLv4K+O26k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884672; c=relaxed/simple;
	bh=u9G/VADTODvU6o35fILx3AL9lup03EwPP9DMGouxYpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ohay+1o6HlpRN18XIh66ZgswNOJN5aVVPpFDRl+Ba8mbM6k9OCWLlF0ilNYzuNjAd2AFdmnkbyw9YRPds865YwsMa612MAM8ULxI8CEMVF1MKAnw/xkY9GzHO0epRNBdeCIRVyRM+0eu5rna9hyWg/Zn7ZvHNtbKbwbhLhqvxXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzEOZXzD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac250d158a8so17037866b.2;
        Thu, 13 Mar 2025 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741884669; x=1742489469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DqhiJj9lWqqTYxoYhDZchLg7FS/oUyFT1jb7mKGMjw=;
        b=TzEOZXzDaIuQgOA/FXrylaUhsJKjSMTy9nOAb+OuS1vhA1nEhYspL4ZoITYPzYH+E2
         whcme6ziceuA98TnlptbWzssV08/sSIaexsYxgno/83715Kdk5kCE5hyAa2iQBIrUN1+
         lIpet59jNFg7hDqv+n3R6Igh2YXHl0UIkzy82uAxFtPKppqXtwYG9bSa8NyT8Qy5clMp
         3MRQDMAmwmotIqVNYPSpoX3jAjkw6fIFRxzJSrDC0yknjHq1KbbpF9PQ7dGs0WgBTriP
         cjdX6FaS2BZA3z+HUso24WCAjyVOutTPN3Dx7SqD0541QLHzJMmsYmqviQC46ZgPOcEp
         AtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884669; x=1742489469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DqhiJj9lWqqTYxoYhDZchLg7FS/oUyFT1jb7mKGMjw=;
        b=PvBUIJ/iOqNWwWLkPX096WV5Tv8Ksvxa+t0JxFNfiFh22QwXguw6bIS1nrhIzygD+z
         Gw2zuMSEuNkHp4dYIUNMwtDEu0EZgNKkbfWyDhr2zAoytI+iE6mA3lNK9Z2fhmHDbmRk
         iYqG8mW0SoBTJOm/luZEzgy9cJhJXRdAHOtt8MbpGrSG4kaZDAj3Zzs/+Vgz5YHpOTR8
         dy+R/hQSQCVx4f6dtAJviGCJjmts6jhI/WwgFTi+E/UZB6NKIik3IB2OzIDddFsh1eAt
         Ye1duLtsO1Vizsrjn0EnRWqkpJTMOE24Vk2SmLNpZlgA4EW0GjCYaNJ3OKQ4hWvBINIk
         Eqcg==
X-Forwarded-Encrypted: i=1; AJvYcCWdYLLu+is+cZGg3nGPtEAw+gutqp8bQ2Lf4N1KaZ0oPhyJL04OZM1r8vzKsHHfTOdfgR4YwLBbxpqYNsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZsRe32r+F0SJp+IlvRrHsQgPp629c4F2tCDe09RPB5P2HbEd
	tSJxrf6Kwn65GH0xcrN2OC6iGFkrNE9JXB79GErKu9hkESlxkJ73
X-Gm-Gg: ASbGncsyacAPW6zECVxOB8WoTG/QpefbikY7LfqQqhpmB3cGePr3Gj+Enk/A/vn2vaL
	kSdGO7LSbm5ikcMmf+P4nm6zM22158QYyocI/EcxRuP1auw0KwT4za9xUU4tFG5SmkDac84J3mH
	6hHTy6wa5P6gXav4M/Bw/8uQzgeI8Sr8bf4LFFX1NMNmgjHZ1jsbUtyirC45JuzjIRg0yWouepM
	aq2CoLYrEgUoUw3PgcK2Qxqhk7LzU33FnTNEYCtjxcTJNRT8hbsxfBf76rtf11decGlQCczUg6s
	urx3YHJ7Ft6OpSlYnI0kvuIkK67xxEeCM/ro0AzlxVK5HWD07d0mRQjb0vYsQHrtQtIYnnTnhJL
	Nq9x9i7/8cYNy523z/1i/wOE7fLPObNKr6g==
X-Google-Smtp-Source: AGHT+IHZVM76uhneXgTV5Vj4H7et8O5mdc7ynEHne1EuR7N2avQZ5Zrp1UZDw9VYpLDiSBl85E2CjA==
X-Received: by 2002:a17:906:7311:b0:abf:6f87:6730 with SMTP id a640c23a62f3a-ac2b9de959fmr607932766b.5.1741884668925;
        Thu, 13 Mar 2025 09:51:08 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147efb0csm101370866b.65.2025.03.13.09.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:51:08 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 03/14] iio: accel: adxl345: cleanup regmap return values
Date: Thu, 13 Mar 2025 16:50:38 +0000
Message-Id: <20250313165049.48305-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313165049.48305-1-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regmap return values sometimes are checked being less than zero
to trigger error handling. Sometimes this is checked for being not
zero. Unify the situation and check for not being zero.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 10e2da7de17e..eec3f0e17e1e 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -133,7 +133,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		ret = regmap_bulk_read(st->regmap,
 				       ADXL345_REG_DATA_AXIS(chan->address),
 				       &accel, sizeof(accel));
-		if (ret < 0)
+		if (ret)
 			return ret;
 
 		*val = sign_extend32(le16_to_cpu(accel), 12);
@@ -145,7 +145,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = regmap_read(st->regmap,
 				  ADXL345_REG_OFS_AXIS(chan->address), &regval);
-		if (ret < 0)
+		if (ret)
 			return ret;
 		/*
 		 * 8-bit resolution at +/- 2g, that is 4x accel data scale
@@ -156,7 +156,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
-		if (ret < 0)
+		if (ret)
 			return ret;
 
 		samp_freq_nhz = ADXL345_BASE_RATE_NANO_HZ <<
@@ -270,7 +270,7 @@ static int adxl345_set_fifo(struct adxl345_state *st)
 
 	/* FIFO should only be configured while in standby mode */
 	ret = adxl345_set_measure_en(st, false);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = regmap_read(st->regmap, ADXL345_REG_INT_MAP, &intio);
@@ -283,7 +283,7 @@ static int adxl345_set_fifo(struct adxl345_state *st)
 			   FIELD_PREP(ADXL345_FIFO_CTL_TRIGGER_MSK, intio) |
 			   FIELD_PREP(ADXL345_FIFO_CTL_MODE_MSK,
 				      st->fifo_mode));
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return adxl345_set_measure_en(st, true);
@@ -304,7 +304,7 @@ static int adxl345_get_samples(struct adxl345_state *st)
 	int ret;
 
 	ret = regmap_read(st->regmap, ADXL345_REG_FIFO_STATUS, &regval);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return FIELD_GET(ADXL345_REG_FIFO_STATUS_MSK, regval);
@@ -332,7 +332,7 @@ static int adxl345_fifo_transfer(struct adxl345_state *st, int samples)
 		/* read 3x 2 byte elements from base address into next fifo_buf position */
 		ret = regmap_bulk_read(st->regmap, ADXL345_REG_XYZ_BASE,
 				       st->fifo_buf + (i * count / 2), count);
-		if (ret < 0)
+		if (ret)
 			return ret;
 
 		/*
@@ -390,7 +390,7 @@ static int adxl345_buffer_predisable(struct iio_dev *indio_dev)
 
 	st->fifo_mode = ADXL345_FIFO_BYPASS;
 	ret = adxl345_set_fifo(st);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, 0x00);
@@ -544,7 +544,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	}
 
 	ret = regmap_read(st->regmap, ADXL345_REG_DEVID, &regval);
-	if (ret < 0)
+	if (ret)
 		return dev_err_probe(dev, ret, "Error reading device ID\n");
 
 	if (regval != ADXL345_DEVID)
@@ -553,11 +553,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	/* Enable measurement mode */
 	ret = adxl345_set_measure_en(st, true);
-	if (ret < 0)
+	if (ret)
 		return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
 
 	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
@@ -595,7 +595,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL,
 				   FIELD_PREP(ADXL345_FIFO_CTL_MODE_MSK,
 					      ADXL345_FIFO_BYPASS));
-		if (ret < 0)
+		if (ret)
 			return ret;
 	}
 
-- 
2.39.5


