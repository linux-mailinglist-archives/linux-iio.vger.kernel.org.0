Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CB8779395
	for <lists+linux-iio@lfdr.de>; Fri, 11 Aug 2023 17:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbjHKP6l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Aug 2023 11:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjHKP6l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Aug 2023 11:58:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCF2270F
        for <linux-iio@vger.kernel.org>; Fri, 11 Aug 2023 08:58:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31771a876b5so1821443f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 11 Aug 2023 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1691769519; x=1692374319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VhfWrRL/Bucrz3EnDiS//8+dWsgaxE0uiOq4QLZ7h7k=;
        b=c8UGt1nCglHJCnLrDER82RKFVDQEMtrCriltH7dTAiQRPfcoe8SsCx3GTyn+zEqPUx
         7miaacj5lbxN2IvhAZ+57XNlqWphkavC7YLeSjL9pLVt8C96m+KVxZXHn/60nou03xcI
         cCqpSFCwwrh8UsrMKsHhiodra+BQg8Qv3LWyKf0YaydzOocGC1J5uVQkvYQleizErJwg
         Fdw4M+ldjxvd6aqgyDG2zoMe1Qjp9F/d/a+0PGoH8tOyL/IxBUwSt4z2Jb0vnBa7V/zJ
         7NPXYe/mmGK4bN9ZvioYramQWgrYgPXzypHucafTHUPYCcYuGJXTJLV15R5O+Dk5He38
         5pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769519; x=1692374319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VhfWrRL/Bucrz3EnDiS//8+dWsgaxE0uiOq4QLZ7h7k=;
        b=ThT53B7kyJ+ql1qqHWq8xyN9muC5lLfzcoJ6ZEsuHZhsIQ/9y6VFxgG8ECEz9l6J1Q
         7Xsqqw1G09n9OZg97CatsJGYbQOyq4+rOKNc6wE1lWJqXgGywAJna2S91EiUi/uUL3BA
         vtFmX+fl5Mu0y1q2DVEXlEWvDboLmkVtjq6Ydy8VnZ1RGaoV2sJrfdyokq22B/EfESNf
         G0ONKMeyF6o+yEfB9uBIYcYTd2LlOWLRk3+NwLUAdGJhyh8IdX+CnhlYNoeCDSNq9qFA
         F9bez5t1zQamyoV5zm2aeqcNZKGjMmY8wLJSdsXBhEgEiFRHKfTadqYj+6BU3Vk9wLk7
         80ow==
X-Gm-Message-State: AOJu0Yy8eu2brolgK+gLXm8IUDVpNSOEO4IY967Sdo6zYNmueDropY5C
        wkc1jLGO6LfXgSC2dvToePh7LqfH57cl9jlc357ErA==
X-Google-Smtp-Source: AGHT+IHFpgBFlG+1HAnV29xYVsli5LgTmV0lSZ4mdL44sRXmH+eUoWwPwmPRN9vCyUwYkOt8ytuZJw==
X-Received: by 2002:a5d:5347:0:b0:317:e5ec:8767 with SMTP id t7-20020a5d5347000000b00317e5ec8767mr1706926wrv.21.1691769518763;
        Fri, 11 Aug 2023 08:58:38 -0700 (PDT)
Received: from buildbot.pitowers.org ([2a00:1098:3142:14:ae1f:6bff:fedd:de54])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d684a000000b0031758e7ba6dsm5769057wrw.40.2023.08.11.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:37 -0700 (PDT)
From:   Phil Elwell <phil@raspberrypi.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Phil Elwell <phil@raspberrypi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH] iio: pressure: bmp280: Fix NULL pointer exception
Date:   Fri, 11 Aug 2023 16:58:29 +0100
Message-Id: <20230811155829.51208-1-phil@raspberrypi.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The bmp085 EOC IRQ support is optional, but the driver's common probe
function queries the IRQ properties whether or not it exists, which
can trigger a NULL pointer exception. Avoid any exception by making
the query conditional on the possession of a valid IRQ.

Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC interrupt")
Signed-off-by: Phil Elwell <phil@raspberrypi.com>
---
 drivers/iio/pressure/bmp280-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6089f3f9d8f4b..a2ef1373a274e 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -2179,7 +2179,7 @@ int bmp280_common_probe(struct device *dev,
 	 * however as it happens, the BMP085 shares the chip ID of BMP180
 	 * so we look for an IRQ if we have that.
 	 */
-	if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
+	if (irq > 0 && (chip_id  == BMP180_CHIP_ID)) {
 		ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
 		if (ret)
 			return ret;
-- 
2.25.1

