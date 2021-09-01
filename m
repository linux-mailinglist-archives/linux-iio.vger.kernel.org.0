Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865F73FD854
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 13:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbhIALDw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 07:03:52 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:60456 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbhIALDv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 07:03:51 -0400
Received: from ert768.prtnl (ert768.prtnl [192.168.224.11])
        by sparta.prtnl (Postfix) with ESMTP id A0FEA44A024D;
        Wed,  1 Sep 2021 13:02:52 +0200 (CEST)
From:   Roan van Dijk <roan@protonic.nl>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>,
        Roan van Dijk <roan@protonic.nl>
Subject: [PATCH v1 0/3] iio: chemical: Add support for Sensirion SCD4x CO2 sensor
Date:   Wed,  1 Sep 2021 12:59:08 +0200
Message-Id: <20210901105911.178646-1-roan@protonic.nl>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds support for the Sensirion SCD4x sensor.

The driver supports continuous reads of temperature, relative humdity and CO2
concentration. There is an interval of 5 seconds between readings. During
this interval the drivers checks if the sensor has new data available.

The driver is based on the scd30 driver. However, The scd4x has become too
different to just expand the scd30 driver. I made a new driver instead of
expanding the scd30 driver. I hope I made the right choice by doing so?

Changes since v1:
dt-bindings:
  - Separated compatible string for each sensor type
scd4x.c:
  - Changed probe, resume and suspend functions to static
  - Added SIMPLE_DEV_PM_OPS function call for power management
    operations.

Roan van Dijk (3):
  dt-bindings: iio: chemical: sensirion,scd4x: Add yaml description
  MAINTAINERS: Add myself as maintainer of the scd4x driver
  drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor

 .../iio/chemical/sensirion,scd4x.yaml         |  46 ++
 MAINTAINERS                                   |   6 +
 drivers/iio/chemical/Kconfig                  |  13 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/scd4x.c                  | 708 ++++++++++++++++++
 5 files changed, 774 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
 create mode 100644 drivers/iio/chemical/scd4x.c

-- 
2.30.2

