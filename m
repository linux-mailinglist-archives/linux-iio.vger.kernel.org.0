Return-Path: <linux-iio+bounces-9704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B09A97E271
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 18:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53F2281304
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD772339AB;
	Sun, 22 Sep 2024 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfC7q5qI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EB928683;
	Sun, 22 Sep 2024 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727022054; cv=none; b=ERfsWCCp0AwhPcY0kD0xndPJc0+uEpX3CgyfmvuFAtYU+ySRqGgqxxarGerTyFeTrvLDql3QkgLT0GWz8DAm9Hcge4+/WsTKNtRzgopOBssKGqgyh/xCOuJSXan6xIWH60FeWek+g+KIdfK1n3Q8+mhxkO8gJ5lTQ2DzSu3Hr98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727022054; c=relaxed/simple;
	bh=cXmEY9dZWA53S3l3c1iklwSAeE8snbgR1wHS2LgirSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eSJRCLC+jqorBb/bI4ORxXa41NsYdgNFbsDB1tDE47m0ds6HH9fONRvagjsiJjbvxkEzUU1pUm1PPfM4e5JfLDkrCArHDdvVLmJYMtd1a7wyjXURgDRYnShz5XUJ0tYK6JYxqB2QY//Mc/JA16n86KFg7MBQnP9NDNWIMY8Yk9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfC7q5qI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so27729235e9.2;
        Sun, 22 Sep 2024 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727022051; x=1727626851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqB2cHmlKDTiUxg67u2DrxaLXAyKOwFS9Hm6s6rWktQ=;
        b=QfC7q5qIVLoEp2eXELFU69KK5TEveY0eqwpwNyFNXpF2zCkvgbM3HtSelSWoofAAuK
         1mtHASHdoT0wTe6DffsF6hbPD+RcOAGW9CH04E+1u+wQ90q7qVszeINcNvD/hKoYTO7H
         LSsOzTTVwGD8n6cbzXXPJMUZxQoePI12kljT3NyNWUf+yHUvd7P4pHyIcPLehVktCY5o
         o1KWOQA9t2eVc/VMcuJPnLqtBGNeOExvdhOflGo1GxE+LlSDnl5yhZgbxG78SiYEPM9x
         RBYcuT5BU+7OsgxuCUm4GjB8FDnKxQe9wcStNa9ltzreAOjdJu4BtLfU3VZQOuMPTqaq
         DY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727022051; x=1727626851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqB2cHmlKDTiUxg67u2DrxaLXAyKOwFS9Hm6s6rWktQ=;
        b=Fp+jwBdd0GtORMjOgN0mmNTt5mVAnHgvAqWfqYl5NUqaqhB0byWvHSow7SSjlx4+C7
         PInfpCLAFb6l7zVjqWDnJawBM6OIF4Yg0O4eHUiike25btZJZ1vh0ZLZYSy7Scqd1c57
         vhImqrwCv8LnZagMKvK+DMbaST6FbtfTdq9zmcYPA4G+s5IzqCX/xZ/BBkv/uNIZhXp/
         R0sc41U4yGfZQcdDggSx2MSsM/cWQ8HLbtprVIUXbMYSU/qUUYuytdTslhBghUKIv7l9
         szEEimuvFchFUVNnedo2KxaRTQ+iFpvaspr3qFfXzGeFdp8e/PIUziuSpzZKCvBss0L0
         yvPg==
X-Forwarded-Encrypted: i=1; AJvYcCVF+VgUomhMRv7jUvpJFiszCE+Ay+ScJPdQSSHHSaPDOrjk1GnK4M7Oi0oyCxiee9xxkzdNq4S+SzdLXufP@vger.kernel.org, AJvYcCW0nSHtTK84gurHSffMXc8zRXMuUY04Ol8yQG8JKidbBYB1ni8VwhQ7S+QoQ1b/Un6hwNWQsQaim4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxBCbqo5BsL1r8wcG+k5wjjepwKsQAIzjK7f8TIgwM1i3IMm3/
	NmngKjfYIN9R4j2mXEqzMcSHZrrLVD+p9pRV7/NuxKeuHvscGF1l
X-Google-Smtp-Source: AGHT+IHU9iElYWUCW4iIIagtb/y6yTklM6puZPDad1jDa/kBBI8YnBsVF+pmMxeTux/kd09PQlQNtQ==
X-Received: by 2002:a05:600c:1c04:b0:428:1b0d:8657 with SMTP id 5b1f17b1804b1-42e7ad8e706mr67269765e9.22.1727022051084;
        Sun, 22 Sep 2024 09:20:51 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:7367:3ea8:c47e:88f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754c6dbcsm104566485e9.46.2024.09.22.09.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 09:20:50 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH RFC v1 2/2] iio: light: rpr0521: Drop unnecessary checks for timestamp value
Date: Sun, 22 Sep 2024 18:20:41 +0200
Message-Id: <20240922162041.525896-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240922162041.525896-1-vassilisamir@gmail.com>
References: <20240922162041.525896-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rpr0521_trigger_consumer_handler() is registered as the trigger
threaded handler in the devm_iio_triggered_buffer_setup() function.
This function is being called in 2 ways:

a) when there is a registered trigger being trigger like sysfs or hrt.
The call of the trigger handler (which is the iio_pollfunc_store_time())
follows which saves the timestamp and then, wakes up the trigger
threaded handler.

b) The irq handler is using the iio_trigger_poll_nested() which wakes
up the trigger threaded handler.

In both cases, the pf->timestamp has already been assigned a value
so there is no need to check if it is 0, neither to 0 it after
the push to the buffer.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/light/rpr0521.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 56f5fbbf79ac..ae6a22b91b8d 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -446,13 +446,8 @@ static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
 	int err;
 
 	/* Use irq timestamp when reasonable. */
-	if (iio_trigger_using_own(indio_dev) && data->irq_timestamp) {
+	if (iio_trigger_using_own(indio_dev))
 		pf->timestamp = data->irq_timestamp;
-		data->irq_timestamp = 0;
-	}
-	/* Other chained trigger polls get timestamp only here. */
-	if (!pf->timestamp)
-		pf->timestamp = iio_get_time_ns(indio_dev);
 
 	err = regmap_bulk_read(data->regmap, RPR0521_REG_PXS_DATA,
 		data->scan.channels,
@@ -463,7 +458,6 @@ static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
 	else
 		dev_err(&data->client->dev,
 			"Trigger consumer can't read from sensor.\n");
-	pf->timestamp = 0;
 
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.25.1


