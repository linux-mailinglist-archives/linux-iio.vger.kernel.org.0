Return-Path: <linux-iio+bounces-21269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB33AF65E6
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C43A4858EF
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BA52FD5AE;
	Wed,  2 Jul 2025 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6wMVUBN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FC22F85DF;
	Wed,  2 Jul 2025 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497433; cv=none; b=tbhDAkYrt8Jtd/Sp740GaQLxEKwXy3OnzmJcQrPa7fL/nDNHt2pOHQZ+VtQJxQ6XQjiqu3tRZxJ6vnaz3c3jJ29wDiGRSqqwSwrCFq++RK4hkwT5OcZxGL4kR/5Yjqc/1gG5V+1N0jwTNp3U7Vdgr4Z6uIRqghn8LunJvce5tPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497433; c=relaxed/simple;
	bh=2oCKa77MmvtjuzTFUyhx2spEW5JEAkYP0TnixHDrvQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNpu+lJQPok2aty5RXNQpsBxLXP6e+7DtMEFQRQ49qCF/dAEyqoadkORCcoZAMBF8E5HQjFVgnK+8D18APe/aZfwOC+j9twKJsy8hKTs3dr+sWCSb8sPuETUW1byydcYvbE2kIYJzpugoj/CfvOZZp/az0ah7rEjP9rDtZw4SyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6wMVUBN; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607780f0793so1519562a12.2;
        Wed, 02 Jul 2025 16:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497430; x=1752102230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSMGUq00Wscsa5i+rwtOnSrfeZI1fF8spFiZz7cfc/s=;
        b=h6wMVUBNKVE9ozZeXwb24Gt00oOBzlDo2x9jzINsHLymSym2HaHt8MDD+yqjjO1RzV
         prnRwm6tzchVDUWS46QIcA8M5pgBnq1vVZCAy1fpFBwXzoTLIgTQEISIPFMOlhFqRRdy
         AhMGexdKpDsJZV6AwiEDqZlTdDoHq2kjHTQsLFz4w/hmVozFsQZvoj95gHm8JuECKR0G
         cGCPHnU8xj5DQoUGNz27dK4OvvHjc8S6e0sVor70OH6dBr1mlS+2N0H2PB9qaHud6CbN
         n3q4iyLFoEM6nN2n2AneFGD5xO/DZEBhoOjIWxq8v8wICzHTYAZBzSAhL9O4BQ8SsVEq
         OAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497430; x=1752102230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSMGUq00Wscsa5i+rwtOnSrfeZI1fF8spFiZz7cfc/s=;
        b=fA9/FCB2tdw8g3BQB3+hz+g7bm8XFw/aL+u1cqed6lWhk3Bti/Wu6HIGuUolz6RcpR
         EUPcXzM099D4I07rojtdrz5TUwmVI5Uj+9B5yKbRi+iZ+RFBk01z+XOaOcmqVSoz2Jex
         S2AyYKLNvj3oYivdtOgkEq7Yzl3FaTAjyvv/xvwt7REf5XbHfM7yp2GwPrQ9E2xz6jMD
         g0MI1tPOv7MrZRzPNOZ1OfceN6N84byFCEqMDdKSiUI3JVSvYLYAoddIRYfPb2L4i2yB
         iO8aRAJdrFIdA5Sgay0+WF7PwPRR2vIXv7OHlmqR57NzmZc3kiC/cy8vRVhOJFuYqHqB
         lmFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUXO6owm2dv9OXcNyHEBjAJbK4MFKVJoiDG/CtMv3XSSbn284RJaJGRfIoAYFzVuwMhII4cJ2ZRtc=@vger.kernel.org, AJvYcCXagHfJid48neSqvXEtbeWI8hrvioWZNx7Zh7QdZzZAfv5g3jOImiZF0uVJB6HYLNTxybDSYyPnOuOHeKsE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzoh/A0RHhUhMUF9ljj+vgaestwLYVwjPqHAXX2l49OVj5uOfX
	na4LWCw6m2zswk9glaqwzL8FEMCy7HD+ji3ylN714iFM8QIHz/C2IkE/
X-Gm-Gg: ASbGnct8uTYSNoA9gAS36/koB6YWfQ6gVlm6hLYMA1U30QGywLXe+pQwpp119XgTdIm
	f0EuvTzMKrXlEJ7/NO0ziSuwfug7FTf3Fx40HjhpOO9P0F+vLTCVTO+/rOYZ80WWwdor4aD/bqZ
	9u5flWXokKmaTSrIoECqW3Q/7SnsjXQs9OAF71xsBJjWkIChdiXxfoQ/OhWtj0vR+o3DLj2yZXM
	AcA8oKAfX509L2PLRmiJkO7t6EbgQ/24ajqIUhVrIr9CMwB4HegCx07POdY2wH2Ib1PaUGhYH3b
	mTmHctEL9ZT6Ln4xnVTsg2r8qhtmc6Dp0ek+4pCUuj/TyNNn12tMoCCzO8YNr1yAYC3kc/PKspM
	lTGXx8YWXLe3d7kEutWb160deWripgj0eP7l61GNHZyw=
X-Google-Smtp-Source: AGHT+IE3HM/yk20/T+LgFmKx7sguDxopwCTI+CHO3W59kYUljAIEQBTlUvCK+ZgLTeBaGo4TuhgiKg==
X-Received: by 2002:a05:6402:1914:b0:609:a671:ebb9 with SMTP id 4fb4d7f45d1cf-60e52cd6d6dmr1208843a12.5.1751497430072;
        Wed, 02 Jul 2025 16:03:50 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8319e706sm10031469a12.47.2025.07.02.16.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:03:49 -0700 (PDT)
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
Subject: [PATCH v11 8/8] docs: iio: describe inactivity and free-fall detection on the ADXL345
Date: Wed,  2 Jul 2025 23:03:15 +0000
Message-Id: <20250702230315.19297-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702230315.19297-1-l.rubusch@gmail.com>
References: <20250702230315.19297-1-l.rubusch@gmail.com>
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
 Documentation/iio/adxl345.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
index 8ee01b8b87f4..c5525267ea12 100644
--- a/Documentation/iio/adxl345.rst
+++ b/Documentation/iio/adxl345.rst
@@ -150,6 +150,31 @@ functions, so that one follows the other. The auto-sleep function puts the
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
+Note: It is recommended to use the activity, inactivity, or free-fall registers
+when operating with an ODR between 12.5 Hz and 400 Hz. According to the
+datasheet, the recommended free-fall threshold is between 300 mg and 600 mg
+(register values 0x05 to 0x09), and the suggested free-fall time ranges from
+100 ms to 350 ms (register values 0x14 to 0x46).
+
 In DC-coupled mode, the current acceleration magnitude is directly compared to
 the values in the THRESH_ACT and THRESH_INACT registers to determine activity or
 inactivity. In contrast, AC-coupled activity detection uses the acceleration
-- 
2.39.5


