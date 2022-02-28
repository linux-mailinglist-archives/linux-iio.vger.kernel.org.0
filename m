Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39814C6E82
	for <lists+linux-iio@lfdr.de>; Mon, 28 Feb 2022 14:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiB1Nsl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Feb 2022 08:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbiB1Nsl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Feb 2022 08:48:41 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E292E2B25B
        for <linux-iio@vger.kernel.org>; Mon, 28 Feb 2022 05:48:00 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id p4so2579776edi.1
        for <linux-iio@vger.kernel.org>; Mon, 28 Feb 2022 05:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HdkEUFY+6UfFXOyfNmMiuhytB0EgkxuNOzDU4nXE2As=;
        b=Acg8Qf3y5cj/j0AXI7nHEvdR0Bm8z150UfhknvW1nlWYlhlpHlnUzc4Y5lZ2tmXWlf
         ZQfuKuLoCJDiUdqvkCImR8sOQrrcE2wODLmxHoqiFcXZbjFphCLLXSNbnZ29VD1OIB2w
         EvsJK2dTUmrsVXzzfrV68V4J5uV5oYOpDWOFRYRScZk5wvy+j2lpP6+El2GvToHcva8I
         N0J2bzfk95tGbdMMGta+knZjPdQFvbgR6tsIOWb/0Fnn3Jc1t09qSONkafikbyQCQaqy
         wL3bHluQBMst0K2JUy7bwe0Bkcj8gAjnC+uQZzaR5tTZBMcUTewrIoSm2ut61P1IisQq
         x6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HdkEUFY+6UfFXOyfNmMiuhytB0EgkxuNOzDU4nXE2As=;
        b=e2V6h0Rcu2ADvaPm0FklgYrp36WvdDiWrOhwEjI7/Ld42XF3rzPbPSc0OWMmF0Ihh/
         PbmPm6bOcIPbwGkHEwdcvPLBRP1YCsdzxbFcwOVqqeVqKJDuLRLD+oUEysDMpvODdpZD
         mT862N4LWxOA2Z5BL+Uv0WVM4jJVGRQZAmhJzvp2ZIWgjCLVO4igkCqQUUHav+8Ga8lZ
         u4LydpZdyIne9z0XSxLByICAPpuZF/kh7O5vPenJSct9t47NiKJvEm49PxgIYHNTGjQ2
         MGhvefmdsP2aknr0P2ZJkPhkyNHPjGyirOetYeJz0NL5tjtNFC9XNzkOkQyiMOYsXJeo
         oRdw==
X-Gm-Message-State: AOAM531sP3bF61aKrMTcJhYNGfdBQZ3L0Z43pA0TOTDX0iX+8Lkq3CMZ
        51DttNVRfDiI0xMoTJvBhB0=
X-Google-Smtp-Source: ABdhPJwLGiy5E/JtucD1WGwt4zpeXGK/kWOy0mhP/9P/pa5BBgwPdDP4XzW7BCFPZ1G9HYBAlThx/w==
X-Received: by 2002:aa7:dc0b:0:b0:413:ce06:898e with SMTP id b11-20020aa7dc0b000000b00413ce06898emr2292536edu.244.1646056079357;
        Mon, 28 Feb 2022 05:47:59 -0800 (PST)
Received: from tp440p.steeds.sam ([69.63.69.90])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090606c200b006a728f4a9bcsm4428640ejb.148.2022.02.28.05.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:47:56 -0800 (PST)
Date:   Mon, 28 Feb 2022 15:47:50 +0200
From:   Sicelo <absicsz@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] iio: accel: add support for LIS302DL variant
Message-ID: <YhzShujezFCu71rp@tp440p.steeds.sam>
References: <Yhv8+py8uAj2j6FX@tp440p.steeds.sam>
 <20220228102021.00001de1@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228102021.00001de1@Huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan

Thank you very much for your review.

On Mon, Feb 28, 2022 at 10:20:21AM +0000, Jonathan Cameron wrote:
> >  	LIS2HH12,
> >  	ST_ACCEL_MAX,
> 
> Think about what ST_ACCEL_MAX is for...
> 
> You'll want to be above that.

I missed this. Thanks for pointing out. I'll prepare a v2.

> However, more interestingly nothing actually uses this enum, so
> you could post a precursor patch that gets rid of it entirely.

Indeed. I noticed this, but thought it had been added for some reason,
or future use. If you agree that removal makes sense, I'll submit that
too.

Also, I have also learned that I should have sent the patch for the
dt_bindings [1] as 1/2 instead of 2/2 as I did. Sincere apologies.

[1] https://lore.kernel.org/linux-iio/Yhv9M%2FaXptQSKQju@tp440p.steeds.sam/T/#u

Regards
Sicelo
