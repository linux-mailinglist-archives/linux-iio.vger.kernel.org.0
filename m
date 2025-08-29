Return-Path: <linux-iio+bounces-23382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E3B3BFC1
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 17:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C04318850C4
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADD8322A25;
	Fri, 29 Aug 2025 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YebqOPZp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFEB1FDA8E;
	Fri, 29 Aug 2025 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482386; cv=none; b=Ooe1HH4/3KZCkt9DGz77RNnMgfbyt1JzHrfZIkN/0I3FwLI271VCDyT7/1xzJbFD7GJ6Y7UGKKd1IxKVhfUCyoykiAnvfqBVNEPzXpnhAh5NI5CVG4k8zd71RikYb7mmBpdz7W6rhhSTBzEKqLWbmHj2KZBJrSjE+W9mlH08NS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482386; c=relaxed/simple;
	bh=e8sPJ17X+lx75ldP5qXIgx8J6qr4yE02nWaybFqGuV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X711LWqKh3N3aRcjs19zJhjWLHq1vatSaYFVLhfKlsbvDuL2UwuQY9qmIAfusA0w/vdpmGZXFVTxM1t2ur0bm0/C2xfsvap49rdE2Uoo2auVfQNIXGd+dDFgWEmi1kEfhP+il7tJaX4h9pIKabq9pClZmXM1OrkVtCu8LwBpLY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YebqOPZp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7322da8so413486966b.0;
        Fri, 29 Aug 2025 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756482383; x=1757087183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtBPqIA1JNDFzQcRGMtKE4PPP5Dg2NN/VZpcc5GHJUc=;
        b=YebqOPZpWCLr6AnBw7hxSQpAAfoHk7UEIMRMlJMQ2Qlc0CCTrTI9GJ2C2/ABeRUzDp
         B5sdYpFmvOb/mbHzzCG9F5TC2YzkVDgZNP+eHsNRqrzh9LyyPoILgxRCI8zIB0ECths6
         z8NagLDnj9mM02M12H+wx7qqaUYL3bfePGmWrQBB87AcSlS4ouKgzYSl2een8Fs/2RO3
         q1RC1PYKmMwurjrfvV+4pAEUQmHuTe4hvhDkfxaRcCscU6PGimIN/9iZQ7wclJSwzPNG
         /iY89c9TV7LDlDNDLl34iHPVudiSCV18DfgVE8OYi5X6RzPci3RtRqjeR6D/dRh696O0
         vglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756482383; x=1757087183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtBPqIA1JNDFzQcRGMtKE4PPP5Dg2NN/VZpcc5GHJUc=;
        b=jTiWcU4vaYgJNexfrrbFuPfJaAKFyPYW+x25J1WcrF7wtLo4I37EzZQucbZPew2BKS
         Fxi6s8HtpJ+PjpuIl8Sxv3QDisVwO3lvnxKZCYp1EkFZ9jZRqwiS8SC5dywGTY5Fc/4w
         LqE63AuomtygxfgimG/nfvokg/+PDbQhzm5AJ7uzVB3Fj7AbdfexHWbAKq3i3g+vftD/
         2GJcXlw+aFac+JohsLGIcRqQ3cWlwp+Ka7LcvBmpaTjpC+R5jalSkxun+1Fjlub7+UHw
         HVXFGuLB1+fde1MoIUoqm4cfWUK2yBWMDbTTT65HVg6Jdhv72brYkCsWKuFuyLofP0yQ
         p3/g==
X-Forwarded-Encrypted: i=1; AJvYcCUgY8gTaZOBJT1pSQ+pfFUhEtTqJcTT1ktCaWUdVD61siKutuKkmplF+8HB094mM94/xZxvL9zWgOo=@vger.kernel.org, AJvYcCWKquYuqlFMZSZ2noX0dHti2oesDFQ7hV8cEaXDqWdPBDV0DBwdhrauOPSjrsLamxU2dCf3XZSN8sicI+Zb@vger.kernel.org
X-Gm-Message-State: AOJu0YxcxQ1bPU6YdvyG0xDSjdFy0JLheg4r7klyuzl4fJbmQ3Plca/u
	Am3tnE4Q9kaW2/p6i53/UvqPAJZuh6wwA0dEPO1BKwv1a/BGHdDGRE03eLPVYZUe+D3ZljmP93r
	nxoOKAADIq7rtFZwPyA2xh67sD8vBgGI=
