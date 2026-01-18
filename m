Return-Path: <linux-iio+bounces-27926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D69D39907
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 19:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EACD3010FD9
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 18:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBED1E9B1A;
	Sun, 18 Jan 2026 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg75V1Nx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63A2FFFB5
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760431; cv=none; b=RyPdsA41L+fGIDfpaRTXzJ8tAoWBaohoL6ukf6mm3Xi31kz+ar/TRycv3hZVhJL+UskIwMaLOIbs80M6Fqs3+C8hYmKUKipX5qWRvU7VJN6guNYg5YKKFzIzZ2mibjxk23mamS33gFFbirb7WJmqVQiQ07xKYtOl5FqjsIJ6YEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760431; c=relaxed/simple;
	bh=Nx2BxfukcgbNMTsAdjO0ux+H8cRidzYXyK9d4V1n0mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5lgOfciKl5s3Bs8V6gBMVXAZAWX84onv5REsNTlTD70mp496ftXaAX9yLM3iw6hyMIaRj3Su7mIUKEdhYyzy9hViK8BVQaM5j+7I1RM8t+NnZckn8h+CvJEC6LeDaGlWErdQxcfyrnDU8KpBPZ1FqVJMJjhbg+Qu8S7dtAMOZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mg75V1Nx; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1220154725fso2703821c88.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 10:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768760423; x=1769365223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8oTH4L6k5lmuFdK6+K3XHyFIuZENoBfyf7y0hnUZr4=;
        b=mg75V1NxXDlUuWprphBTeBFuDW2bFyxMZ7fAS2n59oxEXCtaOQ2SuYbYryua60tUA4
         dPAY68iwfVllwItlhe3yNyDRxU4udTT1Kq07rHRn3IRE1+YX6desNQfvrNuM8e4yd0IC
         jidsbbWpnFIGUyIIfX8PwcHES40hMCtTDtTwEY+Va7ubI7JKggsIgvfovWmMtwzo676b
         TnC5Gq7m5vOuGt65X4FbLd5LxylHal+j6t0Uo03Xs1ctTPwHp/sHjgoPQ1yJOO4I0Qbh
         vZie1KIflfPxsDc9sdb3PM6CdFi46rqKkSGG8hgMkQIK5uhmd8/TGPZdaHtsBULPPD93
         rVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760423; x=1769365223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8oTH4L6k5lmuFdK6+K3XHyFIuZENoBfyf7y0hnUZr4=;
        b=EO86MvARZTBNs8c7Yh9omNdXHKgVYJnrG77c8Qs7R5i2kDPondMox59cNwmFhOnqN6
         Fblc9n07/cy006Ppx7NLxnebo/d/jl9ETGxSPa1fymPX4l2e3X0gYPpdtV2dEug7O4yh
         RtBeIv5vgn5Eew1DBwxBFIPQKlCt2tlZIc186DmLllJI/yVMwHwp6ilspuxNqJBLARvG
         kb/EYZxmU+UHP0B77ORLSLJcQDrvQG94aBre3wFaPlZwKIuJMUebAEAIll+kiWHEO41s
         X5l/SN+1ZXMoREzBqqLqde2846aqV+T09IQCRN/jo93AJCDB07kYCOtg3lMpGi4TEcmo
         BcLQ==
X-Gm-Message-State: AOJu0YyfUJNFvKp9LQCwFe/A8b1WGB778+V+ZaW1ipm3yWXu6w4JQo5A
	PrpAyr4PHnzc12LqS9/WUTV1vNECEe6rgvwOVnmq5k2iOboHG+zWuD6FcKxIn6r9
