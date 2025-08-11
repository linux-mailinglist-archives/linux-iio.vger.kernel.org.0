Return-Path: <linux-iio+bounces-22568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6E0B20947
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 14:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A35D07B48B3
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907112D780D;
	Mon, 11 Aug 2025 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3n3CY3O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9935C2DEA75
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916537; cv=none; b=AbRobVCazAbOxhQG+KJ8BrL2tY5VU1jDlM1Iz7BwJy4gVvQV/lgDABmYRVgDz/UWYruvyqYOwof3zTrHNYltACUcYEVVcQYqA4aksPaaaAjl5PQvdORTSM/Lnjqhe4MHu1xk9+647a/pt2WTEoeTx/msdkDCHs70jMSGB3n0QfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916537; c=relaxed/simple;
	bh=v48hoezjPjhlQEThveAsFmyGqE3+0/r9BvOOods6BtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8yvmw8AFlXeNciYaxQY8eXDb8ecyXEygxw9saqoXj2rSteoqlv4wdlmn8NTqKCl7Bsuma5Zt02PoIx6Of/keIpv5ySU6SeVvO4QC2J4BdzLmQqIEPw0wmfudGwXhk5B8ONwUSbXKZu5aztNiviOuD45P3T+9ucMEqxS+/f8m4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3n3CY3O; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-455b00339c8so27076615e9.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754916534; x=1755521334; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6EfTBGDAXDzgM7XWolNCUyJTyiA8Mcs3y4kxI1uUOm8=;
        b=H3n3CY3OgQhoG2hrlvPyDo07nrQUTSTS2xUpoZi0J5OPdhLULI5xJKdbR26icXkp9u
         OjehlO21iscV6WN/cTGyTWQPPILCjRVE649U0VtnKn9XL9+fhAet4XJzljgTP+qyuuIj
         vMQGdiDuwWMX43ZfxwWy7yQzK/5afwvwmUHtooAdSQ7gCbTQ+NpaBf6jhCM6GeM9roLB
         Tr/YcS6i30AQ2AfumlRQdTs1z1GiWGC4Vj83e/J7Fx1r4rM+qcIuXRZD4lJfFkJDMQmW
         Hd266/uxxgIuNC5diWKELkrLdEtnFmk2iPQUZ6B18+bF+SpoASe+TBh7O4mwto4bW6Gh
         F/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754916534; x=1755521334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6EfTBGDAXDzgM7XWolNCUyJTyiA8Mcs3y4kxI1uUOm8=;
        b=vrjykBlIodSCj0vj/n+mPBTpiRR81kJxsj63jYXZMV4X/YhhjDJTN2YfnQbJr7ZP6m
         pYUWzRJkulU/uEE/ag1jkj+nw053eA/bZElgy6Ikp6d7eD4JHczv453jr+wEnIUjc1F1
         hi/OpXcPEewiFxIAStPcFVNGCyBQU8E+MHhi2MjJnYSBvMZU997EF03QkZ20AaTfeHNt
         6QlrVMj7ymLA6AwVNFG3yEPq1vTvvgY4pek5rhaKmMGwcqktG03VOM3bg77Q+tzsq5oE
         16VzYHRGPVCcS/HAcLZzhdygM/dDwaTWFkwGXjbvDE3ijK7pypGnfmEDOwMCZWq75ys5
         pSYA==
X-Forwarded-Encrypted: i=1; AJvYcCUfjbny8Y1fVIZF2Ixsit+GtYVMZMGQIWB2qrNlO0OeOrZ7Zk8RPQNeTLR7ckh2+xySyRh4fSwiXUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEAFN5jV1ZRORwJnEdfzd4RV2K28mZ6ip5xcXybN4eWME6zKMO
	oiiQVxLnhO0Y3yNQsAeBF52+AUsGvW8LTIkQF3Qiqi14YT9se59QHj8FnHELhEhH4a3CMw==
