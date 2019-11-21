Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5E2105B86
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2019 22:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKUVB0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Nov 2019 16:01:26 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40325 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfKUVB0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Nov 2019 16:01:26 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iXtZV-0006Ob-12; Thu, 21 Nov 2019 22:01:01 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iXtZS-0006yq-RH; Thu, 21 Nov 2019 22:00:58 +0100
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
Subject: [PATCH v3 0/3] iio: adc: add support for ltc2496
Date:   Thu, 21 Nov 2019 22:00:04 +0100
Message-Id: <20191121210007.25646-1-u.kleine-koenig@pengutronix.de>
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

this is v3 of a series generalizing the driver of the ltc2497 (an i2c
ADC) to be able to reuse most of the code for the ltc2496 (an spi
variant of the ltc2497).

Iteration v2 started with Message-Id:
20191114105159.14195-1-u.kleine-koenig@pengutronix.de.

The changes since v2 are based on feedback by Jonathan Cameron:

 - rename common file to ltc2497-core.c (from ltc249x.c), also don't use
   ltc249x in names for cpp symbols, functions and variables.
 - properly align spi and i2c transfer buffers for DMA maintenance
 - improve dt binding to mention spi specific properties

Best regards
Uwe

Uwe Kleine-König (3):
  iio: adc: ltc2496: provide device tree binding document
  iio: adc: ltc2497: split protocol independent part in a separate
    module
  iio: adc: new driver to support Linear technology's ltc2496

 .../bindings/iio/adc/lltc,ltc2496.yaml        |  37 +++
 MAINTAINERS                                   |   2 +-
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   3 +-
 drivers/iio/adc/ltc2496.c                     | 108 ++++++++
 drivers/iio/adc/ltc2497-core.c                | 243 ++++++++++++++++++
 drivers/iio/adc/ltc2497.c                     | 234 ++---------------
 drivers/iio/adc/ltc2497.h                     |  18 ++
 8 files changed, 445 insertions(+), 210 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
 create mode 100644 drivers/iio/adc/ltc2496.c
 create mode 100644 drivers/iio/adc/ltc2497-core.c
 create mode 100644 drivers/iio/adc/ltc2497.h

-- 
2.24.0

