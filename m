Return-Path: <linux-iio+bounces-22075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41075B131EE
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 23:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B71E1769B2
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 21:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B93A248F72;
	Sun, 27 Jul 2025 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADo8Mnnd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F55A246BD7;
	Sun, 27 Jul 2025 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753650036; cv=none; b=Bqr0ESnhZ42p5fScHSii8uAFfB7Dcwtqjbbc+x8tGUfoW3iFFuXM0gFg8muJkxDabguBm7au904VWwU+rM/TIE5g6DKbNhqBineVDXu7wIIYo43ZKUdzpt624lCce/dxyP4vaGcZ8xjdnd8XKphpUY/29jXnGx7hf1osx4LoaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753650036; c=relaxed/simple;
	bh=HDLpnm2Kk1QzS2X1fUn006/ALd+oNwb1nQWqzy+FDCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKh5wo9RHRPiNyyZUulpQr5luoWr9PCIEDqKFCJH2BDasqu2arjGmCb4hI1mL5cwKmlw8YCK3XL8kG/+QI2Ov0Os/CTLq40fby80CNadBjbdTAc62CLhVIKjZNgRVOwDOnfOtoxVqcROoRsE8JEffj/mWL7jv7rPvEhWKfUam9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADo8Mnnd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61531c16c85so55469a12.2;
        Sun, 27 Jul 2025 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753650033; x=1754254833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BDzjo2M2S/ZKrTINViC/iH7/XnhgtICWFKdW2O/sZI=;
        b=ADo8MnndNIk2pbTQdIZtE8rREhSMHl6RC9bWkvCqAZfej8LeE4TIPDsS9WSEgVWU8D
         4wVBojQOqHFuMFuPYyISi1eU9yFiP0MOIZ/OvGGswRWKBT5rTJNKwJ2b1KvyXKY9ZbgC
         oZ02k3PovOXNiHDFbcDvi3Ff749qDsyrkiTTcoghE3NjejYNuaG0kbVJMiqnTW2MkhaJ
         Aevj1HV7ngXv4FX2nZ0AI44KH/ncNn+lTs4wtOEx1CUqso3paJWOFLqcLqLh4JJ39Xcl
         yTOmSqjWRFSVOE7YBKuuzr78Qxz3l0w1698STj2okgtXO2Uft+cxSMUhltib3FfzAXjC
         UGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753650033; x=1754254833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BDzjo2M2S/ZKrTINViC/iH7/XnhgtICWFKdW2O/sZI=;
        b=rpPhLXNahw42cnCc9/lCcMbcH9CbWqj1IrRus/ZCX2UWTTEqNSNDZcniDNNdILTbi4
         FvII1Tn4O8srJxjo/MnQz+3Jry2iyM5kxikk5hqcLSt0M3IL4vVi2x914ig/HI8F0OjP
         njpDtyFn5nYzLyNqAKmkiNjanlHt3pbJISDpW1CXP7nDORqfDr8r0/8uMobSM+RNpabH
         K5R8gFwkWPOZ+8syG9+nEFxUVKh0Dym7qD6NeuJ3d2RNbAp5fuQAdLjY938Nm9F2b79V
         8+2lAz4GFJaveCloMPY1TIqz+13VaMYMjRbzrC5pPA9bZkiK7yGtxudm3WnIASdc0OGy
         1Row==
X-Forwarded-Encrypted: i=1; AJvYcCV7eY4+RCsAG6CM9eyAoOU3Z1pXXQyW0NwgPWbqrEVqgRbIPzRDMma7eylu7ViSIAZtwzKvNG7KPBM=@vger.kernel.org, AJvYcCVA64qUvwPIbGJ1+Xn/jAlv2i9VoCt/m5kIllZsUdPegKbDDK3waRI+VveN6W6gOgQfWKdycsqCSF8Uxk/+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr1lfYHGI4RxwbnudyNBiQHHiVq6z1w+ijtBCNWlHqJwzbdgUB
	aiKJWIzVaCaeh1nm3Hgv+eZCV1ioqHuvCYEbvWYoIitugH4NG39rmR5x
