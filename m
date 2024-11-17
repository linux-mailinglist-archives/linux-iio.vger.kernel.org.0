Return-Path: <linux-iio+bounces-12360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 267209D0523
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53383282260
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0FF1DE3C0;
	Sun, 17 Nov 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsF4V0t1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FE51DE2C0;
	Sun, 17 Nov 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868116; cv=none; b=ui3tZMxcC/F897CLd3wd/mlXnkfsGjkfXnDIDAqP1OA9vpZHn5V0+Oxi22qhlCyPVz1HvKj9cUBcogHonTRFwkg+46vTfAmgt+2x4dPXwsgNObaRmD80uhlQMuuIu/zSyQ+PeECT3q4JpwKGlBaiKwqyPe6r4DG1xyUMfZhJKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868116; c=relaxed/simple;
	bh=9ir+vZ/Jv17LXPmR9NGO3MPEoIMmnrvZ2uBx90jwVSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LkJs4syXQ53Za5p1HdK/HwDjGSuFQbqsuxu1Lx3FiE/dVS02CrDb8rDIvz81mqdEAn98GVw3U7wlhJkHOXhVq2zx31VilrJQxb1H1pXoo6DC9BivIWvMOobxSe/UdaBMPwUIr6LKFzzpXKBeoGq5cxq3IeQ9DTEwJfCyQzJsseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsF4V0t1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315ce4d250so2222015e9.2;
        Sun, 17 Nov 2024 10:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868113; x=1732472913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB5mGB45X+RMJ3zhFxUgvKmYS4xbQci0s/JjGj03ZEo=;
        b=DsF4V0t14q+kbl2wiEnstNxCp+dTXPbG8RNMrEeQbVT/4P+RSJ4fq8HKYlzEMGX6QL
         E3/f4XoqUEwDKVgd+dolaVlZSbGCd4Y1ZZZcxiDTrXDcRvqa3s0JPwZIzE/9rYdoDNoc
         1/XhCUbsraBsE+1vJmp0TXgtVNG6+15tx1zQPZa0UNXCsJkuFs2pErMRiPYD8CytxGWS
         ZbLWnCcUVOLy+hiqf/nAYcqYCxEyLi3cJqrkKgWfhKDxlsoNWmxhEAdoyxVABtJTZsdN
         BVcLfAxqjrxdWFzw4/86D5FTIU8Kfy18eyGZbL5Pk9CftXlVqGIqUBz6PRq7voRlzzpm
         yu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868113; x=1732472913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB5mGB45X+RMJ3zhFxUgvKmYS4xbQci0s/JjGj03ZEo=;
        b=RR+233ezK3wWOlzm98NWcurYbqs9waccsHntuYm+q3LxNqH6nM6/pM0TGUPmzN26hz
         k5JuBFHDeGMjCNMkCLNdftSrklrp5+w4c2bWUJRB3qEVkwVg1ltw1x+JRwgFfJaNVhGv
         Mj4ByAkGDvjlfGKX76Uk8x2f26wRR0vDJh0ErMnjv3ZpW0a5P4VPNteSkMMGft54q1Nz
         2jeKmwD/7uuUWU3rOv9R4Ma0ZrsdbO0JVqHTl09QCHZsv3pNBaGJHu+FyfoCdGt4QdGk
         MuAwM1YMPfvt2Gx9FzYbEil+dRkXtoKKMjgXxpvB32ABDATSapTtK+GqJwtoLb8mBkiF
         4CKA==
X-Forwarded-Encrypted: i=1; AJvYcCUK+zDng3aGNs+8wKDMnm7V/OGwWLHzZQfgCqBfboXNjTq4E83ceXQRq7mJs2v6KtWWXbxCdze2Rok7Ei0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOuAsQ7Pe43kPbhYi+Kj+yr0QV4MQr6U19mF6n1AvZrEvkb8WN
	JJW3gL4Hre/u08/ZQfxGsVBDdksm/KmJP3Zoo+dMI+ZXTVTXGssy
X-Google-Smtp-Source: AGHT+IES29fz+Nj1hxjCALIePv1MBZEWxRWn/hH0czGtFUDPHEDVmL83nGkXai09po8DzcAUJFj02w==
X-Received: by 2002:a5d:5f4b:0:b0:37c:d0d6:ab1a with SMTP id ffacd0b85a97d-38225a92b39mr3254337f8f.12.1731868113187;
        Sun, 17 Nov 2024 10:28:33 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:32 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 17/22] iio: accel: adxl345: push FIFO data to iio
Date: Sun, 17 Nov 2024 18:26:46 +0000
Message-Id: <20241117182651.115056-18-l.rubusch@gmail.com>
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

Add FIFO and hwfifo handling. Add some functions to deal with FIFO
entries and configuration. This feature will be needed for e.g.
watermark setting.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index d58e1994ff..a653774db8 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -437,6 +437,41 @@ static int adxl345_get_status(struct adxl34x_state *st, u8 *int_stat)
 	return 0;
 }
 
+static int adxl345_push_fifo_data(struct iio_dev *indio_dev,
+				  u8 status,
+				  int fifo_entries)
+{
+	struct adxl34x_state *st = iio_priv(indio_dev);
+	int ndirs = 3; /* 3 directions */
+	int i, ret;
+
+	if (fifo_entries <= 0)
+		return true;
+
+	ret = adxl345_read_fifo_elements(st, fifo_entries);
+	if (ret)
+		return false;
+
+	for (i = 0; i < ndirs * fifo_entries; i += ndirs) {
+		/* To ensure that the FIFO has completely popped, there must be at least 5
+		 * us between the end of reading the data registers, signified by the
+		 * transition to register 0x38 from 0x37 or the CS pin going high, and the
+		 * start of new reads of the FIFO or reading the FIFO_STATUS register. For
+		 * SPI operation at 1.5 MHz or lower, the register addressing portion of the
+		 * transmission is sufficient delay to ensure the FIFO has completely
+		 * popped. It is necessary for SPI operation greater than 1.5 MHz to
+		 * de-assert the CS pin to ensure a total of 5 us, which is at most 3.4 us
+		 * at 5 MHz operation.
+		 */
+		if (st->fifo_delay && (fifo_entries > 1))
+			udelay(3);
+
+		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
+	}
+
+	return true;
+}
+
 /* data ready trigger */
 
 static int adxl345_trig_dready(struct iio_trigger *trig, bool state)
@@ -508,6 +543,9 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 		if (adxl345_get_fifo_entries(st, &fifo_entries) < 0)
 			goto err;
 
+		if (adxl345_push_fifo_data(indio_dev, int_stat, fifo_entries) < 0)
+			goto err;
+
 		iio_trigger_notify_done(indio_dev->trig);
 	}
 
-- 
2.39.5


