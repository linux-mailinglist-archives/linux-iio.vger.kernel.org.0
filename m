Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA6D39A9BA
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 20:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhFCSHX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 14:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230443AbhFCSGz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 14:06:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BF15611ED;
        Thu,  3 Jun 2021 18:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622743482;
        bh=GiWzfqYEzX2F0/jFV2TExFGPGu9sc/IZ3x02HUPS5/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EPza7oWfxszpZxXWBBAWxDmI3Sq5Uv1q/kNMAnEnDqwsysCTzKv2djKe8glZNFjzI
         97AuxH1mM2fpE+3a1JUfFDeQHq5kDo9nS3aMCg5+Qs2OABDuWGpCQ+uzzHQof2sW2b
         IARIjUF4sOe0UGQha5HXlpiZO2EYJq7DH/8w2shMLPSAFk7mRNpLxzQuznOOhu18xg
         IKK4Unfaz6+U2X4evg3vo9hZn4cpghPsVBbwmr3iL/IVW1TkN2lizAAtPnosuaOW/z
         wFbCrQGuADFERTp6ZFUOZUaCuTxXRgU3UPJwVjttzAEgz1FBnK+xhocu7KDilSqbqS
         5RTGx5t5iPhQw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 1/4] iio: si1133: fix format string warnings
Date:   Thu,  3 Jun 2021 19:06:09 +0100
Message-Id: <20210603180612.3635250-2-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603180612.3635250-1-jic23@kernel.org>
References: <20210603180612.3635250-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang complains about multiple instances of printing an integer
using the %hhx format string:

drivers/iio/light/si1133.c:982:4: error: format specifies type 'unsigned char' but the argument has type 'unsigned int' [-Werror,-Wformat]
                 part_id, rev_id, mfr_id);
                 ^~~~~~~

Print them as a normal integer instead, leaving the "#02"
length modifier.

Use the 0x02x form as the length specifier when used with # includes
the 0x prefix and is very unlikely to be what was intended by the author.

Fixes: e01e7eaf37d8 ("iio: light: introduce si1133")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/si1133.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index c280b4195003..0accea7090ee 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -978,11 +978,11 @@ static int si1133_validate_ids(struct iio_dev *iio_dev)
 		return err;
 
 	dev_info(&iio_dev->dev,
-		 "Device ID part %#02hhx rev %#02hhx mfr %#02hhx\n",
+		 "Device ID part 0x%02x rev 0x%02x mfr 0x%02x\n",
 		 part_id, rev_id, mfr_id);
 	if (part_id != SI1133_PART_ID) {
 		dev_err(&iio_dev->dev,
-			"Part ID mismatch got %#02hhx, expected %#02x\n",
+			"Part ID mismatch got 0x%02x, expected 0x%02x\n",
 			part_id, SI1133_PART_ID);
 		return -ENODEV;
 	}
-- 
2.31.1