X-Gm-Gg: ASbGncuYArWZAdVnjCiQ9wxhAXFsXr9RfRFudCOeTpuPzenQ0HTFAf8P4LvG6V3lk5c
	NeXrBb6foofIVTqvkGFg8vsh0UMXtbel/f1cJSol8FJTFghcIOYiyeEK0CJiaj4J1BjBQU4R7E7
	aciL0oAYaPMtYehGpG7VO+XQ6FeuaStjoL4P4W3j8xmNlaI41nVvKxPPZ0zBQCZ3fsei628yFJ4
	368HhBMysi9Phc/MRhnVielnels
X-Google-Smtp-Source: AGHT+IHKZ0uhaYWfLOR20ILvJCb538AxW9DNi1ux4ORmh8nz6Oiwfh9sRLvxz0fzGbs+0PGLmbhhcDthOMbxWdll2uE=
X-Received: by 2002:a17:907:3cc8:b0:afe:c2e7:3705 with SMTP id
 a640c23a62f3a-afec2e74289mr956271666b.22.1756482383014; Fri, 29 Aug 2025
 08:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827191919.1361787-1-akshayaj.lkd@gmail.com>
 <CAHp75VdQB673=qXBp0mPUHxQGxM=Z1CNSmEpP82OprVn++Y5uw@mail.gmail.com> <CAE3SzaTJTi3bHnqNbAfQ3W2jHcmhQHqa2ZtKE7=2BnP+onJv-w@mail.gmail.com>
In-Reply-To: <CAE3SzaTJTi3bHnqNbAfQ3W2jHcmhQHqa2ZtKE7=2BnP+onJv-w@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Aug 2025 18:45:46 +0300
X-Gm-Features: Ac12FXy0Uq5hmJ8bzIiGaGfVOD5zp_OIHnBu4TEY5qqqagBQgF8nppcVFglAx9s
Message-ID: <CAHp75VeSMApm0TPU1=myhJiXQjWVpebbWEPGcRJQhfSaffdYmw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: ltr390: Implement runtime PM support
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 9:47=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail.c=
om> wrote:
> On Thu, Aug 28, 2025 at 7:17=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Aug 27, 2025 at 10:19=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gm=
ail.com> wrote:

...

> > > +static int ltr390_read_raw(struct iio_dev *iio_device,
> > > +                          struct iio_chan_spec const *chan, int *val=
,
> > > +                          int *val2, long mask)
> > > +{
> > > +       int ret, retval;
> > > +       struct ltr390_data *data =3D iio_priv(iio_device);
> > > +       struct device *dev =3D &data->client->dev;
> > > +
> > > +       ret =3D pm_runtime_resume_and_get(dev);
> > > +       if (ret < 0)
> > > +               dev_err(dev, "runtime PM failed to resume: %d\n", ret=
);
> >
> > If it fails, there is no point to read the value, it will be garbage
> > or even can make the bus stuck.
> >
> My rationale behind this approach is that earlier ltr390_read_raw()
> had all the functionality
> of the .read_raw callback so the return value whether success or
> failure was of the core functionality.
> But now, since the core functionality has been relocated into
> __ltr390_read_raw(), I felt the return value
> ltr390_read_raw should be the return value of __ltr390_read_raw().

"Main" returned value. But this is not the point. The Q is, how do you
expect to get not a garbage from, e.g., powered off device, please?

> Hence I thought, it will be better to
> just print dev_err for runtime PM failures and return the retval of
> __ltr390_read_raw only.
> Let me know your thoughts on this. Will make the change accordingly in
> the next version.


--=20
With Best Regards,
Andy Shevchenko

