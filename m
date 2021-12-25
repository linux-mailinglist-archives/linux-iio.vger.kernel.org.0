Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F3D47F3C8
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 17:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhLYQLV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 11:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhLYQLU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 11:11:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6D6C06175F
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 08:11:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dU-0008DC-LK; Sat, 25 Dec 2021 17:11:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dR-006agl-3N; Sat, 25 Dec 2021 17:11:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dQ-0007ef-2Q; Sat, 25 Dec 2021 17:11:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel@pengutronix.de
Subject: [PATCH v1 02/23] counter: ftm-quaddec: Drop unused platform_set_drvdata()
Date:   Sat, 25 Dec 2021 17:10:35 +0100
Message-Id: <20211225161056.682797-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=Nuc6uojLK2l78VEJRC17DzBz/PbGGLv4T5mYODCGJkE=; m=qa0/nnsbHdKDuWY5QI5nC4IISJUbD9bjLmxbmrIZnvk=; p=IfE2j3nOQwuWinlapNulwSDtKLZYNVCeEO4YIGFLRlo=; g=7b74987636ca0013f74dda498ee0d0e05ddc7c66
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHHQioACgkQwfwUeK3K7AndwAf/TZc Fqm3SssFAq4uFWMhrvvzPrGZVjsq7W6IQ31HFzbsSQCc1m8m17Ae9QO4fcijhCp2DhdNRmbWH7pOF sQOna9zQ4rWaIJM9P365B2M0uI6AJvzqXnNCqNmdnZkZItZPZDXdhphM9NN1lrU50yuVylPX2Z38i l/6D466jBiZVhWP/7jPRRvUzhcQK7jra2lwxqlY2TGyKtaf2w9Gmw1PJUk5c/Mv2/ZfP/hmrVZfIj wzLstgO8E7c0O5QRNdwaqVZ3Rnh1TS7cBEAmFVJMtTqAErdZbpGFNXbUQXEguXaJkT7Boc+lsEFpQ k03CX8lue0g6aT1xjzzlEeCaa/itktQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver doesn't ever use platform_get_drvdata, so drop this unused
call.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ftm-quaddec.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index 5ef0478709cd..9272f7b58beb 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -269,8 +269,6 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 	if (!ftm)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, ftm);
-
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!io) {
 		dev_err(&pdev->dev, "Failed to get memory region\n");
-- 
2.33.0

