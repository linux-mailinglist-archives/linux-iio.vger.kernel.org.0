Return-Path: <linux-iio+bounces-22581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C49B20D3D
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 17:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1289C1886C3B
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65742DFA26;
	Mon, 11 Aug 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+bJADFG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AFD2DECA1
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925058; cv=none; b=P5d7TGrSX7wNuck9fxlDymYg89my+dUrcblGIrPVtFH1ePOP4d5qOfY4qccC7s/bMFEFaaGY4vt/2lw8cxTGoP04P/5cG7fyPYglEQGmVv9rk6gor9SkEFZ8e/E/Y5k4yrAQnaj0tlSnv+CPvsylYhFdQ/EXp4z2sw7MR1UNG6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925058; c=relaxed/simple;
	bh=hb035pWaK7vft56TxwXLgsSVgtRqam7pwS9jquNHILY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzCSVTLd4PG+QeEDanjvMssz/e/J2Il6pGHAfV0NWVlyS9v1vsbCD5Rudko7G2TvGE2G7w/H4q8N6gNw53zAzVWd/WKV1pDzibPiUuvVGZIYx8fbtX1bML1Jf8zi7jG4VcYwUDLapN3Pgj2dhMBGIm+73IKE0NwBNHfhD2/JNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+bJADFG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-459d40d16bdso30034895e9.0
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754925055; x=1755529855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EvyNGeCGush1eUR9stbhB/7hZ1ffunZtgtCpVkEsXQU=;
        b=h+bJADFGjTXbvVjbEoqFw5ex+xeK7b6KAC80354ekvX6lvz5jZVGTndPMtYg9AnDb4
         rpIi6nCOdvFGRHjUc2ykzAT/YmqsPYOHKlIF4g+DQ9qZxRDFmZ8NRS3mDI8igTaxy2tB
         wbZPA18Qz7csv465shlWvnpkUfcREYQ8pB6QA11To35qflLi4+qzdGX0FovKcye4JhK1
         EpwRDNoKlLsBUzcoe5y+kcQcN9n7sR5jviLSfq+vs1P3sjiFsB9WsNqJn7KSUw7eZRn3
         HS7guXftwoLW3X0QlVl7DcdtwNndn1XIADQq5BkAzP8Xpzfo6cJ/WjDwIZBmWN3HjQHS
         ZiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754925055; x=1755529855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvyNGeCGush1eUR9stbhB/7hZ1ffunZtgtCpVkEsXQU=;
        b=gD8+shhGnuLYoXobo0XTprLJ4K6GIunkegzScCSrjuu3sZefo6SK1Wq4nhORG4Utbb
         JgXhE3YdHg9Sr0vtOfI5v0uozsFjXhY7HA2IN/eUzjeAUv/8krFgg8nlTNgwIKDnbC8C
         ZzxDWGrYwRyXH6DViW8xHxbvmeU1p9jMlOiKN0rQTpdP03sg6QMMVuhOk8B2PxjMXho8
         RGhqGotxf8nLpspSJ2rTHVymeTty0EaUwkQDmGLvdBopJuyomx06OpoM5Hrh7L0a0Wd7
         ktchgJlVElU5L29gIZ/ye3DdceTAy3ZfqjXECakZ6SN7fH3XkTz+TtyjWDTH/xzts9lm
         z8tw==
X-Forwarded-Encrypted: i=1; AJvYcCXz9v61zGup2Upf2icT7Qf4xesFh2V+XdIGC887Z6gEsAJrp5fXK5O2Hq8KuX1qdQtuwNi4my+tWsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxluESUqk9jE12cKqwqQ9HKsPXnei9abUYkcejjP+EP6K5LGTLk
	m2ZNpRyspHyaa49TR/YI/eQhlbzmQ0zZxGH3v9Ep7mCjFEW+wx1eirCO
