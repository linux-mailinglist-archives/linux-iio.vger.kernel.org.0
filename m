Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9E838DC1B
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 19:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhEWRNs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 13:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhEWRNs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 13:13:48 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C5FC061574;
        Sun, 23 May 2021 10:12:21 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id k4so13780391qkd.0;
        Sun, 23 May 2021 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FVFwbzaqJkFQbw95QSxdKG72x5yeV8JgPBrXOT1pa2U=;
        b=TTZ3Z7RPhSXtLexI1i9Ez3Q6mw2GSrOOorQZ9Aq+R0u0SbXRK3OPck/1ARwAbenxwO
         CfCmANaKELZ0iT57dXSx0H9F96pl/Jk9BVcVigW+diVTTAIk8Ee/NDy1G3ouOT1Abfjv
         bIV/Ki6yTAjAXKMgHjIV6xp7al8d6RJndCL+2opSChmS8OFL4BIm068GL7mmQIBsLTr7
         HTBogbSyzqneISWdAQWmZxDaljut1bTYxa3OwBxX1cfXEp/6fiT+0QsLxrI29aCYqRKc
         kVZAQN0HmzjPYE7UH+2qlYqBjF2vhdTKUYmpFU3qxUdfjTOjrz5u/wCq1Kqwy1vKsuYH
         l/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FVFwbzaqJkFQbw95QSxdKG72x5yeV8JgPBrXOT1pa2U=;
        b=P7NxFsCSOVkLLb5f0piD5UBKbaSWEHMsnHwm11mPFPJI5LaaXkBrjIZIIEk1+WLHpl
         sj+IrD4ayVPnp8CkVkz3zunJypcMG0qSGqcziKRohrm9l0bv02ITrsMALrv37YO0iOex
         CC4JBr4nCn7LBQ8Hb4QsslFCSv++hRvfo1wE8JHTLhYExyLcbt4CxSKqFZOmj63UaqaW
         M+eOz2+pAtpP3tfJOskDc3uSLO7LStEb+ZwgtGiMu9zSi1xRWr2U6nYR7QsszUNSZKWe
         RTgfKZueEzjXF0oaxjnrGXEHkqizLpuIpub1/VKAhMN1L1VNlTBrAmM9X19fJ1L1T0sG
         X0Vg==
X-Gm-Message-State: AOAM531ivVu3EMGtDW2JIEOt0GpjL6nYhUVKtLfU9yn2xmvlkfurlKTe
        5u5wvtt+eflf3ZNNbw/IigfmSIpbO0GLRGFy
X-Google-Smtp-Source: ABdhPJxegZy9XqDTwQ82b4AgKjzCAY2P7VQFa9Wik5QZofZ583lov1CO3I1oQIEp0eivCXwoMMDRFw==
X-Received: by 2002:a37:b947:: with SMTP id j68mr23579888qkf.108.1621789940745;
        Sun, 23 May 2021 10:12:20 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1003])
        by smtp.gmail.com with ESMTPSA id x28sm8975699qtm.71.2021.05.23.10.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 10:12:20 -0700 (PDT)
Date:   Sun, 23 May 2021 14:12:16 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] staging: iio: cdc: ad7746: clean up probe return
Message-ID: <45443b8306893576824effaff57d40231de8e813.1621786036.git.lucas.p.stankus@gmail.com>
References: <cover.1621786036.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621786036.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Slight simplication of the probe return on device register.

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 12b2554a85b5..367a5990ae35 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -734,11 +734,7 @@ static int ad7746_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
-	if (ret)
-		return ret;
-
-	return 0;
+	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 }
 
 static const struct i2c_device_id ad7746_id[] = {
-- 
2.31.1

