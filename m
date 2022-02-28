Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89D04C79FE
	for <lists+linux-iio@lfdr.de>; Mon, 28 Feb 2022 21:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiB1UO0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Feb 2022 15:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiB1UOV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Feb 2022 15:14:21 -0500
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE496312;
        Mon, 28 Feb 2022 12:13:37 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2d6d0cb5da4so121706157b3.10;
        Mon, 28 Feb 2022 12:13:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1gNUi++w9jmdAT4TpUHXeBfIhOS/MlJVW6bUq+SZ7M=;
        b=L9capcuXb5dsuR0sbfD3yOZDpkjvzdPU+7pkzyOwsr2UmcLs7shgn/yVbFWGWqEGjD
         k7WPKFXKNp/JqcmG/M02jXsH9TFEZ98XEQ2fJboSzjRusJ0VwDxp1ECkAtBdGiWJbEb4
         TtU1aR12bHbw9ynlrhv/HRph+scub4YKOXEIexqtd5EUnn6PMb75VYcpz/JsI9yfzOJg
         78Z/FHDMuc0oLDR/f/5DkQBkh8ZeovPdffhOEHRuA6mA4GUz/rrM7L352VG9sAByY9lV
         1gE7P+g43U6+Vqg0ULBZnQs0n6fSOvrCQf/pGA2ESTvxBQGV2jhGuqyPRp8VZu/K3XV2
         LgSQ==
X-Gm-Message-State: AOAM532WcmSf9VMEIfU4T6/GoSTraA1/3wkTPf6LoBCWatNe8JGTuLWd
        +hXb3YAyoW6uDguO2G5hLfm/f13SD/UK5FRNC5A=
X-Google-Smtp-Source: ABdhPJwgOy8cKMEV7DdF8wEo1m85qBE5OKhfI4UIKaRKwJTPQgeaDbfJdRd1rWJDrD+o9MheZAj4t2+x8NHEmUwnqWc=
X-Received: by 2002:a81:1611:0:b0:2d6:3290:9bd3 with SMTP id
 17-20020a811611000000b002d632909bd3mr21933149yww.19.1646079216535; Mon, 28
 Feb 2022 12:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20220220181522.541718-1-jic23@kernel.org> <20220220181522.541718-3-jic23@kernel.org>
 <6cd17744-d060-1094-098d-e30a10f96600@intel.com> <20220227114628.219c7055@jic23-huawei>
In-Reply-To: <20220227114628.219c7055@jic23-huawei>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 28 Feb 2022 21:13:25 +0100
Message-ID: <CAJZ5v0iwFJizKf-SEr10M-8HFirMzH8=LkONLvtZ30pfEk4AOA@mail.gmail.com>
Subject: Re: [PATCH 2/8] PM: core: Add NS varients of EXPORT[_GPL]_SIMPLE_DEV_PM_OPS
 and runtime pm equiv
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 27, 2022 at 12:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 21 Feb 2022 20:37:57 +0100
> "Rafael J. Wysocki" <rafael.j.wysocki@intel.com> wrote:
>
> Hi Rafael,
> > CC: linux-pm
>
> Oops. Stupid omission on my part, sorry about that!
>
> >
> > On 2/20/2022 7:15 PM, Jonathan Cameron wrote:
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > As more drivers start to use namespaces, we need to have varients of these
> > > useful macros that allow the export to be in a particular namespace.
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Paul Cercueil <paul@crapouillou.net>
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > I'd rather route this through linux-pm unless you have dependent changes.
>
> Ok.
>
> The kxsd9 patch (4) is dependent on other changes queued for
> the merge window in IIO. If we want to do it through linux-pm I'd
> love it if we can manage to get the ground work in for the coming merge window.
>
> So options are:
>
> 1) This patch alone via linux-pm and I queue the users up for next cycle
>    Fine by me but always awkward to have infrastructure with no users.
> 2) First 3 patches via linux-pm so we have a user (scd30) in a low churn
>    driver and I'll queue the rest for 5.19.  Fine by me as well.
>    That goes on cleanly on 5.17-rc1 and there is nothing else in my review
>    queue touching that driver.

That would work for me.

> I'm also interested to hear your view on the discussion going on in reply
> to the cover letter. Specifically Paul suggested we 'only' have the
> namespaced versions of these macros.

Well, I'm a bit afraid that providing the namespaced versions only
would slow down the adoption.
