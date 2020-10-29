Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80CE29E539
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 08:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbgJ2HzE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 03:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731175AbgJ2Hwj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 03:52:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22724C0613DD;
        Thu, 29 Oct 2020 00:52:09 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b3so1678747pfo.2;
        Thu, 29 Oct 2020 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h5HNd+1MHPcATDzA0dNegCzozzrt6LOIaewSq+EiFJA=;
        b=oPao4NYfZ2uyj3EZCi6YN6EbSge3yEQZJJhHJch2QclcaJMZkYujDNbjFVJWkPbFdQ
         om5o7K7w/mqoZaX9L4sGJLkTSHcltW2oaJbc/LxLC4yjTec6ZI8FjtK4y1wGHQZQWqW3
         4u+t92cdTxo8oy+j3R/kNl6Rk5ZLuN61G1U7ygsrX7sgdaNg95BdczMdI4aySwQI+AzH
         zdncXDeBBG2wJBMq4sfscw+CUFEfIlrWSK7iXCfAy3robW814nJpwe6qgKdM9Mwjb7gG
         TeRKbj/e1Yrud8qV3PFD4w9J/4t8t8EkgFa5opnnWFagTQ8T6qj66WAqIBSBUScZ6A56
         PlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h5HNd+1MHPcATDzA0dNegCzozzrt6LOIaewSq+EiFJA=;
        b=dTYW85dRAaolZfHUtT4QvJ1mGFFXTC3Ch2ASh9mt9QhgE5vdCcpsqRcqUJXWeU7TxT
         vyr9LeF2Nn5iYQiOuqViFnKApWYuHLQ5F7xWq8UUNq1ztH+K5QkXu4NsFf1PzsOsOjJd
         5YBYmBSvXaNgMZcQxUlSMAI/7W/THT5XgC4KEIrBw6jSN0EiJR3owyac7hxqcNrxQUCQ
         VH1vnRj8BZUWCF2smSf+HSEvm4b0V1iTIKkc2WobndAcOOl/0GSDhfADlBLf4FkNK4UF
         xc02RzJZVFtfTsJU0QP2enx8tf7lk+EEBhuPO2mhOqbpxKxr7x9VSh0XvcRKLFTZqJkO
         1xTg==
X-Gm-Message-State: AOAM533rPgl0OOtHFTryJOdkheS4r8U57h09kSc88BKHwNsgIAp9hcJv
        PLuD2PslpishwErW39TWLgI=
X-Google-Smtp-Source: ABdhPJxhAkI44YDXehLLqYzEAveQzMKPLcNf3ICSCQS0rNCgXYn2TXij02zGpcQbodvx2fzi+3QxVA==
X-Received: by 2002:a17:90a:6b08:: with SMTP id v8mr3052424pjj.126.1603957928772;
        Thu, 29 Oct 2020 00:52:08 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id f4sm1789665pjs.8.2020.10.29.00.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:52:08 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 15/15] iio: proximity: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:49:10 +0800
Message-Id: <20201029074910.227859-15-coiby.xu@gmail.com>
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
 drivers/iio/proximity/sx9500.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index acb821cbad46..f4d55d217582 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -994,7 +994,6 @@ static int sx9500_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sx9500_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1031,7 +1030,6 @@ static int sx9500_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops sx9500_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(sx9500_suspend, sx9500_resume)
-- 
2.28.0

