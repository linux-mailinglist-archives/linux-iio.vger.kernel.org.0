Return-Path: <linux-iio+bounces-13024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6799E1D2A
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 14:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C649E283A1F
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 13:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019331EE008;
	Tue,  3 Dec 2024 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CW2YU6Lx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32A1B0F39;
	Tue,  3 Dec 2024 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231471; cv=none; b=PEu1c7Ucch+Ya9FWXL9Q4XcuN/mYnFmgYLZsLgTQpfQL9DIDtWrX6IysJNHKBdmZRXA1pTmshGG3OeYEF4EouAKgPur6r5c7uTTEl8H3V3w4mhhhUzQvNuFsv+TiKE4/HaTifq4lfe6pD973z4Iw21nxavCn0ZyXB28oOK3Dp6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231471; c=relaxed/simple;
	bh=PX7Kj3kOKYVM7x9kcOPxqppRf5NJeDfCiB70Z5leLZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4hpypZUFpVcrnOMZ0rO5tVxuafR0SM987y+mi29+O0IR3xLrk8qvH00esB1qI6PzzzXAR9FH2wuH8J4uAYrTwAFuZNerVi5lLO2xoI/xllYUzJobjDfnRtI7BISBgAoIAoWRbNFNAutcTBqwxOJXdPL4O+lJbLG5irhWK7/kpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CW2YU6Lx; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53e1b955ec2so56984e87.1;
        Tue, 03 Dec 2024 05:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733231468; x=1733836268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdIUd16cnixnbU86FDfrHcPCxtLuUJ//gnjkcCsPHw8=;
        b=CW2YU6LxqtJw6P/rs6s4UMfUEzYXbge057+SKdxsn1xir0inAthHZDcWDwSvregtRw
         rQ1+tsnJ24hjJXq1+p1pDWYaRBm0RLw1n08a3w3RNGVbhWP/5C+FoKebpp190diCn3r3
         Y6rMC9p1Pyydb3pBuKg/nyqDlduc/RV6eo7KmgYP1TkCd51YrijpkOV5mXyHlA/xlvhJ
         PpYkrBvBiAFcNAEP+gtQsNWC+3FAB7EDIuAZRBBWxsAuyXBgn8M2byY1HETqFjtcsjZS
         IdMTgpeQj+JKfzDPIJujAiILYLXvynK6IlKv8uqm6o81Byy46CjOZvtlbjCkDuvmF98V
         CtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231468; x=1733836268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdIUd16cnixnbU86FDfrHcPCxtLuUJ//gnjkcCsPHw8=;
        b=cbwy6P4C2AaEW60VBIX3bJr6b7Q7hVs/aXmtkGk2cmb/gvT83n3QzLo+MhsFligi9P
         OgQLX4LTBJ86yPcmKFygMZBVO7DzFPCaDwCGg6l3q2gosghlj55e4MafWdj/IobC89lI
         Xyo9cca7iXKXaKqLf7ml+lA3ssEtzK5ROZJTtDOqV1ATUmb2MwESiT5nVKl46VBNUsUZ
         hINqqw+k+tCc77oUK4DBfwsBJQqaZ8ChecykCAaDMA0yLx+SitNwyluuAGCbNfXPCMst
         pbMcca+cti8JvEz8MmGzgtsINHN987SjHitSglOLT7I+P7BOV9OUqk5j/bNPi4Zn5My4
         U9pw==
X-Forwarded-Encrypted: i=1; AJvYcCVHyPI0HnDazMBBCADzDOP6ZVE9+V5T8tDuq7SOwjIvnA47okuC8DxgYtc0E2cNr2ZOz73xSNyLs9vC@vger.kernel.org, AJvYcCWPtsWh0XjY+P7/Ae1c39JAZ2jcQYtS9OzwjI06yf5E3fe4Av3QdC8u5IRAoekzfhVYjwwQzl8WmE54@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6KZyb7yUSw7RYVf3OhkFwmqZS8HwWBIx5aQ/cZFXAKIQr8LU
	f/E9SQNGaUO/KiEHM0Ov8NVqqgS1+p2Xib90gVcji+ka86qmyIlDcw6KwzzOogEwZB9utWOiJSg
	9fBVNIruexh24eV7W9k8i+B7/VX8=
X-Gm-Gg: ASbGncsYumZWhosb7uekZK7WbIVOEfnDq+UoIOu7I69pUhmkWF5TaFS8/aLqWrl5Gjx
	n5G4A2nbmddbU/SV1z6Dl2enPl36fncY=
X-Google-Smtp-Source: AGHT+IFrxKMg6+wAYn+dYmFr7LVZ+fSHo5YwtxbzqPd0zeaUWJdhBy5orM6cTta83ugWrdPZrriDCIdAlwnMj3aMCDs=
X-Received: by 2002:a05:6512:3b96:b0:53d:a000:10e5 with SMTP id
 2adb3069b0e04-53e12a216d3mr1285763e87.46.1733231466763; Tue, 03 Dec 2024
 05:11:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203110019.1520071-12-u.kleine-koenig@baylibre.com> <20241203110019.1520071-20-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241203110019.1520071-20-u.kleine-koenig@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 3 Dec 2024 15:10:30 +0200
Message-ID: <CAHp75VfuTRDAjOD73re8tCWWJsAFUq_P6hPiPd4j_mOFM8oKGw@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] iio: adc: ad_sigma_delta: Check for previous
 ready signals
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Renato Lui Geh <renatogeh@gmail.com>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, devicetree@vger.kernel.org, 
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Alexandru Ardelean <aardelean@baylibre.com>, Trevor Gamblin <tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 1:01=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> It can happen if a previous conversion was aborted the ADC pulls down
> the =CC=85R=CC=85D=CC=85Y line but the event wasn't handled before. In th=
at case enabling

Interesting use of Unicode, but I suggest to avoid it when it can be
avoided, i.e.
using the notation of #RDY_N might be appropriate as that is how
usually the HW people refer to the active low signals.

> the irq might immediately fire (depending on the irq controller's

controller

> capabilities) and even with a rdy-gpio isn't identified as an unrelated
> one.
>
> To cure that problem check for a pending event before the measurement is
> started and clear it if needed.

...

> +       data =3D kzalloc(data_read_len + 1, GFP_KERNEL);

Yes, I know that's not needed right now, but would make code robust
against changes. I'm talking about using __free() here.

> +       if (!data)
> +               return -ENOMEM;
> +
> +       spi_message_init(&m);
> +       if (sigma_delta->info->has_registers) {
> +               unsigned int data_reg =3D sigma_delta->info->data_reg ?: =
AD_SD_REG_DATA;
> +
> +               data[0] =3D data_reg << sigma_delta->info->addr_shift;
> +               data[0] |=3D sigma_delta->info->read_mask;
> +               data[0] |=3D sigma_delta->comm;
> +               t[0].tx_buf =3D data;
> +               spi_message_add_tail(&t[0], &m);
> +       }
> +
> +       /*
> +        * The first transferred byte is part of the real data register,
> +        * so this doesn't need to be 0xff. In the remaining
> +        * `data_read_len - 1` bytes are less than $num_resetclks ones.
> +        */
> +       t[1].tx_buf =3D data + 1;
> +       data[1] =3D 0x00;
> +       memset(data + 2, 0xff, data_read_len - 1);
> +       spi_message_add_tail(&t[1], &m);

> +       ret =3D spi_sync_locked(sigma_delta->spi, &m);
> +
> +       kfree(data);
> +
> +       return ret;

With the above this will become just as

  return spi_sync_locked(...);

--=20
With Best Regards,
Andy Shevchenko

