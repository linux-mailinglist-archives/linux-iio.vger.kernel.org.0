Return-Path: <linux-iio+bounces-12357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34069D051D
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4D3281668
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3090B1DDC25;
	Sun, 17 Nov 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4QwwEyd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4291DDC22;
	Sun, 17 Nov 2024 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868114; cv=none; b=BOgRtjCrby1iVFux18dZGTiC4lRIzEmHwbxA2ejFr9erbfXJxNcaAt9CaK7ewLJ8n+HHaRsvFbS9CMo5BocgNHVWZlzfvXsxnqEXJahUw7ggQUq6iLJ599yT1De/SG/wk5Dd4t5JXXX/bOtdyD+KtXeMTOa90zd8MhgSxkxLcxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868114; c=relaxed/simple;
	bh=Z7P8zkNLYdTfpu5DhAwcHjffAVE5EbJYRzO8KjJdDWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=to8EGlTnzZ2gDJln/Jd1bmHrM+QidRll59w01RvusfHr9PH7m6xZIWGARDtUnlsXftjfXXsmsDZyZ0tTYoGydv4SNtXFV5io0z02Sed61bwPVEGs5DYGVA8IHEPPHQ4MpWTqaMDZ/IVmsegPzPXNBNRfcgDFc+FlqtFyM7aPAoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4QwwEyd; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38231f84d8fso94679f8f.3;
        Sun, 17 Nov 2024 10:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868111; x=1732472911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/7YHZgr3ztO/Z4vG8ysu402O+69tdVx/wSYmqJAcik=;
        b=W4QwwEydxHulD8E35spQP9lgSCkv9/wurCCdkY3ipVgE93at+bbKQzQxptYWdb1IOn
         uGTGMsyPW9nUiZhS06FnRdXKdn3I4OGU1L4/FMM2UBmGraY2vUtDI5HrqyRZut1NT5tv
         Y6Tc6G72qHYq8DZpMb17SzEtRezRkqQ5Fm8d/0iBZ1eORZP9IT0DCwRO0PkxUsBfiPVo
         gKMVjoZP1/SZkS1/rjoFL810vKTF60Ys/pCL7Ie3DlneH++Irj9DcZhiqd3/v79d3MfR
         sSKAuf3bBmDD7K2tdfm4yuuvwcPRCm9QjPllKmgww/GOVDWp/ZZTi+2VESPt/HaSWoVH
         zGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868111; x=1732472911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/7YHZgr3ztO/Z4vG8ysu402O+69tdVx/wSYmqJAcik=;
        b=GXCDhAQDIpTNgV/KyOINRHj9gU3TUdEYImSIJFJothi23YbhH2FcjBXVWL0Lk5+45/
         ZOtgUnYH0AimB1XViYwiwlTU/ZczZ7cY91J9vg42DplWw3yjRmB/qKrQXKxuUgqCAfRO
         5v26TeZh3x2fRsDsRmIh4A1KliUyoodNQemB+EvhnqYId2h51MI89zZWURBvx4z/QNju
         K00knBbwp6dtv/bIiaC4VCaL7g9ABK3oUFeCOQ1zEzd0x3Ka4tHvkByYICjSf+qMabjR
         pyNvLk3p2wT/3FdpkFZONDJ+t6aWtmQVl2sO9wI1+N4QeDbnHPRNjkwa9YTpgfeV/gGH
         pPkA==
X-Forwarded-Encrypted: i=1; AJvYcCVMiNISUI8+R5g8qaaAVvLMW1IlDnJyZdPgc2KgfrfWzdl0mZpezDu2tdTbjAtVzxc5licOtaJ7/Gey4Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0ZSLLCLHj6EeC1yIsE+c45794oobJ4IhkFyCLqKl62urtXiY
	8jdtrOhjRBUAeVIkTpL9Jx47EEs2f3KMpkU7jjlc6Ky7yWuWJB5C
