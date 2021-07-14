Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7DA3C8380
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 13:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbhGNLRr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 07:17:47 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:21542 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhGNLRq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 07:17:46 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d27 with ME
        id UzEt2500721Fzsu03zEu7G; Wed, 14 Jul 2021 13:14:54 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 14 Jul 2021 13:14:54 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] iio: buffer: Move a sanity check at the beginning of 'iio_scan_mask_set()'
Date:   Wed, 14 Jul 2021 13:14:51 +0200
Message-Id: <98a351adda1908c306e981b9cc86d3dbc79eb5ec.1626261211.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <89d8a766eb971eda1ee362444a8711037bdb208c.1626261211.git.christophe.jaillet@wanadoo.fr>
References: <89d8a766eb971eda1ee362444a8711037bdb208c.1626261211.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is more standard to have sanity checks at the entry of a function,
instead of allocating some memory first and having to free it if a
condition is not met.

Shuffle code a bit to check 'masklength' before calling 'bitmap_alloc()'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/industrialio-buffer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 6d4776a7f002..a95cc2da56be 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -354,13 +354,14 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
 	const unsigned long *mask;
 	unsigned long *trialmask;
 
-	trialmask = bitmap_alloc(indio_dev->masklength, GFP_KERNEL);
-	if (!trialmask)
-		return -ENOMEM;
 	if (!indio_dev->masklength) {
 		WARN(1, "Trying to set scanmask prior to registering buffer\n");
-		goto err_invalid_mask;
+		return -EINVAL;
 	}
+
+	trialmask = bitmap_alloc(indio_dev->masklength, GFP_KERNEL);
+	if (!trialmask)
+		return -ENOMEM;
 	bitmap_copy(trialmask, buffer->scan_mask, indio_dev->masklength);
 	set_bit(bit, trialmask);
 
-- 
2.30.2

