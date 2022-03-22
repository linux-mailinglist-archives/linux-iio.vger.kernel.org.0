Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92FC4E3C2F
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 11:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiCVKLF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 06:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiCVKLD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 06:11:03 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA842237CC
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 03:09:34 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id a11so10089513qtb.12
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=INxUWnuMkkOhgs7xkqZ5eHI8tVwhHUlyqLTPQHZue5k=;
        b=RGs6YhjQG1BjYyXxiM+vKvrTyAyz5GPiXnjaNKUpWsZ/YQInbmGkr9WCDA6Zd6I6tq
         6wD1d2iRcJ2Q6a71lbOLreqVZ119/nDpwRqAlPnKBa09xpXYOAVfhhuMk559pjR7EP93
         veAWjR1ze3am6Hks8e7V5RxHjKoCH3Z+I7iRABGbKRsq4Q77iLqLsdLt6w3M05UqbogP
         v29Mw6bb0Y2p1+9BJ3mYEzn8NVVdSrcDaYR0GrkUAHHlS4Kh4Y8UN6Ur0LYaR3WEM6D4
         Vf6ZZOM+QKSsFFqeu7omilJA9WrQ+Er/KOSobmaMpjo+XKbUCOH3WyKIAIcJnzYGqZTB
         vijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=INxUWnuMkkOhgs7xkqZ5eHI8tVwhHUlyqLTPQHZue5k=;
        b=P1aZsobLmj/D8aPeeJRRHitRSAgL8IYVCnBnFlHLgnf1wQGt0zal1YPtD13m5uPO1N
         cUDw/5jhBN9/rViuArY15GXdyaFiA0foFN0jcT9yBY50XLyNuXb3u3qOwpV1PwWTFIN9
         H7TxBiDMKjK4+DEDmztAuzjWWAWwVgsH4Fi1txfyy0VXJH2Uq3ScayQ9yMKYER8jSsr6
         QejV3dNxBjWPNP9e5K6EKW5tW3UfOoETo41BDg17ZnDMpK6zEsjfwQ6ltPAtgwuxBkhB
         Ct/VZ2vXwykggJM3WU5PRhrsjfidn4yDqzIW2JZ+pPu/KHdPoU4tOofniGBIyeaLcZs/
         Ea7g==
X-Gm-Message-State: AOAM531sS/tWFHtefuC0f/iPlZMh3K7OEoBx/NsA7s/OpkngP/XnveBt
        TblLTS37WOSmHq8ZWOmjjGU=
X-Google-Smtp-Source: ABdhPJwV69kN7qzOnsc58JMr7oHyBcZfU/1Zi4U3EtGn80dGkO8imptixMuDTncj40mszBqLxEneYw==
X-Received: by 2002:a05:622a:308:b0:2e1:d3f8:b967 with SMTP id q8-20020a05622a030800b002e1d3f8b967mr19196910qtw.224.1647943773097;
        Tue, 22 Mar 2022 03:09:33 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef00:8400:3d36:58a:667a:1da9? (p200300f6ef0084003d36058a667a1da9.dip0.t-ipconnect.de. [2003:f6:ef00:8400:3d36:58a:667a:1da9])
        by smtp.gmail.com with ESMTPSA id o6-20020a05622a044600b002e1b9be8e6fsm13516809qtx.36.2022.03.22.03.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 03:09:32 -0700 (PDT)
Message-ID: <5be8958b14e252fcad9090ce911caa170e654186.camel@gmail.com>
Subject: Re: [PATCH] iio: core: WARN in case sample bits do not fit storage
 bits
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Tue, 22 Mar 2022 11:10:08 +0100
In-Reply-To: <220fa73c-5d61-a564-79a3-eabff366964c@denx.de>
References: <20220320181542.168147-1-marex@denx.de>
         <YjhWIN6GsuhPskrs@smile.fi.intel.com>
         <8b6f00be-c520-45c3-4497-d0fc310ff52f@denx.de>
         <Yjijg7m+TnaMs519@smile.fi.intel.com>
         <30a13541-0ffb-a537-e943-3751b7fd316b@denx.de>
         <bd7f7b9853cbea30740af14d29a46f1a9f93a2a7.camel@gmail.com>
         <YjmbstSwzbu5ZdBg@smile.fi.intel.com>
         <220fa73c-5d61-a564-79a3-eabff366964c@denx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
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

On Tue, 2022-03-22 at 10:57 +0100, Marek Vasut wrote:
> On 3/22/22 10:49, Andy Shevchenko wrote:
> > On Tue, Mar 22, 2022 at 08:43:10AM +0100, Nuno Sá wrote:
> > > On Mon, 2022-03-21 at 20:46 +0100, Marek Vasut wrote:
> > > > On 3/21/22 17:10, Andy Shevchenko wrote:
> > > > > On Mon, Mar 21, 2022 at 03:46:51PM +0100, Marek Vasut wrote:
> > > > > > On 3/21/22 11:40, Andy Shevchenko wrote:
> > > > > > > On Sun, Mar 20, 2022 at 07:15:42PM +0100, Marek Vasut
> > > > > > > wrote:
> > > > > > > > Add runtime check to verify whether storagebits are at
> > > > > > > > least
> > > > > > > > as big
> > > > > > > > as shifted realbits. This should help spot broken
> > > > > > > > drivers
> > > > > > > > which may
> > > > > > > > set realbits + shift above storagebits.
> > > > > > > 
> > > > > > > Thanks!
> > > > > > > 
> > > > > > > ...
> > > > > > > 
> > > > > > > > +                       /* Verify that sample bits fit
> > > > > > > > into
> > > > > > > > storage */
> > > > > > > > +                       WARN_ON(channels[i].scan_type.s
> > > > > > > > torage
> > > > > > > > bits <
> > > > > > > > +                               channels[i].scan_type.r
> > > > > > > > ealbit
> > > > > > > > s +
> > > > > > > > +                               channels[i].scan_type.s
> > > > > > > > hift);
> > > > > > > 
> > > > > > > Not sure WARN is a good level (it might be fatal on some
> > > > > > > setups
> > > > > > > and we won't that),
> > > > > > > besides the fact that we may use dev_WARN(). Perhaps
> > > > > > > dev_warn()
> > > > > > > would suffice?
> > > > > > 
> > > > > > I was actually thinking about BUG(), but that might crash
> > > > > > existing systems.
> > > > > > I think we want a strong indicator that something wrong is
> > > > > > going
> > > > > > on which
> > > > > > must be fixed and the splat produced by WARN_ON() is a good
> > > > > > indicator of
> > > > > > that. It also does not crash existing systems,
> > > > > 
> > > > > It does crash _some_ of them, unfortunately.
> > > > 
> > > > Details please ?
> > > > 
> > > > WARN_ON() shouldn't cause crash outright, or do I miss
> > > > something ?
> > > 
> > > Arghh, completely forgot about this... Andy is right, maybe there
> > > are
> > > other cases (in which case, it would be nice to share :D), but
> > > this one
> > > is definitely one of them:
> > > 
> > > https://elixir.bootlin.com/linux/latest/source/kernel/panic.c#L579
> > > 
> > > You can have a cmdline parameter to panic on _WARN() and some
> > > systems
> > > may have it.
> > 
> > Yes, I meant panic on warning.
> > 
> > And I can't imagine that this driver can be system critical to the
> > extent
> > that we have to crash the system.
> 
> Is there something which does trigger a backtrace, but without 
> panic()ing the system ?

Nothing I'm aware... Other than directly call 'dump_stack()'

- Nuno Sá
