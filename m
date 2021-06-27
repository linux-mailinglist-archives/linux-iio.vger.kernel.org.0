Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095613B543A
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jun 2021 18:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhF0Qc4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Jun 2021 12:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhF0Qc4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Jun 2021 12:32:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D022B619AD;
        Sun, 27 Jun 2021 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624811432;
        bh=hAqoMyIjld/9XyVgLYMid4q9oUOLRkUb/H2AT2cKqk0=;
        h=From:To:Cc:Subject:Date:From;
        b=eOR1a1hctKsnkHfb92XU/NQOaf7C9bX4NqR7GZnOnxl3rYO//dQ9Wgx3plP7s5mAL
         C2pFXpVd2mmgv3tdgqvB0q+EL2vUiSgYmJf+MOLl41kEhugZq5RvDKptBLNRiYBPOG
         dsDHCgQn1N+HHkZAsHiA/r013I+aPQnRceiIRuTagFekWIT2jahXI8SR7pOsOk+c1N
         PcXzx8h2Vs085Ux/CQm/4V1/j2nJJ4204Mi2JPwtGDEQJzuhFaifqhEMqQDiv/M46P
         n87CQnhs0rmxljZsaVIm9bjryhCJzB7XTtFXP//1PgxHs3LTOGZyl4Je2EiuIdQ+Lb
         Mha3j/Dxzssug==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>,
        Michael Welling <mwelling@ieee.org>
Subject: [PATCH 00/15] dt-bindings: iio: dac: Add most missing binding documents.
Date:   Sun, 27 Jun 2021 17:32:29 +0100
Message-Id: <20210627163244.1090296-1-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

We have quite a few drivers in IIO that date back to the days of platform
data.  Many of them either worked out of the box with device tree
due to the spi core using the spi_device_id to match against
device tree compatibles, or were updated to use newer interfaces in the
intervening years.  As such, they mostly 'work' with device tree but
can have some slightly odd quirks (particularly around naming of supplies).
As we have no way of knowing what is out in the wild, we need to support
these interesting bits of regulator naming.

I would ultimately like all such bindings to be documented both to facilitate
automated check of device trees and to make things easier for people trying
to write device tree files using these devices.

This series fills in the majority of the absent bindings for DACs.
There are some outstanding
* max517 - some platform data configuration needs porting over to device tree.
* m62332 - this passes a consumer mapping in as platform data and will need
  careful porting over the dt way of doing that.

There is one 'fixlet' in here for the driver to deal with a case were the
code was intended to allow the presence of a regulator to dictate whether
an internal reference was used, but did not use the optional regulator
get.

I've mostly nominated maintainers based on original authorship + where
I was feeling guilty or couldn't find anyone still active I've listed myself.

I got bored half way through of producing brief descriptions of
the devices so stopped doing so. If anyone wants to provide one for these
parts I'm happy to add it!

Future series will cover the c. 40 bindings that I've identified as missing
for other types of devices.  I've also kept notes of easy cleanups in
drivers spotted whilst working these out, so will probably follow up with
those soon as well.

Note I haven't tested all of these so there may well be errors or elements
I've missed.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ricardo Ribalda <ribalda@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>
Cc: Michael Welling <mwelling@ieee.org>

Jonathan Cameron (15):
  dt-bindings: iio: dac: adi,ad5421: Add missing binding document.
  dt-bindings: iio: dac: adi,ad5064: Document bindings for many
    different DACs
  dt-bindings: iio: dac: adi,ad5360: Add missing binding document
  dt-bindings: iio: dac: ad5380: Add missing binding document
  dt-bindings: iio: dac: ad5446: Add missing binding document
  dt-bindings: iio: dac: ad5449: Add missing binding document.
  dt-bindings: iio: dac: ad5504: Add missing binding document
  iio: dac: ad5624r: Fix incorrect handling of an optional regulator.
  dt-bindings: iio: dac: ad5624r: Add missing binding document
  dt-bindings: iio: dac: ad5686 and ad5696: Add missing binding
    document.
  dt-bindings: iio: dac: ad5761: Add missing binding doc.
  dt-bindings: iio: dac: adi,ad5764: Add missing binding document
  dt-bindings: iio: dac: adi,ad5791: Add missing bindings document
  dt-bindings: iio: dac: adi,ad8801: Add missing binding document.
  dt-bindings: iio: dac: microchip,mcp4922: Add missing binding document

 .../bindings/iio/dac/adi,ad5064.yaml          | 268 ++++++++++++++++++
 .../bindings/iio/dac/adi,ad5360.yaml          |  79 ++++++
 .../bindings/iio/dac/adi,ad5380.yaml          |  70 +++++
 .../bindings/iio/dac/adi,ad5421.yaml          |  51 ++++
 .../bindings/iio/dac/adi,ad5446.yaml          | 105 +++++++
 .../bindings/iio/dac/adi,ad5449.yaml          |  97 +++++++
 .../bindings/iio/dac/adi,ad5504.yaml          |  50 ++++
 .../bindings/iio/dac/adi,ad5624r.yaml         |  47 +++
 .../bindings/iio/dac/adi,ad5686.yaml          |  75 +++++
 .../bindings/iio/dac/adi,ad5761.yaml          |  60 ++++
 .../bindings/iio/dac/adi,ad5764.yaml          |  62 ++++
 .../bindings/iio/dac/adi,ad5791.yaml          |  52 ++++
 .../bindings/iio/dac/adi,ad8801.yaml          |  60 ++++
 .../bindings/iio/dac/microchip,mcp4922.yaml   |  46 +++
 drivers/iio/dac/ad5624r_spi.c                 |  18 +-
 15 files changed, 1139 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5064.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5360.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5421.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5449.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5624r.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5761.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5764.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad8801.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml

-- 
2.32.0

