Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E517918EABD
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgCVRXi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:23:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40797 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgCVRXi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:23:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id t24so5914866pgj.7;
        Sun, 22 Mar 2020 10:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3BqIOjfEqFOKLNKbBxzb895osWZYr0nQui1/0tSkFmQ=;
        b=pSAliulKEZxtRaGdwL2yaJHOhLBdQcfY446rT8OF59P23os5kU61bRSY/rQKcGAkuw
         hrACLdvvleLTm9zJ9jWsvsywkQDA1VqK2oxFIn6EdPM91ly5bbp1ihG2VNqDlgJ5a0dD
         iJMZGCw95XY3mtx7YkWKfjSYbtxcPW7/+ZwOIBRCJUXFIitg6E26HTHrhP8m0KTbRfWS
         S0XhlGrnGc89ckHNZXl1ZoZLcxxnjPfBGfV5n/3CQ8hfy7Mxy9r8DSgKZD8OH7Y1klu2
         hZ3fWnULgleBuxmYctlltQhMOsVkIRwfMdolAZrIKbzXG4eLbfK4FS7XIyBZdjwNfB3E
         B7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3BqIOjfEqFOKLNKbBxzb895osWZYr0nQui1/0tSkFmQ=;
        b=t5jk6Oo/+wIPzTC1L8axXNRg1wDxI/Aq/ndaCHCSEARFa3HV9LwyEx47UB5zGUXW1M
         0UsRoy9BFd4IppjvqA2pXrTVMiAEA+PgrwF5oEqScLCQ9cyh6FwlczalR4+VfUmwz7jV
         9z91yc/726OHVPKHNakSMKsYYZnCPoB9qXGGDinvPgA17vTOaBT19aTktYUh/1SBtW7p
         GHL2lHETF2zzH2TT3HYo5dvsy2ttZpSdcTP0p89NGmYsjzsujgMJU/sL3FVWj2SNHuO6
         5MPFl8w1ir8k2sw1PRSqeRSP+iZlGJo3gRn+8oUgwqhJIG6ttPhW5hMxerR4oEeM276C
         9WWw==
X-Gm-Message-State: ANhLgQ30bUi1WgCE6bF26GFLvEzg4SKy5R3b99yndDrEbg65Y1RgugrY
        new/eCIP7BPPJDYd1ZXMniHGc9VMTNA=
X-Google-Smtp-Source: ADFU+vsFhACvvTD967TNgSX83kYpy6sN7HReH0xa7VW1S87hMkGzZ8HZ6GEIfEbbYeQido8i8IvTeA==
X-Received: by 2002:a63:e20d:: with SMTP id q13mr17764613pgh.6.1584897816847;
        Sun, 22 Mar 2020 10:23:36 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:992:9f95:b1e5:4cbf:6219:65ee])
        by smtp.gmail.com with ESMTPSA id o14sm6848768pfh.147.2020.03.22.10.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 10:23:36 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/13] iio: st_sensors_i2c: Use vsprintf extension %pe for symbolic error name
Date:   Sun, 22 Mar 2020 22:53:04 +0530
Message-Id: <1ac10121b5bd95fbba59d27482a77d55c2461230.1584897364.git.nish.malpani25@gmail.com>
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
 drivers/iio/common/st_sensors/st_sensors_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index 286830fb5d35..4f7ae273ac98 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -49,8 +49,8 @@ int st_sensors_i2c_configure(struct iio_dev *indio_dev,
 
 	sdata->regmap = devm_regmap_init_i2c(client, config);
 	if (IS_ERR(sdata->regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap (%d)\n",
-			(int)PTR_ERR(sdata->regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap: %pe\n",
+			sdata->regmap);
 		return PTR_ERR(sdata->regmap);
 	}
 
-- 
2.20.1

