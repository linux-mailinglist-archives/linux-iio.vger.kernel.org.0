Return-Path: <linux-iio+bounces-23933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FCDB5163A
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 13:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D2067B06D2
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 11:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B629331691A;
	Wed, 10 Sep 2025 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtZPA4Su"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECDC31282E
	for <linux-iio@vger.kernel.org>; Wed, 10 Sep 2025 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757505419; cv=none; b=E4+JD9fYuoGTglnbx36EPQ4GOH/ijrHj6Pgj2PsLQHexKIe7czSRE3sazLlMi5Td5O8YG+gRlRBTcVMC8aswH9o+N3XW+S8b6EfHrQLgXvEHeqYH588XjtOadU2Z728rHm2CZdnUe0IbOlJUBMU7SXPZXU6ZhU9s0g7qcj1Ecbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757505419; c=relaxed/simple;
	bh=rwmd+yOesNaJttzBwQ/tncIS2X68wtbHhq2Lqt3yxog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MRa0RCCqHLzGUfeMcz3fE4OyivLJgC5A1TKgnGCEnf/FxbbWLY/rdLe+UAZj2+ufFKkSMplgxagSoZ7b+l6fAdmy82iLLmvMlbLcz9/rB4tS63HusSUNSnVkn/fqP0vTGBLBkQYTelKRqvbhdsRysd5pqOMZjG1QK+JY5ptYApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtZPA4Su; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b0428b537e5so1077400166b.3
        for <linux-iio@vger.kernel.org>; Wed, 10 Sep 2025 04:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757505416; x=1758110216; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rwmd+yOesNaJttzBwQ/tncIS2X68wtbHhq2Lqt3yxog=;
        b=OtZPA4SuzXZljoX/PlOhz41ZXxaH2ZdQrlMZ/J4O2rkHR+BN5S+0Tsrpdm3yFZ7ibR
         cPS/p+oSg2ANgtPvtaX0eMwNJ/Mpyfq4Dx33vI4Fkrw4XWLD0U7dfpeTDJ68nl3t14qy
         WZ5r+C5bHOU1IpVTiU1LBNtKBvmOk8xI5DDJuJ6sWPLZ3mcSfg1tIMpWPd0eaTRhjtow
         T3xlqEEb1u1saPDcHMGUO4xnJ8IWJz9gS76N3jVRxL7FbZTmL6JPGVaFsaMBr8BoWQKB
         8nKGIUqdo4ofLi4OD5ufbgxbEOnzX6yPBuFzw0hwutRMn9prQGBd3LiDcKvTl4BttXmr
         Ui7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757505416; x=1758110216;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwmd+yOesNaJttzBwQ/tncIS2X68wtbHhq2Lqt3yxog=;
        b=DPSibeo7QXv00Isz5/cH2QY+p+3HZRKSPX+Z+f4HMLevdRoBMFJN2hpdYsjNzbC+ol
         01qFHmCSymJMaWPRz1tp4naa5pyUMV8blal+RcD8VV52g58KbVOoPvbq/jmQKsN1dJMZ
         xHGdq1BNbRKogbB4ljhrbg2Aq2mGt75Cefnj8DjUZHa+XL46ApRMxYdjpImnot9Qksi4
         qq1daBBOauIyYDw7qQMPR1VwRmP6reyEiThkCpgC4YazziwBbKDh9pPirLXGHNcoydUo
         rFV17lPrtaAWZQkYEINH8aZ7hYdJOsBPgBTdjEDLEN8TYtD2wjXv7zx6D1Vnn7WsNkUI
         3xFw==
X-Gm-Message-State: AOJu0YxeZUWQgeBVfeclkpGdN3bjX/SJlAx1AUh13OQjdlIOX1idddp8
	KCE5EbNFzVabMgykfl/eQM+vr4E+tjBd+x9srwC+umbQvHz4nrSpanks
