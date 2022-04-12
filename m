Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579904FE88B
	for <lists+linux-iio@lfdr.de>; Tue, 12 Apr 2022 21:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiDLT0c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Apr 2022 15:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349570AbiDLT0b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2022 15:26:31 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18B963CF
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 12:24:09 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id k13so604630oiw.1
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 12:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ehHADkkXeGmOOoVE2hpQfF90bQu7rxoejBCGdcmXr6M=;
        b=a2dnTdgHyg3PwKC9VFdLgXpNfqBiVJ5zXXVY17ZhQtg0SuoIKojiIPIrgszQpcLEO0
         qlQl0XzWdVQZ6ImBuvNaqdnMHbBt8eN9DLbzfep0uID5aUD+zYGTCBn+HG3lAbIumQEm
         nz4NCaWYWkm9QNguz46dezYYV84ODlq5dfYNRT8j114/KbvuAPV2q2Jmjdge1HGr43df
         3JRZa0SvnPxheAeFz8aB3O4Ii0uMbnVyJAaqb858rmw6rZ5/3XNm14GFPNvEi08yuN6t
         COYDqSKHhh7qr3lGhB4F56bYLLifPIr2xunNAwAFPEhqC1f9vxnhfL8FVYaeK2fzINzH
         uT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ehHADkkXeGmOOoVE2hpQfF90bQu7rxoejBCGdcmXr6M=;
        b=nItGss4g3rrwdysPHQIq5I1sAWUpa6F40zSX+ccAg4Hks1x1z3MlSQ4CVw+TaWHkKI
         yTTilRe5yIVzUK51dwYdRtt/jvic9XXXSgWSby+N/eyLIbXF4WsZE8OXyy4KJPxRhXhc
         vesoutU7y19FUr5AwayNbxKYNuZ/dDI6KORiWs1Sqg46tP9YFwiBX2VnN4KM9F+gm8KN
         QXYAcoza7xodMr6RbE0nHpwtqXuOHjKneuWT4xAExQ1D2ulazSPNlj8OtOOK34nY7z/g
         iW4EQNtN/ZHOpaV1utXkejKqKKC9gQwVbF3sP1YaeIheXorVD+mEDuFetpUtdbvpVMoG
         W2Xw==
X-Gm-Message-State: AOAM533/Yehja9w3Z998kKBHWJTwcl/KZ2/YNCArgpTnNxMMtvIlwraU
        hP4lmrVnrwpwAQ5uMG8iFs4/KQ==
X-Google-Smtp-Source: ABdhPJzYfC7RpM8q7GiIMMk0YHxW08KI2QLkyFIuMqAU8AH0FyWvv0MbomG6+eF+EvcKdp69elW/ag==
X-Received: by 2002:a05:6808:114d:b0:2f7:59fd:2f18 with SMTP id u13-20020a056808114d00b002f759fd2f18mr2477572oiu.113.1649791447671;
        Tue, 12 Apr 2022 12:24:07 -0700 (PDT)
Received: from fedora ([187.64.132.161])
        by smtp.gmail.com with ESMTPSA id x1-20020a4ae781000000b00320d5d238efsm12945515oov.3.2022.04.12.12.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:24:06 -0700 (PDT)
Date:   Tue, 12 Apr 2022 16:24:01 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Hegbeli, Ciprian" <ciprian.hegbeli@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: GSoC Proposal 2022
Message-ID: <YlXR0d7waKW9xncd@fedora>
References: <CAH7FV3=UJn98PRp1dke7iAH2j8pj4-VSbnb11OfzRUKmkAEL8Q@mail.gmail.com>
 <20220410182819.23967855@jic23-huawei>
 <YlNcQEAZVGYBkdy5@fedora>
 <20220411095219.000058a8@Huawei.com>
 <YlQpcZvwZuabMsz+@fedora>
 <CAHp75VeWHgn_c9n4-t2Ofi5S7U+K2o_Sa9hNc6PvXUfR_ENtCg@mail.gmail.com>
 <59c37b67bbc4a24336e5220a7ad4f242d854fb76.camel@gmail.com>
 <YlVvhoBNap4Yip3O@fedora>
 <a5f002afb956c96b20c5f5589c34ecaa1bdfadc6.camel@gmail.com>
 <20220412171933.00002d1d@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220412171933.00002d1d@Huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/12, Jonathan Cameron wrote:
> On Tue, 12 Apr 2022 16:23:55 +0200
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
> > On Tue, 2022-04-12 at 09:24 -0300, Maíra Canal wrote:
> > > On 04/12, Nuno Sá wrote:  
> > > > On Tue, 2022-04-12 at 11:48 +0300, Andy Shevchenko wrote:  
> > > > > On Tue, Apr 12, 2022 at 10:43 AM Maíra Canal <maira.canal@usp.br>
> > > > > wrote:  
> > > > > > On 04/11, Jonathan Cameron wrote:  
> > > > 
> > > > The MAX31875 looks to be a fairly simple one (maybe a good
> > > > candidate
> > > > for a first driver) but, IMO, having it in IIO boils down to have
> > > > support for continuos mode which would mean triggered buffer
> > > > support.  
> > > 
> > > I took another look at the Maxim Integrated catalog and end up
> > > finding
> > > the MAX31889 Temperature Sensor.
> > > 
> > > I guess this sensor has an interesting challenge level with the need
> > > to
> > > implement FIFO and interrupts support. 
> > > 
> > > Have you guys some thoughts on this one?
> Hmm. The fifo is interesting, but I'm somewhat doubtful that it's actually
> much use when connected to a linux system.  The sampling rate is 1Hz.
> At that rate even in busy systems or low power situations, there is
> little reason not to just poll the device.
> 
> You 'could' wire up a PWM or similar to the gpio and have it operate
> like a 'self clocked' device but with sampling rates so low it's a fairly
> contrived situation.
> 
> Temperature sensors in general are often a bad fit for IIO precisely because
> they are mostly designed for monitoring type purposes which HWMON covers.
> The exceptions are high speed or high accuracy devices or weird ones like
> infrared thermometers.

Okay, so temperature sensors are not a good choice for an IIO project.

Just another two suggestions: AD5124/AD5144/AD5144A potenciometer and AD7294-2
ADC. Any of those are a good idea for IIO?

P.S.: It's been hard to choose a component without any project requiments (like
in a real hardware project). I'm sorry for the buzz on the mailing list.

> 
> Jonathan
> 
