Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD9E3A48A5
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 20:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFKS36 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 14:29:58 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:35252 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhFKS36 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 14:29:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623436075; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=igPW7lQGUuQRWmFTJtQvDwkSnkC/EvgJg6R/P0n5HSaObz5ewrTZLzH3yEkkx/O6a4
    ZRr9n5udOo69bniIpU9aKYkVSi8G0nkfmQt69PE6QIClvW4Zxm2CGHsdPu5/L9GmPxxn
    E/wTwCRkeH0CI5cx6aAdQtxbgB3DkiGmnFid288nxu7kn8f47Mxe6xBkaRqk+VqrVwj5
    pX+pbBGytCT9oJ6kJ8BwBVbYqReVrsaJM3IbuGKZkEvFrZaPtqH3dLM10kReGRl3iLac
    P+PktyieVm2hxxH6K98T/3FGQZYm9qNnUXPi8xQR8FXMVBSw6TZpngMmE2Sa/PXUm8JF
    yBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623436075;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=1KirUKRlkIwbATC5H+deJHDf5dhhOMKA19Bn9NBavm8=;
    b=NmWiwhQcF/4VBKhivtmJjiCIbLu1TqijXtE7YKgCD/iYvaPor1nyo2C/wrSW+f+UcU
    dAziJkFQljr+z49OALlM6xR5Uc0HAu5WVBdyeV9Hn7ynqdHxKCL0WinnvFEOIIJOd7DT
    pxS3ZwsHTGNc0X52Ef4A1XBP9REScEZRn1eMe2uyAneqXfqorpL4jeYYo7Z5r1U8Z2M+
    lL7/eZc/jShJCc16SRk0Vg9j+Fn5CZV3tv9ctxKy+8BiRrU1Hwj+C0HpQlha3HxHU8Rn
    +v6XQI6Dd54DQuClztSAqBCvE8NGpWqqi00dJpNQCy3rUWE35oQrarLxZLDsRgqnXxqq
    qlKQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623436075;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=1KirUKRlkIwbATC5H+deJHDf5dhhOMKA19Bn9NBavm8=;
    b=QJonljpdWkWepNL4o3J2Aap88YXks3TYC8gdayZhflfAZr+oLAhveihLh1keK1o99A
    PIUNlDzLJUrjM7XCaaYboN2eAIXg9k9Bvu5HwO1yeYEZ3aspbth9a99O7mtVUNYSwphZ
    SMdKxuFIEG4OBhZKLEt9Cf60TgxQ1h75FPTe1bGqPAvHDeVRFMIoYpDU2hk96eg7BoLW
    VkrB0PCVreLkCDYaCwL1JMV6k2SeoqZNO2LdyB/8dRI3KuCAh2BSfIx7EXBtYE7g1DJn
    lu3z+F2BtLOPQv8Og+fI530xTe7zNjMoWOHAnrE24YEJDewdXQcg9Oyst8YT9ZQqkWYL
    AX8g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA6m6PrPw="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5BIRs2oo
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 11 Jun 2021 20:27:54 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] iio: accel: bmc150: Use more consistent and accurate scale values
Date:   Fri, 11 Jun 2021 20:24:42 +0200
Message-Id: <20210611182442.1971-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It is quite strange that BMA222 and BMA222E have very close, yet
subtly different values in their scale tables. Comparing the datasheets
this is simply because the "Resolution" for the different measurement
ranges are documented with different precision.

For example, for +-2g the BMA222 datasheet [1] suggests a resolution
of 15.6 mg/LSB, while the BMA222E datasheet [2] suggests 15.63 mg/LSB.

Actually, there is no need to rely on the resolution given by the Bosch
datasheets. The resolution and scale can be calculated more consistently
and accurately using the range (e.g. +-2g) and the channel size (e.g. 8 bits).

Distributing 4g (-2g to 2g) over 8 bits results in an exact resolution
of (4g / 2^8) = 15.625 mg/LSB which is the same value as in both datasheets,
just slightly more accurate. Multiplying g = 9.80665 m/s^2 we get a more
accurate value for the IIO scale table.

Generalizing this we can calculate the scale tables more accurately using
(range / 2^bits) * g * 10^6 (because of IIO_VAL_INT_PLUS_MICRO).

Document this and make the scale tables more consistent and accurate
for all the variants using that formula. Now the scale tables for
BMA222 and BMA222E are consistent and probably slightly more accurate.

[1]: https://media.digikey.com/pdf/Data%20Sheets/Bosch/BMA222.pdf
[2]: https://www.mouser.com/datasheet/2/783/BST-BMA222E-DS004-06-1021076.pdf

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/accel/bmc150-accel-core.c | 46 ++++++++++++++-------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 43aecd4bf3a4..5ce384ebe6c7 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1088,19 +1088,21 @@ static const struct iio_chan_spec bmc150_accel_channels[] =
 static const struct iio_chan_spec bma280_accel_channels[] =
 	BMC150_ACCEL_CHANNELS(14);
 
