Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF30D3CCF92
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 11:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhGSISL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 04:18:11 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:14960 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235382AbhGSISL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 04:18:11 -0400
X-IronPort-AV: E=Sophos;i="5.84,251,1620658800"; 
   d="scan'208";a="88109128"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 19 Jul 2021 17:58:49 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id AF7D0400A881;
        Mon, 19 Jul 2021 17:58:45 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/4] Renesas RZ/G2L ADC driver support
Date:   Mon, 19 Jul 2021 09:58:36 +0100
Message-Id: <20210719085840.21842-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

This patch series adds ADC support for Renesas RZ/G2L family.

Cheers,
Prabhakar

Changes for v2:
* Update binding doc, dropped gpios/renesas-rzg2l,adc-trigger-mode
  properties included channel property to represent each wired channel.
* Fixed review comments pointed by Alexandru, implemented pm runtime
  support, dropped mlock usage
* Fixed review comments pointed by Jonathan, renamed the macros,
  simplified the code.
* Included clock and DT patches

Lad Prabhakar (4):
  dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L
    A/D converter
  iio: adc: Add driver for Renesas RZ/G2L A/D converter
  clk: renesas: r9a07g044-cpg: Add clock and reset entries for ADC
  arm64: dts: renesas: r9a07g044: Add ADC node

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 134 +++++
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  42 ++
 drivers/clk/renesas/r9a07g044-cpg.c           |   6 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/rzg2l_adc.c                   | 545 ++++++++++++++++++
 7 files changed, 746 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
 create mode 100644 drivers/iio/adc/rzg2l_adc.c


base-commit: 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
-- 
2.17.1

