Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D6C25D751
	for <lists+linux-iio@lfdr.de>; Fri,  4 Sep 2020 13:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgIDLaT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Sep 2020 07:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730179AbgIDLZ6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Sep 2020 07:25:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B74C061251
        for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2020 04:14:12 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 2so3034068pjx.5
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2020 04:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y4D5QqTSbmVc6Z1rVkpfPCOl/RfvgQ90k2+QfztdFL4=;
        b=wwKqZv7n64y+bz4qrAYwYIFyWmfpKyZ+ZSRmT7qg6WRa5nhTimv7yBBNky31B0T1n+
         D+rvIOXleKJB2z26EFzwyxH+mk4be2ViJoIYeX7PWg6+0PEQ+C+l4TklZfUZ9It+cdM1
         y5FDUgsqghgQAQc4I9ilo9Z87woY2ugqE2osVq2HHpj/3VqKzIN2WuRvmDwDJ+72O7de
         NzXtZzsddxKlhsR8V83nSXldAN63nCQ82LojTP4QGAY+EOGAJk5MIHUqVvRI5v+1k0di
         QN9svkXgB4cRbjU9ZAil57PUdzHZ9CpY8QVcWC/y4L9XFG+4+LE3mOlNMVTRZsSmOqbT
         WOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y4D5QqTSbmVc6Z1rVkpfPCOl/RfvgQ90k2+QfztdFL4=;
        b=BSSTCcagWYqwLkiO0EGcpIIcwoQz+USkUKdFZJEuF15iSHncSJffzzN98Ef4F/w1gR
         cWvIPHmx1rXoT20bIVweAc0hID96Z1xvVxmPUjwLKQ/1bTjC3wZtKWl5MlmzLef44Q0s
         zJigmh8UIpH9Ej+mAqPxDiNcVDmHDA+4C9hubIwKPEioh7qV2RjPsUZfg7UuFY/UBZnp
         BTgVspQ8QWx8h93vlK8TG8g4+iIPuvz2v0jkJj4GSOe9nwGOqyWDfcTfSQWopkqJs9l9
         Ey1hN0bZowXGZObXPhneP00u0HV9Klan3IKeJtTgFCd8BzhC57JVxsS40hve1DZPz9r9
         HAUg==
X-Gm-Message-State: AOAM532ZD0ZMGhzWfJtuazb28glVwOTJusK4eZC7wMXemZMKT273PEbE
        E0eID+2tJeB6qa2KmD1HchGD
X-Google-Smtp-Source: ABdhPJwwQO9ZxO0/SNtTrps/GYoiHfp/tCzVWaEff7uxDvKLINgm0WMDTYotC/fwPXBTR7vFyJxcbw==
X-Received: by 2002:a17:90a:bd0e:: with SMTP id y14mr7662871pjr.13.1599218051178;
        Fri, 04 Sep 2020 04:14:11 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id s23sm5018691pjr.7.2020.09.04.04.14.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Sep 2020 04:14:10 -0700 (PDT)
Date:   Fri, 4 Sep 2020 16:44:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/9] iio: adc: qcom-spmi-adc5: fix driver name
Message-ID: <20200904111402.GC4056@mani>
References: <20200903132109.1914011-1-dmitry.baryshkov@linaro.org>
 <20200903132109.1914011-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903132109.1914011-6-dmitry.baryshkov@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 0903, Dmitry Baryshkov wrote:
> Remove superfluous '.c' from qcom-spmi-adc5 device driver name.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Please add Fixes tag, with that:

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 30b8867b31e4..c2da8f068b87 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -919,7 +919,7 @@ static int adc5_probe(struct platform_device *pdev)
>  
>  static struct platform_driver adc5_driver = {
>  	.driver = {
> -		.name = "qcom-spmi-adc5.c",
> +		.name = "qcom-spmi-adc5",
>  		.of_match_table = adc5_match_table,
>  	},
>  	.probe = adc5_probe,
> -- 
> 2.28.0
> 
