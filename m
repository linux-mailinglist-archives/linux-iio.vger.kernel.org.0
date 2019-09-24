Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC69BC6E9
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2019 13:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438723AbfIXLdO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Sep 2019 07:33:14 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44849 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438702AbfIXLdO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2019 07:33:14 -0400
Received: by mail-yb1-f195.google.com with SMTP id f1so537955ybq.11
        for <linux-iio@vger.kernel.org>; Tue, 24 Sep 2019 04:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lZCfgGP1XyB56VjKXb0vgJCfPG+fbJNE4C9mm4OIDL8=;
        b=qJBll/QahmBRCUakPx7v0lBYKMIF8Knz86rQuchdSPJ+bmzFl1nVd01XI4TJjegZaR
         /HiWy9+N460cScBUKjiOzX5uk8qT1Exx/jm7l1T6W4JlXvhWTksMjRfQQE3vNW12SEZF
         yOfSmMJZoi/5+/3ZJvESTObL352Yl0H2WzBCrAKH20ORL3LKHk9ZYzer475Uvi8MpUkX
         UH4G7IK9MH//nheoXqs1+Xd1wOHrtpqX00D7BfBo3avsHS7pk2b0GKxyAZxAZ8B2Jh0b
         G2msAntFLyGoFtn6fP/pMTUUaZufR8AJfilqBH59g4Ssw48DHRITJnYn0qhyePCigG2t
         ti6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lZCfgGP1XyB56VjKXb0vgJCfPG+fbJNE4C9mm4OIDL8=;
        b=Iy1FU1fvUpPPU/PehbjDms0Kz/XN/OIejyaStrsDYlshojancrXaynyElcLZvikn1Y
         dHaCb3Px+rp+viSG8V2wpfQw/1hyHsxV5YoeAqNvbikW2hpNQ/F4EQf2Q7mtXoUtVSOc
         XuJijzS+9ZgKdU46Ds8tGlRlJL5HPyDpOOGa660kvFkke1po6fGgDkAYE4IUEDaQvhLN
         EO820NVanOmm5zmyyiBdHxDlqNZQrO06uunQLbKyTEaoFrmgdoWEEEaUov/tgOgwLai5
         LEfmNnwjZ7Wsk6Dgm8JXM6LapEaMJ2r3ATiNGxDcDfTFmTfSPZD+jpl0Rfkg8V3Tx65M
         kenw==
X-Gm-Message-State: APjAAAWfKaJviDVSFxAzDxxMr15nm4QJ5R/RukD9hs/VO6+xeNukdIXE
        VZ8MeiE+Y538H+Pm65gR2b8=
X-Google-Smtp-Source: APXvYqxnvMZs3u397EeqN6pvjmkaHFLtDmgCJGRpqFd/4gJKcPKgIlmRR7V9CkxQrewD3cGMlSxlAg==
X-Received: by 2002:a25:9cc6:: with SMTP id z6mr1660168ybo.262.1569324792843;
        Tue, 24 Sep 2019 04:33:12 -0700 (PDT)
