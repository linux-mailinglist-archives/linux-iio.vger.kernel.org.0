Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF9F642AD5
	for <lists+linux-iio@lfdr.de>; Mon,  5 Dec 2022 16:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiLEPAJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Dec 2022 10:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiLEPAI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2022 10:00:08 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 868C8BC85;
        Mon,  5 Dec 2022 07:00:03 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,219,1665414000"; 
   d="scan'208";a="142271622"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Dec 2022 00:00:02 +0900
Received: from localhost.localdomain (unknown [10.226.92.127])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8F8834007F3F;
        Mon,  5 Dec 2022 23:59:57 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        William Breathitt Gray <william.gray@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
Date:   Mon,  5 Dec 2022 14:59:49 +0000
Message-Id: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series aims to add support for Compare-Match Timer (TIM)
module found on RZ/V2M SoC.

it is composed of 32 channels and channels 0-7 and 24-32 are
reserved for ISP usage.

Channel 22 is modelled as clock source and Channel 23 is modelled as clock
event driver and the rest of the channels are modelled as counter driver
as it provides

1) counter for counting
2) configurable counter value for generating timer interrupt
3) userspace event for each interrupt.

logs:-
Counter driver:
Counter driver is tested by reading counts and interrupts tested by
counter-example in tools/counter/counter_example.c

Count snapshot value:
3114
Output from counter_example when it triggers interrupts:
Timestamp 0: 24142152969        Count 0: 5
Error Message 0: Success

Clock source:
Clock source driver is tested by clock-source-switch app.
[ 1275.703567] clocksource: Switched to clocksource arch_sys_counter
[ 1275.710189] clocksource: Switched to clocksource a4000b00.timer
[OK]
# Totals: pass[ 1275.718112] clocksource: Switched to clocksource arch_sys_counter
:0 fail:0 xfail:0 xpass:0 skip:0 error:0
# Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0

Clock event:
clock event driver is tested by changing the rating as 500.

Biju Das (6):
  clk: renesas: r9a09g011: Add TIM clock and reset entries
  dt-bindings: timer: Add RZ/V2M TIM binding
  clocksource/drivers/rzv2m-tim: Add Renesas RZ/V2M compare match
    timer(TIM) driver
  dt-bindings: counter: Add RZ/V2M TIM counter binding
  counter: Add Renesas RZ/V2M TIM counter driver
  arm64: dts: renesas: r9a09g011: Add tim nodes

 .../counter/renesas,rzv2m-tim-cnt.yaml        |  83 +++++
 .../bindings/timer/renesas,rzv2m-tim.yaml     |  83 +++++
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    | 192 ++++++++++
 drivers/clk/renesas/r9a09g011-cpg.c           |  22 ++
 drivers/clocksource/Kconfig                   |   7 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/rzv2m-tim.c               | 330 ++++++++++++++++++
 drivers/counter/Kconfig                       |  10 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/rzv2m-tim-cnt.c               | 312 +++++++++++++++++
 10 files changed, 1041 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/renesas,rzv2m-tim-cnt.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,rzv2m-tim.yaml
 create mode 100644 drivers/clocksource/rzv2m-tim.c
 create mode 100644 drivers/counter/rzv2m-tim-cnt.c

-- 
2.25.1

