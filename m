Return-Path: <linux-iio+bounces-18089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA98A88772
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 17:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9090A3B57FF
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 15:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A6E274674;
	Mon, 14 Apr 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxDmIo2/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A148A192D8A;
	Mon, 14 Apr 2025 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644793; cv=none; b=fsZBl1CyIKT4cNiFi4FGOnmTh4Oagl6572lfitHWfDatliPJJkNvAL0ORAnOOY/XFPIuHUOHr0pZ5fQxLbfWHYQm/p6XpQzrNp42PyYkTL3OSWYkDeer1r1qn96tn1xMP1STpoSTUDmf45BNq8QKlIRFxB5qekr24oHgZUAE6xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644793; c=relaxed/simple;
	bh=Shx9w5ToVCi4sff7w0CjLM7Z/phSkqNv+tYwUPKOOTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKshjovJexVIS2/YhQP7WZAXFgI166t9yKLuqKfp5cAtwU8nYR5vLjq3es0cPzKmnD95TrIJrvw28NTd6ivY/bWOFmU7m2Itq2M4WH9kXyIzAwBns19VAY4DuaA5GpQbiREF44UWCX9MA3R49cPAL+WHq+XjQ4ZuE72FuJZHMtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxDmIo2/; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-47692b9d059so58256121cf.3;
        Mon, 14 Apr 2025 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744644790; x=1745249590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mqOeOTVBHYK93IJiadkRz71/O+ouQlq6IAs4FzVsl24=;
        b=YxDmIo2/jX/Oro4aI3ZVIcEsG0plAUKZYtXzAsKAZyAxO6qNizQUt1hqhSj3jjoHgk
         4r2Q0xlr2P2cUPHRuQNG7JeeOuM00tUuWlhj5tB9zX7esJO0uBVyEijKE5rW19L/LJhr
         urEFt0FxH6hgqNljEHw15JT/dt+n1/9ANIA+TJ+opy9Dl8IBeHzs/KGwTkvL8w03uoFm
         eylqUuUnMZ0U0TGj0RGIn7514S+uyJRThLNfhJwtLSAER0Yi8F5W1Q2TMMa0dHZ9D2J4
         PtcIL+m6ERRqlJxiHhkEeg0gbLmpcDjAfWcyh6Ged2pWS9+QHEkKDEQjK4EgBOo8Sp4I
         /2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744644790; x=1745249590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqOeOTVBHYK93IJiadkRz71/O+ouQlq6IAs4FzVsl24=;
        b=CHPpOLFtluLWsQsTmAdzbXa1aUarkZwgrBoR4vef/cpGGp09OWVT5o8erRy8bQgXKw
         nChjVWYIa6fYZDKH0dr3V2vaiseKEhephfEUxjwIzsNZDZ/4UvtkJwbss+YxyQfMxX0r
         Kxztk1EuNog8UwhjkOzAPtZgprf3+YMYUwKj1z4YFC+vsh2Xoq2+HqDz1YtEumHqiaxj
         FcBdf2ecT35vBwJTibyjnIBsZtPa7gtw8XEtpoNuzccP1SzmvQMd8UYf9icD5LZtbccS
         FaKsOv1UDTb+pR+C4LBzos2ocr6SmV5DrxsiJVXckXRo2AiSG1/PiwyA2idEA8xFa0zK
         txNw==
X-Forwarded-Encrypted: i=1; AJvYcCVtGwiFrf4I5vk+I2YMqxQfh6oD2hSFXEhgogYiiMdzlm6i/mPTP+z/XSL90llPgMtLa15eILRFIX0=@vger.kernel.org, AJvYcCWVY/qgHXMEvajB5FN2svhjGCpzmBQmHiU0D0ma+6xt+wqkWkNn1+KhTOqlduZRDqRuYoPfOnb8@vger.kernel.org, AJvYcCWoBYmRFQwAos6ZsTmb5D2WXBvR+n5zhHl+HS9pZZLWhBxhNYFvfe/rU/Bh7Gra+D/+MJ4Uk8tZkN7zx4Lh@vger.kernel.org
X-Gm-Message-State: AOJu0Yybr3WNA5f3p0VoBuj9CGh7JhehEGg0SXin3FysWvWd4Fph/RfA
	GqKu7+MKVkJr8WqSwJ0q9P6Qoc6+gxtP8VMT7X0WOwc19QRTEagZ
X-Gm-Gg: ASbGncuH5wWwDHdyFQG6nbUETvabjWLeGajUUIby1AR+J52ao8gtsiGSkvBpwuW4Hoy
	JM65dGsTd+mrVBJm3FSuwZq89Nf9P7S2Fo0mS7Iy9NIY3pQeiclgchyAzAp2CgFMExe7Tlm6A94
	gM5ADyhCjVOqCEnQcivbVpOHomiJbdfK/xFCup+Nz3QeiRvhnQfYGJ+MMhduTlrhoE76Pp4b4Ox
	fMLtsmIywPEafwj7t2+tcZv0KlI+54s7bvWSv5EyAO5u6Td1VsokkjZU7iw48v1OuOcxBqaYEGf
	sh+Oyg5nFfm7701ewFK1c3Ujf6NCh/GsLxb1k4PiVXsYWEjJ5w5W2HCVBSC54Sov+PVoU2MJ1+K
	oeDKHIoorLF+zuHtNDVA=
X-Google-Smtp-Source: AGHT+IFCLt0ApqsTq3XSso3U4ONT+jE0KrQ/fisUlyIY/KK1qUJCT+C3nq/DixG4n6Rq/m74n33oeg==
X-Received: by 2002:ac8:7d43:0:b0:476:91f1:9e5 with SMTP id d75a77b69052e-479775e989bmr229803901cf.50.1744644789837;
        Mon, 14 Apr 2025 08:33:09 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb0b26fsm75956541cf.1.2025.04.14.08.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 08:33:09 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	kernelmentees@lists.linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH] iio: adc: Correct conditional logic for store mode
Date: Mon, 14 Apr 2025 11:29:20 -0400
Message-ID: <20250414152920.467505-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mode setting logic in ad7816_store_mode was reversed due to
incorrect handling of the strcmp return value. strcmp returns 0 on
match, so the `if (strcmp(buf, "full"))` block executed when the
input was not "full".

This resulted in "full" setting the mode to AD7816_PD (power-down) and
other inputs setting it to AD7816_FULL.

Fix this by checking it against 0 to correctly check for "full" and
"power-down", mapping them to AD7816_FULL and AD7816_PD respectively.

Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>

---
Changes since v2:
	- Add fixes tag that references commit that introduced the bug.
        - Replace sysfs_streq with strcmp.
---
 drivers/staging/iio/adc/ad7816.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 6c14d7bcdd675..081b17f498638 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -136,7 +136,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
-	if (strcmp(buf, "full")) {
+	if (strcmp(buf, "full") == 0) {
 		gpiod_set_value(chip->rdwr_pin, 1);
 		chip->mode = AD7816_FULL;
 	} else {
-- 
2.43.0


