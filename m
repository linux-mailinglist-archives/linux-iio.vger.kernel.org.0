Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA62355B2EB
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 18:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiFZQp4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 12:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiFZQpw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 12:45:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B018DFFD
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 09:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 767FC60C48
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 16:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DDCC341C7;
        Sun, 26 Jun 2022 16:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656261949;
        bh=nHu7Yp7CZ2tHvUgaPSxmi0PTkqnINCmbbl9RTphOu7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m0ixtDxVSp59vhMPk9TU11Seh3JL6YQW1hV7wAkni4iE4PLiwX1JPwFdi7hHitYSO
         JuJfxTbF4OTdIo0AqOADwu9GQJG0LknS23v8BFk2K/RLc0IxLhCSzjOMmNX5gDyQbN
         DhFHRV2HGJ8EZ5naMi2EpoeKWrLrjXI2/NqSPCs8pBKlxkXa1i/JU9vXnHsqzIhzBT
         XqZKO1EixAj8Dyxp2UGeCgG2OMCKYYgYZojItb4l14x18R1Iiyk5kw9Ej9+571Zv3z
         D6u81lIovjFLY2eHPIQL5o9US8S3Q2w4SKxIa/jeZm/TA41cJ99qnNzwNxBhgyVo3r
         z1ybsx+47zF2A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>
Subject: [PATCH 2/4] iio: ABI: max31865: Drop in_filter_notch_centre_frequency as in main docs.
Date:   Sun, 26 Jun 2022 17:55:09 +0100
Message-Id: <20220626165511.602202-3-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626165511.602202-1-jic23@kernel.org>
References: <20220626165511.602202-1-jic23@kernel.org>
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

As this is the last element in the file, also delete the file.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Navin Sankar Velliangiri <navin@linumiz.com>
---
 .../ABI/testing/sysfs-bus-iio-temperature-max31865        | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
deleted file mode 100644
index 349089e4f2d6..000000000000
--- a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
+++ /dev/null
@@ -1,8 +0,0 @@
-What:		/sys/bus/iio/devices/iio:deviceX/in_filter_notch_center_frequency
-KernelVersion:	5.11
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Notch frequency in Hz for a noise rejection filter. Used i.e for
-		line noise rejection.
-
-		Valid notch filter values are 50 Hz and 60 Hz.
-- 
2.36.1

