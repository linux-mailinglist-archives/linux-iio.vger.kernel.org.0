Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0B1D5569
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 11:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfJMJHw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 05:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbfJMJHw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 05:07:52 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45FE620673;
        Sun, 13 Oct 2019 09:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570957672;
        bh=GnAbmRqSltmFgVAtWkr1ppMMBXyYUykDifDjgp/IOns=;
        h=From:To:Cc:Subject:Date:From;
        b=UHqztY9rxZK8c44qCWisY2COK3m3GkngqaAfv5vpBM3rSzWFhYwVntY6CCAjbAVYW
         +Y+reDoy6/7hRI78yblXHE2W5xUL8Y3lMlGyFklxJkT9lZsxmtVqde1gG4KdvK6Dwx
         ucElB2Uvv/5Ce2Ccklfol3ENtd/3PL545ZHn6yvI=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] iio:adc:mcp320x: Tidy up endian types in type cast.
Date:   Sun, 13 Oct 2019 10:05:42 +0100
Message-Id: <20191013090542.1375572-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Fixes the sparse warning:
drivers/iio/adc/mcp320x.c:167:41: warning: incorrect type in argument 1 (different base types)
drivers/iio/adc/mcp320x.c:167:41:    expected restricted __be32 const [usertype] *p
drivers/iio/adc/mcp320x.c:167:41:    got unsigned int [usertype] *<noident>

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/iio/adc/mcp320x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 38bf10085696..465c7625a55a 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -164,7 +164,7 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
 	case mcp3550_60:
 	case mcp3551:
 	case mcp3553: {
-		u32 raw = be32_to_cpup((u32 *)adc->rx_buf);
+		u32 raw = be32_to_cpup((__be32 *)adc->rx_buf);
 
 		if (!(adc->spi->mode & SPI_CPOL))
 			raw <<= 1; /* strip Data Ready bit in SPI mode 0,0 */
-- 
2.23.0

