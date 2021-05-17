Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C777B386DB3
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 01:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbhEQXgu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 19:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbhEQXgt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 19:36:49 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C741C061573
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 16:35:31 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id v5so9269001ljg.12
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 16:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDsfl8BtnMrIaPegpt8K35ViaVv1v2HfOtAAQSHJJnQ=;
        b=dM5HTpqTzypLbOt2sI0RVqq7FaMCqVr9GfnOtlMgM09omyNxB8EZNVGiOpu64DOChU
         RUV5IjNhDYXGJ9tZksPZTxhnVtcPi2JEExnp0z7tW2lCcwjCRw2QlxNvB3DaEG1NhMim
         P+fa2wETZXUdfuJS3zrDfGomrWoAdTUg/ilj3mea/QBVg+JwiMRYuJPS9NFnYy34js1t
         3PqeYyJiswyPkBSwiRHlGfrlMOOwYGKwSqxYIRKnbbf8bTLROAXL1qW9kBxO5rmbtHrW
         Q2ikiRXDAQHkbVbBs4UFxM4vo1Hb6BD9FgzQU1u6XDTuzan0qSqTZoKokJrkuZnOlg5E
         yetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDsfl8BtnMrIaPegpt8K35ViaVv1v2HfOtAAQSHJJnQ=;
        b=FHETR7uxAn0kBTxps+MNKtry9pE9ZwGDwk5tU/BZrTqcX726AB5e7/2efHFaWQdfAL
         JuSsXosVSw9UV5pH2Ngt9hBYHvoVLcdL7OoDlTwJX0MLwL6xN6MW7NZLTFo2Q9CWiyca
         qfrM2JO+IaQOBMQsu74e7SCbMKceByPjrFMlImwu1xtHTOCBGrOdp557nTiwFrPibiTW
         0inxDWjs3umqEU429WobspTecoDe/yJNfqzcrBekCM5pIjUG7+c8TqLNt81RTIYA1XQe
         Rr9+7hTzfQo/KvTsrmYceU91JzbUCJAvFduIc7Ou3jo/B+qweiLtGKB7oEPPBu9sF22q
         uBrA==
X-Gm-Message-State: AOAM532u/QV0Ev8dgWqqm+ITPENYb512P+mYIDCGw9L8+J2s97xpGL61
        TgYekcw6yNvxe1xF5THGs3UkZw==
X-Google-Smtp-Source: ABdhPJyaisHV5NEBBUZ9qIUyF1/UMcgWZgMh/aRySgBD+81/16Okkvm3Mwm5WRf4K5x5A1Q1LTrxBQ==
X-Received: by 2002:a2e:9dd7:: with SMTP id x23mr1528825ljj.79.1621294529921;
        Mon, 17 May 2021 16:35:29 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id r10sm168425lfe.110.2021.05.17.16.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 16:35:29 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/5 v2] iio: st_sensors: Create extended attr macro
Date:   Tue, 18 May 2021 01:33:18 +0200
Message-Id: <20210517233322.383043-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Extend ST_SENSORS_LSM_CHANNELS() to a version that will accept extended
attributes named ST_SENSORS_LSM_CHANNELS_EXT() and wrap the former as a
specialized version of the former.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Daniel Drake <drake@endlessm.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- New helper patch from Stephan.
---
 include/linux/iio/common/st_sensors.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 33e939977444..704217a5c3ba 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -46,8 +46,8 @@
 #define ST_SENSORS_MAX_NAME			17
 #define ST_SENSORS_MAX_4WAI			8
 
-#define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
-					ch2, s, endian, rbits, sbits, addr) \
+#define ST_SENSORS_LSM_CHANNELS_EXT(device_type, mask, index, mod, \
+				    ch2, s, endian, rbits, sbits, addr, ext) \
 { \
 	.type = device_type, \
 	.modified = mod, \
@@ -63,8 +63,14 @@
 		.storagebits = sbits, \
 		.endianness = endian, \
 	}, \
+	.ext_info = ext, \
 }
 
+#define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
+				ch2, s, endian, rbits, sbits, addr)	\
+	ST_SENSORS_LSM_CHANNELS_EXT(device_type, mask, index, mod,	\
+				    ch2, s, endian, rbits, sbits, addr, NULL)
+
 #define ST_SENSORS_DEV_ATTR_SAMP_FREQ_AVAIL() \
 		IIO_DEV_ATTR_SAMP_FREQ_AVAIL( \
 			st_sensors_sysfs_sampling_frequency_avail)
-- 
2.31.1

