Return-Path: <linux-iio+bounces-19682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB76ABC09F
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E64C3BF2D1
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239BB284B3F;
	Mon, 19 May 2025 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTFX5W3N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DCB284B2E;
	Mon, 19 May 2025 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664782; cv=none; b=q5gxR+O2KkE6BJsmWN9l0ynnvXK/BXu97YVPhAvC11YV2lzFU8ZkFlFE4BDPnS4hNnYPIG8mxOMVqhfHj0YzQFN1mG+v7Iibu0rqaayDWcE6Ut2TA2hzHoWbRUqfpWtkqecAxHXIDkaft73pBE8jiSKZwaUSm6DwBD95PGloDsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664782; c=relaxed/simple;
	bh=9J45HtBubBmey7oBKiVmAPTwwvpT7Y142a0Hwq/B4+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+kT4M28fhUxNfpimJeVcXaqcL5PT5FA6D0YLwzPkz/F96pLheVa/kNAWmvVlDXyMlk6XJWDLYLFX8qfPfJNufpFlaEG3xXd++us4lul2hQVPVUuTrGcjSwc3nAUfiNqCfzPSqo8pvNhlLWe/YFKkmLZCOSnMpNQ0ZIgX0iNQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTFX5W3N; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso4316828b3a.2;
        Mon, 19 May 2025 07:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747664781; x=1748269581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72w6sNIQShW9+z7WOR+nkYITWdJqoFUq46toPD7dMQ8=;
        b=FTFX5W3NiuWbBQwVj4Wml6q9TqyST7nMfWWfc9Bbid4Ftthqr8c28F0rPJttnzvgS1
         aQ7cDoxK8NCRTrltO5ZheJ9YfuDUwz+JCl1OhuNXxHglGD+CwrfRk9ETPXPdAJtVm2Nv
         KywgC1Phftqe6zNbhjIuNMP+JtVwwxD3ZMbj4eGzEybJUe6ME8wJRHSRamzW/nzi05TV
         Isl30UvsYy44+l+8es+C0eijDI9/XbsxdZIOBbF5VLrYS3ZA9GnKaqqgVfmDVw25ANEc
         figvKKTcij4wsvm7ocvWNmZb1mCJcKaiDXziTI4JIquOU60z0ywKLge4DhYmNWWZfaa+
         NHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664781; x=1748269581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72w6sNIQShW9+z7WOR+nkYITWdJqoFUq46toPD7dMQ8=;
        b=iigugAVy+D0Jsgh+zVeQx1bJ6tOsT2mRCtbxLCBBH+DdlTvWK/BAC+5u1PE60qbv9W
         Zj1YRrl8WeVxFcnFAjQ+gVYOinad50PFvV1Fp12LubeRiBHbeMWFZeL3fPp461tZpPBz
         oRFBK+A5Tgvwtj9KHu0D1ylS3iXML8057AQCXcxoR3BqPhPYPUXQ7lIQ7ZMf/eirF8BP
         xu3a/FyLLgyRzp46QvhvOaCqoSiKpzjb9eT7ngYevsSzIxEFV9hvNiGfSGX54vjiVR10
         NyjUuf6IQYxtRhIcIkXKJBdBgJTEKFri36E4hueczvSzq8rwk39Z//1J27NSYBjZXkcY
         1BTw==
X-Forwarded-Encrypted: i=1; AJvYcCURQHe24x0M3xp0LiRe/xP8HC3QoAOyCtEtoDXIqdAv0JFeapKQuWoWER4P9+Cd9k6frUhT68ccowU=@vger.kernel.org, AJvYcCVoD4e/GUiyOtmJTfUslJfxPGpL+Z6gKJDeKoLsHSA6QWyA4kZhCvZ+mqNuSwupx+G7XzqogfNtl+SzBVth@vger.kernel.org
X-Gm-Message-State: AOJu0YwxBux8q7UvskbPWbDyfqZXGrsX8GYRNX9CBQJZP2Xl5ddUQoLy
	9NflDx5Gx4kCGcFrgXzKNGgXe/airD6URF8pNaBf4K+nG3AV6utv/Dpf
