Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9580318E431
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 21:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCUUTC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 16:19:02 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37865 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgCUUTC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 16:19:02 -0400
Received: by mail-pj1-f67.google.com with SMTP id o12so326478pjs.2;
        Sat, 21 Mar 2020 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJ0AgRbEJoFommdqX1eg2v1GRS9pD6sawkpvA/Zb67c=;
        b=oas0AV1oe5ksIUibU59v1KUrsf9zvET7zdNxvM5R+n9/H+28L89s5Fd0z/PQiRQKKE
         Axr7wppUYJZ5w30AL29RJDaxCXRgpDYyzlRRHYw3DTV016dkyKE+PlP8djs9vLwTPZRj
         wacAEaeDlRWzP4lop/OSnMxzY9VxsZQpHLqrO3gzVORt87qoTEZegQrcOws+X7JgmlWr
         7c/sfJsV7h1AlIOVlHlvgPkbx83pkQ2S7tdefrVBWjBOSWvfsindexUd730Z/pclJlwU
         zgBa7NsSHAAc52rLqbd57qCch0GWItr0Fvhc3GLh1J7WRPb9jNwIsV1cCM7NnVMYZDM+
         g2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJ0AgRbEJoFommdqX1eg2v1GRS9pD6sawkpvA/Zb67c=;
        b=Gy8wezHxjVJv1Quaeuab/hbYzXZB3Fp02ZOAvxSrluuwqngF7zDdKy/1++y644NjVD
         piA7gN9Ja1oHZCEbMtxi5YobwVcmpkmtIfupfbmVsM482npC3PzH6PgkvFvdlj8L3uqo
         mhchvN3idIuxRIGszH+w9MYyuqwT0S/8DaUAMPAR6xaucitVJkf7jdONAYgoD8mXpgrd
         x7d2SEwXW6EisENF6LEG6Wh1Zgi6HXaucJDL70HhnG1eKr+U1zzRFN3nkR5E5ZKMeAKX
         dgW4nHSBAYX5Y4vuWxAIP4XRDAmS0nUmg83/HRkOwOg45zQ+4y2Q0JyGHhUWbWkDqcpT
         Egmg==
X-Gm-Message-State: ANhLgQ2PO6mTY88Q2KOYJLQIScrsvQdb/zhFn+13CdbrJwv6VkDe2DfL
        vcI9CVQcTIX9Bk/TmDBMF++vHow9WJe7TVrkxoA=
X-Google-Smtp-Source: ADFU+vvLvwI30YSioHW9jCG7YRT4vp3Bo1OO5Jz61Wu8AqozjSPXCfyA6nh7vCsBj7upjsgK/dxSqP0i7n+9QZiJQM0=
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr14443053plf.255.1584821941371;
 Sat, 21 Mar 2020 13:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200317143336.6098-1-alexandru.ardelean@analog.com>
 <20200321194859.GA2813896@smile.fi.intel.com> <c026dcc85e8454a1ea191c20ba03ce2072271af9.camel@perches.com>
In-Reply-To: <c026dcc85e8454a1ea191c20ba03ce2072271af9.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 21 Mar 2020 22:18:49 +0200
Message-ID: <CAHp75VcAo4qHvFyVkv3Keq63XD_HfSvJ=1LBbxYTM0kYGWJh_g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove Stefan Popa's email
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 21, 2020 at 10:11 PM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2020-03-21 at 21:48 +0200, Andy Shevchenko wrote:
> > On Tue, Mar 17, 2020 at 04:33:36PM +0200, Alexandru Ardelean wrote:
> > > The email is no longer active. This change removes Stefan's email from the
> > > MAINTAINERS list and replaces it with Michael Hennerich's.
> > >
> >
> > Are you planning to fix entries as parse-maintainers.pl does?
> > (Maybe in a separate change, but also why not here)
>
> I think perhaps you should not ask people to use parse-maintainers
> on specific sections anymore as it's rather confusing to use and
> it's best done as a one-shot by Linus one day.  I hope soon.

Why not? The benefits are
 - people will know about the tool
 - the particular sections will be fixed since they are touching the data base

And it doesn't prevent Linus or anybody to run the script in the future.

Actually it will teach people ahead to use the tool then in the future
we won't see such drastic deviation in ordering.

-- 
With Best Regards,
Andy Shevchenko
