Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11217BAFB3
	for <lists+linux-iio@lfdr.de>; Fri,  6 Oct 2023 02:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJFAvL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Oct 2023 20:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjJFAvJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Oct 2023 20:51:09 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EACE7
        for <linux-iio@vger.kernel.org>; Thu,  5 Oct 2023 17:51:06 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1e106eb414cso1018157fac.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Oct 2023 17:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696553466; x=1697158266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmnWnKvM60dm/oO+QIaL6SFHQ4EDYTo8nwIRSW4SLrI=;
        b=PF/idpmj+1syfPcemCEME+Oj7dUosCzZZ9H/mDEyV+Qb+Ss3P80kTGQ3DsML0PyeW4
         AjQIJR3OBT8HdwmDLxsqIPMPf5+ok5kQ7gEwPFncueKhcKWNdnb1ONL0RLARqOXH5mfe
         jq8LMUIX5ZX6kt/GxA30dMyXZ5PUxOWOjtYtGRnJou8MCnkKVT5mUroFriDygb+tft6B
         PRUu7MU6YPEg/UTSYPDzwjrYMUCCOd4FymqzM/xycF7SQfuaHWrfQKuKQfuDA7d8CDCw
         vMoLpoTFFNAgi8greS6BQxDhYUj717t9R9vcg7+OS7c+mEAaMm6PzHLeL1Qw1uKCCCnj
         xYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696553466; x=1697158266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmnWnKvM60dm/oO+QIaL6SFHQ4EDYTo8nwIRSW4SLrI=;
        b=W1OSRBaprBvz2n0IuFjx0PvJ9wCI2RB7kxiQQuYfooOUNdIrNtvDRCOTZ/FzekSG6l
         Rd7FVKVCWd47Tr8fw1Phmp04PEC/aYAOrDU/6Nh5gWesk8k/hhXHwOSeiZiLbAUScqhC
         eV8by+AB/6noCcpx629Ciyg9MZjJo9vr/Z2M2/t1CDNdO/9ZdDJ4nXkiNm7WlLrnEcYT
         l49H8CtmOSDgjs9+fbuxKUOizmo301aVYZYPvqYYbkRbeAjTggPN8sgNFgV6v4MVEK10
         yl2RPRX7+0msnSARvPDGiw5UmBTfY+R3kUVefi4c4Hk3dwsawomosKmeXqj6KX0K+0uE
         cQLg==
X-Gm-Message-State: AOJu0YzUjggotGZpTNgxWovv4tb7DQUCSROiqQKzUfxKNbRcjr9uorZq
        f7b7JLxQu63sIO3Y2DxjByTpuK066rsduSXxjNgqtg==
X-Google-Smtp-Source: AGHT+IEv6WtS6qh9/yTfpep5SGFAYpPtAHL09gstutBcqD5TCzldqYdZkPKppJ2qxWVI1cuLcrDWug==
X-Received: by 2002:a05:6870:9a21:b0:1db:3031:c97c with SMTP id fo33-20020a0568709a2100b001db3031c97cmr8089382oab.26.1696553466001;
        Thu, 05 Oct 2023 17:51:06 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mo9-20020a056871320900b001dd0ff401edsm545072oac.51.2023.10.05.17.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 17:51:05 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/17] staging: iio: resolver: ad2s1210: do not use fault register for dummy read
Date:   Thu,  5 Oct 2023 19:50:18 -0500
Message-ID: <20231005-ad2s1210-mainline-v4-1-ec00746840fc@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When reading registers on the AD2S1210 chip, we have to supply a "dummy"
address for the second SPI tx byte so that we don't accidentally write
to a register. This register will be read and the value discarded on the
next regmap read or write call.

Reading the fault register has a side-effect of clearing the faults
so we should not use this register for the dummy read.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes: New patch

(this probably should have been done before "staging: iio: resolver:
ad2s1210: use regmap for config registers" but was overlooked until now)

 drivers/staging/iio/resolver/ad2s1210.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 67d8af0dd7ae..8fbde9517fe9 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -166,9 +166,10 @@ static int ad2s1210_regmap_reg_read(void *context, unsigned int reg,
 	st->tx[0] = reg;
 	/*
 	 * Must be valid register address here otherwise this could write data.
-	 * It doesn't matter which one.
+	 * It doesn't matter which one as long as reading doesn't have side-
+	 * effects.
 	 */
-	st->tx[1] = AD2S1210_REG_FAULT;
+	st->tx[1] = AD2S1210_REG_CONTROL;
 
 	ret = spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
 	if (ret < 0)

-- 
2.42.0

