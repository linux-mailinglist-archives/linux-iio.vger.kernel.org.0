Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50AA29E4F1
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 08:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbgJ2Htt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 03:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731783AbgJ2Hth (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 03:49:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8573AC0613CF;
        Thu, 29 Oct 2020 00:49:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so1669834pfd.3;
        Thu, 29 Oct 2020 00:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XJJATTLMG2kRLmAM2tHn94nYgGt4dPLhfdTdqDPw4OA=;
        b=JaqJf3npz8P4CJmHUBoIM9v5JqYWF+80oICAvGhYa46KcXnT9e3GvWK4fUmuuYCHrR
         /frkXq0KRnuZf/KDzSmR5XQ5MiAJ1TgR39t+Wn0yiD2CcE8WTcsza+kMRfYgjMDouRX5
         lsMw1UBzppRoBWNwfUwzzCQ+j2zjXi0d0D215IjQJ2WAPL7bgx6hbyk8HX/2x2/29iWe
         AlUVi9UrvsavaAFBTlif3tohSFwBuQO0CiRnJlgqUmtNdRoPUewDw8Uchids/0tKmYHe
         G31hGEziBCkfsrsVxrhfVROalNc0aj4TxyFTQjl9d2+vsKvNzl1+JXIAvAcfn22Y0mUo
         onyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJJATTLMG2kRLmAM2tHn94nYgGt4dPLhfdTdqDPw4OA=;
        b=GC/cYlfwpR+vla9LnM5xntZvkeeA4r5wKbIC9yIjqSi88ZALo6gceom/s270T8UH9t
         noHy397h+wpRJdxpIysBfBYAIJv7NHEtjBlcG1XayD5mrl9UzWIjXaMRaJ+AS0PG9U5R
         YeqmfmkQnrS02Df/GS99E2McWeQjBm569XzlvJ41WI5dFOgVgzJT4WW/hHFgP5wbjnon
         mqqbb0MxbUJU2Jd5O3T70zSpqtRgYKhvyLDuVr7gYWr0SVoBd1ACVGQlh7uPJxjOI0In
         7Gc+Pcx4Vk98PpMH2CSKc/sUr5FeGxQ47FgAgooavOdp+c3Nd1P5ynY/wY20tSLK/1xP
         GV0Q==
X-Gm-Message-State: AOAM5314KtJ7ruHjhKpoTM1FP4nnY/iQo2X2VcdInMI40rHIqeVSsEnY
        UiGRIfOwMv+FxDK9JcRZ1UjiCKARSItUWX2K
X-Google-Smtp-Source: ABdhPJyUvX8REyEq1gw1gZjvui5bDOwIWGZCj5tTeqoeRJ82kFRlzosb8oIsvDVlZFMvUf+Qcvu+pw==
X-Received: by 2002:a17:90a:aa91:: with SMTP id l17mr2973601pjq.198.1603957777159;
        Thu, 29 Oct 2020 00:49:37 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id i2sm1897422pjk.12.2020.10.29.00.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:49:36 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 02/15] iio: accel: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:48:57 +0800
Message-Id: <20201029074910.227859-2-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074910.227859-1-coiby.xu@gmail.com>
References: <20201029074910.227859-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/iio/accel/da280.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 4472dde6899e..c82d241491dd 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -160,7 +160,6 @@ static int da280_remove(struct i2c_client *client)
 	return da280_enable(client, false);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int da280_suspend(struct device *dev)
 {
 	return da280_enable(to_i2c_client(dev), false);
@@ -170,7 +169,6 @@ static int da280_resume(struct device *dev)
 {
 	return da280_enable(to_i2c_client(dev), true);
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(da280_pm_ops, da280_suspend, da280_resume);
 
-- 
2.28.0

