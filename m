Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C301505E6C
	for <lists+linux-iio@lfdr.de>; Mon, 18 Apr 2022 21:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240785AbiDRTYJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Apr 2022 15:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347671AbiDRTYJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2022 15:24:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A0235A8F
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 12:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92873B81087
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 19:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C11C385A1;
        Mon, 18 Apr 2022 19:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309687;
        bh=JBJI2t4VOKygfU39t9hABHDoUygqi0pLsW0/zNUrv7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzN24LMuKdY79hJK4fhLYDGEEqpZ/qDIoQ0+lIufpzA0lGhxhXzv99KmrNeiS+00A
         mVxNzSvo7ikxGLzsQgRMhY/lG1cjXokwUbfX4z0kJDfy8pXJxYfY9KH4PTyvq+OmML
         4fgn7dAY7uVnIyuh6xjgw2QC+fqp6Wplgfgoum6hnOd6N19icRTkFdmFLD3Io67S4T
         cXJkPHM4OQnPOYeU7Uyuqo8PP+5X/bFb3EOWTkMPzol2u2XK5KZxsdkkKCCMmBQYc5
         KQzttLHdcsjXp0JUTe5Knm+lfdjoEAwCuQVU8YEmt78uHj31bbSsknk1YadNjDVo6P
         FC4tAODhveQJg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 09/17] staging: iio: cdc: ad7746: Drop usused i2c_set_clientdata()
Date:   Mon, 18 Apr 2022 20:28:59 +0100
Message-Id: <20220418192907.763933-10-jic23@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418192907.763933-1-jic23@kernel.org>
References: <20220418192907.763933-1-jic23@kernel.org>
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
index bbb7b7db48a2..f6b54e817973 100644
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
2.35.3

