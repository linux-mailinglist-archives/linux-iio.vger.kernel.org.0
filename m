Return-Path: <linux-iio+bounces-11080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACF89AE04B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 11:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075A91C22189
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 09:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F194E1C1753;
	Thu, 24 Oct 2024 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UEB3NOKi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101D81B6CFF
	for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761177; cv=none; b=ETDRzGWTkSQy1WR6I/JVWc9tfyebQrbzNKN3juuBeQGso8tshyhZFtcVF9SDNnrQn6TXnrMzBXdia6bgytOJ4BmUGBHnZK7+4i7hXtklzieCCf3qvobiNyN3apU/gSe2qzxQJauMGom7OVS+i0cDIKrEVJuCMMG0KWlZWd0OdeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761177; c=relaxed/simple;
	bh=EvZTfjPuH+Sw2tva9CA/YuYYsffYBvbQ9xRBfy4MGH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C3DKxZpaXa15JxCfi9t/UAizDHNI5iwVNISXoYdMEbMDwhf6iFWUEPk60UtD7cZXW01TRa5PhN9W/QTRgPiNaOZKGW2XA0NM7bXOknzh8UD4qURUUqt4+k4NGczzB2SlFAid5525lFg6Q7p9RJN7UT9rBRVyC6jcmkcL2lD/zp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UEB3NOKi; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e63c8678so708524e87.0
        for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 02:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729761173; x=1730365973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpXwrqa5mh4an1VW52USOlgjMJ2X4POeKu7/qnEQ85Y=;
        b=UEB3NOKiu7qiJQ+wpnQ+mQ5/yijjJUbHhY6+b09e6YYZm4/CWGkN3fWh1tJlaTQSK/
         S/N629d8wE4wniYUVGp6HM5ShYNr4ob39W+XlMeNkFjDdf33MYlkqq4oPLxVlRFNhWlf
         z7A1vlXEaLKVvsDGbsSLLc7jMunz+7wmUsFZ7LfIJeg6oR1NYHPtMuu4QVmV0x5CNT6d
         XXvhkXS74OoyobaHe7zkzNsKSuv/mAi7mKvAAqHaY4dCuiZZx9pdpB33QYq+4oX0hHpe
         xQ+VzxlzQspIT9IECXZEd9OtEktWpW9xJ05m8mruDuUTGfuOzG+eojB9N31QMqcYEMZb
         0xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761173; x=1730365973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpXwrqa5mh4an1VW52USOlgjMJ2X4POeKu7/qnEQ85Y=;
        b=SyFEDw0LMmGBzn8QZpOdnLHSnYZV0qBcSiEf8bI8XY2c9fw7jYltHpdiKf2r0/kspZ
         qMAmupJyl826yQs9Tq28zt1HxHlobu5ASB2GQUsP+vPLwPwtru8kETE8qmc6wWNgmdDD
         PQHVRJNg6QdkZNh2zUDOWgctPpVtm3aRpCFv0UKpuQZmfQktzk18TIt7Oj2oP1XE1E8L
         ynITwakxtwI0RQwnxD//H0NDvK7LdU2CiVrAwAh68JxU7fqZpOVnRH0t40oGbUMpnUqv
         0iAxKyadWrW3M7q2SE8OjQ+P1/uPMroT7w9yLOtWWw3sy/z3KzqT7ubRhxETS1u8/u52
         BnTg==
X-Gm-Message-State: AOJu0Yxu7G/C3n1IhtYnlLkSyZTVcfYndYWpZvmYSKM2Ao42pcF+2Etv
	YRyqL3D749xcxVuUjcH855o0Tlj3aj1fOFBsz3i9Dx3/SPaRQp1PkVLe0YdvIfM=
X-Google-Smtp-Source: AGHT+IHjMTzdOejYpXdaJTcSXe71t6xMLTv/MupAWuwwaYamFeQSYvZEYBgJNNUbqbvWU86WqzOMBw==
X-Received: by 2002:a05:6512:3a82:b0:539:8b02:8f1d with SMTP id 2adb3069b0e04-53b1a3392bcmr2894072e87.30.1729761173024;
        Thu, 24 Oct 2024 02:12:53 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94071sm10843701f8f.89.2024.10.24.02.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:12:52 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 24 Oct 2024 11:11:27 +0200
Subject: [PATCH 5/7] iio: imu: inv_mpu6050: simplify code in
 write_event_config callback
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-iio-fix-write-event-config-signature-v1-5-7d29e5a31b00@baylibre.com>
References: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
In-Reply-To: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
To: Mudit Sharma <muditsharma.info@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Anshul Dalal <anshulusr@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Dan Robertson <dan@dlrobertson.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Mariel Tinaco <Mariel.Tinaco@analog.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

iio_ev_state_store is actually using kstrtobool to check user
input, then gives the converted boolean value to the write_event_config
callback.

Remove useless code in write_event_config callback.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 7 ++-----
 drivers/iio/light/apds9960.c               | 2 --
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 5680be153127711777b6074da18a7a0f86211d6c..21ebf0f7e28fec302cbf8ab890fc53a3de6f36cd 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1176,21 +1176,18 @@ static int inv_mpu6050_write_event_config(struct iio_dev *indio_dev,
 					  int state)
 {
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-	int enable;
 
 	/* support only WoM (accel roc rising) event */
 	if (chan->type != IIO_ACCEL || type != IIO_EV_TYPE_ROC ||
 	    dir != IIO_EV_DIR_RISING)
 		return -EINVAL;
 
-	enable = !!state;
-
 	guard(mutex)(&st->lock);
 
-	if (st->chip_config.wom_en == enable)
+	if (st->chip_config.wom_en == state)
 		return 0;
 
-	return inv_mpu6050_enable_wom(st, enable);
+	return inv_mpu6050_enable_wom(st, state);
 }
 
 static int inv_mpu6050_read_event_value(struct iio_dev *indio_dev,
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 3c14e4c30805e1b596ef2380f94e6aa3e92082b1..3a56eaae5a68f2891d061871c7013f0b5447bb47 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -762,8 +762,6 @@ static int apds9960_write_event_config(struct iio_dev *indio_dev,
 	struct apds9960_data *data = iio_priv(indio_dev);
 	int ret;
 
-	state = !!state;
-
 	switch (chan->type) {
 	case IIO_PROXIMITY:
 		if (data->pxs_int == state)

-- 
2.47.0


