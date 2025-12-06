Return-Path: <linux-iio+bounces-26826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAB7CAA9AD
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 17:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9849F30DD976
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39972FE596;
	Sat,  6 Dec 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2o7704E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EC622A7E4;
	Sat,  6 Dec 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765037384; cv=none; b=PHqKwUZ9MqdBqUgVFO9ui5hYyIaY++OxIB9oaAzQWA/u+7b2J0PPjUVMZDylhNmS4209XzndDg9lVBvZONeZCND6z8U6k7uAUtXbgECchfRqg4VlzJh+jlFzqqBUvrrBh98q+wgJgVvqTtlZoo/tkcp3iknTcSDnj68loLRjxZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765037384; c=relaxed/simple;
	bh=pnyZeNSHl7AMoGcA2KWf0ofuoHL+QQHYkdXq/DsjagU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Va0XDDP0o+uTfXFDdKdfYCSikooR4p2VOks3mbboKnV67IXCY6jHbfo4iV/cAbPhRoO0/5TXC23/8wiYQXDoQYA2iO4hP+d+QuQiUs9jOdHr9Ba3UAk8b08231p118+I2LWSHEC+bJ5rBcBcvPpBl7XI9yMspQ8p5K/Oo2kK668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2o7704E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61F0C4CEF5;
	Sat,  6 Dec 2025 16:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765037383;
	bh=pnyZeNSHl7AMoGcA2KWf0ofuoHL+QQHYkdXq/DsjagU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K2o7704EWuZWDrW8SEtZkKIj8FdlxXtqD0WzNKaOezXKLqqXTYCOLBUFjPrQVgSox
	 0UsPr72gHvAHxhWAzmVqa+P/DLSBjGPJpw6yYDeCeo/U3K2h0m6Tsgv6YY3dW6G/NL
	 L11mmpXttCykeRaZzQ18f4BCW/BvqLb+mgCO8Q19AHD4ATVAQRjw3Ign13zczF9ymG
	 ZrH9wG5WOTav2Ya124hBKBdI3anKdhd25LHGMKWdC+ycjfdE/QmPQcWiOl3rBtoR8j
	 YMzln10+SFjQOXJbUG5abKCCWqGDMObpyx6d9aWvqndXii7nDPeedAxWRb01Rx+oYG
	 PuCGAytfL6eMg==
Date: Sat, 6 Dec 2025 16:09:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] ad9832: driver cleanup
Message-ID: <20251206160933.46d45e5f@jic23-huawei>
In-Reply-To: <20251205202743.10530-1-tomasborquez13@gmail.com>
References: <20251205202743.10530-1-tomasborquez13@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Dec 2025 17:27:40 -0300
Tomas Borquez <tomasborquez13@gmail.com> wrote:

> This series is a general cleanup of ad9832, with the purpose of 
> graduating it from staging. The main changes are removing legacy 
> platform_data support, converting to IIO channels with read/write_raw 
> callbacks, and adding devicetree support.

Opening question for a cleanup of a driver like this is how you plan
to test it. Do you have the hardware, or are you emulating / stubbing
functions to test it? It is very brave to take on major refactoring
without a good way to test.

I was kind of planning to drop this driver this cycle on basis of no
interest in sorting it out, but clearly you are interested so great
as long as we can be sure it works well after your work on it
(or indeed that it works currently!)

> 
> I'm sending this as an RFC because I have some concerns about the ABI 
> design and would appreciate guidance before putting more time into this.

Very sensible!
 
> 
> Patch 1 removes the legacy platform_data support as suggested by
> Jonathan [1]. The driver now initializes to a safe state and lets
> userspace configure frequencies/phases via sysfs.
> 
> Patch 2 converts frequency and phase configuration from custom sysfs
> attributes to proper IIO channels using read_raw/write_raw callbacks
> (This is the main area where I'd like feedback).
> 
> Patch 3 adds devicetree bindings documentation.
> 
> Design Concerns:
> 1) Channel Organization and ABI Break
> 
>    The device has 2 frequency registers and 4 phase registers. Since both
>    frequency and phase must use IIO_ALTVOLTAGE since there's no better fit
>    (as far as I know), I've organized channels as:
> 
>      out_altvoltage0_frequency  (FREQ0)
>      out_altvoltage1_frequency  (FREQ1)
>      out_altvoltage2_phase      (PHASE0)
>      out_altvoltage3_phase      (PHASE1)
>      out_altvoltage4_phase      (PHASE2)
>      out_altvoltage5_phase      (PHASE3)
> 
>    The old ABI used out_altvoltage0_frequency0, out_altvoltage0_frequency1,
>    out_altvoltage0_phase0, etc. 
> 
>    The new approach felt cleaner but I'm open to alternatives and better 
>    ways of mapping them. Is this channel mapping reasonable, or would a 
>    different organization be preferred? And is the ABI break okay?

