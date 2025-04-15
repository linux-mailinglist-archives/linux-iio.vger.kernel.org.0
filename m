Return-Path: <linux-iio+bounces-18123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEB0A89112
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 03:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0C017AC08
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 01:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFC51F4CBE;
	Tue, 15 Apr 2025 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eee3aKhU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A44C2E62C;
	Tue, 15 Apr 2025 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744679797; cv=none; b=hrP7Rc3fOUTqW1LheUknOqEOmE7XnFrI6FDhxwTKYEO1C19MHAHnFvvxt83H44gQGHO2/8ErFowI8ahyfhM0cpgHIM8d5v4OtP9vRr+mMhay7AYPzvq1qtN7VrSaUPcf4O3j6PDLvLgWjlqE26gbqt7ugRKq+7tH81pOj+lGIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744679797; c=relaxed/simple;
	bh=3AB+ECf5kRFUMb8Ghyva4AZG28Wl4rG6qolNBiF49po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/cJb+clvQP3C8ukfY67Gx+ZdfsQO9s5V7n83U1EUmWlNm81+GaEAWx0mG+c6Hb2Q9OZjOS2rxPCYsEo5AIuQAiDWHY10YWms/2AJcPXUOQsLaeXIn6SF0brw9eSFjd1V4Sxfr89I1aYZCoeLMT4NTRrqwmHraFxs9lAnu09WbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eee3aKhU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3011737dda0so4109476a91.1;
        Mon, 14 Apr 2025 18:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744679795; x=1745284595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Nuj753ea7qfkVgx/WDLsxf+XIOdvwBj7hh/Oj4q+pg=;
        b=Eee3aKhUu6ijcDmM554IoPl9bWFVYNQ8qZ9tJbPeK2awAmGZaFN5WLZNETKBaqxFbv
         Dgbb6ZUv8PAoUcpLpWCWpISP/PWdB8BM7GbgaKBHpGXtPXI+2phq5GmWCIVa0awBxTAf
         CWubK0BVjtxVTEHsnJkrZNaJ6Sd4qrLDf823Q1gVR15tYq69/etHxGzYdUH8vkVeMCY/
         M/4+JT5ZKwvNH8gCviYAu+Rk5erEnsLEqTYNRZOOC7jfXeEZiPTbYoUqju2s7BkJ72PS
         wIGpQAz8FAgmrocTXmrBPqEWKtPY/OuyfzBwyayVr6dJ/EHvHGmcMI09drtvF/YqKUVg
         FVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744679795; x=1745284595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Nuj753ea7qfkVgx/WDLsxf+XIOdvwBj7hh/Oj4q+pg=;
        b=fuSmOeSzsmNyoDLLaIgESBI7bCfPuTkQu4Uel90Osnitdx0dBjLINVU/dxj/NcL+gZ
         w+rPawYJ8Y4lg88uqEse9F+DnwSyqUtRqb8xj3fTPZwTcnRNiCZHxAkjGX1hL5PohzjE
         leB4WqIXKi93pA+dcaJzttc/3rAFMsXHat+Digc3g1htAufsevsENCIMJ8YR1www20vK
         SJjy90Vlkg3h7BfOe/AqY7hugtbX91dp3piXjKRbpk6rGzXK+Vov9ymrMJu54/sqdcNz
         7gx9LMv67MZrpKjX8ij+u6/HDhlVMzgcmcHPB5IBXx3mdAZNRmCjB7PD6GGNsGMH14qa
         Hm/A==
X-Forwarded-Encrypted: i=1; AJvYcCUYkIWU64yzEAXOjiSGxi9j6LsZWG77KUtZJd6fl4rGjVGEMLZQ99/DlDb+bCnCH9N2YdLLP8UmtVgJ@vger.kernel.org, AJvYcCXs28TN/+ov1/CnhlNCwikfVvLi/7FBYmP4jPM2WUSVGBN8dASokJz9cqIfIE9kMI0rMovQeNj2QA4l@vger.kernel.org
X-Gm-Message-State: AOJu0YwbcL90Z57q19uRDlolph2zKzKlxTyS92EMtA95jti3UvoNTuVd
	FXLi3+yK74uk8FuNJG6NL5wjoBt+0DI7SE28dBgvz0CB7/LY4hdOTVrAKEF9DokLsKPugHd1jMI
	ikSMLXxhgtcqjDfq/qhDtQ6SOHJo=
X-Gm-Gg: ASbGncsRFBA5qhCDllK2lhX0fHrdWIUF2CqsS3xahQ9vwabKqP7996pQ8v7B3EWeNNo
	m0RCIE7aIbVuiORFi6rLAMRebpNgCO6VAtAUbwRKLDY3DbpYvGWbOELQ8u2FRBK1E0phyQuOXe2
	w5rmfssvfAFLdjfBFzw3tWeQ==
X-Google-Smtp-Source: AGHT+IGgzIi9F7lrPtwIjA/TgWVY27GzdEaPDW+rB2zEcrkEC9WU+5JbizaK/UgvXU+4DZVPqT404HSnJ4WznO/cmtk=
X-Received: by 2002:a17:90a:e183:b0:2fa:15ab:4df5 with SMTP id
 98e67ed59e1d1-308237c1177mr17682632a91.34.1744679794805; Mon, 14 Apr 2025
 18:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409024311.19466-1-gye976@gmail.com> <20250409024311.19466-5-gye976@gmail.com>
 <CAHp75VfMHdw-6vrELbjjD3T323uDz7U9wRP5YSk2jZ26wBuLTQ@mail.gmail.com>
 <CAKbEznsVxexdrXX72G-tCUHjznx6na1h8MrCFPKrHd27GXht8A@mail.gmail.com> <CAHp75VeU5sERbVz-4OxkJNC-pjT3B5AvfAMj09LXd6v4MdeDeg@mail.gmail.com>
In-Reply-To: <CAHp75VeU5sERbVz-4OxkJNC-pjT3B5AvfAMj09LXd6v4MdeDeg@mail.gmail.com>
From: gyeyoung <gye976@gmail.com>
Date: Tue, 15 Apr 2025 10:16:23 +0900
X-Gm-Features: ATxdqUEiwFZntbAkoQGSF2tTQBTaV6RNaL9vi1FwBU_O_Jnsedb1BjG3xpiQYhc
Message-ID: <CAKbEznsAJ1U+QBs_ZM66Apa-ji4i2BAihP8w++EnAh=8eDaogg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: chemical: add support for winsen MHZ19B CO2 sensor
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 2:21=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Apr 14, 2025 at 6:49=E2=80=AFPM gyeyoung <gye976@gmail.com> wrote=
:
>
> ...
>
> > > > +#include <linux/kernel.h>
> > >
> > > No usual driver has a business to include the  kernel.h. Just follow
> > > the IWYU principle and make sure what you include is what you use
> > > here.
> >
> > I thought "linux/kernel.h" was a globally essential header.
>
> Not at all, it's a big mess which no driver should use.
> And on top of that (to any header) you should not use 'proxy' headers.
> It's a bad style and practice with the real consequences as build time
> and headache for the others who want to clean up header dependencies
> in the future.

Now I see. I had been referring to some legacy examples, but looking
at it again,
It makes more sense to explicitly include only what's needed.
Thank you for pointing out the good practice.

Thanks,
Gyeyoung

