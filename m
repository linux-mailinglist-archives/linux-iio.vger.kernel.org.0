Return-Path: <linux-iio+bounces-11704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED7E9B7E64
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 16:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 224C1B22EE6
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 15:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9D11BBBE0;
	Thu, 31 Oct 2024 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eg+hRmOE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557971BBBF1
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388440; cv=none; b=eKB5Zb6T3orpDT7TPBBDT38Ow2/ADW1Folskux3TjRTXW203qYfzAW5tAazFaSaifjFzwh0hx0VFYy0gtysgd+RELeAVwJuy1MFqM7yzUQG745GA6YrdlTdE62wuxwPFpOfT8oZq/1q50mW/M7wboyOwj6/Q/kzoTR7gAFIYwDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388440; c=relaxed/simple;
	bh=66ZxtddfwLUrZfVWDUy855V73GaqhvBsIS8BnX4bHQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ud/iQDT/SYyCijqI9TSkxno+QumM5yCJPZbkPC0JoT+tp8jp1EjkmL+4GfbrTkiRJOTWPFsNPSe2/3gOKPTpVF1FvnDdit6YGVEwMoo6OmFVU4zQTwwMomYzoggOXZgtDbRDJmwaIH4BDLYgruekbO6HTPUYS7+ygPa75NguWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eg+hRmOE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43169902057so8738535e9.0
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388436; x=1730993236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGlZIwMvz6c7bRFXG/zclkCMmlIDWe/JH5j5KVgG3hQ=;
        b=eg+hRmOEr++M7P4bSWMJLSoog3cNkBJQDvDjKXsHFmpkNixAVvkpFSWY9rgybiegJr
         nqnhvmTE/FuWEkFcgUqJUc+k6NihJu7dsW1AkocrpSaGqU2p08caWQ2tzedFCynQHt3F
         Pi+hPs59TD1n/NjIIMCT7bEqibiHNuFQLE5dT15YVlv3kR/pCHq7sNxXtSCgI/59n0Xk
         fqoQd2eKYiCnMOsrUmv70JTKe11HKHURLSdLce7ReYe5nBpeP4eiLzTYBD4Xwyj6AqNs
         B2I2xCl5JBTrQ6zlSuFpjlKJKN/7Qor3UodXKvRVEGcSqskklUZibofX3zOUezvc98WI
         nV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388436; x=1730993236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGlZIwMvz6c7bRFXG/zclkCMmlIDWe/JH5j5KVgG3hQ=;
        b=Y5eEA17XMWlpZzQ6izhj6oEc9iAHHpRR6Iogy8y7nCoSi6q9reWKdJPy7cgNJiQiN/
         Uw1NeBYq6VpEKiEKjBUPPbASvt5Y8+GSCCd8hfUcWzf4XjK6oi3Jxm0YqxHAFvbpOh78
         /Zfk5FguksxOQYwIDCxvnwQ/GzcacJxfWnIzR0EHf6JaEAvBU2bmY6Q3hpgBDk5znynX
         XMTcNS7dBVEmOYTVK20qLOeqYrRAEWlX5/IhafHc7RcC+7sv0rCdM1iIN/k8Xkm1Hqvl
         PRfO1HtfsZZ4YNtiRdvufqHJslLsCtidRrR1lR4GlsEIPo9NY5etS8fdwxkjmweNkbtU
         6a0Q==
X-Gm-Message-State: AOJu0YyDlNY1aJ7BTK0qDw0nhPN91fBTcugXv3wK8U7XDPhNnX6EaXvc
	ei6Z7EiAAlkZ4+4yH6Va9o2yg0MSDM/9A6vz6HOPLZfZ/iK/XRO0+5sV7s7qlBI=
X-Google-Smtp-Source: AGHT+IHlxC61R96I9SqIUQT7uQ6GYz6mwcgP7vSir2EsAglaq5XnaVblxKW0wQCsPc9q6MdamJ1CIQ==
X-Received: by 2002:a05:600c:458f:b0:431:5ed4:7e7d with SMTP id 5b1f17b1804b1-4327a82f755mr47859695e9.18.1730388435648;
        Thu, 31 Oct 2024 08:27:15 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:15 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:27:03 +0100
Subject: [PATCH v2 08/15] iio: accel: mma9551: use bool for event state
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-8-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
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

Since the write_event_config callback now uses a bool for the state
parameter, update the signature of the function it calls accordingly,
and use a bool array for event_enabled.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/accel/mma9551.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 605022f5239a6412827f4ba059aa18d490908720..6d73eec951263956f314f82542becbbae933de91 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -45,7 +45,7 @@ enum mma9551_tilt_axis {
 struct mma9551_data {
 	struct i2c_client *client;
 	struct mutex mutex;
-	int event_enabled[3];
+	bool event_enabled[3];
 	int irqs[MMA9551_GPIO_COUNT];
 };
 
@@ -162,7 +162,7 @@ static int mma9551_read_event_config(struct iio_dev *indio_dev,
 
 static int mma9551_config_incli_event(struct iio_dev *indio_dev,
 				      enum iio_modifier axis,
-				      int state)
+				      bool state)
 {
 	struct mma9551_data *data = iio_priv(indio_dev);
 	enum mma9551_tilt_axis mma_axis;
@@ -174,7 +174,7 @@ static int mma9551_config_incli_event(struct iio_dev *indio_dev,
 	if (data->event_enabled[mma_axis] == state)
 		return 0;
 
-	if (state == 0) {
+	if (!state) {
 		ret = mma9551_gpio_config(data->client,
 					  (enum mma9551_gpio_pin)mma_axis,
 					  MMA9551_APPID_NONE, 0, 0);

-- 
2.47.0


