Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BE329E53C
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 08:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbgJ2HzD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 03:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731089AbgJ2Hwj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 03:52:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B680EC0613D9;
        Thu, 29 Oct 2020 00:51:51 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 1so916424ple.2;
        Thu, 29 Oct 2020 00:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfAmgCJp6XBS3CiRlJG+P+rWY7X14IqPx3fC7yq/vuY=;
        b=YZw7MU8In/xzm8OvxyQ0PkTj0nuTzquACNYVfNxocqeEEvcQ0RzhIDCIuU0rgs32mU
         wMJEQL6gxivii6gjz1j7XcGMiTwulDldK/Z1l0+PyrtTTOs4/w6jdxfGbcZVeCkKw8Hs
         1jzVvD3vjJQ0BX3Ql5tIBg197293Ioi2lz1EYqSKFb7tL+znuZwGC03oJcwG9a+BW1Yp
         tperapjpr3zb6cO4Zf6sygNo2uASyLLyk+giZlrdbybHrO0yNtL1lY9Af4BHy8fkwCp4
         1of53E7ig3yLrecWum5vOmK3ZSaWiDWl6O2VI0z0fizIaI2lWur0kU+tKwTsDReJY31P
         kZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfAmgCJp6XBS3CiRlJG+P+rWY7X14IqPx3fC7yq/vuY=;
        b=qCyFP2iaH9FfGnUNQCCKhUDlXjuc6PIf5KylzGlgOgLI2LdmXKgmcjHHlt/FeUDsKk
         uOsQKOE9XMlPRqOWeeRY5hkdCMnYB2lil13xwxI/QGPyxyq6vXPQiZRXWWWDO3lPpGfM
         KYeCjSUpwuHfuZhwmrVcVyVT7HdxuceliXyvEe7WWgpFq/hswWJh6G6v7ia50xgadO8r
         M1uUSXK1pHYO/G4gVdEwMPuIy9XB3dYNLXpT26C0j9j9xe0PBji6Q07VP4E9AjwhJrSx
         GQMnc/nM7+W5w5MpLC/oT4dXA7Hc6PBx7faOAuQoV5IC56HwA0djBApftBzggaN5YWUr
         shQA==
X-Gm-Message-State: AOAM532ohKJaw8daoVt2Aoowbo+ZZwmOQ/TIXTIVXztuEnW6HTgIBw6J
        HKjKOB2qqoFLzj4VVP7drv8+cqf4DW2LAOaV
X-Google-Smtp-Source: ABdhPJwc3VaZKXxenrpB0I5h3HuPXvxhgJXxuQ2dX3aAGxS/psGd6Os+8CFGSaUfdjvNvQxkhNMiwg==
X-Received: by 2002:a17:902:bb86:b029:d5:28ac:8800 with SMTP id m6-20020a170902bb86b02900d528ac8800mr2793611pls.27.1603957911357;
        Thu, 29 Oct 2020 00:51:51 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id bo16sm1920225pjb.41.2020.10.29.00.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:51:51 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 13/15] iio: light: us5182d: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:49:08 +0800
Message-Id: <20201029074910.227859-13-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074910.227859-1-coiby.xu@gmail.com>
References: <20201029074910.227859-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/iio/light/us5182d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 393f27b75c75..15c6f8db3fdc 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -918,7 +918,7 @@ static int us5182d_remove(struct i2c_client *client)
 	return us5182d_shutdown_en(data, US5182D_CFG0_SHUTDOWN_EN);
 }
 
-#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM)
+#if defined(CONFIG_PM)
 static int us5182d_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
-- 
2.28.0

