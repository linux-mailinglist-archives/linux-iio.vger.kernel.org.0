Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC22259A
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 03:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfESBFK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 21:05:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55193 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfESBFJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 21:05:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so9996783wml.4;
        Sat, 18 May 2019 18:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EQEfknT+Pvq496JYf3bTAv5KronZjseZKCaJZPgbjH0=;
        b=pRUr/6Z6CuZgZtbgnrrOWcWxfnPOW69i939s1wdUmEar6q/feiA9XbLQlxHt3J9n7m
         q39AhEelGr0lZVXGG6LlBBwjnQS2XHi419ZKgy/ySYKn2E4GihGe2UIlrJZngV36x8di
         FfzUBvQuhGYCmk3XYDWedMeBbWXK1KuL3m6t+LTXTyBP+mUUMo5ddcYgHJMN0SOosfiF
         RfaTIqHfVRP2x7ilKi62wfFIY26/cRZzIG55XENf4zL9WY59DI2sVR7hTXtYg3X0TJrt
         Gj8yZmWSBSNE7PYbQhnNNbFvpeE7Zts5w1+O5xCeTbg6n8ojtMptXdz3lRB+yhCIy/CW
         EFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EQEfknT+Pvq496JYf3bTAv5KronZjseZKCaJZPgbjH0=;
        b=XIfKeE7DyY1TLJjq4x4vMWNG8xH6l8HU0b8mJFrYX3h3/UH6/YrwXfmM7azAUfFou+
         Kgvhbo3TfeOwW0Ajzb+o2AtUpXyL+95Y4rqOzN5uXp3qaHDN0JRC/tZYMLfhLcKpWKBP
         Fd532KbLEH/PLt+FjovLWxKZeYf3QkPot18PSiZnlQ/8058Ny3iWkNf8z7sugFSI1385
         I/l7l65wtmJeT1KbuvU9gbBHpOZvZwJNkn6uO9bxYc7ABovVHXdsjOsCBNECgU0OgpY8
         TlzDIv8K6ecwlfhTzljesXjBAxe2S2xFhkRZNg40sEsXSJcfQu0O44eQNVfAftYc43oF
         X7Hw==
X-Gm-Message-State: APjAAAUSlw7XTE55v7bnOPWTTzm+c7g7ko2KV/jnEMrAzlIjdPNkh0fm
        n5ojL0jeCNDE10KbZddMMh4=
X-Google-Smtp-Source: APXvYqyDyZ2OPbtG1vVkFrxQurfhlNIGM/0qiHcfFqPQZr9B1M1FERztOCTjLSZbuOaP8vskS+nTYQ==
X-Received: by 2002:a1c:2104:: with SMTP id h4mr6868266wmh.146.1558227907595;
        Sat, 18 May 2019 18:05:07 -0700 (PDT)
Received: from smtp.gmail.com ([2001:818:dc0d:4d00:bee4:6ffd:a011:52a7])
        by smtp.gmail.com with ESMTPSA id f2sm13553440wme.12.2019.05.18.18.05.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 18 May 2019 18:05:06 -0700 (PDT)
Date:   Sat, 18 May 2019 22:04:56 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging:iio:ad7150: fix threshold mode config bit
Message-ID: <20190519010456.lwq7n2e6nkqa6niz@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

According to the AD7150 configuration register description, bit 7 assumes
value 1 when the threshold mode is fixed and 0 when it is adaptive,
however, the operation that identifies this mode was considering the
opposite values.

This patch renames the boolean variable to describe it correctly and
properly replaces it in the places where it is used.

Fixes: 531efd6aa0991 ("staging:iio:adc:ad7150: chan_spec conv + i2c_smbus commands + drop unused poweroff timeout control.")
Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/staging/iio/cdc/ad7150.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index dd7fcab8e19e..e075244c602b 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -5,6 +5,7 @@
  * Copyright 2010-2011 Analog Devices Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -130,7 +131,7 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
 {
 	int ret;
 	u8 threshtype;
-	bool adaptive;
+	bool thrfixed;
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 
 	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
@@ -138,21 +139,23 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
 		return ret;
 
 	threshtype = (ret >> 5) & 0x03;
-	adaptive = !!(ret & 0x80);
+
+	/*check if threshold mode is fixed or adaptive*/
+	thrfixed = FIELD_GET(AD7150_CFG_FIX, ret);
 
 	switch (type) {
 	case IIO_EV_TYPE_MAG_ADAPTIVE:
 		if (dir == IIO_EV_DIR_RISING)
-			return adaptive && (threshtype == 0x1);
-		return adaptive && (threshtype == 0x0);
+			return !thrfixed && (threshtype == 0x1);
+		return !thrfixed && (threshtype == 0x0);
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
 		if (dir == IIO_EV_DIR_RISING)
-			return adaptive && (threshtype == 0x3);
-		return adaptive && (threshtype == 0x2);
+			return !thrfixed && (threshtype == 0x3);
+		return !thrfixed && (threshtype == 0x2);
 	case IIO_EV_TYPE_THRESH:
 		if (dir == IIO_EV_DIR_RISING)
-			return !adaptive && (threshtype == 0x1);
-		return !adaptive && (threshtype == 0x0);
+			return thrfixed && (threshtype == 0x1);
+		return thrfixed && (threshtype == 0x0);
 	default:
 		break;
 	}
-- 
2.20.1

