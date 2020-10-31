Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DBB2A19C0
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgJaSv2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaSv1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:27 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65F4B20702;
        Sat, 31 Oct 2020 18:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170287;
        bh=v4LQef1anaehQ63thBz2NllduzyrobtHJoYQb+0Bsak=;
        h=From:To:Cc:Subject:Date:From;
        b=XUSevLWkKUSxMYNxIwPe/yz8X6n4cTa5PMJI1zs3ZsoTASzOHrECM+n3WDxOShmZ7
         NCYA6RuCRMmoCM8l2P1j0VxB9VuU+jzC9U9tpZm5EvRJ4ssLZLTpU0ULTT9GVKeiSl
         yLyN84w9REts8350wOpo+AQUrH3+7VHzkZNxUbxk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/46] dt-bindings:iio: yet more txt to yam conversions
Date:   Sat, 31 Oct 2020 18:48:08 +0000
Message-Id: <20201031184854.745828-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This set is basically all the stuff bindings where I couldn't come up
with a unifying theme to split them out into smaller more palatble sets.

So there is all sorts in here :)  Enjoy.

There are a few more binding files left after these are done.
* io-channel-mux:  Needs conversion of the mux subsystem bindings
* xilinx-xadc: I think Lars is working on this one already.
* lis302: This one got moved to IIO directory, but reflects a bunch of stuff
  that would not have made it into an IIO binding.  The driver is still in
  misc and in theory has been replaced by the st-sensors driver.
  Need to think what to do about this one.
* mount-matrix.txt:  The binding part is under review for inclusion in
  dt-schema rather than kernel tree, but this document has a wealth of
  information we don't want hidden away there.  As such I'm probably
  going to convert it to general kernel documentation.

Final patch in here drops the generic temperatures sensor binding.
Whilst I'm keen on that we only currently have one user.  So I'd
rather we had a second before we went to the effort of defining a
proper yaml binding for that.

