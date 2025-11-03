Return-Path: <linux-iio+bounces-25861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D8CC2E340
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 22:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD2D04E1472
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 21:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CC32D5A07;
	Mon,  3 Nov 2025 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA3CfMZz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64740299A87
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206910; cv=none; b=SRcMkNQyxmkXmQcEi3N4+ULktWpVmy1rYyP31XAyh9gWD0oZxDhN/yQU5sfcWUYtM71imo0mcqu4QlNVV1jWfxrlcGa3Ar1VrhV0TG4PAeBQ9HzlCSkDdPbb7FbHIiBxdPGN0RGg9EZ3XVbyxw2IPJHkmSAVbE3rXRV+XxYAlec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206910; c=relaxed/simple;
	bh=PqRD5AA9CQTIV/Fa/oHzoO1tcNy233SlClAbBJUGor4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VejungMqh2IbIcBl4z30hU5jr0uQAnEpWy8eOECsHXWjuM03ULqc/u16iz1FXMgUR8d/ojM6i0X6A1p/G7ZfnW3d+bL93Tv0InRWeaiU3JSHTJMjbbE4Dq+qjwWGobqeoNfwYHydAGuNtb8UFbOZh3attefkYK5FioCzF1eCowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LA3CfMZz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2953e415b27so27631015ad.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 13:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762206908; x=1762811708; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vr0AhTl2tnZbnbuQ/Lyma/KtCDNr4xZVutDV7GzLnVs=;
        b=LA3CfMZzLrQ6XLQZyRt0GaLcAsm5R8payqzB1LHKzw/LvAirTGwN4Uk0xXe+eT98ls
         LdRsZaqQxizvYR5AtVDfnMJZVynfKcEQ4HOvllbtXE6udxv1M8IVw/Knvse9wgVaaPHk
         9yWoKNYJJKiyv8aplUx6t7yqE2b/1Z67GM77uGWRSHW8pFRD29nCIibfoT+um3926l+U
         ZKBYQdvUba5DPt0ks/7kRanu4kGVh7DnH//mF/1sPGOtMWx+lwCY0F3ZCFBMhGTwEr9z
         XWPdgzenDumCXjlJi4IpeX4c3crZt5aMJeTljnUR6cAC4E0cwmy4cbfpN8IO009qJse4
         q6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762206908; x=1762811708;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vr0AhTl2tnZbnbuQ/Lyma/KtCDNr4xZVutDV7GzLnVs=;
        b=eYyM1ejOB++IJb+tVX6OsF8Oql1FbzZzNuTr+YuwV+J9haIebPFUhr6x6XCudzbf+B
         l26YQlExfvQdE+raX8xZUynzTDZlDqm8VrN6KWOyP7H/yaL5///uafupIY6KFe3gi60i
         ngFyXrhspwKqJ2RaVa2oZS8lreWTWWwZS32pXnqcLPJrNhlWDkew25Wu/2+i4NKuH3IQ
         yuwXTLbFdAI9QHqG40sU3/9uk16WM12g+qYq/bHxIrOO6kyvWxjLLgo1fKdAE3nXqrIF
         PmOWuIGUL5Pj/xw5I+s7f3moYH7dJg9kNclcv5mqhsYOua1qOYU8raUFDrnNLasRjJlt
         1vVw==
X-Forwarded-Encrypted: i=1; AJvYcCV5aXuzGDZgfOY0aENkTrIqA2mvs0mbNXPSYDt9PcsHrVEU3PzJtTh0lnyoV9ECL9JvUf6OoM8WfZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD3b17Oon3Ec2IzrdkUEd1SxFWt+EaW45aI1/HxRi8r7ZFUhSx
	gDp9eLIn2e1zgqfdYwnCu1d++ysNkZsrNOnXM9lUpSiooEijTXgEAQYj
X-Gm-Gg: ASbGncueAYxoQ4LWELMS1pEFw8Oj9SgV/XsaAuME1awJ320Gism4szcnYca4VQ32ST0
	tsLxgdSvzhqpN5kzvN81nUAwJ+yHCdDzjlKfSaZMeokBhv7odrbzo/7Mnn5CnfYH9nfuJtt/uLy
	oIIun1MPDSvpmmVXmwwOGLeu8ZdjzyD57NIg615KlcYtSrdlohDa1ziecMyS6/hn1ZrD6xZOmsO
	mjqrFIdH6RqpiZ5GOG35jMI/soIFj09fVqWe58bpD8tDZkSlNpZ2eFZeEHRzTzSHiCr8KV4rWDb
	9z37eg+hhD7pTZvsu4oJWyZJWZKzYqTdbUYnwZNQpIq8OK85EKxDXhVvwC4OH/Be1dMWVEHAnyk
	n7a7LN+Drgu7HXTL2CRN3ybN5kLdrpTx1lnFKZKU5gMHzbqRFKwKiMdsBMMVrTIMVMV8MYKdFDT
	bkEVbL6QB/Fu4CxlRmpq0d
