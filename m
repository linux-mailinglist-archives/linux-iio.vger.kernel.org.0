Return-Path: <linux-iio+bounces-11746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A29B8C3D
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 08:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4B7283BBE
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 07:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9E4156F36;
	Fri,  1 Nov 2024 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gkkdo5pp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB815624B
	for <linux-iio@vger.kernel.org>; Fri,  1 Nov 2024 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730447199; cv=none; b=WbLRXJWL0v2s8kGvTys2u8RgvifxxQKO+/dJpAE1blQk3bCOBTblapiSM4iAZJHFtCSEUbz0213J/ciD3Zrc9ahWf7xZ0Siv0ZktOqUP2v7G2aKss8I30leDOJkCzXjMtyR9Zi3xX5zH6OruGDS5Cpo7AQ6edWVmF7NCkPB7dkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730447199; c=relaxed/simple;
	bh=73w3b7JtSEWNTPdgJOVen0HK9Np++vEeWqSGPZeIaFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K75rT4K8xu8vWridxty5TUaNZ/Q9JAW0xFfFmcIPwUQVI+8VzniOdSpoXXaAJxTpfTfQYxo3IdXcKJ7z6TC4cVGeI9AOnFbIs5RNCUvPZNGzSjm3Su7UXkoe5lvvOr5kJZqPxYJVZLSEBtH4Tp1K4g+79RQK65pxAzc3cl+Wang=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gkkdo5pp; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbe53a68b5so10812176d6.1
        for <linux-iio@vger.kernel.org>; Fri, 01 Nov 2024 00:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730447196; x=1731051996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4sqTZZzA2b6pzzAnRcujfuXMZvPt6ZPxVHrY4eCstI=;
        b=gkkdo5ppb3jYjEaX0TTPblsDiEiGVtiRGxU28NZWcMGCKi90xfwJ/LYCSNdQdVm264
         KJlqk+yCyo5QmjUmyXrlqloN4LnKEOk++QWEz1W0vN9fDsQ9eqAvcOnIJDyHhFXO+zyk
         kQbTfWv3HeRz6xcDJnW/vlDt6WEUp+gLU682w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730447196; x=1731051996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4sqTZZzA2b6pzzAnRcujfuXMZvPt6ZPxVHrY4eCstI=;
        b=U5Vym4yTXwwOjepss+rBRJtTLSW5hheDbAkyPl9AS17URvLm1O1ZlRtlqW5B1HLWpq
         8zjT5uKGog0KHZFHp+kVxoS7qF9RRKhSdqx3AHcyZeclr9JtXKF5N7+ORelIOVodeifo
         UzpHAIGnAt8E/Klwy27Kl+u9S+pW7mw7glvyGspXWI2ojFrNwO7KqXLCmJ3WeXSGJ7Sb
         n5tsU/rDVB3EfPyXvjh7BGKYQCf7FUoxDZ1KguyCJrcCUasrPNW5kNlBVkuT11US+Rm0
         66sSI9HCV9cO/zmGm1B1JskhaxjgjItVi0vdNZygbOjYGU1J0djUBZp01hjfkpbYh89S
         Re1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLfgsCuNQHSC7KEGxsJSwa48uyokLrq/gxF0MrZhuSZlk5q0sstnoKi5YSOsc22ZRKxl773JkeySQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2CDtQN9XncMvW3TlIMaZREidzBWLs/2BYZcpkVQYk+s6fTKO9
	dG3jtNPhl41AHvCmrOAqPTbpqumlV6gQVOb/N/pUPjDMlmcn/YBZe1w0EslA0w==
X-Google-Smtp-Source: AGHT+IEK+Q29KKRscRDFWSFOW8VroT77GOOZqRsyDMfuqCz0jVMvhTUDjno7cSdqo2AaKKLEGEoQKQ==
X-Received: by 2002:a05:6214:3209:b0:6d1:7271:4005 with SMTP id 6a1803df08f44-6d345ffff07mr109827896d6.23.1730447196489;
        Fri, 01 Nov 2024 00:46:36 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415b1casm16444236d6.78.2024.11.01.00.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:46:35 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 01 Nov 2024 07:46:29 +0000
Subject: [PATCH v3 3/5] iio: Add channel type for attention
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-hpd-v3-3-e9c80b7c7164@chromium.org>
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

Add a new channel type representing if the user's attention state to the
the system. This usually means if the user is looking at the screen or
not.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 tools/iio/iio_event_monitor.c           | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 89943c2d54e8..ab546fe3fa36 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2339,3 +2339,11 @@ KernelVersion:	6.10
 Contact:	linux-iio@vger.kernel.org
 Description:
 		The value of current sense resistor in Ohms.
+
+What:		/sys/.../iio:deviceX/in_attention_input
+KernelVersion:	6.13
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Value representing the user's attention to the system expressed
+		in units as percentage. This usually means if the user is
+		looking at the screen or not.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 6a6568d4a2cb..bdfb51275b68 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -95,6 +95,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_DELTA_VELOCITY] = "deltavelocity",
 	[IIO_COLORTEMP] = "colortemp",
 	[IIO_CHROMATICITY] = "chromaticity",
+	[IIO_ATTENTION] = "attention",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index f2e0b2d50e6b..12886d4465e4 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -51,6 +51,7 @@ enum iio_chan_type {
 	IIO_DELTA_VELOCITY,
 	IIO_COLORTEMP,
 	IIO_CHROMATICITY,
+	IIO_ATTENTION,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 8073c9e4fe46..ed9a677f1028 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -63,6 +63,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_DELTA_VELOCITY] = "deltavelocity",
 	[IIO_COLORTEMP] = "colortemp",
 	[IIO_CHROMATICITY] = "chromaticity",
+	[IIO_ATTENTION] = "attention",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -183,6 +184,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_DELTA_VELOCITY:
 	case IIO_COLORTEMP:
 	case IIO_CHROMATICITY:
+	case IIO_ATTENTION:
 		break;
 	default:
 		return false;

-- 
2.47.0.163.g1226f6d8fa-goog


