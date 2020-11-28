Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC4E2C7606
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgK1W3J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 17:29:09 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:56857 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgK1W3J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Nov 2020 17:29:09 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id DD1C41BF203;
        Sat, 28 Nov 2020 22:28:25 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 00/10] iio: adc: at91_adc: cleanup DT bindings
Date:   Sat, 28 Nov 2020 23:28:08 +0100
Message-Id: <20201128222818.1910764-1-alexandre.belloni@bootlin.com>
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

Changes in v3:
 - rebased on the togreg branch of iio.git
 - dropped "iio: adc: at91_adc: remove forward declaration" as it was already
   done in tree
 - Reworked patch 1 from "iio: adc: at91_adc: remove platform data" to "iio:
   adc: at91_adc: remove at91_adc_ids"

Changes in v2:
 - separated out the dt-binding change to give a chance to Rob to actually
   review them.
 - Dropped "iio: adc: at91_adc: use devm_input_allocate_device"
 - Collected tags
 - use of_device_get_match_data instead of device_get_match_data
 - include backportable sam9rl trigger fix


Alexandre Belloni (9):
  iio: adc: at91_adc: remove at91_adc_ids
  iio: adc: at91_adc: rework resolution selection
  dt-bindings:iio:adc:remove atmel,adc-res and atmel,adc-res-names
  iio: adc: at91_adc: rework trigger definition
  dt-bindings:iio:adc:remove triggers
  iio: adc: at91_adc: merge at91_adc_probe_dt back in at91_adc_probe
  ARM: dts: at91: sama5d3: use proper ADC compatible
  ARM: dts: at91: at91sam9rl: fix ADC triggers
  ARM: dts: at91: remove deprecated ADC properties

Jonathan Cameron (1):
  dt-bindings:iio:adc:atmel,sama9260-adc: conversion to yaml from
    at91_adc.txt

 .../devicetree/bindings/iio/adc/at91_adc.txt  |  83 -----
 .../bindings/iio/adc/atmel,sama9260-adc.yaml  | 121 +++++++
 arch/arm/boot/dts/at91sam9260.dtsi            |  25 --
 arch/arm/boot/dts/at91sam9g45.dtsi            |  27 --
 arch/arm/boot/dts/at91sam9rl.dtsi             |  25 --
 arch/arm/boot/dts/at91sam9x5.dtsi             |  28 --
 arch/arm/boot/dts/sama5d3.dtsi                |  26 +-
 arch/arm/boot/dts/sama5d4.dtsi                |  22 --
 drivers/iio/adc/at91_adc.c                    | 294 +++++++-----------
 9 files changed, 237 insertions(+), 414 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/at91_adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml

-- 
2.28.0

