Return-Path: <linux-iio+bounces-22577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AACC5B20C45
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 16:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59713ACD66
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 14:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B72253920;
	Mon, 11 Aug 2025 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlC2EYPz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC1DDD2
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923024; cv=none; b=HsaCRlvdTxXTi9E784uMTavZpInRpZYlUnA2uB70KVfRl6SimanUdf7s+HHF8p7quirlbDNx5Hn0/wolp3jGHvGo1F0Dq3q23xUOklEKMkV+7NLN0U6QWtz4XZzY1JXomJBrVFkE8ZN7EuK6YpHq+Z/N/8c83R78TuosKFIIRJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923024; c=relaxed/simple;
	bh=d4+R6AmaEr4qV87qAlyPw/P8q29IBL0ijEuSesdpHpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeN2/Dv4yP+d8H42VdxoDta57J6YIhfXuCJlxOBd/GaokJ9gbViDwaWBLTbgILhoSqEhE0Tio7YUXyyJihNlvxEKHF88ZhhY5zAWqDIQ14PKCJRiBFHtSXRaCxO6/oJZCN0u7x7i+cfDrsDo7oVSOy6kGzlL7FaPaZlarKkyUmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlC2EYPz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-455b00339c8so28114485e9.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754923021; x=1755527821; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4v3XIwc2u3z14KPyzS3dYNWVMRJANQbpqz1AUhDIi9M=;
        b=QlC2EYPzD1XMheLk0Vrn4/wlzTZLUqcjQv7elVeonfXD8be/t8E6sAPEoEKn/Tm+rY
         1I1gpFRvqFaTPqvMHmUNDOIgkifezrxKXpb3us4BCZMnH/lNORq2fxRa6V5YdKyVdozh
         8QGwLAGubWeeleg++VROxysWX7k2UaM2qAWPjvdrjMbiTty5XYv+Xd5Ve4Bf/qqgOArA
         CoICBi9gKq4L1bwj5DvrYv20Yl3gCGBPCglOi/9z40aPhOY4TZN05qRIK86/b7tJA1NT
         0xz2Tr0eCbc3TMjiG6cxTEIHpN8bblRBSTOj4Q+0hOohX6qHe1p3FPnQ8Ydl3zPSeoes
         k97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923021; x=1755527821;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4v3XIwc2u3z14KPyzS3dYNWVMRJANQbpqz1AUhDIi9M=;
        b=oiGGdJTVTJjDWGD6wIpexPfTW3xqtD57ngyrRzct42O64N/D0v2cCIlYsbGNZo9NVz
         RRPZf+YO8Zgp8mHnpu7YACdrPZOlj1mPQFqru97yzFCkrIjyUX9nCOXmW9/fuN7D2bcA
         yuQNqsf4RtFVo4ucZqnDBx9AcVFLjKTD+Ynr7NU7/9fPMfghOStSksptMjGfu6cdjruI
         FB7NfOdX9+MGC50RI9N2R/lbIzkBv515JwidXw3xJu4NdgLxCYfYh8cCD+8QlmE7Dh24
         8EjyGXdHGGNIn/lXoYy3ZKSliCsbs46YAVqd/816CuDCftqLp2/LoXbBl+vRUg7QN+HF
         C5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQR5WIcCCKPdSFRU87EmnAyeI2oFXw2hzGRpimWDDeK1wA0U60dwo5vbbLSZzZ/CrAx/yp+hInWGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1jhMcJjG4PK0xmKJttzseejtau5OIk90mhHfG8qwH0tJwt1d3
	CO3TwK1+pBci5iYY6WGGAbBZJsueh7qjrUKeE8sssnLhPic9f+peIqfp
X-Gm-Gg: ASbGncsbrMXhOmDFg5B/JdXIgKni6sDEZR2CSV+SBC32FG3gNgZwEeMDFywCYc+wBhD
	bkWnnDTM6ZU3AhKah01b86g2Ef9OGmDsO/2/3nIG90z4f9BYfchFSIuuvyIUc+gyLleanlk1yaS
	QOQpac0MAGuIM4c4U8OK/xriVo7N2HSarMRGsjwnNA7PNDtUJ80JN3JJp82foIy7TVaOz61PAUU
	/qzDfvDmf007S1P53rPOJxehCA++pfHT+y8A/k4G7kGefBDaMn4SKCkQnfGSOXzpqDwdR+QHLn7
	WBprbtj53Mzr8taFYLQMk9cGPBDW3IFmaCb3p/rNB5Q3TfJlar0H9o7mrpQfh91FSNlfAMo1BGl
	UCRY6C6cX5nu/rbBQFiKTClaC
X-Google-Smtp-Source: AGHT+IGWedYGe8GNda6oNPa1RipPRtcdCDLhlhZHUDkHXPy2K359TG4tWX2URccuol+Xd57s3nK+/A==
X-Received: by 2002:a05:600c:1c18:b0:459:443e:b180 with SMTP id 5b1f17b1804b1-459f4f3e153mr122848855e9.8.1754923020887;
        Mon, 11 Aug 2025 07:37:00 -0700 (PDT)
