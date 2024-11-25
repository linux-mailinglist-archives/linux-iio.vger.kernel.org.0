Return-Path: <linux-iio+bounces-12631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4BB9D8470
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 12:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750ED161DE0
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 11:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76641199947;
	Mon, 25 Nov 2024 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vi5yMCPp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9D199924
	for <linux-iio@vger.kernel.org>; Mon, 25 Nov 2024 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534042; cv=none; b=V54lYuFplws+Tzk8dAlk3iDGpvPaSr26AyfOuX9yi4KzUOs0jzyjIMoW2z+hUPjI+lkoOFxtcGyE3L8yp9Tpm2k7htiNjRBIC2GKc2yvDJ6gGP0QGEqlCjGuNbB3zUs/thbw8TjhEK0DgOxZ39xhhO28lGzaUSn368xI8VHiAsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534042; c=relaxed/simple;
	bh=WDl0bA26jgbiFrgSk5IXgePauTchroaaGp8NMU8IqPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqECoPcnAKoEkGdOWsa2S5omo6Se1fJZBYyJiVCbwC7/3DcgARIIoHWQPBHG5dAczle+3lPHngPLrImG2xErmADeZh0Qp83N/7wMyKxpby0WZxz4Qidd11UTrNSctYaFbie+tASgHHPUOfqhFMNXHtI7kCvl5t+7K4ZBJkxo/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vi5yMCPp; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so2523229f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 25 Nov 2024 03:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732534037; x=1733138837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6W/TcW+FzL/8d8uwhMwfU+3kKX+iaCdQ6aLKFwbtfQ=;
        b=Vi5yMCPpajMos6kplKLn0Zp0rQ37vgyoJw1hG4FGRaq0emYN89Yoc/VJFb/qS7GlYj
         riO+mgIcs7W8/rnTmiC8+mxa891HzAVIzfhECl9Fb0uvZuzIsKB/6F8ZBlS9XVN63Ina
         h4cY1eYkpvJ3Vjws5UVY6ebN6OoVcvvxQfTSUNshzELoAxkptVAby2hUgWgVTWNOiJZO
         GmYy4MlHMxLP7bV9GZ6QkQ9fCBp6qVm+4NqJwS5L8AxACsExocu96jDWKSvZmLHYfKzk
         dxWlB2cJy5Yr2X06EINKmsUENbe8oAKj6va7PWTO+WRj9r2QwksCo8LShhlhwZVHfJwl
         ESBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732534037; x=1733138837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6W/TcW+FzL/8d8uwhMwfU+3kKX+iaCdQ6aLKFwbtfQ=;
        b=q8zk8uMND2zvGuas9tAi3SfgVdOy4Xqhp5Jv/lZSsf/ZjEO8COHJ0+SLVQiaND+mEQ
         Th9jQSeyoTJAPtzgeBoiqSEfzx+jUQs3pdEpmCy7N5wfK1UGZLiGT2I0ggFdGs9+u9Zl
         FUguZZd2KD9ffLE+fNe56IFX6lIxDXf/3nkPUKQV3spXlezJnhO7nhy2l1DTddPY4OCJ
         ScSTN6YrOAN3a7bRsY6PceugoVOyLChoWTsTEFXMPcrQCkELMp/kQZACdBlHTsMDusX2
         KYxIl4vLTuNrhm9t10RHx63+X+8NDUiN4i98ut+jL36UXX9831+xePRmh3vo5biygB1D
         /Qzg==
X-Forwarded-Encrypted: i=1; AJvYcCVJb/Ra8YOLOLKVQzl2gSc9XLUIcyXJDyB9RB/3mMq9BfRbbgpBTQna/T9JI2w0u30qmhb8ZxXFVfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm205lxy8frrfXYpDa3wyb3//1/H8qH3v4SYbsvkn/wvpAf4us
	JryTHLcZsUkrtfHNIh1ijaUxy0J33hislsEug4UL5Dk05IzzquB0+IxiHfbzw0k=
