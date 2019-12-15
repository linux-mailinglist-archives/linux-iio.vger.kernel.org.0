Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB54711F604
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 06:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLOFRp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 00:17:45 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33858 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfLOFRn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2019 00:17:43 -0500
Received: by mail-pj1-f68.google.com with SMTP id j11so1532808pjs.1;
        Sat, 14 Dec 2019 21:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iJPFiDdoTrBrSdqjTpE+VPFHmC8ax0pLThG7IGKangk=;
        b=Id8NfdTFPUPB+fc7GWUtnaZycNxT1n/743f1r4mmprU8vigdUiO+qwV5Rrz9bb5cvS
         JFpw4kpX7F7iUhfnq57t+ScMl4f95d3tqi8LeBRCdyGMExAcUz/W8rfHTPc1pfSrXXti
         PMZTllluPehaVveLsU7xboTHQ5CkDcPhifUoApxdDmxQ0gAQqd5oYjDFsEAUunFDK7mP
         TgcWBy3rf9x/fCIN+Yd/BB4jRXSBr+guHfyatZ7v7cIomD3n8NclP80repjcNSP2ECzf
         CQnlPaqXdr5iEeQn0VfsxWvGaI4UFf1hAQLbeaaVRYg/4hB/8zQGjBw3kzQd6RWBhlRU
         G1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iJPFiDdoTrBrSdqjTpE+VPFHmC8ax0pLThG7IGKangk=;
        b=Yxuw4TE52sHPoJf2HuP820He3Ll3M6Y31MXPV8EFu/4tSjBr2t0Yg/Kheiytcj1p4X
         8gRI65q0JzPXvr+cuedFdX0sXDiImNa7haKlmE4z4Y0MomGjIvuEIy2V4E1Z9C5Wq9lL
         xh8Icbyd3MS7jyTBz8FiwheBTcHxo/9OEr1Wjl8IrpO5HoFhJWTwpw95SUUDeO8VPo0P
         l77SMG38d7Q+aRnPk56WNV81DeofkCoQ93V5WR81GvxD1zOYqTMZbp4WZxn9j2C48mcn
         jgJlUbgdTYVEUxOl+yJ9AGWFnFmZ7O62QzskqON84QIMhPZHmnftwCafTI3y2CARS6S9
         9Bxg==
X-Gm-Message-State: APjAAAVQQeiIsp22nEXdysvI/55P8smopliF2C8WEfdJQTe6V35DNXd+
        P1AwiGSRV36nFz38wRQkYHY=
X-Google-Smtp-Source: APXvYqxTG4dxeNv2aoSLu1cumiV7gAuV9hcPKvGjbWfymM/Tqr7q01DvKziXiVpBQtLaPO5sHG9+HQ==
X-Received: by 2002:a17:902:bd8e:: with SMTP id q14mr9152361pls.199.1576387062386;
        Sat, 14 Dec 2019 21:17:42 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Dec 2019 21:17:41 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Subject: [PATCH v4 11/12] thermal: armada: remove unused TO_MCELSIUS macro
Date:   Sun, 15 Dec 2019 14:16:14 +0900
Message-Id: <1576386975-7941-12-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This removes unused TO_MCELSIUS() macro.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v4
- add Reviewed-by tag

 drivers/thermal/armada_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 709a22f..fc6dc10 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -21,8 +21,6 @@
 
 #include "thermal_core.h"
 
-#define TO_MCELSIUS(c)			((c) * 1000)
-
 /* Thermal Manager Control and Status Register */
 #define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
 #define PMU_TM_DISABLE_OFFS		0
-- 
2.7.4

