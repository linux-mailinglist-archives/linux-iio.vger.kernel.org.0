Return-Path: <linux-iio+bounces-16476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 669F5A54D67
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 15:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38927A45F0
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F0B155757;
	Thu,  6 Mar 2025 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+0LD8VM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865AD8F5E;
	Thu,  6 Mar 2025 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270717; cv=none; b=bojSNIQv3sA4y6KQ18mzUdswB81NZgR2+nLREP9yGqWxi/LFhCB4iOsHSMZhyGeClrAQlVbDqW3BMu5/U8eEba3NMLC8UQ5wXGF0GPXAqPRn86UFUeshW2hxZBBdTa9dS00QTx44vBSSGR9PH3IvMvIyV2pROKif58N4oBkLYbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270717; c=relaxed/simple;
	bh=6ZzYkYzOpEN9bsuAjmemPsA5icXhVP/a2gKzg4hlVrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=un56NOa0o9koSKpkZb18bJ5WUP+TxCEZx3F+Bv9hN5fU0+8tAhOJCcqOj+K78UPg0LaUuBqk2DtUJ2rlyh2rO8ob23z+3SY2iJle4gSs6so1LIr4ImRS+f7t7a4KYfyhoC1e5WkNL+Dq9aGM7HYkT/pxVXzPe/THI1Yf6mnCwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+0LD8VM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22401f4d35aso11826115ad.2;
        Thu, 06 Mar 2025 06:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741270716; x=1741875516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQAiVipD09KIKu+Zw/Djodjc8yHCBQiZ4SWTk0XW8CU=;
        b=C+0LD8VMKsRFxTfoDEGoR3ztl0miPDKkGWdBKNyEqAgLkQFSjaZzXJKAZfDEwgujom
         iVYbR5oBC9xnNYuaZdYG/zuBhZchliaihc+PVdjHkawsv5ilLuvjKmX/gHYQB8pVCrsO
         eqNat91SHbbN1N7buVo8QrXz7FFj2+eW5NQqxXmGroRoG+fdSDxHZh6EXCVaeRilDVSZ
         8eeUmEx7I3yB2Jae5nrZS0PKbJJV3/2ruwF0V2Qyqz8MhCohWqh8ovAKtWY7s3quV7nK
         iOdmSGjf3Y5lDYJ2W87JSDOt+FBLrY5GiaeZ2V7+kY0zV3lj0zTrGgXgyoqaehbINqXo
         a/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270716; x=1741875516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQAiVipD09KIKu+Zw/Djodjc8yHCBQiZ4SWTk0XW8CU=;
        b=vnTYy6cIeSIsGFbHrH5YGCCawD/1sodey+2QNIblhAXSDEEUeMeHJmuSyf7jAQNvDX
         XHH0yTDhA3JR4LovH340JYnPjWa97UR+SwcO6jSy36ouSuQ4aVw36tGFDMPOxpBsFqJ3
         pjIUZ1jldjamwNd0zZWZqWXz9lC8JxWz77hLyL6KWg4IVIFxsLnQgX/C8y3yCRvul73L
         kf0Vvq8kiHrar0pz2VgddcqlsoCtO/Vr9dfFBaHlczJeVtoRvJPag1yHYrAPGNqqICbZ
         TNADdHzR2GO+7yU/5+ZDmKRU5K3nC75Io0jLezdiOnB84ZmernJdPIjDFj9sATBFFdqo
         uvkA==
X-Forwarded-Encrypted: i=1; AJvYcCXSxuo08pI0n46REGmGTW+S/zewmRzQCjAcv60VMMe+vTAkI7XZvhSBcZdGASEF/Ylv+sFW7I3C1Dc=@vger.kernel.org, AJvYcCXvfxpDqsjL9EnCaBniO8/6U14W4kDPb06Fnnkm4M+cewFTH6B7kBRAUwa/UCT5sabCv/IQ+1Jqm4OsT9OW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc/6BfEnZd/NyiJj6U88RqpoSojYeCN+O1+Jthc6HyLTFc2NLB
	cUME3luzcRrICB3ZZ1bP/0hZN3ljpyc5XqfbYcaEfc6IhCLf+A5i6W6XIwI2RXcOxuqymcsdO8A
	p/MO+jjNu7XX7LUYxsokTA6VgLgBTGYWkmJZtig==
