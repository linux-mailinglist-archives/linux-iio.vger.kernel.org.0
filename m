Return-Path: <linux-iio+bounces-6038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FB2900C95
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 21:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697F81C22580
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 19:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5923254918;
	Fri,  7 Jun 2024 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea29Nhr/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2931CAB5;
	Fri,  7 Jun 2024 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717789589; cv=none; b=E5zgWVJqDg1GkWDR+rWzQDPYRpnOdKG2uBIHkR8Bp/CaiLSXGSSdMFPPhBEZpX0PzNCZJVILQ5iLzZWD04apCttjRlu0RV6R0OqPkIn9u2A1ce6r/hOa5mwbu/uegez1fzD8QYe6aeBxvALw9IubA1Ooqhzfhs2Q4zPqgQ3IdKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717789589; c=relaxed/simple;
	bh=k1irwgi6FpLi68D3GV/XGf5Bn+slGqNsnRvB/NipTMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvYDdWaiQlHsqOvBGaz5Wc0zBwaDYTpyq3njuU9VBJMh/XhqAZw6UCw91epfvXAJR3ImV1csV0WvuA81LtLOZh5/DwjayYtLFS4zV2AAjcDTCc040NZqsLRo6f/h3Wu8GyGsLNl3p6h03+6f5qaYeozMWStTrwQ4CouaJ6JINis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea29Nhr/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eaea28868dso11349291fa.3;
        Fri, 07 Jun 2024 12:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717789586; x=1718394386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TASRa7J3c3Fsi6rgHDMWx68962HVziRdA3Bk8xRP7fA=;
        b=Ea29Nhr//SU0rlo8BqM18PVRzLoq3cm9f1UsOdwkOiim4FZlVkBBamR4DO4cELUzqr
         YZuKTNNHY8mvEga7qdgiNIawhVptjpLftdyAtVHV9dJ2cfc7CR2GjX9NzszVRx9J4uJV
         o/nSeDhnElyeNxYnz//7ZBIj1ITmG8ennSNVFGnV2udb3JsYpTH9Cpl1ydMGeArgd5pq
         gFEdwEBYfKOh507oIVQ9sj/mbnGD/5LUpdWOj4Nieb90SDbgFiN1LuTAPdBSGS4+tv4J
         6WZwatycZCjoRAwz03u722FMg1d2dNX1/wi2/1zVe4cA3NbMkDTK5V37zy24MLRU4FZb
         ONWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717789586; x=1718394386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TASRa7J3c3Fsi6rgHDMWx68962HVziRdA3Bk8xRP7fA=;
        b=FiRErSko1akWNg9afAPrxAVqSzlcVb9Ue4gKSpOiKxli+WSkBxPfDXj/p7yofKh6Nf
         +5UN8nKNvkHPXRJNJmz170Ov0XO/o+Fz8M5zz2M2akSa368hOJCAyyA+TrNcoSpNIi62
         /dkQxH8L/Vecyh4zO+HDNQQpqGdWYFUbLSTmNNkpes0rmfaO+eXlphryKe1qWYjm17er
         jodGosEyoPnOFlcedPl1BFG3g7zwSC4fcwYOKW43mpj2/0xj15gg86cNFHPTSMCmdKqE
         g+hlo9Uj6T28mWT9ob5vQIgCNCGPuRM4N2zKyGVGSmfq5Ox/GcGKAQEolI9rkZj+DEyU
         fVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHl4QpCzUcqGH7bsd2CHeP3KN1ahDg0Ahl+fn11Z8v7RFsIqzzvOvmpRYrRgq1/cqiBtteUYYXpGlrSg1aL8uzz770i4RuHCv5JFsigY6b/rPi1vEPWV4kNBIW+xzdopd+OXDfeu39
X-Gm-Message-State: AOJu0YyJNEUaIBb27quz+s4F9ygK6kFQtEnr+UKepSPpNYkFSd++yUOu
	DzGB9me1cqrBuT2QAGl1H3/iKN0kRht4HShkvTMQW/DEg3vLeQSitqUoHlHL/vuT8jsZAoK18/5
	JMwmnTPZdET4nEISg1TpjLtmY44I=
X-Google-Smtp-Source: AGHT+IFja8mXc3yosgz7nndfFzkqXO00aH626fCWmanVCy336Tq+1BF5oj5+AkBubXnheL+aEhpp62EhPCpQIPoYzRc=
X-Received: by 2002:a2e:99d6:0:b0:2eb:45b9:cb45 with SMTP id
 38308e7fff4ca-2eb45b9cd47mr6079711fa.2.1717789585475; Fri, 07 Jun 2024
 12:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607114138.390272-1-yasin.lee.x@outlook.com>
 <SN7PR12MB81017291E79E6B61A8DEC9A5A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
 <CAHp75VdYYGe7rXJm1z2a=r7ZnSU0-y+3N8juoNF-5xXi5=z5nA@mail.gmail.com>
In-Reply-To: <CAHp75VdYYGe7rXJm1z2a=r7ZnSU0-y+3N8juoNF-5xXi5=z5nA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 Jun 2024 22:45:49 +0300
Message-ID: <CAHp75VfYhMbHK7pMTuVDZ3uc5ZjytA7uC+3fr7u3nWUEosGZHw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor driver
To: Yasin Lee <yasin.lee.x@outlook.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nuno.a@analog.com, swboyd@chromium.org, 
	u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 10:40=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jun 7, 2024 at 2:42=E2=80=AFPM Yasin Lee <yasin.lee.x@outlook.com=
> wrote:

...
.
> > +static const struct acpi_device_id hx9023s_acpi_match[] =3D {
> > +       { "TYHX9023" },
> > +       {}
> > +};
>
> Btw, do you have a reference to any device on the market that has this ID=
?

Aaaargh!
Jonathan, we have to have a big rule from now on on ACPI IDs, if
anybody introduces an ID in the driver, they must provide the device
model that is (are going to) use it and excerpt from the ACPI ID
registry to prove the vendor ID is real.

This is the heck fake ID!
NAK.

--=20
With Best Regards,
Andy Shevchenko

