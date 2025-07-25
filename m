Return-Path: <linux-iio+bounces-22015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B48EEB11A34
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 10:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90AF1CE113D
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE151EF39E;
	Fri, 25 Jul 2025 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxaoUDiL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570761FC3
	for <linux-iio@vger.kernel.org>; Fri, 25 Jul 2025 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433281; cv=none; b=jgoj0vonyNu0s4SLAFX3kEt+WBJXGZojm01mNYu8VSeTAEqWbCF0O1TlFnJd5aLh0Gn4o41tAE9yyizS6nbv1AHlJFQazDvgNt/Y1IKzIBBz6qS/1rk84rFjZWL0wq0ZoDenBChNvq/87ragSSjp/Sg0hYoxDwLAAKvROnkwbfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433281; c=relaxed/simple;
	bh=csD/sF4yG3YfzMthVQcKB5U9UpWM9MAwFR9TbE5KZNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XypV8bfXzPnnlfwOz8WINQwLYwNsNVLyooCuJDNF5ODTRP+NhGH5peZalOSbJ4jlNp3VrNHmzSHT9uAIkHrLZAYit1Z8yBzk3UksfBFRlR+eP7vyX85e2bICOuqxaPNj4kLnEeuJ3upjn/uWTucJJ/W8ymDjNvTwKdO07tLqIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxaoUDiL; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0c4945c76so265322766b.3
        for <linux-iio@vger.kernel.org>; Fri, 25 Jul 2025 01:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753433276; x=1754038076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+znwi/mxIg/aCKLJgbIYesuQIwDgClwAVNM/hH9tiQ=;
        b=BxaoUDiL0c7H9wBQXApc1WEMO4idmLbVxTec7waH7VOi+OkpLgBcuvwk2orTjr9ayW
         5cI6f2DU0xltpdkOfqAi4LL6uNiWYIM9f7BcPX0jzh5RoaEesG53xiQ5vkrlodVBxB9y
         L6b7TCk7AwgeZkYxGShQjwQKRNn1OkmAt1ukPZpM1C+DeMVlMfOX84MOWxE51ceDXe2W
         KNKdMfEVpB5LXk18efZa6lFXBjmdNy88t5xwK+v3jeU13pRWqMtp/+2bVbYG47RI24cE
         H/zS7q5azCQcr2fDDYFl+dkj7OUQn06vIkp3ChhUfUtE64Kz/g0oDxq8QfHX02XOKyLu
         WNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753433276; x=1754038076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+znwi/mxIg/aCKLJgbIYesuQIwDgClwAVNM/hH9tiQ=;
        b=mh13XfRGV/lMpXS+lxpQDHMyEbDzE0V/8Ay+6DYXDZF1785//7k4gOMP224D8m6Sx4
         3i3oYulViJT7cPN2tKc4GUwf0ZrppQCw2Ph3v6zI6/ATjjsfUT31acREaiWt20JCEP4s
         R/g+PsMo16HnGP9cCvysN2ebwKux9JGSqPqNjP+LzNNliRlBNjyrvlqbd1uFbYcSyOcK
         ri//7nfTVQdOPjw5SfWelshSsfZptEkbCHoHTD6C+sR0oRNCFCGabzUhj3D574RZFG5N
         J7+YWTqUvPG1jgUN4JamL8AMcbq3OJWJYpcBAK6mfzs2R4sNcQZxQPTrM6qTv6xN59rY
         SxQw==
X-Gm-Message-State: AOJu0Yzh64r7UI5xBoE/vT5pHo2bhAuDwypSSxFxEwsjE+YfAXMp5qLp
	xk95KjuocHDVdy+0dDYt9k1vYeViv5NeKNt/OzMBXIbPkrjp9cujshkCe1aSNBZV7siH2PfncSj
	l3PByDJsBiT2GqueVAWsseiUonsOgKO0=
X-Gm-Gg: ASbGncsxcmvUFWaMUAJAMjEHM+neGJpXjYK1dgywXxBby9BdH5OakPJrM3npfLjIeZa
	EY1C3g3P5C3bj7CIc9kiYcC3YKbTp06tKRduY70Zirp7N/7VAinH9rzf6/aAWwxpsQc/5lJuynH
	Gq4r7J8iU+vMOdqX/izSBZRo7pCz1gK1G4Lw8tDgjUlqSj+DVerZWAxIm3NA6K1CllfzUEbLxDL
	B+ASbOzk5Q1Vad1Vic2
X-Google-Smtp-Source: AGHT+IH+l4Pt6sSuz/IJFYOumMPTsMcvFdLARLJn+k5EF+YNMAPW3BS520AI0apFYLP+QPv2Ccm1VbErIbmVnI0hfLQ=
X-Received: by 2002:a17:907:3e10:b0:ae0:d798:2ebd with SMTP id
 a640c23a62f3a-af61940ce29mr127750766b.35.1753433276294; Fri, 25 Jul 2025
 01:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725-iio-minor-cleanup-v1-1-4e561372142e@analog.com>
In-Reply-To: <20250725-iio-minor-cleanup-v1-1-4e561372142e@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 25 Jul 2025 10:47:19 +0200
X-Gm-Features: Ac12FXzi0Kt-N6j4oZumPjbnh5mJ6FJhHezbvES9rOpFUaZZoeQKXWv-2ZHPO7w
Message-ID: <CAHp75Ve-ra-SbLv0aV=xaC8pLxGUh54v8rx6GHU4yeDtm8=Cbg@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: buffer-cb: drop double initialization of
 demux list
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 9:32=E2=80=AFAM Nuno S=C3=A1 via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>
> Drop the call to INIT_LIST_HEAD(&cb_buff->buffer.demux_list). That's
> already done in iio_buffer_init(&cb_buff->buffer).

LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

>         cb_buff->buffer.access =3D &iio_cb_access;
> -       INIT_LIST_HEAD(&cb_buff->buffer.demux_list);

Looking at this I think ideally it would be nice to have the buffer
type to be hidden from the users and only available via
getters/setters.

>         cb_buff->channels =3D iio_channel_get_all(dev);


--=20
With Best Regards,
Andy Shevchenko

