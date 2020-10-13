Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BA928CBBE
	for <lists+linux-iio@lfdr.de>; Tue, 13 Oct 2020 12:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbgJMKdD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Oct 2020 06:33:03 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:40380 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387471AbgJMKdD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2020 06:33:03 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 09DAUff7010591;
        Tue, 13 Oct 2020 18:30:41 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Oct
 2020 18:32:57 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <p.zabel@pengutronix.de>,
        <billy_tsai@aspeedtech.com>, <alexandru.ardelean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH 0/3] Make driver compatible with ast2600
Date:   Tue, 13 Oct 2020 18:32:42 +0800
Message-ID: <20201013103245.16723-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 09DAUff7010591
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ast2600 is a new generation of SoC from ASPEED.
The adc device in this generation adds some changes and features.
This patch series handles the changes below:
1. Define the new register fields.
2. Split into two individual IPs and each contains 8 voltage channels.
3. Remove the pre-scaler and extend the field length of the scaler.
4. Ref_voltage becomes configurable.

Billy Tsai (3):
  iio: adc: aspeed: Orgnaize and add the define of adc
  iio: adc: aspeed: Make driver compatible with ast2600
  iio: adc: aspeed: Setting ref_voltage in probe

 .../bindings/iio/adc/aspeed_adc.txt           |  16 +-
 drivers/iio/adc/aspeed_adc.c                  | 168 ++++++++++++++----
 2 files changed, 148 insertions(+), 36 deletions(-)

-- 
2.17.1

