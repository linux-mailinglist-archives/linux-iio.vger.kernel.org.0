Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7CD54CBE5
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 16:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343825AbiFOOyJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 10:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245684AbiFOOyF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 10:54:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C9A192A8;
        Wed, 15 Jun 2022 07:54:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cn20so4134776edb.6;
        Wed, 15 Jun 2022 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MwALs328k5FgzGUpRLgAC7GTidVE3+ciCtqMSNIegDM=;
        b=G2nX8wBavzgiVm6qTk1feiExebIzlkjg+FBWWSvFbv+jF9W46cGBsT9qMpUpTBV326
         yc3jvYXU82fr9FTDaIVgkYVWArGJPvROfORPuc+8g/JlNLenzx6Ni5wbdwRqnGlBoXfW
         KmeQ5tBqdvxWUgSzqk3dszkshF6I6bY7l84SaChfQOgQWjLqltMgOmLoHZNXYp8hMqBy
         j0gQ9wAngvkwp0BhYaptnwR9Gc48q05muKENmCfYRL0uTiQ6T9ILjUSjB++JE26rVgD9
         EylcblpkVQk2GteelK+92jYYNQFS+D2rt6fyLrVvoaa9fI2oXYOfCLxSlHCY2cZwspn0
         XQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MwALs328k5FgzGUpRLgAC7GTidVE3+ciCtqMSNIegDM=;
        b=4sata1W4XH+DemI0UQAaLhg9/E2B1RrZDRzpQBhNd5uqqT4dNm8Wx27lwGmowCpW+/
         edtjeTFkHoBxM2UpPhmWKtQqxiQkVInT4UcQOpfib7s92F91xIPy6uuqhMO5ViRwBJjC
         zyFekPhTQEvJFND4oKYr1esfKGXNPW+8Wfp5g1LsGrKDcwsDRDatf501FEWKBqlng5j2
         BS94H5OxmAA93bVbNHcL3Q7fH6JmTefFwDcCpGh22Xtp7RtulMGvUnksNtaiFnrrZcAC
         eHitYFJPSazQLDy3XoKa56JhG5GZNVTfbCJaIeSczOngARznlsMTIR70nv05iErY83RI
         P0gA==
X-Gm-Message-State: AJIora/RDJrKMdZFXXPR9TxdvYWLhEBvT1TrwWub5fZ65OTuTRXmktxL
        ud0aDPxuDWbYYQr6v8gdc4Y=
X-Google-Smtp-Source: AGRyM1u1fduoraB7MKRy6ed5uPlr6OO0A2s4x7C296lPSViw5q5cjlKNDRntfDzR7+C9sbGmIszBMg==
X-Received: by 2002:aa7:cd46:0:b0:42d:d73d:be8b with SMTP id v6-20020aa7cd46000000b0042dd73dbe8bmr121475edw.85.1655304843058;
        Wed, 15 Jun 2022 07:54:03 -0700 (PDT)
Received: from localhost.localdomain (p5dcfe5fe.dip0.t-ipconnect.de. [93.207.229.254])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709063a8200b00706287ba061sm6341665ejd.180.2022.06.15.07.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 07:54:02 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v3 1/6] iio: adc: mp2629: fix wrong comparison of channel
Date:   Wed, 15 Jun 2022 16:53:52 +0200
Message-Id: <20220615145357.2370044-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615145357.2370044-1-sravanhome@gmail.com>
References: <20220615145357.2370044-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Input voltage channel enum is compared against iio address instead
of the channel.

Fixes: 7abd9fb64682 ("iio: adc: mp2629: Add support for mp2629 ADC driver")
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mp2629_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index aca084f1e78a..e7fbfe92e884 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -73,7 +73,7 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		if (chan->address == MP2629_INPUT_VOLT)
+		if (chan->channel == MP2629_INPUT_VOLT)
 			rval &= GENMASK(6, 0);
 		*val = rval;
 		return IIO_VAL_INT;
-- 
2.25.1

