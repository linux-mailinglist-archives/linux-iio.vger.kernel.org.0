Return-Path: <linux-iio+bounces-26900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C892CAB72F
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 17:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 970B5301B492
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9642C2F7478;
	Sun,  7 Dec 2025 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY5mdjhN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1002F7444
	for <linux-iio@vger.kernel.org>; Sun,  7 Dec 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765123233; cv=none; b=hZWjjx9ntd2ZNjWNQqQW7/vm7YfDjxFY2AFmoax3lAXihIKcm0S0pG0CleprgKXsfW+6X+x6irPLO4IINcGrJIcwkcbr8bV00Q/k2X8KZG97zGKIvRFL6lPb8Vl+fdlyaEU1pBzZR+LIyWX/VN54gtiYiifFLlGIXk85aRtMUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765123233; c=relaxed/simple;
	bh=fNaw/pQ6+rIuOq+pZ9tLxQ3v1LQvIrpT0JZXJNXotWc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=J4ENpFQRFwf0wL3X2VrkdCt6WFPBCYXqhvQEk4uujxvqjJSNF2PHGVf5dmwLJZ987bVIAXsLs+g7mlmV0+o37fr5iBjJzGTnP90SEM9bT5iCtVQJOKBn0Ff272TltQicssmALLV9XHg6L4IiZjp6kr6sxOcFgd37CQvdjUTCRtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY5mdjhN; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5de23ddba5eso2891782137.3
        for <linux-iio@vger.kernel.org>; Sun, 07 Dec 2025 08:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765123231; x=1765728031; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvyW/VsfDEVpe/uLFhc3QlugzHRA/waosh3tdpzei1U=;
        b=WY5mdjhN3RBoEi0KkLUb4eQW8S7GRj1PI1XHVG5UE6EOep4I4cWRsNwyPQ2rJg9Dy/
         Rh/KMrIfDWYAcUISGOpAkvRDpPViVgmGYbVka/atGNkNZRltNFDrPjuueXm9dw8aY4pk
         ubVTSVCJUsjHyYNqJ3kj+MbAe6AHpNoDN8soKcCvo5SY04Tu8IrZ9i0i/xcl0bZXdWhH
         X11oFnsQ/x0XxIBcYW1sjYL/MIeO/3HGyBkggDhEsVzH+jZtmT6766vvYyyAIvmu2F6V
         DUi0U/wbERsCLt92/g2XlrjaOJ/vtEAYJhZQYURQ5VuTAaBmRKU57z+123I0ICfDcNer
         lIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765123231; x=1765728031;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SvyW/VsfDEVpe/uLFhc3QlugzHRA/waosh3tdpzei1U=;
        b=c8WaogosZNFzvIYk0bQvWS040e/IFlh+gE/JdrwpFLst4e4hxVa2OnfGnx2fsvWXp6
         HvaJHpyc7w3QokF4HI07JY9GRYidMrUL5zMV3cGHeiWOsGoRX1haoRi3MefJwfAeCfSt
         yYhvLO+ZHsXCeHyhzPuCS5IEP2jJThNya9ZbW5OeHNqyVlmKdHRaZDrpeXj3krrFLH75
         wMEKg81tOAciJwk9a4gQa32Cmxh58hXEEYXZJRIoFhQBR14wC3l55vVzVqNcBHqDSx02
         EOC7o60ilJ/wRLF/y+SQ5jGt16bqrrThJhuZRQ0KKfIVA3SqVE4bozxGLJedZss7Tfa/
         lOIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDefK+eqZ4QST+GFBkbxg5zwfU/0ShKQ+rurn6kMEHr1THn7YPUA9O/+Xcdf95Ns+U0wMLXAlvPBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl9DTTyi7726aauLyvQA9G+xmdWT7XPsOmnDAgEXJnne0P/QaV
	s3Tm/tCyLJKPSs4/1fCIh0L6a2T/SmwAOhvm12eZnlUbUTRuC0Yn08Gs
X-Gm-Gg: ASbGncvLG5IL6PXq88T6LoQeLgkCyjjgUdCiGPLg/+wuu7cSJuy1V1p5KLwTkDWeULP
	cXA2Md3pElfRdblRaxvRKXyZT2MmuJD7I0W8/az+lri3G7uDW8r67XyfH7YdDk3ZZpAe0tT/iCv
	flEWKtjBY7BjdTCb7+ECNLA2JGMmWOUisFYAE72R9e00KaxPaJamtFk1uuOZPkXkeEuMhOu3yuI
	5813I1ng3eyDV7hJQdWJe8wyzwQSUqwHnuC7tD7hKShKkNr6+akpuYavLWd+5YIPva0YrjWXyPS
	DAcdJY/4BAqKqKfqNiGoqQ45RtTnF7vMgR271fvmdRBkXYPk0SiEOdkEy3L2Z26IUviHyINKI2s
	Kwxo3DpqbOCUzJGoBSqukRuK+MP7UDhBLQElrSxNwsjIs+t6Iecs0sGxa1Jy7Pv7GdB6FIk1x2K
	Tjfj2E1+I6OfT/2A==
X-Google-Smtp-Source: AGHT+IHBnqs2aQ2Fr8RdGbKL8fSqIjGYHTr6uO5d9m6cWkZ3v0f4Dr1+0rK9s9F+7cBhyVY8YBiQwg==
X-Received: by 2002:a05:6102:448c:b0:5db:ebb4:fded with SMTP id ada2fe7eead31-5e52cbcfd70mr1635134137.25.1765123230579;
        Sun, 07 Dec 2025 08:00:30 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93f01d022a4sm3058685241.3.2025.12.07.08.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Dec 2025 08:00:30 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Dec 2025 11:00:28 -0500
