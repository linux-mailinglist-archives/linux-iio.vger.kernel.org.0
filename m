Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE09AB5956
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 03:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfIRBfc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 21:35:32 -0400
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139]:42474
        "EHLO rjones.pdc.gateworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728164AbfIRBfc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 21:35:32 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Sep 2019 21:35:32 EDT
Received: by rjones.pdc.gateworks.com (Postfix, from userid 1002)
        id 5FE621A48110; Tue, 17 Sep 2019 18:29:17 -0700 (PDT)
From:   Robert Jones <rjones@gateworks.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Jones <rjones@gateworks.com>
Subject: [PATCH 0/2] iio: imu: add support for FXOS8700
Date:   Tue, 17 Sep 2019 18:28:54 -0700
Message-Id: <20190918012856.18963-1-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

- Document the FXOS8700 device tree binding.
- Implement basic iio driver support for FXOS8700

Robert Jones (2):
  dt-bindings: iio: imu: add fxos8700 imu binding
  io: imu: Add support for the FXOS8700 IMU

 .../devicetree/bindings/iio/imu/fxos8700.txt       |  15 +
 drivers/iio/imu/Kconfig                            |   1 +
 drivers/iio/imu/Makefile                           |   1 +
 drivers/iio/imu/fxos8700/Kconfig                   |  32 ++
 drivers/iio/imu/fxos8700/Makefile                  |   6 +
 drivers/iio/imu/fxos8700/fxos8700.h                | 183 ++++++++
 drivers/iio/imu/fxos8700/fxos8700_core.c           | 517 +++++++++++++++++++++
 drivers/iio/imu/fxos8700/fxos8700_i2c.c            |  75 +++
 drivers/iio/imu/fxos8700/fxos8700_spi.c            |  63 +++
 9 files changed, 893 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/fxos8700.txt
 create mode 100644 drivers/iio/imu/fxos8700/Kconfig
 create mode 100644 drivers/iio/imu/fxos8700/Makefile
 create mode 100644 drivers/iio/imu/fxos8700/fxos8700.h
 create mode 100644 drivers/iio/imu/fxos8700/fxos8700_core.c
 create mode 100644 drivers/iio/imu/fxos8700/fxos8700_i2c.c
 create mode 100644 drivers/iio/imu/fxos8700/fxos8700_spi.c

-- 
2.9.2

