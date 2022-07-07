Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5FF5698C2
	for <lists+linux-iio@lfdr.de>; Thu,  7 Jul 2022 05:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbiGGDVn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Jul 2022 23:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbiGGDVm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jul 2022 23:21:42 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDFD30F52
        for <linux-iio@vger.kernel.org>; Wed,  6 Jul 2022 20:21:42 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d10so2962246pfd.9
        for <linux-iio@vger.kernel.org>; Wed, 06 Jul 2022 20:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2+aOTulpBacXUafi89XgcW61O8xOxcCIKufyRd+DMaE=;
        b=Bjz8vU2YfjQEYasE6WaBobBo7z1JhlzZRisBml1wEg9upjYDA+OL90i1RUCr4jqPbc
         swE4cF8li4HNaa3jaSbn1XtZXlDbiFE5sg9QfNi2NgF40oyMbL8b96CLDdjW+rHUXuYJ
         30Pie1dTWbfTQfpnt9r4l1s0YZ+XJCgz6EXePBUhfU3t27JhAiADYnISBA6eVShKN0Nd
         /WxafL4AvmSKCByjIReG8NGX1hkwmSPKjC/eBrQYSBClEsTYjknrGxjIwLcOjNyoBKRF
         L/bIZm3T+O7//tsd7vnudf5ucAZMIAD5wXtRUY/be9KwJkSHLa9JYIjtueutfgUEvYDp
         BQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2+aOTulpBacXUafi89XgcW61O8xOxcCIKufyRd+DMaE=;
        b=iOX/VS3PcI1eRKITBH+/Vx/LWQlny8Z0fuSbq+p8UO3FqQ6OOBeJ5F9vcoeQJHAJ3+
         kPr+gn/cvIbYaRgCn5X+w7YCOrvKtLQIQX1F6Idk7PmGvujPcuH3G4igXKEesLsMjyGc
         D4pUZgWPnX9adqd7R7drani8di23lyuwe4xZutUp8131cu4pwcF23pU/dN5Rz8Sgovic
         M3UepBCXyjiFelZc3xIsQQxx4e28AMqUMOO5x5O8zBvSRbULCTNZZARqJYZInZubOSkW
         ZCs0GDJMXsntvPiAMlLCeRidZST0CE9HFbgw3wAjYMUmuJ0+QdIC8wY6LNC1oaF9FoxA
         +gew==
X-Gm-Message-State: AJIora8p8WBsQRzD5xjo1bL6/ibgsFXXwRkRKYqt0N9Do5wRJ/iRWkjq
        Fgz+rnfjmRMoz9kvRlBf7jQ=
X-Google-Smtp-Source: AGRyM1tX2CdcVaeerHZ3+DB07hvrp2h8Vuv84zNvP2OH2gUEA+sOZXvCaHTpjfQ/mgfjt3ub1DI6Rg==
X-Received: by 2002:a63:eb03:0:b0:412:b1d6:94ca with SMTP id t3-20020a63eb03000000b00412b1d694camr2732570pgh.468.1657164101621;
        Wed, 06 Jul 2022 20:21:41 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id z29-20020a63191d000000b0040c9774b332sm24385349pgl.48.2022.07.06.20.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 20:21:40 -0700 (PDT)
Date:   Thu, 7 Jul 2022 11:21:33 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     "Hall, Christopher S" <christopher.s.hall@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "william.gray@linaro.org" <william.gray@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        "N, Pandith" <pandith.n@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Subject: Re: Intel Timed-IO driver in IIO/Counter subsystem
Message-ID: <20220707032133.GC7250@sol>
References: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <44170bf8-5777-e30b-b74d-a6835b1937e2@metafoo.de>
 <YqxOl8W2yzp9CcBP@smile.fi.intel.com>
 <CACRpkdbeQ_67V3jkw_-KfTwe54TxrK_LA7N8Nwj1qEpTELN9dQ@mail.gmail.com>
 <ad7e53d1bd2448b4971af65483fe3542@intel.com>
 <CACRpkda63TNWLdTjY+_xxXb4df4qCZi1EaXL3pXK=+Hon-0RLQ@mail.gmail.com>
 <20220705031635.GA14199@sol>
 <7d72f1ef363a4003b5209d68a88f30a9@intel.com>
 <CACRpkdYxverx-KsG9URrh5qkEFXDknZKCE6RM555mjOuC--vMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYxverx-KsG9URrh5qkEFXDknZKCE6RM555mjOuC--vMg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jul 07, 2022 at 01:05:16AM +0200, Linus Walleij wrote:
> On Wed, Jul 6, 2022 at 7:52 AM Hall, Christopher S
> <christopher.s.hall@intel.com> wrote:
> 
> > > My first thought was that you could extend the SET_VALUES ioctl but,
> > > while we have reserved space for future use in most of the ioctls it
> > > turns out we overlooked sets and gets, so you would be looking at a new
> > > ioctl.  And you need to keep in mind how the SET_VALUES ioctl would
> > > interact with it (Linus' point).
> >
> > I think we worked around this in a previous patchset by disallowing
> > (return error) the 'set' method. The pin/pad is assigned (by mux
> > configured in BIOS) to either GPIO or Timed I/O logic and both cannot be
> > used simultaneously.
> 
> And we know it will always be like that? What about other systems
> that are not your specific x86 box and that go and implement this
> API? I don't think this should be handled in the driver but in the
> gpiolib.
> 

Strongly agree with Linus on this - the ABI needs to be general, not
in any way specific to your hardware - but something that can be
implemented using your hardware.  Ideally you have other example
hardware, or two.

GPIO or Timed may not be used simultaneously, but might it be selectable
at runtime?  If so the user would specify an output mode as part of the
line request, which could be an addition to the existing drive modes.

It still isn't clear to me what happens if I request a set for a past
time.  Does it set immediately, do nothing, or return an error?

Same applies for while one is pending, particularly how it is determined
that it is pending.  I have a bad feeling about race conditions here.

Also be aware that the GPIO uAPI line requests operate on a set of lines,
so your ioctl needs to identify which of the lines in the request it is
operating on. e.g. the mask in gpio_v2_line_values.

And you should use fixed sized fields in ioctl structs [1].
For timestamps the GPIO uAPI uses u64.  How that is interpreted depends
on the selected clock.

Also agree with Linus on the periodic trigger - that seems to have
jumped outside of GPIO scope.

Cheers,
Kent.

[1] https://www.kernel.org/doc/html/latest/driver-api/ioctl.html
