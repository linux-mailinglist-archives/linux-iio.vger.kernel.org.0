Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAF64FBCD8
	for <lists+linux-iio@lfdr.de>; Mon, 11 Apr 2022 15:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiDKNPt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Apr 2022 09:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiDKNPq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Apr 2022 09:15:46 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60FC377EA
        for <linux-iio@vger.kernel.org>; Mon, 11 Apr 2022 06:13:29 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id e4so15836139oif.2
        for <linux-iio@vger.kernel.org>; Mon, 11 Apr 2022 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JDW1B6BLoAmhv+DCTKe1MHW7al06U5nxNQoOxLG6DlU=;
        b=oMEeDsDN3hgAPBC8MoAfDLZzQuRHvneegwPtHzpSKNqIO2rlGu11qNozncc+Vfc8ZW
         ezKj25ctYZ7jQWBItc/PBzrXZL2iPtWLgzUUMjPJ90+HwLkPJcyB6/szyZL/yaNrX3GM
         6Qoigl6RCbFj++PB02rMaP2xdrkZu9oWAJ+x/tbCss8zC8E/MUXqhhhIyrj/Rma3jmpJ
         ZppayrGZf1cjrJI8Tf7ZpAmZTj4rBpFWebo1ASlKPfGLQpGlmSJEljyCPGqK6UL8/1E8
         yEauakTtA0v0UtUxBF9CPp8017bFEkbrDwy9f8dXt+jbnCaquzGl5EV21Ao6+OYkHjxe
         Mkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JDW1B6BLoAmhv+DCTKe1MHW7al06U5nxNQoOxLG6DlU=;
        b=Ha5v/CVkolIVJ4+sdJNeD3ODfu7xjrf3BPvLOml7uUxzqaPFXEWwfgM7C4G9yeN9xU
         18VvzU5TpxBPgJdbBnHzAX1HwjpzVpK3rDQ8Qppiaa+s0bsiojLZf04Ve0nkSify0zIj
         h3zkqx47aH+EvuqA47ZcrjVJ66SORQCcLVSzjSgBqkdDRJJYgTlOgHDLdoNWmFyQSH5/
         2WB2iWdU8wOmWavyslgBMOfhatfciN6H/QRRyQ8CZC8ZGF/NlQBQmxjGQ9e3AtL1orlg
         Jq+PKVKCkAst6ecNvwqfvM4r4uqM3XoQgJDg4Ssfkuwq8CF62dA4Tkmb1ZBFPyzPk4oa
         nsbg==
X-Gm-Message-State: AOAM533phMIK7xbiNdAmJvfJn8KuVa3RrEcLm6UN2OLpWLyoIuLKZEPp
        MNBtu6Nj2k8CnGQ+Z2MoQT8rqg==
X-Google-Smtp-Source: ABdhPJwolQWTKuYMWuAsuGXzjaMa0PHkWunhrqjTct6a/cITRfjzA6gU95LRx/dKipd1Fw/0BW7XsQ==
X-Received: by 2002:a05:6808:1596:b0:2f7:5d89:eec7 with SMTP id t22-20020a056808159600b002f75d89eec7mr5043315oiw.228.1649682808530;
        Mon, 11 Apr 2022 06:13:28 -0700 (PDT)
Received: from fedora ([187.64.132.161])
        by smtp.gmail.com with ESMTPSA id 123-20020a4a0181000000b00324a1217e96sm11644844oor.35.2022.04.11.06.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 06:13:27 -0700 (PDT)
Date:   Mon, 11 Apr 2022 10:13:21 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        dragos.bogdan@analog.com, ciprian.hegbeli@analog.com,
        cosmin.tanislav@analog.com, puranjay12@gmail.com
Subject: Re: GSoC Proposal 2022
Message-ID: <YlQpcZvwZuabMsz+@fedora>
References: <CAH7FV3=UJn98PRp1dke7iAH2j8pj4-VSbnb11OfzRUKmkAEL8Q@mail.gmail.com>
 <20220410182819.23967855@jic23-huawei>
 <YlNcQEAZVGYBkdy5@fedora>
 <20220411095219.000058a8@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411095219.000058a8@Huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/11, Jonathan Cameron wrote:
