Return-Path: <linux-iio+bounces-18545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A592FA97A85
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A705A189E2DF
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B2627CB29;
	Tue, 22 Apr 2025 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4zsuD7x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C01EBFE3;
	Tue, 22 Apr 2025 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745361260; cv=none; b=mTbAReWHvFvmHgiEqlB4z9HVMv7qWbZPgmAPZfcanxb13FONSYtSYP5jrn8Rb8TJjtpjeYMaQYBHZcEuLpnyAqyenjbV2eI3n0i5TxvL0HnoT1pxGmbLWSaye8e++bpUC5psIhTe4XLD2OmqNbQffC1agGxHt5ZD8ZOYmFMqPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745361260; c=relaxed/simple;
	bh=voGoFxauiMHX3oaVnZBhPkQWEiSoeuVzpWebqxlf4NI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGHcNnbmKpYv8ri6b6QDltgzcasHR93i26oQaZqULe+cGpvcoyNAW7L9yjN7nRYg/j8czv/cWyn/XlWi5YXopbVLeihsSpYINZoGRp8SjgqZix9iaWngW9YI+t4V03llNzyo9aQh9lML+7uAq70kfDtdKqx4aB8N10ZR5FIQAp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4zsuD7x; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5f6222c6c4cso7931594a12.1;
        Tue, 22 Apr 2025 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745361256; x=1745966056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSwUO8B5vwdfcnexH40Nc2DnuOoNta8XhHEpoFTOGEs=;
        b=b4zsuD7xLjV9xqZkw5j+ocBR9Fg0KvmddASfzY3feeVUJwuv/SqXc6LbQhWRGVW8vy
         RtAI8aP1VNG+mZMHZaMPYRhGa9LuBrO8vFTbUeC2xFBiLOXc+8TVoFkJ45OiyCGlw4tz
         k3RJ1N/SPIQrhqPXs6so4RXcyxtcp9dUukDpaOra9JWDgrU/KfnECWJagOXBqCuPGXDX
         h35tIfKEXG1YqF5BJ6aMTtODrBhT3LXLc8XBkKLzOVOCR9WxYfi3HolyGZLrnuecbviS
         pUFipz6Zc0wiLtK4OWtNOt0sZFGgT6jG7dfsLmcjlyWeXpjeeaAK3F9J1odUu1LoWo/X
         lAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745361256; x=1745966056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSwUO8B5vwdfcnexH40Nc2DnuOoNta8XhHEpoFTOGEs=;
        b=ZS7QihPJYOM86pAs85VdUyIPD0b/j/3hsGCAnTz1YVOLBdaPlVLhydJJw25qs6KXQb
         QQCIUA8lg9N7L2w5UPflnP8C7jgbD3wHV/HHYtIvbC70/9Dt18fzzzpHbUEw5fWpgrVp
         awugI5KDDwEloM0sGpu43w4H55RuWzIGokLIQkY/lswg0mN55x9JI3pVLs81y24I2+rv
         4eFLHtIStgTiz+Ln3ngrQ2B7Y/TKBPukv2ehfrdOvF+l5hOsT9ftgn+XWJFfv8cknYQU
         lxlmpkjEHbqHpYpGWg0l3BQorsbmXxRpyN9EljrAEqBaeRp948ZhXMEZIltCESspgJd/
         72UA==
X-Forwarded-Encrypted: i=1; AJvYcCVbq6fRXN+RxKC0kIjHN6crTs5vMOprtu6qxnIbr+eD7GAgxjemAAjV4+pSWbf4uJcLdqX50hOb/ztjzknD@vger.kernel.org, AJvYcCVf7tdTQnChCeJrH4eIcbNGFBceTVRro5vFXu4aZl5NMl9xLVrO1jwICkA6pW95th6uzQrqdDiwF5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpD1ehOIwT7JIfNGL0FCJzgcoWpBtfmugAo77fH9C2QTIHxN5L
	rWIuR3cyuxEq+OHXGTt/qIUdUQiKjR5hfVCiCTRpQEkCMjGGmTCqDhJzaqWGDTyj5DDU7g+AJ54
	f2cQxUdaUXr326B1jHhMhdwdICA4=
X-Gm-Gg: ASbGncuiQ7rPVAglpZO5Gnv7JSb/k+WdJXJ2fqLIgJjXFruON0+XZnB+FtwOfwOMTwN
	X5SA/tyBmh3f7eHWCnngwWMoHVPmAhFtqE//aag6vOIcyTlER+J+1Lo0arLFKQb5cJOXlNtlGh3
	quz7PZEvVVt2I2AoYTm/o3PQ==
X-Google-Smtp-Source: AGHT+IGEdEyDJ7eLl/WPHqEG6RPTd58T1qtwdpGHMY7GLLjHzgOyyUSyU3WSKL+Ol0SHi9HYxX2HTVhMhy2PuqK/6L8=
X-Received: by 2002:a17:907:7288:b0:aca:d6fd:39a with SMTP id
 a640c23a62f3a-acb74dd403dmr1341111566b.51.1745361255480; Tue, 22 Apr 2025
 15:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
 <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-4-3fd36475c706@baylibre.com>
In-Reply-To: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-4-3fd36475c706@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 23 Apr 2025 01:33:39 +0300
X-Gm-Features: ATxdqUEloA-ZEhkwZ1BjOVJpOHMzDaj9rmKVF64izawsOdJZZCwOJujrDjEDXtU
Message-ID: <CAHp75VdqanGpwB5raE8AmH-Tmb82N9yYmhB+k_rQtc2_Zb8HQw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] iio: adc: ad7380: use IIO_DECLARE_BUFFER_WITH_TS
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
> iio_push_to_buffers_with_ts(). This makes the code a bit easier to read
> and understand.

...

> +       IIO_DECLARE_BUFFER_WITH_TS(u8, scan_data, MAX_NUM_CHANNELS * size=
of(u32))

Btw, why not DECLARE_IIO_...() as other DECLARE_*() look like?

> +               __aligned(IIO_DMA_MINALIGN);

Forgot to drop and use the DMA variant?

--=20
With Best Regards,
Andy Shevchenko

