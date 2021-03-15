Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7095C33B4CB
	for <lists+linux-iio@lfdr.de>; Mon, 15 Mar 2021 14:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhCONmM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Mar 2021 09:42:12 -0400
Received: from foss.arm.com ([217.140.110.172]:41410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhCONmF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Mar 2021 09:42:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F0261FB;
        Mon, 15 Mar 2021 06:42:04 -0700 (PDT)
Received: from bogus (unknown [10.163.67.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3BF43F792;
        Mon, 15 Mar 2021 06:41:58 -0700 (PDT)
Date:   Mon, 15 Mar 2021 13:41:50 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jyoti Bhayana <jbhayana@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Enrico Granata <egranata@google.com>,
        Mikhail Golubev <mikhail.golubev@opensynergy.com>,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>,
        Peter Hilber <Peter.hilber@opensynergy.com>,
        Ankit Arora <ankitarora@google.com>,
        Guru Nagarajan <gurunagarajan@google.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <20210315134150.kq3b22dnzbtldihy@bogus>
References: <20210309231259.78050-1-jbhayana@google.com>
 <20210309231259.78050-2-jbhayana@google.com>
 <20210311210844.34371d8d@archlinux>
 <20210312121639.00001c31@Huawei.com>
 <20210312133101.GG30179@e120937-lin>
 <CA+=V6c0boA1Q+k4rM0NOcK4ek_FYU7omEWhvMowqACH_t44sAQ@mail.gmail.com>
 <20210313171107.4c8215e7@archlinux>
 <CA+=V6c0a8z9+gkD_M6KNviN-VActtmpTgkuCBn-sgC4Fm2C6QA@mail.gmail.com>
 <20210314154033.3facf1a2@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314154033.3facf1a2@archlinux>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sun, Mar 14, 2021 at 03:40:33PM +0000, Jonathan Cameron wrote:
> On Sat, 13 Mar 2021 11:55:39 -0800
> Jyoti Bhayana <jbhayana@google.com> wrote:
>
> > Hi Jonathan,
> >
> > I still see the old version 6 in ib-iio-scmi-5.12-rc2-take2 as well.
>
> OK. I'm completely confused as to what is going with my local tree.
> I have the right patch in the history but it didn't end up in the final
> pushed out version.  Fat finger mess-up I guess and too many similarly named
> branches and the fact I didn't check the final result closely enough.
>
> There is now an ib-iio-scmi-5.12-rc2-take3 branch
>

I have now used this for my for-next/scmi branch. It is not final yet,
just pushed out for bots to build test and get into -next. Let me know
if you have plans to change/rework this branch, I can update it anytime
till end of this week to avoid multiple hashes.

--
Regards,
Sudeep
