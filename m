Return-Path: <linux-iio+bounces-25192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B4BBE89AE
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 14:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2643C620B5D
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 12:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9172E5B2A;
	Fri, 17 Oct 2025 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcDifW+C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB05D19DF66
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760704549; cv=none; b=Vv41CL3t5hnXyIH2+tbnkOxpsJCiop+fwJMt3SQ+T6MKu9aWQgSmFdhqpRtluFoRUTWIMsAVrW1zeQPWLGf6Qoj+QL2v+FTUju/YcPIV8f43N8iPohavvshtTCXfnlE7f23pF1Kxoc5H+nKMEmWhTrvlPqQL5Zv9ft8CUOXqEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760704549; c=relaxed/simple;
	bh=5ScMlkpNB3bO9rP0r5PtsUCVGh6+veBjgyd9l3hbzUk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tJJ6waxdxer2vmV5ir2W4BMBMcFHm+JfDrAniwvpe55n5g/EPJvpCZlLlnwOFHvSF543JuHaffqyHCKzGHlTTtjNIBMrXQ1IvVv1oQ8nepJlbwGqTZzcDTd/MKNdleg408mg3FOl7Br5fEnJ120mUkKEdUJHEDcDS+CfUk9MnT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcDifW+C; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f0308469a4so1254448f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 05:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760704546; x=1761309346; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z3ErgCZMqEpbnKuL5giuJkbnaVmFhSFBsDzPMv4Y24k=;
        b=KcDifW+C4xv4mVIbrV2VtgtdfylQyjozqrobE9GfVnihZAbmhUDcXtKg5fndcIq6Zy
         4MIm5biZyDAk38IwnkdmOOwaDYXmIinVU5Zxfe6CVDHA3Vhb7z8aKsJqXg0XtdNmsHvl
         FkqFC535a0eEZM2LBpJxBCry/Yw3Rs4zksBsDiUmca+a0WypGb1J7TtL59sWYIPYuSKf
         FcQ7077+KdH2A9mTa+YWD+s7WWSUxBX8+SVWGtAokb5nA2ufuHyxT1YCz9pXkUrHw7Pj
         MyMxlO28rfdEzo/4zsFRwvFoBGLBCrRY4o0GbDt8zUHrsE/PM0J72n6BLsev23YW9tjW
         ISVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760704546; x=1761309346;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z3ErgCZMqEpbnKuL5giuJkbnaVmFhSFBsDzPMv4Y24k=;
        b=pTm6nrFzIesfk7CM8/kteRQWJZr6rcQVwnzbNss5MAS5zUiHjzrqCygnhQW+mPqn7G
         or8j4ICPsub+pCKdd00kc6IqeZTlihTobwlz6mZOSadr5NlPSlq88VnGnztQPLPc9On5
         wT2OWGIN8HXLHvrQ7EZyEb78D0UX7vUTLFIfDStrvmxDVDjUALS9gTjrusR7v7CMQ608
         a3Sh7f2X8SEM/XmP75l6gr48YjHVGKXn0GPdkVANpBdX+NvNFZU1MO5YR9paff9Vq0VF
         jNl07K0QeB5OdpDbForZ2jsdY+0fG+/jVW1CcJNQO5ossyexkMYbdZ9M3eaACkvvmit0
         R8dg==
X-Forwarded-Encrypted: i=1; AJvYcCVY4ysHD6YJvVmKNJTYzgi/v21JwRVWfrWjZhLgae+sfTlY16P1ESz16ec0WkCisHI1gpLbqU22wLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHn4Bs5v56UR0dAAIYil1vXaJQixt7AfjzUmijAGeZX8HAjad
	aAlKtVZUauTTVFvtOLdu09hhKfUQ03bsPsrlkDEHPs0v0OT5K4Uk3oi+
X-Gm-Gg: ASbGncs7iSeHdBfE4VXBMpht83O4VBmPyP6V6n+KkpQMBf7tcW+9BFXb9gHIKskWJEV
	91hbGjiK+LtWA68ZNXeBOzC9z6z49lidWmEcJSEysBouWrtDb6o4UJ20f4cM02FNomUBMUQ2FdM
	6lEQF+xzJlM3jRmM1EoGW77NV3WUxQ0I00+ESUfiWuJdMCgVnnSq8VVHMY7vYgjNTjScdB7ZLtg
	hW13neqO167RZFdNUhhz0jnPBpvQszF91sjVLnBGOUmvLqLyv7XS0qTrMy/RJVtjzknn1OKCXCa
	JL6xG/S/hqwuag52s+mLoA1xvMGc1IqU2x/VbrfTlpXX6Jn9ZnbOUsklvMpbRJI7PZX7AIk5bsA
	M6/4DBC2p8VaR7sHuR4E1ChgbahIHtksDQZTCHx/qWMtafcQFjNDE2wDM1yQaVsGOTd8huOMAJ1
	x91M0UPuNX4cVELg==
