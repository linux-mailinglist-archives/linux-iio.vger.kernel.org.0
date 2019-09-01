Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A80A4A00
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2019 17:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfIAP2O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Sep 2019 11:28:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43536 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfIAP2O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Sep 2019 11:28:14 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i4Rld-0002it-Se; Sun, 01 Sep 2019 15:27:50 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: cm36651: redundant assignment to variable ret
Date:   Sun,  1 Sep 2019 16:27:49 +0100
Message-Id: <20190901152749.12916-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable ret is being assigned a value that is never read and
is being re-assigned a little later on. The assignment is redundant
and hence can be removed.

Addresses-Coverity: ("Ununsed value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/light/cm36651.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
index 1019d625adb1..90e38fcc974b 100644
--- a/drivers/iio/light/cm36651.c
+++ b/drivers/iio/light/cm36651.c
@@ -532,7 +532,7 @@ static int cm36651_write_prox_event_config(struct iio_dev *indio_dev,
 					int state)
 {
 	struct cm36651_data *cm36651 = iio_priv(indio_dev);
-	int cmd, ret = -EINVAL;
+	int cmd, ret;
 
 	mutex_lock(&cm36651->lock);
 
-- 
2.20.1

