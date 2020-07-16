Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025642224B6
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgGPOBQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbgGPN7u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7252EC061755
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so7137214wrs.11
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xS5iaY7lfvInFgzdYtfbJOMULW0PjIgmtSXBGbeSKP0=;
        b=xxL5Ag3IresWgQw0UNbgMhC8UUPDoSjfaeodJ14sFm3DDAPplrnoea1LlKXlrLmsSQ
         H+ViunaN8TaBXhiQ42uSBOBQRJ/Tj3qVHVpYLEHkqg0B+ykx75a69k+HK9wM9pxRgzbQ
         msvRRgeMRBI4z5xmbL1p8sMLUjz13LItqneeEcZ+WBLqTS+1BQsTTyVb80iy6I5fQGkq
         bT1NyvWPobGdkt7RYGfQhv6DWxOF/p3vcoVx9zOS4/MtVofe2FEDHLt2LmNX6JLbRvuE
         o0ycpNrLICFEj+hNnlyYRW2z3KmklAnWHiES2PuwZrizhLE/6BmBbWfXLW6nYaeQedpB
         yxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xS5iaY7lfvInFgzdYtfbJOMULW0PjIgmtSXBGbeSKP0=;
        b=JIxHSDOuPXHH3Vt9PTW7yzhSf+rQCKdzK3P3/hk0aXMil7eM2jO0bv1aYRhFuJTSyc
         UUuEw7oZhejKW6ciN5fbNWSNiWOWZhD9wPxeQ1066bAPB2nR1bPIQ5HuUU6dYm8PH5IC
         emubYM59yjuMiRX3LZYMKGuLXad8DWfd98Mt+Et0YSUVZF4HxKLWYhU778zfG654+qG/
         ohk52wW2+DpqiUghoH7oA4DeUuRKhrW3TJ5zf7VxlnTXkSeuUfS1/XFep6jEXtLHGZVj
         K1/ZdPanbl2vBB8oUavhtRIoSn9uCEuHQeFTKaq5jrcNylxS52mVYFv9TkPLFQq8M3Sd
         9yUA==
X-Gm-Message-State: AOAM530wLYU8uV/n0Ru7q1++bu2VDL8g+rWfzwzUNi/spGRHdvICfbU8
        phtHAtICSkEjO7iaN6vlwQFnCw==
X-Google-Smtp-Source: ABdhPJz+3bOsT4wSiHZeM6v8NBbP0nQ87ipkThT9NtG3fkIz00axC34VQ9CXjTVwPymWMRsbdcNijg==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr5144226wru.310.1594907989226;
        Thu, 16 Jul 2020 06:59:49 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 14/30] iio: dac: ad5064: Value returned by ad5064_vref_name may not be 'const * const'
Date:   Thu, 16 Jul 2020 14:59:12 +0100
Message-Id: <20200716135928.1456727-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad5064.c:790:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
 790 | static const char * const ad5064_vref_name(struct ad5064_state *st,
 | ^~~~~

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5064.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index d33642de9720e..303f6d1a5f311 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -787,7 +787,7 @@ static const char * const ad5064_vref_names[] = {
 	"vrefD",
 };
 
-static const char * const ad5064_vref_name(struct ad5064_state *st,
+static const char *ad5064_vref_name(struct ad5064_state *st,
 	unsigned int vref)
 {
 	return st->chip_info->shared_vref ? "vref" : ad5064_vref_names[vref];
-- 
2.25.1

