Return-Path: <linux-iio+bounces-12732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAA19DA984
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 15:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3481F281B87
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AED61FCF7D;
	Wed, 27 Nov 2024 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/ZUJEYi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70103232;
	Wed, 27 Nov 2024 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732716042; cv=none; b=M5MrTgOHpP8vvJ9r/2mMunwQ3fKQ2Q/oUF4fV2bB8R1NfkoL2yE9ZhUTfgYwjz+duxXwjHQhBjt3UrjI/F7Ksh44k4AJiQo5Msf1GCQ+3lXgq58HltnLcdJgnRUWkCp+jiXiSRn2bNCF27msEi9TUU+d3ObffWAkY0hnIO7ZqMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732716042; c=relaxed/simple;
	bh=JgCw2ZB4UkDIjh7bN82YDZQzcE3edM9pnmLtA95/n1w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hy3gHr16dFqXSukN93ZI7Qd7JkdUuDWqY5LOS8VPHdMcT+1wPfRzdPWGs3NXidcsSitevhDq/QVX6eWhLeICdJN2mdOZvs2kwDwX2KF78+rpw+fPq/jx8O7RSXPGNbvCEYTM9lYTaWtc35IejMedo494BMO2NqQ9EjsLwJv8Afc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/ZUJEYi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so26169325e9.1;
        Wed, 27 Nov 2024 06:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732716039; x=1733320839; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JgCw2ZB4UkDIjh7bN82YDZQzcE3edM9pnmLtA95/n1w=;
        b=N/ZUJEYizD5nYF3ggu3AAlnk/AKTYeh7K4VYeMUaXbL8PwF80ZF5oMiTHzrFEeAwYX
         +w3TJExC91Y7eYxuRAJpXSE3VSP3Y5SGVr5fpjG6oNdI7tT5Z4/8layTnWBjXLzTVW+e
         6LEkEiQVBTJRoNI0aTxwySO/cWzmqENDlTCZRf4qAketsJumIN3GOx3g0/aGOZ2xi64y
         pd1/jiM9G9sUKMfdrvRrSm934Dh1uksSgUxwThGZIECAsOaKogljUGzVPX+rzQw3xi/r
         qoVjB1+LNIDuBC19kpGjtJfgLmWgAdMofO21EkEtgyBCjXojiTMqGy4kIRHacjaSWmje
         tz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732716039; x=1733320839;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgCw2ZB4UkDIjh7bN82YDZQzcE3edM9pnmLtA95/n1w=;
        b=ZvqRoTyCGNiwbAw3lThVv8O07q1yVnPYUJwp1ac6heB4UkQ9Up0KuDgCvSdOkL31AU
         Qn438hx5CPr+ogwpGTK3W+PjcL5Kf/Uf4tXQEWVYqskIpN4+abV+7o5UFTzH5wHf7s5e
         E9u5kp3g+ZSnnGpiKndGRykNZ4dbRbkIfwa/J3EhnlW3S/lZW42BFXmBIVxMNqYkS5zD
         erUpMZFJZ1mxvRMw/MZzceZq46Wm75Zz0j/IACWDTdohoTZOpB+tBcaVjsgRE0UBdzn1
         VoFCxMTNqk+orsOQhtaOO/7vjFdRQxioQCIB5tNzc42yXMP2jGQHUu2Z38C+O8gGVrAR
         7IVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6Xiwv/HsyMBfD0CbLzpuqCffdM3MNPEZoIChoiFAHuwbMKCxwCSwaXCF5S172BwbyTzfOqNEHxy/j@vger.kernel.org, AJvYcCVHyh7GBgfHa+kfZlbdvMQLRSoTchJW9MhjwFlxc4awWus2iLZmfFh/zIZZU1cXvkwLBPtqFrS0F+kY@vger.kernel.org
X-Gm-Message-State: AOJu0YySDdzxPiTs6sfKFkyfi230ll7MEBAbYnvc/jqM7LTFfi3+BvsK
	D/Gk/3rinN7z6GjtDHmP4oSyMZzrJAL6gvkTUUaxU+pGIP6dRNVW
