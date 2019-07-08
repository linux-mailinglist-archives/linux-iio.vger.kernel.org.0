Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8E61E75
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2019 14:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfGHMdr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jul 2019 08:33:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39897 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGHMdr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jul 2019 08:33:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so8215898pls.6;
        Mon, 08 Jul 2019 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jAthm+WxbxKT3w7i0wyvJ8rNAQ4gSuwe1Onff42CQls=;
        b=COmFwheYaqCs3c7QPhN18QiYnYAtIpekULwaQLYy7zw/NDr+RwcMaHcElLMG0+11qc
         bw3/JczgJacs0zd1jB+chz1vURSYjchaV6sz9uQmaTZ8zak1x3tf+DEkjbA8TMfx3Kgn
         4H39xsp7gJPC8z+ixSNXr1e2GXw4l+bB4l0sEYWolpQ6+9B7cI5GJlDNt3csKD8BNaVJ
         rwdKZmDrtoMN3oN9Bsa15LRo/Bo5vOREWMt3E9OR3inNtE/ZPSJdKcFilYHC4UI9ERpv
         f/z/Ozypxhn3BfQmVpsi3Jiuk1YxycWDhvBByjb6Lw765j8ZyzctfFWhC7haJK9shArV
         d2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jAthm+WxbxKT3w7i0wyvJ8rNAQ4gSuwe1Onff42CQls=;
        b=HOID3B30IFensHi8AyRVA80zjdXCLfqw36z+88AN/Hx9giJUNlWzTLGrfrX22ybKC4
         G2rfVhvqCp5XkusEU+v5LMOsdoq7/8vRuldp3zPAefXM0E4/wTECx4nxk/oXgZ1W2I0n
         rvI0JDjLBXkiKV3FUofus36EfUit5K8AbneyDZzDV7RSgPDXr9ka9l6bFU12fgTpsg4B
         l3efiiXVadLRMrwVWdOO0PERghH5c/VrWBzUMoT2G52QwcQvQRGGgwFOyL0UxlFWMaO3
         cXrIVK4lcxpwkgtSAnJgFsSRw0zmhwGC3b6i+YcCxWcrPQKaWza2Qvyb9SfEiVqj3I65
         u9yg==
X-Gm-Message-State: APjAAAWZlMNDrqHVQPcSBkqfPY/0FIVQ8TOsnEOx3HSz65N0mRvc17eg
        uACimkFTluX1D+iRqee5WwE=
X-Google-Smtp-Source: APXvYqzWEYy5DWmnGPZx/MdBsBT8HflhtCaUZk2qoy59jNEbuI4R8Dn/xfHORQmcDA8wqETHW1+F6A==
X-Received: by 2002:a17:902:4e25:: with SMTP id f34mr24265563ple.305.1562589226504;
        Mon, 08 Jul 2019 05:33:46 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id g2sm13103473pfq.88.2019.07.08.05.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 05:33:46 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 09/14] iio: imu: mpu6050: Replace devm_add_action() followed by failure action with devm_add_action_or_reset()
Date:   Mon,  8 Jul 2019 20:33:41 +0800
Message-Id: <20190708123341.12035-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

devm_add_action_or_reset() is introduced as a helper function which 
internally calls devm_add_action(). If devm_add_action() fails 
then it will execute the action mentioned and return the error code.
This reduce source code size (avoid writing the action twice) 
and reduce the likelyhood of bugs.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 53a59957cc54..e067927317bd 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1096,10 +1096,9 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	if (result)
 		return result;
 
-	result = devm_add_action(dev, inv_mpu_core_disable_regulator_action,
+	result = devm_add_action_or_reset(dev, inv_mpu_core_disable_regulator_action,
 				 st);
 	if (result) {
-		inv_mpu_core_disable_regulator_action(st);
 		dev_err(dev, "Failed to setup regulator cleanup action %d\n",
 			result);
 		return result;
-- 
2.11.0

