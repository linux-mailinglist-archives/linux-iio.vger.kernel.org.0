Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9669C1413D8
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2020 23:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgAQWBG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jan 2020 17:01:06 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:38480 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730040AbgAQWBD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 Jan 2020 17:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X60lhDD3EIIas99/kMy31DwPl9X0FpUBM1BVk43FGZM=; b=NJ21HVXSsv2aS36MiDR40AQ3VW
        QkvAmK4dHtiyoagnktdOq7OQ0l0U0cJXdG5pdLfqSOEaB9XiHS/T2OMZ0lbCWfxKONZkyhCINj/Km
        7jjpkPNOahPWFeQVjIG+WA07lWdF3Qr+vWlf/8vbBm2Z6u3HI9JOM/ghYlnQIPONWjao=;
Received: from p200300ccff371b001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff37:1b00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1isZfm-000780-Mb; Fri, 17 Jan 2020 23:00:58 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1isZfm-0003yg-DA; Fri, 17 Jan 2020 23:00:58 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, andreas@kemnade.info,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org
Subject: [RFC PATCH 4/5] mfd: rn5t618: add IRQ definitions for RN5T618
Date:   Fri, 17 Jan 2020 22:59:25 +0100
Message-Id: <20200117215926.15194-5-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117215926.15194-1-andreas@kemnade.info>
References: <20200117215926.15194-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Previously, only the definitions for the RC5T619 were
available.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Untested, IMHO only acceptable with a Tested-By

 drivers/mfd/rn5t618.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 321836f78120..6828fd40b0a1 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -58,6 +58,24 @@ static const struct regmap_config rn5t618_regmap_config = {
 	.cache_type	= REGCACHE_RBTREE,
 };
 
+static const struct regmap_irq rn5t618_irqs[] = {
+	REGMAP_IRQ_REG(RN5T618_IRQ_SYS, 0, BIT(0)),
+	REGMAP_IRQ_REG(RN5T618_IRQ_DCDC, 0, BIT(1)),
+	REGMAP_IRQ_REG(RN5T618_IRQ_ADC, 0, BIT(3)),
+	REGMAP_IRQ_REG(RN5T618_IRQ_GPIO, 0, BIT(4)),
+	REGMAP_IRQ_REG(RN5T618_IRQ_CHG, 0, BIT(6)),
+};
+
+static const struct regmap_irq_chip rn5t618_irq_chip = {
+	.name = "rn5t618",
+	.irqs = rn5t618_irqs,
+	.num_irqs = ARRAY_SIZE(rn5t618_irqs),
+	.num_regs = 1,
+	.status_base = RN5T618_INTMON,
+	.mask_base = RN5T618_INTEN,
+	.mask_invert = true,
+};
+
 static const struct regmap_irq rc5t619_irqs[] = {
 	REGMAP_IRQ_REG(RN5T618_IRQ_SYS, 0, BIT(0)),
 	REGMAP_IRQ_REG(RN5T618_IRQ_DCDC, 0, BIT(1)),
@@ -92,6 +110,9 @@ static int rn5t618_irq_init(struct rn5t618 *rn5t618)
 	case RC5T619:
 		irq_chip = &rc5t619_irq_chip;
 		break;
+	case RN5T618:
+		irq_chip = &rn5t618_irq_chip;
+		break;
 	default:
 		irq_chip = NULL;
 		break;
-- 
2.20.1

