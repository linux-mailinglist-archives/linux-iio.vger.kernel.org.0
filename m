Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5C44A3898
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355923AbiA3T02 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36170 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355914AbiA3T00 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 836AD612EC
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64CDC340F1;
        Sun, 30 Jan 2022 19:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570785;
        bh=41fhS7M+Gr5kp7lJvIMl+3f7aA4WpR8w6qGSUi5dX6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVv3G0uNG+UPW58I4m+piU0jbmptRuR8Pq7J2W7gakCx4j+T4EYrln/kiVRDyTa2z
         TbpJYmejQqW3RtBSCKejNPyc9BH2UBaqDldpEDmFu1EMdxqeSk98Vps/75yoRS1m+i
         JwMslNZF4v5YxXGIL1dGP28/Ysa8Hd76etQ2TsY+ayGQfSkBx7DXly7lqIA62wfsEM
         nJ/0lurBqv6InUmcSA+2/Sy6J4J6iMjgcuu6ROYnmRpzWg0nxDEaKRua9Fb7uAoaTZ
         vJLa6b5k4SjdiwAfs0o6gJDftnnTRig2Xs1zA4vxJ9HEWEw5LiIaSZ5eVoHdQ45z56
         5H+g8M/w5cPgQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Icenowy Zheng <icenowy@aosc.io>, Luca Weiss <luca@z3ntu.xyz>,
        Martijn Braam <martijn@brixit.nl>
Subject: [PATCH v3 24/50] iio:light:stk3310: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:21 +0000
Message-Id: <20220130193147.279148-25-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130193147.279148-1-jic23@kernel.org>
References: <20220130193147.279148-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Icenowy Zheng <icenowy@aosc.io>
Cc: Luca Weiss <luca@z3ntu.xyz>
Cc: Martijn Braam <martijn@brixit.nl>
---
 drivers/iio/light/stk3310.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index fc63856ed54d..1d02dfbc29d1 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -632,7 +632,6 @@ static int stk3310_remove(struct i2c_client *client)
 	return stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int stk3310_suspend(struct device *dev)
 {
 	struct stk3310_data *data;
@@ -656,12 +655,8 @@ static int stk3310_resume(struct device *dev)
 	return stk3310_set_state(data, state);
 }
 
-static SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend, stk3310_resume);
-
-#define STK3310_PM_OPS (&stk3310_pm_ops)
-#else
-#define STK3310_PM_OPS NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend,
+				stk3310_resume);
 
 static const struct i2c_device_id stk3310_i2c_id[] = {
 	{"STK3310", 0},
@@ -692,7 +687,7 @@ static struct i2c_driver stk3310_driver = {
 	.driver = {
 		.name = "stk3310",
 		.of_match_table = stk3310_of_match,
-		.pm = STK3310_PM_OPS,
+		.pm = pm_sleep_ptr(&stk3310_pm_ops),
 		.acpi_match_table = ACPI_PTR(stk3310_acpi_id),
 	},
 	.probe =            stk3310_probe,
-- 
2.35.1