X-Google-Smtp-Source: AGHT+IGtc3rElmlZjUCj5LU626fWOPul39pomQ3PRsSjDGqzZiz5b3XHgZGsVeR0STAL9AUxbbUF5w==
X-Received: by 2002:a05:6000:2008:b0:3df:c5e3:55fe with SMTP id ffacd0b85a97d-42704d9895amr2580238f8f.29.1760704546153;
        Fri, 17 Oct 2025 05:35:46 -0700 (PDT)
Received: from [10.5.0.2] ([195.158.248.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm39639352f8f.35.2025.10.17.05.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 05:35:45 -0700 (PDT)
Message-ID: <ccd58e8103e912d0609fbc625f19ec18e605ad4a.camel@gmail.com>
Subject: Re: [PATCH 3/6] spi: add multi_bus_mode field to struct spi_transfer
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Michael Hennerich	
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Jonathan Cameron	 <jic23@kernel.org>, Andy
 Shevchenko <andy@kernel.org>, Sean Anderson	 <sean.anderson@linux.dev>,
 linux-spi@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-iio@vger.kernel.org
Date: Fri, 17 Oct 2025 13:36:18 +0100
In-Reply-To: <66f94eb6-15a9-457f-a7b8-47710652a34b@baylibre.com>
References: 
	<20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
	 <20251014-spi-add-multi-bus-support-v1-3-2098c12d6f5f@baylibre.com>
	 <9269eadc1ea593e5bc8f5cad8061b48220f4d2b2.camel@gmail.com>
	 <409ad505-8846-443e-8d71-baca3c9aef21@sirena.org.uk>
	 <12db0930458ceb596010655736b0a67a0ad0ae53.camel@gmail.com>
	 <8c7bf62a-c5dc-4e4d-8059-8abea15ba94e@sirena.org.uk>
	 <d9455d90-31ca-4be7-b17c-2b339e92f8a0@baylibre.com>
	 <9024f05854dcc3cc59345c0a3de900f57c4730d9.camel@gmail.com>
	 <ad929fe5-be03-4628-b95a-5c3523bae0c8@baylibre.com>
	 <c4b5a42f5f1d3f577cb986946b642b4edc1300e9.camel@gmail.com>
	 <66f94eb6-15a9-457f-a7b8-47710652a34b@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-16 at 10:25 -0500, David Lechner wrote:
> On 10/16/25 4:08 AM, Nuno S=C3=A1 wrote:
> > On Wed, 2025-10-15 at 13:38 -0500, David Lechner wrote:
> > > On 10/15/25 11:43 AM, Nuno S=C3=A1 wrote:
> > > > On Wed, 2025-10-15 at 11:15 -0500, David Lechner wrote:
> > > > > On 10/15/25 10:18 AM, Mark Brown wrote:
> > > > > > On Wed, Oct 15, 2025 at 03:43:09PM +0100, Nuno S=C3=A1 wrote:
> > > > > > > On Wed, 2025-10-15 at 13:01 +0100, Mark Brown wrote:
> > > > > > > > On Wed, Oct 15, 2025 at 11:16:01AM +0100, Nuno S=C3=A1 wrot=
e:
> > > > > > > > > On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:
>=20
> ...
>=20
> > >=20
> > > The AXI SPI Engine doesn't know how to do the quad SPI part yet thoug=
h, so
> > > it isn't something we could implement right now.
> > >=20
> > > If we tried to do it with spi-buses =3D <8>; then we would end up wit=
h the
> > > "interleaved" bits (or nibbles depending on the wiring) that requires=
 the
> > > extra IP block to sort out when using SPI offloading. Technically, we
> > > could
> >=20
> > I think that extra block already exists today. I was thinking the idea =
was
> > just:
> >=20
> > // the case where we just have one channel with eg: 32 bits words (eg: =
test
> > patterns)=20
> > struct spi_transfer example =3D {
> > 	rx_buf =3D rx_buf;
> > 	len =3D 1; /* 1 32bit words */
>=20
> This would still need to be len =3D 4; since there are 4 bytes in a
> 32-bit word. (If this was tx with SPI_MULTI_BUS_MODE_MIRROR, then
> len =3D 1 would be correct, but for striping, it is still the length
> of all data combined).

Right, I was still thinking in the old stuff where the spi engine would alw=
ays
have len =3D 1 (which is nok)

>=20
> > 	/* 4 lanes which is actually quadspi */
> > 	multi_bus_mode =3D SPI_MULTI_BUS_MODE_STRIPE;=20
> > };
>=20
> This will work with the caveat that for non-offload case, the software=
=20
> will need to rearrange the bits in rx_buf into the correct order after
> the spi_sync().
>=20
> For example, u8 *rx_buf will contain bits of the 32-bit word in the
> following order:
>=20
> rx_buf[0] =3D b28 b24 b20 b16 b12 b8 b4 b0
> rx_buf[1] =3D b29 b25 b21 b17 b13 b9 b5 b1
> rx_buf[2] =3D b30 b26 b22 b18 b14 b10 b6 b2
> rx_buf[3] =3D b31 b27 b23 b19 b15 b11 b7 b3
>=20
> The correct order of course would be (assuming little endian):
>=20
>=20
> rx_buf[0] =3D b7 b6 b5 b4 b3 b2 b1 b0

I know, that's what the ad4030 driver has to do.


- Nuno S=C3=A1

