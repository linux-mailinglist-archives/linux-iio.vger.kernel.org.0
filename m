Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5051EC067
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 18:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgFBQt4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 12:49:56 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:39171 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgFBQt4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2020 12:49:56 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.156.120])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 27740607D9B2;
        Tue,  2 Jun 2020 18:49:53 +0200 (CEST)
Received: from localhost.localdomain (34.103.240.103) by DAG2EX1.emp2.local
 (172.16.2.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 2 Jun 2020
 18:49:52 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <jic23@kernel.org>,
        <andy.shevchenko@gmail.com>, <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH v3 0/4] Add support for SCD30 sensor
Date:   Tue, 2 Jun 2020 18:47:19 +0200
Message-ID: <20200602164723.28858-1-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [34.103.240.103]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 9453337095702141975
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudefjedgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofgggfgtihesthekredtredttdenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehtdeggfekuddvkeehgeeggffhhfetkeeltedvkedvtdevuedtteeufeeuheeiteenucfkpheptddrtddrtddrtddpfeegrddutdefrddvgedtrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtohepphhmvggvrhifsehpmhgvvghrfidrnhgvth
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Following series adds support for Sensirion SCD30 sensor module capable of
measuring carbon dioxide, temperature and relative humidity. CO2 measurements
base on NDIR principle while temperature and relative humidity are measured by
the on board SHT31. As for sensor communication, both I2C and serial interfaces
are supported.

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
 drivers/iio/chemical/scd30.h                  |  80 ++
 drivers/iio/chemical/scd30_core.c             | 783 ++++++++++++++++++
 drivers/iio/chemical/scd30_i2c.c              | 134 +++
 drivers/iio/chemical/scd30_serial.c           | 266 ++++++
 9 files changed, 1410 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
 create mode 100644 drivers/iio/chemical/scd30.h
 create mode 100644 drivers/iio/chemical/scd30_core.c
 create mode 100644 drivers/iio/chemical/scd30_i2c.c
 create mode 100644 drivers/iio/chemical/scd30_serial.c

--
2.26.2

