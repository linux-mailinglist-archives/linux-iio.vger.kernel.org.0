Return-Path: <linux-iio+bounces-26738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E3ECA4235
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 16:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7FD630F8966
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 14:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056CB274B3A;
	Thu,  4 Dec 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG0T3Fh3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2D027E1C5
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860223; cv=none; b=F41Da3eJNnb9B3N/o9k7S8BOhxb6EPSEX2Xse3gIoXCjeaKPjsfgwa8nGHh/6Gx0o0/3Q2CLtPSqc8/yGvV1hsUOiLueBEIyeC25wrjKvGAvJmLFVP+p4HGS5k1cWdLTTBrcNmcMmC8KH1Zu569cVoBi2j3zMLF+6B2D2IcT28A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860223; c=relaxed/simple;
	bh=DmGA7BObSUj1+jIGm2JkkYZJxXyx0jrdxG5OhKc0kls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjI+KRHHQXF5zy6/dec59S5M6npRaADrDgQK4LMLVCPu5b4EOOvWD85KXG3hgn1VpGOhZJib+zZ6srhX1KL0YiF41oreUbO++CWvWOz35atTAWLyxG3kGV7LodCn0+frbGaNALmaMcMPVMXbEBX/6n4XcMumSR7k5AEeW4dINEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG0T3Fh3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso1132601b3a.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 06:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764860221; x=1765465021; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a8pMVI5Er56IlfICxxOmm0dvDCyFgiwBCg6aWLDR4js=;
        b=JG0T3Fh3JG7fbKr/+Kkt2A+4MLUsP9scPw3Y4z3fijdYeCGpYR0NUx262qMKUSJsqb
         aa8AByFistbaMpwv0zOn4pvSyJgb89GNmqQX8IX6bCC7WMELFosD4AX+afA83K1CAEqk
         ZXX054rltIBPCgshL2sEIDYF09SPkihGVAPbeUHz/6ZnkA4OexGh5B1PNHx7/pE+2AO5
         rAv9xXn+0Lu56Tf7PGwH9ERKsomX4dMFl2yG+XTOJht/JVy/P/jCaOXJfbFCvIT9Sn0m
         9BHJAM4mOJnKhoHiey+xJr3hVmPsoPgSqTRs9gYyYYpyo/zztBC/jLUV4eiH10NaS9jr
         mO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764860221; x=1765465021;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8pMVI5Er56IlfICxxOmm0dvDCyFgiwBCg6aWLDR4js=;
        b=ToJggy/9jCOsF32qtRBM0sA2ph7V0A83jqSETQgtdVjEzZZsYZoBJAAYMkza7SX5qo
         D7ypk59nlfYl5P0RpDjcYwQNAmgqAu+UdAqEb24q4qkH+FRldrIucmLL59ngtcq/uBsL
         CTF63uFSyYpZYpFLjOwVWHb8HPKNaSy96t45hSkaewZe2yjPD1PPvVkaaV+TDgGnSLen
         X5U/zE6cKRKOyl1WNli1U17R3yLH6WPWSFsi8yWplWkoNyGnHLKk7KLSdrFp1gLOVkbw
         5oG5LnEvuYFgX678LgAbRGu4GJpweBsQy4Bz7PjXX1wT/kbZmln5tJBmwD5Z/7tjWSd9
         4RoA==
X-Forwarded-Encrypted: i=1; AJvYcCXvjDOGCn0jPExnzUi6B7vtp9UoEoDQeeAqCMcoQG3QVQXy2TcICpuHVKSnF77g4e2cB12tn7wVWu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOg2VhQpayxdLmZ43cH+Gv10Zx7Yrh0PF9w0ASzicYgFYILQ3
	v21dmmbJWS7v3+qvPL1X9p06r534FxF/ehvPBdnvrOUt984uS0f1HLMa
