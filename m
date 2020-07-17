Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283F722411C
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGQQ5n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgGQQ4J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88D6C0619D3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 22so15959515wmg.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YT0JMRu5eQoXCKZAUBFbS9kdf7HqY+KCePcGHxfvNYY=;
        b=eTKat4s5/E2CjyBQFfD4OL1Ried9ygggeHKRbE97/qquwCB2+CYfFiIS6FYHPLNsx5
         3bvHk49rpmbB7hewemhLQokS/V6/KSynXxRNFacpI5IIVQ+fMQrB1RyK/ewDBVY73ToY
         ako+0yfuwsc6WN8/S4LT22mJVi28aSWaKEI8EbCNebD6upedRCYsYFg/7LwdcTjXzG/t
         jFXi4H8Z4gXXgZ6RanUmbysgAER+yapMU6ZDtSaCQX0aOfrvxKiNpmZpbq9NZSN7EWoN
         vUY+SBWM+Pe0yMnFXI41l/n+N/+BHK5CFTQDwMCOBeE3d7zZlpHyMJPSUywTDPbWVuJc
         kaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YT0JMRu5eQoXCKZAUBFbS9kdf7HqY+KCePcGHxfvNYY=;
        b=tUGfm6DhEJR4H0IE1w8Spisao59k1p5wSU9u4urLZoQ7XdF7VVltJJ6oL9eYF4leNg
         aPPu0xo4fVugACEOWwlA1T66oSPEdXVH1VxJFr7WvDXaOhH1IRSZ/DSwxNPRvEF6LY85
         kyVxAQZuCOrvIjBLcMxwprQ90Yxj2zjk/6tAZ/oI6Ck+CPyr3ITYpCHExbLzmzM7ejtM
         e21jptUFDbg8Ac2F8KauOhWvGo6CusPjVjbYNyFgufMHD8MIree9bVbpjtFbqTwkv+MJ
         2p8WpZYnfuuCSvsKB6T6YB2RwSjMtTfxWIIokRwSVzsEDV16OhkjMAyi82blXQlLHYax
         NBtQ==
X-Gm-Message-State: AOAM533xKxBfwEuFtjw2uEtibujC77N6DGYUXAAG1kREB9HeZPotfkUI
        mLIOVortyFRfu5SIo4+FpyDtUA==
X-Google-Smtp-Source: ABdhPJzJZIsoV7iAoqalIXWp6mzGqQalHQtp2jPJU/OINo7Arv9yvyl5bvzrXnJxJul0lIZXe1sF6A==
X-Received: by 2002:a1c:2e57:: with SMTP id u84mr10869481wmu.52.1595004967573;
        Fri, 17 Jul 2020 09:56:07 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        David Veenstra <davidjulianveenstra@gmail.com>,
        Graff Yang <graff.yang@gmail.com>
Subject: [PATCH 08/30] iio: resolver: ad2s1200: Change ordering of compiler attribute macro
Date:   Fri, 17 Jul 2020 17:55:16 +0100
Message-Id: <20200717165538.3275050-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kerneldoc gets confused if the variable does not follow the
type/attribute definitions.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/resolver/ad2s1200.c:44: warning: Function parameter or member '____cacheline_aligned' not described in 'ad2s1200_state'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Veenstra <davidjulianveenstra@gmail.com>
Cc: Graff Yang <graff.yang@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/resolver/ad2s1200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
index a391f46ee06b7..29cfd57eff9e7 100644
--- a/drivers/iio/resolver/ad2s1200.c
+++ b/drivers/iio/resolver/ad2s1200.c
@@ -40,7 +40,7 @@ struct ad2s1200_state {
 	struct spi_device *sdev;
 	struct gpio_desc *sample;
 	struct gpio_desc *rdvel;
-	__be16 rx ____cacheline_aligned;
+	__be16 ____cacheline_aligned rx;
 };
 
 static int ad2s1200_read_raw(struct iio_dev *indio_dev,
-- 
2.25.1

