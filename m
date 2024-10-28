Return-Path: <linux-iio+bounces-11495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006289B36BF
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F6B1C216D3
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 16:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BB41DF273;
	Mon, 28 Oct 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bdo2ly5b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C661DEFFC
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133506; cv=none; b=Xq9eX7S7aCP2RK4OoZPZK/qUHe9dOUQWb02/SQA51vyrnUxM9EV6dWSgR4+lWXc9f/Ptwi6r40u6RVotfuTyY6R3ztyQBYsuw+BTxWF6U7ZQYsNg+oeUmQtbi36D34BRmfi4g8phgqfRkwBI/eXNjAFoqslgiSRuMLqlufFTZqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133506; c=relaxed/simple;
	bh=DdpcXG86yQKHjwGV1wZp83j21Iocs6OVFoX2GrPRNF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khxR8Mwmoog1kj7GNsi/Cpo3LRCtCC5oQvlZhjQqLYVmbK+PjgH/mJ0zbhfD4CSfXaVTnmNwz7+qEHKYTkJzgxCfz5l64jWPitDbTPRkQV7ecLmDlsFC232LpLJ0sk5h6ZO9cclzGQyj6ZYmNOUB0h49EeTUDJNvkmgtCqo5mt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bdo2ly5b; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43152b79d25so42106195e9.1
        for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730133502; x=1730738302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABkPdp6W6/7TraRKOCc3eYdKt9nFCUN5Ze+SrjQuTOs=;
        b=Bdo2ly5b7LdcHQsCbWR+JGEgV1Br9NcG3LCAqU46vXvRagiub1kwTK+91+4TvRpBCb
         PeFMWxgCzOyyfgDIT7d+sqfFr+pmbUJHJ/sVzafGAnhPGIndRkUN6q8aK+HKlfjw15uo
         ginoeZayQiFSsnXRVyRGvdLbz/mwz+wAAyPcdNaZbxKAUpRSnWEDF3bLD4RgbrHv3yL8
         Qh6O44arqN3LnGXLa8aNFCoL+JTsoG+OgIi9E0JsIVCrlOk09kfMkHy9T52P/pszRToN
         X5zMMBD9YY7nfynos9hcFOlJktj8TIob7v8oRADz48ZnHPaxmOxLh7Lw5tQrYl9UJfQ1
         RNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133502; x=1730738302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABkPdp6W6/7TraRKOCc3eYdKt9nFCUN5Ze+SrjQuTOs=;
        b=rlHu03YWVniAhtOn/qq/tMBgMiCffOkTrmRNAhz9puOnWYjx6JjjtGHBaR/cGLN03t
         DLglNnkwE3EjR3NUQrd4J/vAWqFNKSK5n8LFzeqecjCHmlyg6h4RBKTAhBdjSN0qwee0
         oDOLniIAI2Ivh+Rz7LVht2fOhDMQw886rjKrxejMiYkdKLEyxhnUXVMA+L7PdQ4gMwUJ
         7GZSUjH/PDA1PQla5GfObchurKQUSdQf8SUeLGIIZf6iFP5RqWFA/CD7FXtAW0XUQN2x
         VveopLlpA/sQZt1JvRAApzzRb0YOkhQWbRztsh+FrwEsdacWaS/5EpbemTX2NPhQCrnP
         p7ww==
X-Gm-Message-State: AOJu0YxXHj4guwrqKOa3c9tVkNOxoXmq3Blhd4LTrOaYm2gGQCG3qws3
	jv89pjeKzITTSgKR3JdE5OK5ZwFBtjjv7+BoZndixjyKqNHwZPb39TsKUVNbHaI=
