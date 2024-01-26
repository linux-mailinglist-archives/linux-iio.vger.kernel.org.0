Return-Path: <linux-iio+bounces-1916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE96183D1CF
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jan 2024 01:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A4B1F24C04
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jan 2024 00:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2970264C;
	Fri, 26 Jan 2024 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMNhX/U/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E181387
	for <linux-iio@vger.kernel.org>; Fri, 26 Jan 2024 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230711; cv=none; b=jvwQU78Y9J4EhFDFpPZUi6Tnw68Mva57q8zPGok6qa9do86Iu4WYARL7gchiN5j+EzDATzr+T5czWeAixVI+etwHshkujHSmo1aSloHCyNBYoLcsqxnw72i+72M/2tvyjKmUghmr7piaenEo0T8xGXOHJrrZhy2mwARVLu8tJbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230711; c=relaxed/simple;
	bh=/95FQAjZqLK7gGuRsgB2xPz1n7S89cJn98y1Y5Udp/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDD255ksVpCb8fGEjsUlK6LjHKYKBcMBwAJ4RIuTMm7mY4upiBoU35kR/T/+UlO7ka5bhM329bYrF1UtbT1B1e2o8xxZMk6pNo/i3dHU4f/FMnw74VWheluDpzuWF+VE71C914qSvtaEl8qutSxMBVJvIORZQrZYMhhwWxIYeas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMNhX/U/; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42a7765511bso47561cf.1
        for <linux-iio@vger.kernel.org>; Thu, 25 Jan 2024 16:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706230709; x=1706835509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/95FQAjZqLK7gGuRsgB2xPz1n7S89cJn98y1Y5Udp/0=;
        b=YMNhX/U/xuS64jMt95rB9CDvMdEkX20vrhLSVMuajWIQd0eoicnvQm9hUb1TmIJUtJ
         KLeOwXiToGuS3xxPpmqB348UDNrJ88QurLk8ir5L9TMa1pFb3iXI0CQZbTYxAYpYc/M3
         4boCPN/XDslWlXYxkYx870mtbYmC7FflSCwF+fErgGfVhLbNr+dxriBeNJydF/nI7WvH
         5dqoY975a/0uxEvoovgbRdXpW/qQdKGtTkCJuUYDxlINqZ4d99spOh4YYnRwYlRItLCl
         91Aq0IbEyFV2plgO+04+EOO24Wy8Y4dwZBni6aEIwGPmbMukz1mGPuD5jF1AgtIn6Icw
         jIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706230709; x=1706835509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/95FQAjZqLK7gGuRsgB2xPz1n7S89cJn98y1Y5Udp/0=;
        b=nBjvhIrk9xTa+MmIQF+R0fLlned9bmvXWlb1q0N9RNDi1U6fpgLgIH82D8wEl4qIlh
         u0/+ogEWo668IYJLkoAErXBs+nYwYS9IYn2qMb/hnTRjDXWenLirYfJ4oI6L6rWEIqhK
         dY/qZF9Y2+OBuAHlqdh44uAr+AGmQE7m9BDudMrb/nT0pqWO8B8ZKWIsAXF79ztZL5IW
         d50boYI6powKBYAeBEJhOtzv9C73vc7wirJdi+9xsXHEq6v+BcQdxRwJ8VzHtBsO3whR
         kbbojiIvUlWz06kIlVSXyOz4ZMs3CS2jO8dssmVfNN3e4Z2qo7JLYdDYeKEMtQQ3oFbm
         YW+Q==
X-Gm-Message-State: AOJu0YzDQ67bIQ+r9e0BwQuAUouJ3d8BrKI3hB7Nvyjkz5EzxFHNeAFo
	6cUDNzx31OtejCSrMmhUM9BoF82J3jgR8QfTeOB8Dno9XjlV/YXzQD+Vc08JZg9mg0PKplU0V/w
	O8tRQ64S3BpBrSsr9oxTwtZjUz24V8k0o9koe
X-Google-Smtp-Source: AGHT+IHEjd5BR8L9kQOHFEvCP6qG5UAH3qgJGozz4IFnJY6RHAf10WCZ4i8cJqq6VumAg7qTr6ESZ85uPHbO8nGPbJA=
X-Received: by 2002:a05:622a:6183:b0:429:c6bc:330c with SMTP id
 hh3-20020a05622a618300b00429c6bc330cmr88128qtb.14.1706230709175; Thu, 25 Jan
 2024 16:58:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
 <20240123-iio-backend-v7-4-1bff236b8693@analog.com> <CAGETcx8_0ExTG4ASb9xK-uwmubMFDx44_wUf1h3VsO8w9jJApQ@mail.gmail.com>
 <8eae083af481441d83df02a1880e2aedf99efdfb.camel@gmail.com> <ef59aaa2a251e92d463d8983ab6eec459298c102.camel@gmail.com>