X-Gm-Gg: ASbGncv9ISieTPVJGmCSQcttDJURbvSuM5+Ggq6FH2+lCBHHrME1WwNjxCjc/3sBaBz
	S6MQGiaGgtzK4VRpHCvJfdeJtMPvEo2VodNov1LTTFpbi8L7OHJIX0BEJV6Nvf9ALTBLo4byxcJ
	8yMw0YRiSRfHBe2JmWH/kG10RVEPXZWgqf8cWp+CA309D11X1Ix/jgSEFpALHFBlLMhQXgyY+Ul
	QTp3e/R7RscUVenssqhgzbUMC1aprd4CsmQfYOunCYbQaGBWsu7pNEWCkNQybd5UYMDgB9HAEyz
	tK3NCs8PiysMkD6mwRy7GylZS4twadfNiumk6xRHxz0JDvMnm6d6aNORLh9NEIWdlr+K2n6tUB+
	s9szV4G3i2yAC6SUqk/BenDvd
X-Google-Smtp-Source: AGHT+IFKyeuRiuESbw2sOxFBCTTQXicWNpqEJHJ9ieyy78zvtplLl9N2ArCuL/F7zhciYQxps5i8pg==
X-Received: by 2002:a05:600c:350f:b0:456:1560:7c63 with SMTP id 5b1f17b1804b1-459f4f3dde5mr133269495e9.3.1754925054617;
        Mon, 11 Aug 2025 08:10:54 -0700 (PDT)
Received: from nsa ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5862be7sm273165655e9.15.2025.08.11.08.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:10:54 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:11:11 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: frequency: adf4350: Fix prescaler usage.
Message-ID: <4unnib32pyl6bcwitvbrjre6zigwcldncx3jczodrrk7i4pyvg@jz7hxq2xgn2g>
References: <20250808-adf4350-fix-v1-1-58eed5c07359@analog.com>
 <CAHp75VeXCrqzRFzNsMYHafRQ3SKztd-UaFKvvt_msh=O+Czb8Q@mail.gmail.com>
 <g7qklr4fx7qria6yeztybimqa26nyysmalbr7vbotjsojw63cw@6n36krmjw77v>
 <CAHp75Vcz1Syosz_uSOka2RCWP7-xiRB5f4iqmWkEPz12iLmkcQ@mail.gmail.com>
 <yvqbio6ip6zeycuccihiqnxpho4p7bpg6uk53zgdbwazlwpwkk@lozrfgb7ul7d>
 <CAHp75Ve-dYcD1j0n3PeRbUJO-8TR1ADyKp-u75sLysNp-uNxwg@mail.gmail.com>
 <ttos64aijdgv6tidi2iiweee2pf3fvu5u2a5hpijleeo533or3@nuaxva2ktrwc>
 <CAHp75Vdfqu6NEHuZXyTEo7aEhPEDjWbwBbk869TDH76SNruVig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vdfqu6NEHuZXyTEo7aEhPEDjWbwBbk869TDH76SNruVig@mail.gmail.com>