X-Gm-Gg: ASbGncvoZBrT4RkGQLvtluchFaaoJyUU6DKQkXPu5TAK4EAKRBf8yGxafwG++gdLWLz
	Xwx3cwoGgi/PXThEs4ExJZ8TIYm0WswGSqvh3kP/8a+Usv9TkI0b/TPsNrPR1vawIcVTXFsFFNC
	1kbKRXMghUyKKX5dBIXne3dvcDKTmMuTsdK5sIJjFZavEBxLso9cwPIbeh15U8p86WVo5IePzdC
	c9LaQkQH+xW6uk+t4G6fH2f0Q+CfSegH4aF/20HaC8tm6WIbKSEBqiGfycb3ZLqq9bAZw7aoSBG
	20Vl1UC2gmA/uJdrjA8RVLiLrL+LlEfH4RVRXQ==
X-Google-Smtp-Source: AGHT+IFv+LaRoSpqPLBzP55J1LGA76RLnlorbc6Kvzp2ZM8a0jgP6t0dbM/2WuhnW+/2vowoHiwUhg==
X-Received: by 2002:a05:6000:18ac:b0:382:4b43:c3a with SMTP id ffacd0b85a97d-38260b45e0cmr11044948f8f.2.1732534037626;
        Mon, 25 Nov 2024 03:27:17 -0800 (PST)
Received: from localhost (p200300f65f242d005bbc9b581c6b9666.dip0.t-ipconnect.de. [2003:f6:5f24:2d00:5bbc:9b58:1c6b:9666])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbedce3sm10097370f8f.97.2024.11.25.03.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 03:27:17 -0800 (PST)
Date: Mon, 25 Nov 2024 12:27:15 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Dumitru Ceclan <dumitru.ceclan@analog.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 10/10] iio: adc: ad7124: Implement temperature
 measurement
Message-ID: <eghe47rkwxmcfkamayemvwfksonrwbysaadakbdm4lvzcsy4ee@7gftiif7ka6i>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
 <20241122113322.242875-22-u.kleine-koenig@baylibre.com>
 <CAHp75Ve_sD-a-m4pYmKrT=LhajO=F7TG7KM7AsM47J0=ksVgNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bs2c2lob2wt3zs3e"
Content-Disposition: inline
In-Reply-To: <CAHp75Ve_sD-a-m4pYmKrT=LhajO=F7TG7KM7AsM47J0=ksVgNw@mail.gmail.com>


--bs2c2lob2wt3zs3e
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 10/10] iio: adc: ad7124: Implement temperature
 measurement
MIME-Version: 1.0

On Fri, Nov 22, 2024 at 10:31:07PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 22, 2024 at 1:34=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > +       /* Add one for temperature */
> > +       st->num_channels =3D min(num_channels + 1, AD7124_MAX_CHANNELS);
>=20
> Is the type of both arguments the same?

Hmm, my compiler is happy with it at least. I don't understand why
though. I'll do a few more tests ...

Best regards
Uwe

--bs2c2lob2wt3zs3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdEXxEACgkQj4D7WH0S
/k6i4wf8DW0o0Rcu5ZujKf4zLtPWyNxenG/CRn4rhq3mhs5LwG6CXR8hxZ/0rtLR
YFTCiFD1HcyQWwDhdEgqsUx8fJu8jFOHdfFElnBzbcd3fiXf4h3bPhXmws9O/8rN
XNnD482R9+/BPsbG1ZIsbH38rodpTa4a8P8KMw44fcUO1sNmgS2fXd+ddDHT3wM/
kL8P7vOufEMMYCMTS4rIBMc51mnukRuBCU03YdZO4ht5sk8jHlYQ1/2/1fyzHQ4l
piDxyNU+LKafY2LlFuvCKUPsie5c7PlFwj+XLbP2E9u7oaIHTtT2nWB+n6gU4lOm
SRT51CVU9ruP63dJ09Y8h2cPAOH0vg==
=UAaT
-----END PGP SIGNATURE-----

--bs2c2lob2wt3zs3e--

