Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5503F3A3DC4
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 10:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFKINw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 04:13:52 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:34236 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFKINw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 04:13:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623399109; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hrrA/pwHqupDXYbKHPwmHFE515HDRNUQLQGiLiun8y2aF/kpCtw01qKb6xixgRa5t8
    dT3wdWiU+29UPSWf/ODZtVSWF3DqVQXFzeg1jQWrpiuuW8bYhEZHI42ymi6yyjD7SHXG
    AHfc62Eez4f/7vojLa/tI2ijfS/0jSEksn3Fk/1Lqo/ZNkeQemis4lCNx+qF1pUSod7j
    LQ6fQsufUg283aQU2QRMMGKTiBdWsTAKcK++WeXGl2VrdXoUlFLcb1PiTsAUMUksxcCx
    OgE2jy6Pkbzi7zJQM7+4pkyYE769p/JesgJJ/WQ9uknIsiKcdgFngaz5moXd7HWc96ra
    EPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399109;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=N255HoRwbQK6GgNYri2591dhE/OLkqcb75P2f4BWQ3w=;
    b=BRL+zvS5YLo00apseEtDmXzWRZFmecKTjp2OjBtdFfa0CMNHA8rCxVu8bT+0aXGunp
    vSFZ+kqx+9viH8Tktq8f1GTh11cbVOzq9a7GvIP4pzVyzMxOzMtvcqJ4JqZmbAPGnOJu
    xr8LIyf/aOmwZEr81+8cVy6X354hE/987dJ7E1ctD8k/hvRUNhqkko2iodIt8wVF4XIP
    fD2/UBwR5LySj2VHykF+kBo8s0ep3lOYejenjtvqxgCNWmF+qynPnXIw/m3/7avOBBSV
    yHI/MS2mD8ATezph+I/R0kyG0w687pYZzGn0Bgd0xxvOtC7ZQUkocTz0BpB23ZFv9MJ8
    22Ow==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399109;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=N255HoRwbQK6GgNYri2591dhE/OLkqcb75P2f4BWQ3w=;
    b=GyhaRSF8ur9VQWtxOKwGRMA85R1qcfABVJpiF3FT+67tJp7vLwFAlNrz1AWMiWwfaZ
    rrPgpIepAeT3eY1oHYMXACISpoI2HqmuVLczsxNDjUfq3wIoqrMc2xuSmvBhl3IrYtx4
    WSbQII05nFy3G6jU1TezFvZCc0nRHt1xPrWq1B55NR6ntAgZAuHwKHdB4sWEMbVTdfR+
    73KZxg4NWYTM6m5e529p8HZ4S34K4FeceCpvwnpm2gt5t8aNHkNSXurqYcGDj5o+70Dm
    XqPzub124WkalrcrouIr4wIMC9GTG3RA6yS4NWodyi0/dZyTL0aVo1s1mMiPuH2tHeuE
    gdzA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA6m6PrPw="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5B8Bm02d
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 11 Jun 2021 10:11:48 +0200 (CEST)
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
Subject: [PATCH v3 01/10] iio: accel: bmc150: Fix bma222 scale unit
Date:   Fri, 11 Jun 2021 10:08:54 +0200
Message-Id: <20210611080903.14384-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611080903.14384-1-stephan@gerhold.net>
References: <20210611080903.14384-1-stephan@gerhold.net>
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

