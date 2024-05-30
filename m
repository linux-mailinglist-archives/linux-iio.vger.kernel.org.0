Return-Path: <linux-iio+bounces-5507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8A18D4EDB
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 17:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E700CB26468
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A7517F51A;
	Thu, 30 May 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IA0CP7al"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A3A17C214
	for <linux-iio@vger.kernel.org>; Thu, 30 May 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082073; cv=none; b=ewGsu3vYZXhJJPktX50CKdxQQZ7eAF0Rp94ZtUl3+ne7vZj8Xd3z4uzy1QgbSJ/64m/An9BUJxWZdCbq8aHtbqE/IF4jqeJH1icmYUWZI5ETgrcK+eI9Mjb0R0yiAkcCj9qxzxytaovaqlf+LyBLX9yJyc9BmFu928LsSIq/S/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082073; c=relaxed/simple;
	bh=ZRrBEnty0a3OvlAcxFKH/wVNDRG+6DSpTucqWWr66pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvOo/G+lRJUzOwuJzoOa++hQtNyNb4gg21rZuglpxJ6/sKCxGMNcW8w0NSA21kiU8ryc9qyUqHEUAai1ZwIXbBWj8xFNpJ9i9kEWyFUnLkLq+87ENlqUHluDYFeALbmo1jGJU2gSOLVMzH5uWmoTZw2eN4zyv7/fXeMU0zO9NUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IA0CP7al; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f8d688ba3cso33598a34.3
        for <linux-iio@vger.kernel.org>; Thu, 30 May 2024 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717082069; x=1717686869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbWYNDGeB4acdSvzLHvqWONXfu2Ni8kWHZVRyossuwM=;
        b=IA0CP7alcnAhoaw0ReGN3EZynNr/XEzvSWs+w6TKe4f+X5SVe04w8nFkvj+jymikic
         5QYcY3eBou1//g9hryIINrBQirenZ85DvWk5ppdc+u3r6WskxZIiF7HSNvEwAE/jzyAz
         q2yC6I3p1fafA+YBZC60mQ+3n9sVqBVpTsUEGNBUcI78wkYFJ1m7gTTtluVKJlH40KM8
         5WiXVRJNN2hWgQLNwU4M6wwQoNpuLO141M3B6wmMFttkd6CtZ6oblh94jTu6M4arzqs9
         MAY2fxA7hG1pcCpnaiWSP3c6Ew/+6u32i4veEDCl9n3J3OK/iGJIl0rnYHa0ECqU7ne+
         NNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717082069; x=1717686869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbWYNDGeB4acdSvzLHvqWONXfu2Ni8kWHZVRyossuwM=;
        b=PCfu9uIhXNB59W0mifn9C4kipBcfbxZlOBlvIiKtGxFEq18nKaO1TLs9JlXw3cf9MR
         Zv7DnkIPMU86qHgSEY7AkR6PBkiimEECTw3MU/8eI2Uug9yFP9SSFqngdo1w1xyc9iX1
         IHeocQ9vRaGEF+hZAo2zfEXMNI1TfV8WZCvK5fYnhU7gWeYrEK+DalrKrk/kFLsxMm0d
         Dp6Sy6JdxdUqNsSRPF6W9//BQrQ2m18aFSnYBk5Gm/jV6A717HjPcQ0Tlz199uZk/OND
         X1MLWlpXHvieADCzgYvwHilFr6h43NQ9WNPDkr8UcAMfZcJyrExy/uvMGBjE0JKOXksZ
         ZIDw==
X-Forwarded-Encrypted: i=1; AJvYcCWd10BSRU9H45cgNwjsjaxh9VWIkslJl+jyuWrtU45zhLjXTstmbGqh0kPD7lnpEmgVysOY5e+8aFBj3BHtCaqlGZ7oVdGtt04y
X-Gm-Message-State: AOJu0Yycep9t5CSifGmeZtnIalj7FZRFUTEyNFRiPfTxdqfPLKDK7azI
	+9HJeOHai1BILydeM531n1z6AoNSSTVansscriZBRFHC0UyK7TRxWZHpDIKIDYQ=
X-Google-Smtp-Source: AGHT+IE2lyAsahNdb+M+r2VsDVKfYnrWiFE+5vnGDiP3IBTld3L7Pf2jxyrJMpOL2y8G8xxJqtOR7w==
X-Received: by 2002:a9d:4802:0:b0:6f0:e7c3:945c with SMTP id 46e09a7af769-6f90af1c9b2mr2439771a34.36.1717082069189;
        Thu, 30 May 2024 08:14:29 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0de6314sm2803425a34.41.2024.05.30.08.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:14:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] iio: introduce struct iio_scan_type
Date: Thu, 30 May 2024 10:14:08 -0500
Message-ID: <20240530-iio-add-support-for-multiple-scan-types-v3-1-cbc4acea2cfa@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
References: <20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This gives the channel scan_type a named type so that it can be used
to simplify code in later commits.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v3 changes: none
v2 changes: none
---
 include/linux/iio/iio.h | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 55e2b22086a1..19de573a944a 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -173,6 +173,27 @@ struct iio_event_spec {
 	unsigned long mask_shared_by_all;
 };
 
+/**
+ * struct iio_scan_type - specification for channel data format in buffer
+ * @sign:		's' or 'u' to specify signed or unsigned
+ * @realbits:		Number of valid bits of data
+ * @storagebits:	Realbits + padding
+ * @shift:		Shift right by this before masking out realbits.
+ * @repeat:		Number of times real/storage bits repeats. When the
+ *			repeat element is more than 1, then the type element in
+ *			sysfs will show a repeat value. Otherwise, the number
+ *			of repetitions is omitted.
+ * @endianness:		little or big endian
+ */
+struct iio_scan_type {
+	char	sign;
+	u8	realbits;
+	u8	storagebits;
+	u8	shift;
+	u8	repeat;
+	enum iio_endian endianness;
+};
+
 /**
  * struct iio_chan_spec - specification of a single channel
  * @type:		What type of measurement is the channel making.
@@ -184,17 +205,6 @@ struct iio_event_spec {
  * @scan_index:		Monotonic index to give ordering in scans when read
  *			from a buffer.
  * @scan_type:		struct describing the scan type
- * @scan_type.sign:		's' or 'u' to specify signed or unsigned
- * @scan_type.realbits:		Number of valid bits of data
- * @scan_type.storagebits:	Realbits + padding
- * @scan_type.shift:		Shift right by this before masking out
- *				realbits.
- * @scan_type.repeat:		Number of times real/storage bits repeats.
- *				When the repeat element is more than 1, then
- *				the type element in sysfs will show a repeat
- *				value. Otherwise, the number of repetitions
- *				is omitted.
- * @scan_type.endianness:	little or big endian
  * @info_mask_separate: What information is to be exported that is specific to
  *			this channel.
  * @info_mask_separate_available: What availability information is to be
@@ -245,14 +255,7 @@ struct iio_chan_spec {
 	int			channel2;
 	unsigned long		address;
 	int			scan_index;
-	struct {
-		char	sign;
-		u8	realbits;
-		u8	storagebits;
-		u8	shift;
-		u8	repeat;
-		enum iio_endian endianness;
-	} scan_type;
+	struct iio_scan_type scan_type;
 	long			info_mask_separate;
 	long			info_mask_separate_available;
 	long			info_mask_shared_by_type;

-- 
2.45.1


