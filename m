Return-Path: <linux-iio+bounces-1917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECA183D58C
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jan 2024 10:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A61285B33
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jan 2024 09:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1D713FEB;
	Fri, 26 Jan 2024 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUWh5urm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06B211CBB;
	Fri, 26 Jan 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256084; cv=none; b=QCz1ejOwt9SsRfHi2cEzYEJF1xKYryR3WmGBZBiNRzCU/oVcZMdmMIefcLtfruqyFUGhOrxA8B8H0atmlvdxph9R+UZT6WinRmrxHjBy0V2WuH7S2W//iz9+j2sZC5prA0fUUvTSj2m4MUQFRXKsJ1jx01H8l02yu6Ww6IcmEHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256084; c=relaxed/simple;
	bh=NFyzYkS6y0G7Qwni6J/7G16JElmLY/jjkE2rhD1Zl74=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qfCRCOhRRVr5YQIUe8LqabKEzC9ZcsVCmQAG7LHdyz1utK1rA0s0AQRKlxSFIE0SSJSGe2SuthaJqSuP//p8Pi/hBUQPMgta/NWj1K++Wy0Vzxb2e50t+qldMsmww1jp3kYV+h8aooaWcV+4gRPJ0nrY9j4HKp7J8I+JRv263eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUWh5urm; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so67868a12.1;
        Fri, 26 Jan 2024 00:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706256081; x=1706860881; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NFyzYkS6y0G7Qwni6J/7G16JElmLY/jjkE2rhD1Zl74=;
        b=XUWh5urmVf/C9mCzED4s4DtzrzvpbMfF64w1mwAvrC9rbPK7eQpOCQczqWUrUfx27Y
         vgh4e1hYwTb4OaV821RT45tgYkdkH6hb8ydHcmsuD7jEEW6ukXrrOehD3ZkPngjEI9Jg
         0r+FNWXbL6iLSrZABfIRkf+te5dyVM/zdeEBQ+C/mWDs/3rCoxDsu1yAva6c16E6ZBhw
         GPSNO/GRx4n+TnWt7e32ZBbcQGlpb89MCgyB2g/H/p3nPaa9Cw5C4Zhwd1DopscD3wmx
         wadkaqXK3avAFZY0FphQPAMgTrsqFHaZbAUF2xlGSmNmmHVC0GReysNpakiGOT2dpF49
         rf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706256081; x=1706860881;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFyzYkS6y0G7Qwni6J/7G16JElmLY/jjkE2rhD1Zl74=;
        b=UiHb2g3Rx2u6h+BHOOYpdc9QwAKQR5nqXqH9h3bjzy1yHzMFqUkGOUHw99Iw2+7uB/
         QpEvRM7w/Rj8HwxJdnxGfs3xDxGBIkaMyaa2c0oe/zZtUfFquqPepjJdaDgSonzgbxVj
         GEej9Fdce4R4jUCx3NI3NOKdEOTj9tKIOo7yrGvGLgn61bAiiGQIaQ/N1XiIcADH/m4b
         cKP23F6h/chYf32VcukfMfVeLWOSTWZHMGVzqiTmtW6y7YWtEhUaZD/7lAQ+aMMzNxn/
         V5JUSd4veCd/IgP9Hq20nuGjWbU6s3rRGzq4JRFYCChqTVaR2WQsYXh5IyAxisnZElch
         ry7Q==
X-Gm-Message-State: AOJu0Yw1TJqhSppjI5qhj25el7uAW6sYyoWEcT9r7xKcHL+xp/b7hI6M
	AIG5wkicvLEUmX9qEMu/FmGTuqJ7t7rrnQk5H4v5jLGtkrUH/GyPam96OElEueSyinnv
X-Google-Smtp-Source: AGHT+IGvXoOvRFcA/6xKIVF+oNYRqu7Hc/7tJ2hDdwiCBQ0LS27fqKhx/D1uRKwU3et5bt+ERWiOzw==
X-Received: by 2002:a17:906:22db:b0:a30:a8b3:e2b5 with SMTP id q27-20020a17090622db00b00a30a8b3e2b5mr552913eja.55.1706256080543;
        Fri, 26 Jan 2024 00:01:20 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id vb1-20020a170907d04100b00a34c07816e3sm334000ejc.73.2024.01.26.00.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:01:20 -0800 (PST)
Message-ID: <ff0b5a9362061fb6969099bc7ae6a0b43707968f.camel@gmail.com>
Subject: Re: [PATCH v7 4/9] driver: core: allow modifying device_links flags
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, nuno.sa@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Fri, 26 Jan 2024 09:04:36 +0100
In-Reply-To: <CAJZ5v0iHJpvzrNSB4XEYxbTN+kQ6G_NXYrK4Z17WiFOTYDbm9w@mail.gmail.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	 <20240123-iio-backend-v7-4-1bff236b8693@analog.com>
	 <CAGETcx8_0ExTG4ASb9xK-uwmubMFDx44_wUf1h3VsO8w9jJApQ@mail.gmail.com>
	 <8eae083af481441d83df02a1880e2aedf99efdfb.camel@gmail.com>
	 <ef59aaa2a251e92d463d8983ab6eec459298c102.camel@gmail.com>
	 <CAJZ5v0iHJpvzrNSB4XEYxbTN+kQ6G_NXYrK4Z17WiFOTYDbm9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-25 at 17:57 +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 25, 2024 at 4:31=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > On Thu, 2024-01-25 at 09:14 +0100, Nuno S=C3=A1 wrote:
