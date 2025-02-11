Return-Path: <linux-iio+bounces-15331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B155A307C9
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 10:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A791888973
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 09:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBD01F190E;
	Tue, 11 Feb 2025 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhB+wiFT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64E11F12E6;
	Tue, 11 Feb 2025 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267793; cv=none; b=PuLzqWMQWc2HUhoy4BhilcfDNp+llcTmhkv8dcECe3x+fbHO4+TF+mCqvpt3DREmwOjVvxctcLz0bx5uVRlu0IhSGqIF2VDxA87p5JPFBtQlQYMivxJ9HTpQ8y+0eUGuwTbZ0d8yzXtUgmZGOpcuRX79H+StauQe5GHgFaiiJO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267793; c=relaxed/simple;
	bh=b1AqRMPwaqzau3bha9hRozWp1+7sibS9GK3Oq4TDWPs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YqxJ38uhdLFEQ5+kgUF3ncc0VpMVbOX8HJEzcK9nEWL5FhEjpLiy8TFd8XxAU/1j2v4h88usSjEDi0eit8eBoHv5xfCWwM89CDXFgaKMs2tKuF0hDcD47P7V7pfAZJIDpxaY5zCtsBDdzkWE65wN19H/q0jnq/YyJ57/2kkpm8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhB+wiFT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38dcb97e8a3so3267532f8f.3;
        Tue, 11 Feb 2025 01:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739267790; x=1739872590; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h5crAJj5oibHuv4aq79XMgvlyOBs6G56NcyMANmwUFA=;
        b=ZhB+wiFTJHGFkB4aZEeR1ab1gIP2kFqy98ReeZtoZecdqruSEa5S8rp1IUbc84Itmn
         ksYwS5CQLkhNpaZQeOcenhLBFot+UyGMpxKHYrxwTAKUM+DyCHHRjdRlpcbeRfzLjasg
         30XiSPY/1AaA0rB0C3fyOpZl1WV03q5WJTsz+1gN/gFo2N9dgNYUnwwNrPpM/g4u/6zb
         FkKJu2mwYyfK0SWtW3YiLEjCKmsX1nNJ4XU5GHQ5gHoRQhHkO5KftgXNUgolgd9v0Dkb
         qwEKtM/QyFR/5ZiYKs9AOG0lcJVQkopgeV6RzLj5yxETP+eKFF1C7m3hXpn6VAqIkJ6e
         Pvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739267790; x=1739872590;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h5crAJj5oibHuv4aq79XMgvlyOBs6G56NcyMANmwUFA=;
        b=VhLufyNx5rJPSc2MYYji6NpqZZwV/aX9NcroC9HHVNi6ZIiI4FDhaSzZtgO8OWlUlx
         yRo+u78atnZ10acyqxosbEhgPGfp+27C5RwWdvq62hTO5ZnC2aGAULLcLWW18vdpbNzM
         r1Z3HF86RwppRyTpLTR8vPGu4+tASAAQery+z3Oc65wi8hKkmlJfx+2DrCgsFXTriHlv
         5sIRnmWAzveRIvvIGEJ+Dfsu0dLFQI0pkMbOkpKqNM1Car4//BPU3OjKRiwgXBZBxCeP
         aNkdSB7DTJVeZgA7BPx9Putd7xvwXmMCJqdiKIgqB5fK1ad4uccbgZ3IkJPJCtoNN81e
         uEMw==
X-Forwarded-Encrypted: i=1; AJvYcCVm8TmmMFQ0mVyrInfAjo0eMPAMJebkK82J0CnFJUwowTlACC4j5pjehNCl6TZZuZfb8VrbcFl/kVXC3Cv2@vger.kernel.org, AJvYcCXYebR/XqHze0HXGC+1roMPlBGW7ab50yfNZD9lot+au5Y52XHt/toJTAue0A2ECsD2KomEDCeuVqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBeu8OSb10WVoLgQoNIf70h+w/QX0cckGrqs9F8zK1Ff/FfILU
	1dQXAWsXeLGB/6DT07gwbCErGA5JaxqttmwG1AOpE9915/hvmoA0
