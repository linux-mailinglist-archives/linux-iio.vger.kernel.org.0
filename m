Return-Path: <linux-iio+bounces-21496-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1650AFF6B8
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 04:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2AF1C46ED1
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 02:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E99E27F74E;
	Thu, 10 Jul 2025 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uBUs+n7u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5A627F017
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114035; cv=none; b=aSYhC7lkqxLhVVSnwnRxuRsSuengyiEOnkhAgA1CAl9yMouMsI8W4+DErpKdgoK1nUlJL0sGE84o+WWGtCTV7rM/8Cym4W0fXC+9JNpPdOSZYym31RiATuLsb5pV0U859meBKKiv0X40NBIP+tAjzCPMyWgj1s3OVGMEZH1/H+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114035; c=relaxed/simple;
	bh=PrdYl6cL5ELmEcjkN1E1wVLyUoxLSD2mgLWQ/8TLt70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTE0VY24IvLTZfDRe5x0B3lUfTIAsxtwQ95SINiyYQ5BEGmYWYNUgynWEQAOIBG1hsbEUhSN9ho9cxJ+KWo0AT2FMVo1Qvan3f0ISL2xIhmCbWCFbRATuCsCf8KGp+LibeMmo4AWb7jEKX6Ebd+Z78lIBFNuUokScGkvlujh5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uBUs+n7u; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-61390809a36so166026eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 09 Jul 2025 19:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752114032; x=1752718832; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=La38bpNvym9P0SG4sHe+uHRcxOOSKpxAGmg4JaBHWlQ=;
        b=uBUs+n7uWPvdJzywIwtg2RnDgue6mQqp232seMWzRBJECTugH11a6eSocr+84pPCRM
         PsRwOXEyi18GeTfDgFwZvj77+XF1Tn0UOP/dT6eLMyrOS14UQvuZoEuQbFLPWSWtJhoM
         RtVNmMe4jkVzhK2+EyvEViDNQfshTPhbe8fHNcreV1eAx7TjjCzRiMnP1Pm34FiYVY2H
         K+EnQmaaWbV4aUG1TeFfjl56LcCg8J8RJkRV8TAya6y06IHRbdLnn3bji7COSc/97mP5
         5SKUp/4FkLw/avqYB8X3QabyOlg0arrY0xnQusw7dVBNlwqClpZqbtURlGVdis+5DGSS
         j2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752114032; x=1752718832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=La38bpNvym9P0SG4sHe+uHRcxOOSKpxAGmg4JaBHWlQ=;
        b=PqhDpL4DZbbzXNtjqBmvf9KPB/cyxdtfreVI61VQxjlbWXIMOEguQVXrSN2XYLlYGP
         hBBn2TA+RLa5/0GqbOQ8w4FSRucRGInE8rQqKUhgPFegg1fLmpXm5JuD0CeOnIILpLpK
         yr4DD98AP5XFvtM+bbFKMwtvIzdcorlWWOAq9R45SOUoU+LTTadTIWI6SNnPe5ZOOTgu
         4NEL7cYKmQU5+6DoXcypgPz0welqlT0zpr3qcxpmfZ2PRZnOvd81E7DI4jj/m4oSPpfs
         JAG3u2SwUVimZyXaxLg8Z4+cXbIJZBJVq/13NmYSIGOvrGNMUg6HlKZqbjqHcKJUAF0X
         0FGw==
X-Gm-Message-State: AOJu0YyLmrfofEff2fgVnGLot20wtUsl9oCJo5Xrhht7BvIJ+o+rtEH4
	5exBHCmI0hIM4Q8GiUQIx3B7RCT+sQObAL0JnSyA6JMVr0RlpttrvI8NAIoVAEuIzyyN9SdPNuU
	3a9stJA4=
X-Gm-Gg: ASbGncvE+FdwsYypIYd05Ng0JhlKp9/W+V0e01OFuGfCnODy8bcEXiYmLsQKqeZSNiT
	D7r5qsPkg2Y2tUJoeMQZfwtLGzicee5gJNzDg2yxBtUfdXzOZdDYs2H43P4zQ5+qZym86L9nnDr
	aP+LAVlVn6YgNp9KNN1bK0+VlGFJaj3j2G62WymgnV8cJcFTcUmDP4XbMKhQ6HVbzt5oXkM3H75
	tR3QaWVfapli4i93XXrKnmdlze1IlZLvJ3K2uhfXT/2vpHdaymw/0Jc+zuNNixC5pw0RWcmSeXz
	smoFNTL+8U0gjn5c7HjZ8G7fprJXpIpEyXmgx32ey2gxUaPRMkgEmNPG2VUj17/0QKJA
X-Google-Smtp-Source: AGHT+IGED0OyDkTZlJZY6bL6UdAlzshsytNE4n6qwY8n7ay5Z6rl6ikJKtV7hvy1K4dtPURwN3dwtw==
X-Received: by 2002:a05:6820:4b89:b0:613:c922:32c6 with SMTP id 006d021491bc7-613d6e13bf0mr1535420eaf.2.1752114031791;
        Wed, 09 Jul 2025 19:20:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:6f38:cf8f:abb1:34f7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9f00d46sm66972eaf.22.2025.07.09.19.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 19:20:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 09 Jul 2025 21:20:00 -0500
