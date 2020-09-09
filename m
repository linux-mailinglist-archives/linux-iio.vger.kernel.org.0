Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A94263557
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgIISCq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 14:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730077AbgIISCT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 14:02:19 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE10921D7E;
        Wed,  9 Sep 2020 18:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599674538;
        bh=x+AENQgE5sQw7JrK4Mcwc/c8kJjrYCcm4fU+wOE0Nzc=;
        h=From:To:Cc:Subject:Date:From;
        b=FB56DlaVIRvKuguvpCUrY8Mea7qm0HLMDbAB6EN29Rf2QVawvL2t2n4NqHuOjbrYS
         kOWG4zF8FfPjiRlIIWf79HtEyIVbKavSdNhZcFMv6pftMrq5nGb5T27mDqu8bum0b9
         cln1/92rOfuL73jYC4hSh5lRN2Giad4LgrH04ZnQ=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 00/20]  dt-bindings:iio:adc: Another set of yaml conversions.
Date:   Wed,  9 Sep 2020 18:59:26 +0100
Message-Id: <20200909175946.395313-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Changes since V1:
- Fixed wrong file naming in the marvell,berlin2-adc header caught
  by Rob's scripts.
- Rolled in Martin's patch for amlogic,meson-saradc
- Changed maitainer for adi,ad7768-1 given Stefan's email address
  is bouncing.  I went with Michael Hennerich as the ADI catch all
  MAINTAINERS entry means this is his problem anyway.
