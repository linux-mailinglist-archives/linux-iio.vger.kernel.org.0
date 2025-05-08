Return-Path: <linux-iio+bounces-19351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20991AB056B
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 23:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858884C53E5
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 21:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2C42222C5;
	Thu,  8 May 2025 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYAVXbAL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1AA15B0EF;
	Thu,  8 May 2025 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746740404; cv=none; b=OZ53MIc4z8o5EuUBYEupupg4J2ygALyrDJiXV+vzlpCFGb5JF4qhJaVKinAtvV3XUku62diahqjLS7ik3qX4p20PEmq2dnCg0E5RqFECXdBwuL28vOEGbHNp5RGlNe4TzmLSXUyPKE5u/ecNx58QGqS8fow3xXwibCsLJexO65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746740404; c=relaxed/simple;
	bh=6yVxsi2E85S+R5lW4kL/CgTk3eP3swRhsuthT/n+Ti4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTQ5CHex+IxmzSfFmqiJt0/2EaburXfTvuLwjWW8wT2Z/7iUoIRSGEr9EI3yc7Z8d4oWmov4PIUDHxd6Qd+SmGDlcZH8bF+IKXq0KyHburJHneFNLpNRppmthMi2MpHgomPIEEtl+FZ2bnt2S6OVP/PgndX2T+FLE3CbNPVtprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYAVXbAL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a1f8c85562so28543f8f.1;
        Thu, 08 May 2025 14:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746740401; x=1747345201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6iKxLNv8V7pETLeJH3poz4r78D0xk17zrhZAC6yXQY=;
        b=KYAVXbALEKE3csg7MWk1wJYJ+GvVT5lYKYFC7UpPY+nAnef7TiEbHlWO3Qs5PzZQWR
         HFQbtEFqKxXgHA82vWX89f4kn6U+NTgRtXX8Ivz/PBmGeMHSecF80w70Z+CcNqHaDVxF
         z44a4uYNWGbzvZ8bx8MjgmoYsWYLIJUw0n8G24E5tSBV5Sj3ky8jaanZzUnBe0zOa8/I
         iwFC58as3KV0rKBc0HbBuapuMOzncgNh90K4VR1sLuaFFmynQyg4KhPr5my7+i70zeq+
         yMJJlXb/H9mBMu7LbDE84FI59Z9CUOB5THSHRY6p3fg5LWJvvOakWAZ5Jm9J8yF+mJf3
         SjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746740401; x=1747345201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6iKxLNv8V7pETLeJH3poz4r78D0xk17zrhZAC6yXQY=;
        b=KCVc/lVz5frLy7U1cmuaubJft3YY0eCYgPzkoJpruUJtoTT5ppK2FITH6UOI0AhVM7
         +C6BQNClVtphcykFgIB4Fw1F8s7uWgahnaOL5rfXZTTSm04OAXpo1IvGob/6h2JkSpnC
         PlwTXNtYNbLeEnbSZ2VFaNG91DgH2HlBbZTPHteG0dQPkBhbIJ+5r5Id7sOiyxTsfDQu
         Ge46RHn2+oKdrZ+zTZaAaHvHYNQwUbFkp4UhnzY20mHG5GMhjqq4QuWecRig4RDett4y
         9PDtgj+orKQizPT1XFAUqE/U+cQ2LiuSzNsZMnuXGEOskCYBXdguzg8M+8w/VielR7ld
         NS1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/eF2u5j/7dIPE+cs2PnkepkTUrVl5k8vhxEej3LLm5y7YEHqTpQS3IUVQX3rMR349tOk9mDRr/wvGxSjG@vger.kernel.org, AJvYcCXnHZRv2eWjnzO8SuDlNTtNXY3O5jtLtq/pdGy982E3ZU/m7lK9J9dMs06ITIag4re5S/yt4/kmKc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKS3KV+9ffKWScMRixeY80VRJKyf5bdFhLMOeifQSm3YpJSWfl
	yVYloH3Per7E3UrsO6KbeyLgNf9587yqtcDY11DKvlMdCOWnEY6+
X-Gm-Gg: ASbGncsJTEW9wIY6EvrzLLkjPZBdTOQp5W8PfJBlZX5AGr5lDOyhiq0+O4JJd2o+Uba
	SyVfOfNrpv3YqJWvAunHh6DrJVXmQ67gyGrBM3WH4nYcaoNFCesBZUr8LkWJhZvWYDZBQUjZkgG
	wmbLGE8HbeOgXUK3WB9TMKpxwy5Z4H4nXdWdvb7EbCenUyR31y+mRflE0dDNP2UJO+hHA+nH7Zu
	J9AfQh0VeXjkAg7eAiiEHa5SF6qt6OldYL9rNRqJms2HS9CpIjv8mnVkq3VUj7vw4suJf0NnqPP
	QgchCEhdsxQw03Q4wftOJQe6UFGAI/JiUHt9ggOCzU5yEno6m86hCClpcF5CpTSLBmw5w5d/L3n
	TcMz3wfwSNyFoZA==
X-Google-Smtp-Source: AGHT+IE0WPQ/O8hzBzdH+71zuXvnfTcTp1gVeC9FNstp3An7yRQmTACh7fhbKRYnp0MWiYuGxTvlCg==
X-Received: by 2002:a05:6000:4304:b0:3a0:b294:ccf2 with SMTP id ffacd0b85a97d-3a1f649cc02mr938659f8f.52.1746740401013;
        Thu, 08 May 2025 14:40:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2a12sm1101305f8f.44.2025.05.08.14.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 14:40:00 -0700 (PDT)
Date: Thu, 8 May 2025 22:39:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Eugen
 Hristev <eugen.hristev@linaro.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/7] iio: make IIO_DMA_MINALIGN minimum of 8 bytes
Message-ID: <20250508223959.70e909d2@pumpkin>
In-Reply-To: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-1-814b72b1cae3@baylibre.com>
References: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
	<20250505-iio-introduce-iio_declare_buffer_with_ts-v5-1-814b72b1cae3@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 05 May 2025 11:31:42 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add a condition to ensure that IIO_DMA_MINALIGN is at least 8 bytes.
> On some 32-bit architectures, IIO_DMA_MINALIGN is 4. In many cases,
> drivers are using this alignment for buffers that include a 64-bit
> timestamp that is used with iio_push_to_buffers_with_ts(), which expects
> the timestamp to be aligned to 8 bytes. To handle this, we can just make
> IIO_DMA_MINALIGN at least 8 bytes.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  include/linux/iio/iio.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 638cf2420fbd85cf2924d09d061df601d1d4bb2a..7e1e3739328d103262071bd34ba5f6631163c122 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -775,8 +775,18 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
>   * to in turn include IIO_DMA_MINALIGN'd elements such as buffers which
>   * must not share  cachelines with the rest of the structure, thus making
>   * them safe for use with non-coherent DMA.
> + *
> + * A number of drivers also use this on buffers that include a 64-bit timestamp
> + * that is used with iio_push_to_buffer_with_ts(). Therefore, in the case where
> + * DMA alignment is not sufficient for proper timestamp alignment, we align to
> + * 8 bytes instead.
>   */
> +#if ARCH_DMA_MINALIGN < sizeof(s64)
> +#define IIO_DMA_MINALIGN sizeof(s64)
> +#else
>  #define IIO_DMA_MINALIGN ARCH_DMA_MINALIGN
> +#endif

Did you actually test this?
You can't use sizeof() in a pre-processor conditional.

	David

> +
>  struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
>  
>  /* The information at the returned address is guaranteed to be cacheline aligned */
> 


