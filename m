Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106F3444EBD
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 07:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhKDGXV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 02:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhKDGXU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 02:23:20 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CF5C061714;
        Wed,  3 Nov 2021 23:20:43 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id n23so4550896pgh.8;
        Wed, 03 Nov 2021 23:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JP6S7sr92Jyer+9L8eAiJicT/LJwG8SJ6BYhUMJ6aHM=;
        b=IcgV7o8+8rJ7DcQwrRzNVgMqNNp5XihtxEh5LyXiqx8MheOHfVtwhQU/HTnXOtjEoO
         Fl5f63adWsyyw2z98vnt4be175c6zG+YO5WgLzGhAMqBrGLPRz3ag8ZIMZmX0dsJ+ot/
         teJc6fpAXpp34MKJawj6jIgYNZsXJ8g6n7r8j4VZGY0n25mdr8NU5iOsLKFXJsDrOOpv
         LCpjc9rjG/mQmS38wyUQCVb9fgHImwH3ETvJ+WDhHe1LW42VrmquUC9dYMfukYb5YNzo
         Nh7BJFnjXdhU0L4P+szYmWoS9azXHFXXkvL2ij8bjpySXdVe6wNEMC9seeJsyzQm0o7F
         thCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JP6S7sr92Jyer+9L8eAiJicT/LJwG8SJ6BYhUMJ6aHM=;
        b=WVWRUuoIG4lRhYPLIJMiuKU7B90jdYioEUGI/PH/qvRa8v+uiuhLVwPPGHeoJXoL6s
         zjINAzPTpaT4mET+dyUVODLK02M/ZB2QuxEaEXZU5JgvNP32IM7dk4vBaNGKx98Ct5z/
         zcRNdjR6SgMhvJVp6pnZ/1aBTYfjaYpONYGsWxQxMvilHP6ChtdIGkZPN8zWF0Z5ikiC
         p6lCxqNQxqUV3zQHhffRTwafw/M/UbXBRvLwxUDYOq2AFX8feN9tNFKPxLMcGV7Ollxe
         3ucr5UKLwfbUckc1GFNy888H/KreJiEi/QZs6D+j3wiEMdcHKoh/tVOK8GTlznco67V0
         6PxQ==
X-Gm-Message-State: AOAM533D3k/8nLJDCyZ7ApZfc5JCphWHegu5kRLLxneoKtbg5p76Z3fD
        NRQZCff3XseNj1WO1TkJWv6eufD84jg=
X-Google-Smtp-Source: ABdhPJygVtdOioU9zNQLo3BMYSvock5UlAt2XeihwskqObFeRrphfzmtzSFzZVusre9utreciyHY2g==
X-Received: by 2002:a05:6a00:1a01:b0:44d:af99:19c9 with SMTP id g1-20020a056a001a0100b0044daf9919c9mr49013384pfv.36.1636006842749;
        Wed, 03 Nov 2021 23:20:42 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id s6sm4206012pfu.137.2021.11.03.23.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 23:20:42 -0700 (PDT)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     jic23@kernel.org
Cc:     davidcomponentone@gmail.com, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] tools: iio: use swap() to make code cleaner
Date:   Thu,  4 Nov 2021 14:20:32 +0800
Message-Id: <20211104062032.1505899-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 tools/iio/iio_utils.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index aadee6d34c74..7a56c41fbded 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -290,15 +290,12 @@ int iioutils_get_param_float(float *output, const char *param_name,
 
 void bsort_channel_array_by_index(struct iio_channel_info *ci_array, int cnt)
 {
-	struct iio_channel_info temp;
 	int x, y;
 
 	for (x = 0; x < cnt; x++)
 		for (y = 0; y < (cnt - 1); y++)
 			if (ci_array[y].index > ci_array[y + 1].index) {
-				temp = ci_array[y + 1];
-				ci_array[y + 1] = ci_array[y];
-				ci_array[y] = temp;
+				swap(ci_array[y + 1], ci_array[y]);
 			}
 }
 
-- 
2.30.2

