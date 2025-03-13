Return-Path: <linux-iio+bounces-16793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4D8A5FCA0
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109103B93FF
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8397326B09A;
	Thu, 13 Mar 2025 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTj02/Tw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697A26A1C1;
	Thu, 13 Mar 2025 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884676; cv=none; b=uooBpBwp1TUKRb6NYinNS84LkeLS++AoKK12Qp2oyg+4iXpSJPDjArO6cUm77uQInxS9H9ZydL7aSRpAL2fU5pD6kLkpE1DoBEIkeA5W6Dv2d4+uQq2vqOVo1AK3ky46p9peMmWtGH4gRxNiYdC08Y+pL/hGn58yQqDSKFk7DvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884676; c=relaxed/simple;
	bh=fH+WgItQJ5QeqHp5GboweniSh+AUhP1VSmPC21hq5IY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=acb7YtBJKfRtUCs+9FRxAe6WF7FX3wSul52xr8z4oph+LVq0x/7BV2pTqleOOkF4FKowXX/kCViCKC4/yrHzEMZ5WzRlA9MrfZmkguZ8nfFxJJyyAmHyEVYqmRaW8aAMJRvXrAK3QhR6XSIvwpkr7XstZUY7VecFFRAI20juGtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTj02/Tw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac24daf5f32so15087466b.0;
        Thu, 13 Mar 2025 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741884673; x=1742489473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A2/dc7iiyTfvwBTBoVMH8GTIaZ5VfQXot2jVROEU34=;
        b=gTj02/Tw0DRbeeBBSv6Iv7jOfY2WhqnL4lYCyYRcjQvjDmJdSQ55oUpeH0SWevlJUY
         iQ/E5I9eOQELh6+Xj6n4AHngsTW/urZIcxs0ZwTx3hjNEHLIkgQ9uBOiF632GFCWMMk4
         Lqaf7tFr/PIlETV2zwkoagVoacsKqUzJAwtLFOakvSfJrnAYhsFaojUqZnGHqPZO5ZLT
         y5HS0piJ4Jx5Z9y2SER48fgA0LWuFjoWNYrJkmzwAHMf8cFMb39J5h9VcSHFZRliVN7j
         Qn6Yip+BRKSU+/OE2dZyAqu7ubgiuWAUKLaGqoGMySchA5QQUdRvd496gH0R/CSkJ0UL
         xf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884673; x=1742489473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3A2/dc7iiyTfvwBTBoVMH8GTIaZ5VfQXot2jVROEU34=;
        b=WD2zRiAldQiP8Q82/lw1kehVdFlRcdh1GEhtLSO+oIzmwvHsX/ZeYqdgwLEUpaacoX
         qUJLwmsgLv5G3twLXQI9EHALDC+QyVN885Eg6v7UVF/m4SPkPvEnBkzaezn4PEL/G8CU
         5S2rwDkULNzcJ1/4WrZH8giF2lrssX927bamYeAA+REVU2siGRH9aJgTu9cQFfONk2aI
         zLeWmYaO8/+Yp3yehEql1TW4lcKrG7mensFNE264OTNHnCkXdpstAjrSx8pT5WmKXG0J
         Nhf8+bC6hzdxmPhH7dqqMQTv7fxI+ub/GFFThNc6BksxVrmzSkRiXisQpag2LsjYvu+6
         2zhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrhiUbIkqcTP2H9WqYZod+eZeR+SH0ujClTezA+OSBQM88ltH9veskBQzZmOfUHclDPV9aKqq2iKJNqAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7cgS++TCyOnx5YOmwAtgXeee5LxgswTXiPHlgpnKsjUCDsbT7
	diw/4l7yxb9OgaYG+45womb3DStFasUK5nCi/xBN8G9Bi5ypvq7f
X-Gm-Gg: ASbGncuDsYjJmZLNzK36kdinn03/Xa+X0ZH+uRzwG02L3PI8rkbZBjTxH6wcmmMkwgt
	CcKbot+beN5ytOXMYvXRUPLUd+uQaK15qIsIQXfAmzIvv2GrW9IlVpQ/J4txdY3p6eaXvl3++Md
	ddfbWvUoi0O5rRQLzrVxN9/rv/7PMsOYzdycYqGhfB2SvZNdBhIAhWa/Qv0Y7+AUrN2T/V966Ag
	cSsHytMN7WCpiNTChL/uOUSuDRPD228Lhl5ziJWHulSRQ0IxYyx6mKA6qvDIlguFgnv1vyM8sFW
	W1SXUtYmzYXmzw8VA4LpLo9T+SiFm2NHK2X/KW94MFI0GvpnlXxseEDZK7O+eioj0Z56WDhu5xZ
	fVJX+arerqf0ZJYo/X1gKApf0ERHsrfnldQ==
X-Google-Smtp-Source: AGHT+IFfsL4WE9ACY7ONw4EWSVGmKjYp5BWArUp5XrgnvuLrglkJP8Pg3VEZkWZSO2Gtmu4wWL2mnA==
X-Received: by 2002:a17:907:7e88:b0:abf:6d80:ae1 with SMTP id a640c23a62f3a-ac2b9c75eb3mr636701166b.2.1741884672499;
        Thu, 13 Mar 2025 09:51:12 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147efb0csm101370866b.65.2025.03.13.09.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:51:12 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 07/14] iio: accel: adxl345: set the tap suppress bit permanently
Date: Thu, 13 Mar 2025 16:50:42 +0000
Message-Id: <20250313165049.48305-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313165049.48305-1-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the suppress bit feature to the double tap detection, whenever
double tap is enabled. This impedes the suppress bit dangling in any
state, and thus varying in sensitivity for double tap detection.

Any tap event is defined by a rising signal edge above threshold, i.e.
duration time starts counting; and the falling edge under threshold
within duration time, i.e. then the tap event is issued. This means
duration is used individually for each tap event.

For double tap detection after a single tap, a latency time needs to be
specified. Usually tap events, i.e. spikes above and returning below
threshold will be ignored within latency. After latency, the window
time starts counting for a second tap detection which has to happen
within a duration time.

If the suppress bit is not set, spikes within latency time are ignored.
Setting the suppress bit will invalidate the double tap function. The
sensor will thus be able to save the window time for double tap
detection, and follow a more strict definition of what signal qualifies
for a double tap.

In a summary having the suppress bit set, fewer signal spikes will be
considered as double taps. This is an optional add on to double tap,
thus a separate patch.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index eae419cf8d0b..9e33236c786a 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -34,6 +34,7 @@
 #define ADXL345_INT2			1
 
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
+#define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
 
 enum adxl345_axis {
 	ADXL345_Z_EN = BIT(0),
@@ -292,6 +293,18 @@ static int adxl345_set_singletap_en(struct adxl345_state *st,
 
 static int adxl345_set_doubletap_en(struct adxl345_state *st, bool en)
 {
+	int ret;
+
+	/*
+	 * Generally suppress detection of spikes during the latency period as
+	 * double taps here, this is fully optional for double tap detection
+	 */
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_TAP_AXIS,
+				 ADXL345_REG_TAP_SUPPRESS_MSK,
+				 en ? ADXL345_TAP_SUPPRESS : 0x00);
+	if (ret)
+		return ret;
+
 	return _adxl345_set_tap_int(st, ADXL345_DOUBLE_TAP, en);
 }
 
-- 
2.39.5


