Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32CAD165D2
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2019 16:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfEGOg0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 May 2019 10:36:26 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:63402 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbfEGOg0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 May 2019 10:36:26 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hO1Ce-000454-QD; Tue, 07 May 2019 16:36:20 +0200
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hO1Ce-0008oW-Jv; Tue, 07 May 2019 16:36:20 +0200
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
Subject: [PATCH 2/5] iio: stmpe-adc: Reinit completion struct on begin conversion
Date:   Tue,  7 May 2019 16:36:12 +0200
Message-Id: <20190507143615.28477-2-dev@pschenker.ch>
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

In some cases, the wait_completion got interrupted. This caused the
error-handling to mutex_unlock the function. The before turned on
interrupt then got called anyway. In the ISR then completion() was
called causing wrong adc-values returned in a following adc-readout.

Reinitialise completion struct to make sure the counter is zero
when beginning a new adc-conversion.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 drivers/iio/adc/stmpe-adc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index 9ec338ba3440..b3872eb37293 100644
--- a/drivers/iio/adc/stmpe-adc.c
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -65,6 +65,8 @@ static int stmpe_read_voltage(struct stmpe_adc *info,
 
 	mutex_lock(&info->lock);
 
+	reinit_completion(&info->completion);
+
 	info->channel = (u8)chan->channel;
 
 	if (info->channel > STMPE_ADC_LAST_NR) {
@@ -105,6 +107,8 @@ static int stmpe_read_temp(struct stmpe_adc *info,
 
 	mutex_lock(&info->lock);
 
+	reinit_completion(&info->completion);
+
 	info->channel = (u8)chan->channel;
 
 	if (info->channel != STMPE_TEMP_CHANNEL) {
-- 
2.21.0

