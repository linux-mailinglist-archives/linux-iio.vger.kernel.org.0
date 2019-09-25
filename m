Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56291BDB71
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2019 11:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfIYJv3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Sep 2019 05:51:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58220 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfIYJv3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Sep 2019 05:51:29 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iD3xG-0003pi-Gv; Wed, 25 Sep 2019 09:51:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] counter: stm32: clean up indentation issue
Date:   Wed, 25 Sep 2019 10:51:26 +0100
Message-Id: <20190925095126.20219-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is an if statement that is indented one level too deeply,
remove the extraneous tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/counter/stm32-timer-cnt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 644ba18a72ad..613dcccf79e1 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -219,8 +219,8 @@ static ssize_t stm32_count_enable_write(struct counter_device *counter,
 
 	if (enable) {
 		regmap_read(priv->regmap, TIM_CR1, &cr1);
-			if (!(cr1 & TIM_CR1_CEN))
-				clk_enable(priv->clk);
+		if (!(cr1 & TIM_CR1_CEN))
+			clk_enable(priv->clk);
 
 		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
 				   TIM_CR1_CEN);
-- 
2.20.1

