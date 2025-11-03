Return-Path: <linux-iio+bounces-25850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9983EC2C698
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 15:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29A9188E1CD
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 14:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3DA27F01E;
	Mon,  3 Nov 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huBbEIi8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4065327EC7C
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180225; cv=none; b=bOyj2FnUj/TPPx8Ob3tic+iqLPS7EY6cfvg6yqpswtCsbw3uViMJgs7c9u0rafTLDQlnVKYOsjrFhZWr2kmptkPBT93EhWF35vIt5/wR12oxMzwpVEIkSUmNeZ+5G2vh4s5y4AelF70zTrYdxgMguucu7RjEQiYBXb8QbA6G2a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180225; c=relaxed/simple;
	bh=d5SlSmgj+KYxoqS8LOdHefpz54HfTiu7PunihQHNVXo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hclF6VGw11lNSSZ1Bfdod4Bzf0V/gR86wR+zKh+0sZDjsMSSit14pilBpzMv7ShRmvZunfec+yZRFeB/ab77VVpDUVa50FOmKVPtRUZ1fA0cuYcISSK8PAxh01hV3ZlsHsGiZKqIHPC2ineNyHpfT1gLv0766cG0D8nfm6IFLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huBbEIi8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-421851bcb25so2496776f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 06:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762180222; x=1762785022; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d5SlSmgj+KYxoqS8LOdHefpz54HfTiu7PunihQHNVXo=;
        b=huBbEIi85H1qTWpWbfgCvVR32T2rJeZWvvVK2L4Crbm8FPC9MhRASv0ZMSEGxn5v7q
         UzhfEq2OryWn6EJqhovBCOEvOiruTEQOlZApucYCsxlQR4DTIdxvaw7fN7jTxxrJqPLc
         s7dNtUIRazzzedL0FMak6N/7z7pM/22s8EI86603D7P/3olP+mpx6xxVwVXCcHYjiiXE
         f0w6mSaBfLTYOerOYyGEeFNkd9NHZn5iZGcrWbpLaULhlTD1UQ6HOnF2ecPUFNnuccRq
         Z9g/okZEociQx8jWIVgzxWSNkDnrp9mIzAwgY97rtZu6feMdohM6pjYoU1E5iSpFMw+b
         v8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762180222; x=1762785022;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5SlSmgj+KYxoqS8LOdHefpz54HfTiu7PunihQHNVXo=;
        b=Jncq4gHUrOdGanR81BQXcORUW8s4r6N2wBfW4b6kZIiJeavF/jF6jnPUCeC87VMD08
         cQhBXXJon3vAIXYd4Z1GQJ4ezgxJ5E6ogdKuhD6WJTNhnJumneuJlVcHnWB8JXnHGVEh
         4fBcDgd/ypP5lTlSeR7VoxnhFLZRP+X/e9Xr3GSNsyzjWgmAYvL9NFtaChZ4DDqOizax
         VUpbZ+bbM2PIi9CSM1kaTwgifP/vCX+DLBOPz6zIebQOler274vnJKwtiOWomh/a8iWR
         2Gu0CzfeMAdm0c+Ud2ZDznpEjSv2jPk2gnf9nxFGCWT6JKm35tGOJNTfy4f9/1Jg6591
         NWYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsCi/9LS6Zbxy4zIljD8+zlWS9NNCs3e3AWmBeKbewRbusH3hrc7ZmeFYMci0v5IS4fFQGqoMVkBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53nbZRoeIL97HKMRiBViEzkIfE7y44QxN9EL61w7jNi7/Jnr3
	Kphiz/ImR0n8d5/NPvmvNCTLr67z5pY4C7XKjDjYX4q4qGQQB/0HRyfM
