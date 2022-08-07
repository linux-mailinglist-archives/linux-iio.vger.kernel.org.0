Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ADB58BB50
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 16:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiHGOos (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 10:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiHGOor (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 10:44:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81289FED
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 07:44:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9455BB80AB2
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 14:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68982C433D6;
        Sun,  7 Aug 2022 14:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659883484;
        bh=emMXobQHAjaV81zlCKMJm3uqmqTVUkg6kDRbBjwc7jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cePllcOUsfNe7jxDmxz1XR4KIEIOcY1eoaU9Xht0eVcCyWcfd0XpoSUUUuVxgsq6b
         PVvppblY0lrdQFakDgaB1D3rkMgVUXRfuujZSVAum+YqJg2OcDvHQz/FUZLj9hrexB
         8Du5+f8i+ZYF4YZT96B0eTx1rbAMoNsk7gWS0YBLVJRi5CGsO0FkklbfGKP3r4qy9Y
         sSm/ckux44RbtBvJJeKzrkyJ3+/EsJca42TTjDmt1gY/EtW8eipOHCRJtYOaCdHgJI
         r8xhsGAz13m5GQ2zbouSV4zi2hti1uWfx65OGLLQW0Dkk774SEtFg7HUR0BkE5qZV1
         f6Zyypr4n8g6g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/2] iio: light: cm32181: Mark the dev_pm_ops static.
Date:   Sun,  7 Aug 2022 15:54:57 +0100
Message-Id: <20220807145457.646062-3-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807145457.646062-1-jic23@kernel.org>
References: <20220807145457.646062-1-jic23@kernel.org>
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

Only accessed from the local file.
Warning:
  drivers/iio/light/cm32181.c:508:1: warning: symbol 'cm32181_pm_ops' was not declared. Should it be static?

Fixes: 68c1b3dd5c48 ("iio: light: cm32181: Add PM support")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/iio/light/cm32181.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index edbe6a3138d0..001055d09750 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -505,7 +505,7 @@ static int cm32181_resume(struct device *dev)
 					 cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
 }
 
-DEFINE_SIMPLE_DEV_PM_OPS(cm32181_pm_ops, cm32181_suspend, cm32181_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(cm32181_pm_ops, cm32181_suspend, cm32181_resume);
 
 static const struct of_device_id cm32181_of_match[] = {
 	{ .compatible = "capella,cm3218" },
-- 
2.37.1

