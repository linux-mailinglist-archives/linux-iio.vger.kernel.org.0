Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3BB47F3B5
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 17:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhLYQLO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 11:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbhLYQLO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 11:11:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F43C061757
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 08:11:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dU-0008DE-LM; Sat, 25 Dec 2021 17:11:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dR-006agm-AU; Sat, 25 Dec 2021 17:11:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dQ-0007ep-8L; Sat, 25 Dec 2021 17:11:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel@pengutronix.de
Subject: [PATCH v1 03/23] counter: microchip-tcb-capture: Drop unused platform_set_drvdata()
Date:   Sat, 25 Dec 2021 17:10:36 +0100
Message-Id: <20211225161056.682797-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=IJqGyNaenfaZbz/IO7oJSnAPP05nliYMDFydrRs1onw=; m=qa0/nnsbHdKDuWY5QI5nC4IISJUbD9bjLmxbmrIZnvk=; p=F2i/tqBhLyub3ogMOMnX0RwvzyCzrWApj0iUvOTunpc=; g=11af2e19c7ba28dd17ba312c8215a1b669ce6c19
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHHQi0ACgkQwfwUeK3K7AmSdQf/S0I ST5Q39syyo2eunyu+FBy9V3nEaNSlhjCmSOykkS1GUjmVR+Jpe46Y+Ug155/GHTGbGf4ScfYUtZmL wP4D+zMUGKTwHCzNwnubLk4bikdhscC17YKDgZH6OG8EHhQXrbrMpcQVtj59lCLxLoqiSUn1N77km ++kXEOFweSdsWMNJQitzwqxzdVEqTWfwrVbhhdCBqIiIL0w5fiFrnUv68mesNt71hzyElytCV6Feh FyByxFNWuj81LywFAUHCa5aQQiFeJOcnwWMhVr8HPAu7qXL602cjcTdN4Jp8MvXs9WsT/GJ7U8jBj 886glyO0kIrrR/FxXAzdqq7PB83aCGw==
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
 drivers/counter/microchip-tcb-capture.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 0ab1b2716784..bb69f2e0ba93 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -307,8 +307,6 @@ static int mchp_tc_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, priv);
-
 	match = of_match_node(atmel_tc_of_match, np->parent);
 	tcb_config = match->data;
 	if (!tcb_config) {
-- 
2.33.0

