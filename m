Return-Path: <linux-iio+bounces-26460-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BC2C862DB
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 18:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1DE34EA283
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 17:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEDD329E78;
	Tue, 25 Nov 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/dyVtNv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE2D329E51
	for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764091117; cv=none; b=p9pyrGYAeJ/8XFiUXDoQTJdvV7fq6QNhOkn2AIl4zqAA/1trnYnfNQ27aLHSCeymxBw+JBgZfLq+FBI3rBZVXcvr+c8tC6sXFxTz0pmnSt7hEumrNhMWHBa3+Sk6TQvQ0HigbTMTGpIQ0YrCD1DhsGH2tzaJRkr4tQFrHHD/Qg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764091117; c=relaxed/simple;
	bh=NCGMO4KyNrDX8qeMfx8WbkTKDG/GcUzek+W1srksjBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTPZnqinWKdpIvmbM7q/nWAKApuThRAWpgEh5otEHhgleHmQvXF276XaYy3asqr3bMroH3/sRn8vScCX2e5QYXIMP5RZEA1urViEgXaffKxMCNWj6xo3rGFXvIR5UIUFb69VCOv8ci9FTm6uERkk7mY0MiQeBLX+iAfhty8gZn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/dyVtNv; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso24971995e9.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 09:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764091114; x=1764695914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AaSodM8BaXTwj38q/AUUUaQCnMwjjQ785e3zJBbJXZU=;
        b=Z/dyVtNv8z8q7zuvavd2bn2ktQIMcN9Y0ChMv/pVsFuQXhUGoA6qCGHVTKbzx4/WKK
         ushOUv/3yHrtuvw4GwybfvWEC93q+6lR3G81OducQx4OJQMEaUUulGuJZCEx/RJUXNf2
         NcP66h3CFUk3eOwVnOaYFcyn40EVFq+IkiY7aK8NgsnLD7oPNt2Y5sEZ1l6/jORH57sM
         uPNANHb6I2ssMuZME2Dk57nhOtpVb6M9uff+tFWXRT35i+zpntMG5pWUj217LpQQfJl+
         F9Bngnb7dqdHU6TStOfTzNbKyn1rSoP+trSGFbWqMVTyAEYLK18/yIElITRJ0eUdOff1
         dRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764091114; x=1764695914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaSodM8BaXTwj38q/AUUUaQCnMwjjQ785e3zJBbJXZU=;
        b=cGJvF3j8b+pdBv9VGCBZMbAbIcTPQHIhyDxnNRYVINRASOVod9jAm40aL6tD6kVhW2
         PrOFVbJI21QvPyTaQyIk7nStPHCCxGljwFJ00IuMkS88LxFXLu6jiYN2kaGBmyBtyMfM
         58YOLhqiiB92xFti2ofz+yqMbmOJMTl0voA3nKoudMvSAcwfk6KrvDqFkwizP5WuQaMa
         u/fEWqN9pjtenYgIWiWcC4wZwREHVyIYstXwOU/XO52h7lROVZgC1nYKfIBvhvA4mZaC
         qW6FDMLwEsZkbMzvbaT9DN2deZUWSeKWi/uwVzxvT2kyRRwtJKYSsKgUqKAzE3coy9T9
         5uIA==
X-Gm-Message-State: AOJu0Ywb1i34f74YXGDDNQm8Eikg2BFc37Ep2QOThyJo9WrYwsygnGxl
	p7xNM6XUaZhaZ1+JU6UWmnZVnDf9ajt+htK36ZrK0/8XwzQP+tYxFFLd
X-Gm-Gg: ASbGncu8xXJV95Rju/JQzyXKeOm/Mgv3q8tZuAQy/PDBkD3RCsbW8+bQjFB9c9H+r9d
	Sha8RDDRj06CWpzLl0aGzbJT1CJ+ru1zFPfaQ6DPfgplThj3KE5SRVs5awak0UenRNvA7Rt9W3l
	GZ2BH7Oy66pCHOgmKIJe7E86Sw9Lat2PInNMM8p3NoeavQh3zE8iJNQv9t3xb5WHiT9p3/mP5+g
	Qfu7/Xt449PojDjAMK3aTCsRssRovf+w5rM5Ufb6B8GzNW00kSAtl9jc6gDrJKecSsNixlsE5V5
	VcZfoG4l8E7vIswgHGbhz1/rUFV4fdgnj1jBMIqCiYo3qkjJXx2qYdjl3KwR5gQHCKOCEjOG/FD
	O9ioYlBD2um1PXwl8tYZ2DPbmAAP6D3FK5RQHhBSMlJsWl9AbRsrHg4uTDC7mR8LLHjdo0zRDAS
	A2JggxL6Ob9iMPmMPT72WA3sPXVt8uQM21/t7t9HQQrHK2SGaZO2I=
X-Google-Smtp-Source: AGHT+IE/vbJJcVgBI3u/KHJW6Do3/ycDBRE8mLPAReHAEx0msChspGeedB3SzWKISO9Xwj+lfS5+Qw==
X-Received: by 2002:a05:6000:18a9:b0:42b:3e60:18e9 with SMTP id ffacd0b85a97d-42cc1ab8bf8mr17090535f8f.10.1764091113948;
        Tue, 25 Nov 2025 09:18:33 -0800 (PST)
Received: from localhost.localdomain (net-93-66-99-25.cust.vodafonedsl.it. [93.66.99.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba20esm35584481f8f.37.2025.11.25.09.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 09:18:33 -0800 (PST)
From: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Jianping.Shen@de.bosch.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
Subject: [PATCH] iio: imu: smi330: remove redundant assignment in smi330_read_avail
Date: Tue, 25 Nov 2025 18:18:16 +0100
Message-ID: <20251125171816.63790-1-mpellizzer.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the IIO_CHAN_INFO_OVERSAMPLING_RATIO case, the type parameter
is assigned from smi330_average_attr.type and then immediately
overwritten with IIO_VAL_INT on the next line.

Since smi330_average_attr.type is already initialized to IIO_VAL_INT,
the second assignment is redundant. Remove the hardcoded assignment
to maintain consistency in the code.

Fixes: 6f3d8de8886d ("iio: imu: smi330: Add driver")
Signed-off-by: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
---
 drivers/iio/imu/smi330/smi330_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
index 7564f12543e0..0cf673b44b62 100644
--- a/drivers/iio/imu/smi330/smi330_core.c
+++ b/drivers/iio/imu/smi330/smi330_core.c
@@ -475,7 +475,6 @@ static int smi330_read_avail(struct iio_dev *indio_dev,
 		*vals = smi330_average_attr.vals;
 		*length = smi330_average_attr.len;
 		*type = smi330_average_attr.type;
-		*type = IIO_VAL_INT;
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		*vals = smi330_bandwidth_attr.vals;
-- 
2.52.0


