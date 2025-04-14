Return-Path: <linux-iio+bounces-18092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D471A8879D
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 17:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DF41885FB8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEE9274FEE;
	Mon, 14 Apr 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUQAF4GS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B7274FE1;
	Mon, 14 Apr 2025 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645192; cv=none; b=LwHQGm32zmI5eaP/8o+HbRDGC9mSEYdaYtH8D1rxOHwcLyGMq5LmEYXpaRwLfFZysD7DoPXf4urTQ/ngyxXjSDn2/LHZs5GHH5nfepnn9YqEcpyhimLnBqL2UIlVK4UOdInrsSfvOBAaJrbXpMEoP68YxSLgLL0yBcwXoCMtWGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645192; c=relaxed/simple;
	bh=Shx9w5ToVCi4sff7w0CjLM7Z/phSkqNv+tYwUPKOOTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oUXzN4oma7zoy8vrKM+H4hhl09BDbsS4Bh6l8GKvhcQ0MfsSsunnawbzLeGW3uZOUipPk/0GNofAz7gzEfbnHWZFUONaB2H0b/IK4XadX8fIAumCrFJQJ/u+Xk2NyxqOZ47XeHlnwr1z2Xe/6ItdyUePX9CYvw5LeHLHe4ixDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUQAF4GS; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4769bbc21b0so39726231cf.2;
        Mon, 14 Apr 2025 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744645189; x=1745249989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mqOeOTVBHYK93IJiadkRz71/O+ouQlq6IAs4FzVsl24=;
        b=mUQAF4GS/vw+0ZXg7rftxYVpflpx8RJi1ewnLZsWqDFrXIGPYs93GrROatrpuOz4u7
         WeGH+F22VzO0eCQ3V6m/rYBV9jHdFQLXaWaWj8229u7UU/HGW88vMWFdIDvRW/OKBDAY
         xj7oYtKBIxnXpiI7R1f5ZEPmQaR3qteryYt4CJcbP2WGcGyol+tYN0PJQOkNu6SDzCOW
         NmINRUlg4YxfxBozySbkRbLQ9J2tdLgPZp5JFQqanPeM/+Ua2BodTcXF+/mVV5L5safq
         SxSVCdZHuF/W7fSNpcLQIuif41pTPSqCU3G17tBvwcRlF12udmMGv6pPAJa4we5ziu2J
         ywmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744645189; x=1745249989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqOeOTVBHYK93IJiadkRz71/O+ouQlq6IAs4FzVsl24=;
        b=fooyffGF/afUIbqfvCqJVP3BzZFf5LsIzxzUn6o4Yc4tgTmv6sdtNAtOyPhtE9VdXc
         Xaa6+nD20r9NL2DMfrCAqyucL0QHp+fGAHLzSIj/u0xUfnm4S2hbvv+2zq95sicgdO3Z
         py7byYSMxfDldwcUUBJgPZg+eu1RJCJjM6O+zRCYtoh/njsMQhmYKP3Sw2d10VCY9j4H
         SzxIxa2HbUhO3OlI5YnIni0bygAvD+Fo0mBRdNGl1F6dZyShhiBFssQefrCVG+jRbv2E
         TaRvY/WFRCee8bPHRiuGqiR1hrt2YURlkJV1WLKQV/FFtsOLbS8WxJRv/mmPsX+pY8AD
         jzdw==
X-Forwarded-Encrypted: i=1; AJvYcCU27mThhtT/AlV7Dx5/DdA5OfEIcmQfjP+KRh5BpIvD6GTP3TXXWlqBMlmdf42pneCR4J+OfCheFDy68792@vger.kernel.org, AJvYcCWCOG7aiZaWB2fGH/oOUC49m1dIXzkqHQ0XEGjckJeIO/MwZLBqD61hcgwCRLeWTWLh3U4eHsWF2jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/FeIh6z1GY0AHBkhsQmUgQx45UxgLppFBb1H8p3u17i2l0ol
	ZpthFLfqad9fLjnPOmgw9EWfCaKKRAiUXrxj78C3TKXXYYryVyWV
X-Gm-Gg: ASbGncuqMwLA+0HZhYeRQchKJLQDYRz0hzNk0BwXnEiMv3mSMnfJpGPTA8+Z0eQXaZB
	5SfKPSJfU6Q+JwQJx5QaBXZ5QYIZ3kMhfbH/QQ7o0YIU/p9j0RB8Cc6Mmpd/9yVA3FkeXyV+CY8
	STitpGE1YGyW3mG4avMcIop0tO1De/hCvCBDF7KuEuBbiM0fqLTBy4zUxztaTBl3BDswp4A/rh0
	hJjlo0xzl7J0TEDL0Qk/artbL7cBcLV7daI5965d4HZ6iGnmVolaPonKWo7O4Di9LgVVaiL8knw
	pN0UMi8fpj0/R7a3xk6tDqbcfcbm37j2sRiUKAuyOeEPST0bobrkJ0nWbMD9xVykajVSuqQVtH/
	+n2xOWaye03t36APjTd0=
X-Google-Smtp-Source: AGHT+IH057zq5PF2wKNUBLrpJS8WguQdnGVsVYpLyP7i4b7sKKSPZxFk3wRU/LDT3qoycsQQ2vUU8Q==
X-Received: by 2002:a05:622a:1107:b0:476:77a5:3104 with SMTP id d75a77b69052e-47977523b4dmr214167571cf.11.1744645189045;
        Mon, 14 Apr 2025 08:39:49 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4797a21aae7sm57700791cf.16.2025.04.14.08.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 08:39:48 -0700 (PDT)
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
	kernelmentees@lists.linuxfoundation.org
Subject: [PATCH] iio: adc: Correct conditional logic for store mode
Date: Mon, 14 Apr 2025 11:39:46 -0400
Message-ID: <20250414153946.469354-1-gshahrouzi@gmail.com>
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


