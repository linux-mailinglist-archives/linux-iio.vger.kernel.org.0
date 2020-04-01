Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E49E19B5E2
	for <lists+linux-iio@lfdr.de>; Wed,  1 Apr 2020 20:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgDASqs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Apr 2020 14:46:48 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:60637 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgDASqs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 14:46:48 -0400
From:   Alexandru Lazar <alazar@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1585766806;
        bh=rPZJR8e0aV7M0z3Rj/djkP3V9lgsL9xCnjkBzqTFBgM=;
        h=From:To:Cc:Subject:Date:From;
        b=ru489shfFLZ74qgFeKk226mO31rKwurEiuqlrFJ2SETaNIRW/PCJBbcRCpY6AqL/u
         +DSvQmS8gaKAnEio01hMAajVQ/Z2HstN+3ZFwNx5TV2BBTmubFqBibW+9+A8Ss3wb3
         w5GvIYCJ1sesDdNnKLeyGN0ai6c886T4PTJrL8ylmbX9eFkV2bbKMo9ZG/2YS4Ty0J
         fkxkf2KIzim/PriZN992OZ7+sMrohQC7Y5muaxLDIauR/g7QsGwG9vQmNBi0npvBqx
         14QWN1WhVYnj2cxK5NJfaZZA3pE8WOWckycHjIDL5jYbNUmGFGKBwW3kMAcD8k+udj
         RyQegqmwNE35Q==
To:     linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, Alexandru Lazar <alazar@startmail.com>
Subject: [PATCH v6 0/2] Maxim MAX1241 driver
Date:   Wed,  1 Apr 2020 21:51:36 +0300
Message-Id: <20200401185138.10673-1-alazar@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi everyone,

Here's version 6 of a patch series which adds support for the Maxim
MAX1241, a 12-bit, single-channel, SPI-connected ADC.

Changelog so far:

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