X-Gm-Gg: ASbGncvQbUM9LsZaTYUHrkulZ54IDoHi4WPpSHoSzy33uqAbFxc8MaRBur6yQ8L8hdh
	OleICE2bQ1vGE3I52SIjscGA150UIDKvSmP+4lcvFKyIZsLR36hVjhB/Yro+pSBRcRDDQOhATZR
	6Cz9q5fA1kmJlgspezYYRoPzJM9ZIn30BOeTj5skRThWAeSMqVMluwEJxT4t3WEf6d2G6R67GZu
	oExG0Um7DQj1xMI5K717Auh5SMMJEn8ncEko4ugjW4rEy4HvshhDleAr/lt082gJ6d9gK4qyv3W
	B+ZDMO5BpHC+udGTebNnrL9RqaCy83U8tGzpVrQWoUTWc946dx+IOU6SHTFlqIr/S9g2l7c0ppO
	1PY1SwgAN8G8lCLWYNDB6wMHLzhiUiF+lKw==
X-Google-Smtp-Source: AGHT+IFevW192YPpg/XYKYA36xKU1TZLsFk4r+NKReSUoLtOsWPnb5Mzh+docL7fNnDCJYkvTB0c6g==
X-Received: by 2002:a17:907:7f8c:b0:b04:76b5:739f with SMTP id a640c23a62f3a-b04b140d29fmr1522596666b.23.1757505415653;
        Wed, 10 Sep 2025 04:56:55 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.234])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078304516fsm159940266b.4.2025.09.10.04.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:56:55 -0700 (PDT)
Message-ID: <5c82294b3a672225542926dee9f5fd18716383c4.camel@gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, David Lechner	
 <dlechner@baylibre.com>, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, 	robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com, 
	ghennadi.procopciuc@oss.nxp.com
Date: Wed, 10 Sep 2025 12:57:19 +0100
In-Reply-To: <222acc86-c405-4e05-ac8c-520ba81ef0a0@linaro.org>
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
	 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
	 <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
	 <0bfce1eb-69f1-4dae-b461-234eb98ffce1@linaro.org>
	 <a3373804-08a4-4526-a432-c21a74ea3d6b@baylibre.com>
	 <edc8e024-e425-49de-bfa2-44218fe72e26@linaro.org>
	 <6b8cd005-b04c-4dd7-abf7-5a51319a5f0a@baylibre.com>
	 <23b80d52-6149-483b-a159-276dd00d12cd@linaro.org>
	 <e5e76789-c8d9-463c-aa01-f2c6ae718f74@baylibre.com>
	 <fd4c81a5-3b99-448c-92d4-9465f0e76db3@linaro.org>
	 <c23ed0cf-8188-49ac-b310-57bbfb54f337@baylibre.com>
	 <c30bb4b6328d15a9c213c0fa64b909035dc7bf40.camel@gmail.com>
	 <222acc86-c405-4e05-ac8c-520ba81ef0a0@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-09 at 18:22 +0200, Daniel Lezcano wrote:
> On 09/09/2025 11:29, Nuno S=C3=A1 wrote:
> > Hi *Daniel* (sorry for that :)),
> >=20
> > On Mon, 2025-09-08 at 08:58 -0500, David Lechner wrote:
> > > On 9/8/25 7:16 AM, Daniel Lezcano wrote:
> > > > On 05/09/2025 23:54, David Lechner wrote:
> > > > > On 9/5/25 3:58 PM, Daniel Lezcano wrote:
> > > > > > On 05/09/2025 17:25, David Lechner wrote:
> > > > > > > On 9/5/25 4:44 AM, Daniel Lezcano wrote:
> > > > > > > > On 04/09/2025 19:49, David Lechner wrote:
> > > > > > > > > On 9/4/25 12:40 PM, Daniel Lezcano wrote:
> > > > > >=20
> > > > > > [ ... ]
>=20
> [ ... ]
>=20
> > > Unfortunately, not really. Until the last few years, there wasn't rea=
lly
> > > any users of these APIs. I added
> > > devm_iio_dmaengine_buffer_setup_with_handle()
> > > for the SPI offloading work I did recently. The only reason it had to=
 be
> > > added is because we needed to get the DMA handle from a different
> > > devicetree
> > > node from the ADC's node. Since this device has dmas and dma-names in
> > > the devicetree, then if devm_iio_dmaengine_buffer_setup[_ext]() doesn=
't
> > > work
> > > with that, then it might have other problems (assumptions made for a
> > > specific
> > > use case) than just not calling dma_slave_config().
> > >=20
> > > I think maybe Nuno and certainly I are guilty of trying to offer you
> > > advice
> > > without looking deeply enough into what you already submitted. :-/
> > >=20
> >=20
> > Yes, I pretty much just asked for (at least) some discussion about this=
 and