On Mon, Aug 11, 2025 at 04:53:52PM +0200, Andy Shevchenko wrote:
> On Mon, Aug 11, 2025 at 4:37 PM Nuno Sá <noname.nuno@gmail.com> wrote:
> > On Mon, Aug 11, 2025 at 03:03:30PM +0200, Andy Shevchenko wrote:
> > > On Mon, Aug 11, 2025 at 2:48 PM Nuno Sá <noname.nuno@gmail.com> wrote:
> > > > On Mon, Aug 11, 2025 at 01:53:20PM +0200, Andy Shevchenko wrote:
> > > > > On Mon, Aug 11, 2025 at 11:42 AM Nuno Sá <noname.nuno@gmail.com> wrote:
> > > > > > On Fri, Aug 08, 2025 at 11:56:23PM +0200, Andy Shevchenko wrote:
> > > > > > > On Fri, Aug 8, 2025 at 6:09 PM Nuno Sá via B4 Relay
> > > > > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> 
> ...
> 
> > > > > > > > +       st->r4_rf_div_sel = 0;
> > > > > > > > +
> > > > > > > > +       while (freq < ADF4350_MIN_VCO_FREQ) {
> > > > > > > > +               freq <<= 1;
> > > > > > > > +               st->r4_rf_div_sel++;
> > > > > > > > +       }
> > > > > > >
> > > > > > > This is a reimplementation of ffs()/fls() or similar calls. Do you
> > > > > > > have a plan to clean up?
> > > > > >
> > > > > > Oh so? Not seeing any direct way of using ffs()/fls() for achieving the
> > > > > > same as the above.
> > > > >
> > > > > Bit operations are hard, I know :-)
> > > >
> > > > Even more in the morning :)
> > > >
> > > > > r4_rf_div_sel is a power-of-two shift to make sure the freq is just
> > > > > above the MIN_VCO_FREQ. Of course it's just a subtraction between
> > > > > fls() of the MIN_VCO_FREQ (which is compile-time constant, I believe),
> > > > > and fls(freq). No need to loop, really.
> > > >
> > > > Yes, I agree the loop is not needed and if I got you right, you mean something like:
> > > >
> > > > if (freq < ADF4350_MIN_VCO_FREQ) {
> > > >         st->r4_rf_div_sel = fls(MIN_VCO_FREQ) - fls(freq);
> > > >         /* But then, you would need to re-check the if condition.
> > > >          * AFAICT, it is not guaranteed that we will always get
> > > >          * the condition right just by subtracting (or shifting freq til
> > > >          * the same MSbit)
> > > >          */
> > > >         if (freq * 2^st->r4_rf_div_sel < ADF4350_MIN_VCO_FREQ)
> > > >                 st->r4_rf_div_sel++;
> > > > }
> > > >
> > > > So yes, we can skip the loop but in terms of code it's not really convincing me
> > > > to bother in changing it. I also don't have HW with me to test it (but
> > > > it does look like a safe change though). I guess we could also use
> > > > ilog2() but I think we always need to recheck to see if we need and
> > > > extra shift.
> > >
> > > Yes, ilog2() to make compile-time constant for minimum.
> > > But also one may think more about this and come with the idea of only
> > > one check. I don't see why the second check is needed.
> >
> > Because if you just fls(MIN_VCO_FREQ) - fls(freq), you might (or might
> > not) get freq * 2^st->r4_rf_div_sel  >= ADF4350_MIN_VCO_FREQ (which is
> > what we want).
> 
> Yes, that's why I pointed out...

Yes, but sometimes you do get what you want by simply subracting and
sometimes you don't. That's why I had the re-check in the code snippet
above.

> 
> > > The question the code tries to answer is "how is the freq lesser than
> > > the minimum in terms of power-of-two multiplier?". I have that already
> > > done in some drivers. And that becomes fls_long(). See implementations
> > > of roundup_pow_of_two() and rounddown_pow_of_two().
> 
> ...these implementations. They accurately assume off-by-one cases.
>
> > I think the code wants to get the minimum value needed in order to get
> > the above condition (r4_rf_div_sel ends up being programmed in the chip).
> > Maybe I'm missing something but at this point (and replying to your
> > original question) I'm not feeling too convinced in changing this code
> > (more so given that I do not have HW to test).
> 
> Okay, fair enough. But maybe TODO in the code to make sure somebody
> looks at it again (e.g., me, if I ever have time for that)?
>

I personally have no problem with that but some maintainers do not like it
(rightfully so) because these TODOs tend to never disappear :)

So, Jonathan are you fine with it?

- Nuno Sá

> > > https://elixir.bootlin.com/linux/v6.16/source/drivers/tty/serial/8250/8250_mid.c#L220
> > > https://elixir.bootlin.com/linux/v6.16/source/drivers/spi/spi-pxa2xx.c#L820
> 
> > > > That said, I would ack a change like (or better) the above.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

