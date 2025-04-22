Return-Path: <linux-iio+bounces-18546-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A62A97A87
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33ED189E373
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433A8298CA1;
	Tue, 22 Apr 2025 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9Noq11e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7140C1EBFE3;
	Tue, 22 Apr 2025 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745361326; cv=none; b=UlB71fKta3d7SmgrlpMP9X0FEfco7TzAoRFiP3zQZ9b7rQgwDFReqJr4WH9uBn7gh+nQaVJe5EEZ9z8HoFNX7sdLf90YbEgSDRrbEFS/uw6BoNdIUo4Hr2Lv8W/tCrWFZRKdf3rmb74kg4vri2nfctbiS/YrUgj6havTWnPBxKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745361326; c=relaxed/simple;
	bh=exuwJXp1XHrfsCfmNkVrZR7xtGP/8Zf7C6Uz7JyF9Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOXzmKdxpl9BfMhXZV8cQNbiKlVDGVicSexiql/3TPanGDxopoBJU7OKYTdvix6XT33UuxIdoChKZwcTNBdJjhXUTj5sBvS2YrGQfby+yqHysWMXpytbjBUyK9N9PV1z0oaHbaZ6LFXY2nI575ML1PARetot70Mwwm/d2Kp9/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9Noq11e; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso577828a12.1;
        Tue, 22 Apr 2025 15:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745361323; x=1745966123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exuwJXp1XHrfsCfmNkVrZR7xtGP/8Zf7C6Uz7JyF9Xk=;
        b=Y9Noq11eGtxRw+dpLHrm9pEVz0+NZ9HRJvK9VtI8RMRHS3egkogrblw2BfgUcIVH0y
         S84l8MrPQRdNQohJLW+vxmJcaWXsGEGITD7VdvTMkwEjS6nGG3opXEUgPfAa2GLX4CpE
         tOYGdDmhkVCgvtqDWCONy2ULTP4097xZAIgKTVG+aSBIUGfbVJisbqsahwf5tCQmyONw
         tCc04Cabg8zcDQWqHd7emtvD6OQbwOwid+6IkLqpuWvVj/jZeoRnnT/G6mjvSKJZFKnN
         0o8iOwaURaEDgHVirveExCMaKOfh0kln1/wRdZ8WnjuwWObhhHTJMCqlpkGzLNpdkdu3
         7w+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745361323; x=1745966123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exuwJXp1XHrfsCfmNkVrZR7xtGP/8Zf7C6Uz7JyF9Xk=;
        b=HGATe4XHdyJRvt+iafU1qOyTfXqBW2fu8qG2NhqbzgkfoWTuOkKY9b3kFSOsaUWPrL
         3YFoYKkfm54TOl+BDhIFrxYvUxss0z4X5iOhb1JWWvjrcuniYoW4faVExbWXQssC5GqM
         L0PR0xKMQRrfYRVstK1LYrnbJVU/KvVXniV+2ADyMXQNiK2wY7l2vp6meZWJWB+0C5HB
         CqtH7L+4k4lsuuevNT2RMMHVlq8NdxuLRZjct+UlSCcZ88J7+9ZK73jJonxEg2S/icHa
         Gesszby3CVNw5JW9mCzGO5qgXw6Bmfc8idhAVpgn3/iV0oIaJ0y3J6ShWAGXmBeTLOBE
         gWGA==
X-Forwarded-Encrypted: i=1; AJvYcCU9ixGgzYk6z7VwgxTHPO4xYihT9Tv9ESpZXGNQShb2peyNYYHrUjIgQRunbD8mLatZlD6fr44P1kydfDUT@vger.kernel.org, AJvYcCW7d3yQ4eVCgWJO9q9KHENc6TuCwpYDx9YWlsogKiXfjrDCGF8yJI9/4dEfE1+ynB2zofzFOloR0+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQi9NvllNjjtfHdGukhHqFQ3VLr4HwctQ+zuBvZoMeYAygU+2H
	BFNmnsaQfJnubrNYAuDUm5WLv1AMCBl0WL0T5lEVa+aFlyRY+hrq9EUj0lE8pOVFSNy5D9NFiiy
	HcOhZ8eE2GmyzQJZN1gup+K8C0ao=
X-Gm-Gg: ASbGncv5xGQZE02IKKqTFbcbFRwlEgAvNnjFJKNRYiKLYTwAgsbh6NN46yUP8Vran2O
	3gbyuUrhOppaOmKZeV6HEuo8u1p7XQpzngmWcWT96w/sgecpossoR3Bf9yTcPLPX4oqsNLRpnVp
	lIvuGxOw+AeRDTY7pk1kbA2TD3bfVuOc2y
X-Google-Smtp-Source: AGHT+IExyhwMK/xkdBJlNnfQyIQa2Se0td5YPkj+KT2p+5TchTOdRI0q/90ny8bjCRUvSLeT6NBK++pX+31tHxqRlEk=
X-Received: by 2002:a17:907:3e10:b0:ac6:e29b:8503 with SMTP id
 a640c23a62f3a-ace3f255374mr55218866b.1.1745361322568; Tue, 22 Apr 2025
 15:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
 <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-3-3fd36475c706@baylibre.com>
In-Reply-To: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-3-3fd36475c706@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 23 Apr 2025 01:34:46 +0300
X-Gm-Features: ATxdqUESYrpnuCfs1f0bD-yTLn32Q3cQsMUye4m7pupxP-8uO4Y3zk6hss6f4Vw
Message-ID: <CAHp75VdpaD5X+p0JSxHRoCAguZH53jfxe_WdASRuRXuS50kkNQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] iio: adc: ad4695: use IIO_DECLARE_BUFFER_WITH_TS
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 1:08=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Use IIO_DECLARE_BUFFER_WITH_TS to declare the buffer that gets used with

I would use the IIO_DECLARE_BUFFER_WITH_TS() form since it's a macro
with parameters.

> iio_push_to_buffers_with_ts(). This makes the code a bit easier to read
> and understand.

--=20
With Best Regards,
Andy Shevchenko

