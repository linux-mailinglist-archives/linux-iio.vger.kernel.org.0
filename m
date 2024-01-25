Return-Path: <linux-iio+bounces-1914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E277F83C945
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jan 2024 18:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921C82967E5
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jan 2024 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08617137C3F;
	Thu, 25 Jan 2024 16:57:27 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFFB1420DE;
	Thu, 25 Jan 2024 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201846; cv=none; b=R8jXg2RQMPi+5vkpcivmX6GvzolKilandItEJfbuzKIx/Q72+tSA5VvgESA/pxQdv8gcvve3ygS/f5uRhVkGRCWF2L4+2fialnSFb2tyWaOr7uZqqBxQiY7DOPf5GuL8JyyXZxDKUaPuba2/HugjRsN1pgCGN0tPqIBuC97mhuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201846; c=relaxed/simple;
	bh=RiNRizmKhtZbovZ32UpEr84kGZN/y1z8+YDbC/izI9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDRM8LnROrHQAvy4W62g+ETpl47RnOW+xYwwECQbFwB5vlZ2cBlVZCixADjEYcqHpbULAuQA7rKN6Wg4Zy13u1O3CeMgLi1QoGfLaMYXhIZForG4aRbBr24ret2Hj599at8HDwVs5zxSzAI6L3QAtPE62NTpKbAh98AXF1kz3ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dfd973f3fdso929165a34.1;
        Thu, 25 Jan 2024 08:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706201844; x=1706806644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiNRizmKhtZbovZ32UpEr84kGZN/y1z8+YDbC/izI9k=;
        b=lAXFQNBfG1YvpY3KaQUfgchKE8pN4jIV4NDoVxaYZx6ZhhQKCrrT5nMfygjDl1AnCF
         VnZDht1k0tH9XPmE8bMxU+QQeoREq/kB4KTeJA1sEs6tLP14IqEOBhe+X7FOkI3RXN36
         VglZ0A7iSaN0pCrBRuGd5Mix9QXUwuJIVfT9h5mS6z+jNFyYmZs6ruZ0Aw5q8F89LAff
         gVpRrDzBL0gVy3JoYPzlibdOBtE03GodJtUr1XfyuY4Q0Lrt6M1s/REY4ninpxz2Xnh8
         HmGShIb7Q/dHg289vcsxQq0HjfcAazSxRFZ2WpfFWvDLeLECBv15G8D8pWY4hBtUNTmh
         0aPg==
X-Gm-Message-State: AOJu0YwrfciYJaqxGX8G6bIft9Q1D2+u2h9e1+T0X7ybTmuHglnf4ZkV
	LOL6UB1aSdP4AHSSEqwUbIjb7kfBLXUN18W/hAs9hWzFEgKkLVlh0lFnbYjgyIx1XcqHR/FsZd9
	gfJOxqI+ZHH8gJlBP5p4wGgCkwqbMApQlRsI=
X-Google-Smtp-Source: AGHT+IFv7QuJvr27LC9PmjbvnHxpdU8dlp8GNGoLYqLwP8M7RcYT0SM1kDKfAUAX+10ZKw5fL2gW2lvxNFcM8Kb5YgU=
X-Received: by 2002:a05:6870:b520:b0:214:2544:bf26 with SMTP id
 v32-20020a056870b52000b002142544bf26mr2275153oap.3.1706201844502; Thu, 25 Jan
 2024 08:57:24 -0800 (PST)
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
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Jan 2024 17:57:12 +0100
Message-ID: <CAJZ5v0iHJpvzrNSB4XEYxbTN+kQ6G_NXYrK4Z17WiFOTYDbm9w@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] driver: core: allow modifying device_links flags
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Saravana Kannan <saravanak@google.com>, nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 4:31=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
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
>
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

No, because DL_FLAG_AUTOREMOVE_SUPPLIER is only added to the link
flags if DL_FLAG_AUTOREMOVE_CONSUMER is already set in there and the
former replaces the latter.

Now, DL_FLAG_AUTOREMOVE_CONSUMER cannot be set in the link flags if
AUTOPROBE_CONSUMER is set in there.

> 3) Keep it as-is... This one is likely a NACK as I'm getting the feeling =
that
> clearing stuff that might have been created by fw_devlinks is probably a =
no-go.
>
> Let me know your thoughts...

If the original creator of the link didn't indicate either
DL_FLAG_AUTOREMOVE_CONSUMER, or DL_FLAG_AUTOREMOVE_SUPPLIER, they are
expected to need the link to stay around until it is explicitly
deleted.

Therefore adding any of these flags for an existing link where they
both are unset would be a mistake, because it would effectively cause
the link to live shorter than expected by the original creator and
that might lead to correctness issues.

Thanks!

