Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E281550CAD
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 21:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiFSS7c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiFSS7T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 14:59:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF62BC8E
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 11:59:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA455B80D8C
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 18:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4898FC3411D;
        Sun, 19 Jun 2022 18:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655665156;
        bh=HxB9OxLijvg7ULeW/hcJOYTO/PYugd9fkq3/piyxHxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QR413PzzxpBHjWk+/dllhWDQZsl4qgSf1DF3LnqK9mMyAFJnNB6Rt0nsu9RWZEQ7c
         yh3RbScyCief6JiL+YIsFqRkVX/zJPkVNzGp+kUFRyIjpfglARxh9EsECfXX7UPags
         juLv0pV23TiykqzHa+40qcR6BXhdxJ7MDgf20RrJF6MaSdH2oQR2GQW+BUD++CpBgj
         iI7NxhpE/oa3OE4qgbrDOFfmtIDxZMnTengmW33GoRO99+mz2KgBiMHhAiGiQDs/Vk
         UwwEKqbwHrZHh6asMZ9M0jMVvgPCk5XqsoWWYjPr02iSB2FKtdTW8bsAgMi4KIdy//
         2oHhdUEJr5ueg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 09/17] staging: iio: cdc: ad7746: Drop usused i2c_set_clientdata()
Date:   Sun, 19 Jun 2022 19:58:31 +0100
Message-Id: <20220619185839.1363503-10-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220619185839.1363503-1-jic23@kernel.org>
References: <20220619185839.1363503-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As the comment states, this was only used in remove() and now
there is no explicit remove() function to make use of it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index a1b0a440728f..7eaffb90e8c3 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -706,8 +706,6 @@ static int ad7746_probe(struct i2c_client *client,
 		return -ENOMEM;
 	chip = iio_priv(indio_dev);
 	mutex_init(&chip->lock);
-	/* this is only used for device removal purposes */
-	i2c_set_clientdata(client, indio_dev);
 
 	chip->client = client;
 	chip->capdac_set = -1;
-- 
2.36.1

