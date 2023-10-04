Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFDD7B820E
	for <lists+linux-iio@lfdr.de>; Wed,  4 Oct 2023 16:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242855AbjJDOSJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Oct 2023 10:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242865AbjJDOSJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Oct 2023 10:18:09 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5961CC
        for <linux-iio@vger.kernel.org>; Wed,  4 Oct 2023 07:18:03 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3af603da0f0so1397059b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 04 Oct 2023 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696429083; x=1697033883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R6/TWL/5A64z3k0Lwl1E33nP72so44fTzxRPPV1CpcA=;
        b=IBdP0jUYj4jZAgYuXmVD15BLL9LpAM28u30yQXTukgswU49v3Csy9bJz7wuhSxseWT
         yAZk6PryErWmkMBNFPzR9AW4V4tbAEE13/NSRsRl1cMvF5mi80/WmLYyUaKB9ekkzBUW
         VePUqa3BYCA0Ie0cR6WE3SkXBSylLKnaPCCUxRLs3/Vo0V++gLdF+gTw6uJEastwvRpK
         HlOXvmRneZCZWEAp5e3xh6xjpg9tVeKFmEmY5wbj6ulXQrneKT/MQnKyTbCEzo64ZLvx
         zQa0Vqtna+2ViI5eu2Zl/8hIKXE8jp/pQeuPa7RAmh7G0Pp3LgXqf12OnyW30H9fIHr8
         GhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696429083; x=1697033883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6/TWL/5A64z3k0Lwl1E33nP72so44fTzxRPPV1CpcA=;
        b=npAegqV1ndj1O7qvUOo7+3NISPxvSNaQRhGpw1B2CPTGlStrd/+eZEvFbWb935e2lV
         sGDyrOLA8xtT3eqGtqDKgb3VbCYlf/r3hktPzMW6SlkQKLZbqzAZIdJ4HLlTHTt52mJi
         430cDYIS9bhQS8A0M+ypbyQ6b0SxU+L8gjZo9SbLJxrOPLvSIQ9LJ8NAXBx+DiCODYf9
         e/SFYw6Sh/l/W9XFIEgWZ5tuVrZXy2/y8q+/l393pKNI0jzV9QLsR9AGz89s+daJ7KM3
         pC2B+jyidfuBvdeRrdOaWOqNn2/62NxXe5p+B4sK5MPLBGoGP2T3QQyuJxhKNcPFXDi9
         i+hQ==
X-Gm-Message-State: AOJu0YzVQQuO5OXMkjuXyFfZ7yD1mIS0UD/ssPUVYh2TuRgKWrj24w9n
        GzzeYCmDz/rkVwjMepZuQiut82WSYXhRPZXFEGP+kg==
X-Google-Smtp-Source: AGHT+IFZdENtnTfT/79Al2GkgFgZYzcroccNCoL23QouRO9oJfO6wYPYPzottJe9QhfLXLLHF1SUOA==
X-Received: by 2002:a05:6808:23cd:b0:3a3:b39d:a8bf with SMTP id bq13-20020a05680823cd00b003a3b39da8bfmr3100444oib.45.1696429082602;
        Wed, 04 Oct 2023 07:18:02 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id dz14-20020a056808438e00b003a78d196acasm523761oib.32.2023.10.04.07.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:18:02 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] staging: iio: resolver: ad2s1210: fix return with lock held
Date:   Wed,  4 Oct 2023 09:17:26 -0500
Message-ID: <20231004-staging-iio-resolver-ad2s1210-fix-return-with-lock-held-v1-1-812b932997bd@baylibre.com>
X-Mailer: git-send-email 2.42.0
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

We missed a return statement in ad2s1210_initial() that would cause
the lock to be held when returning an error.

This is fixed by replacing the return with a goto to release the lock
before returning.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202310030222.iokamE9T-lkp@intel.com/
Fixes: 0d03d0e65846 ("staging: iio: resolver: ad2s1210: rework gpios")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 98afd2e9ea41..67d8af0dd7ae 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -555,7 +555,7 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	mutex_lock(&st->lock);
 	ret = ad2s1210_set_resolution_gpios(st, st->resolution);
 	if (ret < 0)
-		return ret;
+		goto error_ret;
 
 	/* Use default config register value plus resolution from devicetree. */
 	data = FIELD_PREP(AD2S1210_PHASE_LOCK_RANGE_44, 1);

---
base-commit: a533eeaef80e879b3ad1937eee7a43d1f9961c5d
change-id: 20231004-staging-iio-resolver-ad2s1210-fix-return-with-lock-held-f547ce6fae49
