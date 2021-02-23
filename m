Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A6F322EE7
	for <lists+linux-iio@lfdr.de>; Tue, 23 Feb 2021 17:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhBWQib (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Feb 2021 11:38:31 -0500
Received: from www381.your-server.de ([78.46.137.84]:38522 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhBWQi1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Feb 2021 11:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=tlgUyvMAxOQzOyYpYCaYbua1OPAVFxN8saq4CxuGkt4=; b=Vcvh84K+9+7P/8r3MMERhEIt1S
        X/4e8vHPSMoPQ4pohjVsNoz9FBVrxD9nsFtZUW2VwxbsalhcCyC00ncqJS/ig4rlubeQhuQonZR4c
        oF30el/0YDi3rJqboAuovdORkd+M7PZtXv5Y71t9yRvkaqoRCTiinE896Qq2eqzoK0RTToqZiE8VY
        2npTsGGVNVOpyxMz6qDtIrnHNYvQaHbcJeOJL62AHY4NrA2baSFzFVo5BMaSeb8XvyGt3KhcofdzL
        pX46hz0suZajzhm7ykMOBBu6olYmOHcqmL+UrJOTvrBFiwmWbSToyP6JKuwHV/SuVIVa9mwBg2URG
        8TEr8ABg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lEagv-0009Cm-BB; Tue, 23 Feb 2021 17:37:41 +0100
Received: from [62.216.202.180] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lEagv-000InI-5Q; Tue, 23 Feb 2021 17:37:41 +0100
Subject: Re: [PATCH v2 5/5] iio: dac: ad5686: Add PWM as a trigger source
To:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Michael.Hennerich@analog.com, nuno.sa@analog.com,
        dragos.bogdan@analog.com,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        Mihail Chindris <Mihail.Chindris@analog.com>,
        robh+dt@kernel.org
References: <20210217083438.37865-1-alexandru.ardelean@analog.com>
 <20210217083438.37865-6-alexandru.ardelean@analog.com>
 <20210218140506.02b28d8a@archlinux>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <49654dc0-5c6b-2fdc-1e48-22e4b07a4165@metafoo.de>
Date:   Tue, 23 Feb 2021 17:37:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218140506.02b28d8a@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26089/Tue Feb 23 13:11:02 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/18/21 3:05 PM, Jonathan Cameron wrote:
> On Wed, 17 Feb 2021 10:34:38 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
>> From: Mircea Caprioru <mircea.caprioru@analog.com>
>>
>> A PWM signal will be used as a trigger source to have a deterministic
>> sampling frequency since this family of DAC has no hardware interrupt
>> source.
>>
>> This feature is made optional however, as there are some board setups where
>> this isn't used.
>>
> So this is taking a very generic setup, but then implementing it
> as a bit of a hack within the driver.
>
> It's effectively a PWM connected up to an instance
> of iio/triggers/iio-trig-interrupt.c
>
> Now, I've not looked at that trigger driver for a while, so you may well
> need to figure out how to add a binding to instantiate it.
> (looks like no one has used it since board file days, or via instantiation
> from another driver).
>
> It's a slightly odd corner case as what it reflects is that we have
> an interrupt available that is intended to drive some sort of data
> capture or output (it's a trigger signal) - but exactly what is done
> is a runtime configurable.  In this particular case that interrupt
> is hooked up to a PWM and we also want to represent that.
>
> The fact it's being driven via a PWM is interesting but we should be
> able to extend that trigger driver to optionally accept a pwm provider
> and if it has one provide frequency control.
>
> Binding might look something like the following..
>
> interrupt-trigger {
>     interrupts = <>;
>     pwms = <&pwm 0 4000 PWM_POLARITY_INVERTED>;	
> };
>
> @Rob, what do you think of this odd beast?
>
> So all in all, this generic facility needs a generic implementation, not
> one buried in a driver.
>
> Another open question here is whether you really can't just use an hrtimer
> to get similar precision?  Way back at the dawn of time in IIO we had
> code to use the RTC periodic ticks as a trigger with the theory that they
> would give very precise and even timing.  In the end it turned out that
> hrtimers worked just as well (and RTCs drivers emulated the periodic
> ticks via hrtimers, dropping their use of the hardware periodic timers).
>
The way this DAC works is that it has a "latch" pin and some shadow 
registers. The way this is supposed to be used is that you update the 
shadow registers and then when the there is a rising edge on the latch 
pin all the shadow register values are transferred to DAC output registers.

This means if you hook up a periodic signal like a PWM or clock to the 
latch pin you can generate very precise waveforms that have much lower 
jitter than when using a hrtimer since there is no variable interrupt 
latency for the update step itself. This is useful when generating 
periodic signals.

But you could for example also use a GPIO to update multiple discrete 
DACs at the same time.

This is not specific to this particular chip. There are quite a few ADI 
(and probably from other vendors) precision DACs that have this 
functionality. I agree that this should be a some sort of generic 
trigger helper module.

Now for the implementation since there is a direct connection between 
the PWM and the DAC I think it makes sense to describe this connection 
in the DT. After all if there is no connection this will not work.

As for the interrupt, most PWM controllers do have the ability to 
generate an IRQ by themselves once per period. There should be not need 
for a hardware loopback. Unfortunately the PWM framework does not have a 
mechanism yet to expose those IRQs and register a callback.

A similar feature btw exists for many of the ADCs and we did have this 
special Blackfin PWM trigger[1] back in the day to support this. The 
bfin PWM trigger driver essentially implements what I'm describing 
above, but without using the PWM framework.

- Lars

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/iio/trigger/iio-trig-bfin-timer.c?h=v3.15

