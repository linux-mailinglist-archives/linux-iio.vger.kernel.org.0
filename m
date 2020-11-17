Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D85E2B66F9
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 15:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgKQOH4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 09:07:56 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:43209 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgKQOHY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 09:07:24 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4FBFAFF819;
        Tue, 17 Nov 2020 14:07:20 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 00/11] iio: adc: at91_adc: cleanup DT bindings
Date:   Tue, 17 Nov 2020 15:06:45 +0100
Message-Id: <20201117140656.1235055-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

This series cleans up the at91_adc devicetree bindings. This mainly
moves back the resolution options and names and the triggers description
back in the driver.

There are also other cleanups, like removing platform data support, this
was pending for a while.

Changes in v2:
 - separated out the dt-binding change to give a chance to Rob to actually
   review them.
 - Dropped "iio: adc: at91_adc: use devm_input_allocate_device"
 - Collected tags
 - use of_device_get_match_data instead of device_get_match_data
 - include backportable sam9rl trigger fix

Alexandre Belloni (10):
  iio: adc: at91_adc: remove platform data
  iio: adc: at91_adc: rework resolution selection
  dt-bindings:iio:adc:remove atmel,adc-res and atmel,adc-res-names
  iio: adc: at91_adc: rework trigger definition
  dt-bindings:iio:adc:remove triggers
  iio: adc: at91_adc: merge at91_adc_probe_dt back in at91_adc_probe
  iio: adc: at91_adc: remove forward declaration
  ARM: dts: at91: sama5d3: use proper ADC compatible
  ARM: dts: at91: at91sam9rl: fix ADC triggers
  ARM: dts: at91: remove deprecated ADC properties

Jonathan Cameron (1):
  dt-bindings:iio:adc:atmel,sama9260-adc: conversion to yaml from
    at91_adc.txt

 .../devicetree/bindings/iio/adc/at91_adc.txt  |  83 -----
 .../bindings/iio/adc/atmel,sama9260-adc.yaml  | 121 ++++++
 arch/arm/boot/dts/at91sam9260.dtsi            |  25 --
 arch/arm/boot/dts/at91sam9g45.dtsi            |  27 --
 arch/arm/boot/dts/at91sam9rl.dtsi             |  25 --
 arch/arm/boot/dts/at91sam9x5.dtsi             |  28 --
 arch/arm/boot/dts/sama5d3.dtsi                |  26 +-
 arch/arm/boot/dts/sama5d4.dtsi                |  22 --
 drivers/iio/adc/at91_adc.c                    | 351 +++++++-----------
 include/linux/platform_data/at91_adc.h        |  49 ---
 10 files changed, 256 insertions(+), 501 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/at91_adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
 delete mode 100644 include/linux/platform_data/at91_adc.h

-- 
2.28.0

