Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2220218EAD3
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgCVRY3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:24:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42639 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgCVRY3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:24:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id 22so2661562pfa.9;
        Sun, 22 Mar 2020 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eoICbZdrd63nRhP9W5legHD2adGutvhEft5WhE/G10k=;
        b=Fz7IizoyXm66jwJQrY9CDambmJPHpX2RfQjmLDayM02jE0jIyj5RvCSSnmREaIK7Fn
         L5PXE8EIA0yCuq79kwtW0N+gslcZDeU/B0k0GcA557LG6DxvAAQUeXR3ZChek0O/lu7m
         Xk0Z93csBmvR27nbgF5BkuiQUcJvLvd26lRnDkVYz6W1r3enuwnCS1gcoUD2L/L6djAa
         49APvurYzSK5x67lTy0IdFRFPi/QYtvjgqoMzSZHl5sv0OofKFcb88iv7ezLb3AtlECy
         eYkMRoUAFLt1mgMRdTmBqfTysTh2dYNYKjSgIrqU3K/9f3u/yrHRdpGna1D8bgvLGMTk
         Rqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eoICbZdrd63nRhP9W5legHD2adGutvhEft5WhE/G10k=;
        b=j+P0USnyn+d/UZ87xJtORU9KjNS8VHFsfE9jW2diXSkuTsjwWw94IPBoxJibQh+/Au
         kLofeGARU9WIoC9/stsC90TRqaKQJIYpEMkZTkGAqoAsWAS6I95hvvEeHsfoPAPWB6AP
         ALfUmAyNEqwtVpMZTQVMwYQCFeijJwWsufiHpYP9YiKcsOz4bHslyWooPbyRtK1Ey1SK
         JuV+ILUxU0zQMb3bUHYfgDgbv9IxXKjGU+vNHt26QxQyRl1je+a83qm19TNj6wFWdMff
         JTcz8RzN5vMe5i14erwmzqaOhVpaA2REmohPBrOr1+LLg/AdQBtttCVkpfDYL58p+foi
         WK1g==
X-Gm-Message-State: ANhLgQ1D2aewcrJwRrFTd7Qc0uUAidr3MTB9E2jOse2rYmK7DqEgW+dG
        RZrNj5OJ/inbunFqkvj90tvyfTT2mNs=
X-Google-Smtp-Source: ADFU+vsW7XsPITe5FLiUnWASfzdCBcfCNkjvekEE0amMT97wkN7DS9h+7UUmJFDhv8qcv/qsibYkdg==
X-Received: by 2002:a62:7c8b:: with SMTP id x133mr19820054pfc.229.1584897868065;
        Sun, 22 Mar 2020 10:24:28 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:992:9f95:b1e5:4cbf:6219:65ee])
        by smtp.gmail.com with ESMTPSA id f15sm807449pfd.215.2020.03.22.10.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 10:24:27 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/13] iio: magn: bmc150: Use vsprintf extension %pe for symbolic error name
Date:   Sun, 22 Mar 2020 22:53:15 +0530
Message-Id: <aea18dc7c140eacaaba24b82ee7809196047c1e7.1584897364.git.nish.malpani25@gmail.com>
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
 drivers/iio/magnetometer/bmc150_magn_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn_spi.c b/drivers/iio/magnetometer/bmc150_magn_spi.c
index ed9be0490d77..c6ed3ea8460a 100644
--- a/drivers/iio/magnetometer/bmc150_magn_spi.c
+++ b/drivers/iio/magnetometer/bmc150_magn_spi.c
@@ -22,8 +22,8 @@ static int bmc150_magn_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &bmc150_magn_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap: %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 	return bmc150_magn_probe(&spi->dev, regmap, spi->irq, id->name);
-- 
2.20.1

