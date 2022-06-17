Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4515554F6D9
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jun 2022 13:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiFQLkE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 07:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbiFQLkE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 07:40:04 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A5C5A0B6
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 04:40:03 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id v22so6838657ybd.5
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 04:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yc3R1HAxwJRbo0IGIdIenstu0QwkUP0dcps9d2zB52A=;
        b=vE+ND+8bEtyoWfASyAAGfnuGiqsGSf7/9x42qZYxpfKS8n09VlUZXxBJzoBWXBDi0/
         Qx+nuKX8jm9+3lx7/BNixXqDDxpw5yZOM/Q5a6NCz+zR4U/B2thvTw42sslUTgNJm/EK
         Eo/QNM+Qk0FQ9lmPzKYNqvVyXCIy3YTEQtL5Lt4lWuDVsoHrlVJ6EIBQDxR+8Db13f10
         +wjYSks2Bcq9LoSyJKfsvgwF1Qva45AIxrxliFczdJ0DuIVK7oP/mZ7AmAtDtxAjN2hn
         M/fSLzMFRMyFhtBbp0Ny88SPC9Tr0qg87AExNkBTKbN2ad5u/ywo2liWkYwserPqKLsS
         u6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yc3R1HAxwJRbo0IGIdIenstu0QwkUP0dcps9d2zB52A=;
        b=hv0HF67ftorlcgXFbMrQFAdPoFddDVy/3H+Z+aLtcxwFeCjZ9ZqMrqoUC3DOoORO+K
         LxKUD9F5To28jcVEhx/5j8WvbSegLrlJCIfcpKNSLTpXJwdj0uXTS6VoSfb8KcMTcqnl
         Nt4d3+Bsl7UzGtdzpZSt8VGc2ZiIHvxbL7RzQCahQO25oabNoqwzeSMRK3HWNYGybqiv
         GZeeRij3tH0tjBMY7sRDL/CqOgAq2WtU4ERJidSBLEZRLKVcfoXZgNykzIogkYgqzUkt
         MQr7sD9DIgMcaOERrl60awKKMINPGoKbw7qvvnrfGwujM0klTBCJgiI/pcj8v9z572XX
         s4fA==
X-Gm-Message-State: AJIora8oKh2x88YFHb/C0sAw7FJOqxTj4+xInn7qfvzHl1Jnb3jeLOGA
        X0fR2xCwwcWgZfgPjxcSCw7HwXGTi3KI9qx83lcS+w==
X-Google-Smtp-Source: AGRyM1venCjjwZ7GgOmrvGr7VrRGB329r0Hf2ocwMvnWG8w+C90OLZ94ZFN9dD78yXsSvSeaV+aDv5AKrqOZd1021Xk=
X-Received: by 2002:a25:dc0b:0:b0:65d:e5d:a87a with SMTP id
 y11-20020a25dc0b000000b0065d0e5da87amr10277471ybe.295.1655466002933; Fri, 17
 Jun 2022 04:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <44170bf8-5777-e30b-b74d-a6835b1937e2@metafoo.de> <YqxOl8W2yzp9CcBP@smile.fi.intel.com>
In-Reply-To: <YqxOl8W2yzp9CcBP@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Jun 2022 13:39:51 +0200
Message-ID: <CACRpkdbeQ_67V3jkw_-KfTwe54TxrK_LA7N8Nwj1qEpTELN9dQ@mail.gmail.com>
Subject: Re: Intel Timed-IO driver in IIO/Counter subsystem
To:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        "N, Pandith" <pandith.n@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 17, 2022 at 11:51 AM Shevchenko, Andriy
<andriy.shevchenko@intel.com> wrote:
> On Fri, Jun 17, 2022 at 09:22:09AM +0200, Lars-Peter Clausen wrote:
> > On 6/17/22 08:37, N, Pandith wrote:
> > > Hi,
> > >
> > > We have a Intel Timed IO peripheral with following functionalities :
> > >
> > > 1. Event capture capability - Captures event count and timestamp.
> > > 2. Pulse generation - periodic or single event generation.
> > > 3. Return cross-timestamp on request.
> > >
> > > Timed IO device is being used in various Industrial use cases such as : time capture, synchronization, fan speed calculation etc.
> > >
> > > IIO or counter subsystem seems to be suitable for timed-io driver.
> > >
> > > Is it favourable to implement as part of IIO or counter subsystem ? Wanted to know your feedback.
> >
> > That sounds like a mix of a counter and PPS device. Have you looked at the
> > PPS subsystem[1]?
>
> The newly HTE subsystem was proposed by Linus W. to be used for this case.

Indeed, the subsystem was proposed exactly because both IIO and GPIO would
be consumers of it (possibly more). I think it covers case 1 & 3.

Dipen (the HTE subsystem maintainer) worked very hard on it and it can be
used with Tegra194 GPIO events flawlessly all the way to userspace.

You need to make an drivers/hte driver for the Intel hardware and jig
it to the IIO subsystem the same way we connected it to GPIO.

For 2. I am uncertain. Periodic events sound like PWM to me.

If a "single event" is something
like pulling a GPIO line high/low at a specific (wall clock) time in the
future, it should probably be in the GPIO subsystem, like a triggered
GPIO event or so, that sounds a bit hard but certainly doable with some
thinking and tinkering.

Yours,
Linus Walleij