> > >=20
> > > Hi Saravana,
> > >=20
> > > Thanks for your feedback,
> > >=20
> > > On Wed, 2024-01-24 at 19:21 -0800, Saravana Kannan wrote:
> > > > On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Relay
> > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > > >=20
> > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > >=20
> > > > > If a device_link is previously created (eg: via
> > > > > fw_devlink_create_devlink()) before the supplier + consumer are b=
oth
> > > > > present and bound to their respective drivers, there's no way to =
set
> > > > > DL_FLAG_AUTOREMOVE_CONSUMER anymore while one can still set
> > > > > DL_FLAG_AUTOREMOVE_SUPPLIER. Hence, rework the flags checks to al=
low
> > > > > for DL_FLAG_AUTOREMOVE_CONSUMER in the same way
> > > > > DL_FLAG_AUTOREMOVE_SUPPLIER is done.
> > > >=20
> > > > Curious, why do you want to set DL_FLAG_AUTOREMOVE_CONSUMER?
> > > > Especially if fw_devlink already created the link? You are effectiv=
ely
> > > > trying to delete the link fw_devlink created if any of your devices
> > > > unbind.
> > > >=20
> > >=20
> > > Well, this is still useful in the modules case as the link will be re=
laxed
> > > after
> > > all devices are initialized and that will already clear AUTOPROBE_CON=
SUMER
> > > AFAIU. But, more importantly, if I'm not missing anything, in [1],
> > > fw_devlinks
> > > will be dropped after the consumer + supplier are bound which means I
> > > definitely
> > > want to create a link between my consumer and supplier.
> > >=20
> >=20
> > Ok, so to add a bit more on this, there are two cases:
> >=20
> > 1) Both sup and con are modules and after boot up, the link is relaxed =
and
> > thus
> > turned into a sync_state_only link. That means the link will be deleted
> > anyways
> > and AUTOPROBE_CONSUMER is already cleared by the time we try to change =
the
> > link.
> >=20
> > 2) The built-in case where the link is kept as created by fw_devlink an=
d
> > this
> > patch effectively clears AUTOPROBE_CONSUMER.
> >=20
> > Given the above, not sure what's the best option. I can think of 4:
> >=20
> > 1) Drop this patch and leave things as they are. DL_FLAG_AUTOREMOVE_CON=
SUMER
> > is
> > pretty much ignored in my call but it will turn the link in a MANAGED o=
ne
> > and
> > clear SYNC_STATE_ONLY. I could very well just pass 0 in the flags as
> > DL_FLAG_AUTOREMOVE_CONSUMER is always ignored;
> >=20
> > 2) Rework this patch so we can still change an existing link to accept
> > DL_FLAG_AUTOREMOVE_CONSUMER (in the modules case for example).
> >=20
> > However, instead of clearing AUTOPROBE_CONSUMER, I would add some check=
s so
> > if
> > flags have one of DL_FLAG_AUTOREMOVE_SUPPLIER or DL_FLAG_AUTOREMOVE_CON=
SUMER
> > and
> > AUTOPROBE_CONSUMER is already set, we ignore them. In fact, right now, =
I
> > think
> > one could pass DL_FLAG_AUTOREMOVE_SUPPLIER and link->flags ends ups wit=
h
> > AUTOREMOVE_SUPPLIER | AUTOPROBE_CONSUMER which in theory is not allowed=
...
>=20
> No, because DL_FLAG_AUTOREMOVE_SUPPLIER is only added to the link
> flags if DL_FLAG_AUTOREMOVE_CONSUMER is already set in there and the
> former replaces the latter.
>=20

Oh yes, I missed that extra if() against the DL_FLAG_AUTOREMOVE_CONSUMER fl=
ag...

> Now, DL_FLAG_AUTOREMOVE_CONSUMER cannot be set in the link flags if
> AUTOPROBE_CONSUMER is set in there.
>=20
> > 3) Keep it as-is... This one is likely a NACK as I'm getting the feelin=
g
> > that
> > clearing stuff that might have been created by fw_devlinks is probably =
a no-
> > go.
> >=20
> > Let me know your thoughts...
>=20
> If the original creator of the link didn't indicate either
> DL_FLAG_AUTOREMOVE_CONSUMER, or DL_FLAG_AUTOREMOVE_SUPPLIER, they are
> expected to need the link to stay around until it is explicitly
> deleted.
>=20
> Therefore adding any of these flags for an existing link where they
> both are unset would be a mistake, because it would effectively cause
> the link to live shorter than expected by the original creator and
> that might lead to correctness issues.
>=20
> Thanks!

Thanks Rafael, your last two paragraphs make it really clear what's the
reasoning and why this patch is wrong.

Jonathan, if nothing else comes that I need a re-spin, can you drop this pa=
tch
when applying?

I think we can keep the DL_FLAG_AUTOREMOVE_CONSUMER in the device_link_add(=
)
call as it will be ignored if fw_devlinks already created the link but migh=
t be
important if the kernel command line fw_devlink is set to 'off'.

Or maybe, as Saravan mentioned in his reply we can just pass DL_FLAG_MANAGE=
D as
having the link around is useful in case we re-probe so we don't need to ca=
ll
the consumer probe function (just to EPROBE_DEFER) without the supplier bei=
ng
already there...

- Nuno S=C3=A1

