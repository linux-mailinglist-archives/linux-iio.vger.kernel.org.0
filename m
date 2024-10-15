Return-Path: <linux-iio+bounces-10595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7062099DE0F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 08:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8C31F22AF9
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 06:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B0E188717;
	Tue, 15 Oct 2024 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIUljuGG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BADB1591EA;
	Tue, 15 Oct 2024 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728973065; cv=none; b=JdrZVe3uDs/P4WiWvaUzzNpWCaU9vNxBlmbvAMZ/Ftvp9blSy+M/HumxyRscp9Xssys01ehS6DRE6iNr5ECjGI0p+iFjQ49+fQjjm/StgN3ge3Ab+/7IVzDx07tclJK1kNO21w1e7O6lBXHibkH5aXDNvhjkj8+Cp8Wx+CrGKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728973065; c=relaxed/simple;
	bh=IsAbei/8GTBnhwgbr0HhdjaplF9Gtfz3pnvcw6+y/rQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z7k5Kl6XgCA3wK0va4rTd2dEi8b9bLfAEDqbMSbTcTfaAu3PmApW4X+oBIs4XgDhZBhC8BpHCkNG7XU45y79Q5EBaAFF8p9x6YrjK/+Shj1FaxzMCDyW/PelPVsqBCzZ5lbZU3yf8YLAD3L1sk60b5/KRCiYO6+1Lf9ZZ4uqebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIUljuGG; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f84907caso1982717e87.3;
        Mon, 14 Oct 2024 23:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728973061; x=1729577861; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sZow/PSe8knzZXaVaN0MsOXi7OUrBEZMsdAJB+k568A=;
        b=ZIUljuGGYnvWWksxNTdyDtGRXysnONh9J15rZay604/8HYzJmcrOyBj1bPdLhIUFRr
         RVFBXcMW6e8o0J6LLEhHqfYi4zw56MUKiZt67dBUrw0vN2x04fx205Mbav1tTLM6gazY
         e2MSd/Hz0jRq5HVBdRDYuDmhPftyz1ORYBbUfgIL+Nehfi8IBlUix5YdGGAQlz6IRogN
         3FL98KCcYE4dLAYpFLkw+8/ep2KS2wrxA92+9W+E3xNnYz7MtvRV6g6AVbrV+QXa8m3Y
         gm6EEikklgvC3VkU3p5m+tO4eJ+2dh8YPeBrd0LcOSrEFEHwt128Bck5lE1vjyrHEbyh
         48Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728973061; x=1729577861;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sZow/PSe8knzZXaVaN0MsOXi7OUrBEZMsdAJB+k568A=;
        b=vhFm1OcZ0QfvxhPhl/g2/Yj1V+BI5N+eqWNTGJxdaem8BBrsIZMEsxa2lVbRu9OzjY
         ePYquxmi9SqAS59S5Tf9VwKP85gNdcKj02vlpqUgRCZ2eMUHnGt16xkx1MjDAmGMq41a
         5TgxCDmdUPwKp8qso2drJIprXcRMoIZUujQ+0H2QA8xa9PipFUAtQ2G16MC5gXqYeWns
         5Q3FdLs2/Wx+2n3FDTgo6HmpLXqEua7R0yFUAb3VnVeMza8R2NFO7Be05unctlnGpif2
         W95yUnRNBIPgRqrHDV6PtjCmhUU+lNM9pJIL5HDDexr24tladQVv9csUvvqhavKVNuii
         W+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW47cNUPPTLUjtXjHycl2E5ScF0DdV9L+WA4LQnlKSNJo5sDnjyhHP5T22QqAb4rjwY03atcFleee8J@vger.kernel.org, AJvYcCWMq2LCumRDOWThXkJdf1Le7VtfGS6BFKZA7Yn/KyUlRl+MAG3+jvZ6Lq4xEgs/WLcnB5NKMVNuP4CXsUda@vger.kernel.org
X-Gm-Message-State: AOJu0YxFGe1yZcnieaSyRvVIc9U+hJJ2UERSK9CLoXBHmxj+j1ccZN1Z
	ymUfChOxiLoSNKs9RmynpiTfGfaDVouri6/B/DIxe4s28aAcNRAdwVWPpS5rZzg=
X-Google-Smtp-Source: AGHT+IEzCQDyW/MaNX5KwQDbgNZ3TLmk/AXPGOCVoE4K9ppYTbPq/QoP38Z1YD1qemZGg/xxdXZCPQ==
X-Received: by 2002:a05:6512:4018:b0:539:e776:71f7 with SMTP id 2adb3069b0e04-539e77673e6mr4038266e87.37.1728973060924;
        Mon, 14 Oct 2024 23:17:40 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc45297sm670216f8f.115.2024.10.14.23.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 23:17:40 -0700 (PDT)
Message-ID: <aae0d87ff9506198e0d9bf3abee6cd460c655ea0.camel@gmail.com>
Subject: Re: [PATCH v6 5/8] iio: dac: ad3552r: changes to use FIELD_PREP
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Date: Tue, 15 Oct 2024 08:17:39 +0200
In-Reply-To: <161aa7f4-299d-4486-92ad-3f3eab2f2979@baylibre.com>
References: 
	<20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
	 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-5-eeef0c1e0e56@baylibre.com>
	 <161aa7f4-299d-4486-92ad-3f3eab2f2979@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 16:14 -0500, David Lechner wrote:
> On 10/14/24 5:08 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > Changes to use FIELD_PREP, so that driver-specific ad3552r_field_prep
> > is removed. Variables (arrays) that was used to call ad3552r_field_prep
> > are removed too.
> >=20
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
>=20
> Found one likely bug. The rest are suggestions to keep the static
> analyzers happy.
>=20
> 				\
> > @@ -510,8 +416,14 @@ static int ad3552r_write_raw(struct iio_dev *indio=
_dev,
> > =C2=A0					val);
> > =C2=A0		break;
> > =C2=A0	case IIO_CHAN_INFO_ENABLE:
> > -		err =3D ad3552r_set_ch_value(dac, AD3552R_CH_DAC_POWERDOWN,
> > -					=C2=A0=C2=A0 chan->channel, !val);
> > +		if (chan->channel =3D=3D 0)
> > +			val =3D FIELD_PREP(AD3552R_MASK_CH_DAC_POWERDOWN(0),
> > !val);
> > +		else
> > +			val =3D FIELD_PREP(AD3552R_MASK_CH_DAC_POWERDOWN(1),
> > !val);
>=20
> In the past, I've had bots (Sparse, IIRC) complain about using !val
> with FIELD_PREP. Alternative is to write it as val ? 1 : 0.
>=20

Hmm, I'm fairly sure I also suffered from that warning. AFAICT, there's not=
hing wrong
with the code so I would not make it less readable just to keep the tool ha=
ppy (it
seems to me that the tool is the one that needs to make this right). But th=
is is just
me - yeah, not a fan of the ternary operator :)

Anyways, no strong feelings so if you go with the above, I won't really com=
plain...
just my 2 cents.

- Nuno S=C3=A1=20
>=20


