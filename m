Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDEA22787
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 19:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfESRMW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 13:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbfESRMW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 May 2019 13:12:22 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB2092146F;
        Sun, 19 May 2019 08:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558256225;
        bh=AQzZb6C+4ijUYU+KvWh8dd5ifZRMV7kDAkqopeI99S0=;
        h=Date:From:To:Subject:From;
        b=BZQURYDzb8b4M/2XX1tvhMDGV2f42mwZDx3MAjWd5qoHaBsoaYG7xPgyul/CIijgs
         1waH7wE5Fp+Nl/k9Kcq5P9SQBU46fablHthuL26ACKiPfN2rTQkZuSpO1HxlzuRepi
         cGCdT1O5LUqmgcgxitUEbMDZ7Pikvv71Rnij1BO8=
Date:   Sun, 19 May 2019 09:57:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of new device support, features and cleanups for
 IIO in the 5.3 cycle.
Message-ID: <20190519095700.5ffbb7b4@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 575d927c426b83f5f8d5809f46de177cceffe40c:

  LS1021A: dtsi: add ftm quad decoder entries (2019-04-25 21:33:42 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-=
5.3a

for you to fetch changes up to 6d97024dce236619b0bb85bdb5028019ed7fda56:

  iio: adc: mediatek: mt6577-auxadc, add mt6765 support (2019-05-19 09:18:3=
0 +0100)

----------------------------------------------------------------
First set of new device support, features and cleanups for IIO in the 5.3 c=
ycle

New device support
* mt6577
  - add supprot for the mt6765 which requires a few minor additional
    new features in the driver.

Yaml binding conversions
* adxl345
* isl29018
* tsl2583
* tsl2772

Minor features and improvements
* ad5758
  - declare an of_device_id table rather than just relying on the spi
    fallback which doesn't use the manufacturer id.
  - drop a set but not used variable left from previous refactor.
* ad7816
  - Add a bit more description to kconfig text.
* ad9523
  - change calculation order to improve frequency accuracy.
* adxl372
  - declare an of_device_id table
* adt7316
  - white space.
* at91_adc
  - Use dev_get_drvdata directly rather than boucing to the platform device
    and back again.
* cros_ec
  - add an id sysfs entry to bring in line with the other implementations.
* ds5522
  - drop a check on the of_node existing as we don't actually use it for
    anything.
* kxsd9
  - declare an of_device_id table.
* maxim_thermocouple
  - declare an of_device_id table.
* mt6577
  - add dt binding entry for mt8183 which is also supported.
* rcar-gyroadc
  - tidy up unnecessary error messages.
* stm32-dfsdm
  - improved error handling.
* stmpe-adc
  - drop an unnecessary variable assignment.
  - add an of_device_id table.
  - reinit completion on begin converstion to avoid a path in which
    previous round had been interrupted, also switch to non interruptible
    wait to avoid an issue with a user program using -pg
  - simplify interrupt handling by just having them always enabled.
  - reset all interrupts on startup and in the timeout handler to
    avoid getting stuck.
* sun4i-gpadc
  - SPDX

----------------------------------------------------------------
Alexandru Ardelean (1):
      dt-bindings: iio: accel: adxl345: switch to YAML bindings

Brian Masney (3):
      dt-bindings: iio: tsl2583: convert bindings to YAML format
      dt-bindings: iio: tsl2772: convert bindings to YAML format
      dt-bindings: iio: isl29018: convert bindings to YAML format

Chun-Hung Wu (2):
      dt-bindings: iio: adc: mediatek: Add document for mt6765
      iio: adc: mediatek: mt6577-auxadc, add mt6765 support

Daniel Gomez (4):
      iio: temperature: maxim_thermocouple: declare missing of table
      iio: accel: kxsd9: declare missing of table
      iio: adxl372: declare missing of table
      iio: dac: ad5758: declare missing of table

Fabien Dessenne (2):
      iio: adc: stm32-dfsdm: manage the get_irq error case
      iio: adc: stm32-dfsdm: missing error case during probe

Geert Uytterhoeven (1):
      iio: adc: rcar-gyroadc: Remove devm_iio_device_alloc() error printing

Gwendal Grignou (1):
      iio: cros_ec: add 'id' sysfs entry

Jo=C3=A3o Seckler (1):
      staging: iio: adt7316: match parenthesis alignment

Kefeng Wang (1):
      iio: adc: at91: Use dev_get_drvdata()

Lars-Peter Clausen (1):
      iio: ad9523-1: Improve reported VCO frequency accuracy

Philippe Schenker (6):
      iio: stmpe-adc: Remove unnecessary assignment
      iio: stmpe-adc: Add compatible name
      iio: stmpe-adc: Reinit completion struct on begin conversion
      iio: stmpe-adc: Enable all stmpe-adc interrupts just once
      iio: stmpe-adc: Use wait_for_completion_timeout
      iio: stmpe-adc: Reset possible interrupts

Ruslan Babayev (1):
      iio: dac: ds4422/ds4424 drop of_node check

Vatsala Narang (1):
      staging: iio: adc: Add paragraph to describe Kconfig symbol

Yangtao Li (1):
      iio: adc: sun4i-gpadc-iio convert to SPDX license tags

YueHaibing (1):
      iio: dac: ad5758: remove set but not used variable 'dc_dc_mode'

Zhiyong Tao (1):
      dt-bindings: adc: mt8183: add binding document

 Documentation/ABI/testing/sysfs-bus-iio-cros-ec    | 10 +--
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml | 72 +++++++++++++++++++
 .../devicetree/bindings/iio/accel/adxl345.txt      | 39 ----------
 .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |  2 +
 .../devicetree/bindings/iio/light/isl29018.txt     | 27 -------
 .../devicetree/bindings/iio/light/isl29018.yaml    | 56 +++++++++++++++
 .../devicetree/bindings/iio/light/tsl2583.txt      | 25 -------
 .../devicetree/bindings/iio/light/tsl2583.yaml     | 46 ++++++++++++
 .../devicetree/bindings/iio/light/tsl2772.txt      | 42 -----------
 .../devicetree/bindings/iio/light/tsl2772.yaml     | 83 ++++++++++++++++++=
++++
 MAINTAINERS                                        |  1 +
 drivers/iio/accel/adxl372_spi.c                    |  9 +++
 drivers/iio/accel/kxsd9-spi.c                      |  9 +++
 drivers/iio/adc/at91-sama5d2_adc.c                 | 12 ++--
 drivers/iio/adc/at91_adc.c                         |  4 +-
 drivers/iio/adc/mt6577_auxadc.c                    | 54 ++++++++++----
 drivers/iio/adc/rcar-gyroadc.c                     |  4 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |  6 ++
 drivers/iio/adc/stm32-dfsdm-core.c                 |  8 ++-
 drivers/iio/adc/stmpe-adc.c                        | 40 ++++++-----
 drivers/iio/adc/sun4i-gpadc-iio.c                  |  5 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 14 ++++
 drivers/iio/dac/ad5758.c                           | 18 +++--
 drivers/iio/dac/ds4424.c                           |  6 --
 drivers/iio/frequency/ad9523.c                     |  8 ++-
 drivers/iio/temperature/maxim_thermocouple.c       | 10 +++
 drivers/staging/iio/adc/Kconfig                    |  3 +
 drivers/staging/iio/addac/adt7316.c                |  2 +-
 28 files changed, 411 insertions(+), 204 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl345=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/adxl345.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/light/isl29018.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/isl29018.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2583.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2583.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.yaml
