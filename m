Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8073CCFD5
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhGSIVn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 04:21:43 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:10811 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbhGSIVn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 04:21:43 -0400
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 16J7obie015582
        for <linux-iio@vger.kernel.org>; Mon, 19 Jul 2021 15:50:37 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 16J7nQBf015319;
        Mon, 19 Jul 2021 15:49:26 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Jul
 2021 16:05:47 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <billy_tsai@aspeedtech.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <raltherr@google.com>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v1 0/7] Add support for ast2600 ADC
Date:   Mon, 19 Jul 2021 16:06:00 +0800
Message-ID: <20210719080607.28712-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 16J7nQBf015319
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch serials make aspeed_adc.c can support ast2600.
In additional,
patch #6 is used to improve the adc accurate and 
patch #7 is used to fix the clock issue in the original code.

Billy Tsai (7):
  dt-bindings: iio: adc: rename the aspeed adc yaml
  dt-bindings: iio: adc: Binding ast2600 adc.
  iio: adc: aspeed: completes the bitfield declare.
  iio: adc: aspeed: Allow driver to support ast2600
  iio: adc: aspeed: Add func to set sampling rate.
  iio: adc: aspeed: Add compensation phase.
  iio: adc: aspeed: Fix the calculate error of clock.

 ...speed,ast2400-adc.yaml => aspeed,adc.yaml} |  23 +-
 drivers/iio/adc/aspeed_adc.c                  | 313 ++++++++++++++----
 2 files changed, 266 insertions(+), 70 deletions(-)
 rename Documentation/devicetree/bindings/iio/adc/{aspeed,ast2400-adc.yaml => aspeed,adc.yaml} (53%)

-- 
2.25.1

