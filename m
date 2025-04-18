Return-Path: <linux-iio+bounces-18238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66DBA935AB
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 11:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2682C8A6DF9
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 09:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549271F416D;
	Fri, 18 Apr 2025 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwQtpWjb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67841269CF1;
	Fri, 18 Apr 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744970243; cv=none; b=L7yueyKa5cZYUhuVqn1hc93PZpwbYOdpWMaWQpMdl5f/ElcG2tPe7LY7+erBU2AF/3kaBweM2sWd5WVdluPXY6LJfAFibS9H5DiQF8jtldIcMZWbwloaHLQoaDYUe5LRZfDYsKIqXbNYuKOAvdTtbPVGtvT9J+bWdZ+l/kCcmsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744970243; c=relaxed/simple;
	bh=WmaSvDoeqoFzaQP/Y7NFJdAouhFUwa+QoPNGy2guwBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PLN5CAgn6gqEVaYMZGZLosLIsWcC0qU58U6gTRQW6Pbhlsir8b7n1jf3m9VlT9S3ifiSYox/8CcpQOnkWzw2wS6oGcFNtNj2x/sMjUSQ85chGh+A0S1twcwedOYeB7f+grIpBFFjVrzpG9HjVIYZIEBlx5cyEfqvo3bwJvU3a3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwQtpWjb; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39ee57c0b8cso1641312f8f.0;
        Fri, 18 Apr 2025 02:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744970239; x=1745575039; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kJPUilpm25GT69DD5Yt1sEWK/7fI6b7BM1tjdZsDCdE=;
        b=HwQtpWjbmR6ph3fshygqFYNno+mwlQ+tSO1rWvEbJmphZXi35K/Wj8oKfKooGxZoqR
         D1Mh/S1qJKhtBIGAXzZzoBEBHrsyI9b6k3nL9tUzbrZZXoJP9tnjMYxs/jHUrX4D9Moh
         qPaSrLLr8xzIsncMjqH1ZNjVeIMRGB0q7PoVV5cDDmTy/lIiqM/+5Z0mN6La0kThsG8a
         AphpT8aB7IKrcL04rqSU2lVhW6XXkt3slk6vYY6mFYhHm2ygckqSuesolTH/WdKti5rL
         3nMjeclOO9xvzhfFz+xYMCGqiNAPdFRL96QR1wRpLdiVFgVN08zmsOFUeQ5YaIa8KhdT
         YbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744970239; x=1745575039;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJPUilpm25GT69DD5Yt1sEWK/7fI6b7BM1tjdZsDCdE=;
        b=furco27ur4G0K9xyinIBcV5ktHfy+xO3064gjo7H+qhQaun99HGNV9n+E43i1M1cIk
         yYQr0nnfrsQ5/4vYlUgNFpv1Qk3f4zEZrZKScW07S4aZI1P1p6JuEx7WDtEtmow91dQg
         z9hk/L/0ZlhEaZ0bzbBAghic46Mrz4pQ/Fvgf89r6ShGRTOUwm3XFHq4Pv+Jf92seKHU
         LXKIuwRrMcXDoDRekvkKQtHbJiXscRU6WubvHKOuL7xvpjjyoztup9tRHcYMiYyYHHhK
         cWgRKQ8tDnjDmE0qQ6MV8phrGo0v6nEVmQSWBfDlWhjUKMHBuQnCBBZM/JMKs4Qs67bP
         ba5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7H63URhxit/8bARs500JA/UsPSlnhWC9YG1eXBIY0kdoC3shkzac0gWvbHZphXZjKXY2npHtB01Lr40g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUXuoYKS+fV2xwG3Wp4Olm+gaIaFY37SxPX1pUUmAbAAZyAyq/
	Atr5i0EWjm1Mj6IS122TUCLend8C3TsRgtmBCIKhtFfOcyPfdmft
