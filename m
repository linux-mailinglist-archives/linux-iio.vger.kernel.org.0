Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D42481EB4
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbhL3RoK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:44:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48836 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbhL3RoK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:44:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DA1C6173D
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FE8C36AEB;
        Thu, 30 Dec 2021 17:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886249;
        bh=qUebMVJ+1QAQ/r7heURBhOv3RJ7fPRvYR/ve2k6up2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kxRGQ96IjhaVmNGL99AHYEFaXAMj6hU8GgamMh/3fd3ElRXeKjRJOKTmUQxHDYo0M
         jXh0eoTzRpSTJf+jIgVwko2gb0M7ysPD+7/B5OWXi3MPg85FKwt8W9FDsKDJc5ZQrA
         V6EDuIYwl6pDPYSWhAOsEXc5l1P7p2Ur+F2FJryDklfrYUedfRRdvMTqyTeF0dXvZ9
         tUSCrJ+67n1IZsWExCUcKgacaZFj06ykzeIVQpOG012amAOIk1HpX6/wMA5mpyBTeS
         9s9CrlHbhlfhUqOAv9Bp4vdaDNmn2b2+sH9kK39zyiqzNecmpNdaAr2Y9ZJr6HoCQO
         +3RtRe+nFEQcg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH 09/16] iio:proximity:srf08: White space cleanup of spacing around {} in id tables
Date:   Thu, 30 Dec 2021 17:49:04 +0000
Message-Id: <20211230174911.78291-10-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230174911.78291-1-jic23@kernel.org>
References: <20211230174911.78291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The spacing in this driver was inconsistent with a space after the {
but not before the }.  Tidy this up to avoid providing a bad example
to copy into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/srf08.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 9b0886760f76..ac1ab7e89d4e 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -528,9 +528,9 @@ static int srf08_probe(struct i2c_client *client,
 }
 
 static const struct of_device_id of_srf08_match[] = {
-	{ .compatible = "devantech,srf02", (void *)SRF02},
-	{ .compatible = "devantech,srf08", (void *)SRF08},
-	{ .compatible = "devantech,srf10", (void *)SRF10},
+	{ .compatible = "devantech,srf02", (void *)SRF02 },
+	{ .compatible = "devantech,srf08", (void *)SRF08 },
+	{ .compatible = "devantech,srf10", (void *)SRF10 },
 	{},
 };
 
-- 
2.34.1

