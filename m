Return-Path: <linux-iio+bounces-1919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC18383D5AD
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jan 2024 10:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841792884CC
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jan 2024 09:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084B81CFB4;
	Fri, 26 Jan 2024 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqB1wPAx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0394010A17;
	Fri, 26 Jan 2024 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256616; cv=none; b=d2P8gyjCSGc7D3oxG7PE/2BXJrExdiNrg5kPHGckJPN+7EZu/mJaF3jPlN3v8NT9v/i7Vop3dstpuo2OvWXvMBxatnsTnPRknWWSpNypvNFaL5np6LDCHdvdzVcFKzGLYnfKe6vEXI51CK2QCi/HFxGVNvBzeifZCCfdfxMPSqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256616; c=relaxed/simple;
	bh=fjJDWMW4vwQS9Nf0tVgun4J7xTALICwka7Pe6pGqZc0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DYzhNAP+zetyD55J2hEX4mPfzqig1fGkE43pEN0gfB4COqOWRCaDjBY+LmyQYOWiQw4AvAMh4FwhF7BeoAIhM8ep8c1ZiFRTMU75x3D3UuBp0oqUSMBOK8+9SqafFypyILPZSkPVMPSHakN1EeWJ/iyIiHKb0Ov5bTeyamo08K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqB1wPAx; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a90b2b554so105216a12.1;
        Fri, 26 Jan 2024 00:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706256613; x=1706861413; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fjJDWMW4vwQS9Nf0tVgun4J7xTALICwka7Pe6pGqZc0=;
        b=fqB1wPAx7WMfX3GQsG4Fo+EUvxNLXJbe56h3zZ0SiuwEB7u5+c+sZh7zoAI6jCyFYI
         4m7msQSZ0X9GNdpmLCaGIOEP2SqOiIWfMDtTJDXKSnIWQGB7lSRbYiQq24H+81m+qvHs
         QQf3pOK+AovEr/nPaBPNLNpJuqbPOMv91G5HuTLa2yG9lJHgA93Cy9lAOeCBZgqGVGGg
         32NyD2JcnZ53nocRPhIDy6r0nPsWbKG5eDoH3PUjwplhyzYgwstXomPuoswInM7wDm1Y
         3cv1Xx/uESoes9WYDQTICanc7CnSK9ov4zuZ6bFk+UFbNnEdcQklSCRbI1fyp1N6m99Z
         ATYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706256613; x=1706861413;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjJDWMW4vwQS9Nf0tVgun4J7xTALICwka7Pe6pGqZc0=;
        b=ktZ6N5aqwAIeDItes25AOQF+q07kC0xYvoW/7RrqlvHR9uRRJbkQA84pOA+bUmvEZM
         2LXHxJ9a0Bc8nxSbrNReu//iDR8zJgRr2xcy3WGaorfeeZg5IcWB8jjDK7cSDYlp7npB
         4T/9UAErgFZvsDXGgDoS1n9xRFSShs69nTm4jM2aMepKQ/N/sO5kFwBfgOzVqTw6Hh6h
         MKnfbxlb+4QJOJ4Zx01My3Qvhty6/zSRQTpXJI6Qd1jiA50GNQLMSi+8ZKOTxiTWjYkx
         etyvAJG8fr4jsY7WcckGXJ1Ua9hgfugkOI/jmNMWZ/zuNTE2GfxqMn6twQrt0vGsCK8G
         KmaA==
X-Gm-Message-State: AOJu0YxYZLBg2SIBXlGIU+laaQLAxW6QFP6rBRoyHlEoEpwiQst3Ln9H
	7JaFZZNC2t1t5zsjWNTBXjavvaxCmUtdxxkYM5llRrji2b5yLNx1
X-Google-Smtp-Source: AGHT+IE7/Ghl6SBe8tXUbo7L1Oe16r2I0mIMU31XxXXSJaqzLd0JVmMphKORghdFkH2gvT8oo+a9Xg==
X-Received: by 2002:a17:906:390d:b0:a31:6942:eaae with SMTP id f13-20020a170906390d00b00a316942eaaemr915913eje.35.1706256612781;
        Fri, 26 Jan 2024 00:10:12 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709060e1a00b00a2bf375ceebsm347770eji.208.2024.01.26.00.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:10:12 -0800 (PST)
