Return-Path: <linux-iio+bounces-11822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D909B9ABC
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 23:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E12282242
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 22:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52D51EABA1;
	Fri,  1 Nov 2024 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MNX2sM4b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FA01E7C37
	for <linux-iio@vger.kernel.org>; Fri,  1 Nov 2024 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730499443; cv=none; b=a6hA0nrUauFoY5o33/Hy2pYuJQ0fysIH5dwUYrpL4EzSKxkfA77LgOsfkfYKqW5q4tyAbTYIZwjo95Fv/Xnax7aOWPl17bjAXA0eO8IoU8vc6LC8Txpn8Xhz2MFaAYM46XdZWqxSoksl2zf7CJl9awcTd5TAklBdf6p/pJwzbBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730499443; c=relaxed/simple;
	bh=m1YPenGQkWl/zDdbYUdX2RWyx9UwmWv7bbCPVpnxn78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IKNnDfnCfCx3weM/uLjP4WbfjSaTwh0u1untOV0MG0c1xqH8jsKuL4w+nlBkLNKdPuShMujS+Wqw6ZxybxylIjruyQrqCBAOyPbIa/4kOSGx5Oa5Oco26NbCAvQgh1kyCuck3pEfVdXhyV5NKcUeyS5qzCctMAbujVMlDXe/rrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MNX2sM4b; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7180ab89c58so1159156a34.1
        for <linux-iio@vger.kernel.org>; Fri, 01 Nov 2024 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730499441; x=1731104241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NG086UAVHhHYbTY4/rXpdjHhnow1FtKZ4XRiPy3fDw=;
        b=MNX2sM4bkazFk/vdMUJ5AXplFlPq8T0sNJGR9kfFrQn18u38jXHC7R8Xoiv0Dx6/nt
         5t7WDrPiYxyDKRCdkpGYorZR+hDws3idrpoUUB9zdIiCMCoqcmoilm8UfSSdMlwjj9nr
         FUrj+Hc00y5ML41t7km6XGMAfAamxctv+j4l4cqm1W7TW/E/URKhu224O6UW+8bMTvbl
         xTWg2OVxE1AEvuEnywCAZuVW1BkxXTC2c4lsgzCmlXSPeqZpR8Dr2y+Fm/hs3Y0aS0HS
         cs/uW7UtMaH0kb0vbT72Nmcb/CokP0te+jIb7NGDLLEKY2G7ZwRKa+kgPHgrkEo9cr6o
         Tx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730499441; x=1731104241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NG086UAVHhHYbTY4/rXpdjHhnow1FtKZ4XRiPy3fDw=;
        b=eLeruq9OPoDB7/4mI58PRqh1coZZPELqsX/JQkYcacSkFXQuqOXwg6KUXIOf3mhdE6
         rdyJw0tj36i48+mnlQi8GyiNaKZYB0o9rO/cErH+QDFjjujcZB1LDUaMUX9Lqj+HG83i
         K1Ufy/vyDljnTCBTT1sLAu+tra7uBzryicCaUqJqAkLD2PqMKRwbiqbDwZyDFk9ZrtPi
         So2ZDwCbVkn9WD4E9+1L6OE8Ses48z7ZxRyG3zOrucftIKE6Lj/A/TKsp2mT4E/xJTaO
         +hZbaGGxdtVkhKnr8jUvkJ0K07FcIaNh1a9YH68HKUtGvGOM4OvD6BZojjGlVvVbc3Mu
         4QYQ==
X-Gm-Message-State: AOJu0YzM6P6jUuD9MqkOo7SKxCQh2X/2CzDsOv7OAWv7j6i2cbCVmhe/
	0NECuFV7fsEI3/3OA7N1TYBjU8ml4ANA9Ivn06m5FiiLeYaUCY/lkW2NP5i7y5w=
X-Google-Smtp-Source: AGHT+IGuiRggc/VEOXvy/hqc6GPaEDJwMTU6wKNAh5o/gkpRr3AvH9ZaGnzuQSPoyBxVCuiCZVBdfw==
X-Received: by 2002:a05:6830:4406:b0:718:8dc:a5e with SMTP id 46e09a7af769-7189b4df036mr6875600a34.9.1730499440886;
        Fri, 01 Nov 2024 15:17:20 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec70698049sm789817eaf.48.2024.11.01.15.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 15:17:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 01 Nov 2024 17:17:09 -0500
Subject: [PATCH 2/3] iio: accel: mma9553: use specialized event code macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-iio-fix-event-macro-use-v1-2-0000c5d09f6d@baylibre.com>
References: <20241101-iio-fix-event-macro-use-v1-0-0000c5d09f6d@baylibre.com>
In-Reply-To: <20241101-iio-fix-event-macro-use-v1-0-0000c5d09f6d@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using IIO_UNMOD_EVENT_CODE and IIO_MOD_EVENT_CODE
instead of IIO_EVENT_CODE.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/accel/mma9553.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 43ba04c606a4..8536743a6886 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1031,9 +1031,9 @@ static irqreturn_t mma9553_event_handler(int irq, void *private)
 	if (ev_step_detect->enabled && (stepcnt != data->stepcnt)) {
 		data->stepcnt = stepcnt;
 		iio_push_event(indio_dev,
-			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
-					      IIO_EV_DIR_NONE,
-					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
+			       IIO_UNMOD_EVENT_CODE(IIO_STEPS, 0,
+						    IIO_EV_TYPE_CHANGE,
+						    IIO_EV_DIR_NONE),
 			       data->timestamp);
 	}
 
@@ -1042,20 +1042,18 @@ static irqreturn_t mma9553_event_handler(int irq, void *private)
 		/* ev_activity can be NULL if activity == ACTIVITY_UNKNOWN */
 		if (ev_prev_activity && ev_prev_activity->enabled)
 			iio_push_event(indio_dev,
-				       IIO_EVENT_CODE(IIO_ACTIVITY, 0,
-						    ev_prev_activity->info->mod,
-						    IIO_EV_DIR_FALLING,
-						    IIO_EV_TYPE_THRESH, 0, 0,
-						    0),
+				       IIO_MOD_EVENT_CODE(IIO_ACTIVITY, 0,
+						ev_prev_activity->info->mod,
+						IIO_EV_TYPE_THRESH,
+						IIO_EV_DIR_FALLING),
 				       data->timestamp);
 
 		if (ev_activity && ev_activity->enabled)
 			iio_push_event(indio_dev,
-				       IIO_EVENT_CODE(IIO_ACTIVITY, 0,
-						      ev_activity->info->mod,
-						      IIO_EV_DIR_RISING,
-						      IIO_EV_TYPE_THRESH, 0, 0,
-						      0),
+				       IIO_MOD_EVENT_CODE(IIO_ACTIVITY, 0,
+							  ev_activity->info->mod,
+							  IIO_EV_TYPE_THRESH,
+							  IIO_EV_DIR_RISING),
 				       data->timestamp);
 	}
 	mutex_unlock(&data->mutex);

-- 
2.43.0


