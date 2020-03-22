Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABB218EABF
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgCVRXn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:23:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33462 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgCVRXn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:23:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id j1so3563031pfe.0;
        Sun, 22 Mar 2020 10:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=76TwRjRKJI+gH0FRwyhrG+QsrYGl4l8tRg46jH9R0kA=;
        b=LqaFDxG0/wxR7NtrwEQg/cHEmNo7flL0qP/UA58ljUOFvTuOxwFZyjGo809rCZhRMk
         g7a9kzsV6woYRqIIkcDeBMJpb8gPUKmsntpqOb8fK2t+XFg6QdbNiczT/rGpd/3jYGKv
         5LjWHq3h8PHwE7syi336tEf8GqA6Rb58Y0mF1anPYlGGY2fA4/ZbsFflhjDeB/TmR2OF
         Rlj3gVJ0GJuvq32F+nG7ww+mt887U1tEtqu1RRPWpeft3saiZ0aTfRe5b8fdjRPxm+sb
         cByDBHaItmCjp/lVve/PLj7RKYKe5DzrMoUTRoTvlhjHQCW2IsDQTTMMkSioyeaRKE3f
         Sg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=76TwRjRKJI+gH0FRwyhrG+QsrYGl4l8tRg46jH9R0kA=;
        b=qn0x7Cirpla5W5u5wA36mbOpm7H6Mi7Rh6H0/bAgqaFDX76qgtsTKGBy7bT5fcnJVN
         IXd9sa/gLETUyq7nj9HWaGQBJsAJDUJwmOpZr/4MsPo8x063fCSMUSOiDzQeMaMWIuOO
         aKPIWWogvfOiTSBInXkq3DJwXcnmoZX4emZsILqXANqwakdXUsLaDepq6rAMgbOTUD8w
         BawLIp0Ltg5WXk3AF6w+jBJa5Vo/Gu2Nxbdcw9ioCaPkEYKs8caN3/wuz0DdO9NtPySi
         OXiasN9C1YVtO5Nd4kGInLbBH/0v+EQSV0abR/V3WSkumG6F710IbpR5rpn0UjYdE5on
         GyYw==
X-Gm-Message-State: ANhLgQ1P046aECf/spAB0WsUAN6mMd4tNg7jZBv5ipYORn2kqguATGU8
        80fb087r5REyFWqVDfb7nyWB5UqxjcY=
X-Google-Smtp-Source: ADFU+vu7BgIPeAFmXmkg25HJEQFzMDfFvDCfi4aLJBjtG3innZRrow8yoflmXhvRSQulLtttoym97w==
X-Received: by 2002:a63:794d:: with SMTP id u74mr5797759pgc.15.1584897821646;
        Sun, 22 Mar 2020 10:23:41 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:992:9f95:b1e5:4cbf:6219:65ee])
        by smtp.gmail.com with ESMTPSA id 63sm11087191pfx.132.2020.03.22.10.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 10:23:41 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/13] iio: st_sensors_spi: Use vsprintf extension %pe for symbolic error name
Date:   Sun, 22 Mar 2020 22:53:05 +0530
Message-Id: <944c9c32f38a46e9c8589e5297866faa12b2d4ed.1584897364.git.nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1584897364.git.nish.malpani25@gmail.com>
References: <cover.1584897364.git.nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Utilize %pe format specifier from vsprintf while printing error logs
with dev_err(). Discards the use of unnecessary explicit casting and
prints symbolic error name which might prove to be convenient during
debugging.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

Changes in v2:
  - Rewrite commit subject line outlining the usage of %pe.
  - Add a separator between regmap and its error name.

Based on conversations in [1] & [2].

[1] https://marc.info/?l=linux-iio&m=158427554607223&w=2
[2] https://marc.info/?l=linux-iio&m=158481647605891&w=2
---
 drivers/iio/common/st_sensors/st_sensors_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index 1275fb0eda31..efa93928b498 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -101,8 +101,8 @@ int st_sensors_spi_configure(struct iio_dev *indio_dev,
 
 	sdata->regmap = devm_regmap_init_spi(spi, config);
 	if (IS_ERR(sdata->regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap (%d)\n",
-			(int)PTR_ERR(sdata->regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap: %pe\n",
+			sdata->regmap);
 		return PTR_ERR(sdata->regmap);
 	}
 
-- 
2.20.1

