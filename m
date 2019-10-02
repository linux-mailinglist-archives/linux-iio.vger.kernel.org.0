Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77CD2C8E80
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 18:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfJBQhZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 12:37:25 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34644 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfJBQhZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2019 12:37:25 -0400
Received: by mail-yb1-f193.google.com with SMTP id m1so929378ybm.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Oct 2019 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oH9oj3/UqyPOEjpuYbes2FbhL0hGWedPuNlswv/7zBE=;
        b=KMDbqWypEnuNCmOycgaDBbUbOKypZegy45mycRmYGLHmsAv8kpWCjLh0ub2XR9BH3v
         8Fjbow94s8lrJqnZ/g2maVieh8XdqE2CWwBr7SIPL1RB9Rlh0/YCTqs4IxCVf+mYxK+6
         Nv1y+UrMhMl+4quRDRpZPEVTWGUcu1/H7VLBmzec8iXbxXSC/+Xme1BLjlSVU5qLpeHm
         giNsfTe+XHosqVTwZ0waN0BUcXBbfPs/6ejCKckE23PATkx3zhTzmt2gPyTrjzolZZ9I
         cFJoeZZkx3CssTs2lQVYb8CoK4Nmmx1xe3pOxSB21UUYcQbdS6aAm8o42mBC09gIsFia
         lwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oH9oj3/UqyPOEjpuYbes2FbhL0hGWedPuNlswv/7zBE=;
        b=GpED9swTbEwZL9tjArtOOVUJR/F3oFv4f3v1fnCqq8xw4Rrm8a0bDnJW7Wk+LxO0xU
         vN75wauXAxBl4T/AUP9rc4Au6fASjCBtD9bMV4rPJLcVqCoaUM/xZ8PQTjesYZsw8AAB
         ASIqeUUxJLY0tWa2k+NCY7uGXq6VIfRiLCZOnMuUOOuyCUqrqltp6FdRIuNMrUx9j7T4
         0Nbu5rEYFiQ4DCEVAMyG9PGEQ9H0uQc6/CWegDvpJfYdH9l3joQ4EylnnUlmjhaNRWkt
         K7GWjdg/HW582EZqcAG6QSuthIzGc8WL8BsgQMAWSqhkPE2NWQQJWRhQcWW0A2qUI4QK
         atlg==
X-Gm-Message-State: APjAAAXeF1ohPfJFsPzicLaw206u32N4rSZ0eW5QlVbQ6IMiINx9CPR5
        a9eDHIamm9GNm2e8ZFJBiAA=
X-Google-Smtp-Source: APXvYqzDj9C0AIPUIqxnoHoG3e/AMfEkPjboj429/OtU2doP44MfNdYsarPtDbCcye6URWk4zZ5Ixw==
X-Received: by 2002:a5b:5c2:: with SMTP id w2mr2980939ybp.289.1570034244494;
        Wed, 02 Oct 2019 09:37:24 -0700 (PDT)
Received: from icarus (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id f127sm4028468ywe.89.2019.10.02.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 09:37:23 -0700 (PDT)
Date:   Wed, 2 Oct 2019 12:37:08 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] counter: add support for Quadrature x4 with
 swapped inputs
Message-ID: <20191002163708.GA100041@icarus>
References: <87o8zax6ya.fsf@gmail.com>
 <20191001093237.775608-1-felipe.balbi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191001093237.775608-1-felipe.balbi@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 01, 2019 at 12:32:36PM +0300, Felipe Balbi wrote:
> Some Quadrature Encoders can swap phase inputs A and B
> internally. This new function will allow drivers to configure input
> swap mode.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-counter | 4 ++++
>  drivers/counter/counter.c                   | 3 ++-
>  include/linux/counter.h                     | 3 ++-
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
> index 566bd99fe0a5..8f1e3de88c77 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -146,6 +146,10 @@ Description:
>  			updates	the respective count. Quadrature encoding
>  			determines the direction.
>  
> +		quadrature x4 swapped:
> +			Same as quadrature x4, however Phase A and Phase B
> +			signals are swapped.
> +
>  What:		/sys/bus/counter/devices/counterX/countY/name
>  KernelVersion:	5.2
>  Contact:	linux-iio@vger.kernel.org

Thank you for adding an entry for this in the Counter sysfs interface
documentation file. Make a similar addition to the Counter driver API
documentation in the Documentation/driver-api/generic-counter.rst file.

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

Add a comma to the end of this line so that we don't have to change it
if we add another function mode in the future.

William Breathitt Gray

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
> 
