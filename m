Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA7E21568F
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jul 2020 13:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgGFLoD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jul 2020 07:44:03 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50463 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgGFLoD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jul 2020 07:44:03 -0400
X-Originating-IP: 86.202.118.225
Received: from localhost (lfbn-lyo-1-23-225.w86-202.abo.wanadoo.fr [86.202.118.225])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 204804000F;
        Mon,  6 Jul 2020 11:44:00 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v6 0/5] Microchip TCB Capture driver
Date:   Mon,  6 Jul 2020 13:43:42 +0200
Message-Id: <20200706114347.174452-1-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Here is a new counter driver to support Microchip TCB capture devices.

Each SoC has two TCB blocks, each one including three independent
channels.The following series adds support for two counter modes:
increase and quadrature decoder.

As for the atmel clocksource and pwm, the counter driver needs to fill
some tcb capabilities in order to operate with the right configuration.
This is achieved in first patch of this series.

Please feel free to comment.

Cheers,

Changes in v6:
 - Rebased on top of v5.8-rc3
 - Added Alexandre's ack
 - Added Rob's ack

Changes in v5:
 - Fix duplicate keys errors in yaml dt-schema

Changes in v4:
 - Use existing binding to document capture mode of the Microchip TCBs.

Changes in v3:
 - Updated the brand name: s/atmel/microchip/.
 - Added missing kernel doc for new elements introduced in structure
   atmel_tcb_config.
 - Removed useless blank line
 - Added an explicit clock removing path using devm_add_action_or_reset

Changes in v2:
 - Fixed first patch not applying on mainline
 - Updated return code to -EINVAL when user is requesting qdec mode on
   a counter device not supporting it.
 - Added an error case returning -EINVAL when action edge is performed
   in
   qdec mode.
 - Removed no need to explicity setting ops to NULL from static struct
   as
   it is the default value.
 - Changed confusing code by using snprintf for the sake of clarity.
 - Changed code to use ARRAY_SIZE so that future reviewers will know
   that num_counts matches what's in the atmel_tc_count array without
   having to check so themselves.
 - Fixed errors reported by dt_binding_check

Alexandre Belloni (2):
  dt-bindings: atmel-tcb: convert bindings to json-schema
  dt-bindings: microchip: atmel,at91rm9200-tcb: add sama5d2 compatible

Kamel Bouhara (3):
  ARM: at91: add atmel tcb capabilities
  dt-bindings: counter: microchip-tcb-capture counter
  counter: Add microchip TCB capture counter

 .../devicetree/bindings/mfd/atmel-tcb.txt     |  56 ---
 .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 181 ++++++++
 drivers/counter/Kconfig                       |  11 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/microchip-tcb-capture.c       | 397 ++++++++++++++++++
 include/soc/at91/atmel_tcb.h                  |   5 +
 6 files changed, 595 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
 create mode 100644 drivers/counter/microchip-tcb-capture.c

--
2.26.2

