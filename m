Return-Path: <linux-iio+bounces-11915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5429BCA6E
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 11:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66AF51F24F51
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 10:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0001D26F6;
	Tue,  5 Nov 2024 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsiKsDXn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520D91CC881;
	Tue,  5 Nov 2024 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802401; cv=none; b=EAXja0s5m57KFxq/Rn5rVdAFgm+NKej5CrAUKyYoyaxPnv6GYwsmPotQOq/76XY1Pkq8o/Ds280K4S0+Wa1MhXTpjMat7COqYPUDKwcKmVrT7hv0ucD1Kdu9PzUNuS6QR1Qfu5LT/yu1eAzBmyCq8USl3xA/0pXRP9GvTc7hQXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802401; c=relaxed/simple;
	bh=aMMN0XF3aQXNYKr0ca+QnEsqzWRHakQrf9MDJLffMdE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=anpb/3w27G9nFmKmpF0oFA4VYWQWBZEZGC2Xk3VyvJygve37wZzrUHpiiqt5e2P001/j8qMKr/9yPjyVcU8Y9dpTy3zQedJL9k0EDvmwcEODSJsdMbxuq/zeLd1XWC4OlWuonwsp59NhPI/gDmH2wGxp6K+IFt8RuE275Hf1LzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsiKsDXn; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso2979485a12.1;
        Tue, 05 Nov 2024 02:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730802397; x=1731407197; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uXRmrldv0abJ1KuKD/CwJRavhPmq1r5j2UOmv6zY/I8=;
        b=bsiKsDXnouk7jg3FbP4bAplMzYH0XNYbaAv25JroAHbmoC5EKEWrFBAPbUuU3M5NM7
         bP5MXK84OHKqGuFN38RFqf5jTyyQDLcyRBT21LomPADVlLRbyd9DKJ29K+eEMhpFn7SI
         a3aAdaZXtZ6XFRvIrkAFXKqfLBERHTbl3YPlxfOaAAJ8wddthpneRIkJC5U6L3GJbF6k
         dy1dmEevv8dCuSng/GIKubTK7Zsm3VEuy/uDXwx8B8nPQPZfwBZlhrqhDD5j4KBZeOuR
         G4yz0lNzB9RI9f7KbhZ251iyGpwoAPZvLct3r1PkjkWyEneG1b+dwDj32AKNq6q9i70v
         aaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730802397; x=1731407197;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uXRmrldv0abJ1KuKD/CwJRavhPmq1r5j2UOmv6zY/I8=;
        b=ss2jAKVsYyrbaI2VBmEnY0tW9WmlNRCdrPgqWdz+6N8b3L+RWZvzJYiBPYhNLBEXvW
         ECB1P6K+s7rZpRIHmYrWGUC1i3M7JsWEiQhgX1B3R00kuyprCI5OOAppEMb9MlrSnhH6
         RQTRi1Uu1DBq/iJthPTUR8F7Kf4YRxIcVkwpLcFj8tOUvsvI1qXkSH2bWP2+Yudg2TSN
         lhDuGs8mvPXOonguyFd5eAd6pIrGnMITkfoTYwgm8vr8qqv6AyCpkoEJ3/uQ+7tYl7Pq
         IsxKLMrQUyy469Fyg0V7igBjDMwbrg4lDpYgAS3qtahQ5L4MZejC0u3adQLay8h7OgZE
         /zew==
X-Forwarded-Encrypted: i=1; AJvYcCVrtLW9/oUh7wKIfZfBcE4eFkNjMifm/Wo6N1JMf4Tl1gqyhyLNn67TSbi0A/xe07lYGp4B3Q1w6adg@vger.kernel.org, AJvYcCX+JPIyXv8mkL4uViLzR+5/bOP9248TQQx4sgW5idMe4fHz3NYLUrHMvfZ3JQyQsJhuxLOIME6RXVRz@vger.kernel.org
X-Gm-Message-State: AOJu0YyWWiXVxWML7TQV2Qtu2LMMnd23/pp1sh/0j3wVAZKO0cu20gHd
	5p9Sf4CN8214jJbOPU72S5Bdn99Ht2nxjAQUsIQbNS/ciaUO5tOiAC5z8hwCVJg=