> > see
> > if we could use what we already have in IIO.
> >=20
> > > I see now that what you are doing with the DMA looks more like other =
SoC
> > > ADCs
> > > (AT91/STM32/AM335x) which is quite different from how the
> > > iio_dmaengine_buffer
> > > stuff works, e.g. cyclic vs. not. So unless you are interested in evo=
lving
> >=20
> > Supporting cyclic should be fairly easy (Paul left it almost prepared f=
or
> > it)
> > and do I have some patches already. I'm just waiting on having somethin=
g
> > accepted on the ADI DMA IP driver (dmaengine) before sending the IIO pa=
tches
> > I
> > already have.
> >=20
> > > the iio_dmaengine_buffer code to be more general to handle this case =
as
> > > well,
> > > it might not be the right tool for the job currently.
> >=20
> > I think for the STM (IIRC) case they "open" coded it because the IIO DM=
A
> > support
> > we had at the time (if any) was more "rudimentary" - (no real zero copy
> > interface with userspace for example). But yeah, it seems there are som=
e
> > gaps
> > for your usecase so as David said, you would need to be interested in
> > evolving
> > the IIO DMA API to accommodate your needs. Again, if nicely integrated =
you
> > would
> > gain some nice "improvements" in performance (not having to use the fil=
eio
> > interface for reading the buffers) for "free".
> >=20
> > As for dma_slave_config(), you're right and we have no usecase needing =
that
> > setup and TBH, I did not looked or have any idea (atm) on how to do it.=
 That
> > said, I'll be here to help and contribute if you decide to try and foll=
ow
> > the
> > IIO DMA buffer API.
>=20
> I would be glad to help improving the IIO DMA but I don't have enough=20
> bandwidth ATM. I was hoping to get this driver merged for v6.18 which is=
=20
> the next LTS AFAICT. Is it something possible by taking into account all=
=20
> the comments without improving the DMA code ?
>=20

No personal problem with that. But ultimately that is up to Jonathan :)

> Do you have a pointer to Paul's series and the patches you mentioned=20
> above ? I can give a try when having some spare time
>=20
>=20

Here is the DMABUF work from Paul [1]. But I do not think this is of much u=
se
for you (as an in kernel consumer) but it is still interesting :).

My own patches are in here [2] but you have out of tree "noise" in there [2=
]. At
ADI tree we had some legacy "high speed" implementation that we're still
supporting (eventually it will go away and we will sync completely with the
upstream solution). I was hopping for this [3] to land first before sending=
 the
IIO bits but I'm having some issues with lack of bandwidth (I guess) from t=
he
DMA maintainer. They are not really dependent on each other so I might send=
 the
IIO stuff soon enough.

One last comment about dma_slave_config(). That should be easy to go around=
 with
devm_iio_dmaengine_buffer_setup_with_handle(). I mean, we canl do all the D=
MA
chan request in the consumer driver (which would allow to easily call
dma_slave_config() when needed) and pass the DMA handle to IIO with the API
David introduced. In the future, given enough users, we could introduce an
helper in the IIO code and it would be easy to "convert" the driver. Now, i=
f you
do need to do something special in the DMA termination callback, we would
definitely need to add the mechanism for that. In the ADI tree we do have a=
 way
for a custom DMA submit operation [4] but we never had a proper upstreamabl=
e
user for it :(

Anyways, just some thoughts if you or someone else ever have the time for t=
his
:)


[1]: https://lore.kernel.org/linux-iio/20240620122726.41232-1-paul@crapouil=
lou.net/
[2]: https://github.com/analogdevicesinc/linux/commit/a1f64e5e7927d1d96da08=
245cce35ba9e08a5f52
[3]: https://lore.kernel.org/dmaengine/20250811-dev-axi-dmac-fixes-v1-0-8d9=
895f6003f@analog.com/
[4]: https://github.com/analogdevicesinc/linux/blob/main/drivers/iio/buffer=
/industrialio-buffer-dma.c#L1214

- Nuno S=C3=A1

