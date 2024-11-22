Return-Path: <linux-iio+bounces-12505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE1D9D6278
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 17:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26776281AE5
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 16:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869221DEFC6;
	Fri, 22 Nov 2024 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETeVeqbE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9138158DA3;
	Fri, 22 Nov 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293800; cv=none; b=omu9nXF3Ps4RjSh2q3TghJ2kOGv12mhfc/iKU4ccEfPFuuKWy08tzAW89+eK/ZSyaKhUqVe6yOwJ7KuqYwvhleueKVx1i+hGvyALbas/uW/LphqYybMAuDWDG87+h2m+Tr2NPXJo7X4abN6yE4ZIIiyAsja5sAPB3VBJe6yzGNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293800; c=relaxed/simple;
	bh=2ZgV7K9XCfWdPmQxMrDFrNeOxtVJ797ePLaSO7UUfp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tx7BhUQmsct1uxRIQ9KybmgOlfu0M6qg+1azgkSaThC4ffN8ZuX3Yvqilpfp3xI7L/Cb9i5o5nYYTwi3hCVztsWl1rGz1mPoY1VjSbMTf76Q/qaQ2AlNiKsDVrb9FNy6Tui7YJzAYw0lFp5gbkoGl0EXntaoNPY3Vd8UxPCgJrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETeVeqbE; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso1609928a12.3;
        Fri, 22 Nov 2024 08:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732293798; x=1732898598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nHfCcATJyhA1xM48D/qAWkDdE30ifu/pCsiva9LO/Mw=;
        b=ETeVeqbEepJLB1udexAwGU6wXH7y9waD00U0TZzDs4yPkG4Kv0MF/oT0+Ehp4RE4Zo
         sXJX04um2t/tV6IkXU7SAW8KXezD8V42suIqH+UrH6So31eTnL+w3pAnYUYrIL4CQHKN
         ig0rM6zRMiWKCw0xvMvgt0jj8S2ZlTq2fVeRZ2r0KF/Qop8JzTc4ByJpPjWcDucikrC4
         rl5kCDNxR4+lD8RDIyCM/lJGxnaWtcU6nwmSkrL94+cOhslvW6f8atCmPLoxtCBb9x3U
         Op1ZsV1hd18z80+JyrojnhuNpGEC202mey5XDJft3jMXhjokagOQEaGRCSbGoVZ16P2s
         DC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732293798; x=1732898598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHfCcATJyhA1xM48D/qAWkDdE30ifu/pCsiva9LO/Mw=;
        b=ZGplrixqeiviQ7PRBt8BNfMlEx3PXtR61Z0TRQxuLoc96FI3HRyQ1o2UFK/wTRslMs
         0g44h3DeYKWEP8QJJLXuH9KSTFzoMGHfE4RmZu2B4hXZ9DdIzeHpK3vi5U+OtnkZa2HV
         Kq+1IKbekEnbVJ9Cn13OVJQeA8D1kOUQII4uys7SbeBVzO3Fp6tKGKN5znq+f4zN9b8X
         ySsiD+ash35COj75morkntCp9eqHjcC9CKgMrgo30ugLE19jPKmc0HNIcsmeIDGG5O2C
         fD3nBsv611eHO+mDGkyegTwlYENSIAnN2rlmGG+TKs+ohKS5OhznHHiVkbm9Tu5Zuk0A
         ZXJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCqGmlBEcAB2DNKnBGyLK/8zmwhslcntXhRALwaxQUWdl1vCsQN8Ahd/H18ZVny1xEblxMxcirkiNrtrOf@vger.kernel.org, AJvYcCUZrsg4ZL7NGVdUnWhzZwNFqyhrc3y40cu9+wEpZzBxfCmucm1PRXUSUhhtf0CAec7XxDYSHTmGtjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaFi6ojIn0nC5SQaCYtKw7tb/7+AgdMvWnYSOx7OVC6k0VMcO2
	KuHlveWxrtyjeGX5FNOTlFgbXK0Nobegv9kLBbEi7Jj5wJ1SkLRG/1WnmA==
X-Gm-Gg: ASbGncvQUiy4jS8EkuUqHsgXoV+nFYV/LFtdCz4l9ow3A35PCu1dg05jSpc7174mhOb
	2GJqjQCEJSyL0L4yRnWJ0KZ4GcQI5jJ9QOGHM6qdjKvJ71tS+CIlMvD51TnqfPgyMsyej8H9t9n
	YwO4WNu12c5twIgrhaihkLsXD8qVZ3t0ac6zYHLeDKUZvgblqzN7Y4ijK0tnInNWYqqqs9kDd+l
	AsNu92AJJ3n37aVgaPtL9xRm4ENnQkuFtrHmONPD0XpPfE6iRkDgRoEtwB0w9/L
X-Google-Smtp-Source: AGHT+IGLUwQtqj1TJs07ST0ijMjbU/7PjnsuaVXgwaQrxxiGA8N61REG7OFQmsAgBafLD4sP8R0O/w==
X-Received: by 2002:a05:6a20:4310:b0:1db:eb2c:a74 with SMTP id adf61e73a8af0-1e09e409e2emr5439035637.12.1732293798248;
        Fri, 22 Nov 2024 08:43:18 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:1833:e6db:c7dd:9038])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e25cesm1856925a12.28.2024.11.22.08.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 08:43:17 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	dmurphy@ti.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	stable@kernel.org
Subject: [PATCH] iio: adc: ti-ads124s08: Use gpiod_set_value_cansleep()
Date: Fri, 22 Nov 2024 13:43:08 -0300
Message-Id: <20241122164308.390340-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using gpiod_set_value() to control the reset GPIO causes some verbose
warnings during boot when the reset GPIO is controlled by an I2C IO
expander.

As the caller can sleep, use the gpiod_set_value_cansleep() variant to
fix the issue.

Tested on a custom i.MX93 board with a ADS124S08 ADC.

Cc: <stable@kernel.org>
Fixes: e717f8c6dfec ("iio: adc: Add the TI ads124s08 ADC code")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/iio/adc/ti-ads124s08.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 425b48d8986f..f452f57f11c9 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -183,9 +183,9 @@ static int ads124s_reset(struct iio_dev *indio_dev)
 	struct ads124s_private *priv = iio_priv(indio_dev);
 
 	if (priv->reset_gpio) {
-		gpiod_set_value(priv->reset_gpio, 0);
+		gpiod_set_value_cansleep(priv->reset_gpio, 0);
 		udelay(200);
-		gpiod_set_value(priv->reset_gpio, 1);
+		gpiod_set_value_cansleep(priv->reset_gpio, 1);
 	} else {
 		return ads124s_write_cmd(indio_dev, ADS124S08_CMD_RESET);
 	}
-- 
2.34.1


