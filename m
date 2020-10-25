Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B8529829C
	for <lists+linux-iio@lfdr.de>; Sun, 25 Oct 2020 17:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417282AbgJYQvr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Oct 2020 12:51:47 -0400
Received: from vern.gendns.com ([98.142.107.122]:35828 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1417281AbgJYQvq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Oct 2020 12:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pGW5JlQHLHC7jZlWVW5W5JO4NogTaQL5cry9rwJRFUY=; b=YxbsvWBikpHpQBfh3CMfVmv9TL
        g0m+3mLF6VQ+ZMVHhb25fzHPzm7SNI43GriVV/1rWm/LJlhZTZmTBtccR97bbL/CX2V4tK+MPNuZx
        uxX3E4aeFblOgF9P5pNmGi5Dj1XCQz3CwVVqSe9C5GZkcTwYvfJkWFEoYVBoVqdlznRFDcXBQEAUA
        e+zmSkhN29NyuYk/uhDKFhbbu/Xv7EZey+xr6c9juczTwfqGQV+srb0QRKg241rZ/Pqw15Dkf2wml
        U1+vvtr1oX+BctogiJNckOZZEyK3azrp8riZRx6l/4HMznA/Eoie8HFjJINYgFFcIR9+e4RABY1Z+
        UCzuq/Rw==;
Received: from [2600:1700:4830:165f::19e] (port=38296 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kWjFB-0008JL-3s; Sun, 25 Oct 2020 12:51:45 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] counter/ti-eqep: Fix regmap max_register
Date:   Sun, 25 Oct 2020 11:51:22 -0500
Message-Id: <20201025165122.607866-1-david@lechnology.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The values given were the offset of the register after the last
register instead of the actual last register in each range. Fix
by using the correct last register of each range.

Fixes: f213729f6796 ("counter: new TI eQEP driver")
Signed-off-by: David Lechner <david@lechnology.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---

v2 changes:
* add Fixes: tag
* picked up Acked-by:

 drivers/counter/ti-eqep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 1ff07faef27f..5d6470968d2c 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -368,7 +368,7 @@ static const struct regmap_config ti_eqep_regmap32_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.max_register = 0x24,
+	.max_register = QUPRD,
 };
 
 static const struct regmap_config ti_eqep_regmap16_config = {
@@ -376,7 +376,7 @@ static const struct regmap_config ti_eqep_regmap16_config = {
 	.reg_bits = 16,
 	.val_bits = 16,
 	.reg_stride = 2,
-	.max_register = 0x1e,
+	.max_register = QCPRDLAT,
 };
 
 static int ti_eqep_probe(struct platform_device *pdev)
-- 
2.25.1

