Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5682D1E93F6
	for <lists+linux-iio@lfdr.de>; Sat, 30 May 2020 23:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgE3Vit (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 May 2020 17:38:49 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:45487 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729098AbgE3Vit (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 May 2020 17:38:49 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.143.168])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id 1D60B54AA496;
        Sat, 30 May 2020 23:38:47 +0200 (CEST)
Received: from arch.lan (89.70.180.118) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sat, 30 May
 2020 23:38:39 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <jic23@kernel.org>,
        <andy.shevchenko@gmail.com>, <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH v2 0/4] Add support for SCD30 sensor
Date:   Sat, 30 May 2020 23:36:26 +0200
Message-ID: <20200530213630.87159-1-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.180.118]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 15161086671329451031
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeftddgudeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffoggfgtghisehtkeertdertddtnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnhephedtgefgkeduvdekheeggefghffhteekleetvdekvddtveeutdetueefueehieetnecukfhppedtrddtrddtrddtpdekledrjedtrddukedtrdduudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtohepphhmvggvrhifsehpmhgvvghrfidrnhgvth
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Following series adds support for Sensirion SCD30 sensor module capable of
measuring carbon dioxide, temperature and relative humidity. CO2 measurements
base on NDIR principle while temperature and relative humidity are measured by
the on board SHT31. As for sensor communication, both I2C and serial interfaces
are supported.

v2:
* move asm/byteorder.h towards the bottom of include list
* make channel address names in enum more specific
* add postfixes to defines and extra comments
* drop unneeded i2c include from scd30 header
* break generic command sending function into specialized options
* expose automatic calibration and forced calibration via the same attr
* use SAMP_FREQ to set frequency instead of meas_interval attr
* use CALISCALE to set pressure compensation instead of pressure_comp attr
* use CALIBBIAS to set temperature offset instead of temp_offset attr
* fix order in MAINTAINERS
* drop attribute allowing one to reset sensor
* as we have dt probing drop board file based probing (i2c_device_id)
* merge patches touching related files
* use fwnode API to retrieve interrupt from dt
* fix interrupt-parent spelling
* change binding license
* drop supply from required property

Tomasz Duszynski (4):
  iio: chemical: scd30: add core driver
  iio: chemical: scd30: add I2C interface driver
  iio: chemical: scd30: add serial interface driver
  dt-bindings: iio: scd30: add device binding file

 Documentation/ABI/testing/sysfs-bus-iio-scd30 |  20 +
 .../iio/chemical/sensirion,scd30.yaml         |  68 ++
 MAINTAINERS                                   |   9 +
 drivers/iio/chemical/Kconfig                  |  33 +
 drivers/iio/chemical/Makefile                 |   3 +
 drivers/iio/chemical/scd30.h                  |  75 ++
 drivers/iio/chemical/scd30_core.c             | 764 ++++++++++++++++++
 drivers/iio/chemical/scd30_i2c.c              | 134 +++
 drivers/iio/chemical/scd30_serial.c           | 266 ++++++
 9 files changed, 1372 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
 create mode 100644 drivers/iio/chemical/scd30.h
 create mode 100644 drivers/iio/chemical/scd30_core.c
 create mode 100644 drivers/iio/chemical/scd30_i2c.c
 create mode 100644 drivers/iio/chemical/scd30_serial.c

--
2.26.2

