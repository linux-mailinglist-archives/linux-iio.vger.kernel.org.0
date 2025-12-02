Return-Path: <linux-iio+bounces-26649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A0DC9CAE8
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 19:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18533A74D3
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6094C2D192B;
	Tue,  2 Dec 2025 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK4aE4wc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEED23E229
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764701297; cv=none; b=h5RLmSFgEQjUzrjbh5LLMPoPutuam/D31vWAtMJPEIfM/E5CarjP5JyTwy+duuTTDxZ8SmO/X1+XihYsBsWpWbqfXHNClr+8U9t/l5QCt19v7WQPf14MWYC96HZ50EFFBDiEMbKHH5PjAzqv7xMq4EIfsudbrdoZSKFO61qK4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764701297; c=relaxed/simple;
	bh=qmcfhShQh6q6Tg47kHVH1nCSCPnOjgsMPs/kyL1Sick=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJNcmCfLQ1q+8lc9heBng4ProvyVe9WrpFX7fw1nVrod2Ux/9JK98hw4NPnL6TzoT/qAqTGZmVVWek1bTdE2lLZoHntNnVu8CJ+5FoMaGcL5ZuuqDvSJyClVMdjtde9yXfHpKl3kxtycub82+XG3YxkR51rR8GarpxaGRkR4rvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK4aE4wc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b770f4accc0so786446466b.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 10:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764701294; x=1765306094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YK2nhrM29O2hgg2Ta9uM55oXWMLeg2yr8elEf68PO2E=;
        b=FK4aE4wc33gtpKoj5VGypbgR8T+2ecMIE0VhF+9S3A7zr7e7wVqR23rke+VLuRmRE3
         bcbTr4skPBweB3ZLW5fwzUCNvlUznpCHf9ybqnSSblsgZPx/XOGizIOBV/caIOvD9ceF
         8hVt9ZbHdmNY3FyAp7d94iI0f03btXlWuKT64gTmx/s4Wv437a0NNzneKb1QWoHpOro1
         X2STTZk6lhQ/+rdsCCOvkG+zFydyKbUW7V10n/KTQG+nJZ8QP2aM+I3ToedhMtJ+R1lm
         RTf1dKf5VapzdsIfog1TFpF8YRn4JBVgYeJk4bMJPcGBkU8MQtfy6l+uXq2PibmQo/w8
         Ee9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764701294; x=1765306094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YK2nhrM29O2hgg2Ta9uM55oXWMLeg2yr8elEf68PO2E=;
        b=FfNgbfoes/RTJJEPCMMM7zxVnGfAdzFueJCGDempci3hL/xcjTuiFa18XurNcmSek4
         Qt7bClV0iv6+RJnUy6pLo7IcSQGle6cjp3zn9hgdtHxl4p/O940MhbW3JFx7giphezf7
         A6A/WlvLThPF3GJ9yUUwmJ6qv040XAkwub6Cn5iGBWPXhIGSKupFhTVh6Ox+gbJDiAvP
         gKvPbXU1GMvz7vls4wrx9yLZxHZv69ixnlc/aNCuz1Y97JySEfzVHRF0QIMuojT8W9XC
         aQsEiOLOI02LlCsDltnRZlrPDstS0BCb+tHYVfR2f97gfjVinaTMy8qkoKzdKrzoCFHM
         h4xA==
X-Forwarded-Encrypted: i=1; AJvYcCXqMCXn1+V42/I21zEw/S7+3Krz0VD86wKK5zZW6hPPYJT7hVjNUZnBvdhs1Xovcc10CzG2nq5Cf3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8+HVqWYJhlSykiudrjteb8d8c9r9prUU+aqaspkh9bJlM4eHx
	1Le+JowedhLkDzMDW/1vmGYVgzzICYZHWoR1TgXwlqGh0arYPlaFSAlFJJKhbaQeTvc4eianPP1
	L2wmUFRb91W9rCI2ROBQpmGC1stcwd4I=
X-Gm-Gg: ASbGncthBOpibrfA8R3BJQ0zoSlMqJb97NTm7M4IyJVttk1K6Xrh2jNfd4/hHnjniEK
	TTpxXZsGz91tobg3pRqSW6BoVQ5rVQAjLCcNM/2qHqJhuIs4lZCx6QXBbtzGXEEljT0VGqF1hD0
	SqkpT3E/JZ9IYvpFzX6oDM+kcd2CF5uJ2HBZXRjtZFtX6qFkea2UXClRJhp5a72R52VBaPAivPT
	Vagd7/J6b8XvmGfz4JCTK9/TjfqQSN+0kwcqDMFboFRhaIdKRny3vOAPLTB4SYy/eXIbeF6ZN1i
	YwzxPLZOdUEnwsqCZ9mbfH1PMVIRTMspa7iNrWs7gj+u/sXWD6zqQZ/NabeooXQUULJ16dPZanv
	LTA47bg==
X-Google-Smtp-Source: AGHT+IEde5Ne2FWmn/NCQ+IRx4n/GD9c9A5QSTODzTd0KanvaOIf2EO3FmVJ55kB63cvLDvHqezaxI6V2mbDnsSWA4o=
X-Received: by 2002:a17:907:970d:b0:b73:8cea:62b3 with SMTP id
 a640c23a62f3a-b76c555d4e4mr3503240366b.41.1764701293826; Tue, 02 Dec 2025
 10:48:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202181307.510970-2-thorsten.blum@linux.dev>
In-Reply-To: <20251202181307.510970-2-thorsten.blum@linux.dev>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Dec 2025 20:47:37 +0200
X-Gm-Features: AWmQ_blkY4KethoMOw3VYF_HN2LLZpgOJNsEjED8qY3jBtSrhG66YIa0fXVjIf4
Message-ID: <CAHp75VebjUo2JH49tmuOvgjKUbsUmZg0C461wwvL-bRaDd5C9Q@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: PAC1934: Fix clamped value in pac1934_reg_snapshot
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Marius Cristea <marius.cristea@microchip.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, stable@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 8:13=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.d=
ev> wrote:
>
> The local variable 'curr_energy' was never clamped to
> PAC_193X_MIN_POWER_ACC or PAC_193X_MAX_POWER_ACC because the return
> value of clamp() was not used. Fix this by assigning the clamped value
> back to 'curr_energy'.

...

>                         /* add the power_acc field */
>                         curr_energy +=3D inc;
>
> -                       clamp(curr_energy, PAC_193X_MIN_POWER_ACC, PAC_19=
3X_MAX_POWER_ACC);
> +                       curr_energy =3D clamp(curr_energy, PAC_193X_MIN_P=
OWER_ACC,
> +                                           PAC_193X_MAX_POWER_ACC);
>
>                         reg_data->energy_sec_acc[cnt] =3D curr_energy;

Hmm... Maybe

                       reg_data->energy_sec_acc[cnt] =3D clamp(curr_energy,
                                           PAC_193X_MIN_POWER_ACC,
                                           PAC_193X_MAX_POWER_ACC);

?

--=20
With Best Regards,
Andy Shevchenko

