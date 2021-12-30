Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58F481EB8
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbhL3RoR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:44:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48898 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbhL3RoQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:44:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94C556173B
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB86DC36AEC;
        Thu, 30 Dec 2021 17:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886256;
        bh=9a1Dr+JaeaFig8GEgHh1o2WaJJtnhyYwDzi4OUJ+GJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFgcq4U7xzW2UBnP00oBz2AxCOEodRoAKw2syCD8PsyPnEshW30K4BTPztm/uLgiE
         XcwoiqpK6xM6b26Eo+8SJ/YBBnoIiLS3CI0LPTXRROmwtRkSm1S0sr8wx6S+QaJalV
         246PrN05B6JUdO9s2MXmkJF1cS1zdLO9yxMo2VHyIuF81A5coNM46YZmwm8aR2Mvx7
         Kb6n33eSQonzFn4gN+yOoH+mfv9SDkac4IeQn+32P2EHrCGSXdgqiIAbOBb/h1g8kM
         ApAfBgP/qBhyZkd6iraQx3qMgKnvqozSIGML9tnxaz5z2rS0ZCKcvNwi+NpQaoRt9I
         6IhlMWj8n7ASg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 12/16] iio:adc:hi8435: Tidy up white space around {} in id tables
Date:   Thu, 30 Dec 2021 17:49:07 +0000
Message-Id: <20211230174911.78291-13-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230174911.78291-1-jic23@kernel.org>
References: <20211230174911.78291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Previously inconsistent with space after { but not before }.
Tidy that up to avoid providing a bad example to copy into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/hi8435.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index e665e14c6e54..8eb0140df133 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -529,7 +529,7 @@ static const struct of_device_id hi8435_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, hi8435_dt_ids);
 
 static const struct spi_device_id hi8435_id[] = {
-	{ "hi8435", 0},
+	{ "hi8435", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, hi8435_id);
-- 
2.34.1

