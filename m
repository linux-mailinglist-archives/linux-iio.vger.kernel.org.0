Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89A97776BD
	for <lists+linux-iio@lfdr.de>; Thu, 10 Aug 2023 13:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjHJLTt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Aug 2023 07:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbjHJLTp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Aug 2023 07:19:45 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6300926BD
        for <linux-iio@vger.kernel.org>; Thu, 10 Aug 2023 04:19:38 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52364e9daceso937031a12.2
        for <linux-iio@vger.kernel.org>; Thu, 10 Aug 2023 04:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691666377; x=1692271177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/V6DFLyPW5fTIkeZjgzXaCtA05evTZi9HkMiecIQIJk=;
        b=yB54i3REUJbfaQLBZhuqVUpmrZXczDHxzG6U3nYFJfE4z2FNWo3kSa7jt9xHN+lEPK
         AJ3WsOhR5RO/5jgkkRRT48LaeqE8lIjB7Lh0GQ8NxfLGnaBnoNs2Nqq0LdslCmSjylVE
         trhwtL3pXOdYB1rFcdoWRyfIXvRZSjL0SWlwapBpjRBsrJiF/SH3ikZXXdZLVTbKpbMV
         qby8IoA9fC+QLrBMXhLnvsvtaHTnSehSxpwxBkF2Oc+Rdu3U9pPz0eg2Ze+grqBtCJAp
         uvfcz0eakNfSylysYASjhw968yy4eeB+g4s2jNrM4zzQ7ZOAzgdn06hGd37lLHji64Wj
         rUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666377; x=1692271177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/V6DFLyPW5fTIkeZjgzXaCtA05evTZi9HkMiecIQIJk=;
        b=iAPlT1z37aQcpo+h+kqorAMMgZXePoU+ed/GNjXVJRM1fxocA7kUDC8tS1K4RTC8km
         JzsFm+v0XVi718i3JmLpk6c/d3U8cHnxkPpg+3g2CQ/Kutj5GDH9/1TnvLmEOrpuQoeI
         2sOCJdmoSwDBc7PuBnyNJV1Ae4RkxDrCpX7rBuf0yehN6VFKazEogyb4lTLIq/hJtzM/
         sFFQWIKGg+fo5/4Nqb1DkrzeKBWN4IL9TMjuF8xZvBtQoNTM/0RFUb+WZsndcmHYZWDZ
         zscRscQc5S6CmPwqIxP/ikkG1L2ADhmBntHiuZ7NvxiC9lcorriC24j8GYNjnSzW5+1+
         sX5Q==
X-Gm-Message-State: AOJu0YwAoh7z56wd6YH9JMF1lKlS/rOA5z3wpCjPs/v3oRUAMsV10gLg
        iFdp/Y8W8Myfq0UV8fqeiJStWA==
X-Google-Smtp-Source: AGHT+IE8C/ksKHsUFHvfS4u+TFmP/rNkNAi2JFULxgwWftS0stnaq9gp19bC/dbH3dKjCsWoNt4k0Q==
X-Received: by 2002:aa7:d60e:0:b0:523:3853:e01a with SMTP id c14-20020aa7d60e000000b005233853e01amr1921580edr.36.1691666376985;
        Thu, 10 Aug 2023 04:19:36 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id u26-20020aa7d0da000000b0051e0cb4692esm668779edo.17.2023.08.10.04.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 04:19:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] iio: proximity: isl29501: mark OF related data as maybe unused
Date:   Thu, 10 Aug 2023 13:19:33 +0200
Message-Id: <20230810111933.205619-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810111933.205619-1-krzysztof.kozlowski@linaro.org>
References: <20230810111933.205619-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When compile tested with W=1 on x86_64 with driver as built-in:

  isl29501.c:999:34: error: unused variable 'isl29501_i2c_matches' [-Werror,-Wunused-const-variable]

The if defined(CONFIG_OF) is also not needed in such case.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/proximity/isl29501.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index bcebacaf3dab..9e34224b5775 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -995,13 +995,11 @@ static const struct i2c_device_id isl29501_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, isl29501_id);
 
-#if defined(CONFIG_OF)
-static const struct of_device_id isl29501_i2c_matches[] = {
+static const struct of_device_id isl29501_i2c_matches[] __maybe_unused = {
 	{ .compatible = "renesas,isl29501" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, isl29501_i2c_matches);
-#endif
 
 static struct i2c_driver isl29501_driver = {
 	.driver = {
-- 
2.34.1

