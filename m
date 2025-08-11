Return-Path: <linux-iio+bounces-22560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80936B204A0
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 11:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2C93B3E04
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DC6212B05;
	Mon, 11 Aug 2025 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6mBVeNN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822591A5B86
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906070; cv=none; b=h21rLSRJBQMTSb7sXyleAHhwia/gjkGdLAfyVc0xaZJlAvAeKXPpYNfkK/iZaCTPvrfJrRN6McGbFX+AFz51U82lyOehnDrbLIEMKVOGliF8wvDVXGvrtWGeDxRQM/Km68N7iDa+88PcFpmRcE+Hz48TiaD9XhsnyUqLd1tanOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906070; c=relaxed/simple;
	bh=SbE6kdIUu8H7Muv8nz91QkcbE9lSwdtwWrsnuNJv8W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYrAZf+BendvTiMmhlmYgJJJCEI0d4VDEA57f0eZbVv1uIvGKhNUE3qiY4xhghTOS1flT/mNFWnWu/yc5rgsqUxIA+5V42wiAbns8wd0Zwk+NTHdm7OAUlf+vrE0s/1ZdCsgThCr8ZoxsQECKopBpFFaTYho4qdsUQYOQR/Q40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6mBVeNN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so28186535e9.1
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 02:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754906067; x=1755510867; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xh7Cuz5rC90UUv76okc0PUoI20TRweptyTlSuBd1b+8=;
        b=T6mBVeNNVgm69rjGoYUqnXdMWwO4UnwKR7+AGKXoUqng4Jt6+FONDEDrXSY4dzMHtE
         ZM5Gykvgpvh02pl/mnKCO5CzvamCT7VsVNf19xJ0qP+eJj5Zk32qABPj9YbrK8HSVnpS
         8ZZOqp3tlKxq4PNLas6smRWIrQNKE/U7mpueBny/291NRZVDbydTsG/iYPLW0i1/4Jp9
         DP2Bko04A4+mZkn6s9Ftgk3IRpYXnI1ko1jjQowGbKHwTtoNwscXtlSAFCNDHwysyhMa
         h0+ZJU85+x3CTycPyeRmYGrX43jL+cVhApNas7y0Av5AtmS88u5Jg7hrjTSxRfGJp8TO
         oBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754906067; x=1755510867;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xh7Cuz5rC90UUv76okc0PUoI20TRweptyTlSuBd1b+8=;
        b=ZTAjB3LeyeNhH8RtgY2ZA1pNqR0GrySHe1vaMJ0r+U2V47OvuIsg6hTdJCywnJH8eG
         KLhs0OdrGrN7t7B34zvfKp+Au86PWVrtSCLB1kK1A/kKEjjsZu1MRf0bo3Aw8dlmOSx2
         7s9ucl70un93tqMEOoYU3YWVXgeWQtWLnGF5UzE5tEEPM3xMq3vOMUV4yLUDx4eGxeAi
         /7XnjDqK4YGeAq8DGEfmIgeq7FEnUdIfytytY7V3EZRJIzf/kT2Fs4I7/wEZjijtn7Ac
         h41B/qRO6yTiDnKDT2q3bVyk83dTtn0rf0i1F9WpglfkrTZZXaixDh0o2cCYVpmrxPpn
         48Cg==
X-Forwarded-Encrypted: i=1; AJvYcCW9HH+9X8VByMqaCWeP9YmR+CToMb3cN5C4PU2P0ejOrb6ibxzhaWstDZmBC8zKZy8OjEv3Ah7p9Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3zPG+LJqVV0whW/lTdMrSuE8IxGIDnxSwym2LY81v3mx3hoxf
	7Slpmx7ojd/vNUz/LgzhfgWjJkMO5Nfnhfu1eiUKn+ds8wTnRi90gqiEq+CK31afdh/vDQ==
X-Gm-Gg: ASbGnctdlbo1lpEcnn6lLAiVTTfeZy0QCP/GLcCNH1fB7HNHhie0YUbk8UiZItiPNTv
	lKoKSIc0OY7KeXfXgPv8jcfaMTAFDAfgE3v5jUKRauG4Mtn5Lm56YlJkVMUh2a2pEa2+/zTRpaK
	Mhk+GqTrMSczWiTZw5e8Vpp46THl32KGBVsreGhiMel6SHaMq9iCN6g8vqhFnkIFvHAKb2hgSvm
	FaIKrphR9tll5ItUXaWIMLoKrCD5UUQSZtsEqbggUwrqAXmeaWSxNo8gGg0rxIKcDxBLkjtck84
	kPsVfjrwtcY3gaXym6aihR77DdXz/Y6c5tMC7wZwh76R04PF2tt2vWO7iO1CcwmtqL3ZRnVzoB/
	XopC00P0dlWJ+2w==
