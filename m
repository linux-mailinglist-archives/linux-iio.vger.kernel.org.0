Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E6D4AC226
	for <lists+linux-iio@lfdr.de>; Mon,  7 Feb 2022 15:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359470AbiBGO5N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Feb 2022 09:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiBGOiq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2022 09:38:46 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B592C0401C1
        for <linux-iio@vger.kernel.org>; Mon,  7 Feb 2022 06:38:46 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 923E1100010;
        Mon,  7 Feb 2022 14:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644244724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cD+i9Sik7pIq3smtTLXXoNoDwZTqtQUA8nsay+jzZKI=;
        b=km6mdKs9Qr/73F7U3a4uDtrhzfBrZD9wqCPuXN9v97ST9vub2oH3LHPPvQVtZ1EAbTqaMm
        pTXmtQ/WE95Jq6vmqsLZTJaIp5Orcm7LVh7rjuejA8batzj+T4ZBxoY3KHrruEcAeMfDIX
        Qi7ub32i7hBMjgsWsYpVDK7UcAnUgLm+cJNSk2sFFvFF47cJzhoUPtbTtkSpg7dmuTZzWg
        k0I46SRVZooQWRPbeQOtEYkYzkp91bBae6kqDH4rWefYHKTQ5MfgwRWwe6ls7p/2YFGk3V
        gScR08R+GhO9Lud0wTr9BRsYnKt2R08zEkgTnJZVo3d7lOPIUM5U4tRJtJ/f0w==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v3 03/13] iio: adc: stm32-dfsdm: Avoid dereferencing ->currentmode
Date:   Mon,  7 Feb 2022 15:38:30 +0100
Message-Id: <20220207143840.707510-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220207143840.707510-1-miquel.raynal@bootlin.com>
References: <20220207143840.707510-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is an internal variable of the core, let's use the
iio_buffer_enabled() helper which is exported for the following purpose:
telling if the current mode is a buffered mode, which is precisely what
this driver looks for.

Cc: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 1cfefb3b5e56..a3b8827d3bbf 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -466,8 +466,7 @@ static int stm32_dfsdm_channels_configure(struct iio_dev *indio_dev,
 	 * In continuous mode, use fast mode configuration,
 	 * if it provides a better resolution.
 	 */
-	if (adc->nconv == 1 && !trig &&
-	    (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)) {
+	if (adc->nconv == 1 && !trig && iio_buffer_enabled(indio_dev)) {
 		if (fl->flo[1].res >= fl->flo[0].res) {
 			fl->fast = 1;
 			flo = &fl->flo[1];
@@ -562,7 +561,7 @@ static int stm32_dfsdm_filter_configure(struct iio_dev *indio_dev,
 		cr1 = DFSDM_CR1_RCH(chan->channel);
 
 		/* Continuous conversions triggered by SPI clk in buffer mode */
-		if (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)
+		if (iio_buffer_enabled(indio_dev))
 			cr1 |= DFSDM_CR1_RCONT(1);
 
 		cr1 |= DFSDM_CR1_RSYNC(fl->sync_mode);
-- 
2.27.0

