Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB8B1D6EBC
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 04:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgERCVi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 22:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgERCVh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2020 22:21:37 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79136C061A0C;
        Sun, 17 May 2020 19:21:37 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id dh1so147142qvb.13;
        Sun, 17 May 2020 19:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MI/xOtYz1gKmyoKJ7JN1xfWZ15QiPgf/P/ZO62yZ6oI=;
        b=ATj+O5u3xLLXibwinbzTTX1jNuGYZ7yx2aXg6N8/fU5CNNPweoDHEmTs4nGIE/u1OQ
         zHBG64PAdb5oyvtlOyZ9Muu2RSjWkMJctTUKkUwKZzjgufadRvjkLFMkQus0bEXIwBV0
         pS2QTnR3mmW+5pyleWnmKU5coIAygPIYOYtDHETq/UhDeqqOh+6Un5JJWt9Keyrm9gT3
         8HcAxL7pWlyH7R0hoSj828jb+URux07n6Pgq8LQ+mmFuXi/IHVB6Sn7dbPE3cNGoyeUX
         27vNOolqnkvwf2IQs6ddn0bwzOkpCT+Sm+z74BNHWVKwA+FeMe1TYpE/gRUcsx0LSpMS
         zwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MI/xOtYz1gKmyoKJ7JN1xfWZ15QiPgf/P/ZO62yZ6oI=;
        b=mGAg+qz06Y+FTIVXMNVVa3yhcV/d3L9WHIikWwXoRDVjMnvDJk3y3ldeoeyo9PbvsI
         /SZzMbGwbPguBPywtKcNkYV0YVOB+P0NpMkGqFPoZyXLyYQ6vuCv1nJe1LzCyAol/GUj
         wFNPtXlA6100Qa/RvLPVTfT/92mOJqdm9V334iPdbHASWYmgAjB8ksMuhiryOG55amkC
         HpMj1d4okFTl/u65kOyB9M2GwIbi7FEtPsX/172CLvGPMxxSJU6uucAyEwUc9uuv2BL7
         O/7dVlPB/276pirJuNQxMaEsnQPpGn3KcpLmnpbSXUVyGAZczx+/zQYp77QFPV9os5EY
         t5dA==
X-Gm-Message-State: AOAM530f7uGiHVDep+iIZZ7O28gN9kcRumpgzD4J6hvK6C2RynbvLaEF
        KFB6B4CyV1O+k6rPdKFtOzQ=
X-Google-Smtp-Source: ABdhPJw0gRrAu197atVVJRuf4/d2wHUciiwN0loNhbPQ7UUg1uDhNwjlnggs6zRHotXXdp2W86VLNA==
X-Received: by 2002:a0c:f203:: with SMTP id h3mr13677416qvk.131.1589768496671;
        Sun, 17 May 2020 19:21:36 -0700 (PDT)
Received: from renatolg ([2804:14c:118:3134:db0b:3b38:feb6:784c])
        by smtp.gmail.com with ESMTPSA id i41sm8496262qte.15.2020.05.17.19.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 19:21:35 -0700 (PDT)
From:   Renato Lui Geh <renatogeh@gmail.com>
X-Google-Original-From: Renato Lui Geh <renatogeh@renatolg>
Date:   Sun, 17 May 2020 23:21:29 -0300
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Michael.Hennerich@analog.com, renatogeh@gmail.com, lars@metafoo.de,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        giuliano.belinassi@usp.br, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7780: Fix a resource handling path in
 'ad7780_probe()'
Message-ID: <20200518022129.xkcuw4yxotnll7ym@renatolg>
References: <20200517095953.278950-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200517095953.278950-1-christophe.jaillet@wanadoo.fr>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Acked-by: Renato Lui Geh <renatogeh@gmail.com>

On 05/17, Christophe JAILLET wrote:
>If 'ad7780_init_gpios()' fails, we must not release some resources that
>have not been allocated yet. Return directly instead.
>
>Fixes: 5bb30e7daf00 ("staging: iio: ad7780: move regulator to after GPIO init")
>Fixes: 9085daa4abcc ("staging: iio: ad7780: add gain & filter gpio support")
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>---
> drivers/iio/adc/ad7780.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
>index f47606ebbbbe..b33fe6c3907e 100644
>--- a/drivers/iio/adc/ad7780.c
>+++ b/drivers/iio/adc/ad7780.c
>@@ -329,7 +329,7 @@ static int ad7780_probe(struct spi_device *spi)
>
> 	ret = ad7780_init_gpios(&spi->dev, st);
> 	if (ret)
>-		goto error_cleanup_buffer_and_trigger;
>+		return ret;
>
> 	st->reg = devm_regulator_get(&spi->dev, "avdd");
> 	if (IS_ERR(st->reg))
>-- 
>2.25.1
>
