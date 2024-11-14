Return-Path: <linux-iio+bounces-12280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 383EE9C95E6
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC73B252F9
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FBF1BDA99;
	Thu, 14 Nov 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx3OCFW/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA51BD00A;
	Thu, 14 Nov 2024 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625830; cv=none; b=jJDA9lzCURsXQbMAl1VASq0Y5dq1ygUsfaaFMxpHusmamOevnOcBD1cL4KsBNbSL8xmeLpEx3VT2sD3DT6OnKaEmNoRXoAohm+kn0Fp8xyMOqKUfq8lUq8V5D1BWGnJLHu4bBMNcsWdsJ1muJS+8lc8ZNXrBNy3ZvvLr69oSM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625830; c=relaxed/simple;
	bh=FnUMRnVfqPwzn2GWw4P4fw/zWcW37qtrq67wAyadi3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QxJrxQdMrL7Aroc1SOsRKrAsSrthlQqyOuVUDJXyMg+hDitoEbhCoQS35l46zDtUbMLkwOrifM0DvHPCiVdvGFWoHWfWwSz33H5S0arrmq946RamdSsmdl1SrgOY2uo4S3N3dUIAxnuxEYff6kAQkzpmJ6W+wAVbCNxtjvEMFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nx3OCFW/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43152fa76aaso1070095e9.1;
        Thu, 14 Nov 2024 15:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625827; x=1732230627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=252n9N3GvWh31+SjJ6a2GxPMS/1QTtURFdXXkWDSmNI=;
        b=Nx3OCFW/E8Y6WhD3CuxMhGgjPeeao0PPpeuHTSqXFDGIrwIVww3XzPmel3krzOc0tz
         hG81trKaB1IgVG+YzRKq1Ycq/0Zox2aQBQ/WPo2+V6BoLMo7rvXgp1xjoIYMhNR/qhE9
         IyY+JdpVJkca9iSOfhrxo3SzhXTpEPo60pFvr4YFhq0ALPASNp4NGBEspWes8wDcJBZC
         SrMhWAG2lyiFpT39qek0AyJZ+AUB7WQ7zo+h0jz5Smbwfp6PEtCbk8CbNYSmTTbZVnNl
         A0LHH3OYnnPkVOEffPmQLbJGyhwgJsbvBDy9hp+oQ34A5PdcbAxdGMcUxC+8w8dp6c7K
         xB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625827; x=1732230627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=252n9N3GvWh31+SjJ6a2GxPMS/1QTtURFdXXkWDSmNI=;
        b=L46PaqfLYv7sDXcBAuaIkfl7lTArti1IorOwqBkux7MWg7Ye8Fh7bXE11fpDQlgmuy
         3/eMtuKVp4mkQkEU8FJ7qF9QL9Oms1PCI+5y1G0lfO5EbJAYei1BHwCUngJwLo/ag85z
         130eWF3KkZYCuHkya0TfrcaccR/uJI50FvSK9antble/uTvyz/Vs3yVX5DGTsRJm9QU5
         dOgUItRUQ8XwaWbae3KMt/bA5Rbuk34k1cqNvAY/Oi3vBSMuk1Ucp+aQ+f6TQlU9byZN
         ytltrWnxDDq28CRw0vM7Lx0PzN9M0XfNAnYwcTkQqUUXP38BXbd5xiYo13U/Lm1t45Pw
         svpw==
X-Forwarded-Encrypted: i=1; AJvYcCUPlXGuIMmI128iqlUMDPbdMWPZQKy5mr0wQNQ49/xawzluN4Zb3As0qseVJk1XUcjh54rPIG4GzJU=@vger.kernel.org, AJvYcCURLvQqx5JYLOZTpLmiNbJGKk3hDrhEG4uHBHYMXoiqOIdXvzIkPzTezCfQcbQ0Yf2qbllcZkbEzj9fQlIK@vger.kernel.org
X-Gm-Message-State: AOJu0YzJNDixeuy4gb/kUPz9QeXnsxrS896Iw/6dexLnJOa2IHOzt2J1
	GFBdEkeilVrukENMxt/yZGQolGhZPiLSd1TLqAnVg0+28KCjRoxC
X-Gm-Gg: ASbGncuWsBb9GsYdM1EvHleuviGX++KJfKuex/7R1c6CoE67N6rXrcZf6iMx5gosD3R
	63UDhcklh/+EsQUP2o5aEENm8pFgb1ffUkk/uGCuHgPqIiYDv4Z6vAxODFG//a+NavjIjWWqQ6k
	djPtj3Hnd4Wq1xPcbX1yNsFFocMXWP1gsyM84MrGmawAVu8K520BUR0ipRaB6Xe9wJUCpDdH2QO
	zhN2YIQgrfrnZOWJrnazaLt0s7IYOxqZVU2Ek0xDrt16IXZZZFlt8VGY7F2Ho1/ZPonGPFxdni3
	qDtL2gsjO97GJ8EEgju2PGtMxVGE
X-Google-Smtp-Source: AGHT+IHESrZpJmgl/AzIXO1ZP1opZt2LD4GqP7iZbH22OZDYNRPd5BWgXMr4OTGD+8bFaSFAoXu1xg==
X-Received: by 2002:a05:600c:3588:b0:42c:ba61:d20b with SMTP id 5b1f17b1804b1-432df728caamr1681875e9.3.1731625827064;
        Thu, 14 Nov 2024 15:10:27 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:26 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 12/22] iio: accel: adxl345: elaborate iio channel definition
Date: Thu, 14 Nov 2024 23:09:52 +0000
Message-Id: <20241114231002.98595-13-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241114231002.98595-1-l.rubusch@gmail.com>
References: <20241114231002.98595-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the channel definition ready to allow for feature implementation
for this accelerometer sensor.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 36 +++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 57ecf33d60..7e607534df 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -141,21 +141,33 @@ struct adxl34x_state {
 	u8 intio;
 };
 
-#define ADXL345_CHANNEL(index, axis) {					\
-	.type = IIO_ACCEL,						\
-	.modified = 1,							\
-	.channel2 = IIO_MOD_##axis,					\
-	.address = index,						\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
-		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
-		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+#define ADXL34x_CHANNEL(index, reg, axis) {				\
+		.type = IIO_ACCEL,					\
+			.address = (reg),				\
+			.modified = 1,					\
+			.channel2 = IIO_MOD_##axis,			\
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
+			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+			.scan_index = (index),				\
+			.scan_type = {					\
+				.sign = 's',				\
+				.realbits = 13,				\
+				.storagebits = 16,			\
+				.shift = 0,				\
+				.endianness = IIO_LE,			\
+			},						\
 }
 
+enum adxl34x_chans {
+	chan_x, chan_y, chan_z,
+};
+
 static const struct iio_chan_spec adxl34x_channels[] = {
-	ADXL345_CHANNEL(0, X),
-	ADXL345_CHANNEL(1, Y),
-	ADXL345_CHANNEL(2, Z),
+	ADXL34x_CHANNEL(0, chan_x, X),
+	ADXL34x_CHANNEL(1, chan_y, Y),
+	ADXL34x_CHANNEL(2, chan_z, Z),
 };
 
 static int adxl345_read_raw(struct iio_dev *indio_dev,
-- 
2.39.2


