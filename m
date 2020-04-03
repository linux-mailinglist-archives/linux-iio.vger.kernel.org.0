Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFE319D65B
	for <lists+linux-iio@lfdr.de>; Fri,  3 Apr 2020 14:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390906AbgDCMId (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Apr 2020 08:08:33 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:35382 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390880AbgDCMId (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Apr 2020 08:08:33 -0400
From:   Alexandru Lazar <alazar@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1585915711;
        bh=t/fgwWX/kZaoC8BflqR7ErfjHLaLXo/S7BKJpqK5/i0=;
        h=From:To:Cc:Subject:Date:From;
        b=rMMWUyr/DOByYNsrkvB+c1vcyFkKkX17QMBJyRmpZGAlxmdGHEVfugWczTMGtCNP8
         jakSGU8BongwpBbZnQAwVfnh4774zqfdRiGJgW2WSZNQFImmb3V6SWErguYB97Bcx4
         JE0zxdDIKam4PfNbDrFvQAZuvrHa5FZGa5U71YLa3h1lWM8TqY2zJfaEYTJTwok7A8
         rDPvYIWBALVS4VTawGdHVdYJPuHcXIANAaNHbKf/ADc7b5bknA4U2Rfabyd5XsYHaJ
         B5fgb1sEpyqJ3UQURs4aZGv5MjDg3RUZGoFgeYkOONMNpJxNXmZjMbDCJy2XK2G2iu
         ji0Q7R6dyn8Qw==
To:     linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, Alexandru Lazar <alazar@startmail.com>
Subject: [PATCH v7 0/2] Maxim MAX1241 driver
Date:   Fri,  3 Apr 2020 15:13:21 +0300
Message-Id: <20200403121323.1742-1-alazar@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi everyone,

Here's version 7 of a patch series which adds support for the Maxim
MAX1241, a 12-bit, single-channel, SPI-connected ADC.

Changelog so far:

v7:

* Add datasheet tag to commit message

v6:

* Add separate cleanup actions for vdd and vref regulators respectively
* Change shdn pin name to shutdown. shdn is what the datasheet calls it
  but "shutdown" seems to be semi-standard, at least in the bindings
  (Rob orriginally suggested that I change the name in the docs. Figured
  it made zero sense to have it bear another name in the code)
* Dropped maxItems property in vref binding, made binding dual-licensed
* Changed name of spi node in binding example 

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

Alexandru Lazar (2):
  dt-bindings: iio: adc: Add MAX1241 bindings
  iio: adc: Add MAX1241 driver

 .../bindings/iio/adc/maxim,max1241.yaml       |  64 +++++
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max1241.c                     | 227 ++++++++++++++++++
 4 files changed, 302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
 create mode 100644 drivers/iio/adc/max1241.c

-- 
2.20.1

