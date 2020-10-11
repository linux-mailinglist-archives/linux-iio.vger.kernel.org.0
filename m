Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3357928A853
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgJKRJ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbgJKRJ6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:09:58 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F25EE20782;
        Sun, 11 Oct 2020 17:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436197;
        bh=BY/2tfpk1iWx/vrznHI9ZX3dZfa4wUd90rRNm3tHH6U=;
        h=From:To:Cc:Subject:Date:From;
        b=VNXiiaCHVmI6+rPb4HJ5jLbddTcqusS+cjoHrGTreZtWanllk4tYKWDDjadQHl7zu
         zC7scB6gV+8Q31Ve43P4RmIprjOVd8TQ4JgPJhBq4Dc/KMUd/OsWCQpdpHuieQLTfC
         S/71f8lffmj3kUzitt6uVl3NYXwBFIF75p6dU9Tg=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/29] dt-bindings:iio: Another set of yaml conversions.
Date:   Sun, 11 Oct 2020 18:07:20 +0100
Message-Id: <20201011170749.243680-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This set mostly consists of low hanging fruit along the way to converting
all the existing IIO bindings.

A few questions scattered throughout though.  Whilst my skills in these
are hopefully improving it seems there are still plenty more corner
cases that I'm not sure how to handle!  I'm sure I'll have forgotten
something that I should already know as well.

I'm expecting some of these to bounce due to changes of addresses etc.
If I can't track down up to date emails, I'll switch them maintainer
to myself on the basis I'll be reviewing any incoming changes for these
anyway.

Thanks,

Jonathan

