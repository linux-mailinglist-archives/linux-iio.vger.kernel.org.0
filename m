Return-Path: <linux-iio+bounces-16037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE29A435F2
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 08:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F54A3B2F2A
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 07:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB97257AFF;
	Tue, 25 Feb 2025 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp3TwPVj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A7254875
	for <linux-iio@vger.kernel.org>; Tue, 25 Feb 2025 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740467396; cv=none; b=TsVZasst4zhSCTTQ0mY392eXHFAuAzC2tyNm8huZnO7c4prXB88G2xxP6jhqTXA6zIPdHLNKE0quRK22T1e49pEjLG31yu12xlbw72b5f0Z2OIJkZ+aytDzkfj/j4DjZJFQGO8BQLnslv0QeGUuGtBgswR51xVM8AeynpalMArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740467396; c=relaxed/simple;
	bh=gq2hDrmk1YeTI50inWgLhcrnIfTQFwtUpvKtvwO3404=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlAaOt1GAg52g0ksIxgJc/9zTUGB5pf/txRMbA0McOmpj8figDfMPWb1oHFKwRcvYNeZE/S3+uhHEfqcsQSzeN3AOCIiVlTaOmsOo5oiJXizooTR2VmgnezxnExHPQINQKK/cwG+s87dQDU7PDequgAIvovObJoSgCKdnMQO364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kp3TwPVj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abbdc4a0b5aso963896966b.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 23:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740467393; x=1741072193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOLpm8ui9hQ1cEOnkVdiPSGX9UR5KkvhWPdT9wvRCbQ=;
        b=Kp3TwPVjcjHtvnFzeaii+y9t1RI7E2BcJZivr8hZhBEJzbG550sCfXb7EmVi5jM81V
         Rfmm6P7xyJAitnewSm0UblL4EUqGbY+1w8mvyyQOH1/JBTZgkR0/fWFaCarxIL4GVpCo
         fUlmEVmoOF+cq0BVlTcAagRvtxHwFUh7+kx/VVHE1CqsY1x+Q99AQRy1GHEZ+j9PbEru
         2xcBVFpc+hUfVtRQJ8mRRvahNe4isun1KeYjv5uX014NRX2t+oFRREodHZo5BoYuF7DV
         Ype2IALZXM/oMrve68470+usfN24FYhn0UDmtrXUJ7vS/qFFlaCc3izQfhLjGHAi7Jjd
         FoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740467393; x=1741072193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOLpm8ui9hQ1cEOnkVdiPSGX9UR5KkvhWPdT9wvRCbQ=;
        b=enIwfNdnTYRAVq0ojkwGh4/FNLLN2Mv4K8wlPOuPRgLAd4RGCgwcQ0eDJ27HntIfKc
         PL80iCpziYK0iQMNaOHPWbXkgzK465Ns8jMukgM0HTjH30mFQAT4+irro3YrUfMq6W5G
         oiLw+0DZHb0X7EU/QbgqBz70h5HXO9vt3DTnM7Lfs+OQO/aRzxb2gla8lpZlDqujAFVu
         FVAfKWEfF91ChEeph/vVvllMTfq5YOL5GpO/hDPJP+drNcDsM4u/uuG+TdPOWI71C/xQ
         R29W1DKTUe8rxuTsjkuF2MzJoAVBVOB2EA43nHcJV0NlA6FW2CUEut2vFkK8HBIYrZWr
         TUMw==
X-Forwarded-Encrypted: i=1; AJvYcCUyeab/FjE7nMH8wCv9qxxzmFKjdCPK89Wv+Q6+DFZ96gW5Iuk1A24Nf8i2gMpHZrt/MRRMQAlISOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDwTp+dpSm2FKy0gOxfGFtzg61k+4vX71rczr4ghD78iGu0OEC
	b8+spd/4y37ZVbZIwU1aA6ZnXnbxWomqBSly7x+VGfhPmbIMifZkin1Fh1xLLaQbnNcb2mktXKa
	hXvel23pBACLbOERrtjXolVQBgH8=
X-Gm-Gg: ASbGncsegDUX6zh/+jmKkFkME5VbzFuOdZdQyJa2kHYspE6yA8aLSjQeDrVhEjfmAc+
	FoObGtuJ1fkKeWnapO0bTOs++u3XRi4hFtbugNU/hY+5WvJkLD09mlxB40iUqV7IK5sCWeqy50E
	47un3A7cI=
X-Google-Smtp-Source: AGHT+IHohN9r415arwI1n6kdXT4GwQgO0dQRX3at5AJ38Vf3fkfHovy0sxMuYwrqIddIZMA63zn7imu4HdenPWTSztI=
X-Received: by 2002:a17:907:d9f:b0:ab2:f6e5:3f1 with SMTP id
 a640c23a62f3a-abc0ae54e08mr1889252466b.8.1740467392474; Mon, 24 Feb 2025
 23:09:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209180624.701140-1-jic23@kernel.org> <20250209180624.701140-2-jic23@kernel.org>
 <Z7nyQgjZ36zkO8oD@surfacebook.localdomain> <20250222172357.05378fd4@jic23-huawei>
 <CAHp75Vf_XPSvTOH_zvfndghjy+bM_6hr=z2JAcE8AYh415SPWw@mail.gmail.com> <20250225062532.0000475e@huawei.com>
