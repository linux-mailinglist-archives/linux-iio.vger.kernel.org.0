Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C125166ACED
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jan 2023 18:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjANRP4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Jan 2023 12:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjANRPz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2023 12:15:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36F646BB
        for <linux-iio@vger.kernel.org>; Sat, 14 Jan 2023 09:15:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DFBB60BC1
        for <linux-iio@vger.kernel.org>; Sat, 14 Jan 2023 17:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA852C433D2;
        Sat, 14 Jan 2023 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673716553;
        bh=Z4CUb9Wc9SyTLKeH3Dio5eVSdB7/0NkXdVrPSc6jwiQ=;
        h=From:To:Cc:Subject:Date:From;
        b=lm0mS2EK0Ox7W7idER5cwBiAFNEn5WvTQ9mOKmOomoPlba+zqaJh5WrtHwVP1Tx2B
         zMAGGxHcFgxilhLwNSZwCKqLI+I7GNXUTBtfS2etYywd0tfw2KKwyq5szDF5sLelLs
         AVoZM+DyDt3eXQRj8HyDCzWUnmz1U3GWFz6IIhflIYkFTGOrS99q5FhAOsbxhjH5jn
         iPromnetFVikCgFRoCgB3ewidzAqfUJWua0I64MT7G7NUzeEdXeq84DH9n71FPBEEP
         1uzlld1vulXBpGRzl6QhWzU86naxmoVEtm1AvS2w6lmi4ibhfmpxmj22Ett5EBvbz8
         wfebhSr3XAdlQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH] iio: proximity: sx_common: Drop documentation of non existent struct element.
Date:   Sat, 14 Jan 2023 17:29:28 +0000
Message-Id: <20230114172928.80414-1-jic23@kernel.org>
X-Mailer: git-send-email 2.39.0
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

struct sx_common_data doesn't have a num_default_regs element so
drop the documentation for it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx_common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/proximity/sx_common.h b/drivers/iio/proximity/sx_common.h
index a706f4060978..a3335259bcf7 100644
--- a/drivers/iio/proximity/sx_common.h
+++ b/drivers/iio/proximity/sx_common.h
@@ -107,7 +107,6 @@ struct sx_common_chip_info {
  * @regmap:		Register map.
  * @acpi_id:		ACPI device entry when the device is using APCI, NULL
  *			otherwise.
- * @num_default_regs:	Number of default registers to set at init.
  * @chan_prox_stat:	Last reading of the proximity status for each channel.
  *			We only send an event to user space when this changes.
  * @trigger_enabled:	True when the device trigger is enabled.
-- 
2.39.0

