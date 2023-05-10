Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D39B6FDB92
	for <lists+linux-iio@lfdr.de>; Wed, 10 May 2023 12:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjEJKXb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 May 2023 06:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbjEJKX3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 May 2023 06:23:29 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D584F44BA;
        Wed, 10 May 2023 03:23:26 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 236B986008;
        Wed, 10 May 2023 12:23:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683714205;
        bh=/WvgxSTBQJIYwkct9ItX5iqLZqd8FdduZoy1sgKWOlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sBmoUEQxacmg42e5UCufNA0Jcvur1NqUnfjmlawKTp+o9RZz4iaultGrvURPJue0K
         GTrQDD80m8cJZdpx02n0j7Lrj+n+DZGcQ/xR2OdlZMQgQeq9NtQypTZbqjgLt96U3I
         qDLsPHsayZ/mpmAo02yVt4OUJHxNu8jrXdJnWPS38Vy2HFX7EOR4t4mx1h1sCTjqHs
         tK0On+TcqernudAOvszzYa5/5ApFRFGmtjWmzUqgOwKiabxNfay61dglmq9SY1kKmy
         y2b9o2RfPvOZZumc8knfkPWqXSQ9qhXHmFMz7XtkOzTdED7ovNS5zDasXpDItCb+mc
         Jx3KlVwttz2LQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 4/6] iio: mlx90614: Drop MLX90614_CONST_EMISSIVITY_RESOLUTION
Date:   Wed, 10 May 2023 12:22:49 +0200
Message-Id: <20230510102251.10118-4-marex@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230510102251.10118-1-marex@denx.de>
References: <20230510102251.10118-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The MLX90614_CONST_EMISSIVITY_RESOLUTION can be calculated from
MLX90614_CONST_RAW_EMISSIVITY_MAX, perform the calculation inline
and drio the MLX90614_CONST_EMISSIVITY_RESOLUTION.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Crt Mori <cmo@melexis.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org
---
V3: New patch
---
 drivers/iio/temperature/mlx90614.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index b0f69a7b05abc..ecd27fe0c8666 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -63,7 +63,6 @@
 #define MLX90614_CONST_OFFSET_REM 500000 /* remainder of offset (273.15*50) */
 #define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
 #define MLX90614_CONST_RAW_EMISSIVITY_MAX 65535 /* max value for emissivity */
-#define MLX90614_CONST_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~ 0.000015259 */
 #define MLX90614_CONST_FIR 0x7 /* Fixed value for FIR part of low pass filter */
 
 struct mlx90614_data {
@@ -283,7 +282,8 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 			*val2 = 0;
 		} else {
 			*val = 0;
-			*val2 = ret * MLX90614_CONST_EMISSIVITY_RESOLUTION;
+			*val2 = ret * NSEC_PER_SEC /
+				MLX90614_CONST_RAW_EMISSIVITY_MAX;
 		}
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* IIR setting with
@@ -321,7 +321,7 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
 		if (val < 0 || val2 < 0 || val > 1 || (val == 1 && val2 != 0))
 			return -EINVAL;
 		val = val * MLX90614_CONST_RAW_EMISSIVITY_MAX +
-			val2 / MLX90614_CONST_EMISSIVITY_RESOLUTION;
+		      val2 * MLX90614_CONST_RAW_EMISSIVITY_MAX / NSEC_PER_SEC;
 
 		ret = mlx90614_power_get(data, false);
 		if (ret < 0)
-- 
2.39.2

