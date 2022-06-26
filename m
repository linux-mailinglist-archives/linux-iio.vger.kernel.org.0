Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01EB55B1DB
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 14:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbiFZMUq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 08:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiFZMUp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 08:20:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382FAE029
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 05:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECC8DB80D8D
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 12:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215F9C341CA;
        Sun, 26 Jun 2022 12:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656246042;
        bh=X83Z1/x93SZy4VMlZhofrz/IRvGn938xCzPYMDzqeH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tA/811Gj+1n/7RiBL7+L3HgdcdgqaA5YW1BnAOR4jw6jeAOVCuj4fHc7lIj6+2LF4
         FvRp+3eMzRw42K2Mm/h/wYa7hIfVa0r8RJTmchRPptIvMQzt9XkwYrcnqWqYS2Iena
         T+zkGBUFZiRyyqzoGQMk9wD9r6GsQ5l83QuKraTdLxMZ3qi2nso4dggZ9/r8737FMd
         kzpY5Aqw4o+VjWtVRFH0nH0/HS2kmkIFpuqi6q3H2yNZ4qeH33+RjHpBA3VUs7V0ZM
         0SfBVUs5AG0v3LbZNk5z8wLA5DOPwl/PVTUXhKRiacaQH80j80tbt+m055Ekz3DLTv
         ktDxFotCwd8TA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 09/17] staging: iio: cdc: ad7746: Drop unused i2c_set_clientdata()
Date:   Sun, 26 Jun 2022 13:29:30 +0100
Message-Id: <20220626122938.582107-10-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626122938.582107-1-jic23@kernel.org>
References: <20220626122938.582107-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index fa16522221aa..c574bc1c7d3d 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -708,8 +708,6 @@ static int ad7746_probe(struct i2c_client *client,
 		return -ENOMEM;
 	chip = iio_priv(indio_dev);
 	mutex_init(&chip->lock);
-	/* this is only used for device removal purposes */
-	i2c_set_clientdata(client, indio_dev);
 
 	chip->client = client;
 	chip->capdac_set = -1;
-- 
2.36.1

