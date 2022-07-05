Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5745661B7
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jul 2022 05:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiGEDQq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 23:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiGEDQp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 23:16:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6B8EE13
        for <linux-iio@vger.kernel.org>; Mon,  4 Jul 2022 20:16:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so7063664pjm.2
        for <linux-iio@vger.kernel.org>; Mon, 04 Jul 2022 20:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GbLycitLRgBHL5wDg4EwF+jGZQU7+lUzQCNzez09KOM=;
        b=CAI81GomUD+KZowVYsMY7DQvsy9ezpqKi0O5NrlnSv9qJr8nBTM0hl2+7e1wGnRP/l
         8gNlmwIkA6V8bmQBot8T/Caw9Ph2xuVzXv7IQy0APbFBQCQQnuyC7iqtyOBh4D4CRKG+
         Z/aYUv9luMR0F7cyRS6EI3LRTFpA4ByVjXgmK5iOQP/1UgmDkApoaO7vu63+De3A11qQ
         cSyHpK3o2UKKAcBnyrA4diXlaSI6p9Xnfkdg6MR8Lq5K5hdUreiwYsN9bZMarMzHSk7w
         AeYyUv3l0XkfPea++kw31LkCQU+ZjP4s2u2oNM04GIURvuLObf8iq3vePC/y1IC4DTF5
         A3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GbLycitLRgBHL5wDg4EwF+jGZQU7+lUzQCNzez09KOM=;
        b=fN57UCHQILTKU5/ydvAYtTgtX0AqBN4ROm0LSzdxO57+Y29ojPZDV38p11IxfzBuPY
         e/J2v1hfDJH6E7Wcy+i52RA0uX0L043PobGntYLGM4+Vy64Ed121JubFWqBU0q5KJIj5
         VxTvU+1NbGMNsQZ4nv1ksSAuWU2UvCCUla/CflZ2F8eO3ktQscpuFSCpKiKLK6O/AItf
         nnujDMrTqY9msEDw1ve/va5BkfVy140Dij1gok52+HHUo7tbNvRnU3EKXFC9B+z2gq4u
         Ir9G082bfOBsReLkNaBnpbMLiHQtf0F9RXBuzj3e/i9jiUXKB46s/XHkd2paHYO0JR9t
         AHaw==
X-Gm-Message-State: AJIora9uzz+8//D3MtRNS5ma/jX/ic2nlf90Y0h46jYOkeijqBp52a4F
        HxBLz42Gmc9c8DIsKUx5AhA=
X-Google-Smtp-Source: AGRyM1s7NTKAD6BwOVQiMpfsEVXDC8EfwsarBambWfH0SRxA5k00aCqBUctiwsA5/WY+jlfdXY1CFA==
X-Received: by 2002:a17:903:c5:b0:16b:d8d5:5f14 with SMTP id x5-20020a17090300c500b0016bd8d55f14mr13787981plc.18.1656991003207;
        Mon, 04 Jul 2022 20:16:43 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b00164097a779fsm22507499plh.147.2022.07.04.20.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 20:16:42 -0700 (PDT)
Sender: Kent Gibson <warthog618@gmail.com>
From:   Kent Gibson <kent.gibson@iinet.net.au>
X-Google-Original-From: Kent Gibson <warthog617@gmail.com>
Date:   Tue, 5 Jul 2022 11:16:35 +0800
To:     "Hall, Christopher S" <christopher.s.hall@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
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
Message-ID: <20220705031635.GA14199@sol>
References: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <44170bf8-5777-e30b-b74d-a6835b1937e2@metafoo.de>
 <YqxOl8W2yzp9CcBP@smile.fi.intel.com>
 <CACRpkdbeQ_67V3jkw_-KfTwe54TxrK_LA7N8Nwj1qEpTELN9dQ@mail.gmail.com>
 <ad7e53d1bd2448b4971af65483fe3542@intel.com>
 <CACRpkda63TNWLdTjY+_xxXb4df4qCZi1EaXL3pXK=+Hon-0RLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkda63TNWLdTjY+_xxXb4df4qCZi1EaXL3pXK=+Hon-0RLQ@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 23, 2022 at 02:21:30PM +0200, Linus Walleij wrote:
> On Sat, Jun 18, 2022 at 4:01 AM Hall, Christopher S
> <christopher.s.hall@intel.com> wrote:
> > Friday, June 17, 2022 4:40 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > > For 2. I am uncertain. Periodic events sound like PWM to me.
> >
> > I do not think TGPIO periodic output is useful for PWM. There are two output
> > modes: edge output and pulse output. In edge mode output, where the an edge
> > is produced periodically based on the programmed period the duty cycle is
> > always 50%. In pulse mode output where a pulse is produced each output
> > period, the width of the pulse is two ART ticks which on current Intel
> > client platforms is about 50 ns. The pulse width is not adjustable.
> >
> > We want to be able to output a clock from 1 Hz (1 PPS) up to 1 KHz that is
> > synchronized with the system clock.
> >
> > It is possible to represent the periodic output function as a PWM device,
> > but the PWM subsystem output - without modification - is not aligned to
> > any clock which breaks the timing application.
> 
> Is it "just" a clock then? As in drivers/clk?
> 
> It's of course annoying that the functionality of a certain hardware falls
> between the subsystems so we end up using pieces of a subsystem in
> another one, but there are several precedents, like network switch chips
> and USB UART chips with GPIO inside them, or graphic chips with
> clock dividers inside.
> 
> > > If a "single event" is something
> > > like pulling a GPIO line high/low at a specific (wall clock) time in the
> > > future, it should probably be in the GPIO subsystem, like a triggered
> > > GPIO event or so, that sounds a bit hard but certainly doable with some
> > > thinking and tinkering.
> >
> > Earlier, we proposed a linereq_write() method in addition to the already
> > existing linereq_read().
> >
> > https://lkml.org/lkml/2021/8/24/807
> 
> This might be a good approach for this part of the hardware, as long
> as we can make sure we get the userspace API abstract enough
> that other hardware can make use of it and userspace does not
> need to know what provides the timed output, just that there is
> some hardware that does.
> 
> The ABI in the patch looks a bit dangerous, what happens if
> you set an event like that and something decides to shake the
> line by setting the output while the scheduled event is pending?
> 
> The direction seems sound however, but Bartosz and Kent need
> to look at it in detail, their effort on the userspace ABI has been
> tremendous.
> 

Extending the GPIO uAPI seems like a reasonable approach for timed
sets, but as Linus mentioned, you need to consider the semantics of
your operation for the general case.  What if the set time has already
passed?  What happens with subsequent sets when one is already pending?
Can they be cancelled?

My first thought was that you could extend the SET_VALUES ioctl but,
while we have reserved space for future use in most of the ioctls it
turns out we overlooked sets and gets, so you would be looking at a new
ioctl.  And you need to keep in mind how the SET_VALUES ioctl would
interact with it (Linus' point).

I don't see the linereq_write() approach flying - an ioctl is more
appropriate.

Cheers,
Kent.