When fixing up a non standard ABI, ABI breakage is fine, but...

This device only has one output, so there is only one channel.  We are controlling
aspects of that channel.  Hence it should not be split across multiple indexed
channels like you outline. What the number in the attributes indicates here is
the input symbol for phase or frequency modulation.  The applications information
section of the datasheet talks about using this part ofr FSK, GMSK (I had to google that
one ;), QPSK etc.

Oddly I had it in my head that we had a standardised interface for PSK / FSK
parameter control but I guess that discussion was probably for a driver that
never merged.  There is similar stuff for DACs though - see
out_currentY_symbol
out_currentY_rawN 
in sysfs-bus-iio-dac
In those particular cases the thing being switched is of the channel type rather
than modulation on top of that.  But similar approach applies.
Note the symbol control may not be present if the control pins are wired
not to GPIOs but to external circuitry.

So more or less the currently ABI is the way to go, not the one you suggest.


> 2) Scale Attributes
> 
>    The frequency scale is 1 Hz and phase scale is 2*PI/4096 radians.
>    I cannot use info_mask_shared_by_type for IIO_CHAN_INFO_SCALE because
>    all channels share IIO_ALTVOLTAGE.
> 
>    So instead I'm using IIO_CONST_ATTR for the scales:
> 
>      out_altvoltage_frequency_scale = "1"
>      out_altvoltage_phase_scale = "0.0015339808"
> 
>    Is there a better approach here? Or should I just document the units and
>    skip scale attributes entirely?

Good question.  I think right option is to just do the maths in the driver and
have out_altvoltage0_frequencyN take the scaled value rather than the register
value.  Then do some fixed point maths to get to the required register value.

> 
> 3) Remaining Custom Attributes
> 
>    Other controls remain as custom sysfs attributes:
> 
>      - out_altvoltage_frequencysymbol: select active frequency register
>      - out_altvoltage_phasesymbol: select active phase register  

For those two the ADC symbol example above should generalize but we'll need
to extend the ABI to
	out_alvoltage0_phase_symbol / frequency_symbol I think.

>      - out_altvoltage_pincontrol_en: hardware pin control enable

I'm not sure this is something that userspace should control at all.
To me it seems most likely to be wiring question.
1) those pins are ground tied, and we are doing software control -
   corresponds to no DT description of the pins.
2) those pins are couple to GPIOs on the SoC.  Maybe we prefer those over
   software because expectation is that they are quicker to set.
3) Wired to something unknown - expectation is always use those pins
   as we can't meet the documented recommendation to tie them to zero
   when using software control.

The tricky corner is we need firmware to tell us if they are 0 tied
vs wired to something outside our control.  This comes back to a recent
discussion about fake GPIOs that just allow you to read the state but
not set it (that is probably still going on but I'm reading my rather long
inbox backwards so haven't gotten to it yet).   If that isn't resolved
well need a firmware property to distinguish 1 and 3.


>      - out_altvoltage_out_enable: output enable

out_altvoltage0_enable should be fine.  That's standard enough for DAC channels
and this is kind of a fancy DAC.

>    I'm not sure if these map cleanly to IIO interfaces. Should these be
>    documented in ABI or is there a preferred way to handle them?

So a few additions that need documenting but mostly aligns with standard
ABI.

> 
> 4) Implementation Notes
> 
>    - read_raw uses explicit address switching rather than channel index
>      arithmetic for clarity, though phase values could alternatively be
>      accessed via st->phase[chan->channel - 2] and directly in freq with
>      st->freq[chan->channel].
>    - I'm unsure if mutex guards on cached reads are necessary.
> 
> Link: https://lore.kernel.org/linux-iio/20250628161040.3d21e2c4@jic23-huawei/ [1]
> Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
> 
> Tomas Borquez (3):
>   staging: iio: ad9832: remove platform_data support
>   staging: iio: ad9832: convert to iio channels
>   dt-bindings: iio: add analog devices ad9832/ad9835
> 
>  .../bindings/iio/frequency/adi,ad9832.yaml    |  65 +++++
>  drivers/staging/iio/frequency/ad9832.c        | 264 +++++++++++-------
>  drivers/staging/iio/frequency/ad9832.h        |  33 ---
>  3 files changed, 233 insertions(+), 129 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,ad9832.yaml
>  delete mode 100644 drivers/staging/iio/frequency/ad9832.h
> 


