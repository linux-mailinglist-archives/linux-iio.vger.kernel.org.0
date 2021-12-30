Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A53F481EB5
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbhL3RoL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbhL3RoK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:44:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A6FC061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 09:44:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15700CE1C9D
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DC2C36AE9;
        Thu, 30 Dec 2021 17:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886247;
        bh=cMbdJY3wykoFC4gP6DUiXWlgH0xDPLK8ySVX7sJoRC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4QJQXl+d7jPigbahWtoQYvpvI/nFEyNX0gNgGNvh75gshEJ8vHf+WfFByLdY8g+3
         3kTuJAfrevGsh39qVtQaCUbDgLyZfXEsJzHqvI0Y0fPeyHmlnQcVI9U184U+VK2z0M
         sy2RVuNM+QKCS5j+41b0rsrUu/2opQePRzRI28ckPPwK0H7vkqGHAdAtlp3Sv3vN8w
         CxOHMLDUwqWCkklR2f/hHxNE60dw4ndS4WfkAvRTp1PLJ7yRAs9AeTPxX0an18DWxH
         DP6iLVJMGJVprZQyaP91sov0myY7tZ5AYf2T6VoE03j9gq/KXdl6IJh7I8kNTuWTCN
         UU427PV8PfiIg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH 08/16] iio:proximity:srf04: White space cleanup of spacing around {} in id tables
Date:   Thu, 30 Dec 2021 17:49:03 +0000
Message-Id: <20211230174911.78291-9-jic23@kernel.org>
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
 drivers/iio/proximity/srf04.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index fe88b2bb60bc..4e6286765f01 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -235,12 +235,12 @@ static const struct iio_chan_spec srf04_chan_spec[] = {
 };
 
 static const struct of_device_id of_srf04_match[] = {
-	{ .compatible = "devantech,srf04", .data = &srf04_cfg},
-	{ .compatible = "maxbotix,mb1000", .data = &mb_lv_cfg},
-	{ .compatible = "maxbotix,mb1010", .data = &mb_lv_cfg},
-	{ .compatible = "maxbotix,mb1020", .data = &mb_lv_cfg},
-	{ .compatible = "maxbotix,mb1030", .data = &mb_lv_cfg},
-	{ .compatible = "maxbotix,mb1040", .data = &mb_lv_cfg},
+	{ .compatible = "devantech,srf04", .data = &srf04_cfg },
+	{ .compatible = "maxbotix,mb1000", .data = &mb_lv_cfg },
+	{ .compatible = "maxbotix,mb1010", .data = &mb_lv_cfg },
+	{ .compatible = "maxbotix,mb1020", .data = &mb_lv_cfg },
+	{ .compatible = "maxbotix,mb1030", .data = &mb_lv_cfg },
+	{ .compatible = "maxbotix,mb1040", .data = &mb_lv_cfg },
 	{},
 };
 
-- 
2.34.1

