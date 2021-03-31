Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DCA3448AF
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 16:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCVPGr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 11:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhCVPGU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 11:06:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28FEC0613DA
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 08:06:18 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lOM8A-0000Lr-02; Mon, 22 Mar 2021 16:06:10 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lOM89-0003l5-Cr; Mon, 22 Mar 2021 16:06:09 +0100
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
Subject: [PATCH v4 0/3] mainline ti tsc2046 adc driver
Date:   Mon, 22 Mar 2021 16:06:05 +0100
Message-Id: <20210322150608.14347-1-o.rempel@pengutronix.de>
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

changes v4:
- spell fixes
- add more comments
- make code more readable
- move scan_buf to the priv
- use FIELD_GET to extract ADC data
- make some multi line code as one line
- do not use atomic API for trig_more_count
- fix build warning on 64bit system
- add NULL check for the devm_kasprintf()
- use return devm_iio_device_register(), without additional error
  printing.

changes v3:
- different spell fixes
- add some notes about driver structure
- rename the trigger to point on the touchscreen nature of it
- rename DT binding to oversampling-ratio
- make sure we have some defaults in case no DT property is set

changes v2:
- rework and extend DT binding properties
- remove touchscreen related code from the IIO ADC driver
- make trigger be active longer then IRQ is requesting. This is needed
  to get "inactive" samples
- make oversampling and settle time configurable

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

Oleksij Rempel (3):
  dt-bindings:iio:adc: add generic settling-time-us and
    oversampling-ratio channel properties
  dt-bindings:iio:adc: add documentation for TI TSC2046 controller
  iio: adc: add ADC driver for the TI TSC2046 controller

 .../devicetree/bindings/iio/adc/adc.yaml      |   9 +
 .../bindings/iio/adc/ti,tsc2046.yaml          | 115 +++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-tsc2046.c                  | 726 ++++++++++++++++++
 6 files changed, 871 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
 create mode 100644 drivers/iio/adc/ti-tsc2046.c

-- 
2.29.2

