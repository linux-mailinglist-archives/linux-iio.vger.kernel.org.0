Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A22F2B38C9
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 20:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgKOTcQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 14:32:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgKOTcQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Nov 2020 14:32:16 -0500
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 093B0238E6;
        Sun, 15 Nov 2020 19:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605468735;
        bh=ErJov3gozQbcXRWPQ/ExCFfzkMh9py6GNRxpW3I4Dyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMQZo7iiN9bX+UpHwQTM+8TlQe73QrxY7IAvT0Lo1E9nFVBKV4oMRXQL5+0D1ty3g
         gyE/niTL0fVhcY8PXeaVsjYaZ864QtSJzwG2oqqKF7OROum5JSmZrgeGie8yMKy3+/
         Ko3rrnEiXb7Xih6VUPFSBZG1ihMonan1agWgKkuU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [RFC PATCH 9/9] iio: inkern: Drop io-channel-ranges dt property support
Date:   Sun, 15 Nov 2020 19:29:51 +0000
Message-Id: <20201115192951.1073632-10-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201115192951.1073632-1-jic23@kernel.org>
References: <20201115192951.1073632-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This property has been almost exclusively missused in mainline and
we don't actually have any instances of it being necessary.

As such Rob Herring suggested we just drop it and I can't immediately
see any reason to disagree.

If anyone has an out of tree dts file that makes use of this then let
me know.  I'm not against keeping the code, but documenting it as a
deprecated property not to be used in new dts files.

Note build tested only. If someone could give it a sanity check
on a platform that uses this interface that would be great.
If not I'll mock something up before applying this.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/inkern.c | 49 +++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index ede99e0d5371..85a6f6103ee9 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -184,40 +184,25 @@ static struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
 						      const char *name)
 {
 	struct iio_channel *chan = NULL;
-
-	/* Walk up the tree of devices looking for a matching iio channel */
-	while (np) {
-		int index = 0;
-
-		/*
-		 * For named iio channels, first look up the name in the
-		 * "io-channel-names" property.  If it cannot be found, the
-		 * index will be an error code, and of_iio_channel_get()
-		 * will fail.
-		 */
-		if (name)
-			index = of_property_match_string(np, "io-channel-names",
+	int index = 0;
+
+	/*
+	 * For named iio channels, first look up the name in the
+	 * "io-channel-names" property.  If it cannot be found, the
+	 * index will be an error code, and of_iio_channel_get()
+	 * will fail.
+	 */
+	if (name)
+		index = of_property_match_string(np, "io-channel-names",
 							 name);
-		chan = of_iio_channel_get(np, index);
-		if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
-			break;
-		else if (name && index >= 0) {
-			pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
-				np, name ? name : "", index);
-			return NULL;
-		}
+	chan = of_iio_channel_get(np, index);
+	if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
+		return chan;
+	else if (name && index >= 0)
+		pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
+		       np, name ? name : "", index);
 
-		/*
-		 * No matching IIO channel found on this node.
-		 * If the parent node has a "io-channel-ranges" property,
-		 * then we can try one of its channels.
-		 */
-		np = np->parent;
-		if (np && !of_get_property(np, "io-channel-ranges", NULL))
-			return NULL;
-	}
-
-	return chan;
+	return NULL;
 }
 
 static struct iio_channel *of_iio_channel_get_all(struct device *dev)
-- 
2.28.0

