Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477F8214026
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jul 2020 21:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGCTvn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jul 2020 15:51:43 -0400
Received: from vps.xff.cz ([195.181.215.36]:47902 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgGCTvn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 3 Jul 2020 15:51:43 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Jul 2020 15:51:42 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593805465; bh=mtS2OOnwpcAcf3Vn0Zput13XEuuefUuyocjzu7yZ8/g=;
        h=From:To:Cc:Subject:Date:From;
        b=Z/uCE1SWpfQUPh88R+kFhV+o2GxEV223ekwDyj+jMUdO3S38oAVruYrB3/di4HNVZ
         zLy0Cjvv8VSSpoIYnb2rJ/63E4k3VOj2ql6zYN7AZqtAsLjdlcBIqC1p88XnGs7YkH
         3RYPXzV8vo42bRwupJHIdpCw/zcJG5POGk9TV7ks=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-kernel@vger.kernel.org
Cc:     Icenowy Zheng <icenowy@aosc.io>, Ondrej Jirman <megous@megous.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Luca Weiss <luca@z3ntu.xyz>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: [PATCH] iio: light: stk3310: add chip id for STK3311-X variant
Date:   Fri,  3 Jul 2020 21:44:05 +0200
Message-Id: <20200703194406.110855-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

The STK3311 chip has a variant called STK3311-X, which has a different
chip id of 0x12.

Add the chip id to the driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/iio/light/stk3310.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 185c24a75ae6..1a8401d198a4 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -37,6 +37,7 @@
 
 #define STK3310_CHIP_ID_VAL			0x13
 #define STK3311_CHIP_ID_VAL			0x1D
+#define STK3311X_CHIP_ID_VAL			0x12
 #define STK3335_CHIP_ID_VAL			0x51
 #define STK3310_PSINT_EN			0x01
 #define STK3310_PS_MAX_VAL			0xFFFF
@@ -453,6 +454,7 @@ static int stk3310_init(struct iio_dev *indio_dev)
 
 	if (chipid != STK3310_CHIP_ID_VAL &&
 	    chipid != STK3311_CHIP_ID_VAL &&
+	    chipid != STK3311X_CHIP_ID_VAL &&
 	    chipid != STK3335_CHIP_ID_VAL) {
 		dev_err(&client->dev, "invalid chip id: 0x%x\n", chipid);
 		return -ENODEV;
-- 
2.27.0

