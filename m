Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519EF2EBD25
	for <lists+linux-iio@lfdr.de>; Wed,  6 Jan 2021 12:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbhAFL1v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Jan 2021 06:27:51 -0500
Received: from foss.arm.com ([217.140.110.172]:39588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbhAFL1v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 6 Jan 2021 06:27:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26B88D6E;
        Wed,  6 Jan 2021 03:27:05 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E2E03F719;
        Wed,  6 Jan 2021 03:27:02 -0800 (PST)
Date:   Wed, 6 Jan 2021 11:26:59 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        sudeep.holla@arm.com, egranata@google.com,
        mikhail.golubev@opensynergy.com, Igor.Skalkin@opensynergy.com,
        Peter.hilber@opensynergy.com, ankitarora@google.com
Subject: Re: Reply to [RFC PATCH v2 0/1] Adding support for IIO SCMI based
 sensors
Message-ID: <20210106112659.GA9138@e120937-lin>
References: <20201230123748.4e969f82@archlinux>
 <20210105230920.769144-1-jbhayana@google.com>
 <20210106102917.0000332c@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106102917.0000332c@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

On Wed, Jan 06, 2021 at 10:29:17AM +0000, Jonathan Cameron wrote:
> On Tue, 5 Jan 2021 23:09:20 +0000
> Jyoti Bhayana <jbhayana@google.com> wrote:
> 
> > Hi Jonathan,
> > 
> > > So, sensor_max_range can effectively be exposed as a combination of
> > > scale and the *_raw_avail for a raw read (via the read_avail callback in IIO).
> > > We'll ignore the fact the interface assumes a single value (so I assume symmetric?)  
> > 
> > Based on the SCMI specification the sensor min range and max range are 64 bits signed number.
> > 
> > looks like IIO_AVAIL_RANGE can only take the following
> > types of data which all looks like 32 bit. IIO_VAL_FRACTIONAL
> > also takes two int type numbers.
> > How can I send 64 bit sensor range using this and read_avail callback?
> > 
> > #define IIO_VAL_INT 1
> > #define IIO_VAL_INT_PLUS_MICRO 2
> > #define IIO_VAL_INT_PLUS_NANO 3
> > #define IIO_VAL_INT_PLUS_MICRO_DB 4
> > #define IIO_VAL_INT_MULTIPLE 5
> > #define IIO_VAL_FRACTIONAL 10
> > #define IIO_VAL_FRACTIONAL_LOG2 11
> > #define IIO_VAL_CHAR 12
> 
> Hmm It is a bit unfortunate that SCMI decided to pretend that real sensor resolutions were
> greater than 32 bits. I doubt they will ever actually be any (as such accurate measurements
> are completely pointless) and they aren't anywhere near that today.  Only way it might end
> up looking a bit like that would be result of a highly non linear sensor being shoved through
> an interface that pretends it isn't (goody).
> 

We shared this info internally to involve our architects about this.

> Having said that, specifications are what they are and we have to cope with that.
> 
> There is no real problem with defining a new value type except for the fact that any
> legacy userspace won't necessarily expect to see values that large. Given we need the full
> 64 bits it would have to be something like
> IIO_VAL_INT_H32_L32 with the 64 bit values split up appropriately and put back together
> at time of formatting.   Not particularly pretty but I'm not keep to put that much effort
> in to support something like this for one driver (so not interesting in changing that
> the read_raw_* interfaces)
> 

Regarding the current spec and this IIODEV limit to 32bit, I was thinking about
the following horrid thing (:D) as a solution: given that as of now no sensor
exist in real life reporting bigger than 32bits values, instead of adding new
defines in IIODEV framework to support 64bit that no userspace is expecting and
no sensor will really emit ever in the foreseable future, couldn't this SCMI
IIODEV driver simply:

- truncate silently straight away 64bit vals into 32bit when detects
  that he upper MSB 32bit are unused (zeros or sign-extension) and in
  fact the values fits into 32bits

- WARN and do not truncate if the upper MSB 32bit are in fact valid because
  such a 64bit capable sensor was indeed used finally (at that point in time
  IIODEV driver and framework will need a 64bit update)

Or I am missing something ?

Feel free to insult me about this hack ... :D 

Thanks

Cristian

> Jonathan
>  
> 
> > 
> > 
> > 
> > Thanks,
> > Jyoti
> > 
> 