Received: from icarus (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id k1sm377021ywg.49.2019.09.24.04.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 04:33:11 -0700 (PDT)
Date:   Tue, 24 Sep 2019 20:32:58 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     linux-iio@vger.kernel.org,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        David Lechner <david@lechnology.com>
Subject: Re: [RFC/PATCHv2 2/2] counter: introduce support for Intel QEP
 Encoder
Message-ID: <20190924113128.GA2727@icarus>
References: <20190917114403.GA8368@icarus>
 <20190919080305.960198-1-felipe.balbi@linux.intel.com>
 <20190919080305.960198-2-felipe.balbi@linux.intel.com>
 <20190922233538.GA3119@icarus>
 <87tv92xc00.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tv92xc00.fsf@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 24, 2019 at 12:46:39PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> William Breathitt Gray <vilhelm.gray@gmail.com> writes:
> > On Thu, Sep 19, 2019 at 11:03:05AM +0300, Felipe Balbi wrote:
> >> Add support for Intel PSE Quadrature Encoder
> >> 
> >> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> >> ---
> >> 
> >> Changes since v1:
> >> 	- Many more private sysfs files converted over to counter interface
> >> 
> >> 
> >> How do you want me to model this device's Capture Compare Mode (see
> >> below)?
> >
> > Hi Felipe,
> >
> > I'm CCing Fabien and David as they may be interested in the timestamps
> > discussion. See below for some ideas I have on implementing this.
> >
> >> For the few features which I couldn't find a matching property in
> >> counter framework, I still leave them as private sysfs files so we can
> >> discuss how to model them in the framework.
> >> 
> >> Do you want Capture Compare to be a new function mode?
> >> 
> >> BTW, I know I'm missing a Documentation file documenting sysfs files
> >> introduced by this driver, I'll do that once we agree how to move all
> >> other sysfs files to the framework. No worries.
> >> 
> >> 
> >> Details about the controller (do you want this in commit log?):
> >> 
> >> 
> >> Controller has 2 modes of operation: QEP and Capture. Both modes are
> >> mutually exclusive. We also have a set of maskable interrupts. Further
> >> details about each mode below.
> >
> > I noticed your interrupt handler takes care of a number of different
> > scenarios. Would you be able to summarize a bit further here the
> > conditions for this device that cause an interrupt to be fired (watchdog
> > timeout, FIFO updates, etc.)?
> >
> >> Quadrature Encoder Mode
> >> =======================
> >> 
> >> Used to measure rotational speed, direction and angle of rotation of a
> >> motor shaft. Feature list:
> >> 
> >> 	- Quadrature decoder providing counter pulses with x4 count
> >> 	  resolution and count direction
> >> 
> >> 	- 32-bit up/down Position Counter for position measurement
> >> 
> >> 	- Two modes of position counter reset:
> >> 		> Maximum Count (ceiling) to reset the position counter
> >> 		> Index pulse to reset the position counter
> >> 
> >> 	- Watchdog timer functionality for detecting ‘stall’ events
> >> 
> >> Capture Compare Mode
> >> ====================
> >> 
> >> Used to measure phase input signal Period or Duty Cycle. Feature List:
> >> 
> >> 	- Capture function operates either on phase A or phase B input
> >> 	  and can be configured to operate on lo/hi or hi/lo or both hi
> >> 	  and lo transitions.
> >> 
> >> 	- Free-running 32-bit counter to be configured to run at greater
> >>           than or equal to 4x input signal frequency
> >
> > So in "Capture Compare" mode, the counter value is just increasing when
> > a state condition transition occurs. In that case we won't need a new
> > function mode to represent this behavior since one already exists:
> > "increase".
> >
> > You can add it to your intel_qep_count_functions array like so:
> >
> >         [INTEL_QEP_ENCODER_MODE_CAPTURE] =
> >         COUNTER_COUNT_FUNCTION_INCREASE,
> >
> > The various configurations for this mode are just Synapse action modes.
> > If you want only Phase A, you would set the action mode for Phase A
> > ("rising edge", "falling edge", or "both edges") and change the action
> > mode for Phase B to "none"; vice-versa configuration for Phase B instead
> > of Phase A.
> >
> > One thing to keep in mind is that action_set will need to maintain valid
> > configurations -- so if the user tries to set the action mode for Phase
> > A to something other than "none", you need to automatically set Phase
> > B's action mode to "none" (and vice-versa).
> 
> interesting, thanks
> 
> >> 	- Clock post-scaler to derive the counter clock source from the
> >> 	  peripheral clock
> >
> > I see you already have a "prescaler" extension in your code. Is this
> > different from the "post-scaler" you mentioned here?
> 
> This was probably a brain-fart on my side. It should be post-scaler, but
> that's only valid for capture compare mode.

In that case you're implementation seems fine for this; perhaps a more
generic name for that extension might be better such as "scale", but
I'll decide later.
 
> >> 	- 32B wide FIFO to capture 32-bit timestamps of up to 8
> >> 	  transition events
> >
> > You can implement this as a Count extension called "timestamps" or
> > similar. What we can do is have a read on this attribute return the
> > entire FIFO data buffer as unsigned integers, where each timestamp is
> > deliminated by a space.
> >
> > In addition, it may be useful to have another extension called
> > "timestamps_layout", or something along those lines, that will report
> > the ordering of the buffer (i.e. whether it's "fifo", "lifo", etc.).
> >
> > Would this design work for your needs?
> 
> Perhaps it would be best to have a pollable binary sysfs file (meaning,
> we need to be able to call sysfs_notify() at will) and userspace just
> receives POLLIN whenever there's data read. Then a read returns an array
> of e.g. struct counter_event where struct counter_event could be defined
> as:
> 
> 	struct counter_event {
>         	uint32_t	event_type;
> 		struct timespec64 timestamp;
>                 uint8_t		reserved[32];
>         };
> 
> Userspace would do something along the lines of:
> 
> 	fd = open("/sys/bus/counter/foo/capture/timestamps",...);
> 	pollfd[0].fd = fd;
>         pollfd[0].events = POLLIN;
>         poll(pollfd, 1, -1);
> 
> 	if (pollfd[0].revents & POLLIN) {
>         	ret = read(fd, events, sizeof(struct counter_event) * 8);
> 
> 		for (i = 0; i < ret / sizeof(struct counter_event); i++)
> 			process_event(events[i]);
>         }
>         
> Or something like that.

One concern is that returning binary data like that isn't friendly for
human interaction. However, alternatively printing a human-readable
array would add latency for userspace software that has to interpret it,
so that would a problem as well. This is something we'll have to think
more about then.

> I could, also, remove this part from the driver for now, so we can
> discuss how the capture-compare buffer read would look like. At least we
> could get QDP feature merged while we come to a consensus about capture
> compare.
> 
> What do you think?
> 
> -- 
> balbi

That sounds like a good idea. Most of this driver can be implemented
using the existing Counter subsystem components, so we can do as you
suggest and focus on just getting this driver merged in with the
functionality it can for now.

After it's accepted and merged, we can turn our attention to the new
extension features such as the timestamps buffer return. This will make
it easier for us to discuss ideas since we won't have to worry about
merging in nonrelated functionality.

William Breathitt Gray
