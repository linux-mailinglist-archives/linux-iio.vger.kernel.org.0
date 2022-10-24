Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0014E60BB90
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 23:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiJXVDf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 17:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiJXVDT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 17:03:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B72C5684;
        Mon, 24 Oct 2022 12:08:59 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b2so18267074lfp.6;
        Mon, 24 Oct 2022 12:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwL8/qx1/0F0Hrq3IMB5cdMrfq8hnyHJ0+oU5aJtiFo=;
        b=hJu80Hr9tWx4yHsXduGAuqtUGB6IrvpVnsc1taAXKITwr6UOest6JMpQe+OrjHD3ad
         aFOG3QKptelq11AzR0C5ldh2kjMtVx6U7CiknAIDKoPWfyETrjo+Nj+nXkqCj0XnQ+9h
         vq7wuHNQowYgbH4lSqPsACZvbP2xweM+UB9NAZL7o9LTXCtANE7RPF+ipOshTuHpG6EZ
         eIky0yzzS1yCvDzwsR3k8KBqcsFPG8/SPdsiBB2a9OO+K4jb4dorwxmVgajFEg5dSzWL
         cDYCTDP6v4pg8BvhemFU5crB5+dn/n+KAge4M8kn50ywJBmFnhMtEHx4U61d1GZ07MRo
         dTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwL8/qx1/0F0Hrq3IMB5cdMrfq8hnyHJ0+oU5aJtiFo=;
        b=Rd13/FD7+O0dYHPqSn9Z3TZ4B6m+0vq/bzD0oNlZq/GlPwGTrwuhjdrU15lXm74BP+
         XisNNlXIAN6BBw0u2BCNtG0tSgW1ZET9e/foF1gEo/YTeGCY2160r+iuMyTadLGl+llT
         320KxvsH0azztunRWssuNNyKoUjfQoNr6TckiVbrZ7llHsycVngsgyV9emHJyiovJs6+
         s+m06Xm6yqSuY0lMs8zCoQRVUC9If4Yrdi2mv/2Hx1jI+yPuIK995DH/nEHVZ/lu5f+Y
         cbfjnoudC0md4/wHvMoYDahrYjaAv5C6FoPYmoUSa3gH2shIpdlYxwnhS9hWK7g2VpRb
         xUpQ==
X-Gm-Message-State: ACrzQf3AcqaLE6wwyPvM5z6mub/fp7jFGrdzga7SQezSoj+uliXWTtEJ
        9QT0pMGFJmxfF4NkWrfSIzIsU9HD8Uk=
X-Google-Smtp-Source: AMsMyM4QQorvU7/sJtwzla1liZs/dJanTTjXhWgjZ6BdF4BKG+u2hgWU1L3QBk8NZOE7g3hFix2TsA==
X-Received: by 2002:a17:907:5c2:b0:77e:def7:65d8 with SMTP id wg2-20020a17090705c200b0077edef765d8mr28009125ejb.487.1666618087998;
        Mon, 24 Oct 2022 06:28:07 -0700 (PDT)
Received: from discovery.. (p5dcfeede.dip0.t-ipconnect.de. [93.207.238.222])
        by smtp.gmail.com with ESMTPSA id l20-20020a056402231400b00457c5637578sm18243818eda.63.2022.10.24.06.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:28:07 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v4 7/8] iio: adc: mp2629: fix potential array out of bound access
Date:   Mon, 24 Oct 2022 15:27:56 +0200
Message-Id: <20221024132757.3345400-8-sravanhome@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221024132757.3345400-1-sravanhome@gmail.com>
References: <20221024132757.3345400-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add sentinel at end of maps to avoid potential array out of
bound access in iio core.

Fixes: 7abd9fb6468 ("iio: adc: mp2629: Add support for mp2629 ADC driver")
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/iio/adc/mp2629_adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index 0f297072b8aa..18290e176e1e 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -57,7 +57,8 @@ static struct iio_map mp2629_adc_maps[] = {
 	MP2629_MAP(SYSTEM_VOLT, "system-volt"),
 	MP2629_MAP(INPUT_VOLT, "input-volt"),
 	MP2629_MAP(BATT_CURRENT, "batt-current"),
-	MP2629_MAP(INPUT_CURRENT, "input-current")
+	MP2629_MAP(INPUT_CURRENT, "input-current"),
+	{ }
 };
 
 static int mp2629_read_raw(struct iio_dev *indio_dev,
-- 
2.32.0

