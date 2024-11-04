Return-Path: <linux-iio+bounces-11892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A19859BB58C
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 14:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5021F216F4
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEDCAD24;
	Mon,  4 Nov 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUVJg5b7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A133FE;
	Mon,  4 Nov 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726154; cv=none; b=RjQb0JQPqJChjL75FUT3H3XyR6PpC3FIDWlDAPw2IgBIIX/ZP7SRnXTFvRpgT9nAV0ZSzaPpSkKKhEcUIAjECI9Dlpp9EcmdwAvFlU8GDoKbeBNM58dJAviObAudt4Adfd0zMDuI/MId5zBYtByn2xRyvhVF8syPNzPbpdG2iE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726154; c=relaxed/simple;
	bh=GFcu93LZhgflzHwjgZxoMyYv2ii1WI65MwCPlXsbtiA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O1uUmS9TcvRFnDU0+qE+YeKOZknSBZLdGlZiexofEEy4xS6BeiLA7BHOShOxoejJJ/JCljbfVZlRfu5FZy1hbJpW1gMufx1scfLuAAq1kug6UFmV6Xdz63wToxYAWBOXKhnocOS26lZdNqrMlrEKBXQDKM/A4RvRxSWgulm6gy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUVJg5b7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a16b310f5so691910866b.0;
        Mon, 04 Nov 2024 05:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730726151; x=1731330951; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=05Fw0734yDPEZPjYpClPOaXgwFb0vYgwUd4a3SYU9ZA=;
        b=ZUVJg5b7jZbL+MvudG+Ji04VRo1wFXRdHX46+mg94QsZ59kge8/ps9+ogApMgj35hF
         X1/6iV1ALt6cegWTOaQPveccHYzoPgXkLsWp2qYrY1Xv4Xsd0G4stVyAcfjTfLZ/MqrO
         GPZnbYxsArrnWbO1HYoNGjBMTLbarLiD1Bo/aQyjWERafudzF5jy4VIJNMSOr7t6FhpF
         NMuxBoWUnoiC+hnxoUaq9uCtyUNrvJCgPHQHQy/m3BZ3aRI6yLibaAcwRYb0qNK5omI0
         ISwqlTFmy98L3wBmBmwSlampl3A5PZzQXxxYtQHd1j6Jp0uRrJZUtUkG0gFg1DOb3Gdi
         kCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730726151; x=1731330951;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05Fw0734yDPEZPjYpClPOaXgwFb0vYgwUd4a3SYU9ZA=;
        b=EIGCPArNHOH6jG07VzG5M89U6CJWAvBaKdKfuCeV0UwelrG1mCCDVR8pIZ+L3xdr/J
         HF34Xry5Z1JarOHUgTyTN2YToADBlQma81c3PHlBVz/nmTHdDTDtPbILyA/SDIChckhm
         D/l12mz6eYsF5MzI72NboDgoTzTNLmwutbGm4UbPbA7wQWKB3LKUQY00L4z7an5P1X9M
         XPc8jLFKuFBVJFoy+snPKHSOYe545ZeeCPX/IWU5Atc4oU7oD8ykvsTf9V9zO82KTR9H
         sytciFV5xNkcacxqLZc0ef5FGcqVen+G2O5vav5LkVfrj3XwmBwKporT6b6ugg8HyGGr
         /aeA==
X-Forwarded-Encrypted: i=1; AJvYcCVuDkNPitg8z1Om5uZ4VbPXPN/o39ew98PWc0rveFzCXWvkFTZ2OfgMgzqfwlk/luOppueQQEQP4KEm@vger.kernel.org, AJvYcCW4tXvwywTvJcCigTYYfE/uNriJbTrPfb9Z+9wVnyIm3H7GSVrpLVB6MHzMLevD9AiigJ/0Kn5TIZes@vger.kernel.org
X-Gm-Message-State: AOJu0YyffRKuQgJqKWXM4Xeaibt2WG1aPV32yNPP51cU21c7QgPTvEE5
	X2WWYn5hdc+0ZWXGFOxQJ0TahsdJecK2euh02lKdiTIWQIIkfN3P
X-Google-Smtp-Source: AGHT+IF366frdwJAN/Nic5KZbsxx4yX8nROBvgKs2H27mCpl9Co95JYTaTu07b3xJMfTVPR/Qu/Rzg==
X-Received: by 2002:a17:907:6d09:b0:a9a:122b:e545 with SMTP id a640c23a62f3a-a9e5093f0b3mr1643923466b.32.1730726150528;
        Mon, 04 Nov 2024 05:15:50 -0800 (PST)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e5663bd47sm564198666b.144.2024.11.04.05.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:15:50 -0800 (PST)
