Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA5C678925
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jan 2023 22:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjAWVEt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Jan 2023 16:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjAWVEs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2023 16:04:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A7838038;
        Mon, 23 Jan 2023 13:04:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADEB8B80E3F;
        Mon, 23 Jan 2023 21:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC590C4339B;
        Mon, 23 Jan 2023 21:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674507880;
        bh=B+qp4Bg0ckQ1EeHpNrnKDGWpfd3LdqaTfOttRJJrPgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IpA+rARNa9lf8MdJYKMFMJIMjUd7MANNfz2AKQUNB76zH4l+ZyPYqrE+UgyuElwNk
         dfSnj5oPAD3v1BKLkOiwdZ88TMpbk4l2RTMLxWlRFlZ4ctGL+0SqvGPcRzVWmhs/SK
         0H9l9jqGJDjmiAAkvbBgwJM04YlYkwG5beQW3Touyuxdqz25ZsTNc/kUio6HvVe3Of
         esrJ+JpCWmKVOihuZDnQjeN1Vw1E19jDQzGQV/bV0gJQWOZrbgUQrxSqpimSPBvWji
         UYfGeHUPs7QHTepukFxTPpHQFS98bq6y21V7qOnVxYJMrEH4BT4tEWikrTpNg68jPZ
         1/c5vbonQ+ixw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH 09/12] staging: iio: accel: adis16203: Drop setting drvdata as nothing gets it
Date:   Mon, 23 Jan 2023 21:17:55 +0000
Message-Id: <20230123211758.563383-10-jic23@kernel.org>
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

As commented, it is only useful for .remove() which doesn't exist, so
drop setting it and the comment.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/accel/adis16203.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 20e9c9eb9436..9915b73454d2 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -187,8 +187,6 @@ static int adis16203_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
-	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->name = "adis16203";
 	indio_dev->channels = adis16203_channels;
-- 
2.39.1

