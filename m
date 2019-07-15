Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A23569B2F
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2019 21:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfGOTKY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 15:10:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37694 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfGOTKY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jul 2019 15:10:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so7867493pfa.4
        for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2019 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+w68P/RflnycNPzaHgCc3KB0ps9CtDDZmOzM+ZuWKXw=;
        b=LUafB6tHMlY5qgFlhZWCnF9qkr7gq1BPTvu5+XkTX7zuet7c9EwLBeiZuGWZNyyaz4
         NbHH3oIvOoGkdZcmFwUF1EQ+iSz+vrlDPsO2oaYM4p2MQoGxp4ne3b8+9xTGVP5MXqnU
         IBrOenpyTjpPpwS5Capq7uJCk/vavwO4V1qBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+w68P/RflnycNPzaHgCc3KB0ps9CtDDZmOzM+ZuWKXw=;
        b=hT/E85hTvdRlI3vcDw+0ey7cGQYNHD9wyEQ/1DAwvSmBaWxI5vPHLoslAgWLB2ZpJE
         2wnQryQBgpGaNjMoGV0XL4LiQCku2JVkDCLEcUQbqIy0jSrBdAo6uZzS+12UclHluiTz
         oXVo1CcHtpdD91twUiS+SNWc8SX8yIq/JtD/hNkbz4OGTBqqMSNIiG5MrNesuy5l4k92
         71vX3WCUeyoyIsqGaGMZ4q+f8zki0m57ec3k39o2LRG5NuvtM0+wnYRQWSG+KM8Eoq71
         Mdf4kBqISW9/tilfw6bsEKzbZA/OBq5x7ACVcdpW1g36NB1Gme3SH3O+pEoqehRIkmvv
         VHgg==
X-Gm-Message-State: APjAAAXCryuSmlXKxLCT52VIwQIEgcUS83JArfsDODyMnnTpdMJwznId
        TBRKrKJAdhsyzhWEYBLlmkEWwA==
X-Google-Smtp-Source: APXvYqzWfg6LLQbsHj2G2tia2ocmOfcuud7JEZ1ygUWjKr+Bqe/CimGgh9XM/QoOMv6LVAkRUsTgqQ==
X-Received: by 2002:a63:89c2:: with SMTP id v185mr28193637pgd.241.1563217823684;
        Mon, 15 Jul 2019 12:10:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id j6sm22960102pjd.19.2019.07.15.12.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 12:10:23 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] iio: cros_ec_accel_legacy: Always release lock when returning from _read()
Date:   Mon, 15 Jul 2019 12:10:17 -0700
Message-Id: <20190715191017.98488-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Before doing any actual work cros_ec_accel_legacy_read() acquires
a mutex, which is released at the end of the function. However for
'calibbias' channels the function returns directly, without releasing
the lock. The next attempt to acquire the lock blocks forever. Instead
of an explicit return statement use the common return path, which
releases the lock.

Fixes: 11b86c7004ef1 ("platform/chrome: Add cros_ec_accel_legacy driver")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/iio/accel/cros_ec_accel_legacy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 46bb2e421bb9..27ca4a64dddf 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -206,7 +206,8 @@ static int cros_ec_accel_legacy_read(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		/* Calibration not supported. */
 		*val = 0;
-		return IIO_VAL_INT;
+		ret = IIO_VAL_INT;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.22.0.510.g264f2c817a-goog

