Return-Path: <linux-iio+bounces-22311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E870B1B4A1
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 15:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9791118A4C18
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 13:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012F5277003;
	Tue,  5 Aug 2025 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T49CCZYf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308D727510C;
	Tue,  5 Aug 2025 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399626; cv=none; b=tt/Y7Fv1qGiYEoInwuxXWQjdE17Vs91yvovfUcx/rsfJMq53L2V4S/7+Wg8rq+fVf3yVsHtC+Z+ttRbqV9PzWzPYRsHA2Ty8IYQB1mV4xUGareGVd/F5INKbgbTRpU3/2Tk2DEo4EP3kwT2cZGCOk6cxEayeRi6T8MJeefMlwFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399626; c=relaxed/simple;
	bh=iUmfRK7Yn0oMF1Qo7GvW3i3Z6x6LFyVUCrNp+rmkznY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxBfAppxlqQV1yU3n/vOIScnHE0F3gjnlYd8WxroT4f6SNkDatfJoTwIWg1Hz9k808C9xwFH918W53789Yld2xVumjKDwBXN7kuGqAWCsyPv+BOFLmErF+yldQrdzx3NFuFd8ivwVmP7TQyY/7eiIQHE98yZ/4u40c1n8BLwNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T49CCZYf; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-615460d9897so6468293a12.0;
        Tue, 05 Aug 2025 06:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754399623; x=1755004423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaOuyIHTmK9HSHFptV41yWxML0J6/z2Mgw5sUEoSVdg=;
        b=T49CCZYfrEQxTNW+8UUzsIs/WjvF64GG5gOR3+Ak0u7VJKTqMX3hMkp2cYaJDD35uS
         k2hbzEP0hNmPrJxOmKOU+lRhdEaXGmxgIt/MHZrMkuyPgsub/p/l5IJcpHoDLGmbL4Gz
         GS9wcStkfTOUPUQlMG9dQIHQ1zVPIHhDWj5vxBkIKW7MrqM6P53wdhibCoO96mjbdfG8
         7Gs38pExi2kA7DTgDjr57ht2HRFlldHP/Pd/+qwi//MUWoHc9CgX7scdGuZV/xKWueaL
         3mIH1EjHIBBwPyN0ufNMo6yzkrG7VP95b++kWwcSHu7x2CvgBIYzB5QQNSaWEVeymvro
         aRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399623; x=1755004423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaOuyIHTmK9HSHFptV41yWxML0J6/z2Mgw5sUEoSVdg=;
        b=HqGl4WqDTgRz+ESX4dLn+Yho43rOrUK5/Sa4tbihAyzXrc42cN4kfw8GkwcD7tMaGI
         Quw+OF07vdgwf72amdOhDtxRRkKm7dFcfs/lzwadhI7GAzMIWe70cUTf2KXJRVKpH4sd
         OC2d+XbYqviDMgfKHZ2iwozlYPUCE09aFIlaFAilZ4FEezICY1jwxTu4lOf8e4M5heiC
         KdX/NqQ0yPfXVzgdzaLBrX0qThaqLESZ2A8Qn/b5wQoCjOxftfa0lkAjSjdetNf1MzpC
         B7SBx6JNjSdUcG8XNbEZk6BMrrHro8plIpFnO5NT6ga0e3kqs+nUlP/B2aktglE7UlRJ
         Eaew==
X-Forwarded-Encrypted: i=1; AJvYcCXVHU74cd7N/p8vZzKfCWomOvMJYIj8I9KPkFfihbf8GdVmp4O6sPoed+9c70efG9OtAHkis67lekGmFRZO@vger.kernel.org, AJvYcCXhNdLfuukaENTLbcFGeLkgZK+k7FOqmW/kDrOEpge4AS4N8LiZf+XJ5WdzqumvBKkxFg/X/Qa2WdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzEMBOOxXRr17h9c1WgQEgsfI53YL/9zUWoBgq4QFpe+32nbbq
	UwfcoWdkQlqhxLkyWEayyg0QHTsJMqGwT6/Pe8Rt6xetgWQwZUqQ+4iU/ljTZ/qklv6Vrh+Vncf
	37X+Jic5FIYGuDc/pGK9KKtlrO0R/6B4=
X-Gm-Gg: ASbGncur9bX8IU4zsDfqun2uVYWnAM5gQO4WfhYS+y1Xk1BHK8w1alh/MRB2ICbsEui
	JuhhJBl6nHWcxGr4YEe7OjOz5Cg8pd3LLvQpxhzKwfVkCP/pK+2IYlw1zMx1rAOSwGQ+jMq5HT2
	+EizSgV28cBNakkoS1A3PyECtqNoVzefVkvE44z3PpXYxIG8IqxIqYujkZtyh7GzGks4eiNyz4C
	s3ugnyCxh+jMebQSg6t
X-Google-Smtp-Source: AGHT+IGGau0JaddIGiJL9dkAZZR6/DOBiDD6gXHxOfw+awZqPLbkj+6/f14g+6uRL/V+nsQrRnbNgqrqvP+1vl3dyQU=
X-Received: by 2002:a17:907:2d1f:b0:af9:3ef6:86f4 with SMTP id
 a640c23a62f3a-af94001e7d3mr1532662166b.20.1754399623444; Tue, 05 Aug 2025
 06:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805142423.17710-1-stefano.manni@gmail.com>
In-Reply-To: <20250805142423.17710-1-stefano.manni@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Aug 2025 15:13:06 +0200
X-Gm-Features: Ac12FXyVCDTAR5h0FT-1_BJkfiQIKDeAeEYbRmtaE0EINzdk4axA3Cee3AjMpzs
Message-ID: <CAHp75VfCL88GMSRYnJ+wh85Yj_RrBztSLWOvQJTapVdgFerMyg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad799x: add reference supply for ad7994
To: Stefano Manni <stefano.manni@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 2:28=E2=80=AFPM Stefano Manni <stefano.manni@gmail.c=
om> wrote:
>
> AD7994 supports the external reference voltage on pin REFIN.

...

> -               if ((st->id =3D=3D ad7991) || (st->id =3D=3D ad7995) || (=
st->id =3D=3D ad7999)) {
> +               if ((st->id =3D=3D ad7991) || (st->id =3D=3D ad7995) || (=
st->id =3D=3D ad7999)
> +                       (st->id =3D=3D ad7994)) {

Instead of making this conditional longer and uglier, it is better to
add a boolean field to chip_info and just check it instead. This will
remove the churn when any new chip will require the same change in the
future.

So, please make it two patches:
- introducing a field in chip_info and use it for the existing cases
- add this field to be true for the ad7994 case.

Is it doable?

--=20
With Best Regards,
Andy Shevchenko