X-Gm-Gg: ASbGncseUWhssu6ubX+6VsZHcNAK+VUvs+ztsaz24Y/F+dkm2AXuT4RDO7F6CmIVfSK
	jfm2/0ZElsJbu58v6ldq7d6Xq6mqDEhP5i4SauRS6B1al6Pwjm25SyYySR1VraXikZTRHOzHful
	3HaDAwCCQPnmzxvNkdUbXEC+2WBd83C3mWUG9CfJJu6Zfm0+JMIJiad3HE/s2NtFxDxUxCNex/8
	VtdEGbdJPZqNUR6/pJ9HBiNvLFoQs18OC4FTtht2HqtlH2jOTdk6wS6F9OM4PFgbJJLwnXmaP4/
	2Q8SQqv1SVVKWgdjfD71B91F0QYW
X-Google-Smtp-Source: AGHT+IEITVBC0lvPuCmdnEbVFgy8ODWuDTFLqnfBjClQ7MvPpmZgoIfPBCQ4/i9CIthX931zsvs8Qw==
X-Received: by 2002:a05:6000:4012:b0:378:955f:cc0c with SMTP id ffacd0b85a97d-38225aa2cc0mr3008642f8f.14.1731868110548;
        Sun, 17 Nov 2024 10:28:30 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:30 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 14/22] iio: accel: adxl345: read FIFO entries
Date: Sun, 17 Nov 2024 18:26:43 +0000
Message-Id: <20241117182651.115056-15-l.rubusch@gmail.com>
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

Add a function to read the elements of the adxl345 FIFO. This will
flush the FIFO, and brings it into a ready state. The read out
is used to read the elemnts and to reset the fifo again. The cleanup
equally needs a read on the INT_SOURCE register.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 40 ++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 508de81bb9..40e78dbdb0 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -140,6 +140,8 @@ struct adxl34x_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
 	struct adxl34x_platform_data data;  /* watermark, fifo_mode, etc */
+
+	__le16 fifo_buf[3 * ADXL34x_FIFO_SIZE] __aligned(IIO_DMA_MINALIGN);
 	u8 int_map;
 	bool fifo_delay; /* delay: delay is needed for SPI */
 	u8 intio;
@@ -323,6 +325,37 @@ static const struct attribute_group adxl345_attrs_group = {
 	.attrs = adxl345_attrs,
 };
 
+/**
+ * adxl345_get_fifo_entries() - Read number of FIFO entries into *fifo_entries.
+ * @st: The initialized state instance of this driver.
+ * @fifo_entries: A field to be initialized by this function with the number of
+ * FIFO entries.
+ *
+ * Since one read on the FIFO is reading all three axis, X, Y and Z in one, the
+ * number of FIFO entries corresponds to the number of triples of those values.
+ * Note, this sensor does not support treating any axis individually, or
+ * exclude them from measuring.
+ *
+ * Return: 0 or error value.
+ */
+static int adxl345_get_fifo_entries(struct adxl34x_state *st, int *fifo_entries)
+{
+	unsigned int regval = 0;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_FIFO_STATUS, &regval);
+	if (ret) {
+		pr_warn("%s(): Failed to read FIFO_STATUS register\n", __func__);
+		*fifo_entries = 0;
+		return ret;
+	}
+
+	*fifo_entries = 0x3f & regval;
+	pr_debug("%s(): fifo_entries %d\n", __func__, *fifo_entries);
+
+	return 0;
+}
+
 static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
 };
 
@@ -363,6 +396,7 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = ((struct iio_poll_func *) p)->indio_dev;
 	struct adxl34x_state *st = iio_priv(indio_dev);
 	u8 int_stat;
+	int fifo_entries;
 	int ret;
 
 	ret = adxl345_get_status(st, &int_stat);
@@ -380,9 +414,11 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 		goto done;
 	}
 
-	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK))
+	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) {
 		pr_debug("%s(): WATERMARK or DATA_READY event detected\n", __func__);
-
+		if (adxl345_get_fifo_entries(st, &fifo_entries) < 0)
+			goto done;
+	}
 	goto done;
 done:
 
-- 
2.39.5


