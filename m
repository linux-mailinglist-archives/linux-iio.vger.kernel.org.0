Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708503882FC
	for <lists+linux-iio@lfdr.de>; Wed, 19 May 2021 01:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhERXKp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 19:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhERXKo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 May 2021 19:10:44 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AD0C061573
        for <linux-iio@vger.kernel.org>; Tue, 18 May 2021 16:09:26 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j6so13541033lfr.11
        for <linux-iio@vger.kernel.org>; Tue, 18 May 2021 16:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sBsrVwO0k5vVZzlL5NsGIsZu5azbZRJ873wXp6wLn/A=;
        b=pYkcidfCvZVXRbWO95anHPTNaoUwEzZHPw6AfqLTzozaT2IQv5p7NMsQDP5UBAeE4l
         di6ibyOTrDpuBQEywQSSSqeJABdG0PG3qPh9sFmNhoMcOHAY0OWEU4NH6LNBaBr6GmSO
         vxBfBm3sH6TEDskP7nbVwrIFyAOCqlBmPdkun5cKHS/ee55AwN8GN/rwvKgRc+gdhlqh
         XjCA4W2pyA6TLKr4qyTigNGWO+EWw+ObAUC+50z6yQwERWOFTHsLlcoJqZOFj7hTZaAC
         BFEHLjFP2N1rhab42U8BqbFQSn3jSlHtRa3rVGNuhLiriItF6h/g4aInczk/FKxhZAnQ
         gDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sBsrVwO0k5vVZzlL5NsGIsZu5azbZRJ873wXp6wLn/A=;
        b=EzXpV1YeR+Paet6z7GD7s4OztE0GSExjc4eylx6izXkIglhaqTFuScbZYBXR2mu/ga
         Cxnk9nzTnwSDP6i7w4w3lYR565BmGbmN1NZKg9s/8Ldl70fUQ8rMWh38PL5H8GiBmM6Y
         EuCcljczWqDeaLDHglbFc3D1n5y7w0fjNLf1oBQQ8qY7b1WJxjOaO5E7xsvErMCLS/2H
         vsYUwukn/EZsXjG4YYFIUc9EXa0LmylDWHm7UW6ZPJgGuw5CCzwuSag9R07AzWgxIGtD
         A5uI70o72tVqxQr3qtOYYwVXuqczn0YaNovn+Dan5JgzyL/afhiHDfjSdxjr9kcH1lmn
         N7WA==
X-Gm-Message-State: AOAM5319/Gd/aTGiZenBrPGNQzLCrjgXRtfcKjHxsBJEP5ahWBJQM5bZ
        Bz+ZCrrImGoVdp4s5RhGdKoYTA==
X-Google-Smtp-Source: ABdhPJxybEAgmduwxASSqQLbhdhyq9McdC3OAaZN974uxA74lVTZsK5CJsbCopshJzb/w4Nl8RDqKw==
X-Received: by 2002:a05:6512:3e3:: with SMTP id n3mr5525944lfq.169.1621379364668;
        Tue, 18 May 2021 16:09:24 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d10sm1666392lfi.79.2021.05.18.16.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:09:24 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/5 v3] iio: st_sensors: Create extended attr macro
Date:   Wed, 19 May 2021 01:07:18 +0200
Message-Id: <20210518230722.522446-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Extend ST_SENSORS_LSM_CHANNELS() to a version that will accept extended
attributes named ST_SENSORS_LSM_CHANNELS_EXT() and wrap the former as a
specialized version of the former.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Daniel Drake <drake@endlessm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Rebase and resend.
ChangeLog v1->v2:
- New helper patch from Stephan.
---
 include/linux/iio/common/st_sensors.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 0b9aeb479f48..8e0d76b42db9 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -48,8 +48,8 @@
 #define ST_SENSORS_MAX_NAME			17
 #define ST_SENSORS_MAX_4WAI			8
 
-#define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
-					ch2, s, endian, rbits, sbits, addr) \
+#define ST_SENSORS_LSM_CHANNELS_EXT(device_type, mask, index, mod, \
+				    ch2, s, endian, rbits, sbits, addr, ext) \
 { \
 	.type = device_type, \
 	.modified = mod, \
@@ -65,8 +65,14 @@
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

