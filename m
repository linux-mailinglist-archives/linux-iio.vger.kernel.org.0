Return-Path: <linux-iio+bounces-11823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0669B9ABE
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 23:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9341F21F3B
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 22:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390631F12F9;
	Fri,  1 Nov 2024 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MmQKJi8n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377821EB9F9
	for <linux-iio@vger.kernel.org>; Fri,  1 Nov 2024 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730499446; cv=none; b=PUEj7URdSFY4NF2/+fh6hTym1pRH598uJyLxz15jm+b1Zf7KC91SjKKkXfOzhvZ/62CcQ0STHa/abPObMdT4zn17DAX0JW6wEkt01LTHql3sKzzUSqS58TwqNYepSGBjqlu/tro19zq5nef9HDvM096omVjE/HY5ymEZKTNFc50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730499446; c=relaxed/simple;
	bh=howDg03PUqT5uHKdURne7uP61TjoAOHxS8hGuGevvVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A32Dju34A5ol86EKHNrGaauxmz/WItomTAHaMiAYcDiTXZO50tJ9Og2sQieZ+TeMraTyaUwDVB78UTCdQoX6dNHwJ32benWaUHi+gAi0qXDXwI67VtGNFbbEgHMESy1ekjri2QJy9rro1i+A2byN6rcfjBphb23Em/2j2vEmH7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MmQKJi8n; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-718998df806so1215106a34.1
        for <linux-iio@vger.kernel.org>; Fri, 01 Nov 2024 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730499443; x=1731104243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5Y1tvObaqLtYvvCPOD8mS69Ek9mYQwEF5EMFUWXabY=;
        b=MmQKJi8nIJpLcpBz+K6jwSaeBBtOIw/xPY5q/R6ClpR9Cws5eSGT5o4qyxTrCyZJEd
         +YmYst5qZd4MetlcQu+332IXj3dTfIs31oXx403HwmfJYJkAm1c8Conn65MHHX7JVQ83
         3c4mj/f4T+RMgaitEum7Sdp/mS5Pa9eWtgZxrbxTyMVUMI5P5gVgZNOSt1ZUZN5I0eUy
         hfG97IhQZF/i6fV9H6JI4aIBBuGM3CwJKw/bb7G/ymqBHewbNANjh8TdEFMpvdzvRmUG
         YaYs69+m7efsKPQYvJMCmbirCSFFzYriKX3zLRuCJK+BOU82fypGX2Ynw60fclpJ3vS1
         3lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730499443; x=1731104243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5Y1tvObaqLtYvvCPOD8mS69Ek9mYQwEF5EMFUWXabY=;
        b=KO50X356BLAsR14emmhRXTjCgH1UPBNvnQo75KAVsB/0R66I0mqohblFebrwHini2N
         rp/rVPXuGY0XqKwJnz7P5MIvCUFqMoBpe7xUmbEdVwwX4YC/APreh7mmfj0kt9KcZuVT
         xHGbAgyYWhHOq6jCT6Ydqx9d0NgCnvsHVRuKaOUzNiiD1v9p9JIJOsTIkGJH9den+zeq
         coH0MGB5NCb+zQ9VtbzGPqcwuPPO7etLvAi6g3TMpxzDojcyhTyH2t5d+W8JaZzQhLNg
         5p9j2IFgZeyFSFz1lpYtp9MJwNOurHpzH6C4h+R6Pesib+z8lVddw9QoShsLbYmg4JGc
         dFmA==
X-Gm-Message-State: AOJu0YzGYonOSnPQqLA8SQQwuQwyUfRqU3ZCruh7uBoJ9IPzs/YRgZTQ
	XdeAYx6I5YrGzCyySNRLEEWoX2goKvZFMlII6mEtSFjV+dlSNcU/ODdq1tCULRE=
X-Google-Smtp-Source: AGHT+IFwkbWKQ4IGA+r9HW9czIJ7AoQH9s1W0J0JftvMv3EZw3NwVqMe4Cj+MED97B4IZFL9AP8xkQ==
X-Received: by 2002:a05:6830:3748:b0:718:9c7c:2b33 with SMTP id 46e09a7af769-719ca2472b6mr5863742a34.23.1730499443202;
        Fri, 01 Nov 2024 15:17:23 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec70698049sm789817eaf.48.2024.11.01.15.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 15:17:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 01 Nov 2024 17:17:10 -0500
Subject: [PATCH 3/3] iio: events: make IIO_EVENT_CODE macro private
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-iio-fix-event-macro-use-v1-3-0000c5d09f6d@baylibre.com>
References: <20241101-iio-fix-event-macro-use-v1-0-0000c5d09f6d@baylibre.com>
In-Reply-To: <20241101-iio-fix-event-macro-use-v1-0-0000c5d09f6d@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Make IIO_EVENT_CODE "private" by adding a leading underscore.

There are no more users of this macro in the kernel so we can make it
"private" and encourage developers to use the specialized versions of
the macro instead.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/iio/events.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/iio/events.h b/include/linux/iio/events.h
index eeaba5e1525e..72062a0c7c87 100644
--- a/include/linux/iio/events.h
+++ b/include/linux/iio/events.h
@@ -10,7 +10,7 @@
 #include <uapi/linux/iio/events.h>
 
 /**
- * IIO_EVENT_CODE() - create event identifier
+ * _IIO_EVENT_CODE() - create event identifier
  * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
  * @diff:	Whether the event is for an differential channel or not.
  * @modifier:	Modifier for the channel. Should be one of enum iio_modifier.
@@ -19,10 +19,13 @@
  * @chan:	Channel number for non-differential channels.
  * @chan1:	First channel number for differential channels.
  * @chan2:	Second channel number for differential channels.
+ *
+ * Drivers should use the specialized macros below instead of using this one
+ * directly.
  */
 
-#define IIO_EVENT_CODE(chan_type, diff, modifier, direction,		\
-		       type, chan, chan1, chan2)			\
+#define _IIO_EVENT_CODE(chan_type, diff, modifier, direction,		\
+			type, chan, chan1, chan2)			\
 	(((u64)type << 56) | ((u64)diff << 55) |			\
 	 ((u64)direction << 48) | ((u64)modifier << 40) |		\
 	 ((u64)chan_type << 32) | (((u16)chan2) << 16) | ((u16)chan1) | \
@@ -41,7 +44,7 @@
 
 #define IIO_MOD_EVENT_CODE(chan_type, number, modifier,		\
 			   type, direction)				\
-	IIO_EVENT_CODE(chan_type, 0, modifier, direction, type, number, 0, 0)
+	_IIO_EVENT_CODE(chan_type, 0, modifier, direction, type, number, 0, 0)
 
 /**
  * IIO_UNMOD_EVENT_CODE() - create event identifier for unmodified (non
@@ -53,7 +56,7 @@
  */
 
 #define IIO_UNMOD_EVENT_CODE(chan_type, number, type, direction)	\
-	IIO_EVENT_CODE(chan_type, 0, 0, direction, type, number, 0, 0)
+	_IIO_EVENT_CODE(chan_type, 0, 0, direction, type, number, 0, 0)
 
 /**
  * IIO_DIFF_EVENT_CODE() - create event identifier for differential channels
@@ -65,6 +68,6 @@
  */
 
 #define IIO_DIFF_EVENT_CODE(chan_type, chan1, chan2, type, direction)	\
-	IIO_EVENT_CODE(chan_type, 1, 0, direction, type, 0, chan1, chan2)
+	_IIO_EVENT_CODE(chan_type, 1, 0, direction, type, 0, chan1, chan2)
 
 #endif

-- 
2.43.0


