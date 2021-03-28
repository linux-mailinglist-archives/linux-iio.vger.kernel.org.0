Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4CA34BF6E
	for <lists+linux-iio@lfdr.de>; Sun, 28 Mar 2021 23:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhC1VrH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Mar 2021 17:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhC1Vqb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Mar 2021 17:46:31 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E95C061756;
        Sun, 28 Mar 2021 14:46:30 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a11so8118680qto.2;
        Sun, 28 Mar 2021 14:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rzFuE51HjLtetaV2oxoek+FpFdBLQabZgkx6sZySstg=;
        b=rHYNafv7PqWQQyAIXR4YDq7gsrZBNureSM6KvkN/3mcNIfnZ3v1scNOjB8d/hX/mZ0
         LwzMW8FvqnhWXnHs+l8ZLfFoUv6TYYJIO0102otUTOmZeliRPcvE6PzGlfmr1SZCfxXY
         2P/VZa2JK1CZt738ATPQjHe3oB3l0bGdHX8ZI2vObPDWe+u1C/XVNh67Su/3AoksXpNS
         IWkPS2GdqAbFVtiiAXJd2SxOZ1LNQhYi4+YZ4VemQqTmpotK8Vmdpzw5ntLVX5PLTaDO
         ysB5jpDL6ic8qvOTfSvaUx9PVPZzmPj7PoAmKigW2NwXpq+AUxatkoM79VWnK4offxMV
         veaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rzFuE51HjLtetaV2oxoek+FpFdBLQabZgkx6sZySstg=;
        b=JafxkgROlS/A++9B/5dX8tw4eKbShjzfXL9utZZ8sCTkACMzCE9hrUf27fMheo03Eo
         FLg8JjnbBMNtdUQhxZhBu8y5n9rHmj5E04ryE3ZbHz7Q3uvFIhwV78tpxv+rVZ9v744l
         GZ4x2NdEeb1YDFP50JxYhzNguyWfOk4VavwPakPlykeep8bsK8o+5he99/dU5/SBag0r
         HpXFnBttsNubCdVXS2ug0yUEes42pFVgeLUUpgCcyqDxUCMYKjbJZpHpUyN/XtKKG3qF
         kDuG1Zd05y18hosjBmfaKAxy68+k3o1hKozA/L+ErpcRps1fkwn9s7hvPIfQMru9Xu89
         T43Q==
X-Gm-Message-State: AOAM530ugcF8jvKmDB+ftm4aJTshjGydIjVHbfuDE36fQKZakflv2JNx
        7KXpigs3L0AfT+uV3YVMSvw=
X-Google-Smtp-Source: ABdhPJylliaFA/gNKpxH011aGmw0mpAaMh3sAAA6phEUewnCul6FVN5oOYKYxT0XoPHjjuM7zPY4yQ==
X-Received: by 2002:a05:622a:9:: with SMTP id x9mr20506856qtw.189.1616967990210;
        Sun, 28 Mar 2021 14:46:30 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9e91::1002])
        by smtp.gmail.com with ESMTPSA id q125sm11825224qkf.68.2021.03.28.14.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 14:46:30 -0700 (PDT)
Date:   Sun, 28 Mar 2021 18:46:26 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: adc: ad7923: use device-managed function for
 triggered buffer
Message-ID: <fe46a45caaa788f333d78367968272de728f4a6e.1616966903.git.lucas.p.stankus@gmail.com>
References: <cover.1616966903.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616966903.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Converts the iio_triggered_buffer_setup() call to its device-managed
counterpart.
With this, the error handling routine in the ad7923_probe() function
becomes unnecessary as well as the iio_triggered_buffer_cleanup() call.

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
---
 drivers/iio/adc/ad7923.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 3418ef6f0857..d07eaf3111ed 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -351,20 +351,12 @@ static int ad7923_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 &ad7923_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
+					      &ad7923_trigger_handler, NULL);
 	if (ret)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_cleanup_ring;
-
-	return 0;
-
-error_cleanup_ring:
-	iio_triggered_buffer_cleanup(indio_dev);
-	return ret;
+	return iio_device_register(indio_dev);
 }
 
 static int ad7923_remove(struct spi_device *spi)
@@ -372,7 +364,6 @@ static int ad7923_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
 
 	return 0;
 }
-- 
2.31.0

