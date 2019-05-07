Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A534F165D3
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2019 16:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfEGOg1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 May 2019 10:36:27 -0400
Received: from mxout013.mail.hostpoint.ch ([217.26.49.173]:35999 "EHLO
        mxout013.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbfEGOg0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 May 2019 10:36:26 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout013.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hO1Ch-000IFQ-3D; Tue, 07 May 2019 16:36:23 +0200
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hO1Cg-0008oW-Sg; Tue, 07 May 2019 16:36:23 +0200
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        David Laight <David.Laight@ACULAB.COM>, dev@pschenker.ch,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] iio: stmpe-adc: Use wait_for_completion_timeout
Date:   Tue,  7 May 2019 16:36:14 +0200
Message-Id: <20190507143615.28477-4-dev@pschenker.ch>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190507143615.28477-1-dev@pschenker.ch>
References: <20190507143615.28477-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Use wait_for_completion_timeout instead of
wait_for_completion_interuptible_timeout.

The interruptible variant gets constantly interrupted if a user
program is compiled with the -pg option.
The killable variant was not used due to the fact that a second
program, reading on this device, that gets killed is then also killing
that wait.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 drivers/iio/adc/stmpe-adc.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index 82b43e4522b6..cc752a47444c 100644
--- a/drivers/iio/adc/stmpe-adc.c
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -77,17 +77,11 @@ static int stmpe_read_voltage(struct stmpe_adc *info,
 	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_CAPT,
 			STMPE_ADC_CH(info->channel));
 
-	*val = info->value;
-
-	ret = wait_for_completion_interruptible_timeout
-		(&info->completion, STMPE_ADC_TIMEOUT);
+	ret = wait_for_completion_timeout(&info->completion, STMPE_ADC_TIMEOUT);
 
 	if (ret <= 0) {
 		mutex_unlock(&info->lock);
-		if (ret == 0)
-			return -ETIMEDOUT;
-		else
-			return ret;
+		return -ETIMEDOUT;
 	}
 
 	*val = info->value;
@@ -116,15 +110,11 @@ static int stmpe_read_temp(struct stmpe_adc *info,
 	stmpe_reg_write(info->stmpe, STMPE_REG_TEMP_CTRL,
 			STMPE_START_ONE_TEMP_CONV);
 
-	ret = wait_for_completion_interruptible_timeout
-		(&info->completion, STMPE_ADC_TIMEOUT);
+	ret = wait_for_completion_timeout(&info->completion, STMPE_ADC_TIMEOUT);
 
 	if (ret <= 0) {
 		mutex_unlock(&info->lock);
-		if (ret == 0)
-			return -ETIMEDOUT;
-		else
-			return ret;
+		return -ETIMEDOUT;
 	}
 
 	/*
-- 
2.21.0

