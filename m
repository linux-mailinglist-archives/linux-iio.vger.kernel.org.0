Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD971620CD
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2020 07:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgBRGVA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Feb 2020 01:21:00 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:58054 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgBRGUu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Feb 2020 01:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bDxLdFftj2IWWC8iJ/gD6olwrFTBIbD4WB3uu4ao4RY=; b=Ua4SnNymDOW+CeAghFqEEFozG/
        Tj5c3e6dpeLvF3Oe1pDNqKEhaPCpjj/c1aBF4FEK5Hz9T/ZKpVav3IPAH54Fir05T56hUmoDtdJee
        4LiRplNUeRlufno8ua2NmI/6Q2Ep5veFFTjJRHtU400eyGOEzllogeua/SeC4mEn8V+M=;
Received: from [77.247.85.102] (helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j3wFO-0000oy-1L; Tue, 18 Feb 2020 07:20:42 +0100
Received: from andi by localhost with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j3wF4-0005rK-VX; Tue, 18 Feb 2020 07:20:22 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, phh@phh.me, stefan@agner.ch,
        letux-kernel@openphoenux.org, martin.blumenstingl@googlemail.com,
        jic23@kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RFC v3 3/4] mfd: rn5t618: add IRQ definitions for RN5T618
Date:   Tue, 18 Feb 2020 07:17:24 +0100
Message-Id: <20200218061725.22420-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218061725.22420-1-andreas@kemnade.info>
References: <20200218061725.22420-1-andreas@kemnade.info>
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
depends on:
https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.info/

Untested, IMHO only acceptable with a Tested-By.
Not needed for the RC5T619, feel free to ignore them if the whole series
would be delayed just because of missing Tested-By for this.


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