Message-Id: <DES3YOKEMZ16.2OIHKXA8ESBUX@gmail.com>
Cc: "Kurt Borja" <kuurtb@gmail.com>, "David Lechner"
 <dlechner@baylibre.com>, "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Benson Leung" <bleung@chromium.org>,
 "Antoniu Miclaus" <antoniu.miclaus@analog.com>, "Gwendal Grignou"
 <gwendal@chromium.org>, "Shrikant Raskar" <raskar.shree97@gmail.com>,
 "Per-Daniel Olsson" <perdaniel.olsson@axis.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Guenter Roeck"
 <groeck@chromium.org>, "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH RFC 3/6] iio: core: Add cleanup.h support for
 iio_device_claim_*()
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Andy Shevchenko"
 <andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-3-b4a1fd639423@gmail.com>
 <3b80f8f3-c435-49f8-8c55-42568215bf0b@baylibre.com>
 <bf1c82f7-da25-47b6-846d-9f8427ee5790@baylibre.com>
 <DEPLQT84HBAO.2GAY5BHP05HNL@gmail.com>
 <CAHp75VfpG4PAG6rC5aFYAPLgnOZZzfJcGP6bMzKPMkMjpuymoQ@mail.gmail.com>
 <20251206184332.426cc30f@jic23-huawei>
In-Reply-To: <20251206184332.426cc30f@jic23-huawei>

On Sat Dec 6, 2025 at 1:43 PM -05, Jonathan Cameron wrote:
> On Thu, 4 Dec 2025 19:36:28 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>> On Thu, Dec 4, 2025 at 7:18=E2=80=AFPM Kurt Borja <kuurtb@gmail.com> wro=
te:
>> > On Wed Dec 3, 2025 at 5:34 PM -05, David Lechner wrote: =20
>> > > On 12/3/25 3:50 PM, David Lechner wrote: =20
>> > >> On 12/3/25 1:18 PM, Kurt Borja wrote: =20
>>=20
>> ...
>>=20
>> > > When I made the comments about keeping "mode" in the name, I forgot
>> > > that DEFINE_GUARD_COND() only extends a DEFINE_GUARD(). So I underst=
and
>> > > if we need to make names that fit a certain pattern rather than what
>> > > I suggested.
>> > >
>> > > Still would be nice to have:
>> > >
>> > > iio_device_claim_mode()
>> > > iio_device_claim_mode_direct()
>> > > iio_device_claim_mode_buffer()
>> > > iio_device_release_mode()
>> > >
>> > > Just really annoying to rename iio_device_{claim,release}_direct()
>> > > everywhere since we just did that. We could keep both names around
>> > > for a while though to avoid the churn. =20
>
> Definitely. Possibly indefinitely. I don't want a rename just to make
> this facility easier to use as people won't see what is under the
> ACQUIRE() anyway if we end up doing something like Rafael has done for
> runtime PM where you don't call ACQUIRE() directly but use a runtime pm
> specific macro (not sure if that will make this cycle or not, was
> still being discussed when I went on holiday).
>
> https://lore.kernel.org/all/3400866.aeNJFYEL58@rafael.j.wysocki/

That looks nice.

>
>
>> >
>> > If we rename iio_device_claim_direct() (which is huge), maybe we can
>> > pick shorter names and more descriptive names while at it? I was
>> > thinking something like:
>> >
>> >         iio_mode_lock()
>> >         iio_mode_lock_direct()
>> >         iio_mode_lock_buffer()
>> >         iio_mode_unlock() =20
>>=20
>> The device context is important, so at least iio_dev_mode_lock() (and so=
 on).
>
> If we are bringing lock into the name do we need to make it explicit whic=
h can fail?
> Given you can't use them in the wrong place, maybe not.
>
> iio_mode_lock_try_direct() or maybe iio_mode_lock_direct_try()?

As Andy mentioned, maybe iio_mode_trylock_{direct,buffer}()?

>
> This was less relevant when they all could fail.  Maybe we don't need to
> bother given how rarely used the unconditional ones are.
>
> I did like the claiming of mode terminology because it made it a little
> more clear that we were taking a lock that was there for a purpose rather=
 than
> a normal lock.  Also the fact it's a lock is an implementation detail I'd
> rather not back into the ABI.

Even if it's an implementation detail, from what I've seen, a lot of
drivers might depend on this being a lock.

I my other series (ti-ads1x18), I dropped my private lock in favor of
iio_device_claim_direct() per David's suggestion too.

>
> Maybe it's worth something inspired by Rafael's patch linked above?
>
> #define IIO_DEV_ACQUIRE_DIRECT_MODE(_dev, _var) \
> 	ACQUIRE(iio_device_claim_direct, _var)(_dev);
> #define IIO_DEV_ACQUIRE_BUFFER_MODE(_dev, _var) \
> 	ACQUIRE(iio_device_claim_buffer, _var)(_dev);

I like this a lot, I'll add it here.

>
> For the two more complex ones and fine using guard() for the rare
> any mode variant.
>
> Then we can have whatever naming we like for the helpers under
> the hood as no one will ever use them directly.

Yes, I do think a rename would be nice, but maybe we can leave that for
a (near) future patch.

On that note, should I really rename iio_device_claim_buffer_mode()?
With this macros I don't think is necessary anymore.

>
> Hohum. Hardest problems in computer science etc, coherency and naming. :)

Indeed :)


--=20
 ~ Kurt