Message-ID: <865346908c9b76d72741e6f319a4535459de1ea6.camel@gmail.com>
Subject: Re: [PATCH v7 4/9] driver: core: allow modifying device_links flags
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Saravana Kannan <saravanak@google.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Fri, 26 Jan 2024 09:13:28 +0100
In-Reply-To: <CAGETcx_ScsW4gKpAK01dHYxB3XGs-pRjJQMygbZUNAdxV6BqtA@mail.gmail.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	 <20240123-iio-backend-v7-4-1bff236b8693@analog.com>
	 <CAGETcx8_0ExTG4ASb9xK-uwmubMFDx44_wUf1h3VsO8w9jJApQ@mail.gmail.com>
	 <8eae083af481441d83df02a1880e2aedf99efdfb.camel@gmail.com>
	 <CAGETcx_ScsW4gKpAK01dHYxB3XGs-pRjJQMygbZUNAdxV6BqtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-25 at 16:50 -0800, Saravana Kannan wrote:
> On Thu, Jan 25, 2024 at 12:11=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.=
com> wrote:
> >=20
> >=20
> > Hi Saravana,
> >=20
> > Thanks for your feedback,
> >=20
> > On Wed, 2024-01-24 at 19:21 -0800, Saravana Kannan wrote:
> > > On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Relay
> > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > >=20
> > > > From: Nuno Sa <nuno.sa@analog.com>
> > > >=20
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
> > >=20
> > > Curious, why do you want to set DL_FLAG_AUTOREMOVE_CONSUMER?
> > > Especially if fw_devlink already created the link? You are effectivel=
y
> > > trying to delete the link fw_devlink created if any of your devices
> > > unbind.
> > >=20
> >=20
> > Well, this is still useful in the modules case as the link will be rela=
xed
> > after
> > all devices are initialized and that will already clear AUTOPROBE_CONSU=
MER
> > AFAIU. But, more importantly, if I'm not missing anything, in [1],
> > fw_devlinks
> > will be dropped after the consumer + supplier are bound which means I
> > definitely
> > want to create a link between my consumer and supplier.
> >=20
> > FWIW, I was misunderstanding things since I thought
> > DL_FLAG_AUTOREMOVE_CONSUMER
> > was needed to make sure the consumer is unbound before the supplier. Bu=
t for
> > that I think I can even pass 0 in the flags as I only need the link to =
be
> > MANAGED. Still, I think having DL_FLAG_AUTOREMOVE_CONSUMER makes sense.
>=20
> As you noticed, your understanding of DL_FLAG_AUTOREMOVE_CONSUMER is
> not correct. There's almost never a good reason to drop a device link.
> Even when a device/driver are unbound, we still want future probe
> attempts to make use of the dependency info and block a device from
> probing if the supplier hasn't probed.
>=20

Yeah that makes sense and is making me thinking that I should change my cal=
l (in
patch 7 to use the MANAGED flag instead of AUTOREMOVE_CONSUMER). Sure,
AUTOREMOVE_CONSUMER won't matter most cases but if someone disables fw_devl=
inks
then it matters.

> If you don't want the links created by fw_devlink to be relaxed, I
> think you should instead set the kernel command line param so that the
> kernel doesn't time out and give up on enforcing dependencies.
> deferred_probe_timeout=3D-1

Good to know... Nope, I don't care much about them being relaxed as I will =
still
call device_link_add() when the consumer probes and finds the supplier. The=
 only
downside from relaxing is "loosing" AUTOPROBE_CONSUMER but that is not a bi=
g
deal.

>=20
> Then you don't have to worry about creating device links.
>=20
> > Also note that there are more places in the kernel with
> > DL_FLAG_AUTOREMOVE_CONSUMER and that flag is likely being ignored in ca=
se
> > the
> > link already exists.
> >=20
> > I'm also clearing DL_FLAG_AUTOPROBE_CONSUMER as from the first check in
> > device_link_add(() check I realize that we can't/shouldn't have it toge=
ther
> > with
> > one of AUTOREMOVE_CONSUMER | AUTOREMOVE_SUPPLIER, right? At this point,
> > AUTOPROBE_CONSUMER is also likely not that useful anymore as both suppl=
ier
> > and
> > consumer are up and I guess that's the typical case for subsystems/driv=
ers
> > to
> > call device_link_add().
> >=20
> > And since I have your attention, it would be nice if you could look in
> > another
> > sensible patch [2] that I've resended 3 times already. You're not in CC=
 but
> > I
> > see you've done quite some work in dev_links so... Completely unrelated=
 I
> > know
> > :)
>=20
> Regarding [2], I'll try.
>=20

Thanks! I think it's a valid bug with devlinks and overlays but it's sensib=
le
stuff (so the RFC) so it would be nice to have some review and recommendati=
ons
how to solve it... I would definitely like to have it fixed as I see more a=
nd
more people (ab)using overlays.

- Nuno S=C3=A1



