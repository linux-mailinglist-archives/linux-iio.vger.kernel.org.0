Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979C5222491
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgGPN76 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 09:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbgGPN75 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A71C08C5DB
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so7203410wrn.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5dhqQ4NUqiUF2Bq7q61YfGoR1xp2l5qeEphpBIwviqw=;
        b=dbPBBqXNQxXcdUjhThIupcj7hUT6HiWHQxF6DtZKhLxNXTxrJyHDZvy567mnJlko7K
         VmE/hBekbLstojqruJZVxnf54PwhVekIh/XpObFkAdGyJwnGImKh/34abAImwKgm5Qov
         ZfjW3T7836AVQjZzbwFVCqo+988ZUTbc87SV1+coaF05IaNm7YROzqhNIfSbv9IKmzRR
         Z5QLdS18fe7zcOUEVJc7RvYfYvCEoL1gwXRNpBvC209ybypJLdV+mN9YvMQSPdk8Ah14
         XTQCtff8XV3rpAXhCEF8VJKAezSkguRXjzpkXz7Do6lpcB37Q3aXv98Vt55GDPwaqB0R
         QEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dhqQ4NUqiUF2Bq7q61YfGoR1xp2l5qeEphpBIwviqw=;
        b=lbiT+OufKcV5oyF6av/t5YpPSH9fPFBfZcBKgKgdT6O7ukMhGRSTXb5IE8MvsKu8WB
         NtOy0td2pm//PreAqV04Lqq1LxbauHl7i4xCd8xBdEsGw1ZJMK+9cySnMXn6PBV6i9os
         RKxN116IS4lqGrTgPRe4lPN4tqF/mr24MHlNgLyot0Wkvw1V0pTCvxOKmVla/AoTMUOO
         SgW++zGxyXmhBo54/EA+hgosCejAkRxS6T4wwiARKMpioh89SeGZySeqrEnSMzahPyb/
         A/HAa+XuOb9BdfmpEzfwe1cwRhL6EhyQcX1OL2Lk0e3PcUyIi4rUJKZzhdwWbXzzn3t0
         HHyw==
X-Gm-Message-State: AOAM530/XnlNLc/xg1PEULFRtF7EVUaB/Zj3tiug0DKRRkm2rvyWgyzu
        bvJ5uhmjy257sjcEwlB14VDyaw==
X-Google-Smtp-Source: ABdhPJz7hGYComCkdeZkkyqBGf5Dge6AU5ApxQjr/rt5vC1UMsucySFQGpPQzmN4Uk9auol+JJ7QQQ==
X-Received: by 2002:a5d:6990:: with SMTP id g16mr5122440wru.131.1594907995889;
        Thu, 16 Jul 2020 06:59:55 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 19/30] iio: dac: ad5064: Fix a few kerneldoc misdemeanours
Date:   Thu, 16 Jul 2020 14:59:17 +0100
Message-Id: <20200716135928.1456727-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Misspelling, missing description and compiler attribute ordering.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad5064.c:71: warning: bad line:                         internal vref.
 drivers/iio/dac/ad5064.c:83: warning: Function parameter or member 'channels' not described in 'ad5064_chip_info'
 drivers/iio/dac/ad5064.c:125: warning: Function parameter or member 'lock' not described in 'ad5064_state'
 drivers/iio/dac/ad5064.c:125: warning: Function parameter or member '____cacheline_aligned' not described in 'ad5064_state'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5064.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index 303f6d1a5f311..d7109f8f52efa 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -68,8 +68,8 @@ enum ad5064_regmap_type {
  * struct ad5064_chip_info - chip specific information
  * @shared_vref:	whether the vref supply is shared between channels
  * @internal_vref:	internal reference voltage. 0 if the chip has no
-			internal vref.
- * @channel:		channel specification
+ *			internal vref.
+ * @channels:		channel specification
  * @num_channels:	number of channels
  * @regmap_type:	register map layout variant
  */
@@ -98,6 +98,7 @@ typedef int (*ad5064_write_func)(struct ad5064_state *st, unsigned int cmd,
  * @use_internal_vref:	set to true if the internal reference voltage should be
  *			used.
  * @write:		register write callback
+ * @lock:		maintain consistency between cached and dev state
  * @data:		i2c/spi transfer buffers
  */
 
@@ -111,7 +112,6 @@ struct ad5064_state {
 	bool				use_internal_vref;
 
 	ad5064_write_func		write;
-	/* Lock used to maintain consistency between cached and dev state */
 	struct mutex lock;
 
 	/*
@@ -121,7 +121,7 @@ struct ad5064_state {
 	union {
 		u8 i2c[3];
 		__be32 spi;
-	} data ____cacheline_aligned;
+	} ____cacheline_aligned data;
 };
 
 enum ad5064_type {
-- 
2.25.1

