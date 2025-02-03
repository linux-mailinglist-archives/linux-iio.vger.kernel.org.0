Return-Path: <linux-iio+bounces-14952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E54EAA26562
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 22:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7E31886018
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 21:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30820F08B;
	Mon,  3 Feb 2025 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fdn90Aor"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8944B20E71F;
	Mon,  3 Feb 2025 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738617089; cv=none; b=hho95BNhQs169EtaSpfRV2EIVWbrUB8xdzkyN5NxgpXQOEHc6Tboui7vMgsNFDULCXqjcNCLcyuihSOK42zfyVKsxZhBut8uzkd/vLAb9vk3e+EtGJf6c7Fb5YOBdeUafA/woCgy7acOb1dEUadJvFfN97q7eYFIzIHrEsuLQBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738617089; c=relaxed/simple;
	bh=PvG6MO/qhDtrP6JnR5pm9tuiX3EWXEjBNvdJoxGVQ5w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=LyHTn3CQekVfo3Flfn1hP+miROmH8yNdxxr605RLUIzUDMEAICqn4lIGWI+3Ct4068ifQhlmf5YFMM9kRjlcqSVnXC9mbGOA6yF3vHz3BQWGeGd2BlyQ30wa0BIprepXhTcluHBCA5PDZtmxxuww/FwTgU6xTsgR/YJZXNoYkMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fdn90Aor; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-438a39e659cso33908945e9.2;
        Mon, 03 Feb 2025 13:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738617086; x=1739221886; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U08NDyZ7FYenbFVd8FtukZUWJzCXtCq/5zQsyVifqpk=;
        b=Fdn90AorEIRQgQu2JS7Z2vJRXg6Wg5Qqeaj4WDKrbL6rxt/s5Bzo5JoitiQJ7/yNSH
         w4fQIEjHVLlEcigtQMvCLEK/mjXf8defN4MV1pFKYQCtC4uJek7F9ohQsE5aETFWFFTB
         vON1NOLaPpM4AJ9m/JSR2FvX2YaEZwdGZsgsWdm5lJJ10WDodl9tYsEVBSzTYx7usC8Z
         Lv27J65pO/+42yrgGCbtSQbaxN3ZLQx8PxDk8J3OWfio5QE6lGn9ID7tdUcyLJvshy84
         Z648oP+ZNa2STuEch5f6cMjXEOuDsqL2m9V+ed9eqd2FSLFiJfFfBGA/3bcOAsJ6Usuf
         v+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738617086; x=1739221886;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U08NDyZ7FYenbFVd8FtukZUWJzCXtCq/5zQsyVifqpk=;
        b=rX0dD/MvehGllU695chli+kX50x5MzwIyKqwM2LECCM3+cX1N/u5rGOCrSUJQp/Mak
         hMweQPRPYQz4Hs0LBXPUeblK/xrCWoJ4jE8MOg+Fbz/77oShyUuivgCVK7F137H9AAW3
         lL0U6k97Irn8M3B9UqAXB/hWZ4sxxL/AhpfAQRGdJ8eR3MUTmjoDW0wAiyXkFSJzAVrc
         SB4eDufRL4Io/ACT7/G6lWYSqk2SqAJ+slXeSzjDa0DLYewBR7mXFOfs4g37HsPOiXDU
         HxE6jouqRXCZ6zJO7S7TCU2cnBIfXn8PbfMFEPiDQ4jy9KR1o+T5H3zThvmP7olN29En
         jEmw==
X-Forwarded-Encrypted: i=1; AJvYcCWVOqfRQNsBGDAmAzGOLUhOCWWjMGslyH0Z1HGdH/dzDHiD4YSTiVJqVH1Tln7T6g6/W0G2K/6gCGodHxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcgdXe9nSYAVpCp7W/4SoBPRDG7hkjml0EneLoS9VmkApmmxMi
	eTskIBVtHYTGFWwf2zp7qDa4Q8xvHE3y7FrUqPjKcR+2xLayP2U/
