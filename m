Return-Path: <linux-iio+bounces-13125-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2689E5CBE
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 18:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1FD16BD26
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 17:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7689422D4E8;
	Thu,  5 Dec 2024 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzDTAEuZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DBC22B8C2;
	Thu,  5 Dec 2024 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418848; cv=none; b=Bhg/6FXNO7Tvnb1+J/tDZALgAQg1Buoh6h1Q1Ig8xKfnbzcEg4/cDyLGU4dY5Oi2+CZa0KBRtzLruhJRAhmrR8tv0uP7Pbd45tX2HwcclH/q8PAZBX90WUX0a8eTL88rTQR6zUoFYMv8ifdTB+XK7qux1q4ymgnu3XA1RoTWWz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418848; c=relaxed/simple;
	bh=iLDUgU8WNcAh/t6tBH4v0q05mowuF+6hmrNXfHJwFoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ufyLDVtrDHLIVkeSimC6opSapDBJX45rELyiLbq2ZZZD+ASMDyQyr55UwL7/veBAyi3HvWIy7dyenXxYsmUz1/CaMwKk/RTnCOSl6TikqvSwrIeHMQFzfxJecmu25rwvXej5BezDWXLFuHkOwswPoN/sFfiPruIstkQbUj+LZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzDTAEuZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d071ac3f35so199813a12.3;
        Thu, 05 Dec 2024 09:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418845; x=1734023645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgoVWnhvP406HqfDsdu4WH7uW2K8Xa/wgeBTdZ1+3jg=;
        b=hzDTAEuZ++zxApzhj6bXUs8s9hClVQzdiDWWMnrSfh1pxw+0PT2tQOoinr+JIDXOvQ
         cw6hPT2dJDb73PHO8zm0QvR2Gy8/J1/hfYSgxRlSVGJXEfGFVDJEYk0L6IQgfzVg1cZQ
         MjeyncfzzXoYItoZJHy4Xv6nt6gGQpcllh+gqbrGCxHxVQAmBdcVkxH/67Ar3Dw1Uza+
         n5SaoJf6ClzN2mzZ2Rl+PPvCDnfqlPXRQGxVbaRopagpdTECD3hWBsCUgEmaJoroTpYC
         pV3Sobk4KrKXqXkgun3yUpt/xLNLalQ9SCMERpUzF/jibRIO4wTLsSELPAAoBcl36CJI
         5ikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418845; x=1734023645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgoVWnhvP406HqfDsdu4WH7uW2K8Xa/wgeBTdZ1+3jg=;
        b=PpyL+RS9gG5UoJhWePILK8A0rzUUnVd6ELtOTPlyjheAi2uXZaBOwMu6EZJYp3NUOq
         SPL1QR5G9ODr6AzTbs/YN2Tj9m7CMT4dUpSzJVSOaN/H/vaXPFDy0YOEUwKjFetMUFmH
         P3OzgNrGxT14joMEyyw9l1YClmEBpy1NpcnxDVv4ihS6wOILT0Trw2WQ/TrwWgd7LIoi
         3aqlmcp2jBYhjz2mggT+02HhLql47g67KvmaMGf+YYvgtAwXLBXGPDsMKGAa9afP65jN
         OYy10NwaLFdpqQzUjA4NwROxbN4OJL5N4ndXacMA3WhbDhEyt65Y+fhhTjnfIWjWU4w+
         408A==
X-Forwarded-Encrypted: i=1; AJvYcCVJZX8zcFgYwYkvMQJ361z2UR9Ov8bhn4jSbpiqO2vQipm1Rr5IIqWdppZmrZZKhSx0W+L4PUcwKMA7AE07@vger.kernel.org, AJvYcCVuIvjg4p/m/hQD/9eRDeSF+c48rxaG2P2pcZdWHIefBP8uKyzkijGJ4khxsAKJvmOAnOoMtjOkvTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx7zMKCe4GE4n+qkkEc6FeUm8QTVxLfUdOvLDBH6rK3rqFj9rc
	k37zwBiFAwexwuBkmBjKi++l62U6k7k5ZqJjpZhR4aQ5o0yga3FF
X-Gm-Gg: ASbGncujjeWuul0jGsMMGOM6+ts8XW26dA7LoPl6gugDkYtX0+PwZYEg3p8b9husWun
	VDHib/1R+rDOCRm0WmGQX9fxawuJIqCsBOqbSOPVYN4rITBb/+VtWmgfd4QwCDTPCHcNYlHNxRP
	nxPwpR5Qop48kx7JI5OSefH0JO4QuKDF2xd29amx/vWuwVoFE+I8MQZaW0RBLw5/tCBLlocRiXL
	FashVV5dX6PwRom9kh2Ai7sSPoVjiyxYQDcxeoCC39WGv4eE8KD77clf38g0uoX8ojarkfsjsUi
	OWEJ2EOcF8yujctzQ/DqvtgXX5nI
X-Google-Smtp-Source: AGHT+IHupydN7u5UoHUv8Up/y/vujjHXDYpRrXcnAREL4xFBRVIksMwEo0cvdnr9oIMHiXqJQbhs1A==
X-Received: by 2002:a05:6402:2111:b0:5d0:b7c5:c40b with SMTP id 4fb4d7f45d1cf-5d10cb4e07cmr4101115a12.1.1733418844765;
        Thu, 05 Dec 2024 09:14:04 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48a38sm1026078a12.23.2024.12.05.09.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:14:04 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 09/10] iio: accel: adxl345: prepare channel for scan_index
Date: Thu,  5 Dec 2024 17:13:42 +0000
Message-Id: <20241205171343.308963-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241205171343.308963-1-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add separate fields for register and index to the channel definition.
The scan_index is set up with the kfifo in the follow up patches.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 0696e908bdf..3067a70c54e 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -26,21 +26,26 @@ struct adxl345_state {
 	u8 intio;
 };
 
-#define ADXL345_CHANNEL(index, axis) {					\
+#define ADXL345_CHANNEL(index, reg, axis) {					\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
-	.address = index,						\
+	.address = (reg),						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.scan_index = (index),				\
 }
 
+enum adxl345_chans {
+	chan_x, chan_y, chan_z,
+};
+
 static const struct iio_chan_spec adxl345_channels[] = {
-	ADXL345_CHANNEL(0, X),
-	ADXL345_CHANNEL(1, Y),
-	ADXL345_CHANNEL(2, Z),
+	ADXL345_CHANNEL(0, chan_x, X),
+	ADXL345_CHANNEL(1, chan_y, Y),
+	ADXL345_CHANNEL(2, chan_z, Z),
 };
 
 static int adxl345_read_raw(struct iio_dev *indio_dev,
-- 
2.39.2


