Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37CFBDE15
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2019 14:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405619AbfIYMc5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Sep 2019 08:32:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38000 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405486AbfIYMc5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Sep 2019 08:32:57 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iD6TV-0000Dx-Hb; Wed, 25 Sep 2019 12:32:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: gyro: clean up indentation issue
Date:   Wed, 25 Sep 2019 13:32:53 +0100
Message-Id: <20190925123253.11944-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a return statement that is indented incorrectly, add in
the missing tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/gyro/itg3200_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index 998fb8d66fe3..981ae2291505 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -154,7 +154,7 @@ static int itg3200_write_raw(struct iio_dev *indio_dev,
 					  t);
 
 		mutex_unlock(&indio_dev->mlock);
-	return ret;
+		return ret;
 
 	default:
 		return -EINVAL;
-- 
2.20.1

