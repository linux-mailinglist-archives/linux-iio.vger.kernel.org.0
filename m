Return-Path: <linux-iio+bounces-25224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F22DBED11F
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 16:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 24CB134C578
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 14:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A821820B7ED;
	Sat, 18 Oct 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvWGG/wU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CFF17A2E0
	for <linux-iio@vger.kernel.org>; Sat, 18 Oct 2025 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760796990; cv=none; b=tmc4uJ/Tsjj5qDfb97A521INWKxKNIDEZEd9Fk4H5lHLvntKwPzJO6KQseoqbUFuSj5oWPmwn67UpSVewKTFFqxFCSMtT43UWWwzZRcxUDIt6R0AvuccYYkcck1p6Mw7QzRCAzbXJR1hNIWKnv/aH2ItRbvmefUA4sLueLExSms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760796990; c=relaxed/simple;
	bh=X29ameIskitCKG39iDo9fnFG74io4N0elFSW5JYWjCU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cJYo5iQV1iFWPmslSOcKjUClj6abZSQgvDYomqc//GVMFnnKs69BQgV1ucZWOTVMjtI2bu5J2yt0U4DC7ro13zxMfyTSWQ+dTTcfEjD/Wi/jmSbc6WISiu8wSoykECaNFkfhSzTn+6UI1MeZxkiKqjKzqCSyV6PLYIoIfqrTGLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvWGG/wU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so22280895e9.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Oct 2025 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760796986; x=1761401786; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IlCRwb6ZxMUe1+qjY84Z++qKGjm7fl4y3NpRzyLl6u0=;
        b=IvWGG/wUtI48CVMZIi9Os8g+nfjkPY39YS79IHWMLT0tVBRwPXOgf8LDfqH+LEcRJ5
         tx76ayt/kII0DAvvry2RDzch4AdRaKXf6M786FkJR4ES6WADi4A7vhVLStCZTfJY9sxm
         /SmeQ7F9tMPrTyQKBtPMFxwstaJVZnzeVNzKbYWMAt9ZLLejxQt9IJDn/313AMjPZOsG
         vPaJFC1HrUgYEFvv2rckwnC6koMxbwMPbcGUWxLH+kPOkcNeiN/XRMO+5MoVtHDoPpUa
         Z1B9h/EhFHFWI6kyKyUjwq81JvdTW/YmM84hOgkOtaU5ra1S7DoVvrpyzDkjoXgvneDN
         SyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760796986; x=1761401786;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IlCRwb6ZxMUe1+qjY84Z++qKGjm7fl4y3NpRzyLl6u0=;
        b=ON43vhn6yLKr/cxt6YLsXF1Wwipo+H6zhM1ZBrMyWNAxlQauWHBEWPvV6IEH6bFojW
         SYdUZt4M44KO7mqjZ4kbiIyKxPsawVHuIsvmWaRgaVOh32706RdYbP5NaNhB4kIHvIGI
         M/jydiZHcfc7a0uqh+lejVy9JKpko80X+ROyGcJuNKF1SOcP2VIRtfVDoIW2K0rcIJK0
         Wd11B3D0m+43Zs6JbYj82KiRJVj4xOcyKJyRjBm9stXc8DIzq7RZ4Qz8TzP2tQ6jkbDX
         YkVPXh0skLjzgz1P1dE1RfBV63L4Xd+YCJQunrf1tUXRrRPLcdsYFJBmZwcspgGqH6QB
         w2oA==
X-Forwarded-Encrypted: i=1; AJvYcCXpWDzq0SEj1R2E0HZaBH//O+HJ641kE8dUM8TuvI9muZqWIN6A8Id0hnnqAm33K8l5rDGkA5HSAJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2IE+GM+KGMtye/rlXzecqU6ibi9V1JRq6GhVCvqVCyKjJtJyU
	Nn0ScL2LEXkRNR6aq6+wi6vXcA8bAG+ZQXaTw1FeSCv8hSr80NAj6psqr/Iw37TT