X-Google-Smtp-Source: AGHT+IGf3rk/ZWnZ4nfGKqzMAbFFNABrHVTEBwI6MOLjfLVcyB9CbUYGpwNMYJDh1R03ToS7kGBkyA==
X-Received: by 2002:a17:902:f68f:b0:26a:8171:dafa with SMTP id d9443c01a7336-2951a38be8emr209211645ad.21.1762206907635;
        Mon, 03 Nov 2025 13:55:07 -0800 (PST)
Received: from localhost ([2804:30c:1653:6900:3b53:af9d:48d6:f107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29601a7a882sm1715665ad.109.2025.11.03.13.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 13:55:06 -0800 (PST)
Date: Mon, 3 Nov 2025 18:56:21 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v6 8/8] iio: adc: ad4030: Support common-mode channels
 with SPI offloading
Message-ID: <aQklBYl2drPil69Y@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1760984107.git.marcelo.schmitt@analog.com>
 <3fadbf22973098c4be9e5f0edd8c22b8b9b18ca6.1760984107.git.marcelo.schmitt@analog.com>
 <20251027140423.61d96e88@jic23-huawei>
 <aQJY7XizVWbE68ll@debian-BULLSEYE-live-builder-AMD64>
 <ca6760182b4662c96df6204bae903d8affa6a8e3.camel@gmail.com>
 <aQisqe5EWARTwpQq@debian-BULLSEYE-live-builder-AMD64>
 <1c3712b9b5313ed6c9d07c1acbc9b918a4883056.camel@gmail.com>
 <c365b17c-de18-4718-8d51-fa1d93236d90@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c365b17c-de18-4718-8d51-fa1d93236d90@baylibre.com>

On 11/03, David Lechner wrote:
> On 11/3/25 8:30 AM, Nuno Sá wrote:
> > On Mon, 2025-11-03 at 10:22 -0300, Marcelo Schmitt wrote:
> >> On 10/30, Nuno Sá wrote:
> >>> On Wed, 2025-10-29 at 15:11 -0300, Marcelo Schmitt wrote:
> >>>> On 10/27, Jonathan Cameron wrote:
> >>>>> On Mon, 20 Oct 2025 16:15:39 -0300
> >>>>> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> >>>>>
> >>>>>> AD4030 and similar devices can read common-mode voltage together with
> >>>>>> ADC sample data. When enabled, common-mode voltage data is provided in a
> >>>>>> separate IIO channel since it measures something other than the primary
> >>>>>> ADC input signal and requires separate scaling to convert to voltage
> >>>>>> units. The initial SPI offload support patch for AD4030 only provided
> >>>>>> differential channels. Now, extend the AD4030 driver to also provide
> >>>>>> common-mode IIO channels when setup with SPI offloading capability.
> >>>>>>
> >>>>>> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> >>>>>> ---
> >>>>>> New patch.
> >>>>>> I hope this works for ADCs with two channels. It's not clear if works as
> >>>>>> expected with current HDL and single-channel ADCs (like ADAQ4216).
> >>>>>>
> >>>>>> The ad4630_fmc HDL project was designed for ADCs with two channels and
> >>>>>> always streams two data channels to DMA (even when the ADC has only one
> >>>>>> physical channel). Though, if the ADC has only one physical channel, the
> >>>>>> data that would come from the second ADC channel comes in as noise and
> >>>>>> would have to be discarded. Because of that, when using single-channel
> >>>>>> ADCs, the ADC driver would need to use a special DMA buffer to filter out
> >>>>>> half of the data that reaches DMA memory. With that, the ADC sample data
> >>>>>> could be delivered to user space without any noise being added to the IIO
> >>>>>> buffer. I have implemented a prototype of such specialized buffer
> >>>>>> (industrialio-buffer-dmaengine-filtered), but it is awful and only worked
> >>>>>> with CONFIG_IIO_DMA_BUF_MMAP_LEGACY (only present in ADI Linux tree). Usual
> >>>>>> differential channel data is also affected by the extra 0xFFFFFFFF data
> >>>>>> pushed to DMA. Though, for the differential channel, it's easier to see it
> >>>>>> shall work for two-channel ADCs (the sine wave appears "filled" in
> >>>>>> iio-oscilloscope).
> >>>>>>
> >>>>>> So, I sign this, but don't guarantee it to work.
> >>>>>
> >>>>> So what's the path to resolve this?  Waiting on HDL changes or not support
> >>>>> those devices until we have a clean solution?
> >>>>
> >>>> Waiting for HDL to get updated I'd say.
> >>>
> >>> Agree. We kind of control the IP here so why should we do awful tricks in
> >>> SW right :)? At the very least I would expect hdl to be capable to discard the
> >>> data in HW.
> >>>
> >>>>
> >>>>>
> >>>>> Also, just to check, is this only an issue with the additional stuff this
> >>>>> patch adds or do we have a problem with SPI offload in general (+ this
> >>>>> IP) and those single channel devices?
> >>>>
> >>>> IMO, one solution would be to update the HDL project for AD4630 and similar ADCs
> >>>> to not send data from channel 2 to DMA memory when single-channel ADCs are
> >>>> connected. Another possibility would be to intercept and filter out the extra
> >>>> data before pushing it to user space. My first attempt of doing that didn't
> >>>> work out with upstream kernel but I may revisit that.
> >>>
> >>> I'm also confused. Is this also an issue with the current series without common mode?
> >>>
> >>> If I'm getting things right, one channel ADCs pretty much do not work right now with
> >>> spi offload?
> >>
> >> Yes, that's correct. It kind of works for single-channel ADCs, but half of the
> >> data we see in user space is valid and the other half is not. For two-channel
> >> ADCs, everything should be fine.
> > 
> > To me that is something that does not work eheheh :).
Well, yeah, I tend to agree with that 😅

