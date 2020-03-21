Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E1018E4A0
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgCUVDF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:03:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43356 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbgCUVDE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:03:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id f206so5287519pfa.10;
        Sat, 21 Mar 2020 14:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VkJnIV/tJhzhuy7HiqUZ2Wob18zmxSRsMZRCDR3lluU=;
        b=udXM7IxfQiG7Wm4yoTLoQD9d1mXQgjNa27CCVkN+eY+60+dNcmc+GIKvvFF4IO7dF7
         Mf7bSKeIOFOFkA21heRrdmnDqi/Gevhp9iiLhCaIoTEv2iQH2RdSnakzJIkMflqHEC36
         RRgfKqHce6K+HfuU/ApiV84t+oApmwKPkC3a19EoC/P1kG8sZVVgqzOVuh9zt5ALtbjT
         NZfsSwMLwJAP1D5iy2NWmBNiY+rhgfIrWcQU+mK2B9V0SWnjr0COr6/v9SvZa6Njiucg
         HaQ197OFg91qAaDdLnr1qBGefMoMGPrKTkd15wmnqSn6Fuw6pbmOW2g0Rbg7vvcTR3Bp
         mTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VkJnIV/tJhzhuy7HiqUZ2Wob18zmxSRsMZRCDR3lluU=;
        b=pYQ3apBBpfqfPwXYgLAuLF1rVDPP/lE1QLsK1avyY3XEAVVgWm6uD426uECxJYdKUB
         zqkzyzcyxk9PZUnIyuxRA8Wx1bV7GCEkrIYv+8KnW0YxLBZr66aQOAi7BjUpvk8pCBZn
         WGgmDQ0syZbaasdF2EEaeJDHep7jKrCJqdTtRIG5aekw+tZpL0hUgWV4bXZKMjS/CIii
         KKykxDQfywBLwRZR9dSZgOZJGx56dYUwnWXPDS8f/fYEV8g+wRss/LyA/JkkJhyZUIZl
         Pzh3BJjWofN+Q4+zUB8a6yspE9TV5B5xEJYQI0+Iw2p9ePg5FjKjGNxEF5L7u0TN+ToH
         q36A==
X-Gm-Message-State: ANhLgQ00rQbZs8ZzA7DsbGSccU0itxfG13VkuNYlDm8Xoa5kqVc9l7CV
        sFJzEqWSrZZZ+7cai6kHaHyxvP9yN7E=
X-Google-Smtp-Source: ADFU+vv4j9N7hCCa0/x3M03ATtcQhXBAv79bBifuc8/RisPqP5tzIIT6Y0By81cmyjN1XkDXI7jNeA==
X-Received: by 2002:a63:b648:: with SMTP id v8mr14125474pgt.397.1584824582235;
        Sat, 21 Mar 2020 14:03:02 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:488:8b8b:892d:8d8:1a6c:acda])
        by smtp.gmail.com with ESMTPSA id x188sm9160466pfx.198.2020.03.21.14.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 14:03:01 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] iio: magn: bmc150: Use suitable format specifier
Date:   Sun, 22 Mar 2020 02:32:00 +0530
Message-Id: <20200321210204.18106-10-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200321210204.18106-1-nish.malpani25@gmail.com>
References: <20200321210204.18106-1-nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Provide more suitable format specifiers while printing error logs.
Discards the use of unnecessary explicit casting and prints symbolic
error name which might prove to be convenient during debugging.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

Based on conversations in [1] & [2].

[1] https://marc.info/?l=linux-iio&m=158427554607223&w=2
[2] https://marc.info/?l=linux-iio&m=158481647605891&w=2
---
 drivers/iio/magnetometer/bmc150_magn_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn_spi.c b/drivers/iio/magnetometer/bmc150_magn_spi.c
index ed9be0490d77..7f42ee04a6b7 100644
--- a/drivers/iio/magnetometer/bmc150_magn_spi.c
+++ b/drivers/iio/magnetometer/bmc150_magn_spi.c
@@ -22,8 +22,8 @@ static int bmc150_magn_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &bmc150_magn_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 	return bmc150_magn_probe(&spi->dev, regmap, spi->irq, id->name);
-- 
2.20.1

