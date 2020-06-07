Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484A81F0D82
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 20:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgFGSAp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 14:00:45 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:51801 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726841AbgFGSAp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2020 14:00:45 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.156.68])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id 6911955D9B70;
        Sun,  7 Jun 2020 20:00:42 +0200 (CEST)
Received: from arch.lan (89.70.180.118) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sun, 7 Jun 2020
 20:00:35 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <jic23@kernel.org>,
        <andy.shevchenko@gmail.com>, <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH v5 0/4] Add support for SCD30 sensor
Date:   Sun, 7 Jun 2020 19:58:08 +0200
Message-ID: <20200607175812.95777-1-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.180.118]
X-ClientProxiedBy: DAG2EX2.emp2.local (172.16.2.12) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 3119305692199738391
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudegledguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffoggfgtghisehtkeertdertddtnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnhephedtgefgkeduvdekheeggefghffhteekleetvdekvddtveeutdetueefueehieetnecukfhppedtrddtrddtrddtpdekledrjedtrddukedtrdduudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtohepphhmvggvrhifsehpmhgvvghrfidrnhgvth
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Following series adds support for Sensirion SCD30 sensor module capable of
measuring carbon dioxide, temperature and relative humidity. CO2 measurements
base on NDIR principle while temperature and relative humidity are measured by
the on board SHT31. As for sensor communication, both I2C and serial interfaces
are supported.

v5:
* set pressure calibration via output channel
* use kstrtobool() to read value into _enabled attribute
* drop explicit parent asignment as the default one is good enough
  (seems 'iio: core: pass parent device as parameter during allocation'
   series was accepted)

v4:
* improve formatting
* improve error handling readability
* fix message validity check on serial write

v3:
* simplify code by scaling temperature & humidity in _read_meas()
* update realbits in scan types
* s/adjecent/adjacent
* drop IIO_CHAN_INFO_RAW from _write_raw_get_fmt because there's no raw
  output channel
* rework locking in _read_raw
* fix endianess problem on BE machine
* align timestamp properly before pushing to buffers
* explain why interrupt gets disabled after registration
* add trigger validation
* drop SCALE for temperature and humidity channel as they are processed
* register action which stops measuring after starting measurements
* spit generic calibration attr into two doing specific things
* add comment explaining why priv in struct scd30_state is for
* rename node in binding example to co2-sensor

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

 Documentation/ABI/testing/sysfs-bus-iio-scd30 |  34 +
 .../iio/chemical/sensirion,scd30.yaml         |  68 ++
 MAINTAINERS                                   |   9 +
 drivers/iio/chemical/Kconfig                  |  33 +
 drivers/iio/chemical/Makefile                 |   3 +
 drivers/iio/chemical/scd30.h                  |  78 ++
 drivers/iio/chemical/scd30_core.c             | 770 ++++++++++++++++++
 drivers/iio/chemical/scd30_i2c.c              | 139 ++++
 drivers/iio/chemical/scd30_serial.c           | 263 ++++++
 9 files changed, 1397 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
 create mode 100644 drivers/iio/chemical/scd30.h
 create mode 100644 drivers/iio/chemical/scd30_core.c
 create mode 100644 drivers/iio/chemical/scd30_i2c.c
 create mode 100644 drivers/iio/chemical/scd30_serial.c

--
2.27.0

