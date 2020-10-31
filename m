Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0D12A1946
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgJaSOx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbgJaSOx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:14:53 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76C86206A5;
        Sat, 31 Oct 2020 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604168092;
        bh=eN52Y9Agylx5825ENqdDMCX69uxi7BUitn2btS/In8A=;
        h=From:To:Cc:Subject:Date:From;
        b=edZUmKHUKKiNTehXThwZ8pbcfDOxPqE2to3vVKw2oThgQtf3PMh5aNPYU7Ofw+JiO
         cLzibg6Yd67XKTkwKEzVIMpGtSVs/zeZjg72uMaW4xwujQtbATpzMd8V1dHxpHbtBe
         WeDPUX/fWlm5SHHFhMkdnibsQnrjAusX74QEBk2Y=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/10] dt-bindings: iio: conversion of consumer drivers
Date:   Sat, 31 Oct 2020 18:12:32 +0000
Message-Id: <20201031181242.742301-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Firstly drop the old text file as the consumer binding (and the other
parts of that file) are under review for inclusion in the dt-schema external
repo.

This only converts consumers that happen to also be IIO drivers.
Others may get done as part of SoC binding conversions or I may do a lot
of them at somepoint.

A few of the examples in existing text files used providers that were
documented in trivial-bindings.yaml which does not allow for
#io-channel-cells. I have pulled those out to their own files as part
of this patch set.

The iio-mux binding is not done as that has some dependencies and will
form part of some future patch set.

There is no explicit dependency in here on any other sets, but some
noise will occur in trivial-bindings.yaml if applied in a different
order to I happen to have them sets locally.

Jonathan Cameron (10):
  dt-bindings:iio:iio-binding.txt Drop file as content now in dt-schema
  dt-bindings:iio:dac:dpot-dac: yaml conversion.
  dt-bindings:iio:potentiometer: give microchip,mcp4531 its own binding
  dt-bindings:iio:adc:envelope-detector: txt to yaml conversion.
  dt-bindings:iio:afe:current-sense-amplifier: txt to yaml conversion.
  dt-bindings:iio:afe:current-sense-shunt: txt to yaml conversion. 
  dt-bindings:iio:adc:maxim,max1027: Pull out to separate binding doc.
  dt-bindings:iio:afe:voltage-divider: txt to yaml conversion
  dt-bindings:iio:light:capella,cm3605: txt to yaml conversion.
  dt-bindings:iio:potentiostat:ti,lmp91000: txt to yaml conversion.

 .../bindings/iio/adc/envelope-detector.txt    |  54 -------
 .../bindings/iio/adc/envelope-detector.yaml   |  87 +++++++++++
 .../bindings/iio/adc/maxim,max1027.yaml       |  64 ++++++++
 .../iio/afe/current-sense-amplifier.txt       |  26 ----
 .../iio/afe/current-sense-amplifier.yaml      |  55 +++++++
 .../bindings/iio/afe/current-sense-shunt.txt  |  41 -----
 .../bindings/iio/afe/current-sense-shunt.yaml |  65 ++++++++
 .../bindings/iio/afe/voltage-divider.txt      |  53 -------
 .../bindings/iio/afe/voltage-divider.yaml     |  88 +++++++++++
 .../devicetree/bindings/iio/dac/dpot-dac.txt  |  41 -----
 .../devicetree/bindings/iio/dac/dpot-dac.yaml |  64 ++++++++
 .../devicetree/bindings/iio/iio-bindings.txt  | 102 -------------
 .../bindings/iio/light/capella,cm3605.yaml    |  78 ++++++++++
 .../devicetree/bindings/iio/light/cm3605.txt  |  41 -----
 .../iio/potentiometer/microchip,mcp4531.yaml  | 116 +++++++++++++++
 .../bindings/iio/potentiostat/lmp91000.txt    |  33 -----
 .../iio/potentiostat/ti,lmp91000.yaml         |  68 +++++++++
 .../devicetree/bindings/trivial-devices.yaml  | 140 ------------------
 18 files changed, 685 insertions(+), 531 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/envelope-detector.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/dpot-dac.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/iio-bindings.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/cm3605.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4531.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiostat/ti,lmp91000.yaml

-- 
2.28.0

