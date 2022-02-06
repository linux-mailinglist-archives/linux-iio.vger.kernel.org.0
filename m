Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546444AB182
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346009AbiBFS56 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243944AbiBFS56 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:57:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1CBC043186
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:57:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DCAEB80E63
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18C0C340EF;
        Sun,  6 Feb 2022 18:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173875;
        bh=4NSifC6bHz77jMV5LmnqiqkwnvOmKbsrD8jE/vVwFHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oY/4Ob3CzDlSpZpcjWMpOE43Eeu3VH/fmwK8ndV3PHsM+PNWu1JfiIdUPDCOnO1WA
         p7PpLsMZEaaeOHiihogdaSYdWXh48RAU8EnSHegDPztgYpYBmbp/JzKt9xTovd7+Pu
         XdGuKl3/vcialVvrePq/fQGhSKusg1AYUN1RuZATbBlVPdLb8uZmOq1c6iT55gH0Jb
         WtEb1iO28UzQV0xochfEgYtGWZJubzkgSK6FjZ7QZWB40vtg0JQplvUa6IrcMCzWDv
         6z7IvNEx/Q27MdlsIZwtdXnFnEw5qLULx+nlroq4F2qvvQ5SwaxVQp7b696qoWNrFS
         QWXjUA29GJsKQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 15/20] staging:iio:adc:ad7280a: Drop buggy support for early termination of AUX alert.
Date:   Sun,  6 Feb 2022 19:03:23 +0000
Message-Id: <20220206190328.333093-16-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206190328.333093-1-jic23@kernel.org>
References: <20220206190328.333093-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This functionality is intended to allow for a few temperature
sensors to be missing (and hence not worth reading) on the final
device in a chain.  The ones removed are 3 and 5 (unlike for
the ADC channels where it is 4 and 5).

The datasheet includes a foot note 3 to Table 12 that makes this complex
to support.

"(3) To remove AUX5 or AUX5 and AUX3 from the alert detection, conversions
on three auxiliary ADC input channels only must be selected in the
control register."

This mode has never been supported by the driver.

As this support would be complex to add and the rework is being done
against a QEMU model developed for the purposes of verifying nothing
is broken, it is better to drop this support for now.

Reported-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index e8c9f22971cb..a32c32a1226a 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -1022,28 +1022,6 @@ static int ad7280_probe(struct spi_device *spi)
 			break;
 		}
 	}
-	if (device_property_present(dev, "adi,temp-alert-last-chan")) {
-		u32 val;
-
-		ret = device_property_read_u32(dev, "adi,temp-alert-last-chan", &val);
-		if (ret)
-			return ret;
-
-		switch (val) {
-		case 3:
-			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_AUX3_AUX5;
-			break;
-		case 4:
-			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_AUX5;
-			break;
-		case 5:
-			break;
-		default:
-			dev_err(dev,
-				"Firmware provided last temp alert channel invalid\n");
-			break;
-		}
-	}
 	crc8_populate_msb(st->crc_tab, POLYNOM);
 
 	st->spi->max_speed_hz = AD7280A_MAX_SPI_CLK_HZ;
-- 
2.35.1