> On Sun, 10 Apr 2022 19:37:52 -0300
> Maíra Canal <maira.canal@usp.br> wrote:
> 
> > On 04/10, Jonathan Cameron wrote:
> > > On Thu, 7 Apr 2022 00:23:29 -0300
> > > Maíra Canal <maira.canal@usp.br> wrote:
> > >   
> > > > Hi everyone, I am Maíra Canal an undergrad student at the University
> > > > of São Paulo, Brazil, pursuing
> > > > computer engineering. I wish to participate in the GSoC 2021 as a part
> > > > of the Linux Foundation, IIO Project.  
> > > 
> > > Hi Maíra,
> > > 
> > > Nice to 'meet' you ;)
> > >   
> > > > 
> > > > I have been contributing to the Linux kernel for a couple of months
> > > > and have more than 20
> > > > accepted patches in a couple of subsystems.
> > > > 
> > > > I started looking through the catalog of Analog Devices Inc. and I'm
> > > > pretty interested in writing a driver for gyroscopes, inertial
> > > > measurement units (IMUs), magnetometers, pressure sensors, proximity
> > > > sensors, or temperature sensors. But, while looking through the
> > > > catalog, I could not figure out a sensor that would be relevant to
> > > > Linux Kernel. I mean, I would like to work on a sensor that would be
> > > > relevant to the community and to Analog Devices Inc.
> > > > 
> > > > In that sense, I would like to know if anyone in the IIO community
> > > > could recommend a sensor that would make sense for the company and the
> > > > IIO community. Any suggestion is appreciated!  
> > > 
> > > I'm not going to recommend a particular sensor, but more offer some general
> > > tips on what 'sort' of device makes a good target for a GSOC.
> > > Finding a sensor means trawling datasheets and I'm tight on time today
> > > + I've no real insight into what the ADI folk might like to see
> > > supported!
> > > 
> > > The nature of a GSOC driver submission is often a little different to
> > > how an experienced driver author might go about things, simply because you
> > > will / should be looking for feedback at more stages of development and
> > > hopefully to upstream things in multiple stages.  An old hand at IIO
> > > drivers will often just jump directly to a driver supporting all the
> > > features they wish to target.  As such, the 'perfect' device to target
> > > should meet a few requirements that may not be true for the approach of jumping
> > > straight to the end goal.  Note this is equally true for other people
> > > starting out writing drivers - though they can often do very simple
> > > devices first and that is not a good plan for a GSOC project where
> > > you need to have a progression during the project.
> > > 
> > > Try to find something that offers some advanced features to provide
> > > stretch goals but make sure the basic functionality will work with
> > > a much simpler driver. So devices that provide straight forward
> > > registers to access the latest channel value are great, whereas
> > > those that only offer a streaming interfaces / fifo may be less suitable.
> > > However if they offer both that is perfect as the fifo make a good
> > > later feature for a GSOC project if things are going particularly
> > > well!  For a real stretch goal, find a device with features that
> > > we don't support at all today (perhaps new sensor types, or some
> > > other new feature) as they'll give you the experience of defining
> > > new ABI + possibly modifying the IIO core to meet some requirements.
> > > 
> > > Another thing to look at it is whether the part is sufficiently
> > > different from those supported by existing drivers to justify a
> > > separate driver. If not, you may find your GSOC project becomes
> > > simply adding an ID! (then rapidly choosing a second device to
> > > work on).
> > > 
> > > Hope that provides a few hints on what to look at.  Probably the best
> > > way around is to suggest one or more parts you think look interesting
> > > then we can give feedback on whether we think they'd be a good choice
> > > or not.  
> > 
> > Hi Jonathan,
> > 
> > I really appreciate the answer. Thank you for your attention and time!
> > 
> > During the week, I ended up picking the ADXL375 accelerometer (although I am
> > open to any change proposed by ADI or the IIO community). Based on that device,
> > I wrote a proposal and I would appreciate if you provide some feedback on the
> > device choice and proposal: https://pt.overleaf.com/read/xsmmdpvzqrhd.
> 
> Unfortunately that part hits the second to last paragraph above.
> 
> It's so nearly compatible with the ADXL345 that the driver already supports it:
> https://elixir.bootlin.com/linux/v5.18-rc1/source/drivers/iio/accel/adxl345_i2c.c#L42
> This is very common for these types of devices as there are often many similar
> variants, usually with different ranges or with small additional features, or numbers
> of interrupt pins etc.  Another fun one is parts with ratings for different applications
> but identical software interfaces being given different part numbers.
> I think in this case the two parts have different scaling, but are otherwise
> identical.
> 
> So probably need to find another part.

Hi, Jonathan

I took another look at the Analog Devices Inc. catalog and choose another
couple of options:

    - ADPD188BI and ADPD410x: are optical devices based on SPI/I2C. I guess they
    might be too bold for a GSoC project.
    - MAX31875: is a Temperature Sensor based on I2C. Different than the optical
    devices, this one might be too simple.
    - LTC2499: is a multiplexed ADC sensor. For now, it is my best option.

If possible, I would like to get your input on those options.

Sincerely,
Maíra

> 
> Jonathan
> 
> > 
> > Regards,
> > Maíra
> > 
> > > 
> > > Good luck!
> > > 
> > > Jonathan
> > > 
> > > 
> > >   
> > > > 
> > > > Sincerely,
> > > > Maíra Canal  
> > >   
> 
