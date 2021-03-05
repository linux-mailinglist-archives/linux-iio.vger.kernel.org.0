Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC25132EC55
	for <lists+linux-iio@lfdr.de>; Fri,  5 Mar 2021 14:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhCENiy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Mar 2021 08:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhCENiZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Mar 2021 08:38:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F649C06175F
        for <linux-iio@vger.kernel.org>; Fri,  5 Mar 2021 05:38:25 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lIAen-00039m-1T; Fri, 05 Mar 2021 14:38:17 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lIAel-0007IH-5a; Fri, 05 Mar 2021 14:38:15 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v1 0/2] mainline ti tsc2046 adc driver
Date:   Fri,  5 Mar 2021 14:38:11 +0100
Message-Id: <20210305133813.27967-1-o.rempel@pengutronix.de>
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

TI TSC2046 is a touchscreen controller based on 8 channel ADC. Since most of
this ADC based touchscreen controller share same set of challenges, it
is better keep then as simple IIO ADC devices attached to a generic
resistive-adc-touch driver.

This driver can replace drivers/input/touchscreen/ads7846.c and has
following advantages over it:
- less code to maintain
- shared code paths (resistive-adc-touch, iio-hwmon, etc)
- can be used as plain IIO ADC to investigate signaling issues or test
  real capacity of the plates and attached low-pass filters
  (or use the touchscreen as a microphone if you like ;) )

Oleksij Rempel (2):
  dt-bindings:iio:adc: add documentation for TI TSC2046 controller
  iio: adc: add ADC driver for the TI TSC2046 controller

 .../bindings/iio/adc/ti,tsc2046.yaml          |  52 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-tsc2046.c                  | 652 ++++++++++++++++++
 5 files changed, 725 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
 create mode 100644 drivers/iio/adc/ti-tsc2046.c

-- 
2.29.2