X-Google-Smtp-Source: AGHT+IFjjpWORLG5EZwmDcCkf0azWSxPO1Bct/TWivucAAOMC5AokZ+K3ztYFsVpWHl476cCiDvc1w==
X-Received: by 2002:a17:907:2d88:b0:a9a:c691:dcbc with SMTP id a640c23a62f3a-a9e3a57a2e5mr2460466666b.12.1730802397128;
        Tue, 05 Nov 2024 02:26:37 -0800 (PST)
Received: from ?IPv6:2003:f6:ef18:1c00:c8b:7f34:a3dc:c7fc? (p200300f6ef181c000c8b7f34a3dcc7fc.dip0.t-ipconnect.de. [2003:f6:ef18:1c00:c8b:7f34:a3dc:c7fc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16a3d30sm113692166b.35.2024.11.05.02.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 02:26:36 -0800 (PST)
Message-ID: <1e6aba2a95441abfbd6763f8892c4efa4f05ad12.camel@gmail.com>
Subject: Re: [PATCH v2 3/4] iio: adc: ad_sigma_delta: Add support for
 reading irq status using a GPIO
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
  David Lechner <dlechner@baylibre.com>, Dumitru Ceclan
 <dumitru.ceclan@analog.com>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring	
 <robh@kernel.org>, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
 Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>
Date: Tue, 05 Nov 2024 11:30:58 +0100
In-Reply-To: <6qecwcncfjxphezk6zwwafo5khpiqn4g7tsklrd6wv2xlzaok2@pm3rbfhaolzw>
References: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>
	 <20241028160748.489596-9-u.kleine-koenig@baylibre.com>
	 <a575430a74a7825a2df9fad1a8e073ad0507b0e7.camel@gmail.com>
	 <20241030204429.70cdcf35@jic23-huawei>
	 <y3amm7yj37lravbk6fcwze3jlllp4extmffqtx4jaoeqjt6uyl@nsdrcy2dk5kr>
	 <1de551c284aaa9f4e91f91fa0c4ac570c8b7f2c9.camel@gmail.com>
	 <xka5svqs3jbjiqcz6bacih7hjqzjbrugutjii6qusdbqoxfrp5@5hcv3htsjtlp>
	 <2760d1a59114d0eec79405c56253aa82268ecba7.camel@gmail.com>
	 <6qecwcncfjxphezk6zwwafo5khpiqn4g7tsklrd6wv2xlzaok2@pm3rbfhaolzw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-05 at 10:20 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Nuno,
>=20
> On Mon, Nov 04, 2024 at 02:15:49PM +0100, Nuno S=C3=A1 wrote:
> > On Mon, 2024-11-04 at 13:49 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Thu, Oct 31, 2024 at 01:05:21PM +0100, Nuno S=C3=A1 wrote:
> > > > On Thu, 2024-10-31 at 11:40 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > > > On Wed, Oct 30, 2024 at 08:44:29PM +0000, Jonathan Cameron wrote:
> > > > > > On Wed, 30 Oct 2024 14:04:58 +0100
> > > > > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > > > > > Regarding this, I do share some of the concerns already raise=
d by
> > > > > > > Jonathan.
> > > > > > > I fear
> > > > > > > that we're papering around an issue with the IRQ controller r=
ather
> > > > > > > than
> > > > > > > being an
> > > > > > > issue with the device. When I look at irq_disable() docs [1],=
 it
> > > > > > > feels that
> > > > > > > we're
> > > > > > > already doing what we're supposed to do. IOW, we disable the =
lazy
> > > > > > > approach
> > > > > > > so we
> > > > > > > *should* not get any pending IRQ.
> > > > >=20
> > > > > I think this is wrong and you always have to be prepared to see a=
n irq
> > > > > triggering that became pending while masked.
> > >=20
> > > I did some research, here are my findings:
> > >=20
> > > https://www.kernel.org/doc/html/v6.12-rc6/core-api/genericirq.html#de=
layed-interrupt-disable
> > > reads:
> > >=20
> > > 	The interrupt is kept enabled and is masked in the flow handler
> > > 	when an interrupt event happens. This prevents losing edge
> > > 	interrupts on hardware which does not store an edge interrupt
> > > 	event while the interrupt is disabled at the hardware level.
> > >=20
> > > This suggests that lazy disabling is needed for some controllers that
> > > stop their event detection when disabled. I read that as: *Normally* =
an
> > > irq event gets pending in hardware while the irq is disabled.
> >=20
> > I might be wrong, but I think that the lazy approach is the one for
> > optimization.
>=20
> It's both. Needed for some controllers *and* an optimisation (that
> isn't beneficial in some corner cases).
>=20
> > I think the reasoning is that __normally__ no more IRQs will come so
> > no need to access the HW. But also thinking more on the subject and
> > looking at what the lazy approach is doing, I take back what I said in
> > previous emails. I *think* the expectation for a received IRQ while
> > the line is masked (or disabled?!), is to keep it as pending (both on
> > HW - when possible - and in SW).
> >=20
> > > The lazy disable approach is expected to work fine always, the reason=
 to
> > > implement non-lazy disabling is "only" a performance optimisation. Se=
e
> > > commit e9849777d0e27cdd2902805be51da73e7c79578c.
> >=20
> > Not sure If I understood you correctly, but I think is the other way
> > around?=C2=A0
> > Also, as said in the commit, I think it also prevents the same interrup=
t
> > from
> > happening twice (in some cases).
>=20
> The conversation thread isn't complete on lore.kernel.org, so I don't
> know for sure, but the way I understand it is: Normally while you handle
> an irq no new irq comes in and so it's sensible to do lazy disabling.
> Approximately: In 99.9 % of the cases you save 1 =C2=B5s by not masking a=
nd
> in the remaining 0.1% you get another hard irq that costs you say
> 500 =C2=B5s. So on average you save: 0.999 * 1 =C2=B5s + 0.001 * (1 - 500=
) =C2=B5s =3D 0.5 =C2=B5s.
>=20
> However if for a certain device it's normal that another irq comes in
> the "improvement" degrades to: In 20 % of the cases you save 1 =C2=B5s an=
d in
> the remaining 80 % you get a penalty of 500 =C2=B5s. So in this case it's=
 not
> an expected win anymore and you can better stop doing lazy disabling and
> invest the time to mask the irq improving the average cost from
> - 0.2 * 1 =C2=B5s + 0.8 * 499 =C2=B5s =3D 399.4 =C2=B5s to 1 =C2=B5s.
>=20
> The interrupt happening twice is not a problem for correctness as the
> second one is not given to the device driver but caught in the irq
> subsystem that only then disables the irq in hardware and marking it
> pending for later consumption. It "only" costs cpu time. (And maybe it's
> given to the driver twice after enable_irq is called?)

Yeah, enable_irq() was what I meant. So, in the commit message, it's stated=
:

"Unfortunately there are devices which do not allow the interrupt to be
disabled easily at the device level. They are forced to use
disable_irq_nosync(). This can result in taking each interrupt twice."

And the taking twice part was something that I was not getting it. Still no=
t
100% sure but I think that what is meant is that when we enable the IRQ we =
might
get it through [1] and then afterwards through the IRQ controller for devic=
es
that latch the events (as soon as you unmask the line, the event should
trigger). On [1], there's a retrigger path that goes through HW and I'm not=
 sure
if that one is problematic. But I would expect the SW one to be...

[1]: https://elixir.bootlin.com/linux/v6.11.6/source/kernel/irq/chip.c#L283

- Nuno S=C3=A1
>=20
> Looking at the problem at hand with the shared DOUT/=CC=85R=CC=85D=CC=85Y=
 line: It's
> (nearly?) 100% of the cases that the line toggles while the irq is
> logically disabled/masked. So it makes sense to do
>=20
> 	irq_set_status_flags(sigma_delta->irq_line, IRQ_DISABLE_UNLAZY);
>=20
> which however should only have an effect iff the irq controller doesn't
> miss an edge while the irq is disabled.
>=20
> So assuming my understanding is correct, there is something to do about
> the raspberry pi gpio controller to prevent setting IRQ_DISABLE_UNLAZY
> have an effect, because that one looses events.
>=20
> > > However that makes me wonder what is the difference between the
> > > irq_mask() and irq_disable() callbacks defined in struct irq_chip.
> >=20
> > Wondering the same...
> >=20
> > Thanks for digging into this. This has been a long standing thing with =
sigma
> > delta
> > ADCs (I'm fairly sure this discussion about being an issue on the IRQ
> > controller or
> > not already happened before).
>=20
> I keep that paragraph in my reply because the question is still open
> even though I don't add new infos here.
>=20
> Best regards
> Uwe


