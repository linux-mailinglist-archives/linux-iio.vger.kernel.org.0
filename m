Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807D94FEFD1
	for <lists+linux-iio@lfdr.de>; Wed, 13 Apr 2022 08:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiDMGaq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Apr 2022 02:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiDMGap (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Apr 2022 02:30:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4376340ED
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 23:28:20 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b19so1076595wrh.11
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 23:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DwsDzk3cGTeVoEdkuuBjikCrGOrGDxfJnWlv3d6LKdI=;
        b=Y4SPTU2bEzYm2XbMfSoko/dGKSNneQxEoRZzMacjUa73q8ZyueIl7v0aUaWeaAmXys
         vDgBuccTnEDEvuIUWRvks/LQewlxBzfiyHDTvZzIo9TK0hoJHJP8E37Q7J6fHR1Kbdk/
         ficJJZan5npG5Cp7Re2pfKdMoLqIXWVdHHKRKCGgLFndoTDt48Ct7jAsCWJGYX4VNL4K
         gOvS3FN2Y/iZ43AdOmlX40wmVY7REocNiTRkbpQYdv041IwL5MpTkx8hpY02fAF97Piq
         yUW7CW1LQmON/Vwqw/Xp6ICFYxiOh4wJaLcWNjnEetGv/l3CyNKIXmmhEZcArDP1+TAd
         OzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DwsDzk3cGTeVoEdkuuBjikCrGOrGDxfJnWlv3d6LKdI=;
        b=ofBjISfrRGWgvSt3ORSFX0yCMmA2rg/QFo5nxRIm56vx05xcExj6BatlafzzYsUBtY
         QjHNs/boc6xPZ5/AHvlersM4rXB0lIAO9Q72MmUPFbzNLX1QAh7R9x5lRHJROhUTduD1
         vKm/8zWW80wU3do+dTGDbfjw16h1WikI1+w7UK1AXFfAe2wjdyeO2lTAMA52gPV2tWTO
         nUg3jO6/XrLMeGmAwuwp8bZgIQ7jFDvLPL9FF3wDbhNiCJvchWFK3oVbi+Xiun21Lfj2
         f+4ze4GgDMAiiAr08UEKS7l4R3ff3+JX1BmbduSnMuo9aL9ofdKtJWaLR4S+J9sHOwqU
         P2aA==
X-Gm-Message-State: AOAM532Tp70yf4lNbgBgKck83cqc7pQTo+6MKL1G+dnOzIvTKSUQ9dQr
        R33olcJAEcB9C8dHRK0nJVI=
X-Google-Smtp-Source: ABdhPJxjYq/ADtqGcLWAdRrcQaAz7iekg/w6geFb37xOc+IDJC0yajCdhgWPpGex56TcUQEKjEr7dA==
X-Received: by 2002:a05:6000:1f83:b0:207:a4d8:5173 with SMTP id bw3-20020a0560001f8300b00207a4d85173mr12010701wrb.556.1649831299245;
        Tue, 12 Apr 2022 23:28:19 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b2c:c401:dd5:7d95:7a65:6518? ([2001:a61:2b2c:c401:dd5:7d95:7a65:6518])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b00207b5d9f51fsm1384608wrf.41.2022.04.12.23.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 23:28:18 -0700 (PDT)
Message-ID: <3a6be0aab9639081774be6dd011e0b68df53e204.camel@gmail.com>
Subject: Re: GSoC Proposal 2022
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?ISO-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Hegbeli, Ciprian" <ciprian.hegbeli@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Date:   Wed, 13 Apr 2022 08:28:17 +0200
In-Reply-To: <20220412165926.000004c7@Huawei.com>
References: <CAH7FV3=UJn98PRp1dke7iAH2j8pj4-VSbnb11OfzRUKmkAEL8Q@mail.gmail.com>
         <20220410182819.23967855@jic23-huawei> <YlNcQEAZVGYBkdy5@fedora>
         <20220411095219.000058a8@Huawei.com> <YlQpcZvwZuabMsz+@fedora>
         <CAHp75VeWHgn_c9n4-t2Ofi5S7U+K2o_Sa9hNc6PvXUfR_ENtCg@mail.gmail.com>
         <59c37b67bbc4a24336e5220a7ad4f242d854fb76.camel@gmail.com>
         <20220412165926.000004c7@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2022-04-12 at 16:59 +0100, Jonathan Cameron wrote:
> On Tue, 12 Apr 2022 14:06:21 +0200
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
> > On Tue, 2022-04-12 at 11:48 +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 12, 2022 at 10:43 AM Maíra Canal <maira.canal@usp.br>
> > > wrote:  
> > > > On 04/11, Jonathan Cameron wrote:  
> > > 
> > > ...
> > >   
> > > > I took another look at the Analog Devices Inc. catalog and
> > > > choose
> > > > another
> > > > couple of options:
> > > > 
> > > >     - ADPD188BI and ADPD410x: are optical devices based on
> > > > SPI/I2C.
> > > > I guess they
> > > >     might be too bold for a GSoC project.
> > > >     - MAX31875: is a Temperature Sensor based on I2C. Different
> > > > than the optical
> > > >     devices, this one might be too simple.  
> > >   
> > > >     - LTC2499: is a multiplexed ADC sensor. For now, it is my
> > > > best
> > > > option.  
> > > 
> > > Have you checked if it has similarities to 2496 and 2497
> > > variants? We
> > > already have drivers for those, it makes sense to double check.
> > >   
> > 
> > Yeah, after a quick look on the datasheet, they look very
> > similar...
> > 
> > The MAX31875 looks to be a fairly simple one (maybe a good
> > candidate
> > for a first driver) but, IMO, having it in IIO boils down to have
> > support for continuos mode which would mean triggered buffer
> > support.
> > 
> > And this brings me to something that already crossed my mind...
> > Jonathan, would it make sense to be able to change the trigger
> > "sampling frequency" depending on some device configuration? In
> > this
> > case, if we want to have continous mode, I guess a hrtimer trigger
> > would be, for example, one good candidate of a trigger to attach.
> > And, as we can have different SPS, we would want to have the
> > trigger
> > fireing depending on that... This could also be an additional
> > "task"
> > for you (if it makes sense of course).
> 
> In this case what defines the SPS? 

Yeah, it is something that you can set on the device so a writable
sampling_frequency attr. I think it fits on your 3rd point. Anyways, it
din't even crossed my mind that these rates are so low that buffering
is is not worth it...
> 

- Nuno Sá
