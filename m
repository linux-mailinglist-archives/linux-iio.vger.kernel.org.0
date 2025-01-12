Return-Path: <linux-iio+bounces-14236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE76A0AAD0
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F091887083
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC8B1BD9E3;
	Sun, 12 Jan 2025 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igons2Ac"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E3B1B6D18;
	Sun, 12 Jan 2025 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736698889; cv=none; b=AvUBu5LOX7ACr2en5k6zn94qLRlV9jHzF7huwHtq77sBeiiurmfzupJrPnAB0m7E6vvh+JVIJmztB9JpWLIwvZM6rWx8fuQ4dxaVGKt4/2i1TvN/dIpCYv1bqul7O/sNvRNAUE8Oes1L5ZjAJTRrtyhv1cXuEFsDoYCY54/aQUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736698889; c=relaxed/simple;
	bh=WkG8/aMMZYRYV2jh+yrAriwQWA125X5xFX9wxlZc5Ek=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=gkx7HFZQJPKw2GE5u7yGc/YH4+963UVCDK6z9sDy3l6fv1pfWO6+8G2fL2etSSrW9h5JM3Ojx50ZSc+cuogw8IfpzbAOx/HPCR3ZVx5SHayeflZ8IbaN8yrqQB+36XnffVgrl9juKzYdWGFbURLgnPF5hQbpSkSlHoxZS/+bIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igons2Ac; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so1909544f8f.0;
        Sun, 12 Jan 2025 08:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736698885; x=1737303685; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLIHX7c79HxmZ4kE3sAmC5aW0gruDHMawK4zEwJ0CMo=;
        b=igons2Ac1LOE6vkrSWJwR7MQIcuIXF9Vp6xmFi4PLqgHnN+LEk4CCjF0/22jDqODoB
         UyesCU3FzznP8M7qK9e//QPwBrB5GV2HCthHyJyxsr11PTwWEn9+CXjgdetDP0dy6mJn
         Y3MNwCOFmif3VqhK4Q6o8xXi8jO/NmeLMQtS9QvpYKkuBxSPNDyV+8+rS2NmkBw6xSGD
         LQWse6/qWH2zfkYaITHYvxcwedAfKwZ/XAS2n7wcgWXZoutVOyHcaZmqi6ufVHq9Vor6
         02hdsaD1gGh/gabyxfWyBHv4Yqt/OdLgLBqtF6qTU9ED2rTzX/1P5nOHny4UGwlc0ekW
         3yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736698885; x=1737303685;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XLIHX7c79HxmZ4kE3sAmC5aW0gruDHMawK4zEwJ0CMo=;
        b=vnN33Ik5T0H8sy/7M4HyO1W078lMTLKfqQvqR7NYIeiBur7L+EKWsdbIE15qY4jJTb
         Cb6j67GMgCw4Szzkvwv3wt263JldLQv278fgVvVlWbP92X0K2SQxhsSn/zjFurSv24FL
         fvU3zBgfCWhglcjomI5Ay328x7X2Um9kQxWfQY80fXxLRYWm6YYVIJaknJZxcSprrByQ
         cenconJ1QORMfVMT30/ReB/mE2CzUUq7qbGXJRly/Mtcn1EbVVgUYmGmxtzKbmSYYaZz
         y75W5Ver+wSXMvj+pYVZ0u4ObB5Qf9lSPNTqAwoVhhaMyNzvtX5HkM++9EG31rS/ekMJ
         N/UA==
X-Forwarded-Encrypted: i=1; AJvYcCW05z4QYkZZDBzYDvJezByybKYC0UycGu/L3Sa9WTKvPd5Oh68kVV64wZFenaJ4zxOgm4objHn2iN7SOldE@vger.kernel.org, AJvYcCXklvKod3gIwJ7gVelGFle0kUc/a8Ptg1aAZoRuZNqz6PRfU7VW10Ebi3yauIkRjgYWk2LmVRn1lFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybJB26MgHRe4e//pW8QgeS6ivWkoAPsvyYg9rDUDSgC5SZx8nG
	WKzkMxlcMJqTLgQGs3KVyoSi1QpOho5B3/pdtnAMU/z6+8VfL5u1
X-Gm-Gg: ASbGnctZ29I/FvlHmT9dwtZP6JvOZ1QlNPV7ojkCTOZqj+G7XzLpXIaoxxgdQ8mN+TB
	ItVMGEbI2K4fgBN5IukUPNPaxG04nFi714BeUyw3LdE88Jqav0ZdDWcBslq55GMqaesi7+4Qn+D
	zUGwxhewJBTZxD3k9Ctn+guOppaJ/HF7s20F+vwPMUY8Pf+O03F8RfRC7P/sT2vefg5pQMhMhlR
	V1iv0H1uONYnOzhmz9/50YbsnmAbjf+RmoOrRJzlnmADbmAqj3lBgGojJTDnebAIusoW5CwI8j4
	EsSp1JLGr95/SuKFo8ZVKzZBNkmt0yA7q1mA0kZapc16kyQTmRsLSd5SaQORTuPeN0Xx0ox+JPo
	e
