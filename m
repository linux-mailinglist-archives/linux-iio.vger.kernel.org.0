Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D0467FF63
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jan 2023 14:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjA2Nia (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Jan 2023 08:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjA2Ni3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2023 08:38:29 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC471E287
        for <linux-iio@vger.kernel.org>; Sun, 29 Jan 2023 05:38:28 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m2so24573977ejb.8
        for <linux-iio@vger.kernel.org>; Sun, 29 Jan 2023 05:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dj/3crDkqPP4w2eLcips03FDdHELDSaaQ2/SmuyqAFo=;
        b=KR7aywQRARXzeIRbTRnOqjsF8k/8rlzR+GmW0/ByTkGPxI3RrJMr0g4EYWntJ+fiGy
         tcsd4skmNoCVO/xwAI9+amNR1FYQOAuc0mjb+m0O4cKslC17kIDSKPtTaUmbohqgI/t8
         O6PkqhxLckA+dkDkVOx/Db9gYN46EYZ9t32i8EAhq3o+M9wkF8dxczElVpir9Pd+bmV0
         i93Z5nfXpCd6iLMt5w9H28qbZb9KfjZnLwIwTdWq1WeFyGt2TVqUgbZ+olgpaGp+FgAe
         8Ob4i3Lv0yNreQhGegx/4q/2EIjPNUqmU2CS/fM1EXe8niw/XmpTb2R95x4wAoDWYz/f
         XIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dj/3crDkqPP4w2eLcips03FDdHELDSaaQ2/SmuyqAFo=;
        b=p8uKLs5/pGOyiQi1HdTbgLQhlaZSY6/52W7h7+Z/yCNTj1psbuoKJHwZBdXaOWtNrt
         Ecuha3Q6PSqylB0TVCBqwgmTtrg8OM3LhHs1Wdn4Ivd2jHzv8lZwfI2m6uk8jtMDSOzV
         XF2DBdUVcGPpNqkmqfw/HLsx2rZECwLVKxwkGqIC6AfOp+WaxY2qx/0kMCfuHGabBpH+
         Ghb2nFwFsxTIfgHh5uji3AOQUF5Lag5dUSF/F2SfKOdopBjQwBKh24uS4T1fOB1zpSjo
         icbtA4f0tNiHA6BcUml9kzPVrhOz+7CpR0XHfapyYH1lfo0G9NhqKGi+xwwVUqQXukqx
         oYsw==
X-Gm-Message-State: AO0yUKVkgtsnRi3eBtior1NBe4mi8RoHmdEDnCrks6wNLNULxsE0AZwG
        znc8hB8MB+grSvuCm+fXtyA=
X-Google-Smtp-Source: AK7set+fuuR/F1qIvMX2BrzIOnh/dEcEwr4CYnXC9Fc60u2gemNgl8IGBUpLW7rg+rizia4BrkxKmQ==
X-Received: by 2002:a17:907:62a1:b0:87a:3aff:cffa with SMTP id nd33-20020a17090762a100b0087a3affcffamr11990510ejc.27.1674999507273;
        Sun, 29 Jan 2023 05:38:27 -0800 (PST)
Received: from carbian.corp.quobyte.com ([2a02:8109:aa3f:ead8::c406])
        by smtp.gmail.com with ESMTPSA id j4-20020a170906474400b00856ad9108e7sm5371018ejs.70.2023.01.29.05.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 05:38:26 -0800 (PST)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     mazziesaccount@gmail.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH 1/2] iio: accel: kionix-kx022a: Fix the setting of regmap_config rd_table and wr_table
Date:   Sun, 29 Jan 2023 14:37:45 +0100
Message-Id: <0003ce97298da5afd9cfeab8ae8f93f50542fe8c.1674996464.git.mehdi.djait.k@gmail.com>
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

rd_table points to a regmap_access_table with valid ranges for read access
and should be set to &kx022a_ro_regs which points to the read_only regs.
The same for wr_table.

Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 drivers/iio/accel/kionix-kx022a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index f866859855cd..1d3af42ec0e1 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -142,8 +142,8 @@ const struct regmap_config kx022a_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.volatile_table = &kx022a_volatile_regs,
-	.rd_table = &kx022a_wo_regs,
-	.wr_table = &kx022a_ro_regs,
+	.rd_table = &kx022a_ro_regs,
+	.wr_table = &kx022a_wo_regs,
 	.rd_noinc_table = &kx022a_nir_regs,
 	.precious_table = &kx022a_precious_regs,
 	.max_register = KX022A_MAX_REGISTER,
-- 
2.30.2

