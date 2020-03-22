Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0059018E941
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 14:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgCVN6G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 09:58:06 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:46330 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgCVN6G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 09:58:06 -0400
From:   Alexandru Lazar <alazar@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584885484;
        bh=lXnTtC4eUU6M3jrOm/vCYMsZljQfVh1oMFlBSrISk2s=;
        h=From:To:Cc:Subject:Date:From;
        b=AQnUG9x/x8PeJQZxiLMsu1bHMdeJqZgcHJgaKRbMI2D39SuvVzs4VTI5LyeCiarVn
         JYQqGzrTwTzPmsDS5OFGg/tskBDSKlqKr1x7gaZsvaQhlg2kdQYsrBYdoMXXPBGjsS
         /896fZhQsSXYG+g/209fQ6/QBvwmMmhmbxHpoKYljas6IGswfwovjsAcJeuE/MO8d8
         WS0YoHW+adVhO0b9ib32k8W4d0cCe8vCo9KD6u7lrmuLEfHbjzItdE5g9HBwSbmoLb
         4RRiK+opMOZyizyv+zuTeMrx2yJKCKxJdoc2j96ycarsMJDyhptD5h5l1k4cLHEZ8Y
         JbtejBap0ErAQ==
To:     linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, Alexandru Lazar <alazar@startmail.com>
Subject: [PATCH v5 0/2] Maxim MAX1241 driver
Date:   Sun, 22 Mar 2020 16:02:35 +0200
Message-Id: <20200322140237.211347-1-alazar@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello again,

Here's version 5 of a patch series which adds support for the Maxim
MAX1241, a 12-bit, single-channel, SPI-connected ADC.

Changelog so far:

v5:

* Add vdd supply binding
* Reorder include headers -- one of them had escaped the long mechanized
  hand of the Alphabetron
* Drop scan_index and scan_type from channel spec, as the driver
  doesn't support buffered modes
* Drop a useless initialization of a local variable in probe function
* Revise dt-bindings patch subject line, revise maintainer and
  copyright to match the Signed-off: string, drop reference to driver
  from bindings description
* Various readability/cosmetic fixes

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

Thanks,
Alex

Alexandru Lazar (2):
  dt-bindings: iio: adc: Add MAX1241 bindings
  iio: adc: Add MAX1241 driver

 .../bindings/iio/adc/maxim,max1241.yaml       |  65 ++++++
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max1241.c                     | 213 ++++++++++++++++++
 4 files changed, 289 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
 create mode 100644 drivers/iio/adc/max1241.c

-- 
2.25.2