X-Google-Smtp-Source: AGHT+IHnYaU7SXiwH1qOAxbBOUkh15WECy6TNA/nef5w5HHrG5I01zZ8nLXnTWPt7GtePnK4CJ1HFg==
X-Received: by 2002:a05:6000:4714:b0:385:f821:e97e with SMTP id ffacd0b85a97d-38a872f6749mr13594859f8f.9.1736698885569;
        Sun, 12 Jan 2025 08:21:25 -0800 (PST)
Received: from localhost (2a02-8389-41cf-e200-b3ae-4f78-5cdc-b04a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b3ae:4f78:5cdc:b04a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9dd1cc3sm114842115e9.14.2025.01.12.08.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 08:21:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jan 2025 17:21:22 +0100
Message-Id: <D708DGNQA4MO.1DD0OCM1TOHS2@gmail.com>
Cc: "Matti Vaittinen" <mazziesaccount@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v2 3/4] iio: light: veml3235: extend regmap to add cache
X-Mailer: aerc 0.18.2
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
 <20241224-veml3235_scale-v2-3-2e1286846c77@gmail.com>
 <Z4PdP1ZWkd_YgzJF@surfacebook.localdomain>
 <D7082ZE34NTT.DHC0Y5220527@gmail.com>
 <CAHp75Vd5LdP7+ndresVv5STN2zrC3S5puDhcACyEk7MbLA0hgA@mail.gmail.com>
In-Reply-To: <CAHp75Vd5LdP7+ndresVv5STN2zrC3S5puDhcACyEk7MbLA0hgA@mail.gmail.com>

On Sun Jan 12, 2025 at 5:11 PM CET, Andy Shevchenko wrote:
> On Sun, Jan 12, 2025 at 6:07=E2=80=AFPM Javier Carrasco
> <javier.carrasco.cruz@gmail.com> wrote:
> >
> > On Sun Jan 12, 2025 at 4:18 PM CET, Andy Shevchenko wrote:
> > > Tue, Dec 24, 2024 at 11:59:02AM +0100, Javier Carrasco kirjoitti:
> > > > The configuration and ID registers are not volatile and are not aff=
ected
> > > > by read operations (i.e. not precious), making them suitable to be
> > > > cached in order to reduce the number of accesses to the device.
> > >
> > > ...
> > >
> > > >  static const struct regmap_config veml3235_regmap_config =3D {
> > > >     .name =3D "veml3235_regmap",
> > > >     .reg_bits =3D 8,
> > > >     .val_bits =3D 16,
> > > >     .max_register =3D VEML3235_REG_ID,
> > > >     .val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> > > > +   .rd_table =3D &veml3235_readable_table,
> > > > +   .wr_table =3D &veml3235_writable_table,
> > > > +   .volatile_table =3D &veml3235_volatile_table,
> > > > +   .cache_type =3D REGCACHE_RBTREE,
> > >
> > > Any specific reason why this is NOT a maple tree?
> >
> > Hello Andy,
> >
> > I followed the most common approach in IIO (52 RBTREE vs 2 MAPLE),
>
> But it's historical and can't be taken as an argument.
>
> > assuming that the "low-end systems" comment for the different REGCACHE_=
*
> > applies well to the typical systems that will make use of this driver,
> > and many others under IIO. I considered that *possible* performance
> > advantage for low-end systems above other considerations, like the
> > general rule about using maple tree.
>
> https://elixir.bootlin.com/linux/v6.13-rc3/source/include/linux/regmap.h#=
L58
>
> "Any new caches
>  * should usually use the maple tree cache unless they specifically
>  * require that there are never any allocations at runtime and can't
>  * provide defaults in which case they should use the flat cache."
>
> Can you reconsider?

That was exactly the comment I referenced, actually the part about
low-end systems that appears right after what you highlighted.

I have nothing against switching to MAPLE, if that is preferred even if
the main user of this driver will be a low-end system. I think that IIO
is a typical subsystem that addresses needs for very low-end systems
that are sometimes slightly more powerful than a microcontroller, but on
the other hand I am by no means an expert, and if MAPLE is the way to go
here as well, I will send a follow-up patch for it.

Thank you for your feedback!

Javier Carrasco

