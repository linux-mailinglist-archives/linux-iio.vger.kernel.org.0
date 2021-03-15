Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC16F33AFAB
	for <lists+linux-iio@lfdr.de>; Mon, 15 Mar 2021 11:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhCOKOF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Mar 2021 06:14:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2694 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhCOKNg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Mar 2021 06:13:36 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DzXFT64JJz67yxZ;
        Mon, 15 Mar 2021 18:09:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 15 Mar 2021 11:13:32 +0100
Received: from localhost (10.47.90.207) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 15 Mar
 2021 10:13:32 +0000
Date:   Mon, 15 Mar 2021 10:12:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [RFC PATCH 2/7] iio:ABI docs: Avoid repitition of
 triggerX/sampling_frequency
Message-ID: <20210315101217.00002c50@Huawei.com>
In-Reply-To: <079601f7-2d9e-6a01-13a0-4cb7014b2a6a@foss.st.com>
References: <20210117153816.696693-1-jic23@kernel.org>
        <20210117153816.696693-3-jic23@kernel.org>
        <c6fb25c0-1292-f5fa-c5c9-8e47d1061874@metafoo.de>
        <20210307120451.79e538fc@archlinux>
        <079601f7-2d9e-6a01-13a0-4cb7014b2a6a@foss.st.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.207]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Mar 2021 17:56:50 +0100
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 3/7/21 1:04 PM, Jonathan Cameron wrote:
> > On Sun, 7 Mar 2021 10:40:18 +0100
> > Lars-Peter Clausen <lars@metafoo.de> wrote:
> >   
> >> On 1/17/21 4:38 PM, Jonathan Cameron wrote:  
> >>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>
> >>> The timer-stm32 provided a little more specific information than the main
> >>> docs about the value of 0 corresponding to stopping sampling.  Given that
> >>> this makes sense in general, move that statement over to the main docs
> >>> and drop the version in sysfs-bus-iio-timer-stm32
> >>>
> >>> Fixes
> >>> $ scripts/get_abi.pl validate
> >>> /sys/bus/iio/devices/triggerX/sampling_frequency is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:92  ./Documentation/ABI/testing/sysfs-bus-iio:45
> >>>
> >>> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> >>> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>> ---
> >>>   Documentation/ABI/testing/sysfs-bus-iio             | 2 ++
> >>>   Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 | 8 --------
> >>>   2 files changed, 2 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> >>> index d2dd9cc280f9..9b5ceb22363d 100644
> >>> --- a/Documentation/ABI/testing/sysfs-bus-iio
> >>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> >>> @@ -55,6 +55,8 @@ Description:
> >>>   		direct access interfaces, it may be found in any of the
> >>>   		relevant directories.  If it affects all of the above
> >>>   		then it is to be found in the base device directory.
> >>> +		Note a value 0 where supported, will correspond to sampling
> >>> +		stopping.    
> >>
> >> Hm, I don't like this. 0 should be an invalid value for the standard 
> >> ABI. Enabling/disabling of the trigger should be controlled by whether 
> >> there are any active trigger consumers.
> >>
> >> The stm32-timer-trigger implements a non-standard ABI and I think we 
> >> need to document this explicitly. The driver does not have a set_state 
> >> callback. So the frequency property is used to enable/disable the 
> >> trigger, but as said above, for standard compliant triggers that should 
> >> not be the case.
> >>  
> > Good point.  Ideally we'd also fix the stm32-timer-trigger to have
> > an explicit enable / disable (even if that works by setting the frequency
> > to 0 under the hook)  
> 
> Hi Jonathan,
> 
> I'd like to come up with something here...
> The trivial use case is: the stm32-timer triggers the stm32-adc (by HW).
> In this case, "set_trigger_state" perfectly fits the needs (looks like).
> 
> But such change doesn't seems trivial when considering one timer can
> trig another timer in hardware here. The "set_trigger_state" isn't
> called in such a case.

Ah. I'd forgotten that complexity.

> So, I'm not sure what could be suitable to implement explicit
> enable/disable of the timer trigger ?

Perhaps we should just document this one as non standard.  We already have
a few ABI docs that reflect devices that do something that is kind of
'in the spirit' of the ABI, but stretches in a little in an unusual direction.
For those we just say what parts they apply to.  It is existing ABI anyway
so there is no disadvantage in keeping it around if we can't come up with
something better.

> 
> Just to share some thoughts here: For sure the stm32-timer-trigger would
> need additional changes (I haven't forget other mail thread on the
> preset attribute). I believe also some functionalities should be moved
> to the counter framework. But, even provided this, I think there will
> still be a need for an enable or disable attribute, for the trigger part.
> 
> Perhaps adding an enable/disable attribute could be a way here ?

Hmm. At least based on limited caffeine in my system this morning I think
that we may be better off with it just being as it is now and a slightly
'stretch' of the ABI.  

What do others think?

Jonathan

> If yes, would you have some suggestion on the naming ?
> 
> Please advice,
> Thanks in advance,
> Fabrice
> 
> > 
> > For now I've dropped the patch until this is resolved.
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> >   

