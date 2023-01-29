Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F5A67FFF5
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jan 2023 16:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjA2PmV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Jan 2023 10:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjA2PmU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2023 10:42:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC30812870;
        Sun, 29 Jan 2023 07:42:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73DBD60C6D;
        Sun, 29 Jan 2023 15:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C21C433AF;
        Sun, 29 Jan 2023 15:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675006938;
        bh=SwYXs9I2ta5OOSwgF/OPkPmKgovgrvcG9ebNwU0ipZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=irruQ4HVQU/Se0RhzA6X29YhfBt867rGRmxvhpLt+5pLMZq9JbuTav4mDY4bKFOe3
         RjDPQHUgjV5bwwf05mIAg74ZOyVOwy2cqYAzC/THLmflWlDc/Q1V0BG4ZyRIFc4dv4
         A0xn7UQXg9Qa6VOKJ+mUeNlOXoDR6wjl6iuHnEwtdsHrnwdcGV+U22PQAPGbQNs1G+
         kVkJtDv//LFa6tp0YDvyzyKHtGoIq8KtzAM/zM6QxveibRgl5m+gGSGBewIMW+VVuJ
         IPJftb8MFKWRgctPo4C4i3+t3syFPPwtGMLt+35YswOY7cxvqMkTAqM9qxDNBDWnvY
         3w62w9Pj/mgrA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 04/12] staging: iio: accel: adis16203: Drop the 180 degree offset channel
Date:   Sun, 29 Jan 2023 15:55:54 +0000
Message-Id: <20230129155602.740743-5-jic23@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129155602.740743-1-jic23@kernel.org>
References: <20230129155602.740743-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There is no standard ABI suitable for this channel, which is blocking
the graduation of this driver from staging. It provides no obvious
benefit over applying a -180 degree offset in software. So drop the
channel.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/accel/adis16203.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 8e5d1d2ea8e9..b59a003f3e26 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -59,7 +59,6 @@
 
 enum adis16203_scan {
 	 ADIS16203_SCAN_INCLI_X,
-	 ADIS16203_SCAN_INCLI_Y,
 	 ADIS16203_SCAN_SUPPLY,
 	 ADIS16203_SCAN_AUX_ADC,
 	 ADIS16203_SCAN_TEMP,
@@ -140,11 +139,8 @@ static const struct iio_chan_spec adis16203_channels[] = {
 	ADIS_AUX_ADC_CHAN(ADIS16203_AUX_ADC, ADIS16203_SCAN_AUX_ADC, 0, 12),
 	ADIS_INCLI_CHAN(X, ADIS16203_INCL_OUT, ADIS16203_SCAN_INCLI_X,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	/* Fixme: Not what it appears to be - see data sheet */
-	ADIS_INCLI_CHAN(Y, ADIS16203_INCL_OUT_180, ADIS16203_SCAN_INCLI_Y,
-			0, 0, 14),
 	ADIS_TEMP_CHAN(ADIS16203_TEMP_OUT, ADIS16203_SCAN_TEMP, 0, 12),
-	IIO_CHAN_SOFT_TIMESTAMP(5),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
 static const struct iio_info adis16203_info = {
-- 
2.39.1