Jonathan Cameron (29):
  dt-bindings:iio:humidity:hdc100x Drop separate doc + add to
    trivial-devices
  dt-bindings:iio:humidity:htu21 Drop separate doc + add to
    trivial-devices
  dt-bindings:iio:humidity:st,hts221 yaml conversion.
  dt-bindings:iio:humidity:dht11 yaml conversion
  dt-bindings:iio:pressure:ms5637 Drop separate doc + add to
    trivial-devices
  dt-bindings:iio:pressure:murata,zpa2326 yaml conversion
  dt-bindings:iio:pressure:meas,ms5611 yaml conversion.
  dt-bindings:iio:pressure:hoperf,hp03 yaml conversion
  dt-bindings:iio:proximity:semtech,sx9500 yaml conversion.
  dt-bindings:iio:proximity:st,vl53l0x yaml conversion
  dt-bindings:iio:proximity:ams,as3935 yaml conversion
  dt-bindings:iio:dac:ti,dac5571 yaml conversion.
  dt-bindings:iio:dac:ti,dac7311 yaml conversion
  dt-bindings:iio:dac:ti,dac7512 yaml conversion
  dt-bindings:iio:dac:ti,dac7612 yaml conversion
  dt-bindings:iio:dac:ti,dac082s085 yaml conversion
  dt-bindings:iio:dac:adi,ad7303 yaml conversion
  dt-bindings:iio:dac:maxim,ds4424 yaml conversion
  dt-bindings:iio:dac:fsl,vf610-dac yaml conversion
  dt-bindings:iio:dac:microchip,mcp4725 yaml conversion
  dt-bindings:iio:dac:maxim,max5821 yaml conversion
  dt-bindings:iio:dac:nxp,lpc1850-dac yaml conversion.
  dt-bindings:iio:dac:adi,ad5758 yaml conversion
  dt-bindings:iio:temperature:melexis,mlx90614 yaml conversion
  dt-bindings:iio:temperature:melexis,mlx90632 conversion to yaml
  dt-bindings:iio:temperature:meas,tsys01 move to trivial-devices.yaml
  dt-bindings:iio:temperature:maxim,max31856 yaml conversion.
  dt-bindings:iio:temperature:maxim_thermocouple.txt to
    maxim,max31855k.yaml
  dt-bindings:iio:temperature:ti,tmp07 yaml conversion

 .../devicetree/bindings/iio/dac/ad5758.txt    |  83 -----------
 .../devicetree/bindings/iio/dac/ad7303.txt    |  23 ----
 .../bindings/iio/dac/adi,ad5758.yaml          | 129 ++++++++++++++++++
 .../bindings/iio/dac/adi,ad7303.yaml          |  51 +++++++
 .../devicetree/bindings/iio/dac/ds4424.txt    |  20 ---
 .../bindings/iio/dac/fsl,vf610-dac.yaml       |  55 ++++++++
 .../bindings/iio/dac/lpc1850-dac.txt          |  19 ---
 .../devicetree/bindings/iio/dac/max5821.txt   |  14 --
 .../bindings/iio/dac/maxim,ds4424.yaml        |  45 ++++++
 .../bindings/iio/dac/maxim,max5821.yaml       |  44 ++++++
 .../devicetree/bindings/iio/dac/mcp4725.txt   |  35 -----
 .../bindings/iio/dac/microchip,mcp4725.yaml   |  71 ++++++++++
 .../bindings/iio/dac/nxp,lpc1850-dac.yaml     |  58 ++++++++
 .../bindings/iio/dac/ti,dac082s085.yaml       |  58 ++++++++
 .../bindings/iio/dac/ti,dac5571.txt           |  24 ----
 .../bindings/iio/dac/ti,dac5571.yaml          |  52 +++++++
 .../bindings/iio/dac/ti,dac7311.txt           |  23 ----
 .../bindings/iio/dac/ti,dac7311.yaml          |  49 +++++++
 .../bindings/iio/dac/ti,dac7512.txt           |  20 ---
 .../bindings/iio/dac/ti,dac7512.yaml          |  42 ++++++
 .../bindings/iio/dac/ti,dac7612.txt           |  28 ----
 .../bindings/iio/dac/ti,dac7612.yaml          |  53 +++++++
 .../bindings/iio/dac/ti-dac082s085.txt        |  34 -----
 .../devicetree/bindings/iio/dac/vf610-dac.txt |  20 ---
 .../bindings/iio/humidity/dht11.txt           |  14 --
 .../bindings/iio/humidity/dht11.yaml          |  41 ++++++
 .../bindings/iio/humidity/hdc100x.txt         |  17 ---
 .../bindings/iio/humidity/hts221.txt          |  30 ----
 .../bindings/iio/humidity/htu21.txt           |  13 --
 .../bindings/iio/humidity/st,hts221.yaml      |  52 +++++++
 .../bindings/iio/pressure/hoperf,hp03.yaml    |  47 +++++++
 .../devicetree/bindings/iio/pressure/hp03.txt |  17 ---
 .../bindings/iio/pressure/meas,ms5611.yaml    |  57 ++++++++
 .../bindings/iio/pressure/ms5611.txt          |  19 ---
 .../bindings/iio/pressure/ms5637.txt          |  17 ---
 .../bindings/iio/pressure/murata,zpa2326.yaml |  62 +++++++++
 .../bindings/iio/pressure/zpa2326.txt         |  29 ----
 .../bindings/iio/proximity/ams,as3935.yaml    |  71 ++++++++++
 .../bindings/iio/proximity/as3935.txt         |  34 -----
 .../iio/proximity/semtech,sx9500.yaml         |  50 +++++++
 .../bindings/iio/proximity/st,vl53l0x.yaml    |  42 ++++++
 .../bindings/iio/proximity/sx9500.txt         |  23 ----
 .../bindings/iio/proximity/vl53l0x.txt        |  18 ---
 .../bindings/iio/temperature/max31856.txt     |  24 ----
 .../iio/temperature/maxim,max31855k.yaml      |  76 +++++++++++
 .../iio/temperature/maxim,max31856.yaml       |  54 ++++++++
 .../iio/temperature/maxim_thermocouple.txt    |  24 ----
 .../iio/temperature/melexis,mlx90614.yaml     |  51 +++++++
 .../iio/temperature/melexis,mlx90632.yaml     |  55 ++++++++
 .../bindings/iio/temperature/mlx90614.txt     |  24 ----
 .../bindings/iio/temperature/mlx90632.txt     |  28 ----
 .../bindings/iio/temperature/ti,tmp007.yaml   |  57 ++++++++
 .../bindings/iio/temperature/tmp007.txt       |  33 -----
 .../bindings/iio/temperature/tsys01.txt       |  19 ---
 .../devicetree/bindings/trivial-devices.yaml  |  24 ++++
 55 files changed, 1446 insertions(+), 726 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ad7303.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad7303.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ds4424.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/fsl,vf610-dac.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/max5821.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/maxim,max5821.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/mcp4725.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/nxp,lpc1850-dac.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7311.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7512.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7512.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/vf610-dac.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/humidity/dht11.txt
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/dht11.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/humidity/hts221.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/humidity/htu21.txt
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/hoperf,hp03.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/pressure/hp03.txt
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/pressure/ms5611.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/pressure/ms5637.txt
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/murata,zpa2326.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/pressure/zpa2326.txt
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/ams,as3935.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/proximity/as3935.txt
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9500.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/proximity/sx9500.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/temperature/max31856.txt
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim,max31855k.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim,max31856.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp007.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/temperature/tmp007.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/temperature/tsys01.txt

-- 
2.28.0

