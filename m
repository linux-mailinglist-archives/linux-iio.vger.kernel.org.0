Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A785C67FF64
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jan 2023 14:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjA2Nim (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Jan 2023 08:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjA2Nil (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2023 08:38:41 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E774613505
        for <linux-iio@vger.kernel.org>; Sun, 29 Jan 2023 05:38:40 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qw12so9129455ejc.2
        for <linux-iio@vger.kernel.org>; Sun, 29 Jan 2023 05:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhOlIWiyvSLGe85NFsumDCK1qE1JL6EBHu94nwRASkU=;
        b=aK1eM/6vRdwrxAfcmplcRlmhrtkMJTBr9qGF2qw6t0s4s64NwZ3+pPX1SzX1LxAY8Y
         Zed3JAcuWYafoZRxBXAflttDQn5BPQamclg7kDFJq7/CVXr/hNSlSn8mqlGCoh8n3Rd/
         2lmYXxRc6ZshAj8iN8QkZ9OKo7+XvGwdXUl9FTxO5Yhj5znqiTMD9YRJvTY4yW3Uf17K
         x7QE6FV4HNdDqo8zyCt1XHLNN8Zx3y3nLCUn/PyX3StVu1KLRu5ZrmViFsayh81P51Y/
         ANOjpZLbKlub5/eVelUrGWpCSEu2+QPWMxW5ipEyYN1RCg5TluHPL8vpNnfN7Sv1xc0O
         H5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhOlIWiyvSLGe85NFsumDCK1qE1JL6EBHu94nwRASkU=;
        b=H/K3wCg631WVxapXikpxCMi5+t/UTWFnZ8HgBauZ9DZplebblvTUUVRNhtxxHww0vx
         QokZI6dvA1RDoigD7QHpOqvVmgXFDnIp+ZS+S+pOa8MpltmHbbUdtvjubqkCPtjaEf0m
         SPJBLXvZGUjjEIphvyla6NpHQKI7o6GUNerbCOVFbmMlXiv4FBgXjDxc4xhRaObl907J
         UAyri5FxWWc59nG91FMEb19C2HUm7f0bCgu9eBKtwljfmFgRCc9fphM5JLuXcIBGLaa+
         UTkuDNHaHMWMu7lw0EAZrD+Wvg66j1M9IAnL5nU5fjTBkN89qXDnwXOL0PX8zt/BwFB9
         MGVQ==
X-Gm-Message-State: AO0yUKWtnhIBFnLWyWkMZP+SEiGb/P2CF6LhVNSgDyJKl96VN9N6rcUa
        inMW046kNj+lRSK0Kf4rMjY=
X-Google-Smtp-Source: AK7set9U56vRkXd+tNxEUl3sldI+7A5fBVVA66JXes3iQaYNUzyUAi6eo8k1kWKCw7I7DEarsB79Aw==
X-Received: by 2002:a17:906:e096:b0:878:4d11:f868 with SMTP id gh22-20020a170906e09600b008784d11f868mr14314442ejb.2.1674999519219;
        Sun, 29 Jan 2023 05:38:39 -0800 (PST)
Received: from carbian.corp.quobyte.com ([2a02:8109:aa3f:ead8::c406])
        by smtp.gmail.com with ESMTPSA id j4-20020a170906474400b00856ad9108e7sm5371018ejs.70.2023.01.29.05.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 05:38:38 -0800 (PST)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     mazziesaccount@gmail.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH 2/2] iio: accel: kionix-kx022a: Remove the unused member g_range
Date:   Sun, 29 Jan 2023 14:37:46 +0100
Message-Id: <e884d53fed0d8322d8be1de2593d4f5f8975af9c.1674996464.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1674996464.git.mehdi.djait.k@gmail.com>
References: <cover.1674996464.git.mehdi.djait.k@gmail.com>
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

The g_range member of the driver data struct is not used and
should therefore be removed.

Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 drivers/iio/accel/kionix-kx022a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 1d3af42ec0e1..bb43cb0acce4 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -162,7 +162,6 @@ struct kx022a_data {
 	int inc_reg;
 	int ien_reg;
 
-	unsigned int g_range;
 	unsigned int state;
 	unsigned int odr_ns;
 
-- 
2.30.2

