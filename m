Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527647BE722
	for <lists+linux-iio@lfdr.de>; Mon,  9 Oct 2023 18:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377804AbjJIQ6B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Oct 2023 12:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377730AbjJIQ54 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Oct 2023 12:57:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB73FB0
        for <linux-iio@vger.kernel.org>; Mon,  9 Oct 2023 09:57:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32003aae100so3545744f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Oct 2023 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696870673; x=1697475473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2D+qd1LEt3eJ/8XHGRVqxXgOIKNs9E3/VA/WHhSU4M=;
        b=MPD6ZLz3Oygw97Ahyj3zMbBaAvQcaeBhP4L0iVE53kYmz51MUTV7Z40oQDqXtj5PKX
         /YxCDgtUIoCEgUlOCwFDcZGzuBLalKfv4dyWpAVMJZXoNjjgk9/2/66L92j6R7Wtdnkn
         //uFE74D9h9n4/EbntkNepOWScQwhUcgxNLA5fBb3G8kSogc7z9KkXMAFq/LTR3EejoJ
         J4q0afWgH6VWW4GBiOkkiLZQcSKDer3mrri4QkeYhMDa4h3AVX3KGTQGnanAAq57cjlu
         vAE+7pNAI15CDWdLJrORbaEayWTDDtxKWzmXptNhwhasP8z238s4gcx37w1NHq7U6WYV
         RMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696870673; x=1697475473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2D+qd1LEt3eJ/8XHGRVqxXgOIKNs9E3/VA/WHhSU4M=;
        b=PYDzcLF7AllO59X7DdYBrPAuCvglXfqHX5Gsp95/U8FpDaIvf1zYOtIKahmnOfFfZj
         n0XCrcz60SXW5Fi13ND4kIcg9bqjvpXZ4VqGthzc2n5dciTUbNY3Z2NKIMUtIVaX7tl/
         +Bw85BMb5YVuqhvb/R7Fvy2A5mLmNnIwYAmZgyr/0s99G49FycKtkwCqKbdJQndTNjW6
         DOljSuTdgTdFUGQc4SVT98op3h6AhuoXSO4Gl0pW+EWHt5/i37U2Dup9y6Y9rTa/+hg4
         CH+Mvo7T/GRS00FFULxjt9X616l79YUIasaBsOVeTJ/f4aT/JmrmmzvApYKZo5gO782x
         NDUQ==
X-Gm-Message-State: AOJu0YzeGgBHYUNSaTJNz9idq7qp33nOvTm14fYdAcrb27dYAQaPGQcF
        7NAGGQdybz79kuj08nfrR8ExYA==
X-Google-Smtp-Source: AGHT+IElXmP4SCjtxv9ewcCHPAkm9pRR5k2/mRyhENiprO5xOyrGrQtF+ixAcWjFdyzzy5QLvmmn1g==
X-Received: by 2002:a05:6000:1092:b0:320:968:f3b0 with SMTP id y18-20020a056000109200b003200968f3b0mr8718653wrw.35.1696870673079;
        Mon, 09 Oct 2023 09:57:53 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f49a600529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f49:a600:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id d9-20020adff2c9000000b00324887a13f7sm10199828wrp.0.2023.10.09.09.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:57:52 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] drivers/counter: add local variable for newly allocated attribute_group**
Date:   Mon,  9 Oct 2023 18:57:37 +0200
Message-Id: <20231009165741.746184-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009165741.746184-1-max.kellermann@ionos.com>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This allows the compiler to keep the pointer in a register and
prepares for making the struct field "const".

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/counter/counter-sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 42c523343d32..47e1e2c61cf0 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -1122,6 +1122,7 @@ int counter_sysfs_add(struct counter_device *const counter)
 	struct counter_attribute_group *cattr_groups;
 	size_t i, j;
 	int err;
+	const struct attribute_group **dev_groups;
 	struct attribute_group *groups;
 	struct counter_attribute *p;
 
@@ -1141,9 +1142,9 @@ int counter_sysfs_add(struct counter_device *const counter)
 		return err;
 
 	/* Allocate attribute group pointers for association with device */
-	dev->groups = devm_kcalloc(dev, num_groups + 1, sizeof(*dev->groups),
+	dev->groups = dev_groups = devm_kcalloc(dev, num_groups + 1, sizeof(*dev_groups),
 				   GFP_KERNEL);
-	if (!dev->groups)
+	if (!dev_groups)
 		return -ENOMEM;
 
 	/* Allocate space for attribute groups */
@@ -1169,7 +1170,7 @@ int counter_sysfs_add(struct counter_device *const counter)
 			groups[i].attrs[j++] = &p->dev_attr.attr;
 
 		/* Associate attribute group */
-		dev->groups[i] = &groups[i];
+		dev_groups[i] = &groups[i];
 	}
 
 	return 0;
-- 
2.39.2

