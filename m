Return-Path: <linux-iio+bounces-779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A5F80B4EB
	for <lists+linux-iio@lfdr.de>; Sat,  9 Dec 2023 15:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A1C1C20ABC
	for <lists+linux-iio@lfdr.de>; Sat,  9 Dec 2023 14:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7086A1429E;
	Sat,  9 Dec 2023 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTfa4QQJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFE2C8;
	Sat,  9 Dec 2023 06:32:36 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a00cbb83c80so342735166b.0;
        Sat, 09 Dec 2023 06:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702132355; x=1702737155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tn56YAkZLJizqLqOMNcwZRSFjwaUXGsfOCpgirYnJSc=;
        b=FTfa4QQJ0TUZYnWjH5l4LoVTXo1gETLyMOJkYyeh0Y/zjBBpvIy+nIuAq1e3avFhSl
         gtosBl/RxGuaxQ1AeME39p9KLfoln04NmrjaxZT2oiJweNKfEnyhG9L/0COKU3pmoZru
         /pNyGsBCdR8F+UeVwtuHTUVs/mUXv2E5CG7rKAocTkV0dPWBz9s/DsdugfksEUWxK0N4
         AWHdLYkyqnlIWmAdQzffm0F1tPiDF5fSQhHs/95kTViCH8pGKgG0c6bg564Cx6e27IUG
         qxCERO/kt1fWQ7/w0Jp1g6PREmGGSnycKTQMcTfgmxRBYRLo5lyid4LaPFGKmDLkJFY7
         DAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702132355; x=1702737155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tn56YAkZLJizqLqOMNcwZRSFjwaUXGsfOCpgirYnJSc=;
        b=eJ081VCpW8dytITjw4G9oie3Xo4JcqprAGCF5DYtYj6bvCIdduXWGYii/wpb83yftf
         1Iohocf/eq6zJ56/lNHYjVMVt3XvKNaKKT1HilpsYfh39/7kwJfr1Swhd2159h+i0Gq2
         6G9bi1uPFJDaZHeyHTShx8nLdvVBgdLc117zDdOxdTf54b+F3fvCIiVX/86U2rDcNFJ3
         E0MMBjJZoyUG6NIC/ETuZuTKG3yIZB4SErVU2+lCXRfpoqpvmY8LJgFblPdZwkGEFPU3
         maGjR8BheupsXnWW+GE35nkDSZ10gHXEVUrFJWrJqcRSIZp5wCUB3YQfD+9UGCSlk8SZ
         ZvJQ==
X-Gm-Message-State: AOJu0YxUxigxV2Om00oA2iIDnzAt12f/plyAN8ALbYZVkvy0xlViVNJ5
	A2iZbDkpHLsDUEjarssSL74=
X-Google-Smtp-Source: AGHT+IG7KTdMaeaqpR21pCK4zEQBBO6GJidkEHjWh5kTYvm+NSVZGdqJ95KvH33yv6ngjGtNO5a8CQ==
X-Received: by 2002:a17:906:20d8:b0:a19:a19a:ea97 with SMTP id c24-20020a17090620d800b00a19a19aea97mr870037ejc.80.1702132354458;
        Sat, 09 Dec 2023 06:32:34 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090699d000b00a1e27e584c7sm2282429ejn.69.2023.12.09.06.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 06:32:34 -0800 (PST)
Message-ID: <a59232317228f2d459a9c3fba63596daec988520.camel@gmail.com>
Subject: Re: [PATCH v2 0/8] iio: add new backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Conor Dooley <conor@kernel.org>, nuno.sa@analog.com
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Date: Sat, 09 Dec 2023 15:32:33 +0100
In-Reply-To: <20231208-corridor-outfit-ae0314b29186@spud>
References: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
	 <20231208-corridor-outfit-ae0314b29186@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-08 at 15:30 +0000, Conor Dooley wrote:
> On Fri, Dec 08, 2023 at 04:14:07PM +0100, Nuno Sa via B4 Relay wrote:
> > This series depends on [1] and it only build on top of it. The point is
> > to already speed up the reviewing of the framework. That obviously mean=
s
> > that all those pacthes were dropped in v2.
> >=20
> > v1:
> > =C2=A0
> > https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/=
T/#m222f517
> > 5273b81dbfe40b7f0daffcdc67d6cb8ff
> >=20
> > Changes in v2:
> > =C2=A0- Patch 1-2 and 5
> > =C2=A0=C2=A0 * new patches.
> > =C2=A0- Patch 6:
> > =C2=A0=C2=A0 * Fixed some docs failures;
> > =C2=A0=C2=A0 * Fixed a legacy 'conv' name in one of the function parame=
ters;
> > =C2=A0=C2=A0 * Added .request_buffer() and .free_buffer() ops;
> > =C2=A0=C2=A0 * Refactored the helper macros;
> > =C2=A0=C2=A0 * Added Olivier as Reviewer.
> > =C2=A0- Patch 7:
> > =C2=A0=C2=A0 * Use new devm_iio_backend_request_buffer().
> > =C2=A0- Patch 8:
> > =C2=A0=C2=A0 * Implement new .request_buffer() and .free_buffer() ops;
> >=20
> > Also would like to mention that in v2 I'm experimenting in having the
> > DMA on the backend device (as discussed with David in v1). Does not loo=
k
> > to bad but as I said before, I'm not seeing a big issue if we end up
> > having the buffer allocation in the frontend.
> >=20
> > For the bindings folks:
> >=20
> > I'm introducing a new io-backends property in the ad9467 bindings but I=
'm
> > not sure this is the way to do it. Ideally that new property become a
> > generic schema and I'm guessing I should send a PULL to?
> >=20
> > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/=
iio/iio-consumer.yaml
>=20
> That seems like the right thing to do to me, depending on how widespread
> the use of these backends might be. What is seemingly missing though,
> from this cover and from the bindings patch in the series in particular,
> is an explanation of what the "iio-backends" hardware actually is.
>=20

Yeah, sorry about the bindings patch but I was already with the feeling tha=
t a PR in
devicetree-org to be the right place. I'll be adding more drivers needing t=
hat
property and STM also wants make use this.

I'll improve on the explanation and send a PR for a generic schema.

> There is some text below, but it does not seem complete to me. Is the
> idea that this "backend" is shared between multiple frontend consumers?
> The one example is described as being "highly focused on ADI usecases"
>=20

For now it cannot really be shared. The code is not prepared for it (we wou=
ld need to
keep enable/disable counters etc...). For now, I'm just adding the simpler =
cases of
1:1 and 1:n (1 frontend for multiple backends). Internally we do have 1:n d=
esigns
that I definitely want (in time) to bring upstream.

That said, having a usecase for it in the future, it is something that can =
be added,
yes...

Thanks for the feedback!
- Nuno S=C3=A1
>=20


