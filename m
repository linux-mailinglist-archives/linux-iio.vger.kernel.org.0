Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D388AC8884
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 14:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfJBMab (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 08:30:31 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50785 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJBMaa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2019 08:30:30 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id D35FBE0013;
        Wed,  2 Oct 2019 12:30:26 +0000 (UTC)
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
Subject: [PATCH 0/7] Introduce max12xx ADC support
Date:   Wed,  2 Oct 2019 14:30:18 +0200
Message-Id: <20191002123025.21413-1-miquel.raynal@bootlin.com>
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


Miquel Raynal (7):
  iio: adc: max1027: Add debugfs register read support
  iio: adc: max1027: Make it optional to use interrupts
  iio: adc: max1027: Reset the device at probe time
  iio: adc: max1027: Prepare the introduction of different resolutions
  iio: adc: max1027: Introduce 12-bit devices support
  dt-bindings: iio: adc: max1027: Mark interrupts as optional
  dt-bindings: iio: adc: max1027: Document max12xx series compatibles

 .../bindings/iio/adc/max1027-adc.txt          |  12 +-
 drivers/iio/adc/Kconfig                       |   4 +-
 drivers/iio/adc/max1027.c                     | 190 +++++++++++-------
 3 files changed, 133 insertions(+), 73 deletions(-)

-- 
2.20.1

