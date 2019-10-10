Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0967FD1DF6
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2019 03:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbfJJBZ1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Oct 2019 21:25:27 -0400
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139]:46908
        "EHLO rjones.pdc.gateworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731553AbfJJBZ1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Oct 2019 21:25:27 -0400
Received: by rjones.pdc.gateworks.com (Postfix, from userid 1002)
        id BFEA81A41B4D; Wed,  9 Oct 2019 18:25:26 -0700 (PDT)
From:   Robert Jones <rjones@gateworks.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Jones <rjones@gateworks.com>
Subject: [PATCH v2 0/2] iio: imu: add support for FXOS8700
Date:   Wed,  9 Oct 2019 18:25:21 -0700
Message-Id: <20191010012523.14426-1-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20190918012856.18963-1-rjones@gateworks.com>
References: <20190918012856.18963-1-rjones@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

- Document the FXOS8700 device tree binding.
- Implement basic iio driver support for FXOS8700

Changes in v2:
- Reorganized files to base imu directory
- Converted devicetree bindings doc to schema
- Moved single use function definitions out of header
- Added bit definitions and #define usages
- Moved buffer for regmap_bulk_read to private data struct
- Clarified get_data operations
- Remove unreachable code
- Remove log noise
- Remove of_match_ptr() macro usage
- Various style and whitespace changes

Robert Jones (2):
  dt-bindings: iio: imu: add fxos8700 imu binding
  iio: imu: Add support for the FXOS8700 IMU

 .../devicetree/bindings/iio/imu/fxos8700.yaml      |  54 +++
 drivers/iio/imu/Kconfig                            |  28 ++
 drivers/iio/imu/Makefile                           |   5 +
 drivers/iio/imu/fxos8700.h                         | 185 ++++++++
 drivers/iio/imu/fxos8700/Kconfig                   |  30 ++
 drivers/iio/imu/fxos8700/Makefile                  |   6 +
 drivers/iio/imu/fxos8700_core.c                    | 501 +++++++++++++++++++++
 drivers/iio/imu/fxos8700_i2c.c                     |  73 +++
 drivers/iio/imu/fxos8700_spi.c                     |  61 +++
 9 files changed, 943 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/fxos8700.yaml
 create mode 100644 drivers/iio/imu/fxos8700.h
 create mode 100644 drivers/iio/imu/fxos8700/Kconfig
 create mode 100644 drivers/iio/imu/fxos8700/Makefile
 create mode 100644 drivers/iio/imu/fxos8700_core.c
 create mode 100644 drivers/iio/imu/fxos8700_i2c.c
 create mode 100644 drivers/iio/imu/fxos8700_spi.c

--
2.9.2

