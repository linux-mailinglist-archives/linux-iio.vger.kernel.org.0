Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910964FB0B0
	for <lists+linux-iio@lfdr.de>; Mon, 11 Apr 2022 00:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiDJWkN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Apr 2022 18:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiDJWkM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2022 18:40:12 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5782D1BE94
        for <linux-iio@vger.kernel.org>; Sun, 10 Apr 2022 15:37:58 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-df22f50e0cso15419138fac.3
        for <linux-iio@vger.kernel.org>; Sun, 10 Apr 2022 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kYdCeqNxfyFe+q4mlbB31hoROe3b0F3S6Np/YpvuNb8=;
        b=BqrGf/v5BHYFjpkXECcMb/aua8b1UnWtW23b/1W0EA5MUf8v7RKe1se2NFwTD/XW2K
         mgQ33wAlIkxH29GrVwR8CfNm5xSHvwV1stTVkXISCwKYN64wFR8bx3YeFpat90Wds7dR
         7+baJTVQ0vHack8beaFphpHbWjihjWVKhNito697yP6sX9NMUvAbamXjihzWcYG23vc9
         uteaVNIPinVAz+BZCmNdgcq9K2darXOV3SzZ9dd7hWLDqh8ZRBy/8krXk2/b6UqPWQ5l
         CiJi9OyDawl+DljQD4W341fH48kwZgMp8stYTFqqeEC9odced/nmQVp2qB8XZW0OxT9S
         gtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kYdCeqNxfyFe+q4mlbB31hoROe3b0F3S6Np/YpvuNb8=;
        b=BB+kIb8gucWD24cNuSTdJQccScH8cPNUXYWoraHoI5Bbsv0rMjj/mnHK41g6GMB/td
         ya4kpDbBJarKc71iiV4gw4Xslwu3CFtM5gEC83eGO8aOAcCZJVXOnnDwAicwKqbjoq9M
         vfI3aHLOtecE/AxvQgDrXJCFzMl1EjkUI9m5PheDh1wA1cfN5xoGsiya2yQFuRKcXKxu
         ztDlJNweneUpL7df2CtJwxc/TV3f7//dLr1gPLsO3UuLyUAm74w5pGb7VwebjHTxQBMv
         UYEwt+Xr7l/OIK5pQnRMzXCPGQfXyB/w0dnG1nNTjKzihAxhfvLc193JDcRvQ0mrKMAg
         ov3A==
X-Gm-Message-State: AOAM532wYKoh0Z1AuA1J9mNIly5i/68qrPOMXAhbiBAe6OCKZAG9SGj7
        6d3TNvGrbMzEq8Q5J5KExPfWGyEu0E009w==
X-Google-Smtp-Source: ABdhPJyuZDh1aX3sEOiFjNaGHzGWv2r3iYVy+Ip51t9hYzl9qcs2WmdzvTAmb34O6M5P/YCSBqok/A==
X-Received: by 2002:a05:6870:4341:b0:da:b3f:2b26 with SMTP id x1-20020a056870434100b000da0b3f2b26mr13173497oah.197.1649630277638;
        Sun, 10 Apr 2022 15:37:57 -0700 (PDT)
Received: from fedora ([187.64.132.161])
        by smtp.gmail.com with ESMTPSA id w8-20020aca3008000000b002ef7e3ad3b8sm10678165oiw.29.2022.04.10.15.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 15:37:57 -0700 (PDT)
Date:   Sun, 10 Apr 2022 19:37:52 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, dragos.bogdan@analog.com
Subject: Re: GSoC Proposal 2022
Message-ID: <YlNcQEAZVGYBkdy5@fedora>
References: <CAH7FV3=UJn98PRp1dke7iAH2j8pj4-VSbnb11OfzRUKmkAEL8Q@mail.gmail.com>
 <20220410182819.23967855@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220410182819.23967855@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/10, Jonathan Cameron wrote:
> On Thu, 7 Apr 2022 00:23:29 -0300
> Maíra Canal <maira.canal@usp.br> wrote:
> 
> > Hi everyone, I am Maíra Canal an undergrad student at the University
> > of São Paulo, Brazil, pursuing
> > computer engineering. I wish to participate in the GSoC 2021 as a part
> > of the Linux Foundation, IIO Project.
> 
> Hi Maíra,
> 
> Nice to 'meet' you ;)
> 
> > 
> > I have been contributing to the Linux kernel for a couple of months
> > and have more than 20
> > accepted patches in a couple of subsystems.
> > 
> > I started looking through the catalog of Analog Devices Inc. and I'm
> > pretty interested in writing a driver for gyroscopes, inertial
> > measurement units (IMUs), magnetometers, pressure sensors, proximity
> > sensors, or temperature sensors. But, while looking through the
> > catalog, I could not figure out a sensor that would be relevant to
> > Linux Kernel. I mean, I would like to work on a sensor that would be
> > relevant to the community and to Analog Devices Inc.
> > 
> > In that sense, I would like to know if anyone in the IIO community
> > could recommend a sensor that would make sense for the company and the
> > IIO community. Any suggestion is appreciated!
> 
> I'm not going to recommend a particular sensor, but more offer some general
> tips on what 'sort' of device makes a good target for a GSOC.
> Finding a sensor means trawling datasheets and I'm tight on time today
> + I've no real insight into what the ADI folk might like to see
> supported!
> 
> The nature of a GSOC driver submission is often a little different to
> how an experienced driver author might go about things, simply because you
> will / should be looking for feedback at more stages of development and
> hopefully to upstream things in multiple stages.  An old hand at IIO
> drivers will often just jump directly to a driver supporting all the
> features they wish to target.  As such, the 'perfect' device to target
> should meet a few requirements that may not be true for the approach of jumping
> straight to the end goal.  Note this is equally true for other people
> starting out writing drivers - though they can often do very simple
> devices first and that is not a good plan for a GSOC project where
> you need to have a progression during the project.
> 
> Try to find something that offers some advanced features to provide
> stretch goals but make sure the basic functionality will work with
> a much simpler driver. So devices that provide straight forward
> registers to access the latest channel value are great, whereas
> those that only offer a streaming interfaces / fifo may be less suitable.
> However if they offer both that is perfect as the fifo make a good
> later feature for a GSOC project if things are going particularly
> well!  For a real stretch goal, find a device with features that
> we don't support at all today (perhaps new sensor types, or some
> other new feature) as they'll give you the experience of defining
> new ABI + possibly modifying the IIO core to meet some requirements.
> 
> Another thing to look at it is whether the part is sufficiently
> different from those supported by existing drivers to justify a
> separate driver. If not, you may find your GSOC project becomes
> simply adding an ID! (then rapidly choosing a second device to
> work on).
> 
> Hope that provides a few hints on what to look at.  Probably the best
> way around is to suggest one or more parts you think look interesting
> then we can give feedback on whether we think they'd be a good choice
> or not.

Hi Jonathan,

I really appreciate the answer. Thank you for your attention and time!

During the week, I ended up picking the ADXL375 accelerometer (although I am
open to any change proposed by ADI or the IIO community). Based on that device,
I wrote a proposal and I would appreciate if you provide some feedback on the
device choice and proposal: https://pt.overleaf.com/read/xsmmdpvzqrhd.

Regards,
Maíra

> 
> Good luck!
> 
> Jonathan
> 
> 
> 
> > 
> > Sincerely,
> > Maíra Canal
> 
