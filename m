Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B3847F3BA
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 17:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhLYQLP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 11:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhLYQLO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 11:11:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6702C06175D
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 08:11:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dU-0008Dj-LI; Sat, 25 Dec 2021 17:11:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dT-006ahL-PY; Sat, 25 Dec 2021 17:11:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dS-0007gh-DW; Sat, 25 Dec 2021 17:11:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel@pengutronix.de
Subject: [PATCH v1 14/23] counter: Update documentation for new counter registration functions
Date:   Sat, 25 Dec 2021 17:10:47 +0100
Message-Id: <20211225161056.682797-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=JwWwP4Kk92DMBkc2853YlVwW2GZtVpOmi4eNbrbAqOM=; m=8xa0ztoxbc8pXTZ+bVJ9UNVwXDTniwv8lnzxq3YKbKo=; p=hdEi+4ZXao9qa6MHkZ3aC+8cHDmJEmeKboRh2kfI+gM=; g=136907a6200880612a96065c1ff90c379cd4bf57
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHHQmIACgkQwfwUeK3K7Alf4Af7B8D fxg2VcKvTrOY+zFnZ60x7Zt5GvuvkYCnMPYD1f8/LjMcTG4pbt/hOHRAHSpP/z2hUbDIJ1rBnMpWP B9OyFyLCdbwCYnFIM07zSr2vnT5nbHe8I0Z1La4p5jXRvLjjzb5Y6gqbNNgUNqKfPCNDBZWzJ7d/K NGzzR5O6zXZ9Enzxm6sPv5X29eJU5lBtt5klrqvtto9sy3bjRZfiq/C0VdbkxrfBHNEEJH3PWzvpB oybml67Eszk3LByYfpxjRRMS+7BUrX7yRG9PkosfhdL+53dLwyBiL0Zt3Us97dV09Ujfj1pW5MbA+ 3+w8ael/dAX6iWc+m7o1emoPkJXVZ2A==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In order to replace the counter registration API also update the
documentation to the new way.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/driver-api/generic-counter.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index 1b487a331467..991b180c7b47 100644
--- a/Documentation/driver-api/generic-counter.rst
+++ b/Documentation/driver-api/generic-counter.rst
@@ -262,11 +262,11 @@ order to communicate with the device: to read and write various Signals
 and Counts, and to set and get the "action mode" and "function mode" for
 various Synapses and Counts respectively.
 
-A defined counter_device structure may be registered to the system by
-passing it to the counter_register function, and unregistered by passing
-it to the counter_unregister function. Similarly, the
-devm_counter_register function may be used if device memory-managed
-registration is desired.
+A counter_device structure is supposed to be allocated using counter_alloc()
+and may be registered to the system by passing it to the counter_add()
+function, and unregistered by passing it to the counter_unregister function.
+There are device managed variants of these functions: devm_counter_alloc() and
+devm_counter_add().
 
 The struct counter_comp structure is used to define counter extensions
 for Signals, Synapses, and Counts.
-- 
2.33.0

