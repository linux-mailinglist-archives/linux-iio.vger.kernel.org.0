Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E16D22EE3E
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 16:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgG0OGD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 10:06:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43076 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgG0OGD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 10:06:03 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k03lR-0001ev-5a; Mon, 27 Jul 2020 14:06:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] counter: microchip-tcb-capture: remove ATMEL_TC_ETRGEDG_NONE bit check
Date:   Mon, 27 Jul 2020 15:06:00 +0100
Message-Id: <20200727140600.112562-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The macro ATMEL_TC_ETRGEDG_NONE is defined as 0 << 8 which is zero and
hence the check cmr & ATMEL_TC_ETRGEDG_NONE can never be true. Since
*action is already assigned MCHP_TC_SYNAPSE_ACTION_NONE then this check
and set is redundant dead code and can be removed.

Addresses-Coverity: ("Logically dead code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/counter/microchip-tcb-capture.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index f7b7743ddb94..119640d6d6ab 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -185,9 +185,7 @@ static int mchp_tc_count_action_get(struct counter_device *counter,
 
 	*action = MCHP_TC_SYNAPSE_ACTION_NONE;
 
-	if (cmr & ATMEL_TC_ETRGEDG_NONE)
-		*action = MCHP_TC_SYNAPSE_ACTION_NONE;
-	else if (cmr & ATMEL_TC_ETRGEDG_RISING)
+	if (cmr & ATMEL_TC_ETRGEDG_RISING)
 		*action = MCHP_TC_SYNAPSE_ACTION_RISING_EDGE;
 	else if (cmr & ATMEL_TC_ETRGEDG_FALLING)
 		*action = MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE;
-- 
2.27.0

