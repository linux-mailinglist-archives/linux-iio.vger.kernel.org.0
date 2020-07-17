Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2763A22410A
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgGQQ5I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgGQQ4Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687D5C0619D3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so18258009wmh.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31Tvqv5NM4OFlqEMdtTKPK1d2uzVylaWVS7jDebvxGA=;
        b=ZcVlGaOL/eDTv4lz5JNlb4hvtqD+61w7PMNxH3NBGKRHyPqzJ4uTAIwYuWJ3ev4dFT
         5ehYJVF7nzM9II9CEoOhTa5w10VsHMdfcTywQSHOaEckBYNSBkF+sGd21ZfrWfQIlEBL
         qgQPBZ0oVg2jhGx6D3/GJrJ7VfP/4KBF/PtN6vkRzd4z/rXUzkcOw01OfBXm95uVCErX
         lKoBUJ2uPi9lXqc/vfY3vePmqyzN6UUSmJO6WeZa9wZw1PmU+UxCbVUiYkom0kazHefl
         ngHnsxDuAtEVfKz7u+Q4npgGQh/o4Y/5k2CT7Ca7cmyxxW5Z1s1cBljlyLx11/+NZJdw
         cQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31Tvqv5NM4OFlqEMdtTKPK1d2uzVylaWVS7jDebvxGA=;
        b=JIT/jtvyPA4mqueboONVLYNgft7hOjPzy7CKxLrqSrKwVdEaZTFb87qr7CdcJHdU13
         UqYRRqXZ+2XLEGUXJh0F4Fpb057QCaLe+TDBYtnG67bxQOhza1qciKTjbtZNLZDOo8rz
         qvs6YPKavYV4yGQEXhuA7bWsdBXRkjOY2jjYinNoCqzwkAFgBxQn3lbBTRlsdzksKnu+
         fb87AGtNQxj4vvSMmQsoZI6jJCRbaEg/QBIpXh4Zvap/YTrm2FIr0nbzIRECQnoY37Ui
         qMCGom8rm7pQDEm8brbZRQmr0JuWein8TX+vLZTcWCWWPbeZr9z6gSO+b2WPAkCG6qEr
         UcvA==
X-Gm-Message-State: AOAM532HP9C/8X3LVCvHUqinL7KqoFyiWzPPJDy+L/lKlwIlHreko82i
        wLRvFs2q6aC61DfdtUx0GKchJg==
X-Google-Smtp-Source: ABdhPJznCryOGiaapGhkR1ssu1klQe40/wpuzaMcITlbW08G7kOfQATkKGR7vsCaF9kKxBdVSbniuQ==
X-Received: by 2002:a7b:c8c8:: with SMTP id f8mr10596923wml.142.1595004983177;
        Fri, 17 Jul 2020 09:56:23 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        Bendorff Jensen <abj@rosetechnology.dk>,
        Soren Andersen <san@rosetechnology.dk>
Subject: [PATCH 22/30] iio: adc: mcp320x: Change ordering of compiler attribute macro
Date:   Fri, 17 Jul 2020 17:55:30 +0100
Message-Id: <20200717165538.3275050-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kerneldoc gets confused if the variable does not follow th
type/attribute definitions.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/mcp320x.c:96: warning: Function parameter or member '____cacheline_aligned' not described in 'mcp320x'

Cc: Oskar Andero <oskar.andero@gmail.com>
Cc: Bendorff Jensen <abj@rosetechnology.dk>
Cc: Soren Andersen <san@rosetechnology.dk>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/mcp320x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 2c0eb5de110ca..191a8f644ffe7 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -91,7 +91,7 @@ struct mcp320x {
 	struct mutex lock;
 	const struct mcp320x_chip_info *chip_info;
 
-	u8 tx_buf ____cacheline_aligned;
+	u8 ____cacheline_aligned tx_buf;
 	u8 rx_buf[4];
 };
 
-- 
2.25.1

