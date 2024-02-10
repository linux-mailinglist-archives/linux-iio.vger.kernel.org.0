Return-Path: <linux-iio+bounces-2369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FBA850564
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 17:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1731A285BC3
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 16:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479535C8F3;
	Sat, 10 Feb 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pdkj1U1J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696AB53815;
	Sat, 10 Feb 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583594; cv=none; b=YWQzKhlzAv7sfYhNlxbrqFabUWbn50nzTN6dDFXs5pfgx+lXb5Ckq9cCplJSlZgbf0E4zVzxzxWvphrPoRAICGAJ+nUF3vVDJgnWe6F9vwtiVC+GLQZYJ66i2KzqfKMuErgMh4+bgYmae0nPaRBOWUz2tNL1h8k0JhD58S80ACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583594; c=relaxed/simple;
	bh=uF/0Q+hh+EB/Ryd/jd7if3EhKP/ZPR4Y77SPn/T8mVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyiY/22qJg7CDHcEqYJXFUK5XFRLPXD6witpCjDCXHMNnMVaA1riPWx+5gpqJvllQmTT5Bsqko2W4Iq+IAMpJ9K0Q+hm01fgRuA0xWKVFype/ecdScBqpI/87juR2gvxjTnFGdUWT1Dx5fLFSth3+2rFrZ4c+v4Qznq/VTcnr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pdkj1U1J; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a34c5ca2537so244284166b.0;
        Sat, 10 Feb 2024 08:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707583590; x=1708188390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JMNYww4W2d3Ru1Gyj95iIBUMoBqeLdTXBDYv9vdUcs=;
        b=Pdkj1U1J0TpRwkwhuk4dpZZuCqrpHRFDpWZZ2YT+c6iVVTuLU7ByZbjS4oTCFtsP8k
         kbF4ol8XqF6laAiB6F3d+8KzsZhJlI5p4E86WlPfMSnd1ZJaZMOiniX4E9L45YJLjOPH
         gnt3oHzpL7PU/Cwye0idmp4JGR8qMayUOzSXQ3t5u/NuLTidXFo5sEcTPzkXMQ5JsUUX
         fDmsM009t2uLjeehLUB1jegsKl8vuyoPLLcQATpWy6SwxxguSdsqNnRAWY6LX9l0hxpQ
         jI8Dpool+AqekJIgJ7/AkbWMNog8rj02N4Zc41QqZyQmJAY6SCslsxM5JYhnKvvQjjAf
         ZwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707583590; x=1708188390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JMNYww4W2d3Ru1Gyj95iIBUMoBqeLdTXBDYv9vdUcs=;
        b=fTfoIHocfJzVRg8CaYZtp2fSL9+udIui8wen7W4alo76kHO18rLo1qIYFxaumci4Jz
         utDw7NoiZeef4O/SC5s1IUYcLzZFX81GX189LI3v0WFcH7yg9nBWlt/Gs3BADR5Oj5o1
         nbcKu4WNe8wW134D04TcydMWbhCC5t0+ZYoEFGkUEkNgsSsAS81FOCW0kQFpk6YHAgz1
         Usbsm3LvJjOUxzEOfC3jCVVnx6huJSMBzVXYjhVjzTt8NSxNyDCeXk69RFQ3oY0aIgI5
         rAVH1PCPoIlcvWzBDwiHZKZUWGrlbWP80Gdb7U7cChbdQvBk3CErgJq9wQa2Y7iR4Kdq
         1G2w==
X-Gm-Message-State: AOJu0YwndkZdI7e/5iuSUF2vs1xednS+h1ychGTWLnzUS+/qJSB0D2S0
	pR28UN35GQgAZUI7NHoYWhJBpOYJqGAaZr/LDno/flBx+nVt4Ai0vtz2PbErG0Dr99xcY6Q22XU
	qeXC6EHiMo5rWZFx+H3WjcwVPnMs=
