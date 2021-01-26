Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81285303E4B
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 14:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404103AbhAZNNk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 08:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404111AbhAZNNg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jan 2021 08:13:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3DAC061D7F
        for <linux-iio@vger.kernel.org>; Tue, 26 Jan 2021 05:12:52 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l4O9C-0001l1-9b; Tue, 26 Jan 2021 14:12:42 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l4O9A-0002CG-Sx; Tue, 26 Jan 2021 14:12:40 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org
Subject: [PATCH v4 0/2] add support for GPIO based counter 
Date:   Tue, 26 Jan 2021 14:12:37 +0100
Message-Id: <20210126131239.8335-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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
  dt-bindings: counter: add pulse-counter binding
  counter: add IRQ or GPIO based pulse counter

 .../bindings/counter/pulse-counter.yaml       |  52 ++++
 drivers/counter/Kconfig                       |  10 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/pulse-cnt.c                   | 235 ++++++++++++++++++
 4 files changed, 298 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/pulse-counter.yaml
 create mode 100644 drivers/counter/pulse-cnt.c

-- 
2.30.0

