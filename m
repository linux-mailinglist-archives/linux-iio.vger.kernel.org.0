Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BC0445026
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 09:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhKDI1A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 04:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDI1A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 04:27:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705F5C061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 01:24:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id n85so621474pfd.10
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 01:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Feq0h+YQ890t+lGo5iwncpQJOuAUT7hzdpdax9qSy+4=;
        b=N6rHksfRHzjuWEh27X1XAWR3aKYvrBtK1qMxXiKxTG9eCWdpc51FoJSfiRng6iA93o
         q0DIkv0Jdk4EvwxxAaB1XliWZbMg38K6BOFErlWZiz0XFh1q/60+xQvXQufOzVUefcqX
         361IaPHsCRPDmDG6OYcvHGce4QSFNJbZ4C3do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Feq0h+YQ890t+lGo5iwncpQJOuAUT7hzdpdax9qSy+4=;
        b=IbNk8RMrD/IEfP7B/DapcnS22IrI/rQJ9c8xQJfwLKOx0l4+KxXxJOCY0cidLMuXlY
         R2uBeH/Zl8rTCWBM7zWOz5izndZPlIGAL/jvOUJQW4jFWGN5QW4bVLELb9JUe4XWVUQE
         +ZJNUG4qmUGezAK7fumcjX/kLlsOkisEFsuWNOq7zYyZsD73Zzffh1mMkMmFf7YV3VyK
         xvFVkJhBhNkFp3548S5ctsgI8rbNzZtyw3TK01VSKlrzWHvf4jV17GrodFhg4Ju836YG
         GEQcd8da0LuLsayAjX13lgZn1rFsTceSlMBE3ub+zm9fsHOldCkRIRJsjn1NQABW29cY
         GQUA==
X-Gm-Message-State: AOAM531So0ml3kA0LsxK67Hds+xFrATPv+OY4frm86ha+tzIu1mv0g7w
        Ve2aMLUkzWJQKY3HGxeDrPzPnw==
X-Google-Smtp-Source: ABdhPJwYx0SKOT5r6073dAPNNYG4tUJmyhz3kLHXCGnDSaXoaTSw9ogUu3QnUd7bFi0gwkt6gk9iag==
X-Received: by 2002:a63:8943:: with SMTP id v64mr22016990pgd.87.1636014261895;
        Thu, 04 Nov 2021 01:24:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id p1sm4805837pfo.143.2021.11.04.01.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 01:24:21 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 01/13] iio: bma220: Use scan_type when processing raw data
Date:   Thu,  4 Nov 2021 01:24:01 -0700
Message-Id: <20211104082413.3681212-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211104082413.3681212-1-gwendal@chromium.org>
References: <20211104082413.3681212-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use channel definition as root of trust and replace constant
when reading elements directly using the raw sysfs attributes.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/accel/bma220_spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index bc4c626e454d3..74024d7ce5ac2 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -27,7 +27,6 @@
 #define BMA220_CHIP_ID				0xDD
 #define BMA220_READ_MASK			BIT(7)
 #define BMA220_RANGE_MASK			GENMASK(1, 0)
-#define BMA220_DATA_SHIFT			2
 #define BMA220_SUSPEND_SLEEP			0xFF
 #define BMA220_SUSPEND_WAKE			0x00
 
@@ -45,7 +44,7 @@
 		.sign = 's',						\
 		.realbits = 6,						\
 		.storagebits = 8,					\
-		.shift = BMA220_DATA_SHIFT,				\
+		.shift = 2,						\
 		.endianness = IIO_CPU,					\
 	},								\
 }
@@ -125,7 +124,8 @@ static int bma220_read_raw(struct iio_dev *indio_dev,
 		ret = bma220_read_reg(data->spi_device, chan->address);
 		if (ret < 0)
 			return -EINVAL;
-		*val = sign_extend32(ret >> BMA220_DATA_SHIFT, 5);
+		*val = sign_extend32(ret >> chan->scan_type.shift,
+				     chan->scan_type.realbits - 1);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		ret = bma220_read_reg(data->spi_device, BMA220_REG_RANGE);
-- 
2.33.1.1089.g2158813163f-goog

