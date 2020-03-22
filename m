Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2A418EACA
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgCVRYH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:24:07 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53528 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgCVRYG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:24:06 -0400
Received: by mail-pj1-f68.google.com with SMTP id l36so4994001pjb.3;
        Sun, 22 Mar 2020 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xLrIs6rvWHh+rmiQjA6RoqzW6JxJJAgVh27Il2Ppij8=;
        b=mKFA9CDYuYQExPeLtFhGShyTkr3PmK5VnGjFTUS8Fkf0wo55H4lHgLBjYqXnEsfLcD
         dzLdwHKPYFz/ZeYY5W6Rir4wlaIs/BSEZAo31NKROIV05cwiaqhC5qrZZqHWJ3WAR2tv
         zXagGnRGQkbdjidkYh5OF0rgNsyMjOAKfPywjUvLp7mTgn8J9IWezbUkzW2uZswu71D9
         r101qcxBpNzNP1YXcUnGU8G//UTUgWsJLO5sPxOnNhV/tKvNU9vI7j8WqAGdXVtJfjvX
         jGSZbT1caB07I+vB5fdg0b/QZgv/nIaoWHDEJioPDx/a1Sfhqeu7HqywjvQpeNPfO/fc
         hq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xLrIs6rvWHh+rmiQjA6RoqzW6JxJJAgVh27Il2Ppij8=;
        b=eoH94XjhstZSI0MYThSxCaCSNMt4quFBsfKNhhjDtsGQXqAo75fY4zc6GVDVqotUFi
         aPNwyyY/Yas8N97ePX2p84jjZCtRlmb+tvD4D6oHL9D1aVmuCmRty1RwyoWrLNmcmPKb
         Beh5GTtxP1tTD8l7VCzniOpNMdV8Npt4z+jSrerDXPmh+nuLfslXvJAwYMr1Vs3Vv2RQ
         hGMj7aS+NkzR3+BmA2+ubo5NhCtSmGk4ANRevoSQMRLj1vS9RCEVeo0PHuC6IS5BBXcG
         inRibc+yC6kfeLDO7cCVnNaHpahPKMq/fWvnTRLl+mkdlX2ifCioRscxyuQl/OTXx1kF
         oBZQ==
X-Gm-Message-State: ANhLgQ1vTz04k43UJmo4ME89WtpdzmyAQcBnb3haaYTxZ7j7JRAy98Ag
        QJ17rW6MsfoSmYGFqADCeRFSmb+wzes=
X-Google-Smtp-Source: ADFU+vtLOf1pPAxdme/fuz2vcGwaFfTtmCfANGyHDe1MSOGjPBKAW2OgBs4ARpnNIqwhhfFk26Fk7g==
X-Received: by 2002:a17:902:8492:: with SMTP id c18mr18567787plo.147.1584897845635;
        Sun, 22 Mar 2020 10:24:05 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:992:9f95:b1e5:4cbf:6219:65ee])
        by smtp.gmail.com with ESMTPSA id 4sm11097790pfn.156.2020.03.22.10.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 10:24:05 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/13] iio: imu: bmi160_spi: Use vsprintf extension %pe for symbolic error name
Date:   Sun, 22 Mar 2020 22:53:10 +0530
Message-Id: <df440b36aee29cc14c21a3153983c7dfaaf7172a.1584897364.git.nish.malpani25@gmail.com>
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
 drivers/iio/imu/bmi160/bmi160_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index c19e3df35559..61389b41c6d9 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -20,8 +20,8 @@ static int bmi160_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &bmi160_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap: %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 	return bmi160_core_probe(&spi->dev, regmap, id->name, true);
-- 
2.20.1

