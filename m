Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB88382CA4
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 14:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhEQM6M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 08:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233441AbhEQM6L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 May 2021 08:58:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 252766100C;
        Mon, 17 May 2021 12:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621256215;
        bh=D00+FdKgvt6SX0ZwOLrLpE94sSSg/x5em9GIhegOcmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TY+9/sNm5mb/w7m/Mu2rzWkiEElNJSHN/2hGny8tURSQhSLERmTujFT8gjSvRUPRg
         y60Dh1S9res8nS7xn0/skB5TZnnuSjtAiwfs7yCMV86W770ku2JfeERxEw0PLwsP4S
         Vd+eo+Yh+xV3BDo1IbUZqNBRNGVWCwa2gZalB5BXx/1Do9eZS/HN1b4cTdCz6NP9Kn
         w3VeBER1PtvYryRh9eDeAKgCAdrKzSr078ov8kMN2aZu6ZHj+a68HpIimMEs6fPG4Y
         dfhUzYjshdJ3snHW5E6bPNY5fx0wRn7i/mJi/GfVnfSwNanflmDsJFwTXEoapABihs
         FX61ymZXDmvig==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Andreas Brauchli <andreas.brauchli@sensirion.com>
Subject: [PATCH 4/4] iio: chemical: sgp30: Drop use of %hx in format string.
Date:   Mon, 17 May 2021 13:55:54 +0100
Message-Id: <20210517125554.1463156-5-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517125554.1463156-1-jic23@kernel.org>
References: <20210517125554.1463156-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Since:
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
unnecessary %h[xudi] and %hh[xudi]")
use of these format strings has been discouraged.

As there are only a few such uses in IIO, lets clear them all out and
avoid chance of them getting copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Andreas Brauchli <andreas.brauchli@sensirion.com>
---
 drivers/iio/chemical/sgp30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
index 1029c457be15..2343d444604d 100644
--- a/drivers/iio/chemical/sgp30.c
+++ b/drivers/iio/chemical/sgp30.c
@@ -425,7 +425,7 @@ static int sgp_check_compat(struct sgp_data *data,
 
 	product = SGP_VERS_PRODUCT(data);
 	if (product != product_id) {
-		dev_err(dev, "sensor reports a different product: 0x%04hx\n",
+		dev_err(dev, "sensor reports a different product: 0x%04x\n",
 			product);
 		return -ENODEV;
 	}
-- 
2.31.1

