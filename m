Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6604BF06DF
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2019 21:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfKEU20 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Nov 2019 15:28:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59350 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEU2Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Nov 2019 15:28:25 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iS5R4-0001rU-ED; Tue, 05 Nov 2019 20:28:18 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: temperature: ltc2983: fix u32 read into a unsigned long long
Date:   Tue,  5 Nov 2019 20:28:18 +0000
Message-Id: <20191105202818.90065-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the read of temp using of_property_read_u32_index is reading
a u32 value into a unsigned long long.  This relies on machine endianness
to work correctly, so fix this by reading a u32 value and setting temp
to this value.

Addresses-Coverity: ("Reliance on integer endianness")
Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/temperature/ltc2983.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index ddf47023364b..d39c0d6b77f1 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -444,8 +444,10 @@ static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
 			else
 				temp = __convert_to_raw(temp, resolution);
 		} else {
-			of_property_read_u32_index(np, propname, index,
-						   (u32 *)&temp);
+			u32 t32;
+
+			of_property_read_u32_index(np, propname, index, &t32);
+			temp = t32;
 		}
 
 		for (j = 0; j < n_size; j++)
-- 
2.20.1

