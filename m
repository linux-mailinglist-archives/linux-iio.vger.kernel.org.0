Return-Path: <linux-iio+bounces-15048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F80DA299A1
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 20:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7AC1688F3
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 19:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF091684B0;
	Wed,  5 Feb 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N3kRNtGl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4769613AC1
	for <linux-iio@vger.kernel.org>; Wed,  5 Feb 2025 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782028; cv=none; b=ZDslqarx4/qHJ39c+BOVgGbQKrqlQz8I3hCYn8oWB9PMagLTnryJvCSFgIYH6oH4/vCCl5TLS/AlKqFNlnY4C9sm+jAoE5n7i0/fjZmNoTB4fDoGmzwg9hvDUo5P8xrdiSRQHXPGeI2o1BRMOWRxmzBOBqnClTiRwykd5TBj0+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782028; c=relaxed/simple;
	bh=DVZNausarlkBr6HpOTgLxmSO8rKQ9d7P8BI+zLFnbdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piEev3B7m8ErgKfKjUU+SYd4PdsnMGRAIqQwO41LqGOAPxz4YJhKwnfq2egM++0PtmJ91wq/b0D3WSHH3V0GfnWoFVUmvjP24HoJQ9GajZ+yfYQ63Ug9C/7LRmGnb35QmKwuLj5IGvYMS28uFFtkfOBjyNq6FtFdnLjfDbKqZJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N3kRNtGl; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-51e902b58c0so36267e0c.0
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2025 11:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738782025; x=1739386825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+8f5NTb3fsKuo4wsCGreRm0kUNpOc1zPp0/mIECJ8k=;
        b=N3kRNtGl7KWRmvy1LDo+dVYYigUdUCpJO4zG++Fp4z+fHi9YsaV5Ic2j0zMyhNorqt
         l0Q5VYoRhlUjlvPqvGtG8DeMKH0dFBGfMhdW31okPaU8auqFfEJmv3J2ZuNWCtkHYd4M
         iJrZYpldcdpAMlE4/JdVYHufwujZ0I8ralSDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738782025; x=1739386825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+8f5NTb3fsKuo4wsCGreRm0kUNpOc1zPp0/mIECJ8k=;
        b=rGiqlJuPeEURImpqmgYOyCGmupFHs5/4cyXUFK7z6iCDeyGmHnhuUgOmhKQD4/C59Z
         Es31K2SVlrOi1/8uGKvKoYYsCOxpiQIgVhCMcGuhbKp0dzHbADTfCSbbXkk6k2b1SEPo
         l75by9AHRrXqesmfYN27MaO/mtcfiASVOtpZIlpLvVJlKIIXSsPO5G6kpFPvGsk/n6NW
         cgYcvo9Vl5oLZchwxstvm90hg7Qkrmsgf6vJ4DOKSDT7glZ0Aywd5idjRL6YsSHQb4Ty
         4bedrwarXMhDFCjz4ua4uDb6m31Uk4jKslUx4OAfN8LeZn5kqitvlbMOXUX8L2sI3+2H
         bW4Q==
X-Gm-Message-State: AOJu0YyANYBKjKSgCApRm2XzU/ATqbYaTOGbivJYSQXTS/U/tuJevLvA
	hHw+OpOlvP8ZRVYnJNg8Gy648wAlCXdLQMJP2r9tLNXSrRCB7H2ga1sZgrDFrZjPMf8JnlN3dbO
	LjMs/SX65ww8jDSZone3IZG4f/DyQZVuWJA3N50Ed+yBr/bs4WvR1
X-Gm-Gg: ASbGncsgQqcrTjay/rorWfgXMhQoaHfytM6ClU91FnQghsG/wNTYVps1jDUTpGp349v
	BMKeY4jVs2xZ9GvgvJJnrRpmiwiU/Rs87FEQnNXL6B5EICY6eb2QxwAny65oCXgwqdXg93OZmmd
	TdIlpw65jVJNEELTsVQSH97XI=
X-Google-Smtp-Source: AGHT+IGBQEHB+W2DqU412BBuOJKBUBJQ/jFdIXBueK1PNeoaBISDGJVlYA2wimGd76m4r1g8O5BBPEdQBdemlTcyDv8=
X-Received: by 2002:a05:6122:2495:b0:51e:9efb:a23a with SMTP id
 71dfb90a1353d-51f0c48272amr3065522e0c.5.1738782024956; Wed, 05 Feb 2025
 11:00:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204200250.636721-1-jic23@kernel.org> <20250204200250.636721-7-jic23@kernel.org>
In-Reply-To: <20250204200250.636721-7-jic23@kernel.org>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Wed, 5 Feb 2025 11:00:13 -0800
X-Gm-Features: AWEUYZm11uVtWQT406zD7uf-ggayszWbXmQsYI5Rpy03tWjND42kP3TuDH7WdyU
Message-ID: <CAPUE2uu8VhrnZ42LhUwJtN5WD0932WmbwCyJXiM9jbjVQuvt9w@mail.gmail.com>
Subject: Re: [PATCH 06/27] iio: proximity: sx9324: Stop using iio_device_claim_direct_scoped()
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 12:03=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
>
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/proximity/sx9324.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx932=
4.c
> index f7819dd2775c..73d972416c01 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -429,16 +429,23 @@ static int sx9324_read_raw(struct iio_dev *indio_de=
v,
>                            int *val, int *val2, long mask)
>  {
>         struct sx_common_data *data =3D iio_priv(indio_dev);
> +       int ret;
>
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW:
> -               iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> -                       return sx_common_read_proximity(data, chan, val);
> -               unreachable();
> +               if (!iio_device_claim_direct(indio_dev))
> +                       return -EBUSY;
> +
> +               ret =3D sx_common_read_proximity(data, chan, val);
> +               iio_device_release_direct(indio_dev);
> +               return ret;
>         case IIO_CHAN_INFO_HARDWAREGAIN:
> -               iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> -                       return sx9324_read_gain(data, chan, val);
> -               unreachable();
> +               if (!iio_device_claim_direct(indio_dev))
> +                       return -EBUSY;
> +
> +               ret =3D sx9324_read_gain(data, chan, val);
> +               iio_device_release_direct(indio_dev);
> +               return ret;
>         case IIO_CHAN_INFO_SAMP_FREQ:
>                 return sx9324_read_samp_freq(data, val, val2);
>         default:
> --
> 2.48.1
>

