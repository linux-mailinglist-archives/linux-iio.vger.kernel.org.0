Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45D22E3466
	for <lists+linux-iio@lfdr.de>; Mon, 28 Dec 2020 06:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgL1F7Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Dec 2020 00:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgL1F7Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Dec 2020 00:59:16 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2E1C061794
        for <linux-iio@vger.kernel.org>; Sun, 27 Dec 2020 21:58:36 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n10so6759700pgl.10
        for <linux-iio@vger.kernel.org>; Sun, 27 Dec 2020 21:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+r9s3QVCdRffMDQ1Efrn0VnTvZ21pJ0RZgWYWhFHP7U=;
        b=N8HHaebd/uv5IenFxQXxCuwFEmkXgn5iNzOvmuUD2ccJ+tuUCiPjnvsmc2Am822wVp
         jj9esU4sq4i7oDrIOXTzHzHrVg6MgDhFSSjs+GB4R1MNjEWqCUp6pu6cJQG7oE9xiCO9
         AXohgz+0rdsyUB9bLmNZkeVsYcoqVtfw8oFdNn1kel/hD1nxP6kvYbTnO4VShNCGoJ0/
         LstvBw5r+qiZqrV3TG5WeBlBKjxtLk39xYTbrBebSXX4PfLf7mMciv8tMKbIMrtSQ711
         mcQqBBMoXy8hd8WlPVix8/VE6XjOMW/i39wf6bwkHa7uVVNcqj3vXpv/Fyn3P7LK+BCY
         Rm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+r9s3QVCdRffMDQ1Efrn0VnTvZ21pJ0RZgWYWhFHP7U=;
        b=e6JqHnOFacD4Q19wTQN77tdMvzNOgfi9WaeJRs7yyXCt7zFT3Tg8apcSKOQE6umsTA
         fOXJwWjhy1RQsBrBNX5XHp+twcyrRc3wPEt0ZqTSFc0toO33mzK/vc/eT9f5iQC+rmSr
         tQWr8WD18zs0DuCwY9n38x51LyKKksoiyrutAMUI0yKxMfyCUcHtC67NkwR4QKo4W3eu
         ePWHPo2Z+YI4L0BngwJlSGPvVCFeSDXMEEXPeoMErqqI+CH5KVgc5tu3lKEWsh+BBw/Q
         7SLj2bzHQH7X0b9kPdtCDHY1mqP+nkAfNKiCzzwBNwH4q5M8yCVzJUPZnLAGexWbwEf6
         ozQg==
X-Gm-Message-State: AOAM530HXSylmCvK4AyUomB/VvUqqZMLHQl7sKDBINFF2ieJrcYtedhJ
        woERD9+4wGaxNgGVuRQnFhlV
X-Google-Smtp-Source: ABdhPJz01cDLdAp51BgVmbaXZWmJbKALqWqvNV8Dhu9RbkuMBygEWSDdvJ2Aag3kqjolyRVkHeJbGg==
X-Received: by 2002:aa7:810a:0:b029:1a6:501b:19ed with SMTP id b10-20020aa7810a0000b02901a6501b19edmr19254712pfi.17.1609135115615;
        Sun, 27 Dec 2020 21:58:35 -0800 (PST)
Received: from thinkpad ([2409:4072:628e:e0a:f938:76e5:9a02:c8e8])
        by smtp.gmail.com with ESMTPSA id v15sm31420282pfn.217.2020.12.27.21.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 21:58:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Google-Original-From: Manivannan Sadhasivam <manivannanece23@gmail.com>
Date:   Mon, 28 Dec 2020 11:28:30 +0530
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: vl6180: Use DIV_ROUND_CLOSEST() instead of
 open-coding it
Message-ID: <20201228055830.GA9634@thinkpad>
References: <20201227171126.28216-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201227171126.28216-1-lars@metafoo.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 27, 2020 at 06:11:24PM +0100, Lars-Peter Clausen wrote:
> Use DIV_ROUND_CLOSEST() instead of open-coding it. This documents intent
> and makes it more clear what is going on for the casual reviewer.
> 
> Generated using the following the Coccinelle semantic patch.
> 
> // <smpl>
> @r1@
> expression x;
> constant C1;
> constant C2;
> @@
>  ((x) + C1) / C2
> 
> @script:python@
> C1 << r1.C1;
> C2 << r1.C2;
> @@
> try:
> 	if int(C1) * 2 != int(C2):
> 		cocci.include_match(False)
> except:
> 	cocci.include_match(False)
> 
> @@
> expression r1.x;
> constant r1.C1;
> constant r1.C2;
> @@
> -(((x) + C1) / C2)
> +DIV_ROUND_CLOSEST(x, C2)
> // </smpl>
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/iio/light/vl6180.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
> index 4775bd785e50..d47a4f6f4e87 100644
> --- a/drivers/iio/light/vl6180.c
> +++ b/drivers/iio/light/vl6180.c
> @@ -392,7 +392,7 @@ static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
>  {
>  	int ret, it_ms;
>  
> -	it_ms = (val2 + 500) / 1000; /* round to ms */
> +	it_ms = DIV_ROUND_CLOSEST(val2, 1000); /* round to ms */
>  	if (val != 0 || it_ms < 1 || it_ms > 512)
>  		return -EINVAL;
>  
> -- 
> 2.20.1
> 