- Fixed some white space issues and typos (yup I didn't run checkpatch
  on v1 :(
- Add tags where given

It is somewhat easier to do these all at once as then the yaml syntax
knowledge builds up and Rob once said he preferred to review them
in groups. Hence here are 20 binding conversions to enjoy.

There are 2 other bindings currently awaiting v2 review and it may
take a while to convert over the remaining IIO ADC ones as they
are mostly the complex cases. There are also quite a few drivers
that have undocumented bindings. I plan to do a sweep for those once
yaml conversions are finished.

For maintainers, I've mostly gone with the original author of the
txt file. If anyone wants to claim responsibility for any or
reject it then that is great.  I'll act as backup maintainer
for all of these by default anyway.

There are a few places I think we could look to tighten the binding
definitions if we wish. Hopefully this will be a good layer to build on.

Thanks,

Jonathan

Jonathan Cameron (20):
  dt-bindings:iio:adc:fsl,vf610-adc conversion to yaml.
  dt-bindings:iio:adc:ti,twl4030-madc yaml conversion
  dt-bindings:iio:adc:st,stmpe-adc yaml conversion
  dt-bindings:iio:adc: aspeed,ast2400 yaml conversion
  dt-bindings:iio:adc:marvell,berlin2-adc yaml conversion
  dt-bindings:iio:adc:sprd,sc2720-adc yaml conversion.
  dt-bindings:iio:adc:nuvoton,nau7802 yaml conversion
  dt-bindings:iio:adc:nuvoton,npcm750-adc yaml conversion
  dt-bindings:iio:adc:nxp,lpc1850-adc yaml conversion
  dt-bindings:iio:adc:lpc3220-adc yaml conversion
  dt-bindings:iio:adc:motorola,cpcap-adc yaml conversion
  dt-bindings:iio:adc:dlg,da9150-gpadc yaml conversion
  dt-bindings:iio:adc:cosmic,10001-adc yaml conversion
  dt-bindings:iio:adc:adi,ad7949 yaml conversion
  dt-bindings:iio:adc:ad7768-1 yaml conversion
  dt-bindings:iio:adc:ti,ads1015 yaml conversion
  dt-bindings:iio:adc:holt,hi8435 yaml conversion
  dt-bindings:iio:adc:amlogic,meson-saradc yaml conversion
  dt-bindings:iio:adc:fsl,imx7d-adc yaml conversion
  dt-bindings:iio:adc:fsl,imx25-gcq yaml conversion

 .../devicetree/bindings/iio/adc/ad7949.txt    |  16 --
 .../bindings/iio/adc/adi,ad7768-1.txt         |  41 -----
 .../bindings/iio/adc/adi,ad7768-1.yaml        |  89 +++++++++++
 .../bindings/iio/adc/adi,ad7949.yaml          |  57 +++++++
 .../devicetree/bindings/iio/adc/ads1015.txt   |  73 ---------
 .../bindings/iio/adc/amlogic,meson-saradc.txt |  48 ------
 .../iio/adc/amlogic,meson-saradc.yaml         | 149 ++++++++++++++++++
 .../bindings/iio/adc/aspeed,ast2400-adc.yaml  |  54 +++++++
 .../bindings/iio/adc/aspeed_adc.txt           |  22 ---
 .../bindings/iio/adc/berlin2_adc.txt          |  19 ---
 .../bindings/iio/adc/cc10001_adc.txt          |  22 ---
 .../bindings/iio/adc/cosmic,10001-adc.yaml    |  59 +++++++
 .../devicetree/bindings/iio/adc/cpcap-adc.txt |  17 --
 .../bindings/iio/adc/da9150-gpadc.txt         |  16 --
 .../bindings/iio/adc/dlg,da9150-gpadc.yaml    |  33 ++++
 .../bindings/iio/adc/fsl,imx25-gcq.txt        |  57 -------
 .../bindings/iio/adc/fsl,imx25-gcq.yaml       | 129 +++++++++++++++
 .../bindings/iio/adc/fsl,imx7d-adc.yaml       |  62 ++++++++
 .../bindings/iio/adc/fsl,vf610-adc.yaml       |  81 ++++++++++
 .../devicetree/bindings/iio/adc/hi8435.txt    |  21 ---
 .../bindings/iio/adc/holt,hi8435.yaml         |  49 ++++++
 .../devicetree/bindings/iio/adc/imx7d-adc.txt |  24 ---
 .../bindings/iio/adc/lpc1850-adc.txt          |  20 ---
 .../bindings/iio/adc/lpc32xx-adc.txt          |  21 ---
 .../bindings/iio/adc/marvell,berlin2-adc.yaml |  50 ++++++
 .../bindings/iio/adc/motorola,cpcap-adc.yaml  |  51 ++++++
 .../bindings/iio/adc/nuvoton,nau7802.yaml     |  50 ++++++
 .../bindings/iio/adc/nuvoton,npcm-adc.txt     |  26 ---
 .../bindings/iio/adc/nuvoton,npcm750-adc.yaml |  64 ++++++++
 .../bindings/iio/adc/nuvoton-nau7802.txt      |  18 ---
 .../bindings/iio/adc/nxp,lpc1850-adc.yaml     |  61 +++++++
 .../bindings/iio/adc/nxp,lpc3220-adc.yaml     |  50 ++++++
 .../bindings/iio/adc/sprd,sc2720-adc.yaml     |  72 +++++++++
 .../bindings/iio/adc/sprd,sc27xx-adc.txt      |  40 -----
 .../bindings/iio/adc/st,stmpe-adc.yaml        |  45 ++++++
 .../devicetree/bindings/iio/adc/stmpe-adc.txt |  21 ---
 .../bindings/iio/adc/ti,ads1015.yaml          | 113 +++++++++++++
 .../bindings/iio/adc/ti,twl4030-madc.yaml     |  48 ++++++
 .../bindings/iio/adc/twl4030-madc.txt         |  24 ---
 .../devicetree/bindings/iio/adc/vf610-adc.txt |  36 -----
 40 files changed, 1366 insertions(+), 582 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ad7949.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ads1015.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/cosmic,10001-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/hi8435.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/lpc1850-adc.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/marvell,berlin2-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nau7802.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton-nau7802.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,lpc1850-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,lpc3220-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,twl4030-madc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/twl4030-madc.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/vf610-adc.txt

-- 
2.28.0

