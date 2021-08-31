Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A7D3FC3FF
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 10:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbhHaHzz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 03:55:55 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:46016 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240042AbhHaHzx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 03:55:53 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Aug 2021 03:55:52 EDT
Received: from ert768.prtnl (ert768.prtnl [192.168.224.11])
        by sparta.prtnl (Postfix) with ESMTP id B6CD644A024D;
        Tue, 31 Aug 2021 09:49:47 +0200 (CEST)
From:   Roan van Dijk <roan@protonic.nl>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>,
        Roan van Dijk <roan@protonic.nl>
Subject: [PATCH 0/3] iio: chemical: Add support for Sensirion SCD4x CO2 sensor 
Date:   Tue, 31 Aug 2021 09:48:25 +0200
Message-Id: <20210831074832.16310-1-roan@protonic.nl>
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

Roan van Dijk (3):
  dt-bindings: iio: chemical: sensirion,scd4x: Add yaml description
  MAINTAINERS: Add myself as maintainer of the scd4x driver
  drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor

 .../iio/chemical/sensirion,scd4x.yaml         |  45 ++
 MAINTAINERS                                   |   6 +
 drivers/iio/chemical/Kconfig                  |  13 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/scd4x.c                  | 707 ++++++++++++++++++
 5 files changed, 772 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
 create mode 100644 drivers/iio/chemical/scd4x.c

-- 
2.30.2