X-Gm-Gg: ASbGncu80q/qcy1Kgd5ek3GniY8lAgr/GVuobMcgtcB7jQwDpsMl5FnSJJ8iU2O0cNO
	I5UiIDXaJXLKzYmjj7W81aA/IkzHdq2h8ascP5CcyG4kWG+95pmwv+xlnD0PcMqNoKdhayTc3tz
	1UFsb5oGReYnKqt4CjaoxfXb6EMGg4FbCitGzOKtxx6JMb9FFXASP56Af8FPbaXVngJsnRrxP2e
	2yrp6AZnrEehLdY53I52GtO6CpeLY897BJ9oFjnOUg6IGnmHsoVo0DJxGt/jEmeZWkh5RWC+pTB
	5jqh3gvA3M8KvRSokooI4nwbUsFflyMxcCI6bw0PTq+IkCJ2H8C4/oYMQw//kB5O7ZBz+QDGPY5
	hYSVjemxJYJi2hw==
X-Google-Smtp-Source: AGHT+IFf7H9h/qdi1SvJ9cxaDFkx6cSAup3NZEji66VPmKCCWIwIBHDUyXZj7ieZpmxKD7a9XA5t6g==
X-Received: by 2002:a05:600c:4509:b0:456:201a:99f with SMTP id 5b1f17b1804b1-459f4f97f7fmr129000065e9.18.1754916533695;
        Mon, 11 Aug 2025 05:48:53 -0700 (PDT)
Received: from nsa ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5852e28sm250221945e9.9.2025.08.11.05.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:48:53 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:49:10 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: frequency: adf4350: Fix prescaler usage.
Message-ID: <yvqbio6ip6zeycuccihiqnxpho4p7bpg6uk53zgdbwazlwpwkk@lozrfgb7ul7d>
References: <20250808-adf4350-fix-v1-1-58eed5c07359@analog.com>
 <CAHp75VeXCrqzRFzNsMYHafRQ3SKztd-UaFKvvt_msh=O+Czb8Q@mail.gmail.com>
 <g7qklr4fx7qria6yeztybimqa26nyysmalbr7vbotjsojw63cw@6n36krmjw77v>
 <CAHp75Vcz1Syosz_uSOka2RCWP7-xiRB5f4iqmWkEPz12iLmkcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vcz1Syosz_uSOka2RCWP7-xiRB5f4iqmWkEPz12iLmkcQ@mail.gmail.com>

On Mon, Aug 11, 2025 at 01:53:20PM +0200, Andy Shevchenko wrote:
> On Mon, Aug 11, 2025 at 11:42 AM Nuno Sá <noname.nuno@gmail.com> wrote:
> > On Fri, Aug 08, 2025 at 11:56:23PM +0200, Andy Shevchenko wrote:
> > > On Fri, Aug 8, 2025 at 6:09 PM Nuno Sá via B4 Relay
> > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> 
> ...
> 
> > > > +       st->r4_rf_div_sel = 0;
> > > > +
> > > > +       while (freq < ADF4350_MIN_VCO_FREQ) {
> > > > +               freq <<= 1;
> > > > +               st->r4_rf_div_sel++;
> > > > +       }
> > >
> > > This is a reimplementation of ffs()/fls() or similar calls. Do you
> > > have a plan to clean up?
> >
> > Oh so? Not seeing any direct way of using ffs()/fls() for achieving the
> > same as the above.
> 
> Bit operations are hard, I know :-)
>

Even more in the morning :)

> r4_rf_div_sel is a power-of-two shift to make sure the freq is just
> above the MIN_VCO_FREQ. Of course it's just a subtraction between
> fls() of the MIN_VCO_FREQ (which is compile-time constant, I believe),
> and fls(freq). No need to loop, really.

Yes, I agree the loop is not needed and if I got you right, you mean something like:

if (freq < ADF4350_MIN_VCO_FREQ) {
	st->r4_rf_div_sel = fls(MIN_VCO_FREQ) - fls(freq);
	/* But then, you would need to re-check the if condition.
	 * AFAICT, it is not guaranteed that we will always get
	 * the condition right just by subtracting (or shifting freq til
	 * the same MSbit)
	 */
	if (freq * 2^st->r4_rf_div_sel < ADF4350_MIN_VCO_FREQ)
		st->r4_rf_div_sel++;
}

So yes, we can skip the loop but in terms of code it's not really convincing me 
to bother in changing it. I also don't have HW with me to test it (but
it does look like a safe change though). I guess we could also use
ilog2() but I think we always need to recheck to see if we need and
extra shift.

That said, I would ack a change like (or better) the above.

Thanks!
- Nuno Sá
> 
> -- 
> With Best Regards,
> Andy Shevchenko

