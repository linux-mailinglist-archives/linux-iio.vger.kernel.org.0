Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628493F5A8D
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 11:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhHXJM4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 05:12:56 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:49934 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbhHXJMw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 05:12:52 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 17O8rEkf098382;
        Tue, 24 Aug 2021 16:53:15 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 24 Aug
 2021 17:11:47 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [RESEND v4 03/15] iio: adc: aspeed: set driver data when adc probe.
Date:   Tue, 24 Aug 2021 17:12:31 +0800
Message-ID: <20210824091243.9393-4-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
References: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 17O8rEkf098382
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix the issue when adc remove will get the null driver data.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 7010d56ac3b9..20462cf659e4 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -201,6 +201,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 
 	data = iio_priv(indio_dev);
 	data->dev = &pdev->dev;
+	platform_set_drvdata(pdev, indio_dev);
 
 	data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->base))
-- 
2.25.1