X-Gm-Gg: ASbGncs7xaEM9BMfemBPly8axAMFqK3NsPfs7IFJ9Qzv0Ski8w70kGNO9z1q3mbtiio
	VzboOhmGMTBIc3tPhwbiW/bCjxtvF5e0i0Cdx7sOmo1LMSLIm4Y+4YWhlb4KP9AdYBGqfx3vjp0
	djPKQxq3McQYo/ShDCzgZnB9ZvZvSv3z1IFzudfkluyFtrZfStn238SpPUR4EH/y0xg42MzHaLB
	2UH693J+Fcb0IscDdBAkvMmVzKwDfzvTIq/HD74qcP+pjwPJbrFfxx5bz9O7eRJq4jgJqR7YTDc
	xqYH8wKQ5oxfd4HztICXIhWHgs6uvqfSdI+Bjg8SYaIFOI44qheHDPRfisyXgokyOyGB6MKT8su
	OnX9uDyAlbCcRXZidL368C8uU/l9APF9SXBQ=
X-Google-Smtp-Source: AGHT+IGOdduessC+T9RGvthi3zkJCrym4amTRb2PUZ27wAtWRzxm//tlbWzN5SfZsNnwXOPoLhBoGw==
X-Received: by 2002:a05:600c:3583:b0:42c:bb96:340e with SMTP id 5b1f17b1804b1-438dc4349dbmr201383455e9.31.1738617085308;
        Mon, 03 Feb 2025 13:11:25 -0800 (PST)
Received: from localhost (2a02-8389-41cf-e200-f011-fc60-ef85-7f8c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f011:fc60:ef85:7f8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c139f15sm13956899f8f.59.2025.02.03.13.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 13:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Feb 2025 22:11:22 +0100
Message-Id: <D7J4BHL127FC.NVE7SPPOFKOU@gmail.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>
To: "Karan Sanghavi" <karansanghvi98@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v2] iio: light: Add check for array bounds in
 veml6075_read_int_time_ms
X-Mailer: aerc 0.18.2
References: <Z6DpZDJPDtiDzxDU@Emma>
In-Reply-To: <Z6DpZDJPDtiDzxDU@Emma>

On Mon Feb 3, 2025 at 5:05 PM CET, Karan Sanghavi wrote:
> The array contains only 5 elements, but the index calculated by
> veml6075_read_int_time_index can range from 0 to 7,
> which could lead to out-of-bounds access. The check prevents this issue.
>
> Coverity Issue
> CID 1574309: (#1 of 1): Out-of-bounds read (OVERRUN)
> overrun-local: Overrunning array veml6075_it_ms of 5 4-byte
> elements at element index 7 (byte offset 31) using
> index int_index (which evaluates to 7)
>

Hi Karan,

You have dropped the Fixes: tag, please add it again.

> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
>  drivers/iio/light/veml6075.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
> index 05d4c0e9015d..21de193ca09d 100644
> --- a/drivers/iio/light/veml6075.c
> +++ b/drivers/iio/light/veml6075.c
> @@ -210,8 +210,8 @@ static int veml6075_read_int_time_ms(struct veml6075_=
data *data, int *val)
>
>  	guard(mutex)(&data->lock);
>  	int_index =3D veml6075_read_int_time_index(data);
> -	if (int_index < 0)
> -		return int_index;
> +	if (int_index < 0 || int_index >=3D ARRAY_SIZE(veml6075_it_ms))
> +		return -EINVAL;

This approach modifies the original error codes that regmap_read() could
return, which are not always -EINVAL. You could check the index within
veml6075_read_int_time_index(), return -EINVAL, and this section would
stay as it is. There is another call to the function in the driver, but
the same approach would work there as well without modifications.

>
>  	*val =3D veml6075_it_ms[int_index];
>

I would also like to remind you that giving some reasonable time between
versions might let others review your patch. I am the maintainer of this
driver, but no matter how many iterations we go through, the final
decision is made by more qualified users i.e. subsystem maintainers. It
would be nice if we could save them from a bunch of versions in a short
period of time.

Apart from what I pointed out, the patch looks better now. Thanks!

Best regards,
Javier Carrasco