X-Gm-Gg: ASbGncsbGlofPK7XCYaZhBB76BATvNlaXHJT97Uzj+HmaxsVcXG6z1+jJcO8pHlC/TV
	ZxBEUEf2bEvXF2IwSSTL/ek6RQcp1fUbsFPFYnOkCti84R9Sua+P2W4JJesHoBx9B6FelygH23M
	NGmwQLMlTeCctVKdyh8eK0EWjoZNE+TvgDGKvricjvaRZ+LxDE04JcsyXGKISdbjg3cAMUOS8fl
	s5XLpipxYY6FBxTENTy/uUmirdMtukcstm6iU2K5xhD9flwdDvQ1Lcx5ec6kLb/Crti5YLo1N8Q
	oKUmQ7DGlMi+HB91GfJhNV39eS+2p2Tsog7K9oXL520k+p09C4wliJBhrUnhiFtX+ADCGDeaP8h
	Tdy4nylE=
X-Google-Smtp-Source: AGHT+IHBgojp1MwCEvySa9guIxfKIiAEs5qaMPVvWyzd7GgmuFwPZw8S8Nr5lLgmsUERuRYl0or4Tw==
X-Received: by 2002:a05:600c:4e4d:b0:434:8827:f713 with SMTP id 5b1f17b1804b1-434a9dc13e2mr29617495e9.12.1732716038245;
        Wed, 27 Nov 2024 06:00:38 -0800 (PST)
Received: from ?IPv6:2003:f6:ef02:f400:a23c:697f:16fb:11c5? (p200300f6ef02f400a23c697f16fb11c5.dip0.t-ipconnect.de. [2003:f6:ef02:f400:a23c:697f:16fb:11c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7fa3b2sm21922085e9.41.2024.11.27.06.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 06:00:37 -0800 (PST)
Message-ID: <848b5160b1170a9725df48d8dba563db2a0ce998.camel@gmail.com>
Subject: Re: [PATCH v3 10/10] iio: adc: ad7124: Implement temperature
 measurement
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=
	 <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman	
 <alisa.roman@analog.com>, Conor Dooley <conor+dt@kernel.org>, David Lechner
	 <dlechner@baylibre.com>, Dumitru Ceclan <dumitru.ceclan@analog.com>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, 	devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Date: Wed, 27 Nov 2024 15:05:04 +0100
In-Reply-To: <CAHp75VcMHyqjsAVveRf58PhoiKyPJRsjBQiLkz+XVu+NDc+Wog@mail.gmail.com>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
	 <20241122113322.242875-22-u.kleine-koenig@baylibre.com>
	 <CAHp75Ve_sD-a-m4pYmKrT=LhajO=F7TG7KM7AsM47J0=ksVgNw@mail.gmail.com>
	 <eghe47rkwxmcfkamayemvwfksonrwbysaadakbdm4lvzcsy4ee@7gftiif7ka6i>
	 <CAHp75Ve3hBhCMFkjA4-hiLfGQLeeGt_74e=PwTH_nF1NCYiyOA@mail.gmail.com>
	 <2tsxyxmfh3ozolsziu3bps7liagzl4gmvy4oykvyeapziagvy4@tfa2lcxmdsmf>
	 <CAHp75VcMHyqjsAVveRf58PhoiKyPJRsjBQiLkz+XVu+NDc+Wog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-11-25 at 21:33 +0200, Andy Shevchenko wrote:
> On Mon, Nov 25, 2024 at 4:52=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > On Mon, Nov 25, 2024 at 03:47:25PM +0200, Andy Shevchenko wrote:
> > > On Mon, Nov 25, 2024 at 1:27=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@baylibre.com> wrote:
> > > > On Fri, Nov 22, 2024 at 10:31:07PM +0200, Andy Shevchenko wrote:
> > > > > On Fri, Nov 22, 2024 at 1:34=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > > > > <u.kleine-koenig@baylibre.com> wrote:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Add one for temperatur=
e */
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->num_channels =3D min(=
num_channels + 1,
> > > > > > AD7124_MAX_CHANNELS);
> > > > >=20
> > > > > Is the type of both arguments the same?
> > > >=20
> > > > Hmm, my compiler is happy with it at least. I don't understand why
> > > > though. I'll do a few more tests ...
> > >=20
> > > If num_channels is signed int or shorter than (independently on the
> > > sign) int, then it's obvious why. + 1 makes it int.
> >=20
> > Ah indeed, I should have understood that without that explanation.
>=20
> Yeah, but a closer look shows to me that num_channels is unsigned int
> or did I look in the wrong place? If that's true, that should make a
> warning appear since AD7124_MAX_CHANNELS is signed int...
>=20
>=20

Hmm,

Weren't the min()/max() macros improved for things like this?

https://elixir.bootlin.com/linux/v6.12.1/source/include/linux/minmax.h#L22

- Nuno S=C3=A1

