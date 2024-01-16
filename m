Return-Path: <linux-iio+bounces-1717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6145282F434
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jan 2024 19:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC66B21DB5
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jan 2024 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7627D1CF99;
	Tue, 16 Jan 2024 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzTICfnb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D21CF8F;
	Tue, 16 Jan 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429624; cv=none; b=Iepk9MK4L2v2ud6x0C1vvGGh28c+NLBMAYMyFIZEy064M7YAA3qE/IEcmfG9zVXbWnKNxuygjbeh4CesmPxVNKH8hzuRj4GmFAuehfpZZdAh5SmQqsMxJxB3qFAu3hlIsrpaT6DkOyOtCX8CYHYDHxenoIw9BpPutd4iij8wGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429624; c=relaxed/simple;
	bh=taELUrY69KcHAXLRi5qbEgOkPnQr+NV3fILPPJfZOJA=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=pKh118Wfvy7CD43p9nVS3VayOHDi3+JO8mGGcOP9k9WcuaxBKn20X4etjNakUbpkF2v7q726COkvkPlmjoEaNDw63riZT/9mtiQLomIy8CddK8BPz3dGUnGD/NYFN70xJqmjfgjRGnnaWpnDBfwomsac8Xb0+IymnKVt8KQ3me4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzTICfnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8736C43330;
	Tue, 16 Jan 2024 18:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705429623;
	bh=taELUrY69KcHAXLRi5qbEgOkPnQr+NV3fILPPJfZOJA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZzTICfnb64brOegVh2Kv07G1+DW09K+eOkWnEXOAXKGvX4R9q5i8ZqbLM2kLHzNb0
	 l4YjVqsHSsRnO27II3HgcaMlH2qVWzVI6qRrIL12nt5wXPnjrDJbMnRmnNaHpRqz1K
	 zUQypxZuYQkRXWrKgByUX1k5Duh17YfDlTG6JVHwCiptcHkvZiVoedCh6pWy0zjf2V
	 P8Eh2gw1k9XYUlo/Sdk/TgU8gQfML7dvwfIXFJJ0gsR2JXfLNAKXz2jihA8WUFQpl4
	 wc5zflCEt2lATFHc9zEKh1zhbRb1AD90Z3slqJ7Z/bSm5JU4cBiVVY9acCqqhFaM57
	 tl3E1oPLVwerg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cd64022164so118923581fa.3;
        Tue, 16 Jan 2024 10:27:03 -0800 (PST)
X-Gm-Message-State: AOJu0YwphRppc5Q5CpjTZs7JQELPt9K9hjZsPms3b6NvKg5pkJ1egI4c
	5/oAdCn1n4CfDaY0O5noAIYmQLDIJjIY3WsHjg==
X-Google-Smtp-Source: AGHT+IGVjOVbKIhhQDf0snPwfmdER0IRfYmM/jUFpgoBhZsYv/IAdKdyrKk4nUXn8nuydufb9LH/5OhxnvSTtpU6w8w=
X-Received: by 2002:a2e:a4d5:0:b0:2cd:a2e:fba6 with SMTP id
 p21-20020a2ea4d5000000b002cd0a2efba6mr3711751ljm.11.1705429621748; Tue, 16
 Jan 2024 10:27:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240114165358.119916-1-jic23@kernel.org> <20240114165358.119916-3-jic23@kernel.org>
In-Reply-To: <20240114165358.119916-3-jic23@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 16 Jan 2024 12:26:49 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+vsXgBYtj66NG+3eZM-9gGw4QkU-bpn+JprAmG+UWmTQ@mail.gmail.com>
Message-ID: <CAL_Jsq+vsXgBYtj66NG+3eZM-9gGw4QkU-bpn+JprAmG+UWmTQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] of: unittest: Use __free(device_node)
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Frank Rowand <frowand.list@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Sumera Priyadarsini <sylphrenadin@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 10:54=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> A simple example of the utility of this autocleanup approach to
> handling of_node_put()
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/of/unittest.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index e9e90e96600e..b6d9edb831f0 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -233,27 +233,23 @@ static void __init of_unittest_dynamic(void)
>
>  static int __init of_unittest_check_node_linkage(struct device_node *np)
>  {
> -       struct device_node *child;
> +       struct device_node *child __free(device_node) =3D NULL;

In another thread[1], it seems that initializing to NULL is bad form
according to the chief penguin. But as this is a refcounted pointer
rather than an allocation, IDK?

Rob

[1] https://lore.kernel.org/all/289c4af00bcc46e83555dacbc76f56477126d645.ca=
mel@pengutronix.de

