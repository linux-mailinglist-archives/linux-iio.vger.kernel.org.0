Return-Path: <linux-iio+bounces-22284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C51CBB1A2F1
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 15:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF033A3B1B
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 13:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8B625F7B1;
	Mon,  4 Aug 2025 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8WqNx0D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F252459F3;
	Mon,  4 Aug 2025 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313245; cv=none; b=BiORGWrk9U/oIKmgrOUps8ca1tL8IDSGMy5/6b48QCU9CJXhcsRgNMrlOLptwPwuKnRHdeLtB/JvU9JQ9vw3c/jMTvs48P5teeaXB5xERRZrDFdu2B7We0fRN2hjkHYvSHx65VQ2JmDQRPlu5xEUYbYmHzLlG/HWzNqoe1lmTCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313245; c=relaxed/simple;
	bh=q3CUHsU8F2952jCSX7QP7ftAC7i66p+G21KBCduYZNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAUzXpJKKJLSyy1UtjVNFMbLodZBsaLpO/zUF9Z1CLK6sxgraMKGObdH6ENKaZ/yOdpcNCEFpzp2vrzI+qdiT8/CIKDIFNXcKpTHIw0WZ8lFkaeV8Po5fxQ469SE8fQAoUFC5oFyQpqf9a1F/tQtPigv+hZVWs+eyFeKwiJ7Cn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8WqNx0D; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af96fba3b37so132592066b.3;
        Mon, 04 Aug 2025 06:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754313242; x=1754918042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftN/XcZ/dByaEVn0cn0BMSamQ3LUIZlb3wXtmtnhPG8=;
        b=A8WqNx0DMYlWumUMzDV4eF1b6+mMH9KUcxEw10gl4rl/kw2bAyMq1PltKPIEnWu56U
         /aVfipd9LnfZRTQdQZsXu4LsS1w4KHkl6E/QPCarcsjG0P1MryD/92Ei4dFGnEni+Eou
         Hm2bgvmDF2oWJMKPM/z8/pYxigSL1a7DvnCUGpODJaGoTBhciBPj6MMvf/COrmJmlGCt
         Jf7zsxVNmIci4mdzWsUqW0fklWRokRqlrdO4ucI/iSN1F1xgrWFZ06ZJihmmC2xqFp38
         hxw9bTbUk8bFPVxwbgFi3/ptQpwO9TolH9TeB6j23fkaMIwrdXpmaMx8Z7cKw/4XLMP+
         JA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754313242; x=1754918042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftN/XcZ/dByaEVn0cn0BMSamQ3LUIZlb3wXtmtnhPG8=;
        b=G439KzzsMDfpylZ5mLZ36FrYNTMu/g6VlMH9epEVEDRt1pLManJq+AnI9HpgRlnEZr
         lQZNOomCxmoPiRktkVFgS7vh7lqWh9q6jZH6Lwvnjhynarll6I7x8bcsvFNLQN0xD2eP
         QMrAg0WyH9fETNXs7oVtrc/XTFGpJIdyCJ9Qr/4JKn51IOkJAX12MZSJkxvdMlcSzEb9
         eGFGSa7cqjcjX4/7HYlB86Yaj9hLQEdlrbEipaGVuZxWr5Aw37dFDVrbvbScWJ89mu4z
         8xlWPwxnqYrMPPPY/JYvAEM4YjXShW1nuDoN1VDD+rHTvNy6nq3K0404VLbAsmLuWJV9
         nwiw==
X-Forwarded-Encrypted: i=1; AJvYcCU0AluZ51tBa9Yb4UmOcdsPBbAxxAksnHgSELoJfJFnwVqq8ZrSRdVzBTIbPW1QQz4NkyyU4M8DpRqqaoxL@vger.kernel.org, AJvYcCWM7USOqGAwZtzj0s0Bw/dnQvzgvB9xw7sxEhQhft3XZOAINZd+c1j3ijj1KBPBjcRyet+8F7438vp7@vger.kernel.org, AJvYcCXlQfqCDhPYTOpIfXdfBVpqv+g6DqJMaf7nrJjus+/9fdBCzB/PpGajIoXiCypzTmr7lXm8rWJo57BG@vger.kernel.org
X-Gm-Message-State: AOJu0YwxvKXFubfohqQkK0Fld3L0O2faXdh/rGTdMd2qV1RwdQBejEOe
	xhOrZn8ZA4WhHDcmQTtk/mJRRG5lePbBgCKIKAKJ2jOMQZytnbxROJ+GuyodTV8fDhH7/Gukz0p
	TH1VgEq+VdIhQutlWFISuN6CE80mVFBo=
X-Gm-Gg: ASbGnctuV1ZKr6dBzV9nx9s79P9DEwRK1OukCEPGXnbQK9Zmpbcn2mW+8bUsYYQPE3n
	Drry4AkDNWDsA9bGNmVOwn+4Fkxr5J89nIM64VttxaCsNVyzWvS5/S9+PAfmonIXmipZiRe/VzT
	gi3rjhRyMxqMBgmu3842g7MTepeA03GbtF0+yAah/NT/qSWwyCwLJWRg51zQATAox2f4bRTurCg
	uDx1d2wSg==
X-Google-Smtp-Source: AGHT+IGBeqfw3fvLlvAcAw3BpTqiuPXA4J2h3pDCZNywn5w7ddqZQES72AmoaGsmtljDcMeac00/ZeSQ68zvdeoNgFE=
X-Received: by 2002:a17:907:1c12:b0:ad8:a04e:dbd9 with SMTP id
 a640c23a62f3a-af940187873mr985057066b.31.1754313241498; Mon, 04 Aug 2025
 06:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804100219.63325-1-varshini.rajendran@microchip.com> <20250804100219.63325-8-varshini.rajendran@microchip.com>
In-Reply-To: <20250804100219.63325-8-varshini.rajendran@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Aug 2025 15:13:24 +0200
X-Gm-Features: Ac12FXyCmSYVvYJxjx9xn913aCGsLi-yBSTMjwEVe7Qv7e6k9dvmsncWqL8ALhk
Message-ID: <CAHp75VeGbB6kJF879LmDu9X1kcNydhSZo=h4wyUeVHw_WWKBew@mail.gmail.com>
Subject: Re: [PATCH 07/15] iio: adc: at91-sama5d2_adc: add temp init function
 as callback
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: eugen.hristev@linaro.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, 
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, srini@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 12:03=E2=80=AFPM Varshini Rajendran
<varshini.rajendran@microchip.com> wrote:
>
> Adding the temperature sensor init function as a callback function.
> The temperature sensor initialisation sequence is handled differently
> for each platform. The same is added to the platform data of the
> corresponding device. This allows us to handle new devices like
> sama7d65.

...

> +struct at91_adc_state;
> +static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
> +                                    struct device *dev);

Isn't it possible to avoid forward declaration for the function?

--=20
With Best Regards,
Andy Shevchenko