X-Gm-Gg: ASbGnctb0j2rscCYkK3uFwx2aR7f5d4O85aabBua4pRVCGTcYEEejmqs82zwvp9RrTW
	FbMajYkULT9lCZd6/izA/IZCJYQom97a9lQzLopIYRtOjMyYRwf++lxXZnWIaownLF8o++GSQKL
	fo+r8rH47MTmk1SZtPY8j8/SrLHvQK2C1uRDsRJZ5KJBDB8a7fslkUlelfNrvoKRfolHnM7WTO9
	3nlQVriAR0OX5hFknvbL7Lnk9Ul4ArEHkSqn3kEtTCoVE6IK4EqJ7xMgqO0mjMC/x8oXcyUZx/d
	DE1P50UH9Bsa2tqTvRfGgRNY/bgUeCHI21t4sPwE70jQK6vncOFq6ZLXpcdgADAix/uqiPw7FFK
	CG3BUXCy8/Vs9zx6uXqCIjtK0RBYSyhAfEwonJ25qXLI6AUK3IUeXcURxo7ZzBZmP6DMMGPRSsU
	ItpnRjs/WP
X-Google-Smtp-Source: AGHT+IG3AlPGTUhBjZicoKO2fafPrO3Ym6F/9eWov1dBZ28BCJY0XCxolDXbuHb3nvEg1oKZJQkcwQ==
X-Received: by 2002:a05:6000:40dc:b0:414:fb6c:e369 with SMTP id ffacd0b85a97d-42704b3db2dmr4898244f8f.5.1760796985415;
        Sat, 18 Oct 2025 07:16:25 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427e1be5d6csm5297975f8f.0.2025.10.18.07.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:16:25 -0700 (PDT)
Message-ID: <a5cc1d4850b17569900124e1e4cf7549cedc7692.camel@gmail.com>
Subject: Re: [PATCH v5 5/7] iio: adc: ad4030: Add SPI offload support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org,
 michael.hennerich@analog.com, 	nuno.sa@analog.com, eblanc@baylibre.com,
 dlechner@baylibre.com, andy@kernel.org, 	robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net, Trevor Gamblin
 <tgamblin@baylibre.com>, Axel Haslam <ahaslam@baylibre.com>
Date: Sat, 18 Oct 2025 15:16:57 +0100
In-Reply-To: <aPKfCbZSXxaHICel@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
	 <c12569f251962ad6034395e53cd6d998ce78a63f.1760479760.git.marcelo.schmitt@analog.com>
	 <5e3a1d31f3cec340650e2e63db79903b78ab9a1f.camel@gmail.com>
	 <aPKfCbZSXxaHICel@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 16:54 -0300, Marcelo Schmitt wrote:
> On 10/17, Nuno S=C3=A1 wrote:
> > On Tue, 2025-10-14 at 19:22 -0300, Marcelo Schmitt wrote:
> > > AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> > > samples per second (MSPS). Not all SPI controllers are able to achiev=
e
> > > such
> > > high throughputs and even when the controller is fast enough to run
> > > transfers at the required speed, it may be costly to the CPU to handl=
e
> > > transfer data at such high sample rates. Add SPI offload support for
> > > AD4030
> > > and similar ADCs to enable data capture at maximum sample rates.
> > >=20
> > > Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> > > Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> > > Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> > > Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---
> >=20
> ...
> > > +static int ad4030_offload_buffer_postenable(struct iio_dev *indio_de=
v)
> > > +{
> > > +	struct ad4030_state *st =3D iio_priv(indio_dev);
> > > +	unsigned int reg_modes;
> > > +	int ret, ret2;
> > > +
> ...
> > > +	ret =3D spi_offload_trigger_enable(st->offload, st-
> > > >offload_trigger,
> > > +					 &st->offload_trigger_config);
> > > +	if (ret)
> > > +		goto out_pwm_disable;
> > > +
> > > +	return 0;
> > > +
> > > +out_pwm_disable:
> > > +	pwm_disable(st->cnv_trigger);
> > > +out_unoptimize:
> > > +	spi_unoptimize_message(&st->offload_msg);
> > > +out_reset_mode:
> > > +	/* reenter register configuration mode */
> > > +	ret2 =3D ad4030_enter_config_mode(st);
> >=20
> > nit: if ret2 is not being used at all, maybe just
> ret2 is logged on the error message below so I guess I'll keep it as it i=
s.
> >=20
> > if (ad4030_enter_config_mode(st))
> > =09
> > > +	if (ret2)
> > > +		dev_err(&st->spi->dev,
> > > +			"couldn't reenter register configuration mode:
> > > %d\n",
> > > +			ret2);
> here we log the error code. We only reach it if reg access fails after
> something on offload buffer enable have failed first. We cannot reuse ret=
 here
> because we would be shadowing the original error code.

Right :facepalm:


