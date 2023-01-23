Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7F3678919
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jan 2023 22:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjAWVEd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Jan 2023 16:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjAWVEb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2023 16:04:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E34838653;
        Mon, 23 Jan 2023 13:04:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD0C9610A2;
        Mon, 23 Jan 2023 21:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3C0C4339C;
        Mon, 23 Jan 2023 21:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674507868;
        bh=LbJlhf7egiClJvLuB5vqS0R+pxqtjvxQgKBOfISnhYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uitf8mPQ+K4JCogfdxzmGEwlBMft1Zp3tO3jCoVFu9grMReohLIqdz9YcjYz3FEPZ
         GyephBOyIhDGzZgCkcyuLgIjeuhfLkvtuMrTtxdx/zzWkDZ61bSfHnD7kV1etwFYSJ
         s2I3kM+JKK4ANNLZeFJyY0Q3arknEZYVsff3PcUQvxhblqPubVea1VsZMt9fHKlPap
         y+j4VS5IMT7YrciCppM0rhX2QDcoP1wx8xZ7bjIcXIBNlvsIGouHhtpoS88W6zH4B+
         rfv2Jv3mtOm0n1L6rWtifncZY5nLbrGNX1yLCX/PPMeUV4+29BWPS3qocX4aOh8JR5
         hJu29kurY0arA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH 03/12] staging: iio: accel: adis16203: Rename incli channel registers
Date:   Mon, 23 Jan 2023 21:17:49 +0000
Message-Id: <20230123211758.563383-4-jic23@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123211758.563383-1-jic23@kernel.org>
References: <20230123211758.563383-1-jic23@kernel.org>
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

This device has two such channels that are effectively reading the
same thing, just with a 180 degree offset.  First rename them
(later we will drop one of them as it is easier to apply an offset
in software).

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/accel/adis16203.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 60117aaf56d4..8e5d1d2ea8e9 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -19,8 +19,8 @@
 #define ADIS16203_SUPPLY_OUT     0x02
 #define ADIS16203_AUX_ADC        0x08
 #define ADIS16203_TEMP_OUT       0x0A
-#define ADIS16203_XINCL_OUT      0x0C
-#define ADIS16203_YINCL_OUT      0x0E
+#define ADIS16203_INCL_OUT       0x0C
+#define ADIS16203_INCL_OUT_180   0x0E
 #define ADIS16203_INCL_NULL      0x18
 #define ADIS16203_ALM_MAG1       0x20
 #define ADIS16203_ALM_MAG2       0x22
@@ -138,10 +138,10 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 static const struct iio_chan_spec adis16203_channels[] = {
 	ADIS_SUPPLY_CHAN(ADIS16203_SUPPLY_OUT, ADIS16203_SCAN_SUPPLY, 0, 12),
 	ADIS_AUX_ADC_CHAN(ADIS16203_AUX_ADC, ADIS16203_SCAN_AUX_ADC, 0, 12),
-	ADIS_INCLI_CHAN(X, ADIS16203_XINCL_OUT, ADIS16203_SCAN_INCLI_X,
+	ADIS_INCLI_CHAN(X, ADIS16203_INCL_OUT, ADIS16203_SCAN_INCLI_X,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
 	/* Fixme: Not what it appears to be - see data sheet */
-	ADIS_INCLI_CHAN(Y, ADIS16203_YINCL_OUT, ADIS16203_SCAN_INCLI_Y,
+	ADIS_INCLI_CHAN(Y, ADIS16203_INCL_OUT_180, ADIS16203_SCAN_INCLI_Y,
 			0, 0, 14),
 	ADIS_TEMP_CHAN(ADIS16203_TEMP_OUT, ADIS16203_SCAN_TEMP, 0, 12),
 	IIO_CHAN_SOFT_TIMESTAMP(5),
-- 
2.39.1

