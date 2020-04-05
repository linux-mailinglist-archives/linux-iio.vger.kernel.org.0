Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4459C19ED40
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgDESFo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 14:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgDESFo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 14:05:44 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E9DB20678;
        Sun,  5 Apr 2020 18:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586109944;
        bh=t9P+pyoUFij+kWGMhTYvvxg/WLmtzDg9rE3VUgRhm2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M79BDxoVMqNtxlnhxZ9ABH4zs4XihKZMAcJSmBdVz5yRd4GoYB0A31ymutjPQpmwD
         KRaBJsNMIw6gDTqyzGShFk7fCzyRUi2mO7FyA8vD4hNJXLspTjRKrrGwWSufOB8+f3
         LlH2mfDUv5qX9yWX7JJ+s8GCuiW9CYrkEph7RrD0=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/6] iio:accel:mxc4005: Drop unnecessary explicit casts in regmap_bulk_read calls
Date:   Sun,  5 Apr 2020 19:03:16 +0100
Message-Id: <20200405180321.1737310-2-jic23@kernel.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405180321.1737310-1-jic23@kernel.org>
References: <20200405180321.1737310-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

regmap_bulk_read takes a void * for its val parameter. It certainly
makes no sense to cast to a (u8 *) + no need to explicitly cast
at all when converting another pointer type to void *.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mxc4005.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 3d5bea651923..9d07642c0de1 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -135,7 +135,7 @@ static int mxc4005_read_xyz(struct mxc4005_data *data)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, MXC4005_REG_XOUT_UPPER,
-			       (u8 *) data->buffer, sizeof(data->buffer));
+			       data->buffer, sizeof(data->buffer));
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read axes\n");
 		return ret;
@@ -150,7 +150,7 @@ static int mxc4005_read_axis(struct mxc4005_data *data,
 	__be16 reg;
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, addr, (u8 *) &reg, sizeof(reg));
+	ret = regmap_bulk_read(data->regmap, addr, &reg, sizeof(reg));
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read reg %02x\n", addr);
 		return ret;
-- 
2.26.0

