Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A5929E5BD
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 09:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgJ2IDX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 04:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgJ2IBA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 04:01:00 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6C4C0613D2;
        Thu, 29 Oct 2020 00:51:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x13so1647346pfa.9;
        Thu, 29 Oct 2020 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NGq3AUw6ysMha/FfRYSK0ItKsIwpDFgIL0/PfPvnWrU=;
        b=bnVSoLrbLDKak3wbA067m2XQ+pNeAm2plBFMKyCKdA6CEgzhXD/wXBT5lXDx0F+8u+
         xYegieS/ReMqYyfPoM2IYge7/7qvFLjd5p4NxLM1GxnEauDnW2+Qrwu+tn3YNmWONFRY
         TgS5K0YsDv7YYNr/facwK8WQaHhPXtmjgYdq+u34vTR9EUf3NDDQ5eKeO1zV9VpaNhEs
         9KtXX4PvOatAAYC5gUr9/ubfqsegV5th2OOTUNWlDOawIAPSzAw4xbzfxBij0rwLPFUM
         2xchontH33wuSdahu4mOyCKEF9c1qMiITDcq6/FB4VQz3YMJZkirx1xBZxhj28bGLJfS
         I/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NGq3AUw6ysMha/FfRYSK0ItKsIwpDFgIL0/PfPvnWrU=;
        b=I6XfreYes1usXx0YnKXA+rxW/+rCfVj8BRkIUdVWPmhpe2tjyL6RI7eoCrfHgg1WMO
         UFNRquzhd3kHcIfmGAaKLiDJRAh1lnmqdL3B7f5Q2/BTtiR22646x41TF4OZXfONiQ1v
         TgRwlCOfLuCynU8aG6yZ73WAjSd0QvRlAF0AS9IF52vuEnDPY2mX0NTThDR0rMx5IPnI
         vnhU5ALZkvRN56q8oH/DrcHlrgHRURF7bGyWrzJVeMnesaKus4mA77ohu3nU20E+pS7g
         jPy1iytojKoN+nU0FLirzpB+bI9trZPQ1/aDrsxFuxij1b8IbGErvModjpwwOT7SlVCb
         4/DA==
X-Gm-Message-State: AOAM532fmPqraGAbOwQwFLyU8tQ0MXnLM11PjEhjhBBBnD25PdqFIkQN
        mJsR9Xzsw9qIbOLoX+AVYfQ=
X-Google-Smtp-Source: ABdhPJyuOhugn9EpUqKcAqFDBehBdUAOq+V9klQLT4mpZNvgrUWTycwVHeRUf0JZ947fMhy6rQ4NGA==
X-Received: by 2002:a17:90a:b303:: with SMTP id d3mr3056205pjr.207.1603957872363;
        Thu, 29 Oct 2020 00:51:12 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id y1sm1932947pjl.12.2020.10.29.00.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:51:12 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 10/15] iio: adc: stm32: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:49:05 +0800
Message-Id: <20201029074910.227859-10-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074910.227859-1-coiby.xu@gmail.com>
References: <20201029074910.227859-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/iio/adc/stm32-adc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index b3f31f147347..42f9013730f8 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1988,7 +1988,6 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#if defined(CONFIG_PM_SLEEP)
 static int stm32_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -2018,7 +2017,6 @@ static int stm32_adc_resume(struct device *dev)
 
 	return stm32_adc_buffer_postenable(indio_dev);
 }
-#endif
 
 #if defined(CONFIG_PM)
 static int stm32_adc_runtime_suspend(struct device *dev)
-- 
2.28.0

