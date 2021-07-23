Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5113D3655
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 10:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhGWHfX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 03:35:23 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:29940 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbhGWHfX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 03:35:23 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 16N7x5gb041948;
        Fri, 23 Jul 2021 15:59:05 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Jul
 2021 16:15:39 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v2 0/8] Add support for ast2600 ADC
Date:   Fri, 23 Jul 2021 16:16:13 +0800
Message-ID: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 16N7x5gb041948
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch serials make aspeed_adc.c can support ast2600.
In additional,
patch #6 is used to improve the adc accurate 
patch #7 is used to fix the clock issue in the original code.

Changes since v1:
dt-bindings:
  - Fix the aspeed,adc.yaml check error.
  - Add battery-sensing property.
aspeed_adc.c:
  - Change the init flow:
    Clock and reference voltage setting should be completed before adc
    engine enable.
  - Change the default sampling rate to meet most user case.
  - Add patch #8 to suppoert battery sensing mode.

Billy Tsai (8):
  dt-bindings: iio: adc: rename the aspeed adc yaml
  dt-bindings: iio: adc: Binding ast2600 adc.
  iio: adc: aspeed: completes the bitfield declare.
  iio: adc: aspeed: Allow driver to support ast2600
  iio: adc: aspeed: Add func to set sampling rate.
  iio: adc: aspeed: Add compensation phase.
  iio: adc: aspeed: Fix the calculate error of clock.
  iio: adc: aspeed: Support battery sensing.

 .../bindings/iio/adc/aspeed,adc.yaml          |  79 ++++
 .../bindings/iio/adc/aspeed,ast2400-adc.yaml  |  55 ---
 drivers/iio/adc/aspeed_adc.c                  | 376 ++++++++++++++----
 3 files changed, 385 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml

-- 
2.25.1

