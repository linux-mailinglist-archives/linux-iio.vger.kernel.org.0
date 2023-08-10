Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EAB7776BA
	for <lists+linux-iio@lfdr.de>; Thu, 10 Aug 2023 13:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjHJLTr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Aug 2023 07:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbjHJLTn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Aug 2023 07:19:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F53826B6
        for <linux-iio@vger.kernel.org>; Thu, 10 Aug 2023 04:19:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so1130852e87.2
        for <linux-iio@vger.kernel.org>; Thu, 10 Aug 2023 04:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691666375; x=1692271175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PD2GRNX1Jjay8puie92l6jb2A21ZGy6pa02WKtpuhVk=;
        b=S02JNx4QRwltGeoDYVjXQDIOUw8v9lQF+D32SZpaS95wTNH5dkOXsew/5f0gKG04ON
         7HUbhywzmTslFJmFQkSa7eEn1US11DSDbPY3MH1vxyKiWSgxtzPCRz1HLU4L3nfyIogc
         B2FInlZ285KdB81z+mUyUWBUTjdwSnERThIP4mnbZilfZAwvF1Jj6kb9vHmOLhFGnJ1J
         ku8KIVsmrQo18RHqaIm+NgDON8NvpfYK/j83ql4GE8+krocSLS3xtpMAynVBylKsamuh
         xkqAmxmUrDCvzN4L1RsQbwEAMeQytjKWCKSjTYh+/MrQQox7E8YX1tqNkFq4Pp4TkV2P
         qYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666375; x=1692271175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PD2GRNX1Jjay8puie92l6jb2A21ZGy6pa02WKtpuhVk=;
        b=FOFeTYxweHkZkz5DnJHEnkCzgDJJ5VDWeD9QxTSDwmE+YESQzWgFy8eUgIpUC/0T1z
         lne1zwr8xIDuVtct5Scg2SuxxHG3usytxlNVWN9q4N9gu1lvYCpHJI7872c6TjND1erQ
         QgoPR6XWDHz3RvnrMzMMIbjg9bHZLLKRONf6Jdhazy5eNf6UmVVucZklSYrOwl8Xyl9p
         2sxC8K3gSbnfOqJ/Dz62ipb19LZlVvdcVRGPrWILrk52zFkuMmFyB1ot0h/HF8Levw78
         Yqv8UUNUTHdT5DMzxoDGjo25dU1UP5R1u1jv/abA84u9IaTOqOZu1ITYurZt1WZDAZgz
         I5Dw==
X-Gm-Message-State: AOJu0Yxir0zCMfruL4jLR9Ao+qMfSUmPLjkl2A9sBeFJCtCzKzHb6QrC
        Pkb0g/2I/uqNg4eQkgtoMQju2kG9oRNWhmy7QRU1kg==
X-Google-Smtp-Source: AGHT+IFzEoQ+JLrkxCj7YDAT+5ma5m9CP/aItpuP7f2CS0c8OIH4fEoXIC8cct3iBWAhAfSq3bEuZA==
X-Received: by 2002:a05:6512:33d2:b0:4f8:7124:6803 with SMTP id d18-20020a05651233d200b004f871246803mr2375378lfg.35.1691666375646;
        Thu, 10 Aug 2023 04:19:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id u26-20020aa7d0da000000b0051e0cb4692esm668779edo.17.2023.08.10.04.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 04:19:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] iio: dac: ad5755: mark OF related data as maybe unused
Date:   Thu, 10 Aug 2023 13:19:32 +0200
Message-Id: <20230810111933.205619-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

  ad5755.c:866:34: error: unused variable 'ad5755_of_match' [-Werror,-Wunused-const-variable]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/dac/ad5755.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 404865e35460..823049ce2686 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -863,7 +863,7 @@ static const struct spi_device_id ad5755_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad5755_id);
 
-static const struct of_device_id ad5755_of_match[] = {
+static const struct of_device_id ad5755_of_match[] __maybe_unused = {
 	{ .compatible = "adi,ad5755" },
 	{ .compatible = "adi,ad5755-1" },
 	{ .compatible = "adi,ad5757" },
-- 
2.34.1