X-Gm-Gg: ASbGncsUQ/dU+7xzMOXTUFuiGP5H0HwBbV6sO7lAb/c2yI7121B9i212dllJSZ0AIKC
	FTw/i7apEnJcBOUAI1V/asamkE5/kgKIi14BtRzIqvJxKyCXCsNs5fYldN/JDNrUy5bidbhGey7
	hN+grbo3oFofCEBVv8NSbwVnVdKyuQFDMABfums2+5spV7MV0/jRVWRpMlBT1PUWNnRkLm/zbNB
	i1TDv6lQ3pY5FzCetaSYmLyB8MKzkgYvc3I+YvXf2I6ZVyuFr5fdiFiZKYfIf7xCiRPiJF8rzYv
	GjotACeSh6VRr8+OhfzpqCaF+x9oG3eG2l8LCtEdXASINWwh2lvXXMU6HfMgnhC0ftqU6kFopiD
	6gt02sEbuJo/uTIs=
X-Google-Smtp-Source: AGHT+IHyu7Y9UocFj6NyupWQTlJdBONm83Bu6jCvrQKTBDg/mDOlNqwmUghvwlMKZE314LRRl+t+tg==
X-Received: by 2002:a05:6000:4201:b0:391:456b:6ab7 with SMTP id ffacd0b85a97d-39efba5db9bmr1508046f8f.34.1744970239352;
        Fri, 18 Apr 2025 02:57:19 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4207afsm2310967f8f.12.2025.04.18.02.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 02:57:19 -0700 (PDT)
Message-ID: <057bec6375819c3a4cd227c20a60ec1dbb7405c3.camel@gmail.com>
Subject: Re: [PATCH 3/8] iio: addac: ad74413r: use aligned_s64 for timestamp
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lars-Peter Clausen <lars@metafoo.de>,  Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Tomasz Duszynski <tduszyns@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,  Andreas Klinger
 <ak@it-klinger.de>, Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Date: Fri, 18 Apr 2025 09:57:38 +0100
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-3-eafac1e22318@baylibre.com>
References: 
	<20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	 <20250417-iio-more-timestamp-alignment-v1-3-eafac1e22318@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-17 at 11:52 -0500, David Lechner wrote:
> Follow the pattern of other drivers and use aligned_s64 for the
> timestamp. Technically there was no issue here since
> AD74413R_FRAME_SIZE * AD74413R_CHANNEL_MAX =3D=3D 16 and IIO_DMA_MINALIGN
> is always a multiple of 8. But best to conform in case someone copies
> this to new code and then tweaks something.
>=20
> Also move the unaligned.h header while touching this since it was the
> only one not in alphabetical order.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/addac/ad74413r.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index
> f0929616ab899cb374f00869787321eed4ccde16..a0bb1dbcb7ad9d02337d0990e5a3f90=
be7eaa4ac
> 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -4,7 +4,6 @@
> =C2=A0 * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
> =C2=A0 */
> =C2=A0
> -#include <linux/unaligned.h>
> =C2=A0#include <linux/bitfield.h>
> =C2=A0#include <linux/cleanup.h>
> =C2=A0#include <linux/crc8.h>
> @@ -24,6 +23,8 @@
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/regulator/consumer.h>
> =C2=A0#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> =C2=A0
> =C2=A0#include <dt-bindings/iio/addac/adi,ad74413r.h>
> =C2=A0
> @@ -84,7 +85,7 @@ struct ad74413r_state {
> =C2=A0	 */
> =C2=A0	struct {
> =C2=A0		u8 rx_buf[AD74413R_FRAME_SIZE * AD74413R_CHANNEL_MAX];
> -		s64 timestamp;
> +		aligned_s64 timestamp;
> =C2=A0	} adc_samples_buf __aligned(IIO_DMA_MINALIGN);
> =C2=A0
> =C2=A0	u8	adc_samples_tx_buf[AD74413R_FRAME_SIZE * AD74413R_CHANNEL_MAX];
>=20


