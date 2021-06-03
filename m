Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DD239A620
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 18:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFCQri (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 12:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhFCQri (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 12:47:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C371C613B1;
        Thu,  3 Jun 2021 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622738753;
        bh=eL9WePw96ERe592enOs835Ct173ZKy6T8GbeKg5ZWLs=;
        h=From:To:Cc:Subject:Date:From;
        b=LaO9Ib6+9wtWkORQabh3rpbsgHAO245erYjkLqrIVHRuByKFHZ9S+HShhE2qqm3Ie
         U4orKe/Zdr5m52fjSPNIJSypHAprGGfZWmRrI+vhhmOiqyHE0W1qpC2/N06Brbv0z9
         yf7P+PwJKyxcxxMKkIqbnyXGzm7xm5Fsmbm5VXFrawIQzm60LZCdkSNzmmCXEZo2NQ
         5iQaHWh/GHRcBypcX2E/MfYcLDJpnhEJPwfhI7xse1awWRBanJB0tKDJhlLCoB8GOX
         kLxO+IsrfoBh2exCwRqbNboBFpr/GZuYG4+9WNCSuA50PbZY6mRMEH4dxuBkJiVeWu
         acEjeTqrAftZA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] iio: accel: sca3000: Use sign_extend32() instead of opencoding sign extension.
Date:   Thu,  3 Jun 2021 17:47:29 +0100
Message-Id: <20210603164729.3584702-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
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
 drivers/iio/accel/sca3000.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index cb753a43533c..0692ccb80293 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -731,8 +731,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 				return ret;
 			}
 			*val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
-			*val = ((*val) << (sizeof(*val) * 8 - 13)) >>
-				(sizeof(*val) * 8 - 13);
+			*val = sign_extend32(*val, 13);
 		} else {
 			/* get the temperature when available */
 			ret = sca3000_read_data_short(st,
-- 
2.31.1

