Return-Path: <linux-iio+bounces-15249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51F9A2EA59
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 12:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0927E168583
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 11:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A361E0E05;
	Mon, 10 Feb 2025 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lheq0JzT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEABF1DF98B;
	Mon, 10 Feb 2025 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185298; cv=none; b=uM6hkCEC946IqKgTtCbGoGY4EMIvsb5JLozrml+h2liUuIS6aFtEKF1PU3uzlptjCSgnXAIakuJQoaHlXbhJmoxQ79LrpU9MUGHRoowwRiqWw2qXsAZa5orQt2IKVprDZbbdCAju0uiuOp1nFAqiD9g/NlFRzKAyV1+tokW6hxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185298; c=relaxed/simple;
	bh=4lgqPxMFIxcu6DJtyKvsa6jPFpK3C+Ewcmj6hhpH5wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sOz2z3Caq1Hfgh8LLfAQYpj5n+F0EHHi00DX9CdfMpPQT+j/D/ef7qv/uHnHmFy4PDUnyU2Bt+/4+tpw15DOw1Udl4uc0F+6qvlQSAxft6wN5WvQjwzNToAj0XEXKLpNC5F5/571znMM3IABhmLEScGqzGzR1HCURwBmlUDDonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lheq0JzT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7b35a004aso22180666b.0;
        Mon, 10 Feb 2025 03:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739185295; x=1739790095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OpRgAIuBhfsxGTEjf/p9nsoY6yTj5Mb2FMWgMOeJw4=;
        b=Lheq0JzT5+60TiPa6DpCrdE8RrLRtC/LdXgmlpbeBYPtJEqx0gBzUxWHEjx69zNH0a
         My79yWP4fvi2ytcimfHn/hmAVWtxVmJBpeAJrYyzne8wIlNX/QpIri2ToEF0rBpOmFK7
         Nl02Wi2ivZrlo99XnOTLN2BzEMOLXLf9WBigHeNCBFqP1bD7gfpMnTTkJdctIX9Yz05s
         vqCu93WKUcpGJe2uqr8a1WpMG0xG5w1sPVsPuOvY0TFBRSG0MsK01wvbPkmb6g6XH5QN
         hhvWTCYE81osqH+9yHSGbQO+UdT4+uIElThEDJ5rKdqHL2b2tf2ow3bNrwXL1hEdr2+R
         7gKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185295; x=1739790095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OpRgAIuBhfsxGTEjf/p9nsoY6yTj5Mb2FMWgMOeJw4=;
        b=O4qNzae1xh9ttA2+pCx09X9MaFzUEnCVrTlrTlT6djfqtwcUYiS+LYP2l9KSjgkh38
         ciF8bhuuoms+BdBCKHh4Quam3O0cM9si5cpB/C1eswJnbKjh5nlHFtUBUJ7YVgO4Ysr7
         Ilwo3OTSDeFKZaGmt+CN5qJEEzqZFuxodBSEMPPUIHqosxZlF/dgZ07gaBFXtA/urHrS
         MSwJ/KEreqjT4BhOy/i9hQyfNxuqxpjZbF1ce0HqdWNidoBOVn1v+/q6mRA6AiAYkMQN
         aAAo0j+OffRZkrOuWdAyngGCamyv11196Fm1OaRrqQ0KBzumVSGl80c5Zjqsb1caJ7El
         vQag==
X-Forwarded-Encrypted: i=1; AJvYcCWPwXeNONZzI/uKvZaD73a7/7BxuiCOhk6TXqUILfsHc/0nHq9qm59x1FkK7AGOUoCD+Oze8irjfE/9k0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzriI5pzBQekSekuifRSHlju+3cELVBVkvFwcPH6Aj/GwCopKwG
	2mIjl2rhz4vTwSSXf61Ox6jqxqwgRYwYkvSJGSMiQ+sJ0+BxBkX+
X-Gm-Gg: ASbGnctYow/SMgQoJMd+cClNXiY3WQDXlCOy4jW7BckPxzKDlT5sfhkr+9v4YCb1ku9
	1H8u82WfeMB/nszPaovKzQFz3+JqbOji3YHHMl7WFwn7qOMrjAfjBgvaLrG2T9cbKKOXhXECcdb
	5T8trJcxXDTDEjgK/UuVR6+OB+TWh81V/jXUpsArv8fLHE0Pj6o/lwsUG2z9BPUKbbnZpSTTJFc
	AhiM2Ad8lnP9KgwkPx8Tl9X5lu5q2pDRh74AekAZ/zoQK1cZurGnhYmKkDi3LZeSH3oq2ATaB4J
	tsBDA0u3oh7f5Lqo3J3sRRTNXZqgilr3OM5nWCrgP6li3gu/aLS5WeHbSN9tWAYjtsFZBw==
X-Google-Smtp-Source: AGHT+IHCN8FAOnf074W91FqLK2TJl4jo1arYJwYdZdC+yUBSlpwUlylD99NqUWtXXh70SuLS9ddJJQ==
X-Received: by 2002:a17:906:891:b0:ab7:cb76:1b0e with SMTP id a640c23a62f3a-ab7cb768dedmr53984866b.9.1739185295058;
        Mon, 10 Feb 2025 03:01:35 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a5a78369sm486987266b.136.2025.02.10.03.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:01:34 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 02/14] iio: accel: adxl345: add debug register access
Date: Mon, 10 Feb 2025 11:01:07 +0000
Message-Id: <20250210110119.260858-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210110119.260858-1-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the possibility to verify the content of the configuration
registers of the sensor in preparation for upcomming feature
implementations.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index c24692c51893..468d562de227 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -202,6 +202,16 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int adxl345_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+	return regmap_write(st->regmap, reg, writeval);
+}
+
 static int adxl345_set_watermark(struct iio_dev *indio_dev, unsigned int value)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
@@ -467,6 +477,7 @@ static const struct iio_info adxl345_info = {
 	.read_raw	= adxl345_read_raw,
 	.write_raw	= adxl345_write_raw,
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
+	.debugfs_reg_access = &adxl345_reg_access,
 	.hwfifo_set_watermark = adxl345_set_watermark,
 };
 
-- 
2.39.5


