Return-Path: <linux-iio+bounces-19974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2BFAC5C07
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 23:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A27616A6C9
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64249211276;
	Tue, 27 May 2025 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbjvdyPx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62941FFC4F;
	Tue, 27 May 2025 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380242; cv=none; b=ReIetJHQc9rkxSc6VvJkz7TTZivgBTmRmBc8oOB0KTu4aKt4irxaxGSGrshF7xIq7jtddxPjjDlY2cjt8UvRQpJj2pmZQ/a8QWb0gTPlIhymhY+Uld8ou3kJLf8+hfAqZcemdikU7j63dhsYTBtkTvCN8K6jvGN1dGGDD18EvPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380242; c=relaxed/simple;
	bh=zCpa2pqyI2zP8sKDp4CTvJFpQyIi80OjbDKWSt2XCJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDcF+y//a/yoYbbwpSJA+NyFw+UBvb0HZWkjY9lD1F07GCmiq72f4lZ+VlJaelkrfbxzkhq3XFmPcSDMi+totOcEH3wySRyitda32/qi2u9zM0b4Rgzg+iSbGH3kdu0RXU7Bvz1penzjoIiyxQZLuZFTgHVOSr8A/xwsuvKuwdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbjvdyPx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3114560d74aso2708439a91.0;
        Tue, 27 May 2025 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748380240; x=1748985040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra/Kzn/tsEt4UqEeAwhyx54MKmURC8T1Q/5luTcmyIs=;
        b=dbjvdyPxYqNLigadLrg5FUTU2Sg2HDlLZpIiOnYsVi/xHRsHTv0kOak1wLBvoK+6KE
         M6+B4u1panm0g0/I08/ZzoRLouD2UfO/V4J8UBsm75E0Tb/5k1OjL6gZth8cmwcwTaXU
         wFUBRyW3p1lzi9Rh3qg/1M12ecanv9GzdaklQ62qecqti3CAyr+tNmU31j+YBNgdviE2
         7toknj5XB422jzoQLsoICF3yFzBbkg9jEwy5KwBj9p6IyR8f0ldQvD3me3JLPcBKxnRN
         eILIq77hzGo5yJBiBWQUqReHn4cx3wChS/Gxm9fD8pgqtJzcsa9X8bGiBsDXZJ6gJjyf
         6vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748380240; x=1748985040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ra/Kzn/tsEt4UqEeAwhyx54MKmURC8T1Q/5luTcmyIs=;
        b=KuglWoY8GRTXtSXEqlaUFTvFsC+L0BBVvquWd4GxKoBeqZxwnhrRtjX2fpzXqxqaj3
         TMYXiafbOEmty/C9gfiVpZ2SxONuZcNOqwgK3BkzxkgpMrN1hd99R7VdfCUDKEQD2tH+
         mLc3jJLHDvXamGupnR7FY6UaInRRbtfqld4uZiWlBDX1qkw9gJOtY+mpwcBDHvQv3txF
         bLuhzEo9TGl39EOPZuG5ZAMXy+qFQNLn41gQTSrXeHz4HY6fX+hcmHqCyqdlRAlRnDqF
         mI/La/ti1VyRswrajHQrzVa9FTXupeoRzG3shyWLCpmdjagHxnCS6JYjLYKum53KmNZp
         6bPA==
X-Forwarded-Encrypted: i=1; AJvYcCUsIZwciW9IJQZSGiV8h0MdB42hp5O3OOoy+onFM7/y5PXRcHVz3quM1UUwigdbSx9PIq5wgik897o=@vger.kernel.org, AJvYcCVqpy2dOYfRBf/Zez6wrP7vnB+D5GKyiNeLuIsJf5fxXIXHeiasMTkaOmF36YA18JcQuAu0Q7WrYjTdkybL@vger.kernel.org
X-Gm-Message-State: AOJu0YyU6X8wzcsEqTv+Ecez941HsfziKQZmGXD+w8RiF6XR+Z03dLDQ
	ofy8YU6iHnJlE7/+RuM4UD0Qe4snTbrtWPcoEXW5SBTiUw5c8517/wpZSf0VLjiJ7qtYhiKtI0X
	7nhkxtCPufyX0EAgj612keluYcyxy7oM=
X-Gm-Gg: ASbGncuwZs/WPb9fWoB78K+eQOyN5+3199UGR1/mNUOJpcdtzll7zRgDDnuDozxed9x
	6miInl6kB+D5pXQRZy/EKU8RctgsANMyyZr4iN5gLjZmUWsQeMPkvcy28ZULicruhYLkiIUvEA9
	Uo4cvRJocc4OiMaiPKC6wd/QuF6+pbCXm5bA==
X-Google-Smtp-Source: AGHT+IHl7P715WOF+LWqioosOOq3h5WiYgB+6CL8eDZad3EuHhNMuisn5T9/tqND2t4UBilrDM8H7rGnOyMxt470NGo=
X-Received: by 2002:a17:90a:c2c3:b0:30e:6ac1:3716 with SMTP id
 98e67ed59e1d1-3110fc03f88mr18789493a91.34.1748380239820; Tue, 27 May 2025
 14:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527200534.98689-1-gye976@gmail.com> <CAHp75VcUr7-X+F1f=wPH4=Z7q3kFffv8BgkmKWM4VTjy2w-tGg@mail.gmail.com>
In-Reply-To: <CAHp75VcUr7-X+F1f=wPH4=Z7q3kFffv8BgkmKWM4VTjy2w-tGg@mail.gmail.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Wed, 28 May 2025 06:10:28 +0900
X-Gm-Features: AX0GCFvB4TCZpBHeDE8nL4wxgndVCu-VH6I0tAyloGsL1wNjNLRxFmZlXW9TuoI
Message-ID: <CAKbEznuuGX3Gnqg6WF2mqbigRps0gzK_PfGHGNy8-v1WOZoMUQ@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: Avoid data race
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 5:25=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, May 27, 2025 at 10:05=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com>=
 wrote:
> >
> > A data race could occur between `atomic_read()` and `atomic_set()`
> > Use `atomic_cmpxchg_relaxed()` to group them atomically.
> >
> > Previously the main logic was executed when `use_count` is 0.
> > Now it returns early when `use_count` is not 0.
>
> > -       int i;
>
> I don't see the point in changing this line.
> ...
>
> > -       int i;
>
> Ditto.
>
> ...
>
> At bare minimum they are not relevant to the patch change and haven't
> been described in the commit messages.

Hi Andy, thanks for your review.
I initially skipped this part as I thought it was minor.
But on a second look, it seems better to separate the declaration from
the logic.

What do you think about the data race logic? Would it make sense?

>
> --
> With Best Regards,
> Andy Shevchenko

