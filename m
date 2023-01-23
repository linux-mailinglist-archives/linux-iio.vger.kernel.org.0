Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AFD678914
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jan 2023 22:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjAWVE1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Jan 2023 16:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjAWVE0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2023 16:04:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCB130B10;
        Mon, 23 Jan 2023 13:04:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE5876104A;
        Mon, 23 Jan 2023 21:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B80C433EF;
        Mon, 23 Jan 2023 21:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674507864;
        bh=48D1qji7MQQv0UQXB018g3Ske4Yx09paEJnj8pvmczs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DwXPKOQkhmry9nwtI/DNz93nrhgCbj64gR7CFIYUc0QO6UCyOeR2nD7349ozTwG/p
         n9cZ3ZH6IaK7az7Zdd7QhzjVxStfwoR8uZvMG+xsWVCGkvWOjiEfVWxzi7ouEAOzPk
         o0ozEl61ceFvnALdx9hhtN1xoiZax/PCU0oRnlWG+WFUYjqDj+WfPu9pvUtxdU9WCZ
         xt+RX+kHtVoP4kS3YJMq22zD1pXH4s/R9Y9k0q658eiF9zTfYmW4v5nfhgVx3grzCP
         vt1hUVmqmgRcAsbl0Zi1C65zfadERK3cXkplkeOC7gCJ7xZAP0GbVRVgKlpmwc/cSF
         6a8FhO6EHrvtQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH 01/12] staging: iio: accel: adis16203: More conventional header ordering
Date:   Mon, 23 Jan 2023 21:17:47 +0000
Message-Id: <20230123211758.563383-2-jic23@kernel.org>
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

A common practice in IIO drivers it to have the headers in
alphabetical order with the exception of the more specific IIO
headers which come in their own block at the end.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/accel/adis16203.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index c0e4c9266b5f..dd02ceb00d40 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -6,14 +6,13 @@
  */
 
 #include <linux/device.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/imu/adis.h>
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 
+#include <linux/iio/iio.h>
+#include <linux/iio/imu/adis.h>
+
 #define ADIS16203_STARTUP_DELAY 220 /* ms */
 
 /* Flash memory write count */
-- 
2.39.1

