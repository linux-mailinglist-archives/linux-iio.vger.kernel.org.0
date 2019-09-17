Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A8DB4EAD
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2019 15:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfIQNCZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 09:02:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40735 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfIQNCZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 09:02:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so1507879pll.7
        for <linux-iio@vger.kernel.org>; Tue, 17 Sep 2019 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oVeOddo+b0ToaKtmn9OdoPpli6cWoXdYC+4KvLAe1A0=;
        b=KK3qlHRJp9lrCInVzYpo/+TcMJ/OXxfZUow86TlAsGOKewkQwvPPABeGjmb0apOnjQ
         CXbH8y/DCB2l1+6XtVAGQ/pHmFdjQNC0T7kJogjnT/Z4/p9PijRhPJBoW6YNVpSQ8FJs
         5rtzaI8uFx0mCfZUVXsk1gXlGnD3gcrecSBZ+tix1Lch9TQzhTyMNxL4jaQPOmsfiaz5
         wAMPxNDfjlGpZ9KdzWaP/IqbvNoLzwr2gN4+B5/9ThpW70zS6tigYcFISHLf0MP0aJph
         4EXm5lfS01UE6pWQcHKMRsUwP1nK6aeuyzVRiWJvQKfVMYrwAJjQUkxGwlcVbJwlmPJK
         1A1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oVeOddo+b0ToaKtmn9OdoPpli6cWoXdYC+4KvLAe1A0=;
        b=DEFN4NcX2JFpS0inq1BDLej4hVF8XTp8gUxejVbygCuBV2cTyVQFoCFWa+xfZF2/yK
         9L0NMiSvImI32nJngyKPEBFMmpTaYJvyZSHixsjO6UK+TR/RX7ftSgoAJUowe/entABM
         v0e4yHlsA444iv2UlTtCLrHCqk+IAz6f73DO4ixGOLnIz0RmtAs8nCwkVKMkYADQ4Ok8
         XEUnP4ThcsVzfx7beC1ElQkv5NEQ8KtR9Tm5pytTUGAsBh/BjiyPBqomUNCim3jDqTgI
         BZ7+ABRoOC+TCHIvLsH4Q9dLJgcRxwAwSMMKMpHW/yYbt7LMz48tllGxnW5LVLpiwpf+
         gkoQ==
X-Gm-Message-State: APjAAAVRRfn5+eQU+x2n+ERc/J7upQ4GOxC8fbYsosbxklhR8w6fCdG4
        1sLFGG6+qXid9JyilbU7cXM=
X-Google-Smtp-Source: APXvYqw4J8jMcwLvF1U5sRPglTmF9tepR+niO6UNK9Zle2sVhwExmAczV7aVYFgU4nduWzRVn3Wl3Q==
X-Received: by 2002:a17:902:8541:: with SMTP id d1mr3625285plo.39.1568725344028;
        Tue, 17 Sep 2019 06:02:24 -0700 (PDT)
Received: from icarus ([2001:268:c146:aa9b:3c4d:1cfb:4e0b:ea1])
        by smtp.gmail.com with ESMTPSA id u65sm2802864pfu.104.2019.09.17.06.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 06:02:23 -0700 (PDT)
Date:   Tue, 17 Sep 2019 22:02:06 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [RFC/PATCH] counter: introduce support for Intel QEP Encoder
Message-ID: <20190917130206.GA9695@icarus>
References: <20190916093431.264504-1-felipe.balbi@linux.intel.com>
 <20190917114403.GA8368@icarus>
 <87a7b3ceib.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a7b3ceib.fsf@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 17, 2019 at 03:07:40PM +0300, Felipe Balbi wrote:
> 
> Hi William,
> 
> William Breathitt Gray <vilhelm.gray@gmail.com> writes:
> 
> > On Mon, Sep 16, 2019 at 12:34:31PM +0300, Felipe Balbi wrote:
> >> Add support for Intel PSE Quadrature Encoder
> >> 
> >> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> >> ---
> >> 
> >> Hi William,
> >> 
> >> Here's a first cut of the ported driver. Note that this is really an RFC as
> >> there's still quite a bit I don't fully understand. I've left some of my old
> >> sysfs files in there just to keep track of which features I'm still missing.
> >
> > Hi Felipe,
> 
> before anything, thanks for the extensive background on the ideas of the
> framework :-) Much appreciated
> 
> > That is understandable since this is an RFC; I expect in your final
> > version those sysfs files will be Counter subsystem extension
> > attributes.
> >
> > For reference, the existing Counter subsystem attributes are documented
> > in the Documentation/ABI/testing/sysfs-bus-counter file. If you have any
> > new attributes specific to the Intel QEP driver, add them as a new
> > Documentation/ABI/testing/sysfs-bus-counter-intel-qep file.
> 
> Will do, thanks
> 
> >> If understood this correctly, I should add noise filtering as a signal
> >> extension, right? Same for Input Swap.
> >
> > Determining the type of extension to create is a matter of scope.
> >
> > * Signal extensions are attributes which expose information/control
> >   specific to a Signal. These types of attributes will exist under a
> >   Signal's directory in sysfs.
> >
> >   For example, if have an invert feature for a Signal, you can have a
> >   Signal extension called "invert" that toggles that feature:
> >   /sys/bus/counter/devices/counterX/signalY/invert
> >
> > * Count extensions are attributes which expose information/control
> >   specific to a Count. These type of attributes will exist under a
> >   Count's directory in sysfs.
> >
> >   For example, if you want to pause/unpause a Count from updating, you
> >   could have a Count extension called "enable" that toggles such:
> >   /sys/bus/counter/devices/counterX/countY/enable
> >
> > * Device extensions are attributes which expose information/control
> >   non-specific to a particular Count or Signal. This is where you would
> >   put your global features or other miscellanous functionality.
> >
> >   For example, if your device has an overtemp sensor, you could report
> >   the chip overheated via a device extension called "error_overtemp":
> >   /sys/bus/counter/devices/counterX/error_overtemp
> 
> This clarifies a lot of my doubts.
> 
> > I'm not very familiar with the Intel QEP features, so I'll need your
> > help clarifying some of it for me. I'm assuming "noise filtering" is
> > a feature you can enable per individual Signal (is this correct?). If
> > so, then it would be implemented as a Signal extension, maybe as a
> > /sys/bus/counter/devices/counterX/signalY/noise_filter_enable file.
> > Otherwise, it would be a device attribute if it enables noise filtering
> > over all Signals.
> 
> The device, at least as is right now, has a single counter. It's a bit
> difficult to decide whether the noise filter is global or per count :-)
> I'll assume it to be per count as that would allow extension in case a
> future version comes out with more than one counter. What do you think?

