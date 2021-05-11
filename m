Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5627F37A0A6
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 09:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhEKHUL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 03:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhEKHT7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 03:19:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE38C061348
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b17so21651734ede.0
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YxA8FQYDWbxe8BPqwCO+yOABH8hUl4nAhrh9q+4gOxs=;
        b=he2GENrRhDW+bZxoqb8MKMBMQc8bYzFKlxGSCc/RtgNDE4FeeeT7KwUKqf1IyN7XTI
         ZzE6fAXeKtqfvE5taWRvNTrbjh6C2sc+TVO9vkyYqblMDCYxO2U6un7qysqWqKizoEZj
         qSYatZDFhrRgH0xMA9eMVvskwg5W81+O2EW8lDLt5p/u1Zx+yS6OMrnSduy0f6ZKGN8h
         l3U3w8igjLBYJkmk49/fvz0/9bUfKXFcF/3rO0bJzGS+BoxVLrLOMZTkPOZoeyw6RjbW
         Z9pKmQyPebN8mQCh0YadDa3a4k4OnZOgycI1vFto98AGgY0/NiOZXL67vH+qPy8jDzcE
         gGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YxA8FQYDWbxe8BPqwCO+yOABH8hUl4nAhrh9q+4gOxs=;
        b=GmmgnpbqgH8GqEH5Qds66Q+ga+8S4J63F9ld0rU2bbXXJH8HCXJPfo6IF4+s6EECCu
         AlN7heTMdTE1QpB8Uz1XzPppUUcezPB3h5bITdwaTOIJkl0C+4pQ95URGLx4GcWfo0dZ
         lAvgez89P7YD2mKeUMaRLFg273pZlX6PQgi2mlkqNrFHThmwWbFF9xCFQN7Mj9ghjs67
         WnEplRz8jZ5aC+iqBhCgPf9a7p8wrRumy9oSrFBBpbaJKLV3p8nQqhsrEw9mNPb7LmJ2
         kvRpf4Vb+dEfidTHUoO2AvvUQeXzMBXYKnCJ9puz5YIihUr0cwl8wSwhPxxkwS0zMQpn
         BFZA==
X-Gm-Message-State: AOAM531hFOSm15kL+BvmVlNzrfZnRCS8jVd6JX4E9v0NVok0K83iswOo
        ENUhm1ciR62bC27icA6zOM98pSnQEKcXydwu
X-Google-Smtp-Source: ABdhPJypim42rK6++a+BuJWBRwFnCXwcg+zQwnKYHu6Q0j+hTNeTv1EKkr+T8oDqfH+xznhKnO9BMQ==
X-Received: by 2002:aa7:d3c2:: with SMTP id o2mr34437469edr.111.1620717524035;
        Tue, 11 May 2021 00:18:44 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id i6sm13871558eds.83.2021.05.11.00.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:18:43 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 09/12] iio: adc: ad7192: use devm_clk_get_optional() for mclk
Date:   Tue, 11 May 2021 10:18:28 +0300
Message-Id: <20210511071831.576145-10-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511071831.576145-1-aardelean@deviqon.com>
References: <20210511071831.576145-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The devm_clk_get_optional() helper returns NULL when devm_clk_get() returns
-ENOENT.
This makes things slightly cleaner. The added benefit is mostly cosmetic.

Also, a minor detail with this call, is that the reference for the parent
device is taken as `spi->dev` instead of `&st->sd.spi->dev` (which looks a
little quirky).

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7192.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 79df54e0dc96..18e731f1471a 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -326,7 +326,7 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
 	clock_sel = AD7192_CLK_INT;
 
 	/* use internal clock */
-	if (PTR_ERR(st->mclk) == -ENOENT) {
+	if (st->mclk) {
 		if (of_property_read_bool(np, "adi,int-clock-output-enable"))
 			clock_sel = AD7192_CLK_INT_CO;
 	} else {
@@ -986,8 +986,8 @@ static int ad7192_probe(struct spi_device *spi)
 
 	st->fclk = AD7192_INT_FREQ_MHZ;
 
-	st->mclk = devm_clk_get(&st->sd.spi->dev, "mclk");
-	if (IS_ERR(st->mclk) && PTR_ERR(st->mclk) != -ENOENT) {
+	st->mclk = devm_clk_get_optional(&spi->dev, "mclk");
+	if (IS_ERR(st->mclk)) {
 		ret = PTR_ERR(st->mclk);
 		goto error_remove_trigger;
 	}
-- 
2.31.1

