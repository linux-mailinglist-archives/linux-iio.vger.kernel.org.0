Return-Path: <linux-iio+bounces-27375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 712B8CDFF99
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0271C300AC74
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA9C1F9ECB;
	Sat, 27 Dec 2025 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFJde1+s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DF63176F2
	for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766854368; cv=none; b=UFmeKCI63zJTP+7HhIfpmsyIgO2a5Z9YaVUuG4E1AiLQuAbIXps9VbnQXkgYVxT9C9JOf37Zkjn5zlaTJToMFrTcDEDR9uKWG4NuVOSQszFaEpafCmcXhIPCjFJ/HIXC0zgrkZLVakd4gRFqI49DNhfuwUXI6Azactf9ZanS6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766854368; c=relaxed/simple;
	bh=1ZwK+wAyCuHdLpo3w6EU9PSTuqRx5mpl7sISQoLB108=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXvDA8YI/viLQlh7MPqfZIItWnzbltTGmdTpr8V9p9l7Bykatj+EXhoJ9c01Wi1I6Mbk4ln6aY3YLuSiaPWjxyBkn/rsrt92iBRFptMziMi8fPJyO+fPzDUYo91K3km6FzZry8MliWIpDK2u3rwvBm9oL24tpDSddCasKv/suHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFJde1+s; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7277324204so1196850966b.0
        for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 08:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766854365; x=1767459165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tfko82dcCqms3EGQSSsEEZFat667ouuyFTNIUg57/80=;
        b=hFJde1+sA9TJiAbVCSmnuQ5RnCxf2tR8jHlaOOidzccIK2jwTwvtPTLFY/7c2lAzd+
         O+ohKSpo+rs5fylszs8uPFEu5aH74fn1Uc52JuYJ7S03hr+XUSlXdH7gOvxPWcxI8tlg
         2VEgilZy7/N1nFqdKYFWj+3+bwqpc1wRSI1fCyXyuBhKephwfa9ocOR0ZcoL+Edh8MJF
         hsgz9VGKqnZB/vgQaqDKmP8O+Vm6ONU+Z66rXG03dH/Tz8vldUEcJ09jr/ziX9WRuODN
         JsKk0OQthtLBgQ+IPtIngLYczU+HC0HwSVhJRJI7DtY3e0fFjDnOXzRWusvvYkDUzJnM
         wnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766854365; x=1767459165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tfko82dcCqms3EGQSSsEEZFat667ouuyFTNIUg57/80=;
        b=CDukzaLnxQ0R3PI2GDlOhGkR+WGYG6cYAmtDG+6o8acPEtk8dCjkBWs4fK5j7+JlfL
         43CAbVRrDMC7zna1YU2V8HR+AD3BFBjXFRwfa+j7ryWcwyJ5Ki++5i1IEYVtBHF7kYkJ
         pwrFZas+etdST69RCMAQccPAwQMoWDt43iMv6lMJtmq4lnhuW530YPw54URT7vWRPBMp
         k2623z4pPLoUEvX/QLy21YffBkxzKys02O3z/BMqaTbcA1xMt4Sf6D7VBhaqIvkFaYUk
         srIuahNFtC/aHQo5nMOuhEkvAZOZsXo7d/yQ6Ec+CWzszz1QGvaLVF8zvcfcbJ8dVe/H
         Rlzg==
X-Forwarded-Encrypted: i=1; AJvYcCXT73xcMvttd/BcBLbYR4IpVCILoyDbwSyOBqiusoURJ57o3zb7P2kp9Dkw8fIQsf4WHJIj0OsoxlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7cXsX6VItBZ1C4b8VU48ahuI6iCkOMIl+eCoIBYJINQXAnjh2
	KVNdPl/8xt7siqZXSL3JGqJ0sJ5N5nsSa9kA0wLuTpSYMTCRCVXz6J2EUlS6vuewJ60iEuZ6fL9
	WXqD+79FS7fzHGIBz4OSDt/IPfGoiaJQ=
X-Gm-Gg: AY/fxX5FsMFH7idszw+5GWxX0TEYr09SuKCoIsQGZSYEMy8OQygho9zoztK8Q138pCY
	I4fq/0pVnS+diAR1eXC8w0uVLYpPiAja9yIaDQ9ZooA0y0jqf7Sq2NBEqTwJe4ZFEwIsmpNhQLZ
	F2zEzoEjFO1pNwUbSuGRV7cNCYAfn/j+6LMjHpHgL6bmLinPlYH4QcBx7cMKXjwIZvQpMTAgtck
	kgd9wFhkHLBu8R/DdUKid2l/VeUkKQf7fkpFPXnBfwfMM6zR3X5Bz5VaiG99XoB/aaVLn16ql2W
	eoPm/YG3W+eZ6bMj8G85oktIS5mhI33+cimkuLJRsCTBGGV79U2X4XNyYi5IOK4zYL8d2sU=
X-Google-Smtp-Source: AGHT+IHyc9GHB3NOo9q3FtvWIyYw5aAM3bk1yG3iQDjrxwwHCvES93NIb5cEaYnYu8QRDYsv/VaafxyYjpFPsTGHR7Y=
X-Received: by 2002:a17:906:6a08:b0:b7a:1bdd:3313 with SMTP id
 a640c23a62f3a-b80372a42e6mr2337659566b.64.1766854364796; Sat, 27 Dec 2025
 08:52:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765900411.git.Jonathan.Santos@analog.com>
 <43504217d5b3c32da946bed0ce4d81e216f7c7c7.1765900411.git.Jonathan.Santos@analog.com>
 <20251227155525.6d712f42@jic23-huawei>
In-Reply-To: <20251227155525.6d712f42@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 27 Dec 2025 18:52:08 +0200
X-Gm-Features: AQt7F2q__7-ZAKBOMsXdfdCmh6DRPyEzp4KG6I9MVj4PO6swIFIJeYEXUCC2Rg4
Message-ID: <CAHp75Vd0n+aTkdzMC53y9LrPW4t0mckpzmmud4Ez5gXbAdLeVg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] units: add PERCENT and BASIS_POINTS macros
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jonath4nns@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 5:55=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Wed, 17 Dec 2025 02:52:45 -0300
> Jonathan Santos <Jonathan.Santos@analog.com> wrote:

...

> > +/*
> > + * Percentage and basis point units
> > + *
> > + * Basis points are 1/100th of a percent (1/100), commonly used in fin=
ance,
> > + * engineering or other applications that require precise percentage
> > + * calculations.
> > + *
> > + * Examples:
> > + *   100% =3D 10000 basis points =3D BASIS_POINTS
> > + *   1%   =3D 100 basis points   =3D PERCENT
>
> I don't understand the final equality in these examples.
> The top line is as it says 10000 basis points but you have it equal
> to BASIS_POINTS?

Also there are pp (percentage points) and others like per mille

https://en.wikipedia.org/wiki/Percentage_point (see "Related units" section=
).

> > + */
> > +#define PERCENT              100UL
> > +#define BASIS_POINTS 10000UL


--=20
With Best Regards,
Andy Shevchenko