In-Reply-To: <20250225062532.0000475e@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 25 Feb 2025 09:09:16 +0200
X-Gm-Features: AWEUYZko26zZxQ-gHkZHQ-iJcuDHMULR2z2VAlyHQYjTft6KocavJ7ms9e7GJU8
Message-ID: <CAHp75VceUgE-0B02naE8rwvqmvn9C1eKG10gqkqCMs6nkm-_6w@mail.gmail.com>
Subject: Re: [PATCH v2 01/27] iio: core: Rework claim and release of direct
 mode to work with sparse.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	Mudit Sharma <muditsharma.info@gmail.com>, Julien Stephan <jstephan@baylibre.com>, 
	Mariel Tinaco <Mariel.Tinaco@analog.com>, Angelo Dureghello <adureghello@baylibre.com>, 
	Gustavo Silva <gustavograzs@gmail.com>, Nuno Sa <nuno.sa@analog.com>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
	ChiYuan Huang <cy_huang@richtek.com>, Ramona Alexandra Nechita <ramona.nechita@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Guillaume Stols <gstols@baylibre.com>, 
	David Lechner <dlechner@baylibre.com>, Cosmin Tanislav <demonsingur@gmail.com>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, Gwendal Grignou <gwendal@chromium.org>, 
	Antoni Pokusinski <apokusinski01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:25=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Sat, 22 Feb 2025 22:58:00 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Sat, Feb 22, 2025 at 7:24=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote:
> > > On Sat, 22 Feb 2025 17:51:02 +0200
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > Sun, Feb 09, 2025 at 06:05:58PM +0000, Jonathan Cameron kirjoitti:

...

> > > > > +/*
> > > > > + * Helper functions that allow claim and release of direct mode
> > > > > + * in a fashion that doesn't generate many false positives from =
sparse.
> > > > > + * Note this must remain static inline in the header so that spa=
rse
> > > > > + * can see the __acquire() marking. Revisit when sparse supports
> > > > > + * __cond_acquires()
> > > > > + */
> > > > > +static inline bool iio_device_claim_direct(struct iio_dev *indio=
_dev)
> > > > > +{
> > > > > +   int ret =3D iio_device_claim_direct_mode(indio_dev);
> > > > > +
> > > > > +   if (ret)
> > > > > +           return false;
> > > > > +
> > > > > +   __acquire(iio_dev);
> > > > > +
> > > > > +   return true;
> > > >
> > > > While I understand the intention, I dislike the function return boo=
lean and
> > > > hide the actual error code, it calls user to misuse and replace boo=
lean false
> > > > by arbitrary error codes.
> > > >
> > > > Can we rather return an error code, please?
> > > > (as a side effect it reduces the churn in the followup changes)
> > >
> > > I tried - see above.  It plays badly with sparse which is the whole p=
oint of
> > > this exercise. Note that iio_device_claim_direct_mode() only ever ret=
urns one
> > > error code -EBUSY. So reality is it's a boolean and this is a lot clo=
se
> > > to mutex_trylock() than anything else hence the switch to a boolean r=
eturn.
> >
> > Hmm... You mean that the following (still as a macro)
> >
> > static inline int ...
> > {
> >   int ret;
> >   ...
> >   if (ret)
> >     return ret;
> >
> >   __acquire_lock(...);
> >   return 0;
> > }
> >
> > triggers the sparse warning?
>
> Doing it in the ternary form of the same thing did trigger issues on fair=
ly
> simple cases.

Oh...

> I don't recall if I tried this precise combination. The motivation
> for this form originally being the __cond_acquires() markings (See later)=
.
> However, I 'think' based on other false positives including the smaller
> set that required refactors to avoid triggering in this series, is that
> sparse isn't coping well with more complex control flows.  So if we
> assign a local integer variable and then check it, it seems to loose
> track of what is going on in more cases than if we can do
>
>         if (!trylock())
>                 return;
>
> I'm not sure on what is going wrong.  However it seems sparse is effectiv=
ely
> unmaintained at the moment so even if we could rectify things without the
> code upstream it gets us nowhere.  Hence my motivation to make this 'look
> like' existing stuff sparse is checking. The nearest being trylock.
> It makes me have more warm fuzzy feelings to be the same style of code
> as the other cases using the same infrastructure, than doing something ne=
w.

Me neither. I haven't looked at the sparse, I don't know how it works.

> Ideally sparse will eventually wake up again and we can have the __cond_a=
cquires()
> markings that we had in v1 and not have to have the implementation in the
> header. That currently requires trylock type boolean returns.

FWIW, Torvalds recently uploaded a new PoC branch in his sparse tree,
perhaps he can do something about it at the end of the day. I would Cc
him to the most needed sparse updates, like __cond_acquires().

> So overall I think this direction makes sense.  Also can't complain that =
it
> saves 1 line of code for every instance and removes false pretense that
> this thing returned a useful error code.

Right, so we have a trylock semantics for time being...

> > > At the end of the full series (not yet posted) is a patch that gets r=
id
> > > of their being any pretence this isn't a yes / no question and can
> > > return other error values. This intermediate step does leave it looki=
ng
> > > more confusing.
> > >
> > > Churn wise if we'd been able to do keep the error return and make spa=
rse
> > > work I could have just applied this to the original functions and mad=
e
> > > no changes at all to the vast majority of drivers.  Sadly that wasn't
> > > to be. End result of ending up with a trylock type approach is cleane=
r
> > > and more compact even if it's not what we have gotten used to for thi=
s
> > > particular function.
> >
> > > > > +}

--=20
With Best Regards,
Andy Shevchenko