X-Google-Smtp-Source: AGHT+IH1m23SIjqIl+WA8F9WiHmEA7Lz54P20eVi3bNzbZ3Oc0vOguk29THac6uOQcCovsThuKZ4Hwuqo7bXky3g0BQ=
X-Received: by 2002:a17:906:590a:b0:a36:fc15:c6b2 with SMTP id
 h10-20020a170906590a00b00a36fc15c6b2mr1377798ejq.35.1707583590365; Sat, 10
 Feb 2024 08:46:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
 <20240209-iio-backend-v10-5-3ed842064318@analog.com> <CAHp75VeqUnV33YF1WT9B0h=V_DpJBjwaH3g6AHiQQ-yDZBOyfg@mail.gmail.com>
 <20240210164152.49d5406a@jic23-huawei>
In-Reply-To: <20240210164152.49d5406a@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 10 Feb 2024 18:45:53 +0200
Message-ID: <CAHp75VfVK_9wr+fVLkMLoQk+ONgKNdpTdBodJSXE6msim_woaw@mail.gmail.com>
Subject: Re: [PATCH v10 5/7] iio: add the IIO backend framework
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 6:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Fri, 9 Feb 2024 18:30:53 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Fri, Feb 9, 2024 at 5:26=E2=80=AFPM Nuno Sa <nuno.sa@analog.com> wro=
te:

...

> > > +struct iio_backend *devm_iio_backend_get(struct device *dev, const c=
har *name)
> > > +{
> > > +       struct fwnode_handle *fwnode;
> > > +       struct iio_backend *back;
> > > +       unsigned int index;
> > > +       int ret;
> > > +
> > > +       if (name) {
> > > +               ret =3D device_property_match_string(dev, "io-backend=
-names",
> > > +                                                  name);
> > > +               if (ret < 0)
> > > +                       return ERR_PTR(ret);
> > > +               index =3D ret;
> > > +       } else {
> > > +               index =3D 0;
> > > +       }
> > > +
> > > +       fwnode =3D fwnode_find_reference(dev_fwnode(dev), "io-backend=
s", index);
> > > +       if (IS_ERR(fwnode)) {
> > > +               dev_err_probe(dev, PTR_ERR(fwnode),
> > > +                             "Cannot get Firmware reference\n");
> > > +               return ERR_CAST(fwnode);
> > > +       }
> > > +
> > > +       guard(mutex)(&iio_back_lock);
> > > +       list_for_each_entry(back, &iio_back_list, entry) {
> > > +               if (!device_match_fwnode(back->dev, fwnode))
> > > +                       continue;
> >
> > > +               fwnode_handle_put(fwnode);
> > > +               ret =3D __devm_iio_backend_get(dev, back);
> >
> > This order makes me think about the reference counting. So, fwnode is
> > the one of the backend devices to which the property points to.
> > Another piece is the local (to this framework) list that keeps backend
> > devices. So, fwnode reference can be  dropped earlier, while the usual
> > pattern to interleave gets and puts in a chain. Dunno if above needs a
> > comment, reordering or nothing.
> >
> I'm lost. Why don't we need to hold fwnode reference for the
> device_match_fwnode() just before here?

> Or do you mean that we are safe here with the fwnode_handle_put() being
> before the __devm_iio_backend_get()?

This one.

> I think you are correct that the
> lifetimes are fine as we switched from the fwnode to the
> iio_backend from the list at this point.
>
> > > +               if (ret)
> > > +                       return ERR_PTR(ret);
> > > +
> > > +               return back;
> > > +       }
> > > +
> > > +       fwnode_handle_put(fwnode);
> > > +       return ERR_PTR(-EPROBE_DEFER);
> >
> > While thinking about the above, I noticed the room to refactor.
> >
> >   list_for_each_entry(...) {
> >     if (...)
> >       break;
> >   }
> >   fwnode_handle_put(...);
> >   // Yes, we may use the below macro as the (global) pointers are
> > protected by a mutex.
> >   if (list_entry_is_head(...))
>
> Knowing that means we failed to match is a bit obscure.
>
> >     return ERR_PTR(...);
> >
> >   ret =3D __devm_iio_backend_get(...);
> >   ...
>
> Maybe - it's a little ugly either way.  I don't think we care about
> potentially holding the fwnode handle too long, so flipping over to
> the cleanup.h handling (I need to get back to that sometime this week)
> will make this all simpler.

Yes, I agree with your point of view. That's why I'm not insisting on
this change.

> > > +}


--=20
With Best Regards,
Andy Shevchenko

