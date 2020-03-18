Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177F818A3B7
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 21:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCRUYU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 16:24:20 -0400
Received: from mx-out1.startmail.com ([145.131.90.139]:49950 "EHLO
        mx-out1.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgCRUYU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 16:24:20 -0400
From:   Alexandru Lazar <alazar@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584563058;
        bh=DB8Fegu6aEazpNnlT5A39iML9I2jB3qFIVx3pz80S9w=;
        h=From:To:Cc:Subject:Date:From;
        b=t6lUth6uFItkJ+Dg2CQ5Vn/SfMgM+SkElxo0E4leKdyr7UF8rR8jNvFVX14GPr0Oy
         +9WhMv/L1DZfnxS7CPWE4J5hgV5TuVMr+9asKVSb96vxzcn1prRjdpP/T8Q6D0hiHB
         ZCCdCskcgp1CKBU085TcIL1ZhGCp2x0xJ5uLDQb3KSTZo6fSVXzSz9vRfx4/Khg8t/
         QX0TT5+u9bTGQpVwHN1iQy3TJ4j/AeIB14TrUUKnOz2e+c58cYnE6Ev4sGrs7LAVSD
         3XWZI/ATPbWrHNouNxM6KNwaqQHVrFOLH4i9mYXTeENDQUXB6hD0DuthPYOtcygdCY
         PRKsr+feOYSUw==
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        Alexandru Lazar <alazar@startmail.com>
Subject: [PATCH 0/2] Maxim MAX1241 driver, v2
Date:   Wed, 18 Mar 2020 22:28:35 +0200
Message-Id: <20200318202837.512428-1-alazar@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello again,

Here's version 2 of a patch series which adds support for the Maxim
MAX1241, a 12-bit, single-channel, SPI-connected ADC. The previous
version is here:

https://lore.kernel.org/linux-iio/20200317201710.23180-1-alazar@startmail.com/

I've integrated pretty much all of the suggestions I got here, and fixed
the issues that you all pointed out (thanks again! Did I say thanks
lately? Thanks!!!). A short list of the changes is at the end of this
message. checkpatch.pl is happy, it just warns me about the MAINTAINERS
file, where I don't think an entry is necessary. dt_bindings_check is
happy, too.

The only suggestion that I haven't incorporated is adding max1240 to the
list of compatible devices. I've thought about it, but there are
timing-related differences between the two devices, so simply validating
what my machine sends wouldn't be definitive. I think it would be
disingenious to claim compatibility under these circumstances. I do plan
to get a 1240 asap, anyway, and with any luck my patch would just update
the compat string.

Now, here's what I changed:

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

Thanks!

Alex

Alexandru Lazar (2):
  iio: adc: Add MAX1241 driver
  dt-bindings: iio: adc: Add MAX1241 device tree bindings in
    documentation

 .../bindings/iio/adc/maxim,max1241.yaml       |  62 ++++++
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max1241.c                     | 206 ++++++++++++++++++
 4 files changed, 279 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
 create mode 100644 drivers/iio/adc/max1241.c

-- 
2.25.1

