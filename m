Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED471620C5
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2020 07:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgBRGUu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Feb 2020 01:20:50 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:58022 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgBRGUu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Feb 2020 01:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nmY2tjaMWRwVLTyGzwjeXNSRFboYF38fEHLRyvhHHzA=; b=RHBmr/rjCFx1xxay/NykFECKA7
        GOquwGZj8aEAYoe6td91EuHQYFzOyq/E4/+zDlm0ewsYmbYXC9G/tHKDvdfZUd478prGNDL0WoJS5
        rqEUTniMFtU5GNB20FRZN0FDMzF6BSau5o2Mu+Tbegt3aCB6oZJvgCWVIpL07+9lU8JU=;
Received: from [77.247.85.102] (helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j3wFM-0000on-I9; Tue, 18 Feb 2020 07:20:41 +0100
Received: from andi by localhost with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j3wF5-0005rM-OK; Tue, 18 Feb 2020 07:20:23 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, phh@phh.me, stefan@agner.ch,
        letux-kernel@openphoenux.org, martin.blumenstingl@googlemail.com,
        jic23@kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RFC v3 4/4] mfd: rn5t618: add ADC subdevice for RN5T618
Date:   Tue, 18 Feb 2020 07:17:25 +0100
Message-Id: <20200218061725.22420-5-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218061725.22420-1-andreas@kemnade.info>
References: <20200218061725.22420-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

RN5T618 has an ADC but RN5T567 has not, so
we need separate subdevice lists for both.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Untested, IMHO only acceptable with a Tested-By.
Not needed for the RC5T619, feel free to ignore them if the whole series
would be delayed just because of missing Tested-By for this.

 drivers/mfd/rn5t618.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 6828fd40b0a1..d37d7a31cf26 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -21,6 +21,7 @@
 static const struct mfd_cell rn5t618_cells[] = {
 	{ .name = "rn5t618-regulator" },
 	{ .name = "rn5t618-wdt" },
+	{ .name = "rn5t618-adc" },
 };
 
 static const struct mfd_cell rc5t619_cells[] = {
@@ -30,6 +31,11 @@ static const struct mfd_cell rc5t619_cells[] = {
 	{ .name = "rn5t618-wdt" },
 };
 
+static const struct mfd_cell rn5t567_cells[] = {
+	{ .name = "rn5t618-regulator" },
+	{ .name = "rn5t618-wdt" },
+};
+
 static bool rn5t618_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -203,16 +209,32 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	if (priv->variant == RC5T619)
+	switch (priv->variant) {
+	case RC5T619:
 		ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_NONE,
 					   rc5t619_cells,
 					   ARRAY_SIZE(rc5t619_cells),
 					   NULL, 0, NULL);
-	else
+		break;
+	case RN5T618:
 		ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_NONE,
 					   rn5t618_cells,
 					   ARRAY_SIZE(rn5t618_cells),
 					   NULL, 0, NULL);
+		break;
+	case RN5T567:
+		ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_NONE,
+					   rn5t567_cells,
+					   ARRAY_SIZE(rn5t567_cells),
+					   NULL, 0, NULL);
+		break;
+	/*
+	 * Should not happen because we come here only with a valid device
+	 * tree match, so variant contains any of the above.
+	 */
+	default:
+		return -ENOENT;
+	}
 	if (ret) {
 		dev_err(&i2c->dev, "failed to add sub-devices: %d\n", ret);
 		return ret;
-- 
2.20.1

