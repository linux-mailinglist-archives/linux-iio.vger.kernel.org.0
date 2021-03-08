Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD4D3317B4
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 20:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhCHTtG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 14:49:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231734AbhCHTss (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Mar 2021 14:48:48 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED5364F11;
        Mon,  8 Mar 2021 19:48:45 +0000 (UTC)
Date:   Mon, 8 Mar 2021 19:48:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jyoti Bhayana <jbhayana@google.com>,
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
Subject: Re: [PATCH v6 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <20210308194841.525ed61f@archlinux>
In-Reply-To: <20210308042842.e6qr4xxp5tl5ahos@bogus>
References: <20210212172235.507028-1-jbhayana@google.com>
        <20210212172235.507028-2-jbhayana@google.com>
        <20210221144616.4eef6a79@archlinux>
        <CA+=V6c1aKy1nPDMJ+mhB6drUEs6T7SVKon8chH++6Zv1dkv+GA@mail.gmail.com>
        <20210308042842.e6qr4xxp5tl5ahos@bogus>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Mar 2021 04:28:42 +0000
Sudeep Holla <sudeep.holla@arm.com> wrote:

> Hi Jonathan,
> 
> On Tue, Feb 23, 2021 at 10:30:37AM -0800, Jyoti Bhayana wrote:
> > Hi Jonathan,
> >
> > Thanks for the detailed and careful review of this patch. Good to hear
> > that v7 is not required.   Please find below answers to your
> > questions. Looking forward to seeing this patch merged in the next
> > cycle. Thanks for your help in making this happen.
> >  
> 
> Any update on this ? Please share the branch with is patch so that I
> can pull and ask Cristian to make his changes on top.
Running a bit behind at the moment.

Anyhow, there should now be an ib-iio-scmi-5.12-rc1 branch
on https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Includes making the various long long local variables explicitly
s64 and u64 as relevant.

Based on the rc1 that eats babies so handle with care :)

I've also merge this into the togreg branch of iio.git.
As explained above that wasn't entirely trivial so Jyoti
please take a quick look and check that changes are fine.
Pushed out as testing to let the autobuilders poke at it.
Assuming they don't find anything, it should be fine
for Sudeep to merge that ib and everything will unwind
nicely in Linus' tree next cycle.

There is a bit of an ongoing discussion of an earlier patch
in the IIO tree, so I might end up redoing this merge
if I need to rebase to sort that out, but I'll make sure
the diff is the same (git ID might change).

Thanks,

Jonathan

> 
> --
> Regards,
> Sudeep

