Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2801B4720
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgDVOWN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 10:22:13 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:34267 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbgDVOWN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 10:22:13 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.4.231])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id 984EE4F477ED;
        Wed, 22 Apr 2020 16:13:05 +0200 (CEST)
Received: from arch.lan (89.70.31.203) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 22 Apr
 2020 16:13:04 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <jic23@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH 0/6] Add support for SCD30 sensor
Date:   Wed, 22 Apr 2020 16:11:29 +0200
Message-ID: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.31.203]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 5832442993075313687
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrgeejgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffoggfgtghisehtkeertdertddtnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecukfhppedtrddtrddtrddtpdekledrjedtrdefuddrvddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrgh
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Following series adds support for Sensirion SCD30 sensor module capable of
measuring carbon dioxide, temperature and relative humidity. CO2 measurements
base on NDIR principle while temperature and relative humidity are measured by
the on board SHT31. As for sensor communication, both I2C and serial interfaces
are supported.

Tomasz Duszynski (6):
  iio: chemical: scd30: add core driver
  iio: chemical: scd30: add I2C interface driver
  iio: chemical: scd30: add serial interface driver
  Documentation: ABI: testing: scd30: document iio attributes
  dt-bindings: iio: scd30: add device binding file
  MAINTAINERS: add myself as a SCD30 driver maintainer

 Documentation/ABI/testing/sysfs-bus-iio-scd30 |  97 +++
 .../iio/chemical/sensirion,scd30.yaml         |  71 ++
 MAINTAINERS                                   |   9 +
 drivers/iio/chemical/Kconfig                  |  33 +
 drivers/iio/chemical/Makefile                 |   3 +
 drivers/iio/chemical/scd30.h                  |  72 ++
 drivers/iio/chemical/scd30_core.c             | 796 ++++++++++++++++++
 drivers/iio/chemical/scd30_i2c.c              | 141 ++++
 drivers/iio/chemical/scd30_serial.c           | 262 ++++++
 9 files changed, 1484 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
 create mode 100644 drivers/iio/chemical/scd30.h
 create mode 100644 drivers/iio/chemical/scd30_core.c
 create mode 100644 drivers/iio/chemical/scd30_i2c.c
 create mode 100644 drivers/iio/chemical/scd30_serial.c

--
2.26.1

