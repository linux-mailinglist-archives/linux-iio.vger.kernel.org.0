Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF452224B0
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgGPOA5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbgGPN7y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3794C08C5DD
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so7168408wrp.7
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HmsMpTwfL7pGfzUHY+3b/NowLtKwAcX5ohfQKTrGvPA=;
        b=laIysYMMocgn89Hv3NkjP1Jq0QAhgj4ZVjNxfrrMJwCnUv/WsLO4F2Nkr/wHPuNIUg
         mP+NeoGVihsczpizzfCPJKw6wPE1V3cKXk5EpzHoeJ1HkZIaOS8M1t1xog85/GqpcNLf
         WexHvrrAju7qfYLVBi1PbvzLB9kTTalqx47jC7JWPXtX7GskIYX4SkzKYNXvrXxTSg66
         6NeHZk/b09GWq23D5NuCfI/3AdMEZnxvbXGwWmnihzJjUR5U5YqbxYeswhqywylnmJeS
         C2zHSDSrJsXvxTwdsS0MrWavEpFi2BTcNF9FhUmK2BtFH+nJwzguJQM4Edwc9txNVjvf
         O6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HmsMpTwfL7pGfzUHY+3b/NowLtKwAcX5ohfQKTrGvPA=;
        b=Xxa+v4SarekYmgwy8qYGhBYYeZr5xiJlAucD/r+KmOVDTXyrEYCmBMkBQODDU93LO6
         1v7B4oFOUkVQXYmnuzPmwu8NyiB4MTmlML2/x8T+hSndzxua7shHfhU3jpUNf2OOarqU
         OBsthOSHjweiBLFNHQNmUs5t4VB+zMljz/LLWFTznPqVk7bxN0r7pYH2o0HZxDu0J6aa
         76o3Da5HnWu1TA9V3bvmR9+noYlmy9AFqmnQlI92gYiSyORungscRbcHDs93wsoJMiM1
         8OJG10ZxPadfrAGcLFrxDzPplirXMZwoNARJKa4EQX/TbVo86YD9Le6mf/1ndl/MYMM2
         3MLA==
X-Gm-Message-State: AOAM530AQVt9Ml7fMvdaDZn54471QHEBugGIw7xTVWsJqmJHdmpnWgot
        LLV3eoQhlugVD8HAFYYRIrjkHw==
X-Google-Smtp-Source: ABdhPJx3xo8ont4fyIRFtPaHaTq3DoVh4R/yBthdWhJ+fV6UOuEkvSnBzCLHALtNNJeLVQx1vYiUdA==
X-Received: by 2002:a05:6000:1190:: with SMTP id g16mr5000111wrx.286.1594907992627;
        Thu, 16 Jul 2020 06:59:52 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Subject: [PATCH 17/30] iio: adc: ad7949: Fix misspelling issue and compiler attribute ordering
Date:   Thu, 16 Jul 2020 14:59:15 +0100
Message-Id: <20200716135928.1456727-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kerneldoc gets confused if the variable does not follow the
type/attribute definitions.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/ad7949.c:58: warning: Function parameter or member 'indio_dev' not described in 'ad7949_adc_chip'
 drivers/iio/adc/ad7949.c:58: warning: Function parameter or member '____cacheline_aligned' not described in 'ad7949_adc_chip'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/ad7949.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 2c6f60edb7ced..a3fc42617feb9 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -39,7 +39,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
  * struct ad7949_adc_chip - AD ADC chip
  * @lock: protects write sequences
  * @vref: regulator generating Vref
- * @iio_dev: reference to iio structure
+ * @indio_dev: reference to iio structure
  * @spi: reference to spi structure
  * @resolution: resolution of the chip
  * @cfg: copy of the configuration register
@@ -54,7 +54,7 @@ struct ad7949_adc_chip {
 	u8 resolution;
 	u16 cfg;
 	unsigned int current_channel;
-	u16 buffer ____cacheline_aligned;
+	u16 ____cacheline_aligned buffer;
 };
 
 static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
-- 
2.25.1