X-Gm-Gg: ASbGncs1G+1MUjC82FbWT6UnmsVbnS0fibW6KrKSuGGaMHJXBUx81Tv+IuAbdqtRZjO
	38kDcL0ifsjrProMzdbETuoKVRpn1VcoWD9Eh4sbGT1H7l5jQPq7nZX0YJcOOgN4NQhKvMLQHrp
	86n8z1JRtftOkBDW/WPXdhmTrTTT2SrAjP8Q0JAjiTK675W4bakUzm/yWXWsftuSGKCdNFahSEe
	2XOxitAPUctJUBXrSFh6opo5+vfQeS5o1SxtF2+p4gl4K9zdCPouxPxqX3HgtUzYjFhubeSUzan
	t7RPlcPrtOiE24UeLNk+QLotuqWnN2D2tANKE13Q8MGVDkvaAWu0L/yKxWr2JIpspgqQ2GmOUYm
	NbV4uS5QmVIAAJ1r66w+lFVjUFd4DnjS03la2TOCDcmQmwHYENpBVXPrWuMXq38tZx8mx
X-Google-Smtp-Source: AGHT+IHt8qDgPh5e+JtBvImp0fK5R5XuZS8DRGZaNgSQkXvRVTfY5QvVYlMz/sYdpxlHeN3XGpxhXQ==
X-Received: by 2002:a05:6402:51ca:b0:615:35d3:fcde with SMTP id 4fb4d7f45d1cf-61535d40842mr935352a12.8.1753650033094;
        Sun, 27 Jul 2025 14:00:33 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500add92dsm2512774a12.52.2025.07.27.14.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 14:00:32 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v12 7/7] docs: iio: describe inactivity and free-fall detection on the ADXL345
Date: Sun, 27 Jul 2025 21:00:14 +0000
Message-Id: <20250727210014.27766-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727210014.27766-1-l.rubusch@gmail.com>
References: <20250727210014.27766-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Describe the inactivity detection additionally using the free-fall
register. Due to the controversial discussions on the mailing list, this
section of the documentation will be committed separately to allow for a
more focused and detailed elaboration of the topic.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/iio/adxl345.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
index 8ee01b8b87f4..4bd038cb4a37 100644
--- a/Documentation/iio/adxl345.rst
+++ b/Documentation/iio/adxl345.rst
@@ -150,6 +150,30 @@ functions, so that one follows the other. The auto-sleep function puts the
 sensor into sleep mode when inactivity is detected, reducing power consumption
 to the sub-12.5 Hz rate.
 
+The inactivity time is configurable between 1 and 255 seconds. In addition to
+inactivity detection, the sensor also supports free-fall detection, which, from
+the IIO perspective, is treated as a fall in magnitude across all axes. In
+sensor terms, free-fall is defined using an inactivity period ranging from 0.000
+to 1.000 seconds.
+
+The driver behaves as follows:
+* If the configured inactivity period is 1 second or more, the driver uses the
+  sensor's inactivity register. This allows the event to be linked with
+  activity detection, use auto-sleep, and be either AC- or DC-coupled.
+
+* If the inactivity period is less than 1 second, the event is treated as plain
+  inactivity or free-fall detection. In this case, auto-sleep and coupling
+  (AC/DC) are not applied.
+
+* If an inactivity time of 0 seconds is configured, the driver selects a
+  heuristically determined default period (greater than 1 second) to optimize
+  power consumption. This also uses the inactivity register.
+
+Note: According to the datasheet, the optimal ODR for detecting activity,
+or inactivity (or when operating with the free-fall register) should fall within
+the range of 12.5 Hz to 400 Hz. The recommended free-fall threshold is between
+300 mg and 600 mg (register values 0x05 to 0x09).
+
 In DC-coupled mode, the current acceleration magnitude is directly compared to
 the values in the THRESH_ACT and THRESH_INACT registers to determine activity or
 inactivity. In contrast, AC-coupled activity detection uses the acceleration
-- 
2.39.5


