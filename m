Return-Path: <linux-iio+bounces-2270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDF784BC8A
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 18:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25CF1F23440
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 17:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52FED536;
	Tue,  6 Feb 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFic7dYK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07623134A8;
	Tue,  6 Feb 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241934; cv=none; b=AhjZIHeD0HYqzwpgg1FVNFWdZqVdEEKfoA9+sXLVAfWKW3iEs4vKQZY8iFpiWexNvUFf0P3jTz6M0Cdjxwz+GOAAtvC4PWC+B/B9/Ch4W5RekPL/K6lKFukT1p5/3T2FuXuxlQATXcHBzcUPk9QRX7d8LLBWrcyR6eRZvdRs5JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241934; c=relaxed/simple;
	bh=2QzhABsTxWUBevQWOZGnGKdirZ35HE7FBPGc4cptxDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECc5GIns/mdJY47GyVl81cHOk8zTlu4Mcat+h/9zm2opMpuSLQmywALD5X/NMZNUj4dIgVK3BprbZ9S6WW85c3FnEVODyVDlAF+GiJ1lldmZgBNwNT4PlKWolcIliu8O2F4Hog6AVPdQ4n2mAR8HOTooDqKcyx87+6QJFa1Lhys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFic7dYK; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51032e62171so9547144e87.3;
        Tue, 06 Feb 2024 09:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707241931; x=1707846731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faYwZb7i+yTIOYFLp3WhvWUDBoYAgBs1yg0oWwe0bd8=;
        b=nFic7dYK+R27lSszdQdAqngVQX9TCfTlE868k+ruTr7HHHyC1wMmC9vWsBsH5un1GV
         KExoFfzzEtP0bVa+02mktF/e3JYg4trqcNsv58hkVjcKkAE2LFS3Onb0v2eVt1FaT72/
         w9+cldNQhvwaQvfbKJrDr9NXBSUWsh4+eZA/BF28DJ49EQh3zGS4jqkonk/ienM9wF9u
         4B1kvYmg/mjOZLSqH0zB+5H/HOf+OS58pCTHNm8uA3ju/FOccBEFR1XG5qSrvo9K8E0Q
         zx5wSXcx/qg9CwGib+NpwwECgV3ao97mynqYCoWF1GZtBkDB3ull5zBLr/4W7MDvcyZ9
         G71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707241931; x=1707846731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faYwZb7i+yTIOYFLp3WhvWUDBoYAgBs1yg0oWwe0bd8=;
        b=KM3lzqCqm0gd6Ug86/iDbpoLtl0GDcKXlwY1o8a8Ewbsn+HMA7Z6M9o5/V/nPRQnuC
         x7SJm9SQwcN/y2MC+kTPtEgv+wq0z/YdLEWaAzenuRDLZt70zlHrDHrX5ThfVxcUdIja
         oqCJAiufaytcm2H1P1cJzppn3Vrli5X26NzBz6RERhQFdCZilYqmTnqNT086wuwXHEig
         Tipm96zRZSlL7ubpsmuiYs7Bnnn6eWgXdD97rnntFtNGS7zymz/EQdzBFvx8udFi2EnJ
         L2ECsUN7myR+ToBMxZgtUbKIUKTlYb4eGyFqphc4LwJh0+Mz7dcGVQDK6bys4LOFCL0N
         jgOg==
X-Gm-Message-State: AOJu0YzkB+OO+HnA8RmH7EExVkJuAOytXp4AeyXgyWIPKNiGQs3pLEH2
	OllMef7ed2M08fqhObYww9iEdBwGqMrld7+PVTeLmCz6BAWFaLXPf0OMFh/KL+LrWdAvlPOyqP8
	ZqZRzusWI41im9y8bgtvXHfJyCvs=
X-Google-Smtp-Source: AGHT+IGLTy6TLx4POxhIQbKFUiAsygftq31SCBY8yQnVaF9lAFEaBrv4NI6RPcfIMr/BkWbhtVqz0ABNcXJfCKFyegc=
X-Received: by 2002:ac2:530a:0:b0:511:61bd:d748 with SMTP id
 c10-20020ac2530a000000b0051161bdd748mr822543lfh.36.1707241930825; Tue, 06 Feb
 2024 09:52:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206-iio-backend-v9-0-df66d159c000@analog.com>
 <20240206-iio-backend-v9-6-df66d159c000@analog.com> <CAHp75VeWV0+hqCoUb4YvfObnEAv0AaYJmXgpxJLfve+mBwhkyQ@mail.gmail.com>
 <f6ed72343be50c358db8e7e36d9afa875f788425.camel@gmail.com>
In-Reply-To: <f6ed72343be50c358db8e7e36d9afa875f788425.camel@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Feb 2024 19:51:34 +0200
Message-ID: <CAHp75Vf3vvYHz6pTpAQGEAxV-obWV+0XbhVhaFqYU5JUbtFY8Q@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] iio: adc: ad9467: convert to backend framework
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:51=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
> On Tue, 2024-02-06 at 16:20 +0200, Andy Shevchenko wrote:
> > On Tue, Feb 6, 2024 at 12:08=E2=80=AFPM Nuno Sa via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote:

...

> > > +       st->back =3D devm_iio_backend_get(&st->spi->dev, NULL);
> > > +       /* If not found, don't error out as we might have legacy DT p=
roperty */
> > > +       if (!IS_ERR(st->back))
> > > +               return 0;
> > > +       if (PTR_ERR(st->back) !=3D -ENOENT)
> > > +               return PTR_ERR(st->back);
> >
> > This looks hackish...
>
> This was suggested by Jonathan so I'm keen in leaving it as-is

I think I proposed how to improve it. Jonathan?

--=20
With Best Regards,
Andy Shevchenko