In-Reply-To: <ef59aaa2a251e92d463d8983ab6eec459298c102.camel@gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 25 Jan 2024 16:57:51 -0800
Message-ID: <CAGETcx8-WqrjhXLZdtGwnHzc3_VGkUcd2MUgnuAC0JaBHiVQpA@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] driver: core: allow modifying device_links flags
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 7:31=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Thu, 2024-01-25 at 09:14 +0100, Nuno S=C3=A1 wrote:
> >
> > Hi Saravana,
> >
> > Thanks for your feedback,
> >
> > On Wed, 2024-01-24 at 19:21 -0800, Saravana Kannan wrote:
> > > On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Relay
> > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > >
> > > > From: Nuno Sa <nuno.sa@analog.com>
> > > >
> > > > If a device_link is previously created (eg: via
> > > > fw_devlink_create_devlink()) before the supplier + consumer are bot=
h
> > > > present and bound to their respective drivers, there's no way to se=
t
> > > > DL_FLAG_AUTOREMOVE_CONSUMER anymore while one can still set
> > > > DL_FLAG_AUTOREMOVE_SUPPLIER. Hence, rework the flags checks to allo=
w
> > > > for DL_FLAG_AUTOREMOVE_CONSUMER in the same way
> > > > DL_FLAG_AUTOREMOVE_SUPPLIER is done.
> > >
> > > Curious, why do you want to set DL_FLAG_AUTOREMOVE_CONSUMER?
> > > Especially if fw_devlink already created the link? You are effectivel=
y
> > > trying to delete the link fw_devlink created if any of your devices
> > > unbind.
> > >
> >
> > Well, this is still useful in the modules case as the link will be rela=
xed
> > after
> > all devices are initialized and that will already clear AUTOPROBE_CONSU=
MER
> > AFAIU. But, more importantly, if I'm not missing anything, in [1], fw_d=
evlinks
> > will be dropped after the consumer + supplier are bound which means I
> > definitely
> > want to create a link between my consumer and supplier.
> >
>
> Ok, so to add a bit more on this, there are two cases:
>
> 1) Both sup and con are modules and after boot up, the link is relaxed an=
d thus
> turned into a sync_state_only link. That means the link will be deleted a=
nyways
> and AUTOPROBE_CONSUMER is already cleared by the time we try to change th=
e link.
>
> 2) The built-in case where the link is kept as created by fw_devlink and =
this
> patch effectively clears AUTOPROBE_CONSUMER.

I still don't see a good reason for you to set those flags. And if you
see my other reply, I'm not sure you even need to make changes. Just
use the existing command line arg.

> Given the above, not sure what's the best option. I can think of 4:
>
> 1) Drop this patch and leave things as they are. DL_FLAG_AUTOREMOVE_CONSU=
MER is
> pretty much ignored in my call but it will turn the link in a MANAGED one=
 and
> clear SYNC_STATE_ONLY. I could very well just pass 0 in the flags as
> DL_FLAG_AUTOREMOVE_CONSUMER is always ignored;
>
> 2) Rework this patch so we can still change an existing link to accept
> DL_FLAG_AUTOREMOVE_CONSUMER (in the modules case for example).
>
> However, instead of clearing AUTOPROBE_CONSUMER, I would add some checks =
so if
> flags have one of DL_FLAG_AUTOREMOVE_SUPPLIER or DL_FLAG_AUTOREMOVE_CONSU=
MER and
> AUTOPROBE_CONSUMER is already set, we ignore them. In fact, right now, I =
think
> one could pass DL_FLAG_AUTOREMOVE_SUPPLIER and link->flags ends ups with
> AUTOREMOVE_SUPPLIER | AUTOPROBE_CONSUMER which in theory is not allowed..=
.

This is all way too complicated and I still see no good reason to use
those flags in whatever case you have in mind.

And Rafael explained why your changes don't make sense. Once a link is
created, any AUTOREMOVE flags should be set.

> 3) Keep it as-is... This one is likely a NACK as I'm getting the feeling =
that
> clearing stuff that might have been created by fw_devlinks is probably a =
no-go.
>
> Let me know your thoughts...

Basically drop this patch. I don't see a point in this.

-Saravana

