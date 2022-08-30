Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9905A6CC6
	for <lists+linux-iio@lfdr.de>; Tue, 30 Aug 2022 21:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiH3THw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Aug 2022 15:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiH3THw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Aug 2022 15:07:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D96726A4
        for <linux-iio@vger.kernel.org>; Tue, 30 Aug 2022 12:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41FFDB81D89
        for <linux-iio@vger.kernel.org>; Tue, 30 Aug 2022 19:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3946BC433D7;
        Tue, 30 Aug 2022 19:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661886469;
        bh=cnvIvgEyuItWFNNkOLX/DGI9r6ZQLOYG3GPvRG1pF/c=;
        h=From:To:Cc:Subject:Date:From;
        b=LgeA5IJGdMypG3iWQ5XuMGTJyxVgKwIjjTzeAnHQhmRnIss62ytbxnUJKj/Xl4L8x
         t4lHAni+qwyu0qlPYq/oySxvBAtNluZYCkqooY/quvtxOTp+OdKQ1lxPWTiKNbWLER
         ViZqTjYsYIh81qaoUWgQW7QCCjq+A5UFl0fhmzmZF20MWZc//s/IT3NCMewLO1VsPd
         1l2ZayoUZL3j+WIZ7/plkU7pUVzlJD1Pm6nnEDnVLjgUDrSpXr6HOuQdArZ+6H4Unu
         7vQdOmHWPj4+19oqtE0LiYiNzMEbt8Hfey+lDMvc5+pYe2m6FT1KvM7F4bpdlcr8Gq
         yar8vmmIqdMrA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio: cdc: ad7746: Suppress false uninitialized value warning.
Date:   Tue, 30 Aug 2022 19:33:25 +0100
Message-Id: <20220830183325.2641490-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
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

Fix warning:
drivers/iio/cdc/ad7746.c:336:14: warning: use of uninitialized value '<unknown>' [CWE-457] [-Wanalyzer-use-of-uninitialized-value]
reported on linux-next.  The compiler can't see into the implementation
of kstrtobool() to identify that the if (ret < 0) condition is
sufficient to detect cases where this parameter is not initialized.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/cdc/ad7746.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
index b266f5328140..5a3863bcaac9 100644
--- a/drivers/iio/cdc/ad7746.c
+++ b/drivers/iio/cdc/ad7746.c
@@ -333,7 +333,7 @@ static inline ssize_t ad7746_start_calib(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7746_chip_info *chip = iio_priv(indio_dev);
 	int ret, timeout = 10;
-	bool doit;
+	bool doit = false;
 
 	ret = kstrtobool(buf, &doit);
 	if (ret < 0)
-- 
2.37.2

