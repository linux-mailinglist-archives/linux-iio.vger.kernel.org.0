Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D454E39D2
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 08:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiCVHqr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 03:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiCVHq2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 03:46:28 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3672980F
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 00:42:36 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id kl29so6849727qvb.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 00:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OfQAD4iJff5S72ROYWIftuPre1dFw+nLdo1cHHx/NJo=;
        b=BqiszyKlIs1TBaAc4Oy08Cf/a0O+atu9gQRpfX3Yt7acq+VgHbJHobGcErfIK6uSgI
         gurUxIqlgvxDtHLH7Pf/dDAkxghVE2UY0eX68G12G54rW0gor4BG+RyGTyaQ0TWFiEcT
         57dnuzbUNWvvkCEcyHiRE89dHzzThN5uYG+9+kmI/gFRZI4p+D8bwo3SyXeT84RLIaN+
         nwTpJM9NnSwr0XlcBG/hnK40uU23VpuVeBJ16rnOUT6mZhpgEr1q5r6F37wuFwvbJBoZ
         PwDqavDjZ8TYvmfPWKYlxpJvIKyoPqRVgq//Ac4OXEYE4QHwjCxk9XNheSVxtxW/JBEr
         nTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OfQAD4iJff5S72ROYWIftuPre1dFw+nLdo1cHHx/NJo=;
        b=p4MWHweTIo0wr1bm2VKf7wVnfpFn1M69wnUBXOnNZor31wRkWWnXynYhhOljtRZgpj
         OXjnZ0eBSAV8mMlZ+osQtN6FC/I0yaJrC55ZaaqCkFAWbViSI9vzs67W8Bm8rflkx0rN
         N+pKi/4DyYm90M2OWgFtHv/NdtUS/LBNfkYb8XsKtJuXOBwKyOgMEL8Dol/KvUHaKAPm
         SM6eLE2N30+YwZxcAVjCvJMR5nZl2mEuIc8jhVpNsNnxEy/IaJdTZzcc9Vl5nNOD7NJv
         5IAnOr+6/Vw9Kt9zLz4lxObwFCJNa1Xe6crfOFyXj5UHvQh+Spj84XRdNMzHm1c3uFMy
         xrXQ==
X-Gm-Message-State: AOAM532EoxKjZYiUhhPgRi+aX/A17KwICbRcAK2P5ZNpC30InLPb0OwM
        KjFGfpCoJcFeTex36W2PyiA=
X-Google-Smtp-Source: ABdhPJwxXLQfMbeen4zsAejmi+5xMyT+l488SXWpIxjowemgyyl3WZ/yrBmNmLHApGJXCvr3ygVHPA==
X-Received: by 2002:a05:6214:2aa4:b0:440:f5fc:f1c4 with SMTP id js4-20020a0562142aa400b00440f5fcf1c4mr16082826qvb.104.1647934955158;
        Tue, 22 Mar 2022 00:42:35 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef00:8400:3d36:58a:667a:1da9? (p200300f6ef0084003d36058a667a1da9.dip0.t-ipconnect.de. [2003:f6:ef00:8400:3d36:58a:667a:1da9])
        by smtp.gmail.com with ESMTPSA id w17-20020ac857d1000000b002e19feda592sm12997495qta.85.2022.03.22.00.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 00:42:34 -0700 (PDT)
Message-ID: <bd7f7b9853cbea30740af14d29a46f1a9f93a2a7.camel@gmail.com>
Subject: Re: [PATCH] iio: core: WARN in case sample bits do not fit storage
 bits
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Tue, 22 Mar 2022 08:43:10 +0100
In-Reply-To: <30a13541-0ffb-a537-e943-3751b7fd316b@denx.de>
References: <20220320181542.168147-1-marex@denx.de>
         <YjhWIN6GsuhPskrs@smile.fi.intel.com>
         <8b6f00be-c520-45c3-4497-d0fc310ff52f@denx.de>
         <Yjijg7m+TnaMs519@smile.fi.intel.com>
         <30a13541-0ffb-a537-e943-3751b7fd316b@denx.de>
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

On Mon, 2022-03-21 at 20:46 +0100, Marek Vasut wrote:
> On 3/21/22 17:10, Andy Shevchenko wrote:
> > On Mon, Mar 21, 2022 at 03:46:51PM +0100, Marek Vasut wrote:
> > > On 3/21/22 11:40, Andy Shevchenko wrote:
> > > > On Sun, Mar 20, 2022 at 07:15:42PM +0100, Marek Vasut wrote:
> > > > > Add runtime check to verify whether storagebits are at least
> > > > > as big
> > > > > as shifted realbits. This should help spot broken drivers
> > > > > which may
> > > > > set realbits + shift above storagebits.
> > > > 
> > > > Thanks!
> > > > 
> > > > ...
> > > > 
> > > > > +                       /* Verify that sample bits fit into
> > > > > storage */
> > > > > +                       WARN_ON(channels[i].scan_type.storage
> > > > > bits <
> > > > > +                               channels[i].scan_type.realbit
> > > > > s +
> > > > > +                               channels[i].scan_type.shift);
> > > > 
> > > > Not sure WARN is a good level (it might be fatal on some setups
> > > > and we won't that),
> > > > besides the fact that we may use dev_WARN(). Perhaps dev_warn()
> > > > would suffice?
> > > 
> > > I was actually thinking about BUG(), but that might crash
> > > existing systems.
> > > I think we want a strong indicator that something wrong is going
> > > on which
> > > must be fixed and the splat produced by WARN_ON() is a good
> > > indicator of
> > > that. It also does not crash existing systems,
> > 
> > It does crash _some_ of them, unfortunately.
> 
> Details please ?
> 
> WARN_ON() shouldn't cause crash outright, or do I miss something ?

Arghh, completely forgot about this... Andy is right, maybe there are
other cases (in which case, it would be nice to share :D), but this one
is definitely one of them:

https://elixir.bootlin.com/linux/latest/source/kernel/panic.c#L579

You can have a cmdline parameter to panic on _WARN() and some systems
may have it.

That said, the "nice" stack_dump using WARN is way more explicit about
saying that something is seriously wrong and must be fixed. dev_warn()
is easier to ignore... But surely it is not nice to brick existing
systems.  

Not really sure here...

- Nuno Sá
