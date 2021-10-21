Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48779436117
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 14:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJUMNV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 08:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJUMNU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Oct 2021 08:13:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BFEC06161C
        for <linux-iio@vger.kernel.org>; Thu, 21 Oct 2021 05:11:04 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so388876pjb.3
        for <linux-iio@vger.kernel.org>; Thu, 21 Oct 2021 05:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O4/z0whPgiQjs5coOxcU57bQrWr1t2+NY/9kmngGtu0=;
        b=X7lBxaAjAXyIcFEoq5oEEtNaXJZpgTzDRcAGSQWGtnI/VaOU7G0uaxBei+1lUiF9vZ
         QcH1YdjOq5uJQLTracAbl+KNVVkmJc/5OikfGCCfTiji+qkLhw11qM4YQ3YdTQXqlNyr
         VNdorN9HaKIKS2lUb+6fFGnIFki0wHfiVIUUGJX7iSqJlbQdHW+QUC6QMOi2qWaWju8L
         TGiB+jyRrOH0ot4Aq7on8kbYC71e9ZSTBuwotC4UjYtWhzZq6PWGf+ZhDLT1SIkuw7ml
         h5N+2YfVjMAY1nQos0OKXgQh7NkuAtC+0fp4nilu7mFwF2YXvxBxFPORvSJxS531O2Ya
         QJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O4/z0whPgiQjs5coOxcU57bQrWr1t2+NY/9kmngGtu0=;
        b=jjgXQtKTXgesqnD+qfwu6CwqZxsr8a/V10QJb6BUQ7+f6cJrtGFQR26OOVP1uCsok1
         VdsV2BcglnvzUGJMhdN+Kc5u+37ZXNeMG8js1KiCwjIhOPOoCDt8iYcwohWFY06LINZM
         J18fD0AEkGadjCQFM25zuCVWuULrz6yeBIL4Ypso+4CcRRr+G3jva5QAIgFAgXYygCBT
         cKOaMwGBxHJu92ZsdaUrK3KlG30Okbk05JvGRvL/9HSVoeUeq3qNwCq1gzvfysfOXLWJ
         H5vB7NujkoUpDXX2GOwq9jXkv1vWis9/68dlp49z4e5ry4M+dBqk7gRHAkNAxe+i67P6
         NlcA==
X-Gm-Message-State: AOAM533Kyh3IzLC1qerQR86Ru0uEMv/q4cziFp558AiXBIR6cRXUbtIh
        kojGYTb7WS6UuGK7hjjyZBPP1GxFodcXV8AX
X-Google-Smtp-Source: ABdhPJyNJsjJppf3LB5xiPk1keirioNBnayHTWSV3qHIZnwsoUy9QUKGWuui16HxjgET0MtXlASsQw==
X-Received: by 2002:a17:902:da8a:b0:13f:1a39:e02f with SMTP id j10-20020a170902da8a00b0013f1a39e02fmr4936632plx.82.1634818264230;
        Thu, 21 Oct 2021 05:11:04 -0700 (PDT)
Received: from localhost.localdomain ([8.45.41.28])
        by smtp.gmail.com with ESMTPSA id d67sm5998284pfd.151.2021.10.21.05.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 05:11:03 -0700 (PDT)
From:   Yanteng Si <siyanteng01@gmail.com>
X-Google-Original-From: Yanteng Si <siyanteng@loongson.cn>
To:     jic23@kernel.org, cmo@melexis.com, lars@metafoo.de
Cc:     Yanteng Si <siyanteng@loongson.cn>, linux-iio@vger.kernel.org,
        sterlingteng@gmail.com, chenhuacai@kernel.org
Subject: [PATCH] iio/mlx90632: restyle mlx90632_calc_temp_object_iteration
Date:   Thu, 21 Oct 2021 20:10:42 +0800
Message-Id: <20211021121042.1372803-1-siyanteng@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ref: Documentation/process/coding-style.rst:
C programmers do not use cute names like ThisVariableIsATemporaryCounter

so,restyle mlx90632_calc_temp_object_iteration()

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 drivers/iio/temperature/mlx90632.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 608ccb1d8bc8..03257da92db4 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -547,24 +547,24 @@ static s32 mlx90632_calc_temp_object_iteration(s32 prev_object_temp, s64 object,
 					       s32 Ga, s16 Ha, s16 Hb,
 					       u16 emissivity)
 {
-	s64 calcedKsTO, calcedKsTA, ir_Alpha, Alpha_corr;
-	s64 Ha_customer, Hb_customer;
+	s64 calcedksto, calcedksta, ir_alpha, alpha_corr;
+	s64 ha_customer, hb_customer;
 
-	Ha_customer = ((s64)Ha * 1000000LL) >> 14ULL;
-	Hb_customer = ((s64)Hb * 100) >> 10ULL;
+	ha_customer = ((s64)Ha * 1000000LL) >> 14ULL;
+	hb_customer = ((s64)Hb * 100) >> 10ULL;
 
-	calcedKsTO = ((s64)((s64)Ga * (prev_object_temp - 25 * 1000LL)
+	calcedksto = ((s64)((s64)Ga * (prev_object_temp - 25 * 1000LL)
 			     * 1000LL)) >> 36LL;
-	calcedKsTA = ((s64)(Fb * (TAdut - 25 * 1000000LL))) >> 36LL;
-	Alpha_corr = div64_s64((((s64)(Fa * 10000000000LL) >> 46LL)
-				* Ha_customer), 1000LL);
-	Alpha_corr *= ((s64)(1 * 1000000LL + calcedKsTO + calcedKsTA));
-	Alpha_corr = emissivity * div64_s64(Alpha_corr, 100000LL);
-	Alpha_corr = div64_s64(Alpha_corr, 1000LL);
-	ir_Alpha = div64_s64((s64)object * 10000000LL, Alpha_corr);
-
-	return (int_sqrt64(int_sqrt64(ir_Alpha * 1000000000000LL + TAdut4))
-		- 27315 - Hb_customer) * 10;
+	calcedksta = ((s64)(Fb * (TAdut - 25 * 1000000LL))) >> 36LL;
+	alpha_corr = div64_s64((((s64)(Fa * 10000000000LL) >> 46LL)
+				* ha_customer), 1000LL);
+	alpha_corr *= ((s64)(1 * 1000000LL + calcedksto + calcedksta));
+	alpha_corr = emissivity * div64_s64(alpha_corr, 100000LL);
+	alpha_corr = div64_s64(alpha_corr, 1000LL);
+	ir_alpha = div64_s64((s64)object * 10000000LL, alpha_corr);
+
+	return (int_sqrt64(int_sqrt64(ir_alpha * 1000000000000LL + TAdut4))
+		- 27315 - hb_customer) * 10;
 }
 
 static s64 mlx90632_calc_ta4(s64 TAdut, s64 scale)
-- 
2.27.0