X-Gm-Gg: AY/fxX4xqHvCKNL6beadjs/m/00X55msZHj9lqy2Ea4vVzh98eLFgxdhCfgVmlbVUTk
	Gsi31Vo9HoagggsTLqmOiORJUWkbdSKBm6+OWh6TQcq9zCvQrNsnERIZiYR7cBeKJyfLn5ThK5k
	pOycMaGgUg4ToWAYt6GBcrpaElkziIJfxvZCBucZSrPZWKNGzFboNM1PyAvF0KQZ/DUoKn5WRvq
	u6KFpb+wMNn/CtNEy0j1denN3qeGC0EaVlydJJq2iESWvTgkEOBDjMBZ/Hp7sc/FOdmSBi7jeq3
	RRHXuelMVIu239OWj4oKC6vmv0a65sAUpLo4RhVlifgxRciyGFlh/odaCFDBYgMEU7bGWEeqZde
	ldm/I9NsrEuu/7wT0TF3V91xuT6MacE42z733N5dG/m0hi3eewKChFRrhIzRtUzNH5ObnrSfVn6
	9/VR2yrfb+1YEtMF5m7R4=
X-Received: by 2002:a05:7022:e98d:b0:11b:3eb7:f9d7 with SMTP id a92af1059eb24-1233d0adc11mr10868872c88.14.1768760422721;
        Sun, 18 Jan 2026 10:20:22 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac6c2besm12775573c88.5.2026.01.18.10.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:20:19 -0800 (PST)
Date: Sun, 18 Jan 2026 15:22:07 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com,
	andy@kernel.org, dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Subject: [RFC PATCH v1 8/9] iio: dummy: iio_simple_dummy: Update to event
 unit expanded interface
Message-ID: <40da257176192dce3b271c45b6ce7dcaa15b06af.1768759292.git.marcelo.schmitt1@gmail.com>
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768759292.git.marcelo.schmitt1@gmail.com>

The IIO events interface has been expanded with an additional parameter,
enabling drivers to handle values in real-world units for IIO event
configuration. Update to the expanded IIO event interface.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/iio/dummy/iio_simple_dummy.h        | 6 ++++--
 drivers/iio/dummy/iio_simple_dummy_events.c | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy.h b/drivers/iio/dummy/iio_simple_dummy.h
index 8246f25dbad0..a1132781c0bc 100644
--- a/drivers/iio/dummy/iio_simple_dummy.h
+++ b/drivers/iio/dummy/iio_simple_dummy.h
@@ -66,14 +66,16 @@ int iio_simple_dummy_read_event_value(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
 				      enum iio_event_direction dir,
-				      enum iio_event_info info, int *val,
+				      enum iio_event_info info,
+				      enum iio_event_unit unit, int *val,
 				      int *val2);
 
 int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
 				       const struct iio_chan_spec *chan,
 				       enum iio_event_type type,
 				       enum iio_event_direction dir,
-				       enum iio_event_info info, int val,
+				       enum iio_event_info info,
+				       enum iio_event_unit unit, int val,
 				       int val2);
 
 int iio_simple_dummy_events_register(struct iio_dev *indio_dev);
diff --git a/drivers/iio/dummy/iio_simple_dummy_events.c b/drivers/iio/dummy/iio_simple_dummy_events.c
index b51ec21b6309..9dfccc6439d4 100644
--- a/drivers/iio/dummy/iio_simple_dummy_events.c
+++ b/drivers/iio/dummy/iio_simple_dummy_events.c
@@ -120,6 +120,7 @@ int iio_simple_dummy_read_event_value(struct iio_dev *indio_dev,
 				      enum iio_event_type type,
 				      enum iio_event_direction dir,
 				      enum iio_event_info info,
+				      enum iio_event_unit unit,
 				      int *val, int *val2)
 {
 	struct iio_dummy_state *st = iio_priv(indio_dev);
@@ -144,6 +145,7 @@ int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
 				       enum iio_event_type type,
 				       enum iio_event_direction dir,
 				       enum iio_event_info info,
+				       enum iio_event_unit unit,
 				       int val, int val2)
 {
 	struct iio_dummy_state *st = iio_priv(indio_dev);
-- 
2.51.0


