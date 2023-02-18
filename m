Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127D069BA43
	for <lists+linux-iio@lfdr.de>; Sat, 18 Feb 2023 14:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBRNcx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Feb 2023 08:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBRNcw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2023 08:32:52 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F4F5588
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 05:32:50 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id i28so2279745eda.8
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 05:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QIEEk4KJoTaBudftvkYoc1XT4Mo1J1RHSkysR/5EjWI=;
        b=Np5X4Psle7/1uT0Z8HjaewDHbGwRVO83LrHNx968u0y5/PRfGc1c3WET59ARISXGKi
         E/aHuUUr+t3RwYnSB+mMVB5mZjkKZNuCBRL+870U1Pxg7d6BxXiHIWM8Ic54UMl5xv7u
         ULj8cU1y9VMKDjnubVrKN7yHwXduU2A9pUyuH35iuS5Wt1406SU7/9gToDc+uVCxHheU
         0ASKFG9kEWF0EK7yZYZs9Xo1rNwhWEP19xGPFZ5jnyx6NP9LEuxFuSIM3xjYGwtwK3dk
         6jv/tlNUAvuwo0C9zW/KPsWGuH+Y5V/XMMJDIjuVbG1MFrgpgcEoHWoq2sJbcCuNaZcR
         4rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIEEk4KJoTaBudftvkYoc1XT4Mo1J1RHSkysR/5EjWI=;
        b=knZL3jOZspJ+VTAG/IdqttbqdDXnLM6g/qk4lLHloxGmyS/IeFWaWNCDeNxPUNoVBO
         g3B2etM9T9LFAEDI9wBFkgGcj2DWjmtPHCRui6ESZpzPLgPM4gZ0gVQqL3EF/uIb+t/P
         EvaP0uaZm6XmZADJE8D5wb9Pa8zC5aDodjfJmx65vblahRm0apFQMN481lf1LryYcGJC
         qoSgHEyYZjTOlqnZCsLlsp9M03QnHtUJegAWcbDdko2HYpvoWgCwZDEQFkLw9Y7Z6KQS
         /IoEtcOcRBvmv8+foJ5H2miLGSRctxtzzkzBnyg/dK3l06ys1WoG4K7fFh6cZnovLVy3
         POhQ==
X-Gm-Message-State: AO0yUKUVLyrqa3+qhDWSgxc4TT9N8NjgdnE3Gl6Yaxu/JIm8sy329M5c
        xiagVFdqptpGM+PvTT46Xf4=
X-Google-Smtp-Source: AK7set+42g12QE4wN6SPwkidxqRsvVLcJo5UIBcXegbCaLWlUff/YgVTe3h5Qa1dhmpx527BUS7r8A==
X-Received: by 2002:a17:906:198f:b0:8b1:77bf:5b9f with SMTP id g15-20020a170906198f00b008b177bf5b9fmr6593908ejd.13.1676727169369;
        Sat, 18 Feb 2023 05:32:49 -0800 (PST)
Received: from carbian (dynamic-2a01-0c23-5c09-8a00-f386-7b22-bb9a-becb.c23.pool.telefonica.de. [2a01:c23:5c09:8a00:f386:7b22:bb9a:becb])
        by smtp.gmail.com with ESMTPSA id k15-20020a170906680f00b008b3c138f3b4sm1843687ejr.0.2023.02.18.05.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 05:32:48 -0800 (PST)
Date:   Sat, 18 Feb 2023 14:32:46 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/1] iio: accel: kionix-kx022a: Timestamp minor fix
Message-ID: <Y/DTfoFMkPQeZODL@carbian>
References: <cover.1676661174.git.mehdi.djait.k@gmail.com>
 <44a866e5-61ae-3373-10f5-c21efeec7f53@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44a866e5-61ae-3373-10f5-c21efeec7f53@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Matti,

On Fri, Feb 17, 2023 at 10:04:30PM +0200, Matti Vaittinen wrote:
> Thanks again Mehdi. It's great to have this fixed :)
> 
> On 2/17/23 21:19, Mehdi Djait wrote:
> > As discussed in [1] here is a patch to get the timestamp in the
> > trigger handler from the driver's private data
> > 
> > [1] https://lore.kernel.org/linux-iio/Y+%2FLpcc0Wa2VGsGO@carbian/T/#mec923c14d1324ffabfa88dde225eeb227005b48f
> > 
> 
> By the way, I don't think a cover-letter is required for single patches. You
> can usually put the relevant information in the commit message.
> Additionally, if there is some questions, suggestions or other relevant bits
> you wish to say - but don't want to include in commit logs - you can usually
> place them in the patch mail directly after the first
> "---"
> 
> Eg:
> 
> <commit message>
> <Signed-off-by and other tags>
> 
> ---
> 
> Here we can add a note / request if required.
> 

Yes, that's why I sent a cover-letter, I wanted to include relevant bits
but not in the commit message (a reference to the discussion). 

I should have sent the patch --in-reply-to the thread with the discussion 
anyway. 

Thank you for the help :) 

--
Kind Regards
Mehdi Djait
