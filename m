Return-Path: <linux-iio+bounces-27850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A62DAD31E74
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 14:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A51E30EB0BA
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C57281368;
	Fri, 16 Jan 2026 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI0eeAE2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76927283FCE
	for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768570260; cv=none; b=UgF+INGN/mpHvPX5VPRYC41lrih1f+lZt2Z/E0a69vep9rRR0mjty03CZQuXciER1ZON/sZ+taGq2lGnX/M5IM5hBeXVx187EMr9PLVnmyWkAmOCBTccd9tziZBlmpHhgP2+wQBv6Snp3zTIE4Co5TzjK4V7iVMPV9Jn3Zdc8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768570260; c=relaxed/simple;
	bh=Wr+L2zSKge+HUINYV3ElAKBUZ5nbNXnnN0RicZ/LmsM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=avi7Uetyrs4ZPvxHJ+v6I2x2vGf7/j8t31X7eSOUIV8DRsc7hhX502vEn7CtUw8KsDrcnyfT35SFvM45lvuhx16jLR/kDNeovwoP2ypGYag50Y1tvQhUXXuEIJndGklr4PKFRIzQHBnlmm+8S9GSUfCOCTFrSnDfdZouIDG+emc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QI0eeAE2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-432d2670932so1670452f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 05:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768570257; x=1769175057; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wr+L2zSKge+HUINYV3ElAKBUZ5nbNXnnN0RicZ/LmsM=;
        b=QI0eeAE2jEbsSIJowRsgLEROcmkLGQ2v+3uw/8EWZqd9ep+bMRseem9Ny6mjGJs63w
         lsJEF+ySuMjWWgaylSon34NzcBTOA7pfR17bMDwzMGOn2+HfHxUmv73bOPs1KyKDSS6x
         +6xzrL4ftpIzgTejXk5oKcV1RUndXyIQ/31DZtdfhRcTHINMtycCtl3Fl+mePUlHzaWc
         XVAb4Vx/H86cpJswJ+8tznHQxn5mXSv/pRfvb+s0b0mcvwOWAAG3RO0Ie7jYWw1wvoYi
         eQPF6GGEZXe7+Dt4YjtLhRhaTKQwjW8N7CGoG7Fio22oFY90l712HXPrESR9rD7ERvNU
         Qx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768570257; x=1769175057;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr+L2zSKge+HUINYV3ElAKBUZ5nbNXnnN0RicZ/LmsM=;
        b=Q8kW0PCG9mECVjg51MMD3pIKRJ3Ze5NmiXkV/zKbjBNXzIiraRHYD6VcnmAA60iSXx
         6Y7xgqTDorEjx9PG/DGjmZFsAlFD3O3D1vikRbaNYfaZURtAwyEwW3qfOjZgz4mTE598
         7MViI1i/j27/RodE1aXa+3sFEp9/qlSGla6yzF7Rf2x7TZ8PJS+XQ2fHnpQ1iCYtsas5
         uvBrQvNH8JD2WqMLAjacrvG5lfHXSZo3DqwvjOQpxzoAitRMod6VleZgUI5+j7usn94N
         juONi1H6WKCkDUEKKc3QzVvJDeikXFF8mKcltRbbDV08y5MM+4naiBLFswC9pQBLs3VP
         ya1A==
X-Gm-Message-State: AOJu0Yw3U/FsMVwZZK8VUq91cY/tXjnkwIJ78ZbgXo2SdXZ+7qyU5PAL
	pxrhG317kiVxVD1+Fb5kid83dD2FdVYkQVr7MhPcSOxeKF8Pc11w/2b3
