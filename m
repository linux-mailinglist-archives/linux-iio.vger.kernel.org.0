Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEE54AB186
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347243AbiBFS6I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243387AbiBFS6H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:58:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA255C06173B
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:58:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EFE361219
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCCEC340F1;
        Sun,  6 Feb 2022 18:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173886;
        bh=Z31BvjxBQtWJ09tXNp1ZeYtKM45/xMqhOclk4ozw6OQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GOhkKLXW1WImJbxU0tHvJyVo1hs2hgAisFjAXekNot7sowkMR8cz9qGYqoHpE3YSc
         CnKwnLRXG1vRlB1Etmo54o8kEwZupZQiwhLspEdaRlbelRWPo5x61LIqaYsaCO2PZf
         BhCkUqE+lGuUzACCoUdBoM4Ull8CRU06n9Izfoc4l51x8J23s4yAo9/12bJ65v0zTx
         Jlo4rG/CDnYZzoAaPXU6h7/JvGMOXUojwcX5gry7MMxRx13j8UMaXC5SiRGrxhDkSD
         sT0w65BcpIJtRpUz+9+saBi+Ndqvn1R4ddtfpkgYa8l+pBBlekYib653yvn77AMNbx
         Zd4+RRKy4H9dA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 19/20] staging:iio:adc:ad7280a: Use more conservative delays to allow 105C operation.
Date:   Sun,  6 Feb 2022 19:03:27 +0000
Message-Id: <20220206190328.333093-20-jic23@kernel.org>
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

The datasheet provides timings for operating this device at up to 105
degrees centigrade. Adopt these more conservative timings.

Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index a7e16144b013..ef9d27759961 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -137,7 +137,7 @@
 #define AD7280A_DEVADDR_ALL		0x1F
 
 static const unsigned short ad7280a_n_avg[4] = {1, 2, 4, 8};
-static const unsigned short ad7280a_t_acq_ns[4] = {465, 1010, 1460, 1890};
+static const unsigned short ad7280a_t_acq_ns[4] = {470, 1030, 1510, 1945};
 
 /* 5-bit device address is sent LSB first */
 static unsigned int ad7280a_devaddr(unsigned int addr)
@@ -869,7 +869,7 @@ static void ad7280_update_delay(struct ad7280_state *st)
 	 */
 
 	st->readback_delay_us =
-		((ad7280a_t_acq_ns[st->acquisition_time & 0x3] + 695) *
+		((ad7280a_t_acq_ns[st->acquisition_time & 0x3] + 720) *
 			(AD7280A_NUM_CH * ad7280a_n_avg[st->oversampling_ratio & 0x3])) -
 		ad7280a_t_acq_ns[st->acquisition_time & 0x3] + st->slave_num * 250;
 
-- 
2.35.1

