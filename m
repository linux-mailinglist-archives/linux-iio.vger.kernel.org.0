Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A468FC4B4
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2019 11:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfKNKwU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Nov 2019 05:52:20 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38145 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNKwU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Nov 2019 05:52:20 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iVCjL-0005Hl-CP; Thu, 14 Nov 2019 11:52:03 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iVCjJ-0003yF-DX; Thu, 14 Nov 2019 11:52:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 0/3] iio: adc: add support for ltc2496
Date:   Thu, 14 Nov 2019 11:51:56 +0100
Message-Id: <20191114105159.14195-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

this is v2 of a series sent earlier starting with Message-id:
20191111214025.18310-1-u.kleine-koenig@pengutronix.de and addresses the
comments by Alexandru Ardelean. I'm a bit naughty here because I didn't
carry out all suggestions. So I didn't use ...-spi.c and -i2c.c as file
names, because this isn't about a single chip supporting both, but two
different ones supporting only one bus each. So I thought ltc2496.c,
ltc2497.c and ltc249x.c was fine.

Also I didn't merge the binding docs of ltc2496 and ltc2497 for the same
reason. I'm still not entirely happy with the (now) yaml document. I'd
like to have a statement that says: This is an spi device, so it might
have all the properties described in
Documentation/devicetree/bindings/spi/spi-controller.yaml for an SPI
device.

Uwe Kleine-König (3):
  iio: adc: ltc2496: provide device tree binding document
  iio: adc: ltc2497: split protocol independent part in a separate
    module
  iio: adc: new driver to support Linear technology's ltc2496

 .../bindings/iio/adc/lltc,ltc2496.yaml        |  30 +++
 MAINTAINERS                                   |   2 +-
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   3 +-
 drivers/iio/adc/ltc2496.c                     | 100 +++++++
 drivers/iio/adc/ltc2497.c                     | 237 ++---------------
 drivers/iio/adc/ltc249x.c                     | 244 ++++++++++++++++++
 drivers/iio/adc/ltc249x.h                     |  18 ++
 8 files changed, 433 insertions(+), 211 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
 create mode 100644 drivers/iio/adc/ltc2496.c
 create mode 100644 drivers/iio/adc/ltc249x.c
 create mode 100644 drivers/iio/adc/ltc249x.h


base-commit: 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c
-- 
2.24.0

