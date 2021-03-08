Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DEA3319CC
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 22:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhCHV4U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 16:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhCHV4A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 16:56:00 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0579C06174A
        for <linux-iio@vger.kernel.org>; Mon,  8 Mar 2021 13:56:00 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so3801328pjc.2
        for <linux-iio@vger.kernel.org>; Mon, 08 Mar 2021 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U6vx5H19Z/O1TnXd/t+CXw4LK6hHo0WtPQwXZKiOmm8=;
        b=UHRPWU+DnioGx4ycir9gGdEmH/2nSbShB7cGtND/lVTbYw0DeZI3lUfVclsbwMbtDc
         raQx/zYjrgIj+FTM0rMArI2uQzOHyG/WRcbuk/2CvDCANNe1UuC+iVi+29VxhZYz+ZUN
         3a58Ol8boRuQGBY+y2xLcwp7PLrWbIvAy/o5gASjAhavLubHv80JB2JeLue1QDx17n7l
         E/V8rcdd5sHwsdvc2rL/rcFK5AD7gJa5xLlfH/Eckmc6ZQyeSF++jKvR3VTmLKA1alDR
         MxDLe2sAg3gzDDwpYXmHo+1TThU0h4SpeUfuzzAStms2KZmy4QM+rHMBuG4ZxH0LhPgX
         Ffgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6vx5H19Z/O1TnXd/t+CXw4LK6hHo0WtPQwXZKiOmm8=;
        b=Z/aCGteZDgAwVe0Gwi2KT+DyiU4c/ogm0aFAiUcEwR7LCYXC6cHDXYMS2WXgxO4pf4
         IXwER8m2Kz0w11FUApI0NoV4LMntAywC/3WmZgXjB+GEz/BEtlAlfd3wZIfUODXB6qPS
         eS6T5xL637L8hA/+nggP2Fw7YkGQ6AYmMxYbS2zy3xmPI8EyH0Tq6kXSe91+am/RpeCC
         xs4XggAFJ0DCT4BfNq7B6e2CeoFqFa4bSH1r8tlDtuQiCxPnSD2Jynu9HmCAZY25o83B
         7PtJDut8l2HeDVk1EW0iJ10v5UFJuAJA/NuUH0lT+AioT5t5zdPw+7YBPNbtkcgJ+J14
         3z8A==
X-Gm-Message-State: AOAM532XePIk0iwDTugXO8cr4+q8qAnf3C8H+YLjWuhKjxsjy/XMbie2
        pz86HHmToJO7pBdX6CafVUhnTdcE87tGxQDSsGR+ig==
X-Google-Smtp-Source: ABdhPJzjXmi4G6MSuxOSRUfpJUFYTBQWvzZUKsHrFVVnWspoeFmSsV9qMPBg7fDiUHar0J3Xdur5PBF4YKhZKVizP8o=
X-Received: by 2002:a17:902:c589:b029:e6:3a39:d4a0 with SMTP id
 p9-20020a170902c589b02900e63a39d4a0mr3859480plx.76.1615240559998; Mon, 08 Mar
 2021 13:55:59 -0800 (PST)
MIME-Version: 1.0
References: <20210212172235.507028-1-jbhayana@google.com> <20210212172235.507028-2-jbhayana@google.com>
 <20210221144616.4eef6a79@archlinux> <CA+=V6c1aKy1nPDMJ+mhB6drUEs6T7SVKon8chH++6Zv1dkv+GA@mail.gmail.com>
 <20210308042842.e6qr4xxp5tl5ahos@bogus> <20210308194841.525ed61f@archlinux>
In-Reply-To: <20210308194841.525ed61f@archlinux>
From:   Jyoti Bhayana <jbhayana@google.com>
Date:   Mon, 8 Mar 2021 13:55:49 -0800
Message-ID: <CA+=V6c1aZMTOcqK21wQtqtmzxd-aY_ng+=02P+Z_nYQbJvro1w@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] iio/scmi: Adding support for IIO SCMI Based Sensors
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Enrico Granata <egranata@google.com>,
        Mikhail Golubev <mikhail.golubev@opensynergy.com>,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>,
        Peter Hilber <Peter.hilber@opensynergy.com>,
        Ankit Arora <ankitarora@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

I looked at ib-iio-scmi-5.12-rc1 branch and the changes look good to
me. Once again, thanks for all your help.

Thanks,
Jyoti


On Mon, Mar 8, 2021 at 11:48 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 8 Mar 2021 04:28:42 +0000
> Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> > Hi Jonathan,
> >
> > On Tue, Feb 23, 2021 at 10:30:37AM -0800, Jyoti Bhayana wrote:
> > > Hi Jonathan,
> > >
> > > Thanks for the detailed and careful review of this patch. Good to hear
> > > that v7 is not required.   Please find below answers to your
> > > questions. Looking forward to seeing this patch merged in the next
> > > cycle. Thanks for your help in making this happen.
> > >
> >
> > Any update on this ? Please share the branch with is patch so that I
> > can pull and ask Cristian to make his changes on top.
> Running a bit behind at the moment.
>
> Anyhow, there should now be an ib-iio-scmi-5.12-rc1 branch
> on https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>
> Includes making the various long long local variables explicitly
> s64 and u64 as relevant.
>
> Based on the rc1 that eats babies so handle with care :)
>
> I've also merge this into the togreg branch of iio.git.
> As explained above that wasn't entirely trivial so Jyoti
> please take a quick look and check that changes are fine.
> Pushed out as testing to let the autobuilders poke at it.
> Assuming they don't find anything, it should be fine
> for Sudeep to merge that ib and everything will unwind
> nicely in Linus' tree next cycle.
>
> There is a bit of an ongoing discussion of an earlier patch
> in the IIO tree, so I might end up redoing this merge
> if I need to rebase to sort that out, but I'll make sure
> the diff is the same (git ID might change).
>
> Thanks,
>
> Jonathan
>
> >
> > --
> > Regards,
> > Sudeep
>
