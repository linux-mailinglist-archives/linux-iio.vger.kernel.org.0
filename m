Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7C4619D704
	for <lists+linux-iio@lfdr.de>; Fri,  3 Apr 2020 14:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390715AbgDCM6r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Apr 2020 08:58:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53307 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgDCM6q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Apr 2020 08:58:46 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jKLuA-00045U-PA; Fri, 03 Apr 2020 12:58:38 +0000
From:   Colin King <colin.king@canonical.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: dac: ad5770r: fix off-by-one check on maximum number of channels
Date:   Fri,  3 Apr 2020 13:58:38 +0100
Message-Id: <20200403125838.71271-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently there is an off-by-one check on the number of channels that
will cause an arry overrun in array st->output_mode when calling the
function d5770r_store_output_range. Fix this by using >= rather than >
to check for maximum number of channels.

Addresses-Coverity: ("Out-of-bounds access")
Fixes: cbbb819837f6 ("iio: dac: ad5770r: Add AD5770R support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/dac/ad5770r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index a98ea76732e7..2d7623b9b2c0 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -525,7 +525,7 @@ static int ad5770r_channel_config(struct ad5770r_state *st)
 		ret = fwnode_property_read_u32(child, "num", &num);
 		if (ret)
 			return ret;
-		if (num > AD5770R_MAX_CHANNELS)
+		if (num >= AD5770R_MAX_CHANNELS)
 			return -EINVAL;
 
 		ret = fwnode_property_read_u32_array(child,
-- 
2.25.1

