Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF84931B7DE
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 12:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBOLSn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 06:18:43 -0500
Received: from foss.arm.com ([217.140.110.172]:35826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhBOLSj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Feb 2021 06:18:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99FF01FB;
        Mon, 15 Feb 2021 03:17:52 -0800 (PST)
Received: from bogus (unknown [10.57.11.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40CA13F40C;
        Mon, 15 Feb 2021 03:17:50 -0800 (PST)
Date:   Mon, 15 Feb 2021 11:17:30 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
        Ankit Arora <ankitarora@google.com>
Subject: Re: [PATCH v5 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <20210215111730.4tuuuxhjcyqrobea@bogus>
References: <20210208211918.1280588-1-jbhayana@google.com>
 <20210208211918.1280588-2-jbhayana@google.com>
 <20210209115639.GC6873@e120937-lin>
 <CA+=V6c12nRxLCxM2DPst8RV=i+1WatPyHcQQZp4xAzuoN0vKaw@mail.gmail.com>
 <20210210214619.GD6873@e120937-lin>
 <20210212191850.0748ccdb@archlinux>
 <20210215092526.GA29356@e120937-lin>
 <20210215110756.28567df8@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210215110756.28567df8@archlinux>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 15, 2021 at 11:07:56AM +0000, Jonathan Cameron wrote:
> Hi Cristian,
>
> So this driver will also be 5.13 material now (merge window for IIO effectively
> closes 1-2 weeks before Linus opens the main one).
>

I guessed so.

> The way we normally handle cases like this where we likely to have dependencies
> on a patch set from two separate directions is to do what is known as an
> immutable branch.  This is a branch that would probably be based on 5.12-rc1
> containing just this driver.
>

Make sense.

> Then both trees, in this case IIO and scmi merge that branch.  The magic
> of git then means that when Linus gets the eventual pull requests for
> the two trees, the git IDs and content will be the same and the history
> of that particular set of files will be cleanly maintained.
>
> This happens quite a lot for certain parts of the kernel because there are
> a lot of cross dependencies.
>
> @Sudeep, that work for you?  Have to wait for 5.12-rc1 though to give
> us a sensible base.
>

Since this is just one patch, I can pull in the immutable branch if you
could share and then Cristian can make appropriate changes needed for his
series on top of that unless you want to merge 30+ patches that I might
have with Cristain series 😉.

In short I am happy to pull in your immutable branch and I agree 5.12-rc1
is sensible base.

--
Regards,
Sudeep
