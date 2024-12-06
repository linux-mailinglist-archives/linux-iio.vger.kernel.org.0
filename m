Return-Path: <linux-iio+bounces-13192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D769E7C4C
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 00:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E623A1614B2
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 23:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A66212FA4;
	Fri,  6 Dec 2024 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpR2IZhn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D961BC07E;
	Fri,  6 Dec 2024 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526816; cv=none; b=pOt1LNCEL9CIpO94OONRwhZhtbmf6GcA9iiN8S0eOGh0tSDXLM+w9jEok3Gjbp9Z9qAUJGGqLHUqAJPigofrSg7bjh0ChZ4gbNoq7beGjtbimwP8W9WVAXtqG+45ne42CDtcXuTOBtL3lrHFMEGeiG+GiepU9hiliqj9YkMPndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526816; c=relaxed/simple;
	bh=3qxp4aqBbO5r6azhlFBf93yYcyvosRJNFUC8ELQQ87I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Si3btzC+mt6FIyWAhoXa0E5WaQlyzFPG7xlHcIkfU3FKEPEW029q2/Kdi84ZdDI0CJZ+sSABxdY4Pdgx/PFcyEhY+IyRFRiiR63pgerS2Qo6GSkK4Fg/RIZelQyjBYjsjJDZXC7YLr4lFdIF3ndZMoErnnuNXOdbAbnFZZlOqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpR2IZhn; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa543c4db92so511684766b.0;
        Fri, 06 Dec 2024 15:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733526813; x=1734131613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upTIjMMKLahs+IiyuFRN+3jVze1ah5UJhNZodUgjzy8=;
        b=PpR2IZhnE94bWFgK5XK+qG5B4ifjVvxED55ZsLXstUPNBZ5+zwyB+82fWqLBnr1ADC
         nGIFd28RAVYa85wNOW3J/0qFqCVIteD47BMCK0laywXBfUYHtIzEyDlF+OFDPFCutlJl
         pQaY9PvuQ0ntzJxfRmokXCFBL4lLGj3oFTTpOVUETDuZocdfaQNkC9CRGqILEzZGgsDq
         t0kQYpcvV5IB2LhPikNSaTZy4VHGkhxDes6x61T/U02LkqVIBck4soB8WBp3ZV1ePZAy
         1VtkJniw0cocXsdi9ssf+SS/Mug/RSnaJZnq27pn2lDzjIFXElG3m7f707saeoUZj7sZ
         7i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733526813; x=1734131613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upTIjMMKLahs+IiyuFRN+3jVze1ah5UJhNZodUgjzy8=;
        b=ABjnJEE6K45igBMwtgz3l7gQ1QGVw4ZWYyFegnzNcVn5BK1nfoNXe1dVrWNTx6YsRu
         uEH2YyblRiWO8x9YmS3XNoz7o65mCBJR+GuR8ZUr+aT7D31PRKix2IE6mQD2GtAiiFPE
         21AcOuesFZdooN5R4TcOeSEQq9sUanOch98E2G7H7cgY+urq90kuiwQAB3PGOgcH4jSY
         AZ0IQihYwNjYzK/x0/NntR/q4k9wzpOLQQgBskLHd7rLahhgt7TjijeW139z8ZbdVbav
         /vFs+vy+qSva8acrW7dKVRTxRWFSa7N+TKZV4bR2J4DxL6HrZqwLhaugvqJnuXh6k1bq
         lwlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl5hyKcUGG/fOjD4YiFbDN/xZWdlHo4P9Mk4wA6pnkqfDf14B+3xVFM5iwhtD08JJCXnkIkCGad2py@vger.kernel.org, AJvYcCV+s9W/cGKsFAtJBWvhV1JhPPOv7GZAObyFyBHytSr4oxjIm/114wYvJWbNLcnODjjEQWuxt4n2IKSU@vger.kernel.org
X-Gm-Message-State: AOJu0YyA3/SKdZ0NkLfJj7uVwLVpblK5WaHYYKnGauQ9YjWky7OHoQC1
	gw4VPA6y0Ic9eJVqVFnyJtdTi3FgAYYTnCOaWf927WKOKUSG/zC/uUkX9HelPSjt56QDVyx8hqP
	PqOYhsT/RrXfbd/qqrtAOUgbaXfk=
X-Gm-Gg: ASbGnctxBRRMokNuOyVMhk7XmJzGgM3EEWLCz2SofVRsaF4DP13biz0deUG14KbFj4d
	cg8tQrZkH9i2b8UJPg5y+2sMPcumEiBA=
X-Google-Smtp-Source: AGHT+IHgLjSZKrTX04ELF0TVjdTNAQeEsfONk30jyw1GJ/6NidagyUCS6W/vXUUWhM0ex63p39o8cmqGqxWgWkCZgrU=
X-Received: by 2002:a17:907:2918:b0:aa6:4731:5c26 with SMTP id
 a640c23a62f3a-aa647315ca2mr206903366b.29.1733526812954; Fri, 06 Dec 2024
 15:13:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 7 Dec 2024 01:12:56 +0200
Message-ID: <CAHp75VeS3W7zjzsdSLQhmo6yj6ELyGR6muT==kAdXaZ0ZktDrw@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] iio: adc: ad7124: Various fixes
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Alexandru Ardelean <aardelean@baylibre.com>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Renato Lui Geh <renatogeh@gmail.com>, Rob Herring <robh@kernel.org>, 
	Trevor Gamblin <tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 7:29=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> here comes v6 of this series. Compared to v5
> (https://lore.kernel.org/linux-iio/20241203110019.1520071-12-u.kleine-koe=
nig@baylibre.com)
> the following things changed:
>
>  - Rebased to v6.13-rc1 + 64612ec9b909. (No changes needed here.)
>
>  - Add Ack from Conor to patch #3
>
>  - Fixed how R=CC=85D=CC=85Y=CC=85 is written. This was wrong before beca=
use the overline
>    char must be added after the character that should get the overline,
>    not before. I got that wrong because of
>    https://bugs.debian.org/1089108. I would expect that now this is
>    properly shown in most browsers, MUAs and editors.
>
>    I guess Andy still doesn't agree to write it that way.

Yeah, I prefer a solid overline which Unicode simply incapable of, but
HTML does.
In any case the representation in this version is much better than in
the previous version.
I leave this up to Jonathan, but as I said an electrical engineer in
me is not satisfied.

> Jonathan,
>    would you decide here please? If you agree with Andy I suggest to
>    replace it by #RDY. Andy suggested #RDY_N which I think is too far
>    away from the original name. If you (also) like R=CC=85D=CC=85Y=CC=85,=
 just keep it as
>    is.
>
>  - Fix error handling in patch #8
>    I just pasted "return ret" to all callers of
>    ad_sigma_delta_clear_pending_event() before. Now the error handling
>    matches the actual needs of the context.
>
>  - s/irq controller's capabilities/irq controller capabilities/
>    as suggested by Andy for patch #8

--=20
With Best Regards,
Andy Shevchenko

