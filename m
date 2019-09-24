Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3946CBC6FA
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2019 13:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440851AbfIXLhZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Sep 2019 07:37:25 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35383 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440850AbfIXLhZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2019 07:37:25 -0400
Received: by mail-yw1-f68.google.com with SMTP id r134so497156ywg.2
        for <linux-iio@vger.kernel.org>; Tue, 24 Sep 2019 04:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZHlZAXK7eZx5wWnEPuXovMHqlX93BCRBrh3lhHBhxPo=;
        b=cngVRG+3XYq5KGbU9xySLUsMFIhq4/if2CrACJaS9tjF4UTyKoq+KVCge8T5WSy1AZ
         k6x/LQhTYwoHEsRDOGlX/Tu6ybuyIAQxVR9xN1M2XvFjzEHq8ze+9Pb9/gA2J9x51s9e
         vqWJihYqhRLZ8FYfPFB7sahop4v/5wcZyHF7kCa6UwQ8g+/tJlDrHMVW2nYcIBHa4zGe
         oVn1nIQgGY20HV+5ENAmFVq34lR/skT0ovNZft+CjHFzv/AcxPkt80Yh7UeuHZQ2d/TA
         0k+I0jhqBWFOHAfsSS3KPOxvwutOYDkODcdC1zcJyCcOAua2MUVc6GX+95FhcaGEFPSa
         xJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZHlZAXK7eZx5wWnEPuXovMHqlX93BCRBrh3lhHBhxPo=;
        b=i0PziktIb7OAx820s9du2KYcyFK7bbzloUX64OX+i+BM5Rdqzj14lcnF1aix/MrC9+
         5a2pCf2b4xDo344EBv140tQ8Xl+33hLI/hcweSAXi0pnUDPMNxxs9d+JUVq9Zz91x7pC
         bcqeumiba4zzncvIlxtzWKvPyMZNpCLjzVBY1RCuyYYBGFtKs8AMabo9644FfIgGNnO5
         ilhd1vtoSCrdwleRbqlWcn5INqHgWtZC2eQoj51k/EzkMNek/4mWs6YXAOTjYAGeErLv
         3UoklXVuhRTO9xhTX/UeacrLxc3G2m+d2rdSDq114c8/cglAzGctcLBDALfwBG/Cso9a
         C/QQ==
X-Gm-Message-State: APjAAAX9YLf3ud0bkkhrhb78ZE/eFmI/A8aj8Msi6rh+2YbO3b7dFVsZ
        8kkzvtcLiIze/NDtATixYE8=
X-Google-Smtp-Source: APXvYqxW3Ed99A5Y0VODTxzcQ/PFU43E+TKb97JaWGNsGlsdjVYBRJ29LaTdIgl0HEfGM/lhXXkNzA==
X-Received: by 2002:a0d:e482:: with SMTP id n124mr1523969ywe.205.1569325044267;
        Tue, 24 Sep 2019 04:37:24 -0700 (PDT)
Received: from icarus (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id e130sm378586ywh.50.2019.09.24.04.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 04:37:23 -0700 (PDT)
Date:   Tue, 24 Sep 2019 20:37:09 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] counter: add support for Quadrature x4 with
 swapped inputs
Message-ID: <20190924113709.GA3014@icarus>
References: <20190917114403.GA8368@icarus>
 <20190919080305.960198-1-felipe.balbi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190919080305.960198-1-felipe.balbi@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 19, 2019 at 11:03:04AM +0300, Felipe Balbi wrote:
> Some Quadrature Encoders can swap phase inputs A and B
> internally. This new function will allow drivers to configure input
> swap mode.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> ---
>  drivers/counter/counter.c | 3 ++-
>  include/linux/counter.h   | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
> index 106bc7180cd8..b818ae9e85f2 100644
> --- a/drivers/counter/counter.c
> +++ b/drivers/counter/counter.c
> @@ -823,7 +823,8 @@ static const char *const counter_count_function_str[] = {
>  	[COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B] = "quadrature x1 b",
>  	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A] = "quadrature x2 a",
>  	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B] = "quadrature x2 b",
> -	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4] = "quadrature x4"
> +	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4] = "quadrature x4",
> +	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4_SWAPPED] = "quadrature x4 swapped"
>  };
>  
>  static ssize_t counter_function_show(struct device *dev,
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index a061cdcdef7c..860769250f89 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -170,7 +170,8 @@ enum counter_count_function {
>  	COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B,
>  	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
>  	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
> -	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
> +	COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> +	COUNTER_COUNT_FUNCTION_QUADRATURE_X4_SWAPPED,
>  };
>  
>  /**
> -- 
> 2.23.0

Add in an additional patch to update the documentation files to list
this new mode.

Thanks,

William Breathitt Gray
