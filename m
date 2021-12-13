Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3B2472C3D
	for <lists+linux-iio@lfdr.de>; Mon, 13 Dec 2021 13:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhLMM0H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Dec 2021 07:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhLMM0G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Dec 2021 07:26:06 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45964C061574
        for <linux-iio@vger.kernel.org>; Mon, 13 Dec 2021 04:26:06 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id q14so14909048qtx.10
        for <linux-iio@vger.kernel.org>; Mon, 13 Dec 2021 04:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eol+4Xx1S76el2UyoYSJ5NADZzvH03ckqcu6cumzm60=;
        b=SYt52YqtJhSDxt46iMn9cBciAuEvntLIy3WOONeBGXSYdaT8lklTTC8vYhP0gIsvg0
         VbxRO2veYhrz0OMaUD4EEpxyoZY8rfqUhA8csf+dkgszzzC505I69VlaM5TDHP4C2v3F
         uFIhZGSZ6k874j6LUEdFeW/5c2Rkm7NVY17Wg7ZkJU/+K5Ppfm1pJDsIESql72UkFteL
         hO1CJXCgTEjQWAn7mT/himZaLmhx0+MXgv4jFcZzVpQJZop+xYVxavbzNCJAVWobAPGT
         VKb3U7C3mvwqbBtl7f03Zobwi9Fxr4xcF4qKAbdMgIkM/9dUbfigFtuI7q8vGjonRNWC
         94aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eol+4Xx1S76el2UyoYSJ5NADZzvH03ckqcu6cumzm60=;
        b=5CB1tX1E6bnsmYq1j0YAbJ0iXA4aX3m2rc2mF5iIQsWN/dGtBcwx0aq4fIYLmULNw4
         mbld5fBf3B7HJGXYBucCFGPdNcJERli2j3ANhloTXb7IkpQgNUKwx75hIEp1c6g+WYu7
         pIdBR8yXEr76lGyGBXfx210xFvmGLjFg3eNKdbdvohMLiUT8PecAOx5RhXDmBkFZpPEo
         ikC/4s4LtssJQdgyMJID7HR5uLt0A42kX469TVj2GK2KBzJ2lqqiw0W16ovcFopdfYNt
         PlVRM4FcM9TuG32zUuQcN+sJpoTmPBTSafFjFYPq2o2/0W5/knJpZkVAtqs8nswiQfqI
         8Fcw==
X-Gm-Message-State: AOAM532XN1yAVEURWBOJMHvt/cVwFdrgyIw6m5qJciAWuEjOueuBbANF
        ehOTfYcAn2xS8SuYokJ64qkdlXZP2BU=
X-Google-Smtp-Source: ABdhPJyl8+lqeplZhOhpVFLgib0Qa4SoM46w55iLHgrsT6INgNuBXmYto7iWkPvEN7z0ed9iWXdGRg==
X-Received: by 2002:ac8:5e46:: with SMTP id i6mr43903540qtx.7.1639398365462;
        Mon, 13 Dec 2021 04:26:05 -0800 (PST)
Received: from marsc.168.1.7 ([2804:d57:1505:900:9e70:8954:9f0b:ad76])
        by smtp.gmail.com with ESMTPSA id u10sm9347298qtx.3.2021.12.13.04.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 04:26:05 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:26:00 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 01/17] staging:iio:adc:ad7280a: Fix handing of device
 address bit reversing.
Message-ID: <Ybc72In6xsGWoz5H@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205202710.2847005-2-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The bit reversal was wrong for bits 1 and 3 of the 5 bits.
> Result is driver failure to probe if you have more than 2 daisy-chained
> devices.  Discovered via QEMU based device emulation.
> 
> Fixes tag is for when this moved from a macro to a function, but it
> was broken before that.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> Fixes: 065a7c0b1fec ("Staging: iio: adc: ad7280a.c: Fixed Macro argument reuse")
> ---
>  drivers/staging/iio/adc/ad7280a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index fef0055b8990..20183b2ea127 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -107,9 +107,9 @@
>  static unsigned int ad7280a_devaddr(unsigned int addr)
>  {
>  	return ((addr & 0x1) << 4) |
> -	       ((addr & 0x2) << 3) |
> +	       ((addr & 0x2) << 2) |
>  	       (addr & 0x4) |
> -	       ((addr & 0x8) >> 3) |
> +	       ((addr & 0x8) >> 2) |
>  	       ((addr & 0x10) >> 4);
>  }
>  
> -- 
> 2.34.1
> 