X-Gm-Gg: ASbGncuU79lY4/v/sdDDAZyF15sp6C5JJG8PHLMu8L5rFxe9YWCXrcxZ9MMU6I6GIRa
	GTZYlAURLSg3LApYNbhOVthuY/MQdNzti3nVv4sTktTAoZWBXoJxm9XTMJx06S3kSzgovhXVgHq
	etfpiP/yFBXnDp0CLxQXdNOC6208u4k5iJPQeQCW0F4i8/Ng5TOggNVUn/zPfs8bEeiaM/n4LP+
	Uul9f4v/Jg3wNFe2SkrsPnkFF8bwVgGSKOifW23Yn0LyLVIrt/nfD8Ib9JF8Cj7wFHZBOpjcQnp
	iPvF+Q4Wn5Rc1MOvGB0tT/jr5g6QWO68dYHPDsvFqs1E9VIHULagpnZ2hwOEoLQ=
X-Google-Smtp-Source: AGHT+IFVzchNyrNdAYOwSsDK8nNz26vX2DoKpyUMAzIwaPRESr8Q8XFtP/PCFrWTrYdrI3evf3kQhw==
X-Received: by 2002:a05:6000:184f:b0:38d:d2c9:8802 with SMTP id ffacd0b85a97d-38dd2c98948mr8412755f8f.45.1739267789791;
        Tue, 11 Feb 2025 01:56:29 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd7f039sm14637209f8f.59.2025.02.11.01.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 01:56:29 -0800 (PST)
Message-ID: <4c526d89750e1578d8c341caae77aac0321d7ace.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: adi-axi-dac: drop io_mode check
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa	 <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 11 Feb 2025 09:56:31 +0000
In-Reply-To: <20250210191353.2a5fcd4b@jic23-huawei>
References: 
	<20250206-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-1-863a4b2af4ea@baylibre.com>
		<20250208154521.193da461@jic23-huawei>
		<2ae962c19bc9d180dabf52e256a1d6bf215f9bf0.camel@gmail.com>
	 <20250210191353.2a5fcd4b@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-10 at 19:13 +0000, Jonathan Cameron wrote:
> On Mon, 10 Feb 2025 10:05:47 +0000
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Sat, 2025-02-08 at 15:45 +0000, Jonathan Cameron wrote:
> > > On Thu, 06 Feb 2025 09:36:14 +0100
> > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > > =C2=A0=20
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> > > > Drop mode check, producing the following robot test warning:
> > > >=20
> > > > smatch warnings:
> > > > drivers/iio/dac/adi-axi-dac.c:731 axi_dac_bus_set_io_mode()
> > > > =C2=A0 warn: always true condition '(mode >=3D 0) =3D> (0-u32max >=
=3D 0)'
> > > >=20
> > > > The range check results not useful since these are the only
> > > > plausible modes for enum ad3552r_io_mode.
> > > >=20
> > > > Fixes: 493122c53af1 ("iio: dac: adi-axi-dac: add bus mode setup")
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>=C2=A0=
=20
> > > Ah. I missed this.=C2=A0 Anyhow made the same change directly so all =
is well
> > > than ends well!
> > > =C2=A0=20
> >=20
> > Hi Angelo, Jonathan,
> >=20
> > I wanted to reply to this one when I saw it but I haven't done right aw=
ay
> > and
> > then totally forgot. Sorry about that!
> >=20
> > I don't really agree with the "fix" in this patch. AFAIU, smatch is
> > complaining
> > since the enum is apparently defaulting to an unsigned type which means
> > doing
> > the >=3D 0 check is useless. But we should keep the upper bound...
>=20
> Why? It's an enum so unless we are messing around with deliberate casts t=
he
> compiler should always be able to spot this. The check may be needed on a
> future

I do not think the compiler will catch this:

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index c1dae58c1975..5234dd5e227d 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -293,7 +293,7 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev
*indio_dev)
         * Back bus to simple SPI, this must be executed together with abov=
e
         * target mode unwind, and can be done only after it.
         */
-       st->data->bus_set_io_mode(st->back, AD3552R_IO_MODE_SPI);
+       st->data->bus_set_io_mode(st->back, -1);

A W=3D1 build (clang) did not complained at all... Maybe tools like smatch =
will.

> date if we add more types to that enum.
>=20
> So I agree the check wasn't terrible and perhaps acted as hardening but i=
t
> isn't strictly speaking doing anything today.
>=20

It's not a very super important check, I agree... and being an enum will be
easier to spot a raw value being passed during a review but since we alread=
y had
the check, I don't see why we should remove it completely and not keep the =
upper
bound.

- Nuno S=C3=A1

