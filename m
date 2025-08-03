Return-Path: <linux-iio+bounces-22229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA81B19507
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 21:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A232D16E964
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 19:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4191E32D7;
	Sun,  3 Aug 2025 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmFbQZNF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3005A2E36E8
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754250451; cv=none; b=EZicSOfNbF1j1Bl7+ii3emqZ3A+hDX7CrOdW4GTDjNRJo1sQtmhaoJnUDMNWBaVXc3iOkSAT7SYjLYNlJOyTTeEs3hImMdw55FD3SRzpDjKGUhAQMCmZ4Sr7LuHPtja/nMELnjvZ44uOkINd/cTsHmMmxfbR4G5Au8ke1QbOYts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754250451; c=relaxed/simple;
	bh=krbt/IhEjLFN0UDv/DmDrmnzkvsBjagQ5FxSpGQMfFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDgaw6YIqHqrPa7CJA/WP8rmCSjee957k1UgPx3+RgjhsAHQmUl4Log7aVbJhEgEhBjZaYvCl9x7M4w6ZGYwJ5jzKjrZqeyvFmiHDKkNvNtKTP5Sc+7ju3WFC/+VFagAZxVsRvprhTKEIP45I19rhylO0FMyB8rMFoybSgpFq5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmFbQZNF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae9c2754a00so921622366b.2
        for <linux-iio@vger.kernel.org>; Sun, 03 Aug 2025 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754250447; x=1754855247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ejlxk3BZjkFz9xKUl51RVklJ1o0h834VhvaQjAtWiAE=;
        b=hmFbQZNFb6WMzwTzDfqL0B0WNjupYRBO2OrIANPt2WILkE3+pIWF2RuaDSp4bdAOiS
         u9TbhASpAA0iIhPK4WeGpv2eVi2fFAoCjsanYO17DGQ4MACdK0CQXUL4ePu8c0aU317M
         ZgdVvkYO3BlxB/xl+kdGnRjyG1MnUEZuoLBT0VSDqHmImD9dlYMEDYjkDS/nvV1Htjuu
         AdUITpGr8LO4ZFFWtsP9TKqv/dpVdKDVzlTGvB3STw5dgNk7o3FfMyxEeBP9pmbI/rBW
         lRj22GjllyFdWrikqTqTo/xwc7q08LKYY/BxPmUAU6VF12X60DZUahMra/JqKKNu8kBx
         9Vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754250447; x=1754855247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ejlxk3BZjkFz9xKUl51RVklJ1o0h834VhvaQjAtWiAE=;
        b=Z49lTsow4rqVJDrj6p7Ta4iLKGN2ZUafeUlC00E//tdaWmzgk9qX2XcVa2mJtKDLxM
         QEJgDDpKyBiX35CuA2YNJw0z4SDFkFX/OB8rn3MYTK86n06m3ECiMch9j5yu0CHkxwwK
         b5eINCXawrlndZoYwhRiMLraFdssJ3eGabbVfSA5vgwR5ay88UHe6h318qdIfiqtRu0p
         Lzkj8ooZaYR2Cw5+yBQ1CTvdLazSgtejhLyooDlF7h/BvLvhIH8hyZAQwVS05La9ysMW
         bGdGI5pl0+HLNkIWb2nVIUdHCcI9oUgE8SOsTgYGiDK4/Xg+RnmOlKuFKuriySzTGzpu
         Qcqw==
X-Gm-Message-State: AOJu0Yx/YVVgTerF5ut/wzBwH9NQ0GTLZiC+luzhzyvP1VU5Hcw1hqie
	qZHweQ8g7VE5QZ9gnjyVfsxNnVx8W4vdkeYQSVVJm7JdVKrREs37JQWhK7+S6lD7bzEUJTyqFme
	fwQP6FqsnNnarb4DSnz5WFVWDKhcTt22vSP5HEs8=
X-Gm-Gg: ASbGncua61RUoVluFRKz7XNQz8kqNHb6J/u/Skk8Tr1RzewTZsJzDmo9aLYVcJBTuLQ
	TB4EFALJKwvaj5Gjxp8+rxcnY50xhKeHmF3HlymbSAXX9fE60xPxbjYaNmicY8aYnpVQrG847Xc
	LiADkFcE3LU3An+1cPIEGtkcwoZrz3/+TQi+dmCw1yqfWOmwo/j1Agfws5+MloqV8pVHRqZ7CwB
	uSzP6EBZs3vMiKu1N7r
X-Google-Smtp-Source: AGHT+IFHYhaZewS9Vs3z81aYzdeseYGQ818N7nIxfZRxR4IxnjgaNa+gDWnr3r0uS3IolAqqN+Adk3eHO9o18bb09Bk=
X-Received: by 2002:a17:907:3d05:b0:ad5:2328:e39b with SMTP id
 a640c23a62f3a-af94016b21cmr737885266b.31.1754250447375; Sun, 03 Aug 2025
 12:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802171539.518747-1-jic23@kernel.org>
In-Reply-To: <20250802171539.518747-1-jic23@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 3 Aug 2025 21:46:50 +0200
X-Gm-Features: Ac12FXz8ARTrr6HOYdZHb-VEYvKkVIwHeTGuzAiJUn1Geux9H2MRRYNpZc89RuY
Message-ID: <CAHp75VfuLcV5Bv1WG3hbRr3P1-kxusN1Gf2dge1mC68cYGfxvw@mail.gmail.com>
Subject: Re: [PATCH RFT] iio: Fix core buffer demux failure to account for
 unwanted channels at tail
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Shen Jianping <Jianping.Shen@de.bosch.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 7:15=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The IIO channel demultiplexer code is there to deal with a mismatch betwe=
en
> the channels captured and those requested by user space either due to
> driver supporting only particular channel combinations
> (available_scan_masks) or due to multiple concurrent consumers (e.g.
> userspace IIO buffered interfaces and an inkernel consumer such as a
> touch screen).
>
> Whilst this code is exercised by many drivers, a corner case has been
> hiding there all along.
>
> Consider an input of (postfix is the channel size)

size in bits

> a_32, b_32, c_32, d_32, ts_64
>
> and desired output of
>
> a32, b_32, ts_64

You missed underscore here and below.

> the current code ends up with
>
> a32, b_32, c_32, d_32
>
> because of a failure to iterate over the tail of unwanted channels
> (here c_32 and d_32).
>
> Fix this by adding the code to walk the channels in the gap.
>
> Reported-by: Jianping Shen <Jianping.Shen@de.bosch.com>
> Closes: https://lore.kernel.org/all/AM8PR10MB4721FB1A78F25B204BE3A26ACD5F=
A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM/
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Fixes?

...

> Whilst this is being tested I'll try to figure out a Fixes tag.
> There is some code movement so needs more digging that I have time for
> today.

Ah, okay.


> +       /* Walk remaining bits of active_scan_mask */
> +       in_ind =3D find_next_bit(indio_dev->active_scan_mask, masklength,
> +                              in_ind + 1);
> +       while (in_ind !=3D masklength) {

for_each_set_bit_from() ?

> +               ret =3D iio_storage_bytes_for_si(indio_dev, in_ind);
> +               if (ret < 0)
> +                       goto error_clear_mux_table;
> +
> +               length =3D ret;
> +               /* Make sure we are aligned */
> +               in_loc =3D roundup(in_loc, length) + length;
> +               in_ind =3D find_next_bit(indio_dev->active_scan_mask,
> +                                      masklength, in_ind + 1);
> +       }


--=20
With Best Regards,
Andy Shevchenko

