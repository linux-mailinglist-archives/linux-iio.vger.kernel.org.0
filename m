Return-Path: <linux-iio+bounces-20781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 117FDADFFBE
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jun 2025 10:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A881759F2
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jun 2025 08:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F12264A60;
	Thu, 19 Jun 2025 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW3pKRbl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A1126136D;
	Thu, 19 Jun 2025 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750321810; cv=none; b=IAjQ0zk1pmgO43vLblRWuBH/caLjjW7A+XBVCCZWIPbR6ASZbJfT+lSgoCg4ifR04xMhbYEaZQKyLC/MT9iUHrxag92BC+dss4c8CBHlBN0SVOn8zkEeHZrLQqAkFYufciPQq8TM37OGaLYt+gZN4lSFLYifSISu+aZuJxOGGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750321810; c=relaxed/simple;
	bh=e6K52pkiA4lbq0TxwiOJxzpreb0jdw8kCEm3dDzE+so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcQVR+d2LKDgRoMCbvUoSOwylS0Uon30O7l29gah7aukTFu1wbzuELrCoXrIOihJm8vpQE+csHnR/WoGVoCITcS9OccNWPh9rgi7m89u86tRIHMG6iwxmQqmIPjlqNJUmeSlNsSYtmfxc0/3N/9x1a2m/5Z0GCSoa5TYObx0lDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW3pKRbl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad89333d603so91463966b.2;
        Thu, 19 Jun 2025 01:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750321807; x=1750926607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKn1ptPL56ANrUjI3SM/qbSzwOU3Ovzfc0dxrbHyY+o=;
        b=hW3pKRbl6rLwYBk99tBn4ruUkxbk1UAyt8ovhcF8BmjUfra/sLzChT6P8yyC8ebSwg
         yoAiB8pmoD+yrWGLtZYwYrfMQTz3DR6rrQzC7mtWcUTNb9xDlp6etk437fwzrYiaATL4
         iw3sY9fik5y+LxOrR04HMh68Fo8wCmlfUiuWUIk6XPnIYC0oJO6SYSiuZRq1dwIbXm4F
         wZp38noENZBOqhS5wzwko58Auon4aDksZFXAT/X++SxTYNMtxefs9Tit9im675BZL6Hr
         S7gvrY52SO1lawfnyhTvgK2O8XTUx/gOxBE1ckwC1gwBoRA0DBu959K+APyyCc81B22Y
         8+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750321807; x=1750926607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKn1ptPL56ANrUjI3SM/qbSzwOU3Ovzfc0dxrbHyY+o=;
        b=YBARnVKXjf1npJqV831g10hMecrYfIqVYyhCPq9VdwfwkCTpV1px2hQw97XcCNxXCt
         EW/yx3ESNnnjoi+ttRLM+AxA8yQ0xMsP8puPh3phkur3fr9qzVGwO0zmqJxQeRBWiTNs
         1LMOxd6hbTY5t3xZErmVXraGLjmKlbcNC3wuGsLtzw2e8I/UF2zaeh9TJB5nKjmxBCCr
         2CxGTEb289cv0yQvsmMd68UOBtmKVn9Y+6d/OoDvp5BnbhUzRWk7zg8gH1HHlg6kT7wA
         BAaXxn9g57+tzlPRwyh484luoH8AvZggPO5CBsdraiRw+ozb6N2tqVDDYg1Eq9MJM9yQ
         SvaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGRADRJXPWx3XCRAFsRUNSTm7ZYVhAQY9HUocMaJ/2JrMvRcpzsSjaRvVbDo8P8SYRO9tGGsCQaWb7AZtX@vger.kernel.org, AJvYcCUdRY2av6XQ7MjDMJLaNeQPBmrunU7Y9AzKUiRt8hebb3KskQj/G4SK2xfC7KUFTzksU2OWxagpsLeY@vger.kernel.org, AJvYcCWbCSKQbqOm9EhDcNLK9r4LJ1pRAVfYm0NGPA6JiPHMunqCHE/jzgqDxR1bmtUcaNMynyItEcPsC8cn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3W7iIf3EiUHZqDJKUwVlocteGWKy/G8V/Yb+kVDSQu73+h5si
	2m/iindEp00FlM+bZUlqagSkIVUvqNIkuhsLzauckbXyJYdWsf8ZI57nfDgxEdhG0JZiGe8paCk
	7IMnZN2Mzoo/KvBfOiSKoRy8jPJz+nho=
