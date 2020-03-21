Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D13D18E4A4
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgCUVDP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:03:15 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52355 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgCUVDO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:03:14 -0400
Received: by mail-pj1-f66.google.com with SMTP id ng8so4146266pjb.2;
        Sat, 21 Mar 2020 14:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YhmrCCr2VKlc28KIOh4AfuOVE801CwlQGUjtjOvqgPY=;
        b=MKafsdAegpBG18CRekmO4/CUq3+JkrIiOkTlDZoEqu+dyhtRnzjgGGpMQ92kEMBVC8
         9/D0l/Qd1mmn5wN3HHPPFLWED+IMu96p3BmiRSVPhJTiykzK6eVEH+0Mp5v3xEM/l2oH
         I8XnePrC+YpgBR856gB90iCgBs0/jZtLxUFY3heMZnCEKqNzUvNMDH4iZynrHD5/82rd
         qTaoNF2WIbqn1iPTMAz/sfGNS/omCNAnikuArDaeyhYIdWNfNAJuIgoHqHBaTOcCtmPK
         BIix2TbePXm/DWVtV+5ieyewiD+F+NQdOnvsrPiqYUYi2Lc8vZ8jOT3n7III70oYoyIx
         hNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YhmrCCr2VKlc28KIOh4AfuOVE801CwlQGUjtjOvqgPY=;
        b=YUct8QuHP0AAj+gEKnMwEl6AoBO34fCCZNkV/ae2KZ4a5QRTMRnvRCQ+IquHuduU7p
         b1243LlRCIbD28SqYQ8JcVosVFaw2Tzig4VxcCLBCj5T630uLaxra/FPZMhTCwlpDixH
         5Rl3Fnzz4AMbiSgI73bc+9UdYmqRGXWE4eqao6joMD5fYNdw75UAoJOGFF1X4EFA3AIV
         VaUC6k1NPj1yrrbzTzsnt+Xm8ZuuU32fEeT77pMmzG7ndgO2NxfTSMdVL2Y75JRWNGs3
         U+/PpxG0q0W4A084orAB22+n21t+9JqYnALimi9yJaryPa4YbTBveQp0mo0u02B6LoLa
         oZxQ==
X-Gm-Message-State: ANhLgQ3yfVdHOsvFGRbgJoVDRURPHlmpflnACLA9NlcANHrySyMWfWVI
        7srS5RP4LAZ2wlDJlNIIM8CM2tF3Mus=
X-Google-Smtp-Source: ADFU+vvhn+4ADEow0QnQIoawR0VhrDW7Zs2E5wALd6cthCQuEYsuXAGAL9OeB8YkK1NExj6GC2K6Rg==
X-Received: by 2002:a17:902:b187:: with SMTP id s7mr15328253plr.84.1584824592527;
        Sat, 21 Mar 2020 14:03:12 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:488:8b8b:892d:8d8:1a6c:acda])
        by smtp.gmail.com with ESMTPSA id b17sm9170167pff.81.2020.03.21.14.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 14:03:12 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] iio: light: st_uvis25_spi: Use suitable format specifier
Date:   Sun, 22 Mar 2020 02:32:02 +0530
Message-Id: <20200321210204.18106-12-nish.malpani25@gmail.com>
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
 drivers/iio/light/st_uvis25_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/st_uvis25_spi.c b/drivers/iio/light/st_uvis25_spi.c
index a9ceae4f58b3..2afc3fea7357 100644
--- a/drivers/iio/light/st_uvis25_spi.c
+++ b/drivers/iio/light/st_uvis25_spi.c
@@ -31,8 +31,8 @@ static int st_uvis25_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &st_uvis25_spi_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

