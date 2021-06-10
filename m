Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397F93A2B61
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFJM0L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:26:11 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:21848 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFJM0L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:26:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623327846; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oUX/M8odnIAnnw2D1doRgDiaPGppWg1mZI3ctPQNFB5WCBw4v9vcuVeSY+2Bxzqn6b
    vwsn1eFUxYIW5vC2u1Uj+OxDgXjAptNVLTb1n/os1oAGodE1VGQgAn7bwFBMaqcxzwy0
    HIdjZqx4MF7XYzw7y23R/N7LOJ54fZNUbpfk3rPfIwTfz5z1pj5fLeU5+nIf1c286xS4
    0h3HuAIN2asbmHUPmU167sn+NkX55ejAXKIdnMAj0K6JimOB7nK3KM6UZRVlRLVJsJoY
    Gg3k4yPiAezx5qOYOF7N+HWOrUWlDOVEqk+Qq04qKqX6Fo82Dfhu2cXGuP3tnIpbRXhf
    kMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327846;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=N255HoRwbQK6GgNYri2591dhE/OLkqcb75P2f4BWQ3w=;
    b=a9mK3ozC3pTxjjN0XXbgYOVqs7e12IrChZ6lgGKWdckIfkBl1I7oxJhvds0jVaxzHA
    XMBePJUrIo55fi6/5iAOkp/6WY0fE3cTMeJLZMaK0+/JGaWxf2Ha2A0c71Ltjv4h6k8S
    6jhW5gB5cfAuKKoHHwQusboQb1ZxaUaAx7gaQu0RHTYckRKdCexp26+DoT3itCisFAfc
    w/x6UuhoTQzd9pwZrYL0+DdanCOM4mawJL+cxAqRXjD4zJRBUvNDIYXpyXlqD0xFpIbI
    +FFKTobRt4X9f9RVRWSk7DOrLaTA+p8egGiz2t0kuQ1LQbRtYqFVvAzlL0swNQ4BO8Tm
    9DnQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327846;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=N255HoRwbQK6GgNYri2591dhE/OLkqcb75P2f4BWQ3w=;
    b=mrx7uzURySm5jO1HQd7GxJ33XQm5GVNCHtcp2/9S9wz+26gs0b99HqzehRDxtZhds7
    KV3+sGI/89lRtnjaNOSp5vA/bUPgBhwtFcyMIcFe5YM2cSWrS5of8SczOfH2+onlixUn
    k7PFvPS3pfA1qTmrZP/CIyhrFSEDvQRPqeQPHER4zsowZSfbFR4VKSgLo/T8oO4sUsez
    5i1HLyLw/XdLCR2R1OSJ10cvkjvyBFw/FKt8I9UNaODM8EhS5V9UZBjaWq1C4oTNeZX/
    NGfGEhRvAwe0lLZwXoTa9cr0j+inz04vacoaVpNBKGXXABvLbbRxTogk+RABhCn7tt10
    aw4g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA626NTAM6"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5ACO5tzs
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 14:24:05 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 1/9] iio: accel: bmc150: Fix bma222 scale unit
Date:   Thu, 10 Jun 2021 14:21:18 +0200
Message-Id: <20210610122126.50504-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610122126.50504-1-stephan@gerhold.net>
References: <20210610122126.50504-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

According to sysfs-bus-iio documentation the unit for accelerometer
values after applying scale/offset should be m/s^2, not g, which explains
why the scale values for the other variants in bmc150-accel do not match
exactly the values given in the datasheet.

To get the correct values, we need to multiply the BMA222 scale values
by g = 9.80665 m/s^2.

Fixes: a1a210bf29a1 ("iio: accel: bmc150-accel: Add support for BMA222")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Added this patch in v2 to avoid conflicts later in case this
should be backported to a stable kernel.
---
 drivers/iio/accel/bmc150-accel-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index a3d08d713362..a80ee0fdabc5 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1145,11 +1145,12 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 		/*
 		 * The datasheet page 17 says:
 		 * 15.6, 31.3, 62.5 and 125 mg per LSB.
+		 * IIO unit is m/s^2 so multiply by g = 9.80665 m/s^2.
 		 */
-		.scale_table = { {156000, BMC150_ACCEL_DEF_RANGE_2G},
-				 {313000, BMC150_ACCEL_DEF_RANGE_4G},
-				 {625000, BMC150_ACCEL_DEF_RANGE_8G},
-				 {1250000, BMC150_ACCEL_DEF_RANGE_16G} },
+		.scale_table = { {152984, BMC150_ACCEL_DEF_RANGE_2G},
+				 {306948, BMC150_ACCEL_DEF_RANGE_4G},
+				 {612916, BMC150_ACCEL_DEF_RANGE_8G},
+				 {1225831, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
 	[bma222e] = {
 		.name = "BMA222E",
-- 
2.32.0

