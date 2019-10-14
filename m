Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71879D69BB
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2019 20:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbfJNStc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Oct 2019 14:49:32 -0400
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139]:39548
        "EHLO rjones.pdc.gateworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732294AbfJNStc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2019 14:49:32 -0400
Received: by rjones.pdc.gateworks.com (Postfix, from userid 1002)
        id E398E1A47B9B; Mon, 14 Oct 2019 11:49:30 -0700 (PDT)
From:   Robert Jones <rjones@gateworks.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Jones <rjones@gateworks.com>
Subject: [PATCH v4 0/2] iio: imu: add support for FXOS8700
Date:   Mon, 14 Oct 2019 11:49:19 -0700
Message-Id: <20191014184921.22524-1-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20191010175648.10830-1-rjones@gateworks.com>
References: <20191010175648.10830-1-rjones@gateworks.com>
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

Changes in v3:
- Refactored Freescale mentions to NXP, including compatible string
- Removed missed files from reorganization to base imu directory
- Removed Kconfig source command to now nonexistent directory
- Fixed devicetree binding properties definitions
- Added SPI example to devicetree documentation

Changes in v4:
- Updated interrupts property and example of devicetree binding
- Removed unnecessary header definitions and reorganized others to source files
- Changed data buffer to __be16 to properly reflect data type
- Changed included file to one more appropriate

Robert Jones (2):
  dt-bindings: iio: imu: add fxos8700 imu binding
  iio: imu: Add support for the FXOS8700 IMU

 .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  |  76 +++
 drivers/iio/imu/Kconfig                            |  27 +
 drivers/iio/imu/Makefile                           |   5 +
 drivers/iio/imu/fxos8700.h                         |  10 +
 drivers/iio/imu/fxos8700_core.c                    | 649 +++++++++++++++++++++
 drivers/iio/imu/fxos8700_i2c.c                     |  71 +++
 drivers/iio/imu/fxos8700_spi.c                     |  58 ++
 7 files changed, 896 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
 create mode 100644 drivers/iio/imu/fxos8700.h
 create mode 100644 drivers/iio/imu/fxos8700_core.c
 create mode 100644 drivers/iio/imu/fxos8700_i2c.c
 create mode 100644 drivers/iio/imu/fxos8700_spi.c

-- 
2.9.2

