Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E13BE18D205
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 15:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgCTO4z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 10:56:55 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:51425 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCTO4z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 10:56:55 -0400
From:   Alexandru Lazar <alazar@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584716212;
        bh=sZD0qWHqFqESLhv5Lfz3UbS8xmvjsTflHa3pdsR+j74=;
        h=From:To:Cc:Subject:Date:From;
        b=ELtOtXxsWBfWi8U4ybnW8KdB/WFIQ+qrIaTzOiGI7/v9sNqCI5SHdFl4Cs2y6pF3e
         O6dTaMqigrzlc5NGLjc/JdXNo1/4TvT1AfMejK1yLTU8OjPupgAffs2+ZeuJYDuuF1
         mFccLUzKIsw/d96H9PfkrsuUU6JZVqSjaXX4FUxEeIZTBlocfXYUAGGE/E3Pv+J1As
         TyZRWD8oPAYbJDBNUGamS62oAWvGznmvABHl6qL9z40J6nJfBjMDD622Jifvbn3Q3y
         QAAESMf0Dc5uHYsWLYrnhs2PGxK1Ul4whnSW7Ius3ZnzsokDrzzHXqtPnC2Pjn1rGs
         //xrQ16qq+msw==
To:     linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, Alexandru Lazar <alazar@startmail.com>
Subject: [PATCH v4 0/2] Maxim MAX1241 driver
Date:   Fri, 20 Mar 2020 17:01:13 +0200
Message-Id: <20200320150114.9297-1-alazar@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello again,

Here's version 4 of a patch series which adds support for the Maxim
MAX1241, a 12-bit, single-channel, SPI-connected ADC.

Changelog so far:

v4:

* Dropped explicit documentation of SPI reg property
* Reordered patch series so that dt bindings come first

v3:

* Fixed silly copy-paste error in Kconfig description

v2:

* Removed useeless header includes
* Dropped needlessly verbose stuff in _read and _probe functions
* Dropped useless GPL notice
* Lowered log level of shdn pin status in probe function, now it's
  dev_dbg
* Added proper error checking for the GPIO shutdown pin
* remove now always returns zero (man, I've been wrong about this for
  *years* now...)
* Added regulator disable action, cleanup is now handled via devm
* Drop delay_usecs, use delay.value, delay.unit
* Drop config_of, of_match_ptr call
* Dropped IIO_BUFFER, IIO_TRIGGERED_BUFFER dependencies, set SPI_MASTER
  as dependency, fix indenting.
* DT binding: use correct id, add reg description (looks pretty
  standard), dropped spi-max-frequency, fixed dt_binding_check
  complaints (oops!)

Apologies for the last botched message -- my machine died at the
wrongest possible time.

All the best,
Alex

Alexandru Lazar (2):
  dt-bindings: iio: adc: Add MAX1241 device tree bindings in
    documentation
  iio: adc: Add MAX1241 driver

 .../bindings/iio/adc/maxim,max1241.yaml       |  61 ++++++
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max1241.c                     | 206 ++++++++++++++++++
 4 files changed, 278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
 create mode 100644 drivers/iio/adc/max1241.c

-- 
2.25.2

