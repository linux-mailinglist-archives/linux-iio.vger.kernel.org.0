Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4B94B457F
	for <lists+linux-iio@lfdr.de>; Mon, 14 Feb 2022 10:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242738AbiBNJTE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Feb 2022 04:19:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242452AbiBNJTE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Feb 2022 04:19:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CC4B606E8
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 01:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644830336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AsxyZOgufzk8HpMLNICOi8wJ4CMKP8C9MplVo5OUilM=;
        b=CTzKL8DVgTh2kemtstM7n3/PLAseoWoA4dVXz4O10z7HgXwpQvaug7ttD6umaBB9UKI5XG
        Wr1c+9hmEMLGO23EecP4sf9BmDgpcfwDnq/NPQcVyR+843OZFoMxunGaWK6Tja8Lya4s+I
        IMgjl2rEhKuYLI/5D2VJVkcc2yP5a1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-ZNpaTmvOOGaS0sg1BURtMw-1; Mon, 14 Feb 2022 04:18:54 -0500
X-MC-Unique: ZNpaTmvOOGaS0sg1BURtMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B86A1091DA1;
        Mon, 14 Feb 2022 09:18:53 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.195.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B34A860C25;
        Mon, 14 Feb 2022 09:18:51 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: mma8452: Fix 'mma8452_dt_ids' defined but not used compiler warning
Date:   Mon, 14 Feb 2022 10:18:50 +0100
Message-Id: <20220214091850.44139-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Commit 90adc57bd55a ("iio: mma8452: Fix probe failing when an
i2c_device_id is used") introduces a new: "'mma8452_dt_ids' defined
but not used" compiler warning.

This is caused by the switch from of_match_device() (which takes a
pointer to this) to device_get_match_data(), combined with the use of
of_match_ptr() when setting of_match_table.

We actually want mma8452_dt_ids to get optmized away when CONFIG_OF is
not set, so mark it as __maybe_unused to silence the warning.

Fixes: 90adc57bd55a ("iio: mma8452: Fix probe failing when an i2c_device_id is used")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note the 90adc57bd55a hash is from the jic23/iio.git testing branch, not
sure of it is stable. It is probably best to just squash this into the
original commit.
---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 590d9431e1bd..1324bd515377 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1529,7 +1529,7 @@ static int mma8452_reset(struct i2c_client *client)
 	return -ETIMEDOUT;
 }
 
-static const struct of_device_id mma8452_dt_ids[] = {
+static const struct of_device_id __maybe_unused mma8452_dt_ids[] = {
 	{ .compatible = "fsl,mma8451", .data = &mma_chip_info_table[mma8451] },
 	{ .compatible = "fsl,mma8452", .data = &mma_chip_info_table[mma8452] },
 	{ .compatible = "fsl,mma8453", .data = &mma_chip_info_table[mma8453] },
-- 
2.33.1

