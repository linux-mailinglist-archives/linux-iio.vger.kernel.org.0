Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B1533A6F7
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 17:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhCNQtQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 12:49:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234673AbhCNQtK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 12:49:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61BB364EC6;
        Sun, 14 Mar 2021 16:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615740550;
        bh=2gpVKDyz4eKOgby8fB5zPO24dATUQOirm4NV4OFwVM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=io/XMjmOxXOyvMoilQ87PDNcZ6PxCxHflR2GMJDTCieFFb5exd4glnzT/q1DRl7S8
         QBVwTmb1lXBUKxeYxruIMfmMc7NipiP3BWTBstMwfrusOw0YsX/kaMjw58Aa2Nd4t4
         kNvNMHN3dJjZkOPQr9po6XFERru9KzFfacjJaGf/kVpAI8abicbZpOrCKenL83rXrJ
         lM2nsUiODWv37UwoxKH2nYH7blvZYinq2xebTUwNokFPhoHYmjEOpxZRmFUoRSyqSX
         qF0/tXw4xn3RxNW4N3Q0oxQJXNqpm2vlYFk+dZ7SR0VnD8bk/O9beZIGzJAQC+348+
         4slYU+BjWFLIA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/8] iio: dac: ad5504: fix wrong part number in kernel-doc structure name.
Date:   Sun, 14 Mar 2021 16:46:51 +0000
Message-Id: <20210314164655.408461-5-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314164655.408461-1-jic23@kernel.org>
References: <20210314164655.408461-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Probably a bit of cut and paste where someone forgot to change the
part number.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5504.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index e9297c25d4ef..f383bdcdc121 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -39,7 +39,7 @@
 #define AD5504_DAC_PWRDN_3STATE		1
 
 /**
- * struct ad5446_state - driver instance specific data
+ * struct ad5504_state - driver instance specific data
  * @spi:			spi_device
  * @reg:		supply regulator
  * @vref_mv:		actual reference voltage used
-- 
2.30.2

