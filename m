Return-Path: <linux-iio+bounces-26940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A25CAD9CF
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 16:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B572300C0FD
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FE6267B02;
	Mon,  8 Dec 2025 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQifH5nI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BCF2B9B9
	for <linux-iio@vger.kernel.org>; Mon,  8 Dec 2025 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208224; cv=none; b=qOFyao6XvdFKs3oM0DKcHIssjXbwwXOVw95iAirKnq3s+W/muMgvr6Dt4J9saKip3tGyQELCuO/pPLRlmABVmJqVkdPpz6N9EoGkjge/FT8Mjm5cFgUyHMpGAteD+L85w3qtNtI8jjXxWE31QDUYjzwx/sQn1VD93cDe0WqZRSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208224; c=relaxed/simple;
	bh=0a4dwMpBBIfI9xTxKD35Li1k32wcNYYYk3dybFc2/1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGtY3EWlq5TJdXX1Nukesgk7Wyx4X5xYsOKo8ol5hCEFDenuprD1fe7a50G2aQeIKeV+HkOe7fC8V2KdwK/M5DHZTy/EThBa/h3Y0RySVWwPAbSeXXNMEpg43yg/l97KMYTo53Qnx7c/bjju1wNAZLobQESw+/PIPsqPxYwKubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQifH5nI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7ade456b6abso3785553b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 08 Dec 2025 07:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765208222; x=1765813022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dJ9fRIoaXrFePWfJyjcX9mlmAJ92ptU0OJk0UFqvTAI=;
        b=AQifH5nIgTykq3gbtI7gXycS//0lVx14VgkkkizTct9HXHKBticGg8ajfgdasuggWY
         Xu4XaaKY0pTH365bEoGLW6QYUUXrgLbrBWJKvgX3ChdRAQ3/O1rJf7XXajP/zGn43L1U
         Bnwy4YAEZVhpsTgeYEEuaisoQ2OJDMJ0AuN5f748RZVdUcCP5sSCsTdlexRqbTr1lWhk
         Nh80+qUkcTwyZn1to9ywOl6m/2xTzXaxBGK7NPijTFtVAhMbW7NvSx7q2bsckZPiDYe7
         /1IDL4UY8Eq0JJNoXF7cGjZMS4EbfNHx2ugXnawQ7PxMZBKjUtE7xRYJhh6bpBXb2qbd
         /IrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765208222; x=1765813022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJ9fRIoaXrFePWfJyjcX9mlmAJ92ptU0OJk0UFqvTAI=;
        b=h6ODRH6jnICaPELgXQOMDCKaEN4bpXOpIeJbRC/3t3CRqPPB20VvNs6yEcLiFPdYb9
         BxSJm8ByjwAiAcUT7Dsq3E/OBvlx0zzxe+PmwdR34xX462Eg056UKKoOLTyzCI/wINmD
         bhpA/RFQP/klq7Y0NuyrKRUk0IHAX30Y6HDhFMifOfSmn15AC/9UQYPmo627QZxco/rV
         AdM/SG04O/fk6Z37zwh6OXCNzYpXtYD4FMN7iiO8ZK55r6xMcGxMsfkfK07qRSVwlOlY
         nC6HUT61so6NKM6BKBDTWkcoVlManKL5SiaBNz2sM78BKLydpchC5YISYji9nux0w1Vs
         mNIg==
X-Gm-Message-State: AOJu0Ywmr3kix6c9BH+CIqb6JKBSyXLRC8qXHXy2y1tBIOaxNLDE7kdR
	HuZlH4KW/voaLSgl6GDupwzJxyZFBAFvecljNTU85zN8TQqYWJAoIPsm7Ch+kksk
