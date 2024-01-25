Return-Path: <linux-iio+bounces-1906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC40C83BB58
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jan 2024 09:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16071C25D5D
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jan 2024 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D87017551;
	Thu, 25 Jan 2024 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC01qIYr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6E11798A;
	Thu, 25 Jan 2024 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170269; cv=none; b=Z1A5NApSWgo5LYSIF5YuH2PgJBF7gevUdPT3IDbFgd1GuSyn8YBb3KB2IYuF3RNbbGRUNdmbaeAVoKSgXYpJiBCMX3cVbvRNvpCnp35JgaM911ALAvAqfLpMKl5iSUmsrDINtI+7WOq1MGon0kMzF7UeEg5aY+RJvFjLsHJQ4Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170269; c=relaxed/simple;
	bh=AFQeLGJ3SlHqENDbSrFuGEHGU0fgFNqj/hlb6fOw6UY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eirve219EAzSgx5Nym2gRjsPwfVVbTfYhYtToT8O3atuI74jFZkSDaOBCQV9CAsNUNhhqiSuOCVHYlS09MLPjbUoRrrEUE18c4OEwwIInlDIypbzq4iS+Ff2TxXYFPK4yacW+g98qYEStSy8i5p7BjbxOSYc9X62a5fO+mHH5wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC01qIYr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a27733ae1dfso666996366b.3;
        Thu, 25 Jan 2024 00:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706170266; x=1706775066; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AFQeLGJ3SlHqENDbSrFuGEHGU0fgFNqj/hlb6fOw6UY=;
        b=WC01qIYrTfEMzKEnchdESlrO6o1Ub/Odaf8d361ivUfbhRJ7ZZm43qkqT52yZ48KY9
         QqtyK4M7DL9Ncce3KVB2iUtSCNMX0QMqigY3/oPGerZxFzPfkSYT1twLwcueHh6JqSVW
         19YwxT7Rt272Qvaw9P2G0GQClSgjYTkagY/rblGyEhmdqkU4I3gGbQejF1AMdY/W3DmE
         +QmVsi1h+D0FiOvY24I3nMAbB3yrjo/XBphHnOShFDYnjCDSYAv90bPCtoxQZIjKJU7q
         U15juR1mdf209W28efnrVtrVdunHckmvEAA8h2w8DqX2Ax1JwAOIGac3wcW2TZDJ0Ob0
         yl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706170266; x=1706775066;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFQeLGJ3SlHqENDbSrFuGEHGU0fgFNqj/hlb6fOw6UY=;
        b=FLtwv/iLcd9szu6IpMM0NsCsqxhElZwDN9cxciJvzgrfrhzfrZKzlYvXeCf7B/0PB8
         Eg4eR+bRK8TOPleopEDp+ntsFzWkj8T55DBTGA43wXgjriyiBGy3rJs09pWzDNAPn9vu
         V69Qs2H/uts808ffSXaaq1fD1/u1DR52+PShBFlBS4PFFgaTCWM9Fdsiv1ok7KTivzmo
         PPPyBkD7sTpyBiA+bSLjHyBSfrRMICAKRffTeICKZNXWh5RtfjgGZfU2Sc9uFnGaOgJJ
         DSipmQ4rF4cFnNu50Ksp7OCAeHdBhCbG0+xsVWeL/Iczn6Knrmn7b2byxjAbgeWvDHE3
         siaw==
X-Gm-Message-State: AOJu0YybAtzxTcGXZkbcNMW/aFWEAh1ZdftBQXF5d0GQvcQ/8qGPmmtW
	q4exihLQ7JqAQoN9c+7JLvkU+E20khxawIQXvrDKVZrCbv3j4FY/
X-Google-Smtp-Source: AGHT+IFfH5knZNZq+oc8cDv/5dkB0G7tYIXy6KRJ76RPHc4m89958eb/G2kdO3NbO9WThcouH/Tl6w==
X-Received: by 2002:a17:906:b052:b0:a31:6811:bf99 with SMTP id bj18-20020a170906b05200b00a316811bf99mr205372ejb.56.1706170265420;
        Thu, 25 Jan 2024 00:11:05 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id vt6-20020a170907a60600b00a317be75012sm360042ejc.27.2024.01.25.00.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 00:11:05 -0800 (PST)
Message-ID: <8eae083af481441d83df02a1880e2aedf99efdfb.camel@gmail.com>
Subject: Re: [PATCH v7 4/9] driver: core: allow modifying device_links flags
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Saravana Kannan <saravanak@google.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Thu, 25 Jan 2024 09:14:20 +0100
In-Reply-To: <CAGETcx8_0ExTG4ASb9xK-uwmubMFDx44_wUf1h3VsO8w9jJApQ@mail.gmail.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	 <20240123-iio-backend-v7-4-1bff236b8693@analog.com>
	 <CAGETcx8_0ExTG4ASb9xK-uwmubMFDx44_wUf1h3VsO8w9jJApQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


Hi Saravana,

Thanks for your feedback,

On Wed, 2024-01-24 at 19:21 -0800, Saravana Kannan wrote:
> On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > If a device_link is previously created (eg: via
> > fw_devlink_create_devlink()) before the supplier + consumer are both
> > present and bound to their respective drivers, there's no way to set
> > DL_FLAG_AUTOREMOVE_CONSUMER anymore while one can still set
> > DL_FLAG_AUTOREMOVE_SUPPLIER. Hence, rework the flags checks to allow
> > for DL_FLAG_AUTOREMOVE_CONSUMER in the same way
> > DL_FLAG_AUTOREMOVE_SUPPLIER is done.
>=20
> Curious, why do you want to set DL_FLAG_AUTOREMOVE_CONSUMER?
> Especially if fw_devlink already created the link? You are effectively
> trying to delete the link fw_devlink created if any of your devices
> unbind.
>=20

Well, this is still useful in the modules case as the link will be relaxed =
after
all devices are initialized and that will already clear AUTOPROBE_CONSUMER
AFAIU. But, more importantly, if I'm not missing anything, in [1], fw_devli=
nks
will be dropped after the consumer + supplier are bound which means I defin=
itely
want to create a link between my consumer and supplier.=C2=A0

FWIW, I was misunderstanding things since I thought DL_FLAG_AUTOREMOVE_CONS=
UMER
was needed to make sure=C2=A0the consumer is unbound before the supplier. B=
ut for
that I think I can even pass 0 in the flags as I only need the link to be
MANAGED. Still, I think having DL_FLAG_AUTOREMOVE_CONSUMER makes sense.

Also note that there are more places in the kernel with
DL_FLAG_AUTOREMOVE_CONSUMER and that flag is likely being ignored in case t=
he
link already exists.

I'm also clearing DL_FLAG_AUTOPROBE_CONSUMER as from the first check in
device_link_add(() check I realize that we can't/shouldn't have it together=
 with
one of AUTOREMOVE_CONSUMER | AUTOREMOVE_SUPPLIER, right? At this point,
AUTOPROBE_CONSUMER is also likely not that useful anymore as both supplier =
and
consumer are up and I guess that's the typical case for subsystems/drivers =
to
call device_link_add().

And since I have your attention, it would be nice if you could look in anot=
her
sensible patch [2] that I've resended 3 times already. You're not in CC but=
 I
see you've done quite some work in dev_links so... Completely unrelated I k=
now
:)

[1]: https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L12=
92
[2]: https://lore.kernel.org/all/20231213-fix-device-links-overlays-v1-1-f0=
91b213777c@analog.com/#t

- Nuno S=C3=A1
>=20


