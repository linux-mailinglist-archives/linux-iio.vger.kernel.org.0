Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B5431EB96
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 16:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhBRP31 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 10:29:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232484AbhBROg0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 Feb 2021 09:36:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A198264EAE;
        Thu, 18 Feb 2021 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613658941;
        bh=8/1IqR6HXIUyOdXA/aJwouek9ZMCkL1nIp5uOO/mlec=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VdtxJkCDa414iNNczvI7Pi3GVTJRxp1jNYSFFSE22IypA82LbGS+Gj7swBPnHlGX4
         19w/J+hFpGGex9FcmazoYT2Ju4kLYh6vFF6A4+m3N9RPrKZJb0VYI5w3PJOUH5uVfe
         4SPGmQoMcAbKauLBn/0qcKrJuxhRPhKxUY1LRJ7c1wDh1dwriR9y9eGMRqjA/gd9cN
         Rh7ukmzW+M1ZHpJfSoSfAc2g6TRF6DQbcMApbkuni3uxbZZW55EewQ1BEfeG9YgCVW
         Mu5ASdew+vlAkTHnBa/CIH0vzqt3pR7YRoMRXfFKjnsNGCVTKicnQTdEtAHSwy5PWX
         InCbs5v1Umqrg==
Received: by mail-ej1-f45.google.com with SMTP id lu16so5897001ejb.9;
        Thu, 18 Feb 2021 06:35:40 -0800 (PST)
X-Gm-Message-State: AOAM530f/SzvN47CwebCKrnjqkoYoijoS00FAJhqJkTZo2WMtFvxhF0x
        rnW4ia3rVVeIJA+juxk1n8v1X7CriPLPpC9E8g==
X-Google-Smtp-Source: ABdhPJxJm743ODnmWfRYqpHq4k+p/LgIpGEUes+LEamFSE93HhV3FfLeLA+QcSMLlLzuhWYBhB/JMJH0OmQjJsithso=
X-Received: by 2002:a17:906:25c4:: with SMTP id n4mr4299436ejb.359.1613658939091;
 Thu, 18 Feb 2021 06:35:39 -0800 (PST)
MIME-Version: 1.0
References: <20210217083438.37865-1-alexandru.ardelean@analog.com>
 <20210217083438.37865-6-alexandru.ardelean@analog.com> <20210218140506.02b28d8a@archlinux>
In-Reply-To: <20210218140506.02b28d8a@archlinux>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 18 Feb 2021 08:35:27 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+_HYQ1KT7L34nuM2RENnX1A5J8LCazCV2aeNFmkeskGw@mail.gmail.com>
Message-ID: <CAL_Jsq+_HYQ1KT7L34nuM2RENnX1A5J8LCazCV2aeNFmkeskGw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: dac: ad5686: Add PWM as a trigger source
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        Mihail Chindris <Mihail.Chindris@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 18, 2021 at 8:05 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 17 Feb 2021 10:34:38 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > From: Mircea Caprioru <mircea.caprioru@analog.com>
> >
> > A PWM signal will be used as a trigger source to have a deterministic
> > sampling frequency since this family of DAC has no hardware interrupt
> > source.
> >
> > This feature is made optional however, as there are some board setups where
> > this isn't used.
> >
>
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
>    interrupts = <>;
>    pwms = <&pwm 0 4000 PWM_POLARITY_INVERTED>;
> };
>
> @Rob, what do you think of this odd beast?

So a PWM routed back to a GPIO interrupt? It needs a compatible, but
otherwise I wouldn't object to the binding if that's what the h/w
looks like. But from an OS perspective, I don't think you need it.

> So all in all, this generic facility needs a generic implementation, not
> one buried in a driver.
>
> Another open question here is whether you really can't just use an hrtimer
> to get similar precision?  Way back at the dawn of time in IIO we had
> code to use the RTC periodic ticks as a trigger with the theory that they
> would give very precise and even timing.  In the end it turned out that
> hrtimers worked just as well (and RTCs drivers emulated the periodic
> ticks via hrtimers, dropping their use of the hardware periodic timers).

+100

A hrtimer is likely going to be more precise. IIRC, timers are
serviced first. Either way, you're going to have some amount of
interrupt service latency, so any precision you think you are gaining
by 'doing it in h/w' isn't really there.

Rob