X-Gm-Gg: ASbGncsRrUOrt5gyKKxXxW8zwqahZb3N8p8f8jv6+aGGn0QvSLP/RNWB6IQhcB+3Wt+
	mVmZ3DbypSMTe3aJu0i3tOsc5Yz5RcIb63ssrTHLQcCqCHLBe7sIoZckiL78gd3aC7FMQMipTzN
	NNU+nkZ6U+Sn+UoaiXWLsu1MLaF5s=
X-Google-Smtp-Source: AGHT+IFBpyTNHtiMmLFxkbAg/J2sbQ6v2C1nvdphAqmRGoPEzGjVevVePBHeYTX9VAHVhIyAKyCTa2fEOFEk92elhGc=
X-Received: by 2002:a05:6a00:2e9f:b0:736:34ff:be7 with SMTP id
 d2e1a72fcca58-73682c86af1mr10680714b3a.15.1741270715643; Thu, 06 Mar 2025
 06:18:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220165001.273325-1-jerrysteve1101@gmail.com>
 <20250220165001.273325-2-jerrysteve1101@gmail.com> <20250222163752.5eb0d694@jic23-huawei>
In-Reply-To: <20250222163752.5eb0d694@jic23-huawei>
From: yjun <jerrysteve1101@gmail.com>
Date: Thu, 6 Mar 2025 22:18:24 +0800
X-Gm-Features: AQ5f1Jq-3ZHG-6n7Wd6PynG5qETGYDMfW85-PwZ2GKrWZfGiftXy9zwhYY-k7_8
Message-ID: <CADOC9A_wwOS_zm1P_=s0n9MOaUC3nqEQQhWoG4vjxvgZHONjfg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: gyro: bmg160_spi: add of_match_table
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm sorry. The commit message was referenced from other similar
submissions and hasn't been actually verified. I will resubmit the
patch in V3.

On Sun, Feb 23, 2025 at 12:37=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Fri, 21 Feb 2025 00:50:00 +0800
> Jun Yan <jerrysteve1101@gmail.com> wrote:
>
> > Add of_match_table to bmg160_spi driver.
> >
> > This fixes automatic driver loading by userspace
> > When using the device tree and the driver is built
> > as a module, devices can be probed.
> Wrap patch descriptions at 75 chars as mentioned in submitting-patches.rs=
t
>
> >
> > Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> Hi.
>
> The patch content is fine, but I'm doubtful about the autoloading.
> Did you actually try this and see a failure without this patch?
>
> For SPI autoloading even with device tree compatibles should work without
> the of_match_table though it will match against the compatible without
> the bosch, part.  Maybe I missed a change that means that no longer
> works.
>
> I in general don't mind the actual change because it does ensure
> we have the manufacturer in the match as well so makes future
> problems less likely.
>
> Jonathan
>
>
>
> > ---
> >  drivers/iio/gyro/bmg160_spi.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_sp=
i.c
> > index fc2e453527b9..ac04b3b1b554 100644
> > --- a/drivers/iio/gyro/bmg160_spi.c
> > +++ b/drivers/iio/gyro/bmg160_spi.c
> > @@ -41,9 +41,19 @@ static const struct spi_device_id bmg160_spi_id[] =
=3D {
> >
> >  MODULE_DEVICE_TABLE(spi, bmg160_spi_id);
> >
> > +static const struct of_device_id bmg160_of_match[] =3D {
> > +     { .compatible =3D "bosch,bmg160" },
> > +     { .compatible =3D "bosch,bmi055_gyro" },
> > +     { .compatible =3D "bosch,bmi088_gyro" },
> > +     { }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, bmg160_of_match);
> > +
> >  static struct spi_driver bmg160_spi_driver =3D {
> >       .driver =3D {
> >               .name   =3D "bmg160_spi",
> > +             .of_match_table =3D bmg160_of_match,
> >               .pm     =3D &bmg160_pm_ops,
> >       },
> >       .probe          =3D bmg160_spi_probe,
>