X-Gm-Gg: AY/fxX6lSWbhgPe472Mj8CjAoMC4qENP6mbFUYLvmH5HaWFjOqVNUXNUXWUp/q1RWsV
	5TBynTmKQMov8DMUfjGyHgc2kF5v4w3pydx3EA3YePuwn79j83BGxvMJFlZq4XjzHCGw7ErrsXj
	thY88fONHWfpfJ7JaW+nCfquvX1nhNqb67Iih/r78xu7oKzTtODjEW1NVlVx9jhlsavyULvIVlm
	XoTMMBahgPHQqhV4vVxlm7lZaiurzvqGJ6ldg9gqcayrG/5mVm/0cNJPNa1kQHMfivrZtbFnyLL
	yw6QDIn7u3dEiRJZBmh8ENSziCXWlDC9zUNuUWZQpmF14X+4fJ+veEbiJe3EqYgxsOwcumBwbh9
	kOfM0zuKP1ER9PuE8Ri3S0Lo0aiECZgIl6QJmcrCOXA1725NEw4U2n/p2Ly3NoDjoKJ55A8Im+t
	ZjEGgZZP3U3Ik939JhfPM=
X-Received: by 2002:a05:6000:240e:b0:433:1d30:461 with SMTP id ffacd0b85a97d-43569bc4837mr3480939f8f.32.1768570256414;
        Fri, 16 Jan 2026 05:30:56 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569997f41sm5025335f8f.38.2026.01.16.05.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 05:30:56 -0800 (PST)
Message-ID: <931160a27cfcfbf55d75bf9662442988c266343f.camel@gmail.com>
Subject: Re: [PATCH v3 0/4] iio: adc: ad9467: Support alternative backends
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 16 Jan 2026 13:31:39 +0000
In-Reply-To: <41cac06c-8db2-4a52-854f-659606d89121@vaisala.com>
References: 
	<20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
	 <0ad12e16e3fffb4b72a460d7f2b2e627a781b93b.camel@gmail.com>
	 <7ac7033a-2273-4556-a605-1ea0200665a9@vaisala.com>
	 <5896ab55e0d23d235908f9f592c8a7975428dc54.camel@gmail.com>
	 <41cac06c-8db2-4a52-854f-659606d89121@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-01-15 at 15:30 +0200, Tomas Melin wrote:
> Hi,
>=20
> On 15/01/2026 14:04, Nuno S=C3=A1 wrote:
> > On Wed, 2026-01-14 at 17:32 +0200, Tomas Melin wrote:
> > > Hi Nuno,
> > >=20
> > > On 14/01/2026 15:32, Nuno S=C3=A1 wrote:
>=20
> > > >=20
> > > > But more importantly, how are your usecase supposed to work with th=
is
> > > > series? I'm not seeing any new backend being added as part of the s=
eries.
> > > > Point is, if we are adding all of this, I would expect your usecase=
 to
> > > > have fully upstream support. If I'm not missing nothing, we would a=
t least
> > > > need a dummy backend providing stubs for enable()/disable()
> > > My usecase adds simplistic backend support and registers to the
> > > framework via an related driver. So that use case works with that
> > > approach. I think it is better to assume there is always some entity
> > > that can take on the role of being backend, rather than adding a dumm=
y
> > > backend. Adding the capabilities are defining role here, as having th=
at
> >=20
> > Well, I would argue your backend is exactly that. A dummy one :)
>=20
> It's kindof ;)=C2=A0 But on general level it handles the stuff a backend
> needs to do, just does not have most of the operations or capabilities
> available. OTOH having the backend defined means that if some of the
> capabilites would be added, there is a natural place to add it.
>=20

But there's nothing you can control from Linux right?

> >=20
> > > allows for customer integrations with backends that differ but are of=
 no
> > > interest for the mainline.
> > >=20
> >=20
> > It would still be nice to have this usecase fully supported upstream=C2=
=A0
> > (having a black box backend).=C2=A0
> >=20
> > What I have in mind would be really to do the same as regulators do. If=
 you call
> > regulator_get() then the consumer really assumes a regulator must exist=
. But if it
> > is something the kernel does not control we get a dummy one with very l=
imited
> > functionality/stubs. If you call regulator_get_optional(), then the reg=
ulator is
> > really optional and might not physically exist. Seems very similar to w=
hat you have.
>=20
> There could perhaps be use for a backend like this too. Is the idea such
> that one would still need to define a "iio-backend-simple" node or such
> to device tree which would then provide the backend link and compatible?
>=20

My idea would be to automatically define one if we fail to find it. Natural=
ly if we
ever add an optional() get the dummy could not be added. See how regulator_=
get()
handles it. That's basically what I have in mind.

- Nuno S=C3=A1