Jonathan Cameron (46):
  dt-bindings:iio:resolver:adi,ad2s90: Conversion of binding to yaml.
  dt-bindings:iio:potentiometer:adi,ad5272 yaml conversion
  dt-bindings:iio:potentiometer:microchip,mcp4131 txt to yaml conversion
  dt-bindings:iio:potentiometer:microchip,mcp41010 txt to yaml
    conversion
  dt-bindings:iio:impedance-analyzer:adi,ad5933 yaml conversion.
  dt-bindings:iio:samsung,sensorhub-rinato: yaml conversion
  dt-bindings:iio:health:ti,afe4403: txt to yaml binding
  dt-bindings:iio:health:ti,afe4404: txt to yaml conversion
  dt-bindings:iio:health:maxim,max30100: txt to yaml conversion
  dt-bindings:iio:health:maxim,max30102: txt to yaml conversion
  dt-bindings:iio:imu:adi,adis16480: txt to yaml conversion
  dt-bindings:iio:imu:st,lsm6dsx: txt to yaml conversion
  dt-bindings:iio:light:avago,apds9300: txt to yaml conversion.
  dt-bindings:iio:light:avago,apds9960: txt to yaml conversion
  dt-bindings:iio:light:capella,cm36651: txt to yaml conversion.
  dt-bindings:iio:light:sharp,gp2ap020a00f: txt to yaml conversion.
  dt-bindings:iio:light:maxim,max44009: txt to yaml conversion.
  dt-bindings:iio:light:ti,opt3001: txt to yaml conversion
  dt-bindings:iio:light:upisemi,us51882: txt to yaml conversion.
  dt-bindings:iio:light:st,uvis25: txt to yaml conversion for this UV
    sensor
  dt-bindings:iio:light:vishay,vcnl4035: txt to yaml conversion
  dt-bindings:iio:light:st,vl6180: txt to yaml format conversion.
  dt-bindings:iio:magnetometer:fsl,mag3110: txt to yaml conversion
  dt-bindings:iio:magnetometer:asahi-kasei,ak8974: txt to yaml format
    conversion
  dt-bindings:iio:magnetometer:bosch,bmc150_magn: txt to yaml
    conversion.
  dt-bindings:iio:magnetometer:honeywell,hmc5843: txt to yaml format
    conversion
  dt-bindings:iio:magnetometer:pni,rm3100: txt to yaml conversion.
  dt-bindings:iio:adc:atmel,sama5d2-adc: txt to yaml conversion
  dt-bindings:iio:adc:atmel,sama9260-adc: conversion to yaml from
    at91_adc.txt
  dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to yaml conversion.
  dt-bindings:iio:adc:x-powers,axp209-adc: txt to yaml conversion
  dt-bindings:iio:adc:brcm,iproc-static-adc: txt to yaml conversion
  dt-bindings:iio:adc:mediatek,mt2701-auxadc: rename and yaml
    conversion.
  dt-bindings:iio:adc:ti,palmas-gpadc: txt to yaml format conversion.
  dt-bindings:iio:adc:qcom,pm8018-adc: yaml conversion and rename.
  dt-bindings:iio:adc:qcom,spmi-iadc: txt to yaml format conversion.
  dt-binding:iio:adc:ti,ads124s08: txt to yaml format conversion.
  dt-bindings:iio:dac:ad5592r: txt to yaml format conversion.
  dt-bindings:iio:dac:ad5755: txt to yaml format conversion.
  dt-bindings:iio:accel:bosch,bma180: txt to yaml format conversion.
  dt-bindings:iio:accel:kionix,kxcjk1013: txt to yaml format conversion.
  dt-bindings:iio:accel:fsl,mma8452: txt to yaml conversion.
  dt-bindings:iio:gyro:bosch,bmg180: txt to yaml format conversion.
  dt-bindings:iio:st,st-sensors: txt to yaml conversion.
  dt-bindings:iio:frequency:adi,adf4350: txt to yaml format conversion.
  dt-bindings:iio:temperature: Drop generic binding file.

 .../devicetree/bindings/iio/accel/bma180.txt  |  35 ---
 .../bindings/iio/accel/bosch,bma180.yaml      |  62 ++++++
 .../bindings/iio/accel/fsl,mma8452.yaml       |  62 ++++++
 .../bindings/iio/accel/kionix,kxcjk1013.txt   |  24 ---
 .../bindings/iio/accel/kionix,kxcjk1013.yaml  |  46 ++++
 .../devicetree/bindings/iio/accel/mma8452.txt |  35 ---
 .../bindings/iio/adc/at91-sama5d2_adc.txt     |  50 -----
 .../devicetree/bindings/iio/adc/at91_adc.txt  |  83 --------
 .../bindings/iio/adc/atmel,sama5d2-adc.yaml   | 104 +++++++++
 .../bindings/iio/adc/atmel,sama9260-adc.yaml  | 178 ++++++++++++++++
 .../bindings/iio/adc/axp20x_adc.txt           |  48 -----
 .../iio/adc/brcm,iproc-static-adc.txt         |  40 ----
 .../iio/adc/brcm,iproc-static-adc.yaml        |  70 ++++++
 .../iio/adc/mediatek,mt2701-auxadc.yaml       |  77 +++++++
 .../bindings/iio/adc/mt6577_auxadc.txt        |  34 ---
 .../bindings/iio/adc/palmas-gpadc.txt         |  48 -----
 .../bindings/iio/adc/qcom,pm8018-adc.yaml     | 166 +++++++++++++++
 .../bindings/iio/adc/qcom,pm8xxx-xoadc.txt    | 157 --------------
 .../bindings/iio/adc/qcom,spmi-iadc.txt       |  46 ----
 .../bindings/iio/adc/qcom,spmi-iadc.yaml      |  62 ++++++
 .../bindings/iio/adc/renesas,gyroadc.txt      |  98 ---------
 .../iio/adc/renesas,rcar-gyroadc.yaml         | 141 ++++++++++++
 .../bindings/iio/adc/ti,ads124s08.yaml        |  52 +++++
 .../bindings/iio/adc/ti,palmas-gpadc.yaml     |  87 ++++++++
 .../bindings/iio/adc/ti-ads124s08.txt         |  25 ---
 .../bindings/iio/adc/x-powers,axp209-adc.yaml |  67 ++++++
 .../devicetree/bindings/iio/dac/ad5592r.txt   | 155 --------------
 .../devicetree/bindings/iio/dac/ad5755.txt    | 124 -----------
 .../bindings/iio/dac/adi,ad5592r.yaml         | 201 ++++++++++++++++++
 .../bindings/iio/dac/adi,ad5755.yaml          | 178 ++++++++++++++++
 .../bindings/iio/frequency/adf4350.txt        |  86 --------
 .../bindings/iio/frequency/adi,adf4350.yaml   | 190 +++++++++++++++++
 .../bindings/iio/gyroscope/bmg160.txt         |  20 --
 .../bindings/iio/gyroscope/bosch,bmg160.yaml  |  46 ++++
 .../bindings/iio/health/afe4403.txt           |  33 ---
 .../bindings/iio/health/afe4404.txt           |  29 ---
 .../bindings/iio/health/max30100.txt          |  28 ---
 .../bindings/iio/health/max30102.txt          |  33 ---
 .../bindings/iio/health/maxim,max30100.yaml   |  52 +++++
 .../bindings/iio/health/maxim,max30102.yaml   |  75 +++++++
 .../bindings/iio/health/ti,afe4403.yaml       |  54 +++++
 .../bindings/iio/health/ti,afe4404.yaml       |  51 +++++
 .../iio/impedance-analyzer/ad5933.txt         |  26 ---
 .../iio/impedance-analyzer/adi,ad5933.yaml    |  59 +++++
 .../bindings/iio/imu/adi,adis16480.txt        |  86 --------
 .../bindings/iio/imu/adi,adis16480.yaml       | 130 +++++++++++
 .../bindings/iio/imu/st,lsm6dsx.yaml          |  86 ++++++++
 .../bindings/iio/imu/st_lsm6dsx.txt           |  49 -----
 .../bindings/iio/light/apds9300.txt           |  21 --
 .../bindings/iio/light/apds9960.txt           |  21 --
 .../bindings/iio/light/avago,apds9300.yaml    |  44 ++++
 .../bindings/iio/light/avago,apds9960.yaml    |  44 ++++
 .../bindings/iio/light/capella,cm36651.yaml   |  48 +++++
 .../devicetree/bindings/iio/light/cm36651.txt |  26 ---
 .../bindings/iio/light/gp2ap020a00f.txt       |  21 --
 .../bindings/iio/light/max44009.txt           |  24 ---
 .../bindings/iio/light/maxim,max44009.yaml    |  45 ++++
 .../devicetree/bindings/iio/light/opt3001.txt |  25 ---
 .../iio/light/sharp,gp2ap020a00f.yaml         |  49 +++++
 .../bindings/iio/light/st,uvis25.yaml         |  42 ++++
 .../bindings/iio/light/st,vl6180.yaml         |  45 ++++
 .../bindings/iio/light/ti,opt3001.yaml        |  47 ++++
 .../bindings/iio/light/upisemi,us5182.yaml    |  75 +++++++
 .../devicetree/bindings/iio/light/us5182d.txt |  45 ----
 .../devicetree/bindings/iio/light/uvis25.txt  |  22 --
 .../bindings/iio/light/vcnl4035.txt           |  18 --
 .../bindings/iio/light/vishay,vcnl4035.yaml   |  45 ++++
 .../devicetree/bindings/iio/light/vl6180.txt  |  15 --
 .../bindings/iio/magnetometer/ak8974.txt      |  31 ---
 .../iio/magnetometer/asahi-kasei,ak8974.yaml  |  57 +++++
 .../bindings/iio/magnetometer/bmc150_magn.txt |  25 ---
 .../iio/magnetometer/bosch,bmc150_magn.yaml   |  55 +++++
 .../iio/magnetometer/fsl,mag3110.yaml         |  48 +++++
 .../bindings/iio/magnetometer/hmc5843.txt     |  21 --
 .../iio/magnetometer/honeywell,hmc5843.yaml   |  43 ++++
 .../bindings/iio/magnetometer/mag3110.txt     |  27 ---
 .../bindings/iio/magnetometer/pni,rm3100.txt  |  20 --
 .../bindings/iio/magnetometer/pni,rm3100.yaml |  42 ++++
 .../bindings/iio/potentiometer/ad5272.txt     |  27 ---
 .../iio/potentiometer/adi,ad5272.yaml         |  50 +++++
 .../bindings/iio/potentiometer/mcp41010.txt   |  28 ---
 .../bindings/iio/potentiometer/mcp4131.txt    |  84 --------
 .../iio/potentiometer/microchip,mcp41010.yaml |  48 +++++
 .../iio/potentiometer/microchip,mcp4131.yaml  | 102 +++++++++
 .../bindings/iio/resolver/ad2s90.txt          |  31 ---
 .../bindings/iio/resolver/adi,ad2s90.yaml     |  60 ++++++
 .../iio/samsung,sensorhub-rinato.yaml         |  72 +++++++
 .../devicetree/bindings/iio/sensorhub.txt     |  24 ---
 .../bindings/iio/st,st-sensors.yaml           | 123 +++++++++++
 .../devicetree/bindings/iio/st-sensors.txt    |  82 -------
 .../iio/temperature/temperature-bindings.txt  |   7 -
 91 files changed, 3480 insertions(+), 2037 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/bma180.txt
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/mma8452.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/at91_adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ad5592r.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ad5755.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5592r.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/frequency/adf4350.txt
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/health/afe4403.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/health/afe4404.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/health/max30100.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/health/max30102.txt
 create mode 100644 Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
 create mode 100644 Documentation/devicetree/bindings/iio/impedance-analyzer/adi,ad5933.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/light/apds9300.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/light/apds9960.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/capella,cm36651.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/cm36651.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/light/max44009.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/maxim,max44009.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/opt3001.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/st,uvis25.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/st,vl6180.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/us5182d.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/light/uvis25.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,vcnl4035.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/vl6180.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8974.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/fsl,mag3110.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/hmc5843.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/honeywell,hmc5843.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/mag3110.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mcp4131.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp41010.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/adi,ad2s90.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/samsung,sensorhub-rinato.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/sensorhub.txt
 create mode 100644 Documentation/devicetree/bindings/iio/st,st-sensors.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/st-sensors.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt

-- 
2.28.0

