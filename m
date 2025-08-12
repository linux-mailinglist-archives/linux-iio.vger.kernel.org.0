Return-Path: <linux-iio+bounces-22637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E71CB23A24
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 22:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2CB02A77A8
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 20:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716072D063B;
	Tue, 12 Aug 2025 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf0oicVR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57D72D0630;
	Tue, 12 Aug 2025 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755031494; cv=none; b=H0YuK6Y8sfGqN5aDgyGc1V53YkYrM1ff8H47PFZi408ILY0iwcdOIc3Fw3sqxG5MdypDktUnTJVwu45CkiCdP6L6CYl74XKH+7at9Od6uy5Mu6j9NqV4grqLkJ2btnML46mD6sOtFfRCTTPGnznzc+mEOO8QVjj+LHDIwanp1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755031494; c=relaxed/simple;
	bh=aM7e/+KGd/V2NUzE0oUSN1/mfJjNn/37TznCs0kM4lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IpDLXrlQWSAZLH7pSxT3IARrwXNaQ+gYlEt+XToaGD7ub24AHMC8P+ngSqAaKQ4jF4yR/alDpT7rN6wWDaVPLbT6VvHNBPWNE2YRFkhLYkUXbNUg3gxS2rvqH4Ejkt0MKuBkrVHm/EDNEldujmlEea1F2aMQDPbyi5q8p9IWUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hf0oicVR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af949891d3aso774091466b.1;
        Tue, 12 Aug 2025 13:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755031491; x=1755636291; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+88F9Gm7HjgcLdQMszLxthtdJLA8x/2b7jcYJOgu8ks=;
        b=Hf0oicVRZ5RbkfXuZXaRZCvJ5mVIf+pvKbOwFI/4a1+B7M1HhrAwz655Aj0Y6Pq/pu
         voAgHNDYK+AgRjbyI3vBcu6+R0nJw9vTvWPOsdISBCaz5xvnWMizQ98fdIz/XtywPHL9
         NaNMbcdO6ytQUZXUpj1pipMgxqyLtYZzXedt4jF6OpN0OTKwF9NvyiPMlIx8UpViBUY7
         /QOMMwHUc24hYzgQ1zCzh038NHEWnOfNa4UlPFlGFrC19py62Cq72tNERxA6dc+weBC4
         MfzY4I8h+StfXyBnswixXEPH+AwAnp6rWlqa2XPXzh6hGC4eELlMBOzsS1fQstYeKbQL
         HgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755031491; x=1755636291;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+88F9Gm7HjgcLdQMszLxthtdJLA8x/2b7jcYJOgu8ks=;
        b=hrNxEyDQvYexSZWJf67AYBMkyV/zvqRqVojifu/WZGjjy4RtMwaubtV4+av91KcvcC
         /pArpHcNGenqq7QoE4yX+GCVRryRI0P1jWe7w3ggnQ+lENUboxvdWvSc+gGRLQ13pIxW
         oIiEPRrPk+OizI3g36Pl0cF+nmagPDcrXNbVt2pzel0aqicla822/9eOc+RWiFHVuhsg
         1D54BoLaxG9nySng14ZCfuRcaaUCklYkW/yTNtzMn/YxV+Vak/KzAb2p5pez5btFmYDq
         uXBV2HpWDyIXM080QOLGziCCAaTv3c9AVKGaysMBnGQYMLN/0xbr2bzdq6A+mawrkasT
         8lJw==
X-Forwarded-Encrypted: i=1; AJvYcCWQcsEL64x56RD2hGFTgyvKrQfSdxUH69CniemNCa3HJ4sWd9m7QC5ZHk3aBwUCnnswKl1mp7mBkk4FPz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5NStwlcs5m9vHsDBsuY4qb+XKod+AoLoR9Y562f4iGbFzS5h5
	P1rxSypbme5cfKcGP/GCgUDmzUph4fpBA5kyxKBZReylJvxqWbercF59eHzQorm+xxZWC4gZAsM
	sYyxjHgWaM5w/rNYsaOYIfRMnYOYs3BzefNekhRQ=
X-Gm-Gg: ASbGncuuJ9epQpNs9U04ML7b3OQrCJwDykI47No5SRPOYelmZhRngCCe/Fkux7wVq8b
	Pgai/qge4lnq//TK2oDaYAGfDch8oPKzi2rwpIsBqTHLrzwl4OYmiTF+ZEFeFjU/XGkssZrqFMv
	WvogoEMxo0zx6mcu836TgKCl114B/7r2HpNcT5RuUpEMzl5zWoJVPoxdRJO2qwMvbFztK9fk+RU
	JqILIRYl6VrfX/Trxgk
X-Google-Smtp-Source: AGHT+IHIeB78wRTRLKkqGIVkelwFbSK4trU/vb/eHIDUc4pSTuzhiQ+g9ieLFqmgf5MmRobDdsd1L8raj+AXeTD/Kws=
X-Received: by 2002:a17:907:720e:b0:ad8:9a3b:b26e with SMTP id
 a640c23a62f3a-afca4e7bff3mr54468966b.56.1755031490617; Tue, 12 Aug 2025
 13:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <vidvwybkm3vwmtopihyaj6tlvswwa5ixmgptfzpk5ujl2ixjjb@olz6275ftabs>
In-Reply-To: <vidvwybkm3vwmtopihyaj6tlvswwa5ixmgptfzpk5ujl2ixjjb@olz6275ftabs>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 Aug 2025 22:44:13 +0200
X-Gm-Features: Ac12FXy5VFecznpFfU8oJaKReQiI6cskrCzpCHFLPLyOuiB7eLW82u-0ssh26DM
Message-ID: <CAHp75VfQFN+F0xMyhWvHOejD0AefDfBLf9s4eu1bpqCBY7bkdA@mail.gmail.com>
Subject: Re: [PATCH] iio: iio_format_list() should set stride=1 for IIO_VAL_CHAR
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@anaog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 1:13=E2=80=AFPM Ben Collins <bcollins@kernel.org> w=
rote:
>
> iio_format_list() sets a stride across the val array of 1 for INT
> type, and 2 for all others. Add IIO_VAL_CHAR so it also gets a
> stride of 1 assuming val is an array of integers with char type
> values.
>
> No drivers currently use this, but I found this issue adding an
> avail callback for IIO_INFO_THERMOCOUPLE_TYPE for a driver I'm
> working on.
>
> Signed-off-by: Ben Collins <bcollins@kernel.org>

Please, keep the Cc list after the '---' line (note, you may have more
than a single one in the patch, hence you may just add it here). This
will reduce the unneeded noise in the commit message as the very same
information will be available in the email headers and in lore
archive.

> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
>
> ---
>  drivers/iio/industrialio-core.c | 1 +
>  1 file changed, 1 insertion(+)


--=20
With Best Regards,
Andy Shevchenko

