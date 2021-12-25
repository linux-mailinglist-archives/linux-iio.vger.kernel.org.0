Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A9E47F3C2
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 17:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhLYQLS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 11:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhLYQLR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 11:11:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DF9C061759
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 08:11:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dY-0008D7-PN; Sat, 25 Dec 2021 17:11:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dQ-006agf-Lm; Sat, 25 Dec 2021 17:11:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dP-0007eG-Mi; Sat, 25 Dec 2021 17:11:03 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel@pengutronix.de, David Lechner <david@lechnology.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Felipe Balbi <balbi@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Raymond Tan <raymond.tan@intel.com>
Subject: [PATCH v1 00/23] counter: cleanups and device lifetime fixes
Date:   Sat, 25 Dec 2021 17:10:33 +0100
Message-Id: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

this serie's goal is to fix struct device lifetime issues as pointed out
in patch #13. The patches up to patch #12 are only prepatory and cleanup
patches. Patch #13 provides the needed functions to fix the issues in
all drivers (patches #15 to #22). The last patch removes the then unused
API calls.

Best regards
Uwe

Uwe Kleine-König (23):
  counter: Use container_of instead of drvdata to track counter_device
  counter: ftm-quaddec: Drop unused platform_set_drvdata()
  counter: microchip-tcb-capture: Drop unused platform_set_drvdata()
  counter: Provide a wrapper to access device private data
  counter: 104-quad-8: Convert to counter_priv() wrapper
  counter: interrupt-cnt: Convert to counter_priv() wrapper
  counter: microchip-tcb-capture: Convert to counter_priv() wrapper
  counter: intel-qep: Convert to counter_priv() wrapper
  counter: ftm-quaddec: Convert to counter_priv() wrapper
  counter: ti-eqep: Convert to counter_priv() wrapper
  counter: stm32-lptimer-cnt: Convert to counter_priv() wrapper
  counter: stm32-timer-cnt: Convert to counter_priv() wrapper
  counter: Provide alternative counter registration functions
  counter: Update documentation for new counter registration functions
  counter: 104-quad-8: Convert to new counter registration
  counter: interrupt-cnt: Convert to new counter registration
  counter: intel-qep: Convert to new counter registration
  counter: ftm-quaddec: Convert to new counter registration
  counter: microchip-tcb-capture: Convert to new counter registration
  counter: stm32-timer-cnt: Convert to new counter registration
  counter: stm32-lptimer-cnt: Convert to new counter registration
  counter: ti-eqep: Convert to new counter registration
  counter: remove old and now unused registration API

 Documentation/driver-api/generic-counter.rst |  10 +-
 drivers/counter/104-quad-8.c                 |  88 +++++-----
 drivers/counter/counter-core.c               | 168 +++++++++++++------
 drivers/counter/ftm-quaddec.c                |  37 ++--
 drivers/counter/intel-qep.c                  |  46 ++---
 drivers/counter/interrupt-cnt.c              |  38 +++--
 drivers/counter/microchip-tcb-capture.c      |  44 ++---
 drivers/counter/stm32-lptimer-cnt.c          |  51 +++---
 drivers/counter/stm32-timer-cnt.c            |  48 +++---
 drivers/counter/ti-eqep.c                    |  47 +++---
 include/linux/counter.h                      |  15 +-
 11 files changed, 345 insertions(+), 247 deletions(-)


base-commit: a7904a538933c525096ca2ccde1e60d0ee62c08e
-- 
2.33.0