Received: from nsa ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458bb04c612sm376853835e9.0.2025.08.11.07.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:37:00 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:37:18 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: frequency: adf4350: Fix prescaler usage.
Message-ID: <ttos64aijdgv6tidi2iiweee2pf3fvu5u2a5hpijleeo533or3@nuaxva2ktrwc>
References: <20250808-adf4350-fix-v1-1-58eed5c07359@analog.com>
 <CAHp75VeXCrqzRFzNsMYHafRQ3SKztd-UaFKvvt_msh=O+Czb8Q@mail.gmail.com>
 <g7qklr4fx7qria6yeztybimqa26nyysmalbr7vbotjsojw63cw@6n36krmjw77v>
 <CAHp75Vcz1Syosz_uSOka2RCWP7-xiRB5f4iqmWkEPz12iLmkcQ@mail.gmail.com>
 <yvqbio6ip6zeycuccihiqnxpho4p7bpg6uk53zgdbwazlwpwkk@lozrfgb7ul7d>
 <CAHp75Ve-dYcD1j0n3PeRbUJO-8TR1ADyKp-u75sLysNp-uNxwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Ve-dYcD1j0n3PeRbUJO-8TR1ADyKp-u75sLysNp-uNxwg@mail.gmail.com>

On Mon, Aug 11, 2025 at 03:03:30PM +0200, Andy Shevchenko wrote:
> On Mon, Aug 11, 2025 at 2:48 PM Nuno Sá <noname.nuno@gmail.com> wrote:
> > On Mon, Aug 11, 2025 at 01:53:20PM +0200, Andy Shevchenko wrote:
> > > On Mon, Aug 11, 2025 at 11:42 AM Nuno Sá <noname.nuno@gmail.com> wrote:
> > > > On Fri, Aug 08, 2025 at 11:56:23PM +0200, Andy Shevchenko wrote:
> > > > > On Fri, Aug 8, 2025 at 6:09 PM Nuno Sá via B4 Relay
> > > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> 
> ...
> 
> > > > > > +       st->r4_rf_div_sel = 0;
> > > > > > +
> > > > > > +       while (freq < ADF4350_MIN_VCO_FREQ) {
> > > > > > +               freq <<= 1;
> > > > > > +               st->r4_rf_div_sel++;
> > > > > > +       }
> > > > >
> > > > > This is a reimplementation of ffs()/fls() or similar calls. Do you
> > > > > have a plan to clean up?
> > > >
> > > > Oh so? Not seeing any direct way of using ffs()/fls() for achieving the
> > > > same as the above.
> > >
> > > Bit operations are hard, I know :-)
> > >
> >
> > Even more in the morning :)
> >
> > > r4_rf_div_sel is a power-of-two shift to make sure the freq is just
> > > above the MIN_VCO_FREQ. Of course it's just a subtraction between
> > > fls() of the MIN_VCO_FREQ (which is compile-time constant, I believe),
> > > and fls(freq). No need to loop, really.
> >
> > Yes, I agree the loop is not needed and if I got you right, you mean something like:
> >
> > if (freq < ADF4350_MIN_VCO_FREQ) {
> >         st->r4_rf_div_sel = fls(MIN_VCO_FREQ) - fls(freq);
> >         /* But then, you would need to re-check the if condition.
> >          * AFAICT, it is not guaranteed that we will always get
> >          * the condition right just by subtracting (or shifting freq til
> >          * the same MSbit)
> >          */
> >         if (freq * 2^st->r4_rf_div_sel < ADF4350_MIN_VCO_FREQ)
> >                 st->r4_rf_div_sel++;
> > }
> >
> > So yes, we can skip the loop but in terms of code it's not really convincing me
> > to bother in changing it. I also don't have HW with me to test it (but
> > it does look like a safe change though). I guess we could also use
> > ilog2() but I think we always need to recheck to see if we need and
> > extra shift.
> 
> Yes, ilog2() to make compile-time constant for minimum.
> But also one may think more about this and come with the idea of only
> one check. I don't see why the second check is needed.

Because if you just fls(MIN_VCO_FREQ) - fls(freq), you might (or might
not) get freq * 2^st->r4_rf_div_sel  >= ADF4350_MIN_VCO_FREQ (which is
what we want). 
> 
> The question the code tries to answer is "how is the freq lesser than
> the minimum in terms of power-of-two multiplier?". I have that already
> done in some drivers. And that becomes fls_long(). See implementations
> of roundup_pow_of_two() and rounddown_pow_of_two().

I think the code wants to get the minimum value needed in order to get
the above condition (r4_rf_div_sel ends up being programmed in the chip). 
Maybe I'm missing something but at this point (and replying to your
original question) I'm not feeling too convinced in changing this code
(more so given that I do not have HW to test). 

Thanks!
- Nuno Sá
> 
> https://elixir.bootlin.com/linux/v6.16/source/drivers/tty/serial/8250/8250_mid.c#L220
> https://elixir.bootlin.com/linux/v6.16/source/drivers/spi/spi-pxa2xx.c#L820
> ...
> 
> > That said, I would ack a change like (or better) the above.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

