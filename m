Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6C24EDF8F
	for <lists+linux-iio@lfdr.de>; Thu, 31 Mar 2022 19:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiCaRXT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Mar 2022 13:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiCaRXP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 31 Mar 2022 13:23:15 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4091F0C96;
        Thu, 31 Mar 2022 10:21:26 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2e68c95e0f9so6742647b3.0;
        Thu, 31 Mar 2022 10:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DEwBC1O2sWIMQ/yd+TC2ZcExUMwvMfzRcdpkpoM5EA=;
        b=LDzUpFG8LvhaNRogfQHiSCJ+2CrCL4i9GAeLOCO4oo0hSmPpU0MMP+bT3qtQgFW3Di
         /jfV7OvfNg6STYOujNso5YENa3/IuJrmEtpri1N1xwXRu8Hvmv79slnrJFlKCJprj5UN
         lv4F0FmbWAvmDBrtoLhESTlftbv9d9mSVlxZXXGJARRKAFQ3NROYeAFHdA5z/YIcwwZ6
         MHB+21r9nkJFg0yG1WywaA0X1OdaeGfyulEKDYcKw0dTGBd5z43O0vZ1SH+bgUEDpbP+
         HLuosdMayeawiHXR3lllASU5WXJOCneVMAyde1QMZjD3tKxSnR8nGxlzaoABf97pLxKp
         gQgg==
X-Gm-Message-State: AOAM532wLnM0b2OcC97jMnf/Ii8UbFGP7Dwdta3JNYY/79AAFtehMZVE
        iKl05G98ffg0/hd/A6zTVA9YC8+A+L7cLfu3OSk=
X-Google-Smtp-Source: ABdhPJy9u2Dob6LDT/bQELypzvObVEXznR0ktRZIzvkuXclo2fZryJ3gwusyAUDjrxGo/jBNHqU1jlmMKM1Ll5uuRYg=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr5804359ywb.326.1648747285718; Thu, 31
 Mar 2022 10:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220220181522.541718-1-jic23@kernel.org> <20220220181522.541718-3-jic23@kernel.org>
 <6cd17744-d060-1094-098d-e30a10f96600@intel.com> <20220227114628.219c7055@jic23-huawei>
 <CAJZ5v0iwFJizKf-SEr10M-8HFirMzH8=LkONLvtZ30pfEk4AOA@mail.gmail.com>
 <20220301113145.00004ce4@Huawei.com> <20220330133037.000044b2@Huawei.com>
In-Reply-To: <20220330133037.000044b2@Huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Mar 2022 19:21:14 +0200
Message-ID: <CAJZ5v0j47Ub=kXU5ZB_JF35xwBtUuLCwiFyEw-+B=r5z-Ac78Q@mail.gmail.com>
Subject: Re: [PATCH 2/8] PM: core: Add NS varients of EXPORT[_GPL]_SIMPLE_DEV_PM_OPS
 and runtime pm equiv
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
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

Hi Jonathan,

On Wed, Mar 30, 2022 at 2:30 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 1 Mar 2022 11:31:45 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
> > On Mon, 28 Feb 2022 21:13:25 +0100
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >
> > > On Sun, Feb 27, 2022 at 12:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > > >
> > > > On Mon, 21 Feb 2022 20:37:57 +0100
> > > > "Rafael J. Wysocki" <rafael.j.wysocki@intel.com> wrote:
> > > >
> > > > Hi Rafael,
> > > > > CC: linux-pm
> > > >
> > > > Oops. Stupid omission on my part, sorry about that!
> > > >
> > > > >
> > > > > On 2/20/2022 7:15 PM, Jonathan Cameron wrote:
> > > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > >
> > > > > > As more drivers start to use namespaces, we need to have varients of these
> > > > > > useful macros that allow the export to be in a particular namespace.
> > > > > >
> > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > Cc: Paul Cercueil <paul@crapouillou.net>
> > > > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > I'd rather route this through linux-pm unless you have dependent changes.
> > > >
> > > > Ok.
> > > >
> > > > The kxsd9 patch (4) is dependent on other changes queued for
> > > > the merge window in IIO. If we want to do it through linux-pm I'd
> > > > love it if we can manage to get the ground work in for the coming merge window.
> > > >
> > > > So options are:
> > > >
> > > > 1) This patch alone via linux-pm and I queue the users up for next cycle
> > > >    Fine by me but always awkward to have infrastructure with no users.
> > > > 2) First 3 patches via linux-pm so we have a user (scd30) in a low churn
> > > >    driver and I'll queue the rest for 5.19.  Fine by me as well.
> > > >    That goes on cleanly on 5.17-rc1 and there is nothing else in my review
> > > >    queue touching that driver.
> > >
> > > That would work for me.
> >
> > Great.  Let's do that then.  Are you fine picking them from this thread, or
> > would you like me to resend with just those 3 patches as a fresh series?
> Hi Rafael,
>
> I've not heard back from you, so have been assuming you'd pick those first
> 3 patches up from this series.  Is that a correct assumption?

This was my intention, but then I lost track of them and now I can't
find them in the linux-pm Patchwork.  Sorry about this.

Can you please resend just the 3 patches?

Thanks!
