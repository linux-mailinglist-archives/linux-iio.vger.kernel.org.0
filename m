Return-Path: <linux-iio+bounces-4861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D17F8BEC29
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 21:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB0E3B22596
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 19:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3429A16D9CD;
	Tue,  7 May 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZulPEtYj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2BB16D9AF
	for <linux-iio@vger.kernel.org>; Tue,  7 May 2024 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108540; cv=none; b=q/4WAWvAru+LxDThqC/yLYSmQkslRQVfvXz3oxFAns/H4sBkFe1v4SQWh5kVpFdy/lQpW8njvp4v16oDabSiPjIuFnxHxZNcrtH1vibOivKbuhrGqyMYnyIlHwhf/+lyMQ5F1uOF9mTcQxF0deCvsrau+PIY5fh8mMLsmeutV78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108540; c=relaxed/simple;
	bh=ZuQNDZ6FvEykzl/xun3pMRTdOGRALArKnmySgTgs6W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oovuoA6hdPJzANEasmQFsO+aR3ws/Kpe8aocJG00VVUE3FpL9XCTtjGQwzaVJ6ot2lvjK2Lne0gZMLv4QTkolq39muR6yRNoEKj32NCZHEL13pTXWovNkjzEZ4uvLTyUEkCLrMpP0RGf7I7+IYfFTjrnUEEHYfvLTPsmofAj9g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZulPEtYj; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c96be1ef20so1446440b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 07 May 2024 12:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715108538; x=1715713338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCGWhLT+GW7C3GUbTFxtCVYF67mxCVX333qfGkLE2u0=;
        b=ZulPEtYjD6TRCmGJEN9vUxlJw61b7U4ADye04UWDC4ICwuwbP55/RXw5MLQf6iZgt/
         HHTk5+7jDM01vtJwPcNtg2C6CxuvhJA7STyhgBNwHux5GD4wVILcn0aYvwf3NmJ+a808
         OnWfyP5mjY1mqmckXDDN0OmSIaLn/GK50SiT5rNC12t3voZNwImadJs3I9MGJJYmkjPU
         QR9NuIi22/8f1D3fpcctQNxFcD1Xcec8gPLK628yTBojYBygPCbDapT/v5v0MgxF9Xvr
         plt/cHrrTtNtvZPMaXoR12rqIC3WPeFxfXFy7PHewaKTUGVeOPcfwxGQZGFexd2sRDta
         T+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715108538; x=1715713338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCGWhLT+GW7C3GUbTFxtCVYF67mxCVX333qfGkLE2u0=;
        b=RGp5cX4dlZRXaw6zolBTaQtwAtzD0AEr5qFDPxWMob+TeQlj6z23DHqAdAa+kJ8LCs
         TktoZFiIQmIU5uARvOkxmd1jV2YJoZlVG04w6rvWO8TfXZc8skmpk0TO1SOJ5pYwd9S9
         GcjyJGJTRfxFB5xRQrzfIHm1QtG4hqzz63eetcJe49cA7g/9BdAwzlieasp6H1qWnUxH
         C5KpWQjMFNPRs32u7maA9PBZkxa9dWV8XL+JMOU6BkQwTNDfTuayZk3zuCY7lnHFUj5Q
         0bVmox/isPgvE5vTBJ1kZAlUZVcCbkpFM+eeo4jnC6ID/wSvX0yrIaBniZM0BdrveYA8
         j9lw==
X-Forwarded-Encrypted: i=1; AJvYcCWZErwuaKTwMjca68A/YTIK+KngQwab3uOtbMLK16DJm5ynlQ26sQnsY7Pdlzl7KEzx58FMmftHxWs4Jps2oU0hTfM/VeEzpgRD
X-Gm-Message-State: AOJu0YzGeaLZqY7pWgaKs3G8oA7I+xt6QXbeeGJTQPy7VuMntVRqJ8Fb
	3BdUGmsxx4nUjGC2hfTfsixC6Al6rpJb1mhkfx18ZKbtSaE9UbXr3n5X/zapIIk=
X-Google-Smtp-Source: AGHT+IFL6ERS1/RYKsFupGgA1xBg56o5QNJtLC1lE9gU+5b2z3/U/CF3gHCNHmI4JJsZ2InfuQGgaw==
X-Received: by 2002:a05:6808:1b21:b0:3c9:6d1c:81db with SMTP id 5614622812f47-3c98532c341mr532151b6e.56.1715108537916;
        Tue, 07 May 2024 12:02:17 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id j14-20020a54480e000000b003c96bbe0e79sm909652oij.13.2024.05.07.12.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 12:02:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/4] iio: introduce struct iio_scan_type
Date: Tue,  7 May 2024 14:02:05 -0500
Message-ID: <20240507-iio-add-support-for-multiple-scan-types-v1-1-95ac33ee51e9@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
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
2.43.2