+/*
+ * The range for the Bosch sensors is typically +-2g/4g/8g/16g, distributed
+ * over the amount of bits (see above). The scale table can be calculated using
+ *     (range / 2^bits) * g = (range / 2^bits) * 9.80665 m/s^2
+ * e.g. for +-2g and 12 bits: (4 / 2^12) * 9.80665 m/s^2 = 0.0095768... m/s^2
+ * Multiply 10^6 and round to get the values listed below.
+ */
 static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 	{
 		.name = "BMA222",
 		.chip_id = 0x03,
 		.channels = bma222e_accel_channels,
 		.num_channels = ARRAY_SIZE(bma222e_accel_channels),
-		/*
-		 * The datasheet page 17 says:
-		 * 15.6, 31.3, 62.5 and 125 mg per LSB.
-		 * IIO unit is m/s^2 so multiply by g = 9.80665 m/s^2.
-		 */
-		.scale_table = { {152984, BMC150_ACCEL_DEF_RANGE_2G},
-				 {306948, BMC150_ACCEL_DEF_RANGE_4G},
+		.scale_table = { {153229, BMC150_ACCEL_DEF_RANGE_2G},
+				 {306458, BMC150_ACCEL_DEF_RANGE_4G},
 				 {612916, BMC150_ACCEL_DEF_RANGE_8G},
 				 {1225831, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
@@ -1109,9 +1111,9 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 		.chip_id = 0xF8,
 		.channels = bma222e_accel_channels,
 		.num_channels = ARRAY_SIZE(bma222e_accel_channels),
-		.scale_table = { {153277, BMC150_ACCEL_DEF_RANGE_2G},
-				 {306457, BMC150_ACCEL_DEF_RANGE_4G},
-				 {612915, BMC150_ACCEL_DEF_RANGE_8G},
+		.scale_table = { {153229, BMC150_ACCEL_DEF_RANGE_2G},
+				 {306458, BMC150_ACCEL_DEF_RANGE_4G},
+				 {612916, BMC150_ACCEL_DEF_RANGE_8G},
 				 {1225831, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
 	{
@@ -1119,30 +1121,30 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 		.chip_id = 0xF9,
 		.channels = bma250e_accel_channels,
 		.num_channels = ARRAY_SIZE(bma250e_accel_channels),
-		.scale_table = { {38344, BMC150_ACCEL_DEF_RANGE_2G},
-				 {76590, BMC150_ACCEL_DEF_RANGE_4G},
-				 {153277, BMC150_ACCEL_DEF_RANGE_8G},
-				 {306457, BMC150_ACCEL_DEF_RANGE_16G} },
+		.scale_table = { {38307, BMC150_ACCEL_DEF_RANGE_2G},
+				 {76614, BMC150_ACCEL_DEF_RANGE_4G},
+				 {153229, BMC150_ACCEL_DEF_RANGE_8G},
+				 {306458, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
 	{
 		.name = "BMA253/BMA254/BMA255/BMC150/BMI055",
 		.chip_id = 0xFA,
 		.channels = bmc150_accel_channels,
 		.num_channels = ARRAY_SIZE(bmc150_accel_channels),
-		.scale_table = { {9610, BMC150_ACCEL_DEF_RANGE_2G},
-				 {19122, BMC150_ACCEL_DEF_RANGE_4G},
-				 {38344, BMC150_ACCEL_DEF_RANGE_8G},
-				 {76590, BMC150_ACCEL_DEF_RANGE_16G} },
+		.scale_table = { {9577, BMC150_ACCEL_DEF_RANGE_2G},
+				 {19154, BMC150_ACCEL_DEF_RANGE_4G},
+				 {38307, BMC150_ACCEL_DEF_RANGE_8G},
+				 {76614, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
 	{
 		.name = "BMA280",
 		.chip_id = 0xFB,
 		.channels = bma280_accel_channels,
 		.num_channels = ARRAY_SIZE(bma280_accel_channels),
-		.scale_table = { {2392, BMC150_ACCEL_DEF_RANGE_2G},
-				 {4785, BMC150_ACCEL_DEF_RANGE_4G},
-				 {9581, BMC150_ACCEL_DEF_RANGE_8G},
-				 {19152, BMC150_ACCEL_DEF_RANGE_16G} },
+		.scale_table = { {2394, BMC150_ACCEL_DEF_RANGE_2G},
+				 {4788, BMC150_ACCEL_DEF_RANGE_4G},
+				 {9577, BMC150_ACCEL_DEF_RANGE_8G},
+				 {19154, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
 };
 
-- 
2.32.0

