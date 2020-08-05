Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4617223D3E3
	for <lists+linux-iio@lfdr.de>; Thu,  6 Aug 2020 00:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgHEWWv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Aug 2020 18:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgHEWWu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2020 18:22:50 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07204C061575
        for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2020 15:22:50 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w17so26395176ply.11
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2020 15:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=C7jRxiEWSkPb08M8KnKtQzQRuV+vVeTwV+miKN/MORE=;
        b=aSHTNrMX71mvGXhVa+/WHhW9loObH5TbqUceiCThUk+NDaFVAVUiD+iBqicBtpaZqI
         aJaM9FSAXIZUhhpAgxEwEtuf6ZFPLMkSWf1UjS6YDtSQS6vOsGCbbwoQhgM8+YAKFpuM
         bIBW/5sz9tdFL2jaDlxAG/hQMzQKBDxmQauYNOQt+bgwQDlsJvrWaZBI+bAdVxY2S0dE
         5QlBnYTijlI0cMCNJ7F3SiFzB73huqFyMiweM0fIGni16nO5kdXlSAmTIeq5ENHAMd4Q
         j1SX9Qg5fqyLayHdSVn40eLulbXKlK3znxlEqllxHczIjHrL9xAezdqzbd9DaXD0KV4d
         /S0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=C7jRxiEWSkPb08M8KnKtQzQRuV+vVeTwV+miKN/MORE=;
        b=X1N72GVpA9jeJ7kavFZ7eyaIzHuCy5AURDIYomSmRoE3sU+uY/viC0UscR4Dpx5Qyv
         /V3wx2YufSZVIfTqlyOB5qmacnkahlUZzBGo6Qc1yGBNI29hKYAK4lhXlpfJ54Zf9Kql
         BkzLl9FJqF8NUvmvrz4jrdTgp9WgtpgtHo2H4NfXcWHdK6rJpZHkK99YUtjgrGA6vKq3
         5p2sYkm/PldHpGMUygPK4vNGbeJk6Iy4ZQvDigBEJvOBOZNNzU7OinGaHXVUpVXZweA4
         N7qdzXXUbfYamkNzTcBSrl2ww+rXHV5HiIlkVLriNCvqKBAc0W7CGcGuE6VjLWzy73rH
         7dxg==
X-Gm-Message-State: AOAM531l9vk+7U3jbLGWTMIcn6cczXnPNZSAkRSSIK8TU8q51Qkq+ISU
        hYu8oNHjCN+XOszrtem/suP2bIbI4YGw7A==
X-Google-Smtp-Source: ABdhPJygScMfP/7+ItTfHi7dW6CBvdYC9WLFdGHLOK2kVlj4TtxJLi42CJIzR9mvAA9zLSqqBaTxzg==
X-Received: by 2002:a17:90a:1aee:: with SMTP id p101mr5245441pjp.138.1596666169395;
        Wed, 05 Aug 2020 15:22:49 -0700 (PDT)
Received: from ougon ([2605:e000:121c:c291:0:f2d3:694a:387b])
        by smtp.gmail.com with ESMTPSA id t63sm4010641pgt.50.2020.08.05.15.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 15:22:48 -0700 (PDT)
Date:   Wed, 5 Aug 2020 15:23:00 -0700
From:   Calvin Glisson <taragaram@gmail.com>
To:     lars@metafoo.de
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH] staging: iio: ad9834: Remove excess blank line
Message-ID: <20200805222300.GA5402@ougon.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove excess blank line after variable declarations.
Improves code consistency and readability.
Change suggested by checkpatch.pl:

CHECK: Please don't use multiple blank lines

Signed-off-by: Calvin Glisson <taragaram@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 77f77a2b2e05..262c3590e64e 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -397,7 +397,6 @@ static int ad9834_probe(struct spi_device *spi)
 	struct regulator *reg;
 	int ret;
 
-
 	reg = devm_regulator_get(&spi->dev, "avdd");
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
-- 
2.26.2

