Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0A6368AF4
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 04:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbhDWCKn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Apr 2021 22:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhDWCKn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Apr 2021 22:10:43 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ED1C061574;
        Thu, 22 Apr 2021 19:10:07 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x20so44889959lfu.6;
        Thu, 22 Apr 2021 19:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z1+bwtZ0MCH93R65mDiW9cH6H6AcURGrd4JDJqJEmgc=;
        b=bVYgDSersnQPTNwFZ5U4L2TdNqQEwG/XxNxk5gsxa9RClV04efBLGHXii2ocYQvKye
         U4FlkFjuaX40TRqw+iGRxtM8d/MutlmMhcNaAFiAiF84T9+6MialivSIVIC/3rC6ga/h
         7ODi7ox/VomAxQqGeRo4ohFLqVPV4jSmx/8SXbpvp/FzULat/fPoqcZ7t3SouiN7mcSy
         ZtXja95z0hYlmZyewkTLqfV6MO2P2ygFw0F0IDwvUDt0GTxggbHdtbE/kyo84zVHDoO+
         lFJNMeoOFxXfEoKWInmCn6tGY32btFmQ2v2bJtb6YhCFwHagBPsHEUtU0L+Hjl23RNUJ
         owLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z1+bwtZ0MCH93R65mDiW9cH6H6AcURGrd4JDJqJEmgc=;
        b=N023KWC2cn4X/IgfCJuj5A17prugEVzvlzE3ZY/spWN2+dVi6VL3cnMNj/OQlQ8zqb
         R4YzpYT7+S0xrWyapVAZbjHCn6EH76b5+Z3Y1SUNjODFyRxqz8vf1bPQeuqHVtOQ8aqp
         ChmlPPORIafe54AJUNF4BzqW2uSN8CSgPlmnNsLAS4ZA0egy8HzKyUy14UZ87lDvbW5T
         K9Djt682Xs4zDVexTpMEw1Cz8EK17rN1sF8bMvJsB6C0C3/vgEx/F9SvrrxyHE0CJHfo
         GziVHKetqbDbvrfZpkimf9LB0nRIOd7mVn/r7mjcGSr/KjmDPRejX/eMKOx8AKXe7WDE
         RHRQ==
X-Gm-Message-State: AOAM532/Jm/SnupvGQKUYvQdvpfD3xR8pqk6DSYwY8wp0l8Ui/lmFxiL
        MzNyz/xBH7ajr0DsATFdakQYbsAEreA=
X-Google-Smtp-Source: ABdhPJzCUNy7RSZ0rRYYdaJdRHecEatv3L3wq8P68hRsRzxxrSWPuZppXtcM8BT5V2M+OnfWBvTQtw==
X-Received: by 2002:ac2:4c85:: with SMTP id d5mr921854lfl.79.1619143805558;
        Thu, 22 Apr 2021 19:10:05 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-103.dynamic.spd-mgts.ru. [109.252.193.103])
        by smtp.gmail.com with ESMTPSA id m19sm416489lfg.140.2021.04.22.19.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 19:10:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: gyro: mpu3050: Fix reported temperature value
Date:   Fri, 23 Apr 2021 05:09:59 +0300
Message-Id: <20210423020959.5023-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The raw temperature value is a 16-bit signed integer. The sign casting
is missing in the code, which results in a wrong temperature reported
by userspace tools, fix it.

Cc: stable@vger.kernel.org
Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Datasheet: https://www.cdiweb.com/datasheets/invensense/mpu-3000a.pdf
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Asus TF201
Reported-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Andy Shevchenko <Andy.Shevchenko@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

v3: - Improved comment in the code, saying that the temperature range
      corresponds to the "best fit straight line" range where temperature
      is reported reliably, i.e. in accordance to the linear equation.

v2: - Replaced "signed 16bit integer" wording with "16-bit signed integer",
      replaced "Link" tag with the "Datasheet" and added "Fixes" tag as was
      suggested by Andy Shevchenko.

    - Added r-b from Andy Shevchenko and Linus Walleij.

 drivers/iio/gyro/mpu3050-core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index ac90be03332a..f17a93519535 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -272,7 +272,16 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
 		case IIO_TEMP:
-			/* The temperature scaling is (x+23000)/280 Celsius */
+			/*
+			 * The temperature scaling is (x+23000)/280 Celsius
+			 * for the "best fit straight line" temperature range
+			 * of -30C..85C.  The 23000 includes room temperature
+			 * offset of +35C, 280 is the precision scale and x is
+			 * the 16-bit signed integer reported by hardware.
+			 *
+			 * Temperature value itself represents temperature of
+			 * the sensor die.
+			 */
 			*val = 23000;
 			return IIO_VAL_INT;
 		default:
@@ -329,7 +338,7 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
 				goto out_read_raw_unlock;
 			}
 
-			*val = be16_to_cpu(raw_val);
+			*val = (s16)be16_to_cpu(raw_val);
 			ret = IIO_VAL_INT;
 
 			goto out_read_raw_unlock;
-- 
2.30.2

