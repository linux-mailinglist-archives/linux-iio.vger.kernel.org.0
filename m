Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B51CE38E
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 15:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfJGN1B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 09:27:01 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35771 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfJGN1A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 09:27:00 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id B24261C000C;
        Mon,  7 Oct 2019 13:26:58 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 0/8] Introduce max12xx ADC support
Date:   Mon,  7 Oct 2019 15:26:49 +0200
Message-Id: <20191007132657.4190-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello, here is a patchset updating the existing max1027.c driver (for
10-bit max1027/29/31 ADCs) with a few corrections/improvements and
then introducing their 12-bit cousins named max1227/29/31.

As on my hardware setup the "start conversion" and "end of conversion"
pin are not wired (which is absolutely fine for this chip), I also
updated the driver and the bindings to support optional interrupts. In
this case, triggered buffers are not available and the user must poll
the value from sysfs.

Thanks,
Miquèl


Changes in v3:
==============
* Updated the commit message of the patch adding debugfs read access
  to better explain why I decided to limit the number of bytes read to
  two.
* Updated the macros to define the number of channels per device as
  proposed by Jonathan.
* Re-used the realbits entry instead of adding my own (called .depth).
* Started doing DT-bindings yaml conversion, but realized that after
  the first patch offering the interrupt as optional, the
  documentation was fitting pretty well the trivial devices
  representation. Dropped the specific bindings files and updated the
  trivial devices list instead.

Changes in v2:
==============
* Removed the addition of three compatibles from patch 4 (the
  preparation patch) to add these lines back in patch 5 (the actual
  introduction).


Miquel Raynal (8):
  iio: adc: max1027: Add debugfs register read support
  iio: adc: max1027: Make it optional to use interrupts
  iio: adc: max1027: Reset the device at probe time
  iio: adc: max1027: Prepare the introduction of different resolutions
  iio: adc: max1027: Introduce 12-bit devices support
  dt-bindings: iio: adc: max1027: Mark interrupts as optional
  dt-bindings: Add 1027/1029/1031 SPI ADCs as trivial devices
  dt-bindings: Add max12xx SPI ADC series as trivial devices

 .../bindings/iio/adc/max1027-adc.txt          |  12 +-
 .../devicetree/bindings/trivial-devices.yaml  |  12 ++
 drivers/iio/adc/Kconfig                       |   4 +-
 drivers/iio/adc/max1027.c                     | 180 +++++++++++-------
 4 files changed, 135 insertions(+), 73 deletions(-)

-- 
2.20.1

