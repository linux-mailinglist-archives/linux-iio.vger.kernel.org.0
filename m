Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9439C3300AC
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 13:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhCGMFO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 07:05:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhCGMFB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Mar 2021 07:05:01 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C7646501E;
        Sun,  7 Mar 2021 12:04:59 +0000 (UTC)
Date:   Sun, 7 Mar 2021 12:04:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [RFC PATCH 2/7] iio:ABI docs: Avoid repitition of
 triggerX/sampling_frequency
Message-ID: <20210307120451.79e538fc@archlinux>
In-Reply-To: <c6fb25c0-1292-f5fa-c5c9-8e47d1061874@metafoo.de>
References: <20210117153816.696693-1-jic23@kernel.org>
        <20210117153816.696693-3-jic23@kernel.org>
        <c6fb25c0-1292-f5fa-c5c9-8e47d1061874@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 7 Mar 2021 10:40:18 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 1/17/21 4:38 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > The timer-stm32 provided a little more specific information than the main
> > docs about the value of 0 corresponding to stopping sampling.  Given that
> > this makes sense in general, move that statement over to the main docs
> > and drop the version in sysfs-bus-iio-timer-stm32
> >
> > Fixes
> > $ scripts/get_abi.pl validate
> > /sys/bus/iio/devices/triggerX/sampling_frequency is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:92  ./Documentation/ABI/testing/sysfs-bus-iio:45
> >
> > Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> > Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   Documentation/ABI/testing/sysfs-bus-iio             | 2 ++
> >   Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 | 8 --------
> >   2 files changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index d2dd9cc280f9..9b5ceb22363d 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -55,6 +55,8 @@ Description:
> >   		direct access interfaces, it may be found in any of the
> >   		relevant directories.  If it affects all of the above
> >   		then it is to be found in the base device directory.
> > +		Note a value 0 where supported, will correspond to sampling
> > +		stopping.  
> 
> Hm, I don't like this. 0 should be an invalid value for the standard 
> ABI. Enabling/disabling of the trigger should be controlled by whether 
> there are any active trigger consumers.
> 
> The stm32-timer-trigger implements a non-standard ABI and I think we 
> need to document this explicitly. The driver does not have a set_state 
> callback. So the frequency property is used to enable/disable the 
> trigger, but as said above, for standard compliant triggers that should 
> not be the case.
> 
Good point.  Ideally we'd also fix the stm32-timer-trigger to have
an explicit enable / disable (even if that works by setting the frequency
to 0 under the hook)

For now I've dropped the patch until this is resolved.

Thanks,

Jonathan


