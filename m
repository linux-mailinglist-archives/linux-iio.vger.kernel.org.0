Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121863CCFD4
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbhGSIVm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 04:21:42 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:22444 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbhGSIVl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 04:21:41 -0400
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 16J7oY9O015581
        for <linux-iio@vger.kernel.org>; Mon, 19 Jul 2021 15:50:34 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 16J7nQi0015320;
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
Subject: [v1 1/7] dt-bindings: iio: adc: rename the aspeed adc yaml
Date:   Mon, 19 Jul 2021 16:06:01 +0800
Message-ID: <20210719080607.28712-2-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210719080607.28712-1-billy_tsai@aspeedtech.com>
References: <20210719080607.28712-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 16J7nQi0015320
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The aspeed,ast2400-adc.yaml not only descriptor the bindings of ast2400.
Rename it to aspeed,adc.yaml for all of the aspeed adc bindings.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/iio/adc/{aspeed,ast2400-adc.yaml => aspeed,adc.yaml} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/iio/adc/{aspeed,ast2400-adc.yaml => aspeed,adc.yaml} (100%)

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml
rename to Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
-- 
2.25.1

