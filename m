Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBDC189D26
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 14:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgCRNhl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 09:37:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33264 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgCRNhl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 09:37:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id r7so2342354wmg.0;
        Wed, 18 Mar 2020 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=43EnDEqOvNTQaVElWki6b7aWJraaV8Mamxc/TOhHBBk=;
        b=aRzNxqUCydwgpzyK/GwX4T+mHGnkjYP0xR4jHIHopGjMT7BELNt+DPc9vclxAdej4m
         smSA9VfUVrLVxQKylwNgVriXkSgfCPJqGN+Kdc+Z60DI7Muvw29N/bH/A/xcee1QsFup
         oxl++PURjVPGd6B4cCVfD6kHN7JN9MwOhhbQZCx0eztXbT4k/4eLMWrUktL3utfb6yuF
         xe/n6GkeSYH2Sd9NkrcwBkO7fI0+6rizznypGJKB51LoPNxl7XGyPtgk79JiS+aeUk+O
         aWWZF6trVp9ftVLIoLXFZrgHw0f4zo51F3ZDDorxIHyq3mkUUgqz2Wo2vvYcDJHescpv
         cYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=43EnDEqOvNTQaVElWki6b7aWJraaV8Mamxc/TOhHBBk=;
        b=tWeR3QBIwuWVwH9ZDmiyB/6NuefB6zMW672nXb+lIye5fqN9VtLkD6oZ/Suarp5+v3
         0FdZjIZG9szz92EdZj0NLHrDpw5BJauLI1UC2a+kCS0RtcoLBmQ+/Pigcdy8wkgj9J1C
         nlyrB4D7b1uQ1qSjwhhvB7+2RQqPbw5Qw2PEq0IJRC7JxOLZKDIZ3loX9H1xrfo1VOck
         G6b8ApqxRMJlk6ikAm54Cv3OPH3Uj6COyO4sFMdLRGJCUYl0PoM6pJ+hMTqamBE2eHdi
         exwWfCXV7Vr/QcqJ1V1OpsRa00PpNoD/P9PjyCDRkJ3GnVmuSgdtihiCfHmp9hEyteY6
         dDiA==
X-Gm-Message-State: ANhLgQ3792z7CL2RjiQ3UfbkRFfR1tcFNIcuAHOptEPwXk//nWZ5kTkP
        Y4/buSL3pIVUrpLOzbgzQfieZAeY
X-Google-Smtp-Source: ADFU+vslQnXxRNxVxe1fbt8lNLd1lnms6YrH2kzqbvyZKJknR2fsU37c2fg0WFgVgmhG7dTbv6QW7Q==
X-Received: by 2002:a05:600c:2244:: with SMTP id a4mr4995330wmm.147.1584538658482;
        Wed, 18 Mar 2020 06:37:38 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id f15sm9444002wru.83.2020.03.18.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 06:37:38 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael.Hennerich@analog.com, renatogeh@gmail.com, lars@metafoo.de,
        jic23@kernel.org, mircea.caprioru@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 4/5] iio: ad_sigma_delta: remove unused IIO channel macros
Date:   Wed, 18 Mar 2020 15:40:41 +0200
Message-Id: <20200318134042.30133-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318134042.30133-1-alexandru.ardelean@analog.com>
References: <20200318134042.30133-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Now that all channel SigmaDelta IIO channel macros have been localized,
remove the generic ones.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/iio/adc/ad_sigma_delta.h | 58 --------------------------
 1 file changed, 58 deletions(-)

diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 5a127c0ed200..a3a838dcf8e4 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -133,62 +133,4 @@ void ad_sd_cleanup_buffer_and_trigger(struct iio_dev *indio_dev);
 
 int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
 
-#define __AD_SD_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
-	_storagebits, _shift, _extend_name, _type, _mask_all) \
-	{ \
-		.type = (_type), \
-		.differential = (_channel2 == -1 ? 0 : 1), \
-		.indexed = 1, \
-		.channel = (_channel1), \
-		.channel2 = (_channel2), \
-		.address = (_address), \
-		.extend_name = (_extend_name), \
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
-			BIT(IIO_CHAN_INFO_OFFSET), \
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
-		.info_mask_shared_by_all = _mask_all, \
-		.scan_index = (_si), \
-		.scan_type = { \
-			.sign = 'u', \
-			.realbits = (_bits), \
-			.storagebits = (_storagebits), \
-			.shift = (_shift), \
-			.endianness = IIO_BE, \
-		}, \
-	}
-
-#define AD_SD_DIFF_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
-	_storagebits, _shift) \
-	__AD_SD_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
-		_storagebits, _shift, NULL, IIO_VOLTAGE, \
-		BIT(IIO_CHAN_INFO_SAMP_FREQ))
-
-#define AD_SD_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
-	_storagebits, _shift) \
-	__AD_SD_CHANNEL(_si, _channel, _channel, _address, _bits, \
-		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
-		BIT(IIO_CHAN_INFO_SAMP_FREQ))
-
-#define AD_SD_CHANNEL(_si, _channel, _address, _bits, \
-	_storagebits, _shift) \
-	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
-		_storagebits, _shift, NULL, IIO_VOLTAGE, \
-		 BIT(IIO_CHAN_INFO_SAMP_FREQ))
-
-#define AD_SD_CHANNEL_NO_SAMP_FREQ(_si, _channel, _address, _bits, \
-	_storagebits, _shift) \
-	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
-		_storagebits, _shift, NULL, IIO_VOLTAGE, 0)
-
-#define AD_SD_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift) \
-	__AD_SD_CHANNEL(_si, 0, -1, _address, _bits, \
-		_storagebits, _shift, NULL, IIO_TEMP, \
-		BIT(IIO_CHAN_INFO_SAMP_FREQ))
-
-#define AD_SD_SUPPLY_CHANNEL(_si, _channel, _address, _bits, _storagebits, \
-	_shift) \
-	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
-		_storagebits, _shift, "supply", IIO_VOLTAGE, \
-		BIT(IIO_CHAN_INFO_SAMP_FREQ))
-
 #endif
-- 
2.20.1