X-Gm-Gg: ASbGncutD+l1FBvBkfyph+4qKewVIjLVUTMOzHz9DUhmE8zXPJ8bOOCl5WmxL4OldKS
	KIXOm19f16E9WqYu9/U02rGo61+EZzv57SilD0ckME5cLNH65PRCB/qFXdeJmXk/AM4MYxQyxrl
	2HsnpUcvMZGtuDYsIq60aelhxjnDrEhrivn1dJeuhAqRylkCoNEVQ5YuS9WeZM9vcIFhl45b/pC
	NQippzmulhfeTBi5Rw4ZHnc99uAOJc1ZNVqz6p3s/H2rq+yEvKzVP/mKdRNYgaeZO8Ow4+H+9vQ
	E8pyFKez8awkpiJCEd7qwmjxcENP6C3e+uOlqDjcKNfkGvd5wX5A6xLtSArTjiYZGqKFY4tkka+
	INg+c8iIu5dps/wCgFU20Gjwm/uHbLrPWfSWJzAD4av2sKulGOUSEy2Acz5FsqWR8ihYQ/4V+S7
	adA+O8AqquaP9Zka626nee2VJmV4ZUG1blF15aSwLY1LPXaRLodjpqpjkGcdOfUaPMQ8g9+PXvh
	MiXahf4eUTOAYYIfF9O2jWAj4vX1pk3od+SeQaev8UN8OX3v+5yE+rYvw==
X-Google-Smtp-Source: AGHT+IHTE9mtGISDZUwxGiFQ+/FTfOTulE9lYil/XVmUis6qjiYPhdCQSfkDs7dPL+BzwggaBookVg==
X-Received: by 2002:a05:7022:928:b0:11a:342e:8a98 with SMTP id a92af1059eb24-11e0310cb45mr6623393c88.0.1765208221941;
        Mon, 08 Dec 2025 07:37:01 -0800 (PST)
Received: from localhost ([181.191.143.42])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7552defsm56707150c88.2.2025.12.08.07.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 07:37:01 -0800 (PST)
Date: Mon, 8 Dec 2025 12:36:59 -0300
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] ad9832: driver cleanup
Message-ID: <aTbwmynIVfIbGWJ7@Lewboski.localdomain>
References: <20251205202743.10530-1-tomasborquez13@gmail.com>
 <20251206160933.46d45e5f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206160933.46d45e5f@jic23-huawei>

On Sat, Dec 06, 2025 at 04:09:33PM +0000, Jonathan Cameron wrote:
> On Fri,  5 Dec 2025 17:27:40 -0300
> Tomas Borquez <tomasborquez13@gmail.com> wrote:

Hey Jonathan, thanks for all the feedback!

> Opening question for a cleanup of a driver like this is how you plan
> to test it. Do you have the hardware, or are you emulating / stubbing
> functions to test it? It is very brave to take on major refactoring
> without a good way to test.
> 
> I was kind of planning to drop this driver this cycle on basis of no
> interest in sorting it out, but clearly you are interested so great
> as long as we can be sure it works well after your work on it
> (or indeed that it works currently!)

I don't have the hardware, so I've been testing with a stubbed SPI layer.
I created a platform device wrapper that registers the IIO device without
real SPI and replaced spi_sync() with a function that dumps the TX buffer
via print_hex_dump() which allows me verify the register protocol against
the datasheet, I validated:

- Frequency tuning word calculation (32-bit, formula from datasheet)
- Phase register writes (12-bit values across two transfers)
- Control register state machine (SLEEPRESCLR, FPSELECT commands)
- Proper preservation of ctrl_fp bits when updating freq_symbol vs
phase_symbol independently
- Input validation (bounds checking on phase/frequency values)

All the SPI command bytes match what the datasheet specifies. Obviously
this can't catch electrical issues or timing problems that would only show
up with real hardware but it does verify the driver's logic and register
protocol are correct.

I also ran it through sparse, smatch, and checkpatch with no warnings.
I can share the test module + logs if that's useful for review.

...

> > 2) Scale Attributes
> > 
> >    The frequency scale is 1 Hz and phase scale is 2*PI/4096 radians.
> >    I cannot use info_mask_shared_by_type for IIO_CHAN_INFO_SCALE because
> >    all channels share IIO_ALTVOLTAGE.
> > 
> >    So instead I'm using IIO_CONST_ATTR for the scales:
> > 
> >      out_altvoltage_frequency_scale = "1"
> >      out_altvoltage_phase_scale = "0.0015339808"
> > 
> >    Is there a better approach here? Or should I just document the units and
> >    skip scale attributes entirely?
> 
> Good question.  I think right option is to just do the maths in the driver and
> have out_altvoltage0_frequencyN take the scaled value rather than the register
> value.  Then do some fixed point maths to get to the required register value.

Which is already done in write_frequency(), should I do it with phase too?
And should I accept radians or microradians?

...

I've been working on v2 based on your ABI feedback. If the testing approach
sounds acceptable I'll send it out and if someone with hardware wants to
test it, that would be great.

...

Tomas