X-Gm-Gg: ASbGncvrFdx+rLGbiMCVpI1ulJsSNxGZmPKD/40fjXQXFOXaZFU4Tkw1eTPTYOQO8gA
	5Y8y6V2C+hrR65XM2c3DVQc/loqrtXj4o/vQQjaM4IL3zTdCVhbQl5ORtG3mI6N3j1+WB2crNGm
	WaocBENfUm2JimP4+GEAexqdL3rKTfzrmkJfb+m3PK8cqtDWx3ydN505VYobZjc6coCLooziZnA
	qYatoV8UMKSjVFsMJ8hFiYFp8WeU1ithrUUyDKDccclnHmOqWTktFaUlYxoA88wdzh1u4ZWTzVn
	6QBIADfQ+3IT0sLUSqJI9/EFqRBv3rT1ruIZh+X9ijUVwXFAOD/DISW7Bg==
X-Google-Smtp-Source: AGHT+IFoA1qfvEQtDcQsD+Ns9UkG9OyzBjikf6koFx8PXX6r7HAzxGDdeXp5GUGIGcBI9B9HAkjBNA==
X-Received: by 2002:a05:6a20:432b:b0:215:cf53:6e6d with SMTP id adf61e73a8af0-2170ce19ec6mr20162279637.27.1747664780557;
        Mon, 19 May 2025 07:26:20 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e211csm6465303b3a.16.2025.05.19.07.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:26:20 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 4/9] iio: consumer: Add new API iio_poll_func_register()
Date: Mon, 19 May 2025 23:25:56 +0900
Message-ID: <20250519-timestamp-v1-4-fcb4f6c2721c@gmail.com>
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

This API wraps either the tophalf or bottomhalf handler to grab a timestamp,
based on the consumer's `timestamp_enabled` and the trigger's `trig_type` and `early_timestamp`.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 58 +++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 527c3cf84be0..1a7bab2741af 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -65,6 +65,24 @@ ATTRIBUTE_GROUPS(iio_trig_dev);
 
 static struct iio_trigger *__iio_trigger_find_by_name(const char *name);
 
+/* Only be invoked in consumer top-half */
+static irqreturn_t iio_pollfunc_top_half_wrapper(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+
+	pf->timestamp = iio_get_time_ns(pf->indio_dev);
+	return IRQ_WAKE_THREAD;
+}
+
+/* Only be invoked in consumer botom-half */
+static irqreturn_t iio_pollfunc_bottom_half_wrapper(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+
+	pf->timestamp = iio_get_time_ns(pf->indio_dev);
+	return pf->thread(irq, p);
+}
+
 int iio_trigger_register(struct iio_trigger *trig_info)
 {
 	int ret;
@@ -270,6 +288,36 @@ static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
 	clear_bit(irq - trig->subirq_base, trig->pool);
 }
 
+static int iio_poll_func_register(struct iio_poll_func *pf,
+				  struct iio_trigger *trig)
+{
+	irq_handler_t tophalf = NULL;
+	irq_handler_t bottomhalf = pf->thread;
+	int ret;
+
+	/*
+	 * The consumer does not need timestamp.
+	 * Just request raw irq handler.
+	 */
+	if (!pf->timestamp_enabled)
+		goto out_request_irq;
+
+	if (trig->trig_type & IIO_TRIG_TYPE_POLL_NESTED) {
+		bottomhalf = iio_pollfunc_bottom_half_wrapper;
+		pf->timestamp_type = IIO_TIMESTAMP_TYPE_CONSUMER_BOTTOM_HALF;
+	} else if (trig->trig_type & IIO_TRIG_TYPE_POLL) {
+		tophalf = iio_pollfunc_top_half_wrapper;
+		pf->timestamp_type = IIO_TIMESTAMP_TYPE_CONSUMER_TOP_HALF;
+	} else {
+		pr_err("Trigger does not set valid trig_type.");
+		return -EINVAL;
+	}
+
+out_request_irq:
+	return request_threaded_irq(pf->irq, tophalf, bottomhalf,
+				    pf->type, pf->name, pf);
+}
+
 /* Complexity in here.  With certain triggers (datardy) an acknowledgement
  * may be needed if the pollfuncs do not include the data read for the
  * triggering device.
@@ -296,10 +344,8 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 		goto out_put_module;
 	}
 
-	/* Request irq */
-	ret = request_threaded_irq(pf->irq, pf->h, pf->thread,
-				   pf->type, pf->name,
-				   pf);
+	/* Register consumer handlers */
+	ret = iio_poll_func_register(pf, trig);
 	if (ret < 0)
 		goto out_put_irq;
 
@@ -352,6 +398,10 @@ int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 	return ret;
 }
 
+/*
+ * Will be deprecated.
+ * We do not need to set this as a top half manually to grab a timestamp.
+ */
 irqreturn_t iio_pollfunc_store_time(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;

-- 
2.43.0

