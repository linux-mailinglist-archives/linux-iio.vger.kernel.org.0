Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE9A189D1E
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 14:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgCRNhi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 09:37:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54512 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgCRNhh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 09:37:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id n8so3401291wmc.4;
        Wed, 18 Mar 2020 06:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PR2Dx4JJczYBzXPLCpd2saEeBdJWRyPIAxRYGmlSBHk=;
        b=OpWAwC08VQH5fnuStY7Wf973ZBfDQd8hcSkwZVh6PwZXr9sk5c/ozGEo5duxIM+0XV
         1AwPdOTXahyyrNeW1NcaIgguG/RrRe88rnirEDSaZAngZlxr5i5+YYtoG1hfLGlOntm5
         2WgsXQv9mPwnTwfCGJIPw5+Had37iUsfNQLkS0sthUyGYgsCf3YzdvR0WcJyIqOnrQxz
         v378FCm7elVEDd2ebaUR5rYspqddq0XOQ/BTjbyDPPtCUSJNR78ey9PABBe5Wt2tvFP5
         Yzwr9dXpjVkgXvMzH5evNj84dH6ooniI/DrBHc0d+Yl7TM2AavFt3EBKIWh2eMdhGEt2
         kV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PR2Dx4JJczYBzXPLCpd2saEeBdJWRyPIAxRYGmlSBHk=;
        b=uVjjTjollIJ7EbHS7OApluIbubopWVx8CoCnob9uq/0t2tww4OrIg0zYYMlcABhuTY
         dqgrN7hBxzxLV9yZcppGSCctGC54VjhOzJsa0soZZlML5iuAIKERpdN+i3aXa/PLMoz+
         Jw8fO/PlS+WakZhDOANSgCHl+x+H+yiTKCwLU8H4acjuP+0C8/sDPZkd5fQgTjvB/XxW
         zVTbzQoSHRRnxnmzT7xRYVElff1PU+HBbgS3ATvG75ansUTAnArMob4fAtYAnzctJK7S
         7VCvi2vcegeIkZmp6nZbI66VjgeZZC1FOUp+fo+5+LGLcMR04LtezO+s1uKv2sY0jzNC
         1tfA==
X-Gm-Message-State: ANhLgQ31LiEMvRWaXFyQDMwFo3OLhBG+gfF0KJ4/T2G2FOg1UC8Il7R8
        yVGnVwOMto4DE5KGsnorSR+DMKql
X-Google-Smtp-Source: ADFU+vstFsptAKsAMum3FEShJXVbPl+v4MkW3NRy60uOOIeRD+O1zziYw/k9G6ZxOXqH4EkUjHj74w==
X-Received: by 2002:a05:600c:290f:: with SMTP id i15mr5071254wmd.113.1584538655129;
        Wed, 18 Mar 2020 06:37:35 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id f15sm9444002wru.83.2020.03.18.06.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 06:37:34 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael.Hennerich@analog.com, renatogeh@gmail.com, lars@metafoo.de,
        jic23@kernel.org, mircea.caprioru@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/5] iio: adc: ad7780: define/use own IIO channel macros
Date:   Wed, 18 Mar 2020 15:40:38 +0200
Message-Id: <20200318134042.30133-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318134042.30133-1-alexandru.ardelean@analog.com>
References: <20200318134042.30133-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change gets rid of the AD_SD_*_CHANNEL macros in favor of defining
it's own. The ad7780 is quite simpler than it's other Sigma-Delta brothers.

It turned out that centralizing the AD_SD_*_CHANNEL macros doesn't scale
too well, especially with some more complicated drivers. Some of the
variations in the more complicated drivers require new macros, and that way
things can become harder to maintain.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7780.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
index 291c1a898129..f47606ebbbbe 100644
--- a/drivers/iio/adc/ad7780.c
+++ b/drivers/iio/adc/ad7780.c
@@ -206,10 +206,29 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
 	.irq_flags = IRQF_TRIGGER_LOW,
 };
 
-#define AD7780_CHANNEL(bits, wordsize) \
-	AD_SD_CHANNEL(1, 0, 0, bits, 32, (wordsize) - (bits))
-#define AD7170_CHANNEL(bits, wordsize) \
-	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, (wordsize) - (bits))
+#define _AD7780_CHANNEL(_bits, _wordsize, _mask_all)		\
+{								\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = 0,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+		BIT(IIO_CHAN_INFO_OFFSET),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.info_mask_shared_by_all = _mask_all,			\
+	.scan_index = 1,					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = (_bits),				\
+		.storagebits = 32,				\
+		.shift = (_wordsize) - (_bits),			\
+		.endianness = IIO_BE,				\
+	},							\
+}
+
+#define AD7780_CHANNEL(_bits, _wordsize)	\
+	_AD7780_CHANNEL(_bits, _wordsize, BIT(IIO_CHAN_INFO_SAMP_FREQ))
+#define AD7170_CHANNEL(_bits, _wordsize)	\
+	_AD7780_CHANNEL(_bits, _wordsize, 0)
 
 static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7170] = {
-- 
2.20.1