X-Gm-Gg: ASbGncs2jjEWDkDirOhT+PpDcAU2fKLnG/NSROKIqQSnOeQseVTNyqC7kw7YMpaATH5
	GECYzmv9pBg3wxT2N2ffPyqcmcKUKDiC5jTf8XBtIY3UaO2LpMukCdolBfRVYyuKAoxHB0AQW0r
	7uXp8+cZQI6tgXB+d8Z8nI/WMUYLOKkmOw1Pus0acXsIQ04g==
X-Google-Smtp-Source: AGHT+IF0i2vkEF+jFHeW2WDp5kmVNds+1mm8/x/CqyVXx2I+yZPnhJtAh3oOECcje7sEAEEwsOb1vr6CTNHgfN4ifPE=
X-Received: by 2002:a17:907:1b0d:b0:ade:5fb:53bd with SMTP id
 a640c23a62f3a-adfad3c5445mr2083453666b.20.1750321806964; Thu, 19 Jun 2025
 01:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613130207.8560-1-victor.duicu@microchip.com>
 <20250613130207.8560-3-victor.duicu@microchip.com> <CAHp75VdRisP+trez2Ysgrhan_zXMWsmawB3XeW+_ePsbNC4RzQ@mail.gmail.com>
 <f980b3c1a4fbd60f70dda9670648479a38313439.camel@microchip.com>
In-Reply-To: <f980b3c1a4fbd60f70dda9670648479a38313439.camel@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 19 Jun 2025 11:29:30 +0300
X-Gm-Features: AX0GCFtK0ncIVhpppFTb1voQFgUUDtzpBF-GqtLcEGCIbcMStBY2pLpHDJm_GWg
Message-ID: <CAHp75Vc2nueOycoy8+dYyQekAAMPO82wOYSVT0RZOC4yRaE5jA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: temperature: add support for MCP998X
To: Victor.Duicu@microchip.com
Cc: dlechner@baylibre.com, nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, jic23@kernel.org, 
	andy@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
	Marius.Cristea@microchip.com, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 10:22=E2=80=AFAM <Victor.Duicu@microchip.com> wrote=
:
> On Sat, 2025-06-14 at 00:50 +0300, Andy Shevchenko wrote:
> > On Fri, Jun 13, 2025 at 4:02=E2=80=AFPM <victor.duicu@microchip.com> wr=
ote:

...

> > > +MICROCHIP MCP9982 TEMPERATURE DRIVER
> > > +M:     Victor Duicu <victor.duicu@microchip.com>
> > > +L:     linux-iio@vger.kernel.org
> > > +S:     Supported
> > > +F:
> > > Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982
> > > .yaml
> > > +F:     drivers/iio/temperature/mcp9982.c
> >
> > So, with the first patch only the dangling file will be present
> > without record in MAINTAINERS. Please, make sure that your DT schema
> > file is in MAINTAINERS.
>
> Are you referring here to the file sysfs-bus-iio-temperature-mcp9982?
> This file was in v2 where there were a few custom attributes. In v3
> I removed them, so the driver currently doesn't have custom attributes.
> Should I had added it to the files in MAINTAINERS?

You should have added the file to the MAINTAINERS in the same patch it
appears. Not in some arbitrary change afterwards.

> Isn't the yaml file sufficient to describe the devicetree? Should I
> also add a dts file?

No, this is not the point.

...

> > > +#define MCP9982_CHAN(index, si, __address)
> > > ({                                          \
> > > +       struct iio_chan_spec __chan =3D
> > > {                                                 \
> >
> > Why not compound literal?
> >
> In v2 I used compound literal, but Jonathan suggested to add
> the struct in the macro. After describing the reasoning, we
> agreed to code it like this.

Neither of the versions has a compound literal.

> > > };
> > >              \
> > > +
> > > __chan;
> > >              \
> > > +})


https://gcc.gnu.org/onlinedocs/gcc/Compound-Literals.html

--=20
With Best Regards,
Andy Shevchenko

