Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A112E3211
	for <lists+linux-iio@lfdr.de>; Sun, 27 Dec 2020 18:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgL0RMa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Dec 2020 12:12:30 -0500
Received: from www381.your-server.de ([78.46.137.84]:59642 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgL0RM3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Dec 2020 12:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=mSm8vzDAnhl2k4crdbOo2YtVaYJmVkHvtKyvZ4SH3qM=; b=gdqpsA9zkz58C7rxyx6k1imYKB
        ZJkWZ+89R9p0jcfNacErWxQs3V4EImcGYg64ODDE6WCaH9bluSy7+4hCBsodNxTFMnRSbjGQrQMjJ
        JAg2kuOYNzDHq9zRYZIXGlsVN+6RMwd0I8Ey+gyDtALaAxWl5EkbxILuYQlIDigOFROd+WtN0Z929
        FdTnvWsfp3KdQ4XYp0Dc1jviAvF8akRS44AM9pmYeNPdBW429pQAniLjOUbyZ9zwQ3s06n5bNkS1S
        eFgf0NItExevNcabZTSja2tGdlOT7LU8WQY8g2frgEHkhGFZ2Ftdxi4GPRVdZMv+dHfpK8NPpXy23
        mZa/Z/ww==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1ktZa7-0009Ha-H5; Sun, 27 Dec 2020 18:11:47 +0100
Received: from [2001:a61:2af4:a201:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1ktZa7-000T2x-Cq; Sun, 27 Dec 2020 18:11:47 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Manivannan Sadhasivam <manivannanece23@gmail.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] iio: tsl2583: Use DIV_ROUND_CLOSEST() instead of open-coding it
Date:   Sun, 27 Dec 2020 18:11:26 +0100
Message-Id: <20201227171126.28216-3-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201227171126.28216-1-lars@metafoo.de>
References: <20201227171126.28216-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26030/Sun Dec 27 13:44:56 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use DIV_ROUND_CLOSEST() instead of open-coding it. This documents intent
and makes it more clear what is going on for the casual reviewer.

Generated using the following the Coccinelle semantic patch.

// <smpl>
@r1@
expression x;
constant C1;
constant C2;
@@
 ((x) + C1) / C2

@script:python@
C1 << r1.C1;
C2 << r1.C2;
@@
try:
	if int(C1) * 2 != int(C2):
		cocci.include_match(False)
except:
	cocci.include_match(False)

@@
expression r1.x;
constant r1.C1;
constant r1.C2;
@@
-(((x) + C1) / C2)
+DIV_ROUND_CLOSEST(x, C2)
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/light/tsl2583.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 9e5490b7473b..0f787bfc88fc 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -285,7 +285,7 @@ static int tsl2583_get_lux(struct iio_dev *indio_dev)
 	lux64 = lux64 * chip->als_settings.als_gain_trim;
 	lux64 >>= 13;
 	lux = lux64;
-	lux = (lux + 500) / 1000;
+	lux = DIV_ROUND_CLOSEST(lux, 1000);
 
 	if (lux > TSL2583_LUX_CALC_OVER_FLOW) { /* check for overflow */
 return_max:
@@ -361,12 +361,12 @@ static int tsl2583_set_als_time(struct tsl2583_chip *chip)
 	u8 val;
 
 	/* determine als integration register */
-	als_count = (chip->als_settings.als_time * 100 + 135) / 270;
+	als_count = DIV_ROUND_CLOSEST(chip->als_settings.als_time * 100, 270);
 	if (!als_count)
 		als_count = 1; /* ensure at least one cycle */
 
 	/* convert back to time (encompasses overrides) */
-	als_time = (als_count * 27 + 5) / 10;
+	als_time = DIV_ROUND_CLOSEST(als_count * 27, 10);
 
 	val = 256 - als_count;
 	ret = i2c_smbus_write_byte_data(chip->client,
@@ -380,7 +380,7 @@ static int tsl2583_set_als_time(struct tsl2583_chip *chip)
 
 	/* set chip struct re scaling and saturation */
 	chip->als_saturation = als_count * 922; /* 90% of full scale */
-	chip->als_time_scale = (als_time + 25) / 50;
+	chip->als_time_scale = DIV_ROUND_CLOSEST(als_time, 50);
 
 	return ret;
 }
-- 
2.20.1

