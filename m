Return-Path: <linux-iio+bounces-19683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BAFABC0A1
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC681176631
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E792853F1;
	Mon, 19 May 2025 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdGpXOaq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D2284B4B;
	Mon, 19 May 2025 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664785; cv=none; b=OplUmRJPA9hbU3niZM/mYVlRhlGZGGNrHUHlof4reJcNg3JMTwd3nplihsDk/4Nu8borqlv1qVWxoRu74LpA7kpKruw4vEWYTiIzR3aLXr4URObcHfZcorAezzUSApEByCnAgJP0PmWZx5Q/TOQOSmnG0uarmFFSmz0Ujm4D3fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664785; c=relaxed/simple;
	bh=lS/HUz45oQx+9z2eaRmHfIfkvPWTLAB+/fytA1bUjG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jyLvWbhlFFDTqpU/m31XBOQ42lUP6ANK4FvYH8nJVQDhfEwV/5aSp+vM0sqc+dp1sAUCemQtXNz9FsplEf5GshFwLKIzwLma7aiaqyMYg7Im8H/wd5DFz8LtFln5XNLqJeoqHAq0w16TBmkBnq8zjL9J7fQoCBjmMuNQI6SEbfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdGpXOaq; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74068f95d9fso4014248b3a.0;
        Mon, 19 May 2025 07:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747664783; x=1748269583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EA/lIxRtTaYgwRnB6DUO1QwQzE9WOnzeg19F8rZeoAA=;
        b=PdGpXOaqJuX6w9gArPED6M0RlKCr2wow9xogZW579uXRvzAkqDUiEIvXeO35Zfr6yv
         QhzQwdlPCS+1bzs1tNpk0uc23pzRV6nUA2dOZYwG+S8U6Hc6y0e3Tsmvc+ARVw5JbNQC
         /oOb2TMKzWAX7mqFhZ3Py8jum6KUV21UdT/BiVwREGOJM4L6B0JPM9OKyYexcHcggcTk
         G4lE40IYoL9jbmWg/d3ASS3dWxN5lYRhk+gBpXdqH3teyoxbk9uD4F+9HEKjmKggl/qG
         ZWdYq02qUb4ZSDdb1Qjq7IhxwU1d7f95YivcBdhcECpMy20FGPwdf7N9hfy/fr3pWp3d
         BaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664783; x=1748269583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EA/lIxRtTaYgwRnB6DUO1QwQzE9WOnzeg19F8rZeoAA=;
        b=cQc3srDoNhbKX5zPlWi6PqX4HeHZ+JrLqyuoQFKs0cF2bZzCvxtFqntWQ1m74xADiI
         vL+PVhy1sTKjHZDJmINFg2jH9qCWBogDgQ8BfYJmRGY4EjZZ8AjFGLO64TWgBnJIrEl3
         9K4vg58xTT2/sw0m6sbqoBd0SVhEX3cL/4obJNNnbxGm+2yNJ6eV4WRmxep/c1czj+EV
         bQ0UGr8aiPg1ywIV1iKsxbhsSK0hz7nFKDOQSe3cETL57I1IycrbejD7tUCT/35E70qD
         VGGvQosBKAygMBXdraNQdyPAl47g7fXCNs48y9lVvEYQXIgHwQ/yI1RaHft0y9rJ1qgC
         dskQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJvPVEdrwuE0tcaQJFuEIYpAJUaS1+sdybZcCJgotcRPsNBa1zmoxFVsdgJY+9edsC3L8n2YFSR/coj6OX@vger.kernel.org, AJvYcCXavhzZSNKdmwz91eeo/iFmR/T+FjB/FboiaAtpbgiyB2aLLJ/M9gTUO31dPY+z8HgqH51tnVXMNJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYLKVtzb4vnlAX4HlLV0ADYbueDoWH1TfBkTMIJx3Z2JHawUZg
	BNxWtv9SIn86NuLZ8NwD8NULrWaydWnIuvJYAsf0whK0jnZLFvREreI5
X-Gm-Gg: ASbGncuR+akFhaYsGyxZICi5ThHg2QWCSY/dVYElaW29q1i5jC63Vmt8hhEq8Ysikae
	HbIkG7FXMwcIp/NcaWYYJOMyKTsoojixp4MaPKfIFSV59iDMpJkEAe8DWTOtIZ7slJ3TOiB6IMY
	WEhqSmS7N4XQRMceRoJc+9H6Btd4Up/N2vulWLKnRYZCd2oOtdi5YX4FIN8qhgzcVAcsUF+llst
	RQwumAdV6jgniWqpYVwj7pwXjZeAnDnlFY488Dz6dRo/RGMnFFT+pgWaZWL5zRTQVYwXHrVWxnY
	2v5iS7rQkV9Nv2fhNOqyljOMQzhWvWW1MsTjZ9qaep/nI/+KOjc7T0q9Iw==
X-Google-Smtp-Source: AGHT+IGkFiDQ5bFXMe7ArKrN+3W0Jtx7TMgPz45kogXhfnRdGYIpduCE80798VLlxvnsMymGc3UhdQ==
X-Received: by 2002:a05:6a00:4106:b0:740:9d6f:a73b with SMTP id d2e1a72fcca58-742acd509c3mr15131986b3a.17.1747664783046;
        Mon, 19 May 2025 07:26:23 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e211csm6465303b3a.16.2025.05.19.07.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:26:22 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 5/9] iio: consumer: Add new API iio_pollfunc_get_timestamp()
Date: Mon, 19 May 2025 23:25:57 +0900
Message-ID: <20250519-timestamp-v1-5-fcb4f6c2721c@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

As the timestamp is automatically grabbed,
the consumer can simply read it using this API.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/industrialio-trigger.c   | 6 ++++++
 include/linux/iio/trigger_consumer.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 1a7bab2741af..d6b0e1ec4153 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -398,6 +398,12 @@ int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 	return ret;
 }
 
+s64 iio_pollfunc_get_timestamp(struct iio_poll_func *pf)
+{
+	return pf->timestamp;
+}
+EXPORT_SYMBOL(iio_pollfunc_get_timestamp);
+
 /*
  * Will be deprecated.
  * We do not need to set this as a top half manually to grab a timestamp.
diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
index 213cd8560518..279c88cae675 100644
--- a/include/linux/iio/trigger_consumer.h
+++ b/include/linux/iio/trigger_consumer.h
@@ -65,8 +65,11 @@ __printf(5, 6) struct iio_poll_func
 		    struct iio_dev *indio_dev,
 		    const char *fmt,
 		    ...);
+
 void iio_dealloc_pollfunc(struct iio_poll_func *pf);
+
 irqreturn_t iio_pollfunc_store_time(int irq, void *p);
+s64 iio_pollfunc_get_timestamp(struct iio_poll_func *pf);
 
 void iio_trigger_notify_done(struct iio_trigger *trig);
 

-- 
2.43.0

