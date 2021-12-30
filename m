Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087DF481EB9
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241500AbhL3RoT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241509AbhL3RoT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:44:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ABBC061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 09:44:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB7B16173B
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A71C36AE7;
        Thu, 30 Dec 2021 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886258;
        bh=OkcMXqU2PKjdhhKcDgrrf/LBQMi/lh1QknOWib6iwHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WahFOhSWIq7PU9STYrgvrBPZNqQVVEuTytJTUAr3M58YcMxTGo/0PEDABxpclCDD1
         PSmAu9GhARgXL7Wvdm/OaH/buIBc/4r/5MnfPSJBaWkoI7QYD7mWME8z7HS87aFCSW
         OaZmSmH/wNumIT2wLbmNmsNDi7Qo+22nK/wmXE1ptb5Vo0VmEwZ+MrjGW3VaI+5h25
         yh3o1Sgr0LCHbW2j8p1Xp/Pc8FXge8IQppTQWs2rN1tCtJqlw0RMSerEVecOr8ljJs
         cWof0c/ZBMKlivsuegTg3CGfRc5d5JbQLmJorN5+xQCRy7rKHZ8McoF+UGV/T5Zd5+
         gBQXwPo09bUIA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 13/16] iio:adc:ti-adc084s021: Tidy up white space around {}
Date:   Thu, 30 Dec 2021 17:49:08 +0000
Message-Id: <20211230174911.78291-14-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230174911.78291-1-jic23@kernel.org>
References: <20211230174911.78291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Previously inconsistent with a space after { but not before }.
Tidy that up to avoid providing an example to copy into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/adc/ti-adc084s021.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index ce3f5a3814f9..c9b5d9aec3dc 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -248,7 +248,7 @@ static const struct of_device_id adc084s021_of_match[] = {
 MODULE_DEVICE_TABLE(of, adc084s021_of_match);
 
 static const struct spi_device_id adc084s021_id[] = {
-	{ ADC084S021_DRIVER_NAME, 0},
+	{ ADC084S021_DRIVER_NAME, 0 },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, adc084s021_id);
-- 
2.34.1