Subject: [PATCH v2 1/2] iio: imu: bno055: fix OOB access of hw_xlate array
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-iio-const-data-19-v2-1-fb3fc9191251@baylibre.com>
References: <20250709-iio-const-data-19-v2-0-fb3fc9191251@baylibre.com>
In-Reply-To: <20250709-iio-const-data-19-v2-0-fb3fc9191251@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andrea Merello <andrea.merello@iit.it>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=PrdYl6cL5ELmEcjkN1E1wVLyUoxLSD2mgLWQ/8TLt70=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBobyNdqlts8HOoSJGjEpUG0vkpz3w/6lOCHab6J
 x/NMV3xG/WJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaG8jXQAKCRDCzCAB/wGP
 wJZlB/9NBd9Xls/tWIsMyNt2QblowGb92oV81hUIFWXripSyeMN93WZ6cfo1basvQJg4g453W4H
 N9q9aeMYlFwXEBVhANdBQYP5pbMD7Z1PPgMFzP+ZKcCfArjMU+ofRaXgOcJIaEg3DxSmTPlHwXX
 WGobVVtPOBsUVwUjIlm4coJjwBPQ4NHECXtsce9sWUnbhW/bjqk0hA0gwP0jwcmRTe05WKVHetR
 NfBTkbVK2c/hsPqhQM/LSqto5WgpF+Df1+ERLe7FZ4uha6V0J2GtfV72uuQvAMdXi2MJOKT9WMe
 92/yxsnyh5GOmn6SZH1AD+7Zy6ef6uaeAJ8dAY1FPRdBcEkd
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix a potential out-of-bounds array access of the hw_xlate array in
bno055.c.

In bno055_get_regmask(), hw_xlate was iterated over the length of the
vals array instead of the length of the hw_xlate array. In the case of
bno055_gyr_scale, the vals array is larger than the hw_xlate array,
so this could result in an out-of-bounds access. In practice, this
shouldn't happen though because a match should always be found which
breaks out of the for loop before it iterates beyond the end of the
hw_xlate array.

By adding a new hw_xlate_len field to the bno055_sysfs_attr, we can be
sure we are iterating over the correct length.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507100510.rGt1YOOx-lkp@intel.com/
Fixes: 4aefe1c2bd0c ("iio: imu: add Bosch Sensortec BNO055 core driver")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/imu/bno055/bno055.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 3f4c18dc3ee983fe3c5569406a2c6350b0cc756c..0eb5e1334e5564284c7f4bf560424b5ec734903d 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -118,6 +118,7 @@ struct bno055_sysfs_attr {
 	int len;
 	int *fusion_vals;
 	int *hw_xlate;
+	int hw_xlate_len;
 	int type;
 };
 
@@ -170,20 +171,24 @@ static int bno055_gyr_scale_vals[] = {
 	1000, 1877467, 2000, 1877467,
 };
 
+static int bno055_gyr_scale_hw_xlate[] = {0, 1, 2, 3, 4};
 static struct bno055_sysfs_attr bno055_gyr_scale = {
 	.vals = bno055_gyr_scale_vals,
 	.len = ARRAY_SIZE(bno055_gyr_scale_vals),
 	.fusion_vals = (int[]){1, 900},
-	.hw_xlate = (int[]){4, 3, 2, 1, 0},
+	.hw_xlate = bno055_gyr_scale_hw_xlate,
+	.hw_xlate_len = ARRAY_SIZE(bno055_gyr_scale_hw_xlate),
 	.type = IIO_VAL_FRACTIONAL,
 };
 
 static int bno055_gyr_lpf_vals[] = {12, 23, 32, 47, 64, 116, 230, 523};
+static int bno055_gyr_lpf_hw_xlate[] = {5, 4, 7, 3, 6, 2, 1, 0};
 static struct bno055_sysfs_attr bno055_gyr_lpf = {
 	.vals = bno055_gyr_lpf_vals,
 	.len = ARRAY_SIZE(bno055_gyr_lpf_vals),
 	.fusion_vals = (int[]){32},
-	.hw_xlate = (int[]){5, 4, 7, 3, 6, 2, 1, 0},
+	.hw_xlate = bno055_gyr_lpf_hw_xlate,
+	.hw_xlate_len = ARRAY_SIZE(bno055_gyr_lpf_hw_xlate),
 	.type = IIO_VAL_INT,
 };
 
@@ -561,7 +566,7 @@ static int bno055_get_regmask(struct bno055_priv *priv, int *val, int *val2,
 
 	idx = (hwval & mask) >> shift;
 	if (attr->hw_xlate)
-		for (i = 0; i < attr->len; i++)
+		for (i = 0; i < attr->hw_xlate_len; i++)
 			if (attr->hw_xlate[i] == idx) {
 				idx = i;
 				break;

-- 
2.43.0


