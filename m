Return-Path: <linux-iio+bounces-26595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38208C97B82
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 14:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 069324E280A
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25755310768;
	Mon,  1 Dec 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGyPOeIQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6C7262D
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764597022; cv=none; b=OD2Neq9pIEPa61RjuhHp/IlNowiQ+9BWCQlIDBbRqVlKPAUNXURhWF9g/1ov2/bAvp5LNXZSJnUfURQiUKhYpsQsYniZ2c3B0g64dOhGeQiZZHpcHVRgwj1OVkr7ApXb2U8AhsmdNwmqMIr5cG5Zv73+66gShPrnixd2PGG4/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764597022; c=relaxed/simple;
	bh=p85X0J0UnbALoITGe6YA4ab7POsnUlbmukdXt+y5esg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLe2V43ZsZqkL00XpCjfqkEyjLsouTyyqUJon9GESk/ga2g/dzZwd5S1CpsvGpan2Hc/VUbG9CLGT3WPV3TM9CADoM5aqVyao3sJUpUMEzRwFBYtGWLKtNRq3zJqBr8YOLysf1/jAwW+Gu+7V+ityWRLvIUomvAfG62jMoLex10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGyPOeIQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b73545723ebso833145566b.1
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 05:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764597019; x=1765201819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uKx7pf/MHkZGvF9ayjlVAxa8MKZFSt++HbCpNwuS6w=;
        b=jGyPOeIQ0Otv2ymrtwmrP/Vm4IEWFE6KRMZ88IJOGqd9rHpSIJw7LlJvhpWgpJvHyf
         4wo9maeWsa4fTvSOVFpt/JgZDAo3L8hLkrtpfw8QiJccjqvUDN5iEmuZ4X28DqV4mBQk
         Miy/HWlvf6kHfaED1u/xCeO9uhjwxHDNS2YwZXGW/OKIJSAKeI1MSybz6xDRYGGGehev
         mq3pC16oiAvHD1QKdCGZ/Q2oX9G6oJqc5CuyU9DnbzC2LVfaHl0Jb7vXJXIHSZezItt4
         DEN0yFQqOcYjBeJEfSFOdJx5tcJvpH+AnaOYPZTECk1cfBrngQVPY06BCwohT29r2+TJ
         KyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764597019; x=1765201819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9uKx7pf/MHkZGvF9ayjlVAxa8MKZFSt++HbCpNwuS6w=;
        b=qfZHfSVCWXDGFuNoi2Gsibj1xmWDduQgJWX+WRKuhTnnr7/Ha8lfR+vYBqqmWv0Nrs
         T1z/PaI/yrtLcOeaugAWjUcYIWKlUnLhExxZrkvsFCZYLypHsGWaHMkaNOLd0kI4Uyu3
         7q2/+vLyT4B3Pk4m9c1KIDXlvwtd3NKLjb+RlXCwnExRB4aDGyeHEfhW7IhuAvgQaAOR
         eN6bbVJ9hTMnB7wGlcee5qEA/gEI75ewsxREMx0gQptrWfNVfQf6Ucyz58nMNUy9BND5
         ON4I4MF/vGjxIkHL9Cc+pwoWP9EYpIZJE/D30lscfLC1o6vgV8WEjH05knU300cVP00C
         Ky1w==
X-Forwarded-Encrypted: i=1; AJvYcCVqZcj7swcMGeAoecI/RxyYeq3MWPRkvbA3xSVbwfRTtILnvB1/WMbr/81wxgXeDn9BHhSJ4XBd5Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHUmu/RvREuNc/iNp/AMCk7pQCPByo8INPGGroYBlT7/dMW7hn
	RrsMHoz8FDwegV6ndyPYjsNKpSu8MeKS2L1taIjxWiXaRKijVxmS3yTgthbf9qDU8CFK2Df5m4k
	PYBJrzPOh99yi9sK4aQPxOFWyzOEp6bU=
X-Gm-Gg: ASbGncsQkmxntJtukWGENd/Le/LYX2QsakkCM28LOsLTYyA7w1DFWkirU+SVFqR16tf
	Q9CXAx1M/sqwmHcdi8fdtTPO0PycXAt08K702X0CH/sg9iMsJxhSYFdeDmSBvcdmKbeSEZfTX3y
	NVls+0B3emLEXVPRIx6LQPrR0p8QQWOQKzVRYrHiehlW6ujNKJZMPkXNGIoyGbdEBDMoXa6LaqX
	dlwSXEWQdAgemJcTgYDgDaLBkG8SCvYFhCWgCvFwJh0RiaHFecXeYehsh52kqzm4o+IWC5bQ8IC
	fFZulny7pyDkR+etswjdLFGdvOhM1MSywnQ7BXmTadHI7iYQ7BeGS1acep1hCy+1G49iA9E=
X-Google-Smtp-Source: AGHT+IHEOLuoGXFGYBTH2HjQUfuu4TkoqmEk+qrU7XALhRvjeCKZ+qrdCqGfeDWXrLGf2eTNZzSTdvKoEyteHojFqx4=
X-Received: by 2002:a17:907:3e86:b0:b73:926e:ddc6 with SMTP id
 a640c23a62f3a-b76716844c4mr4321393766b.10.1764597019209; Mon, 01 Dec 2025
 05:50:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201-ad9434-fixes-v1-0-54a9ca2ac514@vaisala.com> <20251201-ad9434-fixes-v1-1-54a9ca2ac514@vaisala.com>
In-Reply-To: <20251201-ad9434-fixes-v1-1-54a9ca2ac514@vaisala.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 15:49:43 +0200
X-Gm-Features: AWmQ_bn0AG5ww_oR5DfxgRhbYCQMGAXFVUHKSuP8RpigyA8mafSVaI3G-6Is7SA
Message-ID: <CAHp75VfMO7GfyNvWwR88VV8atiJ_wV0M_xbzMnroP5tp8=sodQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: ad9467: fix ad9434 vref mask
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Alexandru Ardelean <alexandru.ardelean@analog.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 2:00=E2=80=AFPM Tomas Melin <tomas.melin@vaisala.com=
> wrote:
>
> The mask setting is 5 bits wide for the ad9434
> (ref. data sheet register 0x18 FLEX_VREF). Apparently the settings
> from ad9265 were copied by mistake when support for the device was added
> to the driver.

...

> -#define AD9434_REG_VREF_MASK           0xC0
> +#define AD9434_REG_VREF_MASK           0x1F

Can you switch to use GENMASK() while at it?

--=20
With Best Regards,
Andy Shevchenko