Ah, I see what you mean, that was causing me confusion as well. However,
I would suggest making this a device extension instead of a Count
extension.

From an ontological perspective, Counts are essentially independent from
Signals -- they are affected by Synapses, not Signals. So in the sense
of the Generic Counter paradigm, it is wrong to go to a Count's
directory to configure a feature for a Signal.

The practical reason not to do this is that a single Signal can in
theory be associated to several Counts via multiple Synapses. In these
cases, it would be wrong for one of those Count attributes to affect the
configuration of a Signal that is also used by another Count. This is
the reason we have the distinction between Signal extensions and Count
extensions: in the Generic Counter paradigm, these components are
independent.

> > Is "Input Swap" swapping the Phase A and Phase B signal lines for each
> > Count? If so, this would be a Count extension if you can configure it
> > per Count; otherwise a device extension if it's globally enabled for all
> > Counts.
> 
> Yeah, it swaps A and B signals. Again, with a single count, difficult to
> decide on global vs per-count.

Hmm, this may make more sense as a new function mode. You can see the
existing available function modes in the sysfs-bus-counter Documentation
file, under the "/sys/bus/counter/devices/counterX/countY/function"
description section.

I suggest implementing a new one called "quadrature x4 inverted" or
similar (whatever name you think is most apt). Define a function_set
callback and add it to your intel_qep_counter_ops structure -- when a
user wants to swap the signals, they can select the new function mode.

In a separate patch from your Intel QEP introduction, implement this new
function mode by doing the following:

* include/linux/counter.h
  Add a new constant to the counter_count_function enum structure.

* drivers/counter/counter.c
  Add a respective entry to the counter_count_function_str string array.

> > If you're still having trouble figuring out which type of extension to
> > use, give me a simple breakdown of the features you are trying to
> > support with these attributes and I should be able to specify which type
> > works best for each.
> >  
> >> How should we handle the reset mode of the device? And mode of operation?
> >
> > Is "reset mode" specifying the condition that causes a Count's count to
> > be reset back to a value of 0? If so, I assume "index" means an active
> > level on the index line will reset the count; does "maximum" mean the
> > index line is ignored and the reset operation is simply activated once
> > the ceiling is reached? As well, I'm assuming this is a global
> > configuration for all counts.
> 
> This seems more logical to be global, yes. The other thing this QEP
> controller has is that we can configure the maximum count value. By
> default it's UINT_MAX (0xffffffff) but it could be less and that's
> configurable. So I'm assuming I would have a "maximum_count" device
> extension in this case.

You can implement this as a writable "ceiling" Count extension. It's
already documented in the Documentation/ABI/testing/sysfs-bus-counter
file so no need to worry since some of the other existing counter
drivers already have support for such functionality.

> > If my assumptions are correct here, then this behavior can be exposed
> > by creating two device extensions: "preset" and "preset_enable"; these
> > should be based on the existing two same-named Count attributes (see the
> > Documentation/ABI/testing/sysfs-bus-counter file).
> >
> > * /sys/bus/counter/devices/counterX/preset
> >   For the Intel QEP, this will be a read-only that always report "0".
> >
> > * /sys/bus/counter/devices/counterX/preset_enable
> >   Assuming "maximum" is just equivalent to ignoring index, preset_enable
> >   can toggle between the two modes as a simple boolean: "1" = "index"
> >   and "0" = "maximum".
> 
> Understood. This will be nice from userspace point of view.
> 
> >   If I assumed incorrectly, please let me know and we can discuss the
> >   possibility of a new attribute (perhaps "preset_mode").
> >
> > Take a look inside 104-quad-8.c to see how it handles index lines and
> > reseting the counts; "preset" and "preset_enable" extensions are
> > specified in the quad8_count_ext array.
> >
> >> If you have any ideas, let me know.
> >> 
> >> cheers
> >
> > Since I expect a good amount of this code to change once the extensions
> > are added, I'll hold off on a more in-depth code review until we get it
> > closer to what it'll actually look like. From skimming the code in this
> > RFC, it seems like you have the core Counter subsystem functions and
> > structures use correct, so I think it'll be the implementations of the
> > extensions that we'll be focusing on.
> 
> Cool, thanks a lot. I'll start moving some more of those private sysfs
> files to extensions.
> 
> Again, thanks for the background information. Helps a lot.
> 
> cheers
> 
> -- 
> balbi