> > I mean, going with all this trouble
> > to sample as fast as we can just so we have to discard (or mask out) half of every sample
> > in userspace (even though I can imagine we still get better performance vs non offload case).
> 
> If we are getting extra data to userspace, then either we aren't creating the
> SPI message correctly and telling the controller to read too much data or
> the HDL is broken.

The current patch set version (v6) only asks for the amount of ADC precision
bits in each transfer when offloading messages. I can't see how that would work
but okay, I'll test it with smaller xfer length.

> 
> > 
> >>
> >>>
> >>> If the above is correct I would just not support it for 1 channel ADCs.
> >>
> >> Currently, it's just one part that is single-channel (AD4030). If patches 6 and
> >> 7 were accepted, it would be 3 single-channel parts supported. I can add an `if`
> >> somewhere to check the number of channel, but it will eventually have to be
> >> removed when HDL gets fixed.
> > 
> > I would probably do the above or maybe we just need to push for an hdl fix or some
> > final conclusion (like if they cannot fix it for some reason) and act accordingly.
> > 
> >>
> >> Or, if HDL can't be fixed, then we'll need the `if` now and something else
> >> latter to filter out extra data before pushing to IIO buffers as mentioned
> >> above. Though, this scenario seems odd to me as I think the HDL wouldn't be 100%
> >> compatible with single-channel AD4030-like parts. We would be writing code to
> >> support AD4030 _and_ a peculiar data stream from this specific HDL project?
> >>
> >> My suggestion is to apply all patches except patch 8. IMHO, SPI offload
> >> single-channel ADC support is broken due to HDL IP data stream not being
> >> compatible with single-channel parts. That's not a Linux driver issue.
> > 
> > Well, it's not a SW issue but we are driving the HW and we know it's broken so I
> > don't see a point in having something that does not work. Given that this is so
> > connected to the HDL part of it I'm not sure it's fine to ignore that offload does
> > not work for 1 channel parts. 
> > 
> > Anyways, it's odd to me but ultimately if Jonathan is fine with it, I won't object :)
> > 
> > 
> > - Nuno Sá
> 
> If single-channel parts currently don't work and two-channel parts need [1] or
> a hardware descrambler to work with a single data line, then it sounds like we
> are blocked here until the HDL is improved or [1] is merged.
> 
> [1]: https://lore.kernel.org/linux-iio/20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com/

Ack, I think so.

