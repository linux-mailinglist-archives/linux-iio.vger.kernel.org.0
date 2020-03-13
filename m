Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 864E21840FC
	for <lists+linux-iio@lfdr.de>; Fri, 13 Mar 2020 07:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCMGqO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Mar 2020 02:46:14 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:56088 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgCMGqN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Mar 2020 02:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8SjkA7IjCSGUMcfzL6sRgrvmSd1UEQES9jRtvIHJjUo=; b=bqcD0aWWWQNEdTjDdCr84C7Llq
        DBI64Xdpy+figcHl1WbVCNQaFMFy6ZFNOSSrMqkCfEDrsCd02n21vMqpM836FVXjmGPUiLIK8iCn3
        7JPyGYUxe7PQ7XMLRVg9L6ZRJzt3eqqmIXzO/1ypBGpu52mKX78k8W0iHmhfgHsURdFg=;
Received: from p200300ccff096400e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff09:6400:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jCe4v-0002pJ-TH; Fri, 13 Mar 2020 07:45:57 +0100
Received: from andi by eeepc with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1jCe4v-0008D2-Bn; Fri, 13 Mar 2020 07:45:53 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, stefan@agner.ch, b.galvani@gmail.com,
        phh@phh.me, letux-kernel@openphoenux.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        jic23@kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RESEND v6 4/7] mfd: rn5t618: add more subdevices
Date:   Fri, 13 Mar 2020 07:45:31 +0100
Message-Id: <20200313064535.31503-5-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200313064535.31503-1-andreas@kemnade.info>
References: <20200313064535.31503-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since the RC5T619 has a RTC, use a separate subdevice list for that.
The ADC should be the same as in the RN5T618, according to drivers
in the wild, but since it is not tested, the ADC is only added for
the RC5T619.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v6:
- squashed with patch from former ADC patchset

Changes in v3:
- alignment cleanup
 drivers/mfd/rn5t618.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 30fed9ab3d04..321836f78120 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -14,6 +14,7 @@
 #include <linux/mfd/rn5t618.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 
@@ -22,6 +23,13 @@ static const struct mfd_cell rn5t618_cells[] = {
 	{ .name = "rn5t618-wdt" },
 };
 
+static const struct mfd_cell rc5t619_cells[] = {
+	{ .name = "rn5t618-adc" },
+	{ .name = "rn5t618-regulator" },
+	{ .name = "rc5t619-rtc" },
+	{ .name = "rn5t618-wdt" },
+};
+
 static bool rn5t618_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -174,8 +182,16 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	ret = devm_mfd_add_devices(&i2c->dev, -1, rn5t618_cells,
-				   ARRAY_SIZE(rn5t618_cells), NULL, 0, NULL);
+	if (priv->variant == RC5T619)
+		ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_NONE,
+					   rc5t619_cells,
+					   ARRAY_SIZE(rc5t619_cells),
+					   NULL, 0, NULL);
+	else
+		ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_NONE,
+					   rn5t618_cells,
+					   ARRAY_SIZE(rn5t618_cells),
+					   NULL, 0, NULL);
 	if (ret) {
 		dev_err(&i2c->dev, "failed to add sub-devices: %d\n", ret);
 		return ret;
-- 
2.20.1

