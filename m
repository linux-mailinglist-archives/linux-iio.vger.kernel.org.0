Return-Path: <linux-iio+bounces-10657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A3B9A08DA
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 13:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C9D1C23834
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 11:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD4A208983;
	Wed, 16 Oct 2024 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9zm1Q7u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D177206979;
	Wed, 16 Oct 2024 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079691; cv=none; b=i4Zesp0bFgiTj1WyGA8fvXe8/Hg4o0LZ9B/EMIBaUyJmLIdlUfMAiPVzWjW2Uudqzm9PD055ttG6akSxoGbN6fZ4hThSW+EfaY2ZYEMEoWgw4oxVorW+8p/T7RIJApcORZtgMrS4444CNgxWIf1tIJ12kYF2zjzgCYdscQS6p58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079691; c=relaxed/simple;
	bh=L5o8ve+VBHrYej/fsSNBUxsfqyYd3ayQ8f7khXw4HFI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QASegUVGE8hWbcVE2lpQ4pm95k4Fn6YH8ymXEYmK0du5KUnCXU5KP81gLth/R10Ib295FIZfCVKJxDhelYo6e66nhJi35EQP4CYmBK2e/1HiQzCuFtgJ2Way+Hv4aJOBrSlIjIjxFTwo8iXGvWnuq4W0xoHmXmt4VCdALyAIfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9zm1Q7u; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99ffeea60bso526181366b.3;
        Wed, 16 Oct 2024 04:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729079688; x=1729684488; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z0OTk8uA9zI9WVj1Qu6RX4DnD4VV3Dh4MTgYuYdKIqQ=;
        b=N9zm1Q7up9OA5XXiNFteryjYZH7G28JYwLjB+HkAqs/eRyUjmA0pjWVBWsahr4rzBQ
         bGhyeGRAv3bNC1k9gTGieNkPjO/nTV7eIO1nKknzyVK572woTexDacCVifl5GzkhX0U+
         H2d0ZlOQLIEUvnid8l6IuE/ci//r+7sFE/vFEE5dvn3TVbqAIceKRLlYCxPImjurggGM
         0xK+y014z4M6ySeA7hvuulPvIMrR9y1f3oLxkNR2nVhxLuIvJbGnYqW0+C/VodtgFemQ
         tFjxLmb8C7vsk1AyU9s+o/e8UVGmgK64AHv7UGxA69IpswdM3y88AKdzfFukyuaLbGto
         341Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729079688; x=1729684488;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0OTk8uA9zI9WVj1Qu6RX4DnD4VV3Dh4MTgYuYdKIqQ=;
        b=FoY0vNmhO77UACCkHtmJI3+NoDLi6D+jr60SrrBcRM5lCTxVcWLIzyRbWcvEi/p/GP
         wC4edCbjkPrjWrv4NRgDOvK0sNo8Lnfx7cjY3q0Rb1B5rv1yo4WPpnyJzNkTDo3VWR8I
         nHlP3h9y24q+XG0Vh5sohucQjXHB1je1/fFSj3ZdXmW6or/5IKmRECjzAN/O4fuS/HK1
         hWVVAJ7Jgtd2z1uEEMhK5vWwvydHl9uMIhUjpT9n55CKdd/rxsbm5868fkUGBEXFgiYx
         /3vW5BBS2/u40D8avhv2ARLeRuP1Ivc5iWaRvQe+3BEkaq3n6Ht1cL/EIjwedemSkcrO
         h9ww==
X-Forwarded-Encrypted: i=1; AJvYcCVYjklbzyWMEk/zruA3Xp2Z1nHBmP+7ADbFTrkPkb+0vxaZds6+5VlCdp05p070+QlWa1AvfMiHIboh4U6K@vger.kernel.org, AJvYcCWz3EIhpUTP/Vg4h6g1+b194ETkrf9q8pNwfehyFw/+aPjGA2IGettu7YrQwQ9mx1Wkx/gnB7h3ezQE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxct8Ju2jJQa1AH9jKkE5e53gK95VKl0TgHG45JIeDMYPstcj+B
	6W6kVWSABr7aZroKv/3FHo4qvx/063eWf9Ymflp9YAcPMLNmHPt/oluecpGwrjDgjA==
X-Google-Smtp-Source: AGHT+IF/9oRF6YEKgYiwKxIqKCxwILrNcGJG10m81vLSGKTHRuCSu+6WqBf7IYEFKl9bNKlIV000Xg==
X-Received: by 2002:a17:907:724f:b0:a99:ee83:2b19 with SMTP id a640c23a62f3a-a99ee832da8mr1278188366b.35.1729079687512;
        Wed, 16 Oct 2024 04:54:47 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a298443f3sm173586666b.165.2024.10.16.04.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 04:54:47 -0700 (PDT)
Message-ID: <8caf3074e925dd131ff62375c6849a7f3ac6c5a6.camel@gmail.com>
Subject: Re: [PATCH v6 7/8] iio: dac: ad3552r: add high-speed platform driver
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
Date: Wed, 16 Oct 2024 13:54:46 +0200
In-Reply-To: <f1f7f187-f1d4-4d81-9187-ac238c0ca964@baylibre.com>
References: 
	<20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
	 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-7-eeef0c1e0e56@baylibre.com>
	 <549566b00524c0230a6a970b74a38dbe58e2589d.camel@gmail.com>
	 <f1f7f187-f1d4-4d81-9187-ac238c0ca964@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-15 at 09:48 -0500, David Lechner wrote:
> On 10/15/24 2:15 AM, Nuno S=C3=A1 wrote:
> > On Mon, 2024-10-14 at 12:08 +0200, Angelo Dureghello wrote:
> > > From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> ...
>=20
> > > +	} else {
> > > +		err =3D ad3552r_qspi_update_reg_bits(st,
> > > +					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> > > +					AD3552R_MASK_SOFTWARE_RESET,
> > > +					AD3552R_MASK_SOFTWARE_RESET, 1);
> > > +		if (err)
> > > +			return err;
> > > +	}
> > > +	msleep(100);
> >=20
> > nit: fsleep()
> >=20
>=20
> fsleep() is microseconds, but we really do want milliseconds here.
> Datasheet t_18 is 100 ms. (Internally, fsleep() calls msleep()

I know. That's why the nitpick :). I just see it as a good practice...
=20
> for anything over 20 ms anyway so makes more sense to just call
> msleep() directly and avoid 3 extra 0s.)
>=20

Anyways, fair enough

- Nuno S=C3=A1

