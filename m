Return-Path: <linux-iio+bounces-11745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F7E9B8C3A
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 08:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB86A1C20EBE
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 07:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA18F156654;
	Fri,  1 Nov 2024 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bAVRjLjw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F9A155743
	for <linux-iio@vger.kernel.org>; Fri,  1 Nov 2024 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730447197; cv=none; b=liOnGPHVdiRwpTMqWjLBwwT4Jb5mVYPGsAEo1l25B5oZd+JFEfPUYI0oPBfwWyGf3Ph5qCXnFtxPh9im3v3vJBEVU81gMdsaYjxsx4dbuGZ5K2Fp4EucVIUS4kFxiejEOC1mv9wP1jvZt0JM5+rfHwoMy68dg9Vdvpa7WzIA6Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730447197; c=relaxed/simple;
	bh=NTUbVMYf2x+7q0/8Barwlk+9iZKYWLsfR/svD0SOK6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eVsgRaVakjIojMkOm2dlfhIm1IETM1WF1Yp9SUz1XVcAJavejGlNKT1WRK+8G8Nh5FTVthDlKsFVgx3EKbFJt6BseF4LQ5p3rjV2lqsdoWhXRHPNpenkNNTt2wNTwxPoR0T2XpQXj7BaCQdCDMqM8nkvJbEhjxR91GUr4nEGOJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bAVRjLjw; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b148919e82so107092385a.0
        for <linux-iio@vger.kernel.org>; Fri, 01 Nov 2024 00:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730447194; x=1731051994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQttLL6CFS2JGt87dEF+H1Jt5OZPaXEa5P0U/qvO3f8=;
        b=bAVRjLjwIq6OrclJFJHiLf3srLR2oDUETFEOnAYAgU3GXP//o/56teqera1r/iY9v7
         a4u8uqHgjfZtJ5E9EQxLlXXcqTsX4iBhXtmJ/HjH+i1Qk5akI7Jb35g4NK5i2/8IuOMC
         JJ7dworp/BayRuzjPST2Us4yrSzYx2yqQHbQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730447194; x=1731051994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQttLL6CFS2JGt87dEF+H1Jt5OZPaXEa5P0U/qvO3f8=;
        b=Ct8LJ1PZv5fTP63sQ5ExuIRoVfhKX8Sf8z9BIdJT0Dzz1K1BkUHqICr+ChOureBqiA
         v29BV23589xZZTVKYyqP/Dlt/cgajiZKRoPSbQEAgLtAVFn8uvztKtrZZVN34e9RNnuP
         n2KuaBiRWBMf1siCLUPXPHwcOwgJjDron90/kLY3K0y/v74Apye16It076A+EgF+7Fz5
         YmlIbzcbtdWwQiqpfmaBqrAO3CrwzoMicmV9jO9YUuIpTrrJFbLTiuNgI7lbN4VN/mtb
         owd97H/axtKDjHH9FC/nI84lGmBxUuu1cfDGTi+MIWZGcP1GrABJECREnvLqHbvDK6zZ
         qPVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBNihonSRhPKtXMr9A2b4CVGsK0oK/CRwY0obZyzm/WANAAHJHIpsVy1NOi4MROeLcCuZQAJf/QR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg0tQ07Ou72OLOTjjX5xc01BOlJfQQePwHVr/EL5FbsnexnIpE
	pwTGtB8734J7q+uPNlQxM+R76b5+zgGkcA3NEjnyn6drspobnol2iJmMUR8mug==
X-Google-Smtp-Source: AGHT+IENVEkusl1Ou+3L/NJxmVRgnRFcmI2cch41SDweq+Sq+50us7wvB4RBAe0Eo6+OmdWlgyVR8Q==
X-Received: by 2002:a05:6214:5349:b0:6cb:eb66:c37a with SMTP id 6a1803df08f44-6d351b4a825mr53516406d6.53.1730447194314;
        Fri, 01 Nov 2024 00:46:34 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415b1casm16444236d6.78.2024.11.01.00.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:46:33 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 01 Nov 2024 07:46:28 +0000
Subject: [PATCH v3 2/5] iio: hid-sensors-prox: Factor-in
 hid_sensor_push_data
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-hpd-v3-2-e9c80b7c7164@chromium.org>
References: <20241101-hpd-v3-0-e9c80b7c7164@chromium.org>
In-Reply-To: <20241101-hpd-v3-0-e9c80b7c7164@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Harvey Yang <chenghaoyang@google.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The function is only called from one place and it is a one-liner.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/iio/light/hid-sensor-prox.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 26c481d2998c..d38564fe22df 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -153,14 +153,6 @@ static const struct iio_info prox_info = {
 	.write_raw = &prox_write_raw,
 };
 
-/* Function to push data to buffer */
-static void hid_sensor_push_data(struct iio_dev *indio_dev, const void *data,
-					int len)
-{
-	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
-	iio_push_to_buffers(indio_dev, data);
-}
-
 /* Callback handler to send event after all samples are received and captured */
 static int prox_proc_event(struct hid_sensor_hub_device *hsdev,
 				unsigned usage_id,
@@ -170,10 +162,10 @@ static int prox_proc_event(struct hid_sensor_hub_device *hsdev,
 	struct prox_state *prox_state = iio_priv(indio_dev);
 
 	dev_dbg(&indio_dev->dev, "prox_proc_event\n");
-	if (atomic_read(&prox_state->common_attributes.data_ready))
-		hid_sensor_push_data(indio_dev,
-				&prox_state->human_presence,
-				sizeof(prox_state->human_presence));
+	if (atomic_read(&prox_state->common_attributes.data_ready)) {
+		dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
+		iio_push_to_buffers(indio_dev, &prox_state->human_presence);
+	}
 
 	return 0;
 }

-- 
2.47.0.163.g1226f6d8fa-goog


