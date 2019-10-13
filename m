Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A99DAD5591
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 11:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfJMJ5U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 05:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728543AbfJMJ5U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 05:57:20 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 514C020673;
        Sun, 13 Oct 2019 09:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570960640;
        bh=PTGfE6rg34JkW4EyQE873y0B+++yKeoya/IaJGIPNEo=;
        h=From:To:Cc:Subject:Date:From;
        b=rrzJiJJgo/bdDE3lK6KJB+9lgNYjuucSLyfRI3XsD9iXpTXKS0wAUta8sy2ZENaOW
         t/bEVU9tWdtKscAKG9czclRFBN6GdOLQ38W6NqGUISWq8gcCJc++JLAxsA8hhy3HkF
         45/9mWke30pIiTKtm8uBCF8s9o86zXMBE3wXJXus=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH] iio: chemical: sps30: Explicity truncate constant by masking
Date:   Sun, 13 Oct 2019 10:55:15 +0100
Message-Id: <20191013095515.1438147-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

When breaking up a constant to write to two 8 bit registers
it isn't obvious to sparse that it was intentional.

CHECK   drivers/iio/chemical/sps30.c
drivers/iio/chemical/sps30.c:120:30: warning: cast truncates bits from constant value (8004 becomes 4)

So in the interests of minimising noisy warnings, let us add
a mask.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/chemical/sps30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index edbb956e81e8..acb9f8ecbb3d 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -117,7 +117,7 @@ static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
 		break;
 	case SPS30_READ_AUTO_CLEANING_PERIOD:
 		buf[0] = SPS30_AUTO_CLEANING_PERIOD >> 8;
-		buf[1] = (u8)SPS30_AUTO_CLEANING_PERIOD;
+		buf[1] = (u8)(SPS30_AUTO_CLEANING_PERIOD & 0xff);
 		/* fall through */
 	case SPS30_READ_DATA_READY_FLAG:
 	case SPS30_READ_DATA:
-- 
2.23.0