X-Gm-Gg: ASbGnctgaeyEA6dGB1P2oPhPMT+zw3p7//FON4R7BZTy6JgPXuVS8XDD5jUQWrzZtXb
	8yu8reX3szwgkwI7KCgb57kclL8JgaDij0K0jemDUGtuQq8kkh3RDjOJmTQzsHBXr92w2xs8oiF
	mjkGExZQm37IrGd2Sg75n/TnLyu7PxV2BAfaGNCE5qV+g25z+0RA+Q/6/icAGc3QhgYgls+PN25
	T5+QCveYyTNEDC+QaHIvFRpp/bLHvp0bJxJPhW0qNf8Arz+dG0/jqcSvxAeSyqYXGmBVL6+TKwi
	Prlrg9C49Z1sScf2Kxq6/TyqMtc1gwUAskGpatTL3BAIjC4Q2/tq4DDFp7CddsXZmrcdJHjpF56
	D++bBOPfblAXphB7A0Ay7CG6e7n0KML96GaXvcscSNC5KvfykXRKdUjubUgWCQ1DaE0I56knAPB
	IUi9XTJ9hA7nj+4ifhbik=
X-Google-Smtp-Source: AGHT+IEplJ4I66QnrFQ6IexEu0lm2qZpLG+9kBXJImu7awVRriBW7b1SWrjgxOO9Yk6R6iWrwFjEbQ==
X-Received: by 2002:a05:600c:4e05:b0:475:de14:db1f with SMTP id 5b1f17b1804b1-477308b4d29mr120402465e9.30.1762180221180;
        Mon, 03 Nov 2025 06:30:21 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c44de707sm19098975f8f.14.2025.11.03.06.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:30:20 -0800 (PST)
Message-ID: <1c3712b9b5313ed6c9d07c1acbc9b918a4883056.camel@gmail.com>
Subject: Re: [PATCH v6 8/8] iio: adc: ad4030: Support common-mode channels
 with SPI offloading
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Marcelo Schmitt	
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
 nuno.sa@analog.com, 	eblanc@baylibre.com, dlechner@baylibre.com,
 andy@kernel.org, robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org,
 corbet@lwn.net
Date: Mon, 03 Nov 2025 14:30:56 +0000
In-Reply-To: <aQisqe5EWARTwpQq@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1760984107.git.marcelo.schmitt@analog.com>
	 <3fadbf22973098c4be9e5f0edd8c22b8b9b18ca6.1760984107.git.marcelo.schmitt@analog.com>
	 <20251027140423.61d96e88@jic23-huawei>
	 <aQJY7XizVWbE68ll@debian-BULLSEYE-live-builder-AMD64>
	 <ca6760182b4662c96df6204bae903d8affa6a8e3.camel@gmail.com>
	 <aQisqe5EWARTwpQq@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-03 at 10:22 -0300, Marcelo Schmitt wrote:
> On 10/30, Nuno S=C3=A1 wrote:
> > On Wed, 2025-10-29 at 15:11 -0300, Marcelo Schmitt wrote:
> > > On 10/27, Jonathan Cameron wrote:
> > > > On Mon, 20 Oct 2025 16:15:39 -0300
> > > > Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> > > >=20
> > > > > AD4030 and similar devices can read common-mode voltage together =
with
> > > > > ADC sample data. When enabled, common-mode voltage data is provid=
ed in a
> > > > > separate IIO channel since it measures something other than the p=
rimary
> > > > > ADC input signal and requires separate scaling to convert to volt=
age
> > > > > units. The initial SPI offload support patch for AD4030 only prov=
ided
> > > > > differential channels. Now, extend the AD4030 driver to also prov=
ide
> > > > > common-mode IIO channels when setup with SPI offloading capabilit=
y.
> > > > >=20
> > > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > > ---
> > > > > New patch.
> > > > > I hope this works for ADCs with two channels. It's not clear if w=
orks as
> > > > > expected with current HDL and single-channel ADCs (like ADAQ4216)=
.
> > > > >=20
> > > > > The ad4630_fmc HDL project was designed for ADCs with two channel=
s and
> > > > > always streams two data channels to DMA (even when the ADC has on=
ly one
> > > > > physical channel). Though, if the ADC has only one physical chann=
el, the
> > > > > data that would come from the second ADC channel comes in as nois=
e and
> > > > > would have to be discarded. Because of that, when using single-ch=
annel
> > > > > ADCs, the ADC driver would need to use a special DMA buffer to fi=
lter out
> > > > > half of the data that reaches DMA memory. With that, the ADC samp=
le data
> > > > > could be delivered to user space without any noise being added to=
 the IIO
