Return-Path: <linux-iio+bounces-4772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E366D8BA773
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 09:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206051C216D2
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 07:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEA91465BF;
	Fri,  3 May 2024 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MagekP9N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC0139CE9
	for <linux-iio@vger.kernel.org>; Fri,  3 May 2024 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720418; cv=none; b=HId/GRYX5dkld6mtsHOnZ6tKJS4MatD1K8oNDH/k0vkXpqnN6ieyRcnfS7mL77v8fO+Ixt5hW9argS+DWQF8BDjxXCpU8vBiopmThbuCYLmSj1c0iDojSUcolNr1QF5Syi/oDEsL55OJ2OYeDrK3VZKJ71NF58kfz/D/cLOCOsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720418; c=relaxed/simple;
	bh=dsTy2wNoWYPdaVbM1kcoJgd+KYE4tOPhm9nXcNIb/2c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N+3Ge/JPq1vOG4oeV5mCPuZS3Op9w/ZAp889hFZyoYEYBxgHJnVxQG1Wlf44iK3h4CErWzUlQkWDOfm22iOGsT4UOM2skPTQcYja9edJpesT6umrddG6tSYWuTFGscoASIZoEsidXzhvAafdP4vJEvqDUSfWYiABK0kkKAl42HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MagekP9N; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-349545c3eb8so5655841f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 03 May 2024 00:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714720415; x=1715325215; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dsTy2wNoWYPdaVbM1kcoJgd+KYE4tOPhm9nXcNIb/2c=;
        b=MagekP9NtBmNBXn7Fn1TnNIZQg1Mv+v810SS95TyfuraC7Gr/uPZY2KQFbcbz16wUZ
         WBX0uNW1C2pvPVCvUruxKTaNX3U+qPoRXt9ZOWxe3FcMLRJcYvCQUepqYPDoyv4Pfqyt
         a1bFs5sVjYWyvlaLR/zpvlODUounJuDHvKyyM3uBWEZVjkgm3AvSzuQJN94n2O9+wHvF
         MoYfcdljg2wyUWpg3BSVVqMssr7QdIMho2FDAWZCN0P8JKdv5Qy5CbZErgTMhtgpDLLP
         5cLxFWo24MTFGACUTRQDA8mKoz9H9jx1dBKn+6Bi27GaH82r3PfLg0iTt8s7nYZ+98Be
         mY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714720415; x=1715325215;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dsTy2wNoWYPdaVbM1kcoJgd+KYE4tOPhm9nXcNIb/2c=;
        b=Eh53MItlfqCcov2T4R34OAFwRzbEZImLvd/R6wAQRckYjqr1JDEn3kmkV6Fu7N7H9I
         y5hsWMQ6rFXd4Wbb+e+fVtlurZD43ngIoCXVz57F85sE4cBRxTczccVML1nCnulTs48O
         L5mg3upPI3kbMhgXWjJs4tOpJHD/6AxrSkIkPENb5dr4NEyYFBFeSr9+sQWvoMR5fcSm
         W2IrXEjUXUtvmcekS56J2S6Wfu3QwhTXCrPZIO3UxeFvexEa++VWr2763jh6ofVIJdSe
         nR8ndmKr6cpGI9sW00tygq5wH2M6BZj0qIQtMyYdSrCRI21sgiXzT8xob2LnZwCyHxmt
         tBDg==
X-Forwarded-Encrypted: i=1; AJvYcCULcIwKeRCVe2MNLE5dI3trSSu+mmhy5zGtKB1Qq3A4MB6pe6clowHtweIf6K1svgZgakB2DoF7cuiFtH5HFAuTFfU63Tx/9l6L
X-Gm-Message-State: AOJu0YxnzHhfIW3b57VmnNNBmdHFaa7ycz7xWbEJAkMwCUDagV6ob5WL
	UOiPIrCYuRB/+DHJOGfN2WzkGHgfGFx2N5rcSYt514KCOdLeoLKv
X-Google-Smtp-Source: AGHT+IHPoo9gjz2hGTHBUIRjj/RB3GM5uCPuEUSOQtTdbJp5trXxYAo4Fg4YaOTnSdUcI39Rgso18Q==
X-Received: by 2002:adf:f382:0:b0:34d:9d2c:8eaa with SMTP id m2-20020adff382000000b0034d9d2c8eaamr1407076wro.67.1714720414854;
        Fri, 03 May 2024 00:13:34 -0700 (PDT)
Received: from thinkpad-work.lan (228.red-83-37-7.dynamicip.rima-tde.net. [83.37.7.228])
        by smtp.gmail.com with ESMTPSA id h4-20020adff4c4000000b0034cee43238fsm3013973wrp.27.2024.05.03.00.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 00:13:34 -0700 (PDT)
Message-ID: <bcd4495c4dd988263acb257c0ccef27c7fe49020.camel@gmail.com>
Subject: Re: Replying to: [PATCH] iio pressure: bmp280: Fix BMP580
 temperature reading
From: Angel Iglesias <ang.iglesiasg@gmail.com>
To: Adam Rizkalla <ajarizzo@gmail.com>, Vasileios Amoiridis
	 <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Date: Fri, 03 May 2024 09:13:33 +0200
In-Reply-To: <ZjPYLtGAFtI5iN8E@adam-asahi.team.saronic.dev>
References: <043f2be49df3c11152aaf32fc5467ed43fd59faa.camel@gmail.com>
	 <20240502171616.154085-1-vassilisamir@gmail.com>
	 <ZjPYLtGAFtI5iN8E@adam-asahi.team.saronic.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-02 at 13:15 -0500, Adam Rizkalla wrote:
> On Thu, May 02, 2024 at 07:16:16PM +0200, Vasileios Amoiridis wrote:
> > Hi Angel!
> >=20
> > Indeed the datasheet says that the pressure is a signed value. But this
> > comes
> > in contrast with 2 things:
> >=20
> > 1) The BMP58x sensor does not have a compensation function so the value=
 from
> > the
> > sensor is a pressure value just in different unit from the one reported=
 by
> > IIO.
> > And the sensor is able to report in between 30-125kPa according to the
> > datasheet which are both positive values so it makes more sense to be a=
n
> > unsigned value.
> >=20
> > 2) According to the BMP5 sensor API [1] provided by Bosch, the pressure=
 is
> > declared as an unsigned value.
> >=20
> > So, what should we trust?
> >=20
> > [1]:
> > https://github.com/boschsensortec/BMP5_SensorAPI/blob/master/bmp5_defs.=
h#L895
>=20
> The pressure sensor reading cannot be negative, as the pressure range of =
the
> sensor
> is 300 - 1250 hPa,so this change does not need to be applied for
> bmp580_read_press().
> Also, the overflow issue does not happen with the pressure reading since =
the
> value
> read back from the device is scaled up only by 2^6 for pressure vs 2^16 f=
or
> temperature,
> so multiplying by 1000 even for the maximum value would still fit in a 32=
-bit
> signed
> integer. Temperature ranges above ~32.767C, however, will overflow a 32-b=
it
> signed
> integer when multiplied by 2^16 * 1000 which is why this change is necess=
ary
> only for
> temperature readings.
>=20
> Hope this helps clarify.
>=20
> Best,
> Adam

Crystal clear. Thanks to both of you for the clarifications :)

Acked-by: Angel Iglesias <ang.iglesiasg@gmail.com>

Kind regards,
Angel

