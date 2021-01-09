Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0544A2F0301
	for <lists+linux-iio@lfdr.de>; Sat,  9 Jan 2021 20:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbhAITCV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jan 2021 14:02:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbhAITCV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Jan 2021 14:02:21 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6C602399A;
        Sat,  9 Jan 2021 19:01:37 +0000 (UTC)
Date:   Sat, 9 Jan 2021 19:01:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jyoti Bhayana <jbhayana@google.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        egranata@google.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, Peter.hilber@opensynergy.com,
        ankitarora@google.com
Subject: Re: Reply to [RFC PATCH v2 0/1] Adding support for IIO SCMI based
 sensors
Message-ID: <20210109190133.61051fab@archlinux>
In-Reply-To: <20210106212353.951807-1-jbhayana@google.com>
References: <20210106161233.GA44413@e120937-lin>
        <20210106212353.951807-1-jbhayana@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  6 Jan 2021 21:23:53 +0000
Jyoti Bhayana <jbhayana@google.com> wrote:

> Hi Jonathan,
> 
> Instead of adding IIO_VAL_INT_H32_L32, I am thinking of adding IIO_VAL_FRACTIONAL_LONG
> or IIO_VAL_FRACTIONAL_64 as the scale/exponent used for min/max range can be different
> than the one used in resolution according to specification. 

That's somewhat 'odd'.  Given min/max are inherently values the sensor is supposed to
be able to return why give them different resolutions?  Can you point me at a specific
section of the spec?  The axis_min_range_low etc fields don't seem to have units specified
but I assumed they were in sensor units and so same scale factors?

> 
> I am planning to use read_avail for IIO_CHAN_INFO_PROCESSED using IIO_AVAIL_RANGE 
> and this new IIO_VAL_FRACTIONAL_64 for min range,max range and resolution.
> Instead of two values used in IIO_VAL_FRACTIONAL, IIO_VAL_FRACTIONAL_64 will use 4 values
> val_high,val_low,and val2_high and val2_low.

I'm not keen on the changing that internal kernel interface unless we absolutely
have to.  read_avail() is called from consumer drivers and they won't know anything
about this new variant.

> 
> Let me know if that is an acceptable solution.

Hmm. It isn't a standard use of the ABI given the value in the buffer is (I assume)
raw (needs scale applied).  However, it isn't excluded by the ABI docs.  Whether
a standard userspace is going to expect it is not clear to me.

I don't want to end up in a position where we end up with available being generally
added for processed when what most people care about is what the value range they
might get from a polled read is (rather than via a buffer).

So I'm not that keen on this solution but if we can find a way to avoid it.

Jonathan


> 
> 
> Thanks,
> Jyoti
> 

