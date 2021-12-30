Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB16481EAF
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241508AbhL3RoC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:44:02 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:60248 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241506AbhL3Rn6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:43:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 12509CE1C9E
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF5CC36AE9;
        Thu, 30 Dec 2021 17:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886235;
        bh=++d6l3JwUFYmjYbUTMBYB9vOnn5DJlDL3AA/Fnv1Rug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxMcK9Z2/OhmUNy04z2ukKljeUG+C8iXP/BUdkBran9RiCYEzkuzA9+GsfHXBDxIE
         CT4i1kcRqrNEzVq3ALEdhIe2V69rel4ZaL201SoGbbtpBCyg6sthtXUGhuBTr/Xhf1
         Kl4/wBlj6mWeu4f7fuyHCkKWzp2cIMU0QKeGkN01/HRpvjRarTSxIV4z2V2R+NeU+C
         AFJKhpj8NQY644lOo+hDtFcw2BcJkVYTe+IDHp9EHO1T/1n1XBK61Xzrdoa6WSReB9
         XaBh3wA/dkuxteSIzkrrFL+I78SP/h9TKg5D0IhsNZpLkrdWQ1uCS73Ps9b1JahKrI
         zC2PvN3CpYT+g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH 03/16] iio:light:vcnl4035: Trivial whitespace cleanup to add space before }
Date:   Thu, 30 Dec 2021 17:48:58 +0000
Message-Id: <20211230174911.78291-4-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230174911.78291-1-jic23@kernel.org>
References: <20211230174911.78291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Having a space after the { and not one before the } is inconsistent and
I'd rather not have examples of this that get copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Parthiban Nallathambi <pn@denx.de>
---
 drivers/iio/light/vcnl4035.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 0db306ee910e..da2bf622a67b 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -651,7 +651,7 @@ static const struct dev_pm_ops vcnl4035_pm_ops = {
 };
 
 static const struct i2c_device_id vcnl4035_id[] = {
-	{ "vcnl4035", 0},
+	{ "vcnl4035", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vcnl4035_id);
-- 
2.34.1

