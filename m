Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4F547F3C9
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 17:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhLYQLW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 11:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhLYQLU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 11:11:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE4FC06175E
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 08:11:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dU-0008D8-LL; Sat, 25 Dec 2021 17:11:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dQ-006agg-PK; Sat, 25 Dec 2021 17:11:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dP-0007eM-Rs; Sat, 25 Dec 2021 17:11:03 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel@pengutronix.de
Subject: [PATCH v1 01/23] counter: Use container_of instead of drvdata to track counter_device
Date:   Sat, 25 Dec 2021 17:10:34 +0100
Message-Id: <20211225161056.682797-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=WhZLdLliam1HUvYgAAdyYZqU7b1Ox6SZw+AoFf3AYfo=; m=9wq0CKsz7Zt+5kbGc6ZP9L3j/ut+4WtFH3D3A21gjvg=; p=TR5ghLNVD5w+ejoxev7uMl+j4ICbXKPQUuSfB2Fckww=; g=fd9c9e8d0472fe9e05d9e8e3943c38b880e5b1dd
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHHQiUACgkQwfwUeK3K7AmXGwf/dOI Vz+taCDWLsHwJsJ3yvcsALTXbWSgYSkrS7AI28Ezgn4kcfnUF01/Q5XrCh/+7UdpS9mB4NEZXqNol /Ihpn9n9wA5SR15G+Ar2r1RdnZ/y8O422+YyF1ZA5JqzHnfY3l6TiWxQXZjXWUcv9e4uXqMa082yC HaznIsGXGJNAN60epSYIsHsXG/EE0hVdMKTMnF4jjLn0t/x7nxUvijN56uaD8cqN5jLfK+6rE0Bru mnZgqkzJ/td1CDxifafS/zQkx3lQ6HsCvbEHA0bkBoiNe1/GMP94/FvKztlFD97jQsy4Sx6N7BvVF rxVnQiSH1GEPVyDcW5JuRVL83IFOaKA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The counter core uses drvdata to find a struct counter_device from a
struct device. However as the device is a member of struct counter_device,
the lookup can be done faster (and a bit type safe) using container_of.

There are no other users of drvdata, so the call to dev_set_drvdata can
go away, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/counter-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 5acc54539623..f053a43c6c04 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -26,7 +26,8 @@ static DEFINE_IDA(counter_ida);
 
 static void counter_device_release(struct device *dev)
 {
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter =
+		container_of(dev, struct counter_device, dev);
 
 	counter_chrdev_remove(counter);
 	ida_free(&counter_ida, dev->id);
@@ -78,7 +79,6 @@ int counter_register(struct counter_device *const counter)
 		dev->of_node = counter->parent->of_node;
 	}
 	device_initialize(dev);
-	dev_set_drvdata(dev, counter);
 
 	err = counter_sysfs_add(counter);
 	if (err < 0)
-- 
2.33.0

