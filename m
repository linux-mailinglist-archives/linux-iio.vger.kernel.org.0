Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164693675E8
	for <lists+linux-iio@lfdr.de>; Thu, 22 Apr 2021 01:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343768AbhDUXu1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Apr 2021 19:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbhDUXu0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Apr 2021 19:50:26 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B4AC06174A;
        Wed, 21 Apr 2021 16:49:52 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a1so49724411ljp.2;
        Wed, 21 Apr 2021 16:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5rLqatd0/cPLTKtVbdK7mYIU6Py/40xQ4LKl2quF0qk=;
        b=h9AgVeqfNYvmKTbZiu5GNcEmw9xgAeFCaltYCTxxGreTrtwN4fpvS1sV7J5Sw3csX0
         hZJc3ERjkk0FzYCvHu+PlVfVCwEvBGAADt6aZpqxDshtBF6bElhJj03YZ0zxsB9LM/yT
         axXwjmoaoUhLLj7E1Evw/YqWayBwHemfikEaZkihF4WEzQsajNSCLmC0FPVgPFalorAn
         j4YLzjZYKG7pEo3XKjjzJXLZrpjeltmpldIRjpVpQ3dsrhGbDHLhmIwxBwgCziKQXbjl
         zfKfDDDXPJwvNNstIWsp0/CmWKw+5v9OVzbUERAbBlemo9QtNCWbrWISPuSKYB1YtPEm
         XD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5rLqatd0/cPLTKtVbdK7mYIU6Py/40xQ4LKl2quF0qk=;
        b=F/58YdzHzwD2x13OUWB6RkMIqzzCbLs+y2yhaSHfrzZO84/skvJtQtVKPHeqwlzMTy
         VJr1Ma/KyNNxcScN3zLDGSNQhNiHNSWCSECOQXsYOFwXofOa0I6SSOqgdGNLKQYDML7i
         WpnijLz/jxRrDq7sMrChMyRQdseMImQQTsLsgn1bOh63B/02n46UDGbqim/OqIMzRNAm
         aNVcNp9LPyQNNpXhMOurc6KqcoDwRb/cJGaI5bVk1tVWZ/PCGzVP0S1dA4p6VXrsel+t
         MB22YYiCllMUGI7RR7FBdVKSoOYDhcSL876LCoY2P9tIQX1204qhPzYlW8Pt0xl/5YNR
         2IVg==
X-Gm-Message-State: AOAM530jwlGDF2gFUxHyZcpEooDL1MHyltV1L++nXxHd+19O/yIqxvSi
        g2mYbZMHOrEx9MT6TB/8DIU=
X-Google-Smtp-Source: ABdhPJznnuxx9XBJ1JQpBCbM/IsT0QdoG97Yok024S5D1tB8/C4i/WG4Qic7AUaBEL+kn90VQWucIg==
X-Received: by 2002:a2e:7119:: with SMTP id m25mr490630ljc.231.1619048991396;
        Wed, 21 Apr 2021 16:49:51 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-103.dynamic.spd-mgts.ru. [109.252.193.103])
        by smtp.gmail.com with ESMTPSA id u6sm94758lfr.164.2021.04.21.16.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 16:49:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] iio: gyro: mpu3050: Fix reported temperature value
Date:   Thu, 22 Apr 2021 02:48:20 +0300
Message-Id: <20210421234820.32211-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The raw temperature value is a signed 16bit integer. The sign casting
is missed in the code, which results in a wrong temperature reported by
userspace tools, fix it.

Cc: stable@vger.kernel.org
Link: https://www.cdiweb.com/datasheets/invensense/mpu-3000a.pdf
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Asus TF201
Reported-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index ac90be03332a..9885428ca12e 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -272,7 +272,16 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
 		case IIO_TEMP:
-			/* The temperature scaling is (x+23000)/280 Celsius */
+			/*
+			 * The temperature scaling is (x+23000)/280 Celsius,
+			 * where 23000 includes room temperature offset of
+			 * +35C, 280 is the precision scale and x is the signed
+			 * 16bit integer which corresponds to the temperature
+			 * range of -40C..85C.
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

