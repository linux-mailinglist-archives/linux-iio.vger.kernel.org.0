Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309BD7B38A3
	for <lists+linux-iio@lfdr.de>; Fri, 29 Sep 2023 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjI2RZz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Sep 2023 13:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjI2RZy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Sep 2023 13:25:54 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3D61B6
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2023 10:25:52 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57ba2cd3507so5855922eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2023 10:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008352; x=1696613152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gkx5P/I+qjqJv4UaL/3S8ec+xgMfUSpu8JHr+ZyL9fM=;
        b=qO0Ld7aZUFIP41AkqcMkH836Bw6dUV6LNLbPOBBRC9iWgyb4tgaitmR0FmhOio8aGs
         fEilizl6C+cuFNqP5x/VfMiRBNZWEwYuV59whLDT3HfBE+UAbpwSSF9uA7HPjOeDx33K
         rVpre+LrU/bOVpeVdKWvC4tLxKLAIX7ZfgLekG2w3o6SrfWOHwPtd/WOCG8U7I48bI5l
         D/T18RaBW8U1exBE+xtr/WZ9gGuYOXotnUEsF5Lgig8yskWhhRlbrAIjmzNqZVJtXbxg
         JODg4LODhZS+KheV8+nz5OcvksUFme36MjssjpaXCN3Efm3h36NdsQb196q3W7E71U+B
         fMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008352; x=1696613152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gkx5P/I+qjqJv4UaL/3S8ec+xgMfUSpu8JHr+ZyL9fM=;
        b=nafqbRP/f+a0ECaK1si4CQzhaTMg1MdzEeOE8mvRxg5HkI3i/efG62ZC1r7l2sJL/O
         T9n2Nki4bfPQKfIuj0dJDx0skRw2AbEdfMYifNSkjcHHvz23u3A8XLGNJELD8FMpAS8V
         MebebP5bMS1CVjyfvksW9bA5nectoDZrHUeduQqHxrBka00fWDlFZbwtdjoU/z+Qp2h8
         dp29WEGxs6hAw0Tw3kx6Y4ylHpzNQVJ2FH+wofoIMQZ0KdKaw7v7+JdKS9XSkWaxmwcg
         /04ad+1+yIAh0zuo10cc2AHrCrs0biXKpPGsOtKqxvC663GuPCYxXN3a1srJTM/bQLe8
         84Iw==
X-Gm-Message-State: AOJu0Yz4jbrzYnnygnR6YuQjCWj9Sm8eMwGEUlxMgvvc49pci6ZLx6+C
        qzruspSUBiqtLahZn0aQrBsIYJmpdZcyqqpJTHAYhA==
X-Google-Smtp-Source: AGHT+IFxikc/8KvEMGZ+gJBnorvyfx+jDYYgmBwRwAiusDLE/tDFFURBfLomSTduLrTMqWfQBD006Q==
X-Received: by 2002:a4a:3c07:0:b0:57b:6f5c:c90a with SMTP id d7-20020a4a3c07000000b0057b6f5cc90amr4717791ooa.8.1696008351927;
        Fri, 29 Sep 2023 10:25:51 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:25:51 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 06/27] staging: iio: resolver: ad2s1210: sort imports
Date:   Fri, 29 Sep 2023 12:23:11 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-6-fa4364281745@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: David Lechner <david@lechnology.com>

From: David Lechner <dlechner@baylibre.com>

There are quite a few imports and we will be adding more so it will
make it easier to read if they are sorted.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* This is a new patch split out from "staging: iio: resolver: ad2s1210:
 use devicetree to get fclkin"

 drivers/staging/iio/resolver/ad2s1210.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 28015322f562..832f86bf15e5 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -4,16 +4,16 @@
  *
  * Copyright (c) 2010-2010 Analog Devices Inc.
  */
-#include <linux/types.h>
-#include <linux/mutex.h>
+#include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/spi/spi.h>
 #include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <linux/sysfs.h>
-#include <linux/delay.h>
-#include <linux/gpio/consumer.h>
-#include <linux/module.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>

-- 
2.42.0

