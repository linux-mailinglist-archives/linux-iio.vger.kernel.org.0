Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D677A772FE4
	for <lists+linux-iio@lfdr.de>; Mon,  7 Aug 2023 21:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjHGTvW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Aug 2023 15:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjHGTvV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Aug 2023 15:51:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFA8172A
        for <linux-iio@vger.kernel.org>; Mon,  7 Aug 2023 12:50:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0626961F95
        for <linux-iio@vger.kernel.org>; Mon,  7 Aug 2023 19:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0D3C433C7;
        Mon,  7 Aug 2023 19:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691437856;
        bh=zgkIJrhOa8rgUvqiVhd/EfQLmFmpL3o8U7Vuk+laMr8=;
        h=From:To:Cc:Subject:Date:From;
        b=aX/rVDlJdnV3SJ8Bs/0IU+oWcwUuV+47excvm1M/ibzpj/Ek3tBrwA/0t9KNDqO3M
         sBkS4mfBsGki59EZmzUc9vCwUm62Jsbze85LMBatOjrcqHUkI41WeB4Fi3v7FCR7im
         x+wQDyl1E9S6XTSePnp6Z7Dhkq4k1kWFUmb6vYVmR2J40ZyXdODj9XBBPoIr7Ht4YP
         f/6VfT5fCf8+3EvCb1uCqkawEQmPHKrDVfNeYYv6COFS4LNVtBdNoKRTiCIeeqZbyi
         86G2d0q+pyQrrxxEyeRoy1zjj282w/1UUdeNuJMhr1l7fl5Q/c5wWsd6Ozihm29GGN
         sEjpA+e0q+gvA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel test robot <lkp@intel.com>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Subject: [PATCH] iio: light: opt4001: Fix a wrong array iteration limit
Date:   Mon,  7 Aug 2023 20:50:43 +0100
Message-ID: <20230807195043.200767-1-jic23@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In practice it's unlikely anyone would try to set the integration time
to 0 which isn't in the available list and if they did then they would
get index 12 which whilst reserved on the device fits in the field.
However a compiler might get half way through this reasoning and that
might be the cause of

> >> drivers/iio/light/opt4001.c:215:9: error: call to '__compiletime_assert_355' declared with 'error' attribute: FIELD_PREP: value too large for the field
>      215 |         reg |= FIELD_PREP(OPT4001_CTRL_CONV_TIME_MASK, chip->int_time);

Even if this isn't the cause, it looks like a bug to me.

Fixes: 9a9608418292 ("iio: light: Add support for TI OPT4001 light sensor")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308061902.0gVz6bSe-lkp@intel.com/
Cc: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/opt4001.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index 502946bf9f94..83f978706758 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -137,7 +137,7 @@ static int opt4001_als_time_to_index(const u32 als_integration_time)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(opt4001_int_time_available); i++) {
+	for (i = 0; i < ARRAY_SIZE(opt4001_int_time_available) / 2; i++) {
 		if (als_integration_time == opt4001_int_time_available[i][1])
 			return i;
 	}
-- 
2.41.0