X-Gm-Gg: ASbGncvZceACDh665eu8kMBI8Mq3aENeNI87N0PqK3MbE1RUTmV4E/trrRrehcRO7k2
	rCekfVpgpzZcR31OksYUa56e6/wAyFMhFygJsDU7a5GxfBpU9fULrgfxWVQ3KNJpFUEJv3ZoyxW
	2MxTAqaazWfyYzLMxtJdbwqxStCrFqTNKwSmz8FB5rpbjKJ7jvdvvAeWMW/Rjgfc0DMWBs4tXxh
	QRWwV29hySTKaOjUCqU45c02RDCG9piCnOZmqQXhZZg3bWuPdDIxxZ//IB2LXZr2g6M7ifb3Lu8
	Yf9hL/QfAZfG7u82mwHhzlyaE72bMiyRNsRLD9r2Us6uYxJlOxVgquKmJcFkoEJUFqDlbNQAOlg
	4/9afGhTSEC9WFOGWglUguTe6fhQVwENtUeixHQYrgxBJhLNMjUcKnYqj7QMBbHkMghLEOr+Q9Q
	bei3TqkY7yRaD96jez56KtCe6IXe6qyg==
X-Google-Smtp-Source: AGHT+IFSFj9LiSB/ZQRNyTtaPIMQVQOWKHnwdBDVXSz1iz5nNQ4hgnCsZfBc6hoHlPzvzqzMWY7GiQ==
X-Received: by 2002:a05:7022:429a:b0:11a:29e5:12e5 with SMTP id a92af1059eb24-11df0c3cb64mr4968973c88.30.1764860221504;
        Thu, 04 Dec 2025 06:57:01 -0800 (PST)
Received: from localhost ([2804:30c:941:4500:2e30:10b5:73b0:4b74])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-11df7552defsm8413736c88.2.2025.12.04.06.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 06:57:00 -0800 (PST)
Date: Thu, 4 Dec 2025 11:58:34 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v3 2/3] iio: adc: Initial support for AD4134
Message-ID: <aTGhmgsRmphZY92X@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1764708608.git.marcelo.schmitt@analog.com>
 <c189c25b1c46f406c3f7942e5ac4cdb0b964ee52.1764708608.git.marcelo.schmitt@analog.com>
 <CAHp75Vf7p=aPy2ofC_zVz1PURA3R9i0WZCG63-dCEXO=xKJ0FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf7p=aPy2ofC_zVz1PURA3R9i0WZCG63-dCEXO=xKJ0FA@mail.gmail.com>

On 12/02, Andy Shevchenko wrote:
> On Tue, Dec 2, 2025 at 10:55 PM Marcelo Schmitt
> <marcelo.schmitt@analog.com> wrote:
> >
> > AD4134 is a 24-bit, 4-channel, simultaneous sampling, precision
> > analog-to-digital converter (ADC). The device can be managed through SPI or
> > direct control of pin logical levels (pin control mode). The AD4134 design
> > also features a dedicated bus for ADC sample data output. Though, this
> > initial driver for AD4134 only supports usual SPI connections.
> >
> > Add basic support for AD4134 that enables single-shot ADC sample read.
> 
...
> 
> Bart converted it to be an aux driver and it should work. Please, give
> a try after v6.19-rc1 is out.
> 
Ok, from yesterday's disscussion I see I should give rest framework another try.
For now, I'll rebase on top of linux-next to experiment with the new reset gpio aux device.

...
> 
> > +        * interface. Now we read data from all channels but keep only the bits
> > +        * from the requested one.
> > +        */
> > +       for (i = 0; i < ARRAY_SIZE(ad4134_chan_set); i++) {
> > +               ret = spi_write_then_read(st->spi, NULL, 0, st->rx_buf,
> > +                                         BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS));
> > +               if (ret)
> > +                       return ret;
> > +
> > +               if (i != AD4134_VREG_CH(reg))
> > +                       continue;
> > +               *val = get_unaligned_be24(st->rx_buf);
> 
> Hmm...
> 
> In this case it might be better to  use
> 
>   if (i == ...)
>     *val = ...
> 
> but it's still unclear on how many times the conditional can be true
> in the loop.

The if != ... condition was true on three iterations of the loop and false
in only one iteration. Updated to if (i == ...), the conditional is now true
only on one iteration. 
The AD4134 has a built-in feature that flags when data trasnfers don't run
enough clock cycles to read the entire data frame (i.e. the data from all 4
channels in this case).
Since this is not expected to be a time critical method for acquiring data,
I coded it to avoid that error flag. I added a comment about that for v4.

Thanks,
Marcelo

