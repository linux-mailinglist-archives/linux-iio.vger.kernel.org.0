Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5396F4AC211
	for <lists+linux-iio@lfdr.de>; Mon,  7 Feb 2022 15:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiBGO46 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Feb 2022 09:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237317AbiBGOiq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2022 09:38:46 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F78C0401C2
        for <linux-iio@vger.kernel.org>; Mon,  7 Feb 2022 06:38:44 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6D58010000A;
        Mon,  7 Feb 2022 14:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644244723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TawdqjX7BEkznrUMkUPTanTqZyIkwauouY0To3CdU2s=;
        b=IRk3yVLSOWB7iFl68cInmVeAgHQZWL+aGqe5pyYjG7cDkzere+vQZ8J0S/ywGLlXyQB0IW
        BF5cNvDPL481uIprrXrrB5UdpciA/78kPW3JD3FTJOHJ/8m1K2GRzPER3KqAAZ1HtpwgFh
        4e3BS/HFigL2IrFSuZrK103ed1aQfivVsI1Gtis6C9sahlhllM9DU7KdwrwgRl2aVRA83+
        HUPJHR3j25Mem+SIF1eP72W5fYWS/usv5JH8TXTdBHTnST2lVjao59RPEGxeGOA9nLNPIK
        wuGRjO7NSZRsqF1Act42lO7sRVkdDVJ0UQ74VvRNwpbahGUjeXZ7lhmwaCMZXw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v3 02/13] iio: magnetometer: rm3100: Stop abusing the ->currentmode
Date:   Mon,  7 Feb 2022 15:38:29 +0100
Message-Id: <20220207143840.707510-3-miquel.raynal@bootlin.com>
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

This is an internal variable for the core, here it is set to a "default"
value by the driver in order to later be able to perform checks against
it. None of this is needed because this check actually cares about the
buffers being enabled or not. So it is an unproper side-channel access
to the information "are the buffers enabled?", returned officially by
the iio_buffer_enabled() helper. Use this helper instead.

Cc: Song Qiang <songqiang1304521@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/magnetometer/rm3100-core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 13914273c999..be0057f82218 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -141,18 +141,10 @@ static irqreturn_t rm3100_irq_handler(int irq, void *d)
 	struct iio_dev *indio_dev = d;
 	struct rm3100_data *data = iio_priv(indio_dev);
 
-	switch (indio_dev->currentmode) {
-	case INDIO_DIRECT_MODE:
+	if (!iio_buffer_enabled(indio_dev))
 		complete(&data->measuring_done);
-		break;
-	case INDIO_BUFFER_TRIGGERED:
+	else
 		iio_trigger_poll(data->drdy_trig);
-		break;
-	default:
-		dev_err(indio_dev->dev.parent,
-			"device mode out of control, current mode: %d",
-			indio_dev->currentmode);
-	}
 
 	return IRQ_WAKE_THREAD;
 }
@@ -377,7 +369,7 @@ static int rm3100_set_samp_freq(struct iio_dev *indio_dev, int val, int val2)
 			goto unlock_return;
 	}
 
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+	if (iio_buffer_enabled(indio_dev)) {
 		/* Writing TMRC registers requires CMM reset. */
 		ret = regmap_write(regmap, RM3100_REG_CMM, 0);
 		if (ret < 0)
@@ -553,7 +545,6 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	indio_dev->channels = rm3100_channels;
 	indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
-	indio_dev->currentmode = INDIO_DIRECT_MODE;
 
 	if (!irq)
 		data->use_interrupt = false;
-- 
2.27.0

