Return-Path: <linux-iio+bounces-17059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FAFA6807F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 00:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FEAE7A9C69
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CAF214232;
	Tue, 18 Mar 2025 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM8s/p6D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866152139B0;
	Tue, 18 Mar 2025 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339342; cv=none; b=N3rXgXLsCL+3omHVDHIaoO/5ILDYTlXC0FH+iZusQUbnhrPNl35fJZ8Hf53oyOvNzxAzefRoU9XZVrh4kALvsxHTpthqmsvwYj0ahbnSOYsdEh7iQfOOMNFfMjDXXtU7YKP5mNMSBOcnOXf8yltCcQpf/PUQar3Er4e0NktHWlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339342; c=relaxed/simple;
	bh=kTuk4oS1Z5MqPEpTNJY/RFfU8sOm/9Vfhefz+HHDWy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZoDOwgoNxaexq+uHX3Rz/ilx4LxfnofIXBTY0JcqwghZJHMXVbvIgdkmNkZXapBygZN8wYt3Z2+qLhl4dC/nRgbkJ4VsROYgHk945qkh3E5QtH13C3f5W/btIwEwrouqR2+X1taKXWMVLxxKgItq/u5oAg0uq6ihjcJSJugvnAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM8s/p6D; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d0953d3e1so3861255e9.2;
        Tue, 18 Mar 2025 16:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742339339; x=1742944139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mK9Gt9waVp5YavrmSeXRxGHtVUUg9Z23BLqhVi00yoA=;
        b=UM8s/p6D2it/OlpRuWXhECh6zOMRgvW5WYAX+GORN8uTbvkV/HkAGQxV2+QS6K3cfQ
         MKF7qhm3ErG8DUVxv2VmHoPBd90RINnxiOCppKt/Bt76kiISwVhe4vBh/a5huKOe4QkO
         Ec/OggJ8io4hfhXc9AgPqECKJX30ZR1iS3w9CUUUVPJss+9JfVT1igHr9hIvQUkF0d4E
         riWy9HweFU8OpEYop141qI8G3yWuIzAc8fq2/5SBP16jrjJ6CxwB33sR3ZyGEKy39o6m
         5y6SLLLbfeg0wpJCR+OeiuVHJojp47aTDANvg3k+L6mzJG6OGdZXYX8tdzvYDHx0FUJp
         dPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339339; x=1742944139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mK9Gt9waVp5YavrmSeXRxGHtVUUg9Z23BLqhVi00yoA=;
        b=kUG2PvrfRcSF0CMO9nxTj6IGVx8kHxr856WxQq7ykkiH9/xIL7uiLkZnv1ymgToPni
         B5UXXec4jmVWDaDzRQa//Hc3lc9OtzaYu1zlbnj0210QBG5JBsnyfOy1Fu4hyjlRSQ/C
         JUIK0jj2chbK9QfBUkp6s8xwsCUA7TK1ntT2avfolUtFXTTJRLgAwv3ItkoFWgFkRUut
         m53NunuM/UTVX6cQCuRnj4yj6Dr3ZU1pBGOmFUQwnUU2bOOI3/4Om00cJ3bairsmGWHI
         XHu+RdnwW3EnWNsBmQtew1bbVfAvuvykpSsL7FYlZJIgG2PHcKVS5tGzCa+lDmnGNBx9
         yXgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLbDL+oQ74OcXk/+Nhs+KodrlFmIAPz6F7vGZcMW5ywE44UTmj0Xw0mp8ENG0r8Vd+IF1bG3FZgvKqUDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrOSl8cqK9qDOOWFIXvHXIUhVFkrTz3oFa67KjYdEtNmQt8/ST
	DmQ6i4O8tFlxguh3Yab+82DKzBJ8h2TBSQu1upSrhDTWMuzdVtdS
X-Gm-Gg: ASbGncuUdy8fDftrgD/unidYV5NYWEVlFjRxDm96PmSSiUMdLGtWFB2cVmQw2stDgh/
	6FOyhhQXRhNIlv0vAzqAmPCKI/0RbUbCl+3uDEGzuutcHPtRLsKZSHV4Yqo0qZu5XBh6nOEEDja
	04ZfNgxPyrQ5/xF3LMv9J3L3ZhH53r0mtz6dXAl2jq7gD/EBmZXdPxMAou4taz2T6XSH1ZAUok8
	z/xI6JSTxxtOZ+9mrokqyUINecoIg9JOG9C8DOS/bLZPX08hg/3YJzod5qsTTNU62hBljhQDwqD
	i+cBle42QYVtQkPrQedxkEGg6TynYsvAIjPngVX+LgwM3la4/mCC9W0Iw5AHdjzICL/rWzqK7zP
	BS74AHWY8ZmVyzMyBy1aSIG4=
X-Google-Smtp-Source: AGHT+IHCsLWjI3h37CbyOLS5zu4xP3emYSD3vqaqnjAUpFHi/hya9/9aOGP9QmiJhvU6AjxJspey/Q==
X-Received: by 2002:a05:600c:1d88:b0:43b:c844:a4ba with SMTP id 5b1f17b1804b1-43d4387586amr1043795e9.3.1742339338604;
        Tue, 18 Mar 2025 16:08:58 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed793sm1113455e9.39.2025.03.18.16.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:08:58 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 04/11] iio: accel: adxl345: set the tap suppress bit permanently
Date: Tue, 18 Mar 2025 23:08:36 +0000
Message-Id: <20250318230843.76068-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318230843.76068-1-l.rubusch@gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 9dee819d5252..52daf46c4acd 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -34,6 +34,8 @@
 #define ADXL345_INT2			1
 
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
+#define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
+#define ADXL345_REG_TAP_SUPPRESS	BIT(3)
 
 #define ADXL345_TAP_Z_EN		BIT(0)
 #define ADXL345_TAP_Y_EN		BIT(1)
@@ -288,6 +290,18 @@ static int adxl345_set_singletap_en(struct adxl345_state *st,
 
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
+				 en ? ADXL345_REG_TAP_SUPPRESS : 0x00);
+	if (ret)
+		return ret;
+
 	return _adxl345_set_tap_int(st, ADXL345_DOUBLE_TAP, en);
 }
 
-- 
2.39.5


