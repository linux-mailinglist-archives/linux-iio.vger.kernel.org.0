Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4514FF021
	for <lists+linux-iio@lfdr.de>; Wed, 13 Apr 2022 08:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiDMGyZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Apr 2022 02:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiDMGyY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Apr 2022 02:54:24 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1495B10F2
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 23:52:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id p15so1947473ejc.7
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=8bgy75n4r6EuA1ve+vfhmIAzPRAe0prSAeF9WLtXlts=;
        b=q42FmhOyIFkmVSEP3NQHsZrLaPyIS4x4/BLgilhhC1Mw7rFqh0vaMTWgmWGn29h4He
         RHssQ+oK44napw0tV3hG3IF9E9lhZBo09PbL9uh/MntaR2Wbzx9FT/Nk71FNEyz9gPWk
         2pRBNqnXWT7x6ZqEseQF4vYoCDA4dqPeiV/RY+KqtgXkTAP/lUqLI+jAw96cR0H69oFL
         lBRz/aoWaCLnSCl12nIu49eXQcOOUlN1KfzbaTDnozrEZ+rQMS4tV0fxt8qJ0X/mLDzi
         XjmBjqZKx7pl/uAxzrd791DrfQF8DEzp0rkW9EHjLU8fbBsjt2j4ndtuU922IAeqNJdX
         kRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8bgy75n4r6EuA1ve+vfhmIAzPRAe0prSAeF9WLtXlts=;
        b=2TWOzZVfu7chSHTryxV6xZ3DKckl4NabgFvXF6aysjs/k+wTFKnVcawsC1dS0zsPTH
         FL29kzHtH7veRoGeJZm09bThfC0wQwX+L6mWyG3i1n82cUp+9vdVjFXantzvFVwo28cK
         bj0u+SJkzmx1bLTUpozEcxnYJN/zaWxvJadgBgvT06sFgVYa1+KNTG8pDHXZkgjQhpN9
         w2oXNbq533q4LV1gTKqEind2uzsMkaZVIhkJtSE0s55ADHZMYbhq6bmZMghtllHK2xzb
         xvBfNedJgoo+b48jg5Q7gR/1QUZMNrr5FD4/udKrAXh1EKs4vC9+9trNoByU6oT1qDSt
         pD2A==
X-Gm-Message-State: AOAM53037kuc2VFDmDRM/azYCoc9aESyDhQurAkxMag5fCJrF0g3v4OP
        Ug0gWK9NymnNCUvNsAQJKqU=
X-Google-Smtp-Source: ABdhPJxCmmF5/4cWLQEFgaajhHik/PJyNN2MJEIY48jEfdOtEMFYg4faExT1qaosBBgi3CnYSlmLrA==
X-Received: by 2002:a17:906:f0d4:b0:6e8:67c9:9ce0 with SMTP id dk20-20020a170906f0d400b006e867c99ce0mr18857098ejb.218.1649832722454;
        Tue, 12 Apr 2022 23:52:02 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b2c:c401:dd5:7d95:7a65:6518? ([2001:a61:2b2c:c401:dd5:7d95:7a65:6518])
        by smtp.gmail.com with ESMTPSA id k14-20020a50e18e000000b0041b6f23f7f6sm811801edl.22.2022.04.12.23.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 23:52:01 -0700 (PDT)
Message-ID: <e6c272a05b9073718a6b869533537bf163bf4ad5.camel@gmail.com>
Subject: Re: GSoC Proposal 2022
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     =?ISO-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Hegbeli, Ciprian" <ciprian.hegbeli@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Date:   Wed, 13 Apr 2022 08:52:01 +0200
In-Reply-To: <YlXR0d7waKW9xncd@fedora>
References: <CAH7FV3=UJn98PRp1dke7iAH2j8pj4-VSbnb11OfzRUKmkAEL8Q@mail.gmail.com>
         <20220410182819.23967855@jic23-huawei> <YlNcQEAZVGYBkdy5@fedora>
         <20220411095219.000058a8@Huawei.com> <YlQpcZvwZuabMsz+@fedora>
         <CAHp75VeWHgn_c9n4-t2Ofi5S7U+K2o_Sa9hNc6PvXUfR_ENtCg@mail.gmail.com>
         <59c37b67bbc4a24336e5220a7ad4f242d854fb76.camel@gmail.com>
         <YlVvhoBNap4Yip3O@fedora>
         <a5f002afb956c96b20c5f5589c34ecaa1bdfadc6.camel@gmail.com>
         <20220412171933.00002d1d@Huawei.com> <YlXR0d7waKW9xncd@fedora>
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

On Tue, 2022-04-12 at 16:24 -0300, Maíra Canal wrote:
> On 04/12, Jonathan Cameron wrote:
> > On Tue, 12 Apr 2022 16:23:55 +0200
> > Nuno Sá <noname.nuno@gmail.com> wrote:
> > 
> > > On Tue, 2022-04-12 at 09:24 -0300, Maíra Canal wrote:
> > > > On 04/12, Nuno Sá wrote:  
> > > > > On Tue, 2022-04-12 at 11:48 +0300, Andy Shevchenko wrote:  
> > > > > > On Tue, Apr 12, 2022 at 10:43 AM Maíra Canal
> > > > > > <maira.canal@usp.br>
> > > > > > wrote:  
> > > > > > > On 04/11, Jonathan Cameron wrote:  
> > > > > 
> > > > > The MAX31875 looks to be a fairly simple one (maybe a good
> > > > > candidate
> > > > > for a first driver) but, IMO, having it in IIO boils down to
> > > > > have
> > > > > support for continuos mode which would mean triggered buffer
> > > > > support.  
> > > > 
> > > > I took another look at the Maxim Integrated catalog and end up
> > > > finding
> > > > the MAX31889 Temperature Sensor.
> > > > 
> > > > I guess this sensor has an interesting challenge level with the
> > > > need
> > > > to
> > > > implement FIFO and interrupts support. 
> > > > 
> > > > Have you guys some thoughts on this one?
> > Hmm. The fifo is interesting, but I'm somewhat doubtful that it's
> > actually
> > much use when connected to a linux system.  The sampling rate is
> > 1Hz.
> > At that rate even in busy systems or low power situations, there is
> > little reason not to just poll the device.
> > 
> > You 'could' wire up a PWM or similar to the gpio and have it
> > operate
> > like a 'self clocked' device but with sampling rates so low it's a
> > fairly
> > contrived situation.
> > 
> > Temperature sensors in general are often a bad fit for IIO
> > precisely because
> > they are mostly designed for monitoring type purposes which HWMON
> > covers.
> > The exceptions are high speed or high accuracy devices or weird
> > ones like
> > infrared thermometers.
> 
> Okay, so temperature sensors are not a good choice for an IIO
> project.
> 
> Just another two suggestions: AD5124/AD5144/AD5144A potenciometer and
> AD7294-2
> ADC. Any of those are a good idea for IIO?
> 

Both options look promising being AD7294-2, at first glance, more
complex. The latter actually looks like it fits iio/addac category of
devices. I just briefly looked at the datasheets so I cannot really say
for sure if buffering makese sense for these (for adc/dac often it
does).

- Nuno Sá
> > 