Message-ID: <2760d1a59114d0eec79405c56253aa82268ecba7.camel@gmail.com>
Subject: Re: [PATCH v2 3/4] iio: adc: ad_sigma_delta: Add support for
 reading irq status using a GPIO
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
  David Lechner <dlechner@baylibre.com>, Dumitru Ceclan
 <dumitru.ceclan@analog.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
 Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>
Date: Mon, 04 Nov 2024 14:15:49 +0100
In-Reply-To: <xka5svqs3jbjiqcz6bacih7hjqzjbrugutjii6qusdbqoxfrp5@5hcv3htsjtlp>
References: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>
	 <20241028160748.489596-9-u.kleine-koenig@baylibre.com>
	 <a575430a74a7825a2df9fad1a8e073ad0507b0e7.camel@gmail.com>
	 <20241030204429.70cdcf35@jic23-huawei>
	 <y3amm7yj37lravbk6fcwze3jlllp4extmffqtx4jaoeqjt6uyl@nsdrcy2dk5kr>
	 <1de551c284aaa9f4e91f91fa0c4ac570c8b7f2c9.camel@gmail.com>
	 <xka5svqs3jbjiqcz6bacih7hjqzjbrugutjii6qusdbqoxfrp5@5hcv3htsjtlp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-11-04 at 13:49 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> [adding rmk to Cc as the docs state that he invented lazy disabling]
>=20
> On Thu, Oct 31, 2024 at 01:05:21PM +0100, Nuno S=C3=A1 wrote:
> > On Thu, 2024-10-31 at 11:40 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Wed, Oct 30, 2024 at 08:44:29PM +0000, Jonathan Cameron wrote:
> > > > On Wed, 30 Oct 2024 14:04:58 +0100
> > > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > > > Regarding this, I do share some of the concerns already raised by=
 Jonathan.
> > > > > I fear
> > > > > that we're papering around an issue with the IRQ controller rathe=
r than
> > > > > being an
> > > > > issue with the device. When I look at irq_disable() docs [1], it =
feels that
> > > > > we're
> > > > > already doing what we're supposed to do. IOW, we disable the lazy=
 approach
> > > > > so we
> > > > > *should* not get any pending IRQ.
> > >=20
> > > I think this is wrong and you always have to be prepared to see an ir=
q
> > > triggering that became pending while masked.
>=20
> I did some research, here are my findings:
>=20
> https://www.kernel.org/doc/html/v6.12-rc6/core-api/genericirq.html#delaye=
d-interrupt-disable
> reads:
>=20
> 	The interrupt is kept enabled and is masked in the flow handler
> 	when an interrupt event happens. This prevents losing edge
> 	interrupts on hardware which does not store an edge interrupt
> 	event while the interrupt is disabled at the hardware level.
>=20
> This suggests that lazy disabling is needed for some controllers that
> stop their event detection when disabled. I read that as: *Normally* an
> irq event gets pending in hardware while the irq is disabled.

I might be wrong, but I think that the lazy approach is the one for optimiz=
ation. I
think the reasoning is that __normally__ no more IRQs will come so no need =
to access
the HW. But also thinking more on the subject and looking at what the lazy =
approach
is doing, I take back what I said in previous emails. I *think* the expecta=
tion for a
received IRQ while the line is masked (or disabled?!), is to keep it as pen=
ding (both
on HW - when possible - and in SW).

>=20
> The lazy disable approach is expected to work fine always, the reason to
> implement non-lazy disabling is "only" a performance optimisation. See
> commit e9849777d0e27cdd2902805be51da73e7c79578c.

Not sure If I understood you correctly, but I think is the other way around=
?=C2=A0
Also, as said in the commit, I think it also prevents the same interrupt fr=
om
happening twice (in some cases).

>=20
> With the DOUT/=CC=85R=CC=85D=CC=85Y pin the ad7124 (and others) is in thi=
s "Unfortunately
> there are devices which do not allow the interrupt to be disabled easily
> at the device level." class.
>=20
> However that makes me wonder what is the difference between the
> irq_mask() and irq_disable() callbacks defined in struct irq_chip.

Wondering the same...

Thanks for digging into this. This has been a long standing thing with sigm=
a delta
ADCs (I'm fairly sure this discussion about being an issue on the IRQ contr=
oller or
not already happened before).

- Nuno S=C3=A1