> > > > > buffer. I have implemented a prototype of such specialized buffer
> > > > > (industrialio-buffer-dmaengine-filtered), but it is awful and onl=
y worked
> > > > > with CONFIG_IIO_DMA_BUF_MMAP_LEGACY (only present in ADI Linux tr=
ee). Usual
> > > > > differential channel data is also affected by the extra 0xFFFFFFF=
F data
> > > > > pushed to DMA. Though, for the differential channel, it's easier =
to see it
> > > > > shall work for two-channel ADCs (the sine wave appears "filled" i=
n
> > > > > iio-oscilloscope).
> > > > >=20
> > > > > So, I sign this, but don't guarantee it to work.
> > > >=20
> > > > So what's the path to resolve this?=C2=A0 Waiting on HDL changes or=
 not support
> > > > those devices until we have a clean solution?
> > >=20
> > > Waiting for HDL to get updated I'd say.
> >=20
> > Agree. We kind of control the IP here so why should we do awful tricks =
in
> > SW right :)? At the very least I would expect hdl to be capable to disc=
ard the
> > data in HW.
> >=20
> > >=20
> > > >=20
> > > > Also, just to check, is this only an issue with the additional stuf=
f this
> > > > patch adds or do we have a problem with SPI offload in general (+ t=
his
> > > > IP) and those single channel devices?
> > >=20
> > > IMO, one solution would be to update the HDL project for AD4630 and s=
imilar ADCs
> > > to not send data from channel 2 to DMA memory when single-channel ADC=
s are
> > > connected. Another possibility would be to intercept and filter out t=
he extra
> > > data before pushing it to user space. My first attempt of doing that =
didn't
> > > work out with upstream kernel but I may revisit that.
> >=20
> > I'm also confused. Is this also an issue with the current series withou=
t common mode?
> >=20
> > If I'm getting things right, one channel ADCs pretty much do not work r=
ight now with
> > spi offload?
>=20
> Yes, that's correct. It kind of works for single-channel ADCs, but half o=
f the
> data we see in user space is valid and the other half is not. For two-cha=
nnel
> ADCs, everything should be fine.

To me that is something that does not work eheheh :). I mean, going with al=
l this trouble
to sample as fast as we can just so we have to discard (or mask out) half o=
f every sample
in userspace (even though I can imagine we still get better performance vs =
non offload case).

>=20
> >=20
> > If the above is correct I would just not support it for 1 channel ADCs.
>=20
> Currently, it's just one part that is single-channel (AD4030). If patches=
 6 and
> 7 were accepted, it would be 3 single-channel parts supported. I can add =
an `if`
> somewhere to check the number of channel, but it will eventually have to =
be
> removed when HDL gets fixed.

I would probably do the above or maybe we just need to push for an hdl fix =
or some
final conclusion (like if they cannot fix it for some reason) and act accor=
dingly.

>=20
> Or, if HDL can't be fixed, then we'll need the `if` now and something els=
e
> latter to filter out extra data before pushing to IIO buffers as mentione=
d
> above. Though, this scenario seems odd to me as I think the HDL wouldn't =
be 100%
> compatible with single-channel AD4030-like parts. We would be writing cod=
e to
> support AD4030 _and_ a peculiar data stream from this specific HDL projec=
t?
>=20
> My suggestion is to apply all patches except patch 8. IMHO, SPI offload
> single-channel ADC support is broken due to HDL IP data stream not being
> compatible with single-channel parts. That's not a Linux driver issue.

Well, it's not a SW issue but we are driving the HW and we know it's broken=
 so I
don't see a point in having something that does not work. Given that this i=
s so
connected to the HDL part of it I'm not sure it's fine to ignore that offlo=
ad does
not work for 1 channel parts.=20

Anyways, it's odd to me but ultimately if Jonathan is fine with it, I won't=
 object :)


- Nuno S=C3=A1

