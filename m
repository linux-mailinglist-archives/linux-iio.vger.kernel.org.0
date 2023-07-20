Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5087375AF38
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jul 2023 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjGTNKa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jul 2023 09:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGTNK3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jul 2023 09:10:29 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D410135;
        Thu, 20 Jul 2023 06:10:24 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,218,1684767600"; 
   d="scan'208";a="170253809"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Jul 2023 22:10:23 +0900
Received: from localhost.localdomain (unknown [10.226.92.157])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 65D8140116DC;
        Thu, 20 Jul 2023 22:10:19 +0900 (JST)
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
Subject: [PATCH 0/6] Add RZ/G2UL MTU3a support
Date:   Thu, 20 Jul 2023 14:10:10 +0100
Message-Id: <20230720131016.331793-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series aims to add MTU3a support for RZ/G2UL SMARC EVK.

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

