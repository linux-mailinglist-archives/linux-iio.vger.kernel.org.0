Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46275EEEF
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jul 2023 11:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjGXJTh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jul 2023 05:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjGXJTg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2023 05:19:36 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38F7412A;
        Mon, 24 Jul 2023 02:19:35 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,228,1684767600"; 
   d="scan'208";a="170613687"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Jul 2023 18:19:34 +0900
Received: from localhost.localdomain (unknown [10.226.92.186])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6ECE54155DE0;
        Mon, 24 Jul 2023 18:19:30 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/6] Add RZ/G2UL MTU3a support
Date:   Mon, 24 Jul 2023 10:19:21 +0100
Message-Id: <20230724091927.123847-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series aims to add MTU3a support for RZ/G2UL SMARC EVK.
Also it fixes overflow/underflow interrupt names.

v1->v2:
 * Added Ack tags from Conor Dooley for binding patches
 * Updated commit description RZ/G2UL->RZ/{G2UL,Five} for patch#5.
 * Fixed build error reported by kernel test robot by replacing
   GIC_SPI x ->SOC_PERIPHERAL_IRQ(x) for patch#5.

Biju Das (6):
  dt-bindings: timer: renesas,rz-mtu3: Improve documentation
  dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interrupt
    names
  dt-bindings: timer: renesas,rz-mtu3: Document RZ/G2UL SoC
  arm64: dts: renesas: r9a07g044: Update overfow/underflow IRQ names for
    MTU3 channels
  arm64: dts: renesas: r9a07g043: Add MTU3a node
  arm64: dts: renesas: rzg2ul-smarc: Add support for enabling MTU3

 .../bindings/timer/renesas,rz-mtu3.yaml       | 67 +++++++++---------
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    | 70 +++++++++++++++++++
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   | 11 +++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 16 ++---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    | 16 ++---
 .../dts/renesas/rzg2ul-smarc-pinfunction.dtsi |  6 ++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi | 13 ++++
 7 files changed, 150 insertions(+), 49 deletions(-)

-- 
2.25.1

