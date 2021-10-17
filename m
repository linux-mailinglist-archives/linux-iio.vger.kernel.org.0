Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D800430A55
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 17:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbhJQQBH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 12:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237507AbhJQQBH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 12:01:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E77661040;
        Sun, 17 Oct 2021 15:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634486337;
        bh=ogb2FpJKMZfPnp21xeZREjE7NG2W6B7oCI0E7ScgD4I=;
        h=From:To:Cc:Subject:Date:From;
        b=S05ekInNMnKqBYHrokxocf+kCOXaubSdiGm6zzCUUfCG3T3oUlCVW/Pq7mapiZtpU
         I46Y2DtnkTb5Ee0Or28NXt11mOf8hhZm7uiD8lJWrmgW5PcqmgkV++C9Rbr1elLW2J
         xIJkJzeKf0yjam3lvf3GjOUZlgKM6C7MzJomQ/+Q9in2VyVW3kl0/YhUrI+lQFgj8F
         WKjeSjf3Mceq/sJOFSY4qATcbO72svhyIvb62cWZatxtP3qN8OVKiWfdPa6XSWs1Wk
         oxCjHF2hig5W+pOWr7clzDZDTRmqdNOP0xvZotGyPiTidiQiKPIyn8TlGFm+DLNLrh
         LYfoVE67BtM7A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] iio: accel: sca3000: Use sign_extend32() instead of opencoding sign extension.
Date:   Sun, 17 Oct 2021 17:03:03 +0100
Message-Id: <20211017160303.72441-1-jic23@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst nice to get rid of this non obvious code, this also clears a
static checker warning:

drivers/iio/accel/sca3000.c:734 sca3000_read_raw()
warn: no-op. '((*val) << 19) >> 19'

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: 
Use the right sign bit (thanks Lars!)
Should be bit 12 for a 13 bit value.

 drivers/iio/accel/sca3000.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index cb753a43533c..c6b75308148a 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -731,8 +731,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 				return ret;
 			}
 			*val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
-			*val = ((*val) << (sizeof(*val) * 8 - 13)) >>
-				(sizeof(*val) * 8 - 13);
+			*val = sign_extend32(*val, 12);
 		} else {
 			/* get the temperature when available */
 			ret = sca3000_read_data_short(st,
-- 
2.33.1

