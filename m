Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075E81AA32A
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 15:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505904AbgDONFH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 09:05:07 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:46327 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505896AbgDONFC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 09:05:02 -0400
X-Originating-IP: 78.193.40.249
Received: from localhost (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id C089DFF80D;
        Wed, 15 Apr 2020 13:04:58 +0000 (UTC)
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
Subject: [PATCH v3 0/3] Microchip TCB Capture driver
Date:   Wed, 15 Apr 2020 15:04:52 +0200
Message-Id: <20200415130455.2222019-1-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.25.0
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

Changes from v3:
 - Updated the brand name: s/atmel/microchip/.
 - Added missing kernel doc for new elements introduced in structure
   atmel_tcb_config.
 - Removed useless blank line
 - Added an explicit clock removing path using devm_add_action_or_reset

Changes from v2:
 - Fixed first patch not applying on mainline
 - Updated return code to -EINVAL when user is requesting qdec mode on
   a counter device not supporting it.
 - Added an error case returning -EINVAL when action edge is performed in
   qdec mode.
 - Removed no need to explicity setting ops to NULL from static struct as
   it is the default value.
 - Changed confusing code by using snprintf for the sake of clarity.
 - Changed code to use ARRAY_SIZE so that future reviewers will know
   that num_counts matches what's in the atmel_tc_count array without
   having to check so themselves.
 - Fixed errors reported by dt_binding_check


Kamel Bouhara (3):
  ARM: at91: add atmel tcb capabilities
  dt-bindings: counter: microchip-tcb-capture counter
  counter: Add microchip TCB capture counter

 .../counter/microchip-tcb-capture.yaml        |  33 ++
 drivers/counter/Kconfig                       |  11 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/microchip-tcb-capture.c       | 397 ++++++++++++++++++
 include/soc/at91/atmel_tcb.h                  |   5 +
 5 files changed, 447 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/microchip-tcb-capture.yaml
 create mode 100644 drivers/counter/microchip-tcb-capture.c

-- 
2.25.0