X-Google-Smtp-Source: AGHT+IFmPR30jHS7NHjeB3f98BpOrBbtqsa/UBcQjkainAGHZVJjT9Ggam5xlNf675x10NtH66x8Pw==
X-Received: by 2002:a05:600c:3b86:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-459f4f3e88emr123352705e9.3.1754906066265;
        Mon, 11 Aug 2025 02:54:26 -0700 (PDT)
Received: from nsa ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5868fd7sm263713755e9.18.2025.08.11.02.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:54:25 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:54:43 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Shen Jianping <Jianping.Shen@de.bosch.com>
Subject: Re: [PATCH RFT] iio: Fix core buffer demux failure to account for
 unwanted channels at tail
Message-ID: <ntyiwxlni5t76wbatwdbre77vjawl3ocdtv2tdt5rhhahi546f@43be2gqldvln>
References: <20250802171539.518747-1-jic23@kernel.org>
 <73r5iyaprblcalagi7gt3bxjdnoudfyagwgz3n7dvmjhzjvure@2yekmv62faa4>
 <CAHp75VcuWfQtxrhdZeX4cZ3aNnCZb1mKbZaUPVwF8oOnfpPcFw@mail.gmail.com>
 <zaymyis6xp4t6qz6se2xehj4gp4lzaybuu2vzabew3pxqoxtsf@36dykzwuloq6>
 <CAHp75VcWepvA73Pv=JHZn3BAnnO=NcaEvU85p2yQrVJW_pXFmw@mail.gmail.com>
 <20250806163613.00003788@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250806163613.00003788@huawei.com>

On Wed, Aug 06, 2025 at 04:36:13PM +0100, Jonathan Cameron wrote:
> On Tue, 5 Aug 2025 14:41:03 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Tue, Aug 5, 2025 at 10:16 AM Nuno Sá <noname.nuno@gmail.com> wrote:
> > > On Mon, Aug 04, 2025 at 06:02:22PM +0200, Andy Shevchenko wrote:  
> > > > On Mon, Aug 4, 2025 at 5:37 PM Nuno Sá <noname.nuno@gmail.com> wrote:  
> > > > > On Sat, Aug 02, 2025 at 06:15:39PM +0100, Jonathan Cameron wrote:  
> > 
> > ...
> > 
> > > > > > +     /* Walk remaining bits of active_scan_mask */
> > > > > > +     in_ind = find_next_bit(indio_dev->active_scan_mask, masklength,
> > > > > > +                            in_ind + 1);  
> > > > >
> > > > > I wonder if it matters to check that in_ind + 1 is in fact lower than
> > > > > masklength? Not that it will be an issue for find_next_bit() but we will
> > > > > fail the expectation:
> > > > >
> > > > > if (unlikely(__start >= sz)) [1]
> > > > >
> > > > > And being this a sensible path, I thought it's worth (at least) questioning...  
> > > >
> > > > It doesn't matter. The find_*_bit() are all aligned to return sz for
> > > > anything "not found anymore" cases, so it will be okay.  
> > >
> > > I know :):
> > >
> > > "...Not that it will be an issue for find_next_bit()..."
> > >
> > > I was mostly worried by performance as we'll have a compiler hint that
> > > will pretty much fail (that ´if (unlikely(__start >= sz))' for every sample we push and
> > > I guess the CPU will have to unroll that prediction. Maybe it will be smart enough to
> > > adapt.  
> > 
> > Ah, I see now. Yeah, there might be a hint to skip the branch which is
> > unlikely() for.
> 
> Assuming I remember how this all works...
> 
> This doesn't happen on the fast path (pushing samples)
> It's a setup activity on a buffer being enabled.  The code is
> generating a table of offsets and sizes that are then used to
> on every sample.  So I don't think it's worth bothering to optimize it.

Right! For some reason I assumes this was running on every push (which
would not be a great idea anyway we did it)

That said, the change LGTM:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> 
> Jonathan
> 
> > 
> > > But as I said, it might be neglectable but still worth at least
> > > questioning...
> > >  
> > > > > Other than that kind of nit comment, patch looks good.
> > > > >
> > > > > [1]: https://elixir.bootlin.com/linux/v6.16/source/lib/find_bit.c#L50  
> > > >  
> > > > > > +     while (in_ind != masklength) {
> > > > > > +             ret = iio_storage_bytes_for_si(indio_dev, in_ind);
> > > > > > +             if (ret < 0)
> > > > > > +                     goto error_clear_mux_table;
> > > > > > +
> > > > > > +             length = ret;
> > > > > > +             /* Make sure we are aligned */
> > > > > > +             in_loc = roundup(in_loc, length) + length;
> > > > > > +             in_ind = find_next_bit(indio_dev->active_scan_mask,
> > > > > > +                                    masklength, in_ind + 1);
> > > > > > +     }  
> > 
> 

