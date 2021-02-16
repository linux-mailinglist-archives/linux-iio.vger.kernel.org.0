Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE8B31C733
	for <lists+linux-iio@lfdr.de>; Tue, 16 Feb 2021 09:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhBPIQZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Feb 2021 03:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBPIQR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Feb 2021 03:16:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522B2C06178B
        for <linux-iio@vger.kernel.org>; Tue, 16 Feb 2021 00:14:25 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lBvUw-0000SJ-MH; Tue, 16 Feb 2021 09:14:18 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lBvUv-0000x5-Em; Tue, 16 Feb 2021 09:14:17 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v6 0/2] add support for GPIO or IRQ based evemt counter 
Date:   Tue, 16 Feb 2021 09:13:54 +0100
Message-Id: <20210216081356.3577-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

changes v6:
- rename it to interrupt-counter
- driver fixes
- device tree fixes

changes v5:
- rename it to event counter, since it support different event sources
- make it work with gpio-only or irq-only configuration
- update yaml binding

changes v4:
- use IRQ_NOAUTOEN to not enable IRQ by default
- rename gpio_ from name pattern and make this driver work any IRQ
  source.

changes v3:
- convert counter to atomic_t

changes v2:
- add commas
- avoid possible unhandled interrupts in the enable path
- do not use of_ specific gpio functions

Add support for GPIO based pulse counter. For now it can only count
pulses. With counter char device support, we will be able to attach
timestamps and measure actual pulse frequency.

Never the less, it is better to mainline this driver now (before chardev
patches go mainline), to provide developers additional use case for the counter
framework with chardev support.

Oleksij Rempel (2):
  dt-bindings: counter: add event-counter binding
  counter: add IRQ or GPIO based event counter

 .../bindings/counter/interrupt-counter.yaml   |  62 +++++
 MAINTAINERS                                   |   7 +
 drivers/counter/Kconfig                       |  10 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/interrupt-cnt.c               | 249 ++++++++++++++++++
 5 files changed, 329 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/interrupt-counter.yaml
 create mode 100644 drivers/counter/interrupt-cnt.c

-- 
2.29.2

