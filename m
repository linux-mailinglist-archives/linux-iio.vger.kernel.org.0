Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D996061F4AA
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 14:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiKGNzP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Nov 2022 08:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiKGNzN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 08:55:13 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80321CFF7;
        Mon,  7 Nov 2022 05:55:12 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y16so16274767wrt.12;
        Mon, 07 Nov 2022 05:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3LAmMy16ngwzae4fSDH7FFtFnYTg6fQW31PoCf+xM+8=;
        b=c+Lke68wfeJaKpFboAM7nyYzkOkqjt1+5fFU+2sf/HAIZjLM++4jxwM1kloBMCdZUW
         I8N3en2IJ6rLJFbLYCRo8LXISPUjdMgXJuhM3levbiu8bQEarwnkZlTybFkQ3Pc4R186
         ZQUfZbf/zImk90wOA76MrclPHzKrQMvCGc3XemxknZPWTo6+naVSaW/iPAwZQMMaWQ2E
         khOePrq7DYz/+p9K0jhKneR7Dt5U5HGqBwOhcU1rm0wXfjlyD3k33FaiT1PSOmeOj2df
         979tjgXM3tluDLCvuU2SdWMVZuEc0bSHfQda7pNp8snqyVKeBacTf2mvmy2kAhV6Kl37
         NcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LAmMy16ngwzae4fSDH7FFtFnYTg6fQW31PoCf+xM+8=;
        b=LtaUTJ3NTTX2OkdkrS3cLY/duCiW74dmLrrM1rXaTcQn/KXp4wOCasbEl7uSAUvjPQ
         qzhuF/EEyGL5QvaYz6Ri3uToCOib6PNgMEGd93KCD4a+m6RqSVhMZ/dBpSZeZ1ic6HYr
         jLdV0fPBvJhEqgvg3YD+dTU7Y86twXGTcMfWF21DV4iabJINQD9xBmpEQ4Ci/kWnNs51
         It90DucQcrsWTlWakjeKUPBsWtyz9lAPYTCfyYR5jG4tgCNz6GuDz/8mMgZ3eID74DbP
         vrJf7B4hUk91c7v08AmloIMPFSw0Tae+DSzBN5AasgdX3Up+r6ho/ryN3CeEgnysjl4g
         +h5g==
X-Gm-Message-State: ACrzQf0RDtKJTEv6t5oNPSLwBcCx8x8RLQb+nzKMsXDvFWxK3XYhHcYI
        7ZgspuykoERFMStHFLGOevE=
X-Google-Smtp-Source: AMsMyM5qRiAMgBiXBgMncnurl3tPb4Iy7u6LCDEH80MFwa5vh+cDz7eYpEgB++2SNRsP5MHu6jrPag==
X-Received: by 2002:a5d:648b:0:b0:236:6ff3:43c3 with SMTP id o11-20020a5d648b000000b002366ff343c3mr31624955wri.287.1667829311285;
        Mon, 07 Nov 2022 05:55:11 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c199400b003cf9bf5208esm10077387wmq.19.2022.11.07.05.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 05:55:10 -0800 (PST)
Date:   Mon, 7 Nov 2022 16:55:07 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andrea Merello <andrea.merello@iit.it>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bno055: uninitialized variable bug in
 bno055_trigger_handler()
Message-ID: <Y2kOOxSc60IBuzhk@kadam>
References: <Y0kuaO9PQkSQja+A@kili>
 <20221015173359.20c7928e@jic23-huawei>
 <20221029163956.2a70dc94@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029163956.2a70dc94@jic23-huawei>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 29, 2022 at 04:39:56PM +0100, Jonathan Cameron wrote:
> On Sat, 15 Oct 2022 17:33:59 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Fri, 14 Oct 2022 12:39:52 +0300
> > Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > 
> > > This bug is basically harmless, although it will trigger a runtime warning
> > > if you use KMSan.  On the first iteration through the loop, the
> > > "best_delta" variable is uninitialized so re-order the condition to
> > > prevent reading uninitialized memory.
> > > 
> > > Fixes: 4aefe1c2bd0c ("iio: imu: add Bosch Sensortec BNO055 core driver")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>  
> > 
> > You reported this a while back along with a second issue (false positive)
> > with hwval.
> > 
> > I posted a patch fixing both 
> > https://lore.kernel.org/linux-iio/20221002145324.3776484-1-jic23@kernel.org/
> > 
> > I don't really care which patch goes in, but curious to reasoning to not also
> > deal with the hwval warning here?
> > 
> Meh. Rather than not applying either patch, I'll pick this one up.  We can
> deal with the hwval warning at a later date if necessary.
> 

Sorry, I am behind in my email.

There was a couple weeks in between sending the bug report and the patch
so I forgot about it.  Also I send those bug reports from a different
system so I don't check that as part of the QC process.  I'm moving to
checking vger instead of grepping my outbox but I haven't automated that
yet.

I don't get a "hwval" warning on my system so using the cross function
DB must have silenced the false positive.

regards,
dan carpenter

