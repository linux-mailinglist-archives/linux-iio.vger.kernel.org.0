Return-Path: <linux-iio+bounces-18616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C9FA9BD8F
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 06:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA943A7019
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 04:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B861215F53;
	Fri, 25 Apr 2025 04:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZtiDDBd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44C26AC3;
	Fri, 25 Apr 2025 04:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745555377; cv=none; b=QYGHeToHInZYoHqfcKrQzrCeLKjdl11A0PrMikN7qvSmtpmIM8UsMOw7f6PVoob5J2BJQ7SCtQTUJP1nEvqoBP3cv5sdjlgAF0GsIQMzKR3J6D7WndIyUckl86x1RFg4KIMKns8LKWcGjTe/pcAs4tYXg0oiUNG4cbsw7HchvG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745555377; c=relaxed/simple;
	bh=cg7O8yhjOZVG71mTeSzefOVsa0LfzjT7LGCUjjEisOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nr6X7lSHgnXbubquZsBQaw7LJmQKVYI+CUqtx264uaXWr+mU8tLZbsX6L6hJMVhRBnPI0M1XpzxrCLIT1aXJuX2VIFiqGp6/IWbi+2hXKxT41q9U93wn9/OhuYCqDvhOfVG0K/8N8SNQhW2e1hN773bUsRHJIL7Z+igMcwCwG2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZtiDDBd; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so264885666b.3;
        Thu, 24 Apr 2025 21:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745555375; x=1746160175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TQXT7I/YGU9ccLOz7Oy5JRY77KJdz9t2wirKmQESkI=;
        b=hZtiDDBdXZ4kX2CAW2YKl4bbVjiXV6LhnDa02uirdki9WoMfjEGpnuwFIykuqDT1Vu
         apnvwBMGNsVbCKBZ47+3E6fnmWhVY4ONn+86gcNB90Zgu0VioGTh3wNyLXlOHsWg8+x8
         MlqwLRJdcbV5V8Apuqp/QFArU/C4MNWq/QcwOi5ss86w0ZrXrbRC8j+n0/GQbuYhgxV/
         vs6Pp4/aPAxMQvtDrA9xEYUCGpmZxT8EmLFqYAKQNT/B45nxbZHnES8uPFLseN16Ghz+
         kmRrzpOgAO8rELZE+kdmDzKyLTX2LAjqsGuOZb/HEWxOnQztdgvVgu12oJczJiuLLUOh
         rz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745555375; x=1746160175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TQXT7I/YGU9ccLOz7Oy5JRY77KJdz9t2wirKmQESkI=;
        b=nf3vtU9ehpEIZlj0AfmJw+mIm2uHzS2O8Mry6PUJt2A8kj0H2MWc+kwY5/Wk7PsvXh
         D/3UFYpl6/E2rXC9qGgY0lbHNVkhkZaTWvQSSbYepllmjgBA+QBo0mrO1s+5xFIKHwK9
         DolZIhdPctduOIyv3rcuYqbwZjyk+e0nrOXoNr1L3MvoPqpQh4aU4JampMrZdsPH8pGj
         ADTFqdpdEReZudTC+v9NX8UqVPDZb9JUc9nUcVBhuIzDZqLZUxNR2NP3WYDWrJy2cdRQ
         bwYG5jo5RoVufgD20Bg5M1BDidNxJg7bHEVeBe1xQylmqpniyhGQKKToaYY/pfwG0qDC
         JApw==
X-Forwarded-Encrypted: i=1; AJvYcCUp1Kuyn7+9B7ZTI6SQbu75eP+NxBUzjppQk3cUZ8bT0wejgL24GnheKjjD5j3ymk8XuzxWLGOdQsmtYdxa@vger.kernel.org, AJvYcCXC18jBUTMVq5TDqWbzt4dUWW2m83aJpX7odlifCyRkU6p2gXPzUmJ8ret3wvQyqc/O5WFFhiGa36k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzF36CZvtfgxErHLymUYE7TTEctEgiOr6Qkgs/eJ4Wqc/Bwx4G
	Q0PbnUelnvHL11p988villt44MA/TKxKU7dd9liQjcIjx+QbMveUKCHei3oPzVNpcRdBAwlfDQZ
	J6W4WeKEUJ13+BCUlCEF1eprzuvk=
X-Gm-Gg: ASbGncuZh28+ZQ1JtGN4H0C2YC8q3s9BHq69XvqyHPlg51n+KYLQG83HkuLkBsFvTi7
	NPSA7i2u9oociueANLy8LoTYupqUsUsrWOj+IhZgr/XGDko/GAE4JLj6y0GPjK9a3SPSHHeJPR4
	ZhbSYOXQCvAKBk/3w0ur/O3YI2Adm0cE0i
X-Google-Smtp-Source: AGHT+IG0AYlOtH+5JPDtKd5wFOhw+RWLQKfnoUqpSwBB8ND0XF9crM+q/OJlTbLI/aTcHklgH2UFV9/u7EK4hxR3hs4=
X-Received: by 2002:a17:907:6ea2:b0:ac7:f00d:52ec with SMTP id
 a640c23a62f3a-ace713af43cmr80944666b.58.1745555374372; Thu, 24 Apr 2025
 21:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com> <20250424-bmi270-events-v1-1-a6c722673e5f@gmail.com>
In-Reply-To: <20250424-bmi270-events-v1-1-a6c722673e5f@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 25 Apr 2025 07:28:57 +0300
X-Gm-Features: ATxdqUGM3HjCbKjmk98EUkLep4i7LzPMduvsKtQnoahfj8rheOtUPRhmr4gsT4U
Message-ID: <CAHp75Vc_AnwjY6E_iE5RMOSh4eV2iWuqqAoteo9TvtgDT_CXKQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: imu: bmi270: add channel for step counter
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 3:15=E2=80=AFAM Gustavo Silva <gustavograzs@gmail.c=
om> wrote:
>
> Add a channel for enabling/disabling the step counter, reading the
> number of steps and resetting the counter.

Looks ideal from the style and maintaining perspective, thanks for
making the reviewer's job easy! One small comment, but
Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

> +       case IIO_CHAN_INFO_PROCESSED: {
> +               guard(mutex)(&data->mutex);

> +               if (val || !data->steps_enabled)
> +                       return -EINVAL;

Please, move the val check outside of the lock, no need to lock for
the local data.

> +               /* Clear step counter value */
> +               return bmi270_update_feature_reg(data, BMI270_SC_26_REG,
> +                                                BMI270_STEP_SC26_RST_CNT=
_MSK,
> +                                                FIELD_PREP(BMI270_STEP_S=
C26_RST_CNT_MSK,
> +                                                           1));
> +       }

--=20
With Best Regards,
Andy Shevchenko

