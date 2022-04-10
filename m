Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11C74FAE7C
	for <lists+linux-iio@lfdr.de>; Sun, 10 Apr 2022 17:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240177AbiDJP1n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Apr 2022 11:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiDJP1m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2022 11:27:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886A43152B
        for <linux-iio@vger.kernel.org>; Sun, 10 Apr 2022 08:25:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D7D561022
        for <linux-iio@vger.kernel.org>; Sun, 10 Apr 2022 15:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B3AC385A4;
        Sun, 10 Apr 2022 15:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649604330;
        bh=OtM2Y1/lFvGPddwWauqUeSf4/A6bJ3UaB9Dzaio25xQ=;
        h=From:To:Cc:Subject:Date:From;
        b=LjPRT8JnepgCsDzywJa/zcY9adGsjJPaV586X5MkXeeDb9eWY+W/UpLyg7VaUdSOn
         kCGckgcca7zuhvOHJKVrrhgXWxFt0MAk5SvlIse/G9OBEjtUeUXS1Lm0MEZgMjQZ+8
         9XPQflbTKJJZgGVekCWHM9OvC4SshFq5fOjovAbFHYfmBhGc4+rXnYXaNOn8sIAAx0
         orQ8Y4Gnv712diDMVApS+cEXPIKiVLFR4Ffsnu3f4cdxHL2PKH4P4hAqLzMbwrHutS
         Q7Zy230E1QXSLZ8U2jU3AGi5RRZ2QZk/K27joB4CyYPJdJHud/nT77tJZ9ZjzOPMpI
         qvvszk0C6GGvg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] iio: accel: mma8452: Add missing documentation for name element of chip_info
Date:   Sun, 10 Apr 2022 16:33:17 +0100
Message-Id: <20220410153317.290896-1-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Documentation needed to avoid build warning with W=1 builds. It doesn't
really add any non obvious information but good to have it anyway.

No fixes tag as not worth backporting onto the fix that added the name
element to the structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/mma8452.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 9c02c681c84c..912a447e6310 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -166,6 +166,7 @@ static const struct mma8452_event_regs trans_ev_regs = {
 
 /**
  * struct mma_chip_info - chip specific data
+ * @name:			part number of device reported via 'name' attr
  * @chip_id:			WHO_AM_I register's value
  * @channels:			struct iio_chan_spec matching the device's
  *				capabilities
-- 
2.35.1

