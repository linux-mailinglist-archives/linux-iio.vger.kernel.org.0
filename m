Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37F93E0947
	for <lists+linux-iio@lfdr.de>; Wed,  4 Aug 2021 22:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbhHDUZX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Aug 2021 16:25:23 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:13749 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237196AbhHDUZX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Aug 2021 16:25:23 -0400
X-IronPort-AV: E=Sophos;i="5.84,295,1620658800"; 
   d="scan'208";a="89824500"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Aug 2021 05:25:08 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A5A7940E2584;
        Thu,  5 Aug 2021 05:25:05 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 0/3] Renesas RZ/G2L ADC driver support
Date:   Wed,  4 Aug 2021 21:21:15 +0100
Message-Id: <20210804202118.25745-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

This patch series adds ADC support for Renesas RZ/G2L family.

Patches apply on top of v5.14-rc2.

Cheers,
Prabhakar

Changes for v4:
* Fixed registering action to assert resets on failure/remove
  as reported by Philip.
* Fixed review comments suggested by Jonathan.
* Included RB tag from Rob for patch 1/3
* Note DTS patch applies on top of https://git.kernel.org/pub/scm/
  linux/kernel/git/geert/renesas-devel.git/log/
  ?h=renesas-arm-dt-for-v5.15

Changes for v3 (as requested by Jonathan):
* Made use of FIELD_PREP()
* Renamed _CLEAR to _MASK and inverted inline as required
* Moved |= pair's on same lines
* Made use of sysfs_emit() while reading the labels
* Used for_each_bit_set() in rzg2l_adc_isr()
* Renamed rzg2l_adc_parse_of() -> rzg2l_adc_parse_properties()
* Used devm_add_action_or_reset() for asserting the reset signals and
  disabling pm_runtime and eventually removing remove() callback
* Added comments in isr handler for channel select interrupt
* Moved enabling/disabling of pclk during hw init in rzg2l_adc_hw_init()
* Dropped clock patch 3/4 (https://lore.kernel.org/patchwork/patch/1462152/)
  from previous series as its queued up in renesas-clk-for-v5.15

Changes for v2:
* Update binding doc, dropped gpios/renesas-rzg2l,adc-trigger-mode
  properties included channel property to represent each wired channel.
* Fixed review comments pointed by Alexandru, implemented pm runtime
  support, dropped mlock usage
* Fixed review comments pointed by Jonathan, renamed the macros,
  simplified the code.
* Included clock and DT patches

v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/
    20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Lad Prabhakar (3):
  dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L
    A/D converter
  iio: adc: Add driver for Renesas RZ/G2L A/D converter
  arm64: dts: renesas: r9a07g044: Add ADC node

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 134 ++++
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  42 ++
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/rzg2l_adc.c                   | 600 ++++++++++++++++++
 6 files changed, 795 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
 create mode 100644 drivers/iio/adc/rzg2l_adc.c

-- 
2.17.1

