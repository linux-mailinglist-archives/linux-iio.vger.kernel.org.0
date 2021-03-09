Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B552331F55
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 07:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhCIGh5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 01:37:57 -0500
Received: from foss.arm.com ([217.140.110.172]:47808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhCIGhf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 9 Mar 2021 01:37:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32A74D6E;
        Mon,  8 Mar 2021 22:37:35 -0800 (PST)
Received: from bogus (unknown [10.57.20.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8C7D3F70D;
        Mon,  8 Mar 2021 22:37:29 -0800 (PST)
Date:   Tue, 9 Mar 2021 06:37:27 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jyoti Bhayana <jbhayana@google.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
Subject: Re: [PATCH v6 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <20210309063727.a4olkoha5jernvwx@bogus>
References: <20210212172235.507028-1-jbhayana@google.com>
 <20210212172235.507028-2-jbhayana@google.com>
 <20210221144616.4eef6a79@archlinux>
 <CA+=V6c1aKy1nPDMJ+mhB6drUEs6T7SVKon8chH++6Zv1dkv+GA@mail.gmail.com>
 <20210308042842.e6qr4xxp5tl5ahos@bogus>
 <20210308194841.525ed61f@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308194841.525ed61f@archlinux>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 08, 2021 at 07:48:41PM +0000, Jonathan Cameron wrote:
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

No worries.

> Anyhow, there should now be an ib-iio-scmi-5.12-rc1 branch
> on https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>

Thanks

> Includes making the various long long local variables explicitly
> s64 and u64 as relevant.
>
> Based on the rc1 that eats babies so handle with care :)
>

😁 

> I've also merge this into the togreg branch of iio.git.
> As explained above that wasn't entirely trivial so Jyoti
> please take a quick look and check that changes are fine.
> Pushed out as testing to let the autobuilders poke at it.
> Assuming they don't find anything, it should be fine
> for Sudeep to merge that ib and everything will unwind
> nicely in Linus' tree next cycle.
>

Hope so.

> There is a bit of an ongoing discussion of an earlier patch
> in the IIO tree, so I might end up redoing this merge
> if I need to rebase to sort that out, but I'll make sure
> the diff is the same (git ID might change).
>

I can wait for a week or 2 if you think things will settle down by then.
We can avoid 2 different git IDs if possible. The main intention was to
give some reference to Cristian to rebase/post his series. I am all
fine to wait for a week or 2 for final branch.

--
Regards,
Sudeep