X-Google-Smtp-Source: AGHT+IEasamIcI+PZCE+cvM4eiyJPSM/zmLg/qvaggXa7RCvn+IAAwng/+80MgvZ7i79D4r0fs40Hg==
X-Received: by 2002:a05:600c:3b1a:b0:430:52ec:1e41 with SMTP id 5b1f17b1804b1-4319acb1072mr93360515e9.17.1730133500853;
        Mon, 28 Oct 2024 09:38:20 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55d753sm147308435e9.11.2024.10.28.09.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:38:20 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Oct 2024 17:38:11 +0100
Subject: [PATCH 1/2] iio: events.h: add event identifier macros for
 differential channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241028-iio-add-macro-for-even-identifier-for-differential-channels-v1-1-b452c90f7ea6@baylibre.com>
References: <20241028-iio-add-macro-for-even-identifier-for-differential-channels-v1-0-b452c90f7ea6@baylibre.com>
In-Reply-To: <20241028-iio-add-macro-for-even-identifier-for-differential-channels-v1-0-b452c90f7ea6@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Currently, there are 3 helper macros in iio/events.h to create event
identifiers:
- IIO_EVENT_CODE : create generic event identifier for differential and non
  differential channels
- IIO_MOD_EVENT_CODE : create event identifier for modified (non
  differential) channels
- IIO_UNMOD_EVENT_CODE : create event identifier for unmodified (non
  differential) channels

For differential channels, drivers are expected to use IIO_EVENT_CODE.
However, only one driver in drivers/iio currently uses it correctly,
leading to inconsistent event identifiers for differential channels that
don’t match the intended attributes (such as max1363.c that supports
differential channels, but only uses IIO_UNMOD_EVENT_CODE).

To prevent such issues in future drivers, a new helper macro,
IIO_DIFF_EVENT_CODE, is introduced to specifically create event identifiers
for differential channels. Only one helper is needed for differential
channels since they cannot have modifiers.

Additionally, the descriptions for IIO_MOD_EVENT_CODE and
IIO_UNMOD_EVENT_CODE have been updated to clarify that they are intended
for non-differential channels,

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 include/linux/iio/events.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/events.h b/include/linux/iio/events.h
index a4558c45a548834e33702927609ca9ad447c67de..eeaba5e1525e44fd3b51985ffa99837efc6cdd00 100644
--- a/include/linux/iio/events.h
+++ b/include/linux/iio/events.h
@@ -30,7 +30,8 @@
 
 
 /**
- * IIO_MOD_EVENT_CODE() - create event identifier for modified channels
+ * IIO_MOD_EVENT_CODE() - create event identifier for modified (non
+ * differential) channels
  * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
  * @number:	Channel number.
  * @modifier:	Modifier for the channel. Should be one of enum iio_modifier.
@@ -43,7 +44,8 @@
 	IIO_EVENT_CODE(chan_type, 0, modifier, direction, type, number, 0, 0)
 
 /**
- * IIO_UNMOD_EVENT_CODE() - create event identifier for unmodified channels
+ * IIO_UNMOD_EVENT_CODE() - create event identifier for unmodified (non
+ * differential) channels
  * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
  * @number:	Channel number.
  * @type:	Type of the event. Should be one of enum iio_event_type.
@@ -53,4 +55,16 @@
 #define IIO_UNMOD_EVENT_CODE(chan_type, number, type, direction)	\
 	IIO_EVENT_CODE(chan_type, 0, 0, direction, type, number, 0, 0)
 
+/**
+ * IIO_DIFF_EVENT_CODE() - create event identifier for differential channels
+ * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
+ * @chan1:	First channel number for differential channels.
+ * @chan2:	Second channel number for differential channels.
+ * @type:	Type of the event. Should be one of enum iio_event_type.
+ * @direction:	Direction of the event. One of enum iio_event_direction.
+ */
+
+#define IIO_DIFF_EVENT_CODE(chan_type, chan1, chan2, type, direction)	\
+	IIO_EVENT_CODE(chan_type, 1, 0, direction, type, 0, chan1, chan2)
+
 #endif

-- 
2.47.0


