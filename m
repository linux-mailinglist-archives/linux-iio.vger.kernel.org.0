Return-Path: <linux-iio+bounces-21784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2115B0B451
	for <lists+linux-iio@lfdr.de>; Sun, 20 Jul 2025 10:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF39B17560B
	for <lists+linux-iio@lfdr.de>; Sun, 20 Jul 2025 08:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CAF1D5141;
	Sun, 20 Jul 2025 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YoAYaHjM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CF9125D6;
	Sun, 20 Jul 2025 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753001338; cv=none; b=bD4r0WY9yZeAjowisJnJ4zOCy8/3Oj7w9PeOQSNhU4uNX5R0AcXoREfyoEr4aNEUaIgaarGeG//M7885hnsJskRthVMlRBijSWk4pp6dwNvMQQ4rx0ZLz24VbhDqf6AsvHKDUsrJhGfqXULeJhAMu3ar15+xltT5s6fuB5wRZOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753001338; c=relaxed/simple;
	bh=No2sk2IuIhzjEyWFsf9BPzEmRbKad5ko+vVn9iKWiWU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=eBKfKSxn5KDn4ab1iGfT620RHLv0aHzuEFo3d6GLTTv3aIAQxz7HIB7/5r1zlQIapIt0lH94DisvyRY7rF4G3Js+tSvh9Am1KgJWfMttBBxEAALVtOYOyogdRPOVhQxhrA9+7wDeR1RP5v1KYWdNc6WcapeRLYeqTtZ90yKxntc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YoAYaHjM; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753001324; x=1753606124; i=markus.elfring@web.de;
	bh=rscPHLErhSJ8FVJqx7sMwbc1IoevGkE751ziuG863K0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YoAYaHjMSmcWx6DluHTfBXdvU2iTsQGph+0Tz0pPqTuj5J0EehxvY95q3vbtrZup
	 R6+w7xscIebELg6wMitGa+Aw5VTa56lvDie9gqRG6vOPtLP1RcVYjHppFz1eGFmsF
	 Gq7tv9Uol13Gy2b0YYTt+gEgncCuuzgUSnYVuwuf94j5zmEphQe5RsVx/VjNFwlN1
	 k8lThY4SGZbgJut0DNiWzp5sw/2LE8y37JfYegFMjy52ugDTchH1dvu+dvgwk4aO2
	 sw52+12zQZOl40AimZdKso1RDI6TIiIqEMXtBpH1oxyE0YPmowrdM1BsVmo4dyB+b
	 R123Ohc9AOO4op6ffA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.216]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZB01-1u8wP437xZ-00IGzN; Sun, 20
 Jul 2025 10:48:43 +0200
Message-ID: <43ed8918-0116-4e8b-943c-2e62906b1fdb@web.de>
Date: Sun, 20 Jul 2025 10:48:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
References: <7b2fec30e9c6a80630a5fc08fb061d17417eb350.1752956751.git.marcelo.schmitt@analog.com>
Subject: Re: [PATCH] iio: adc: ad4170-4: Correctly update filter_fs after
 filter type change
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7b2fec30e9c6a80630a5fc08fb061d17417eb350.1752956751.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LmihGFOT270cJbHbLAS4lGTrz9J/5b57tnDBSVFRjmDk1pIo6vU
 svolSANHv7W7mpTLfwSUpuiuKLAAVf/BKbd0v/hi3vJmZ4LwEJU2xvegNvhQRlapXrMdirM
 QUOd7xaxJYIIt9sfUD6Fz4d43KkU7SKvqFo2pMSc2yW/u4cYCK/Q8i3RD+FgtVkfFSOUqil
 RQUL9atgBLMFuIDDLc+QA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JzGbNqcT7jQ=;7IwtuAMD2GwwjRPavG3cqkYakxi
 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

=E2=80=A6
> +++ b/drivers/iio/adc/ad4170-4.c
> @@ -880,10 +880,12 @@ static int ad4170_set_filter_type(struct iio_dev *=
indio_dev,
>  			return -EBUSY;
> =20
>  		if (val =3D=3D AD4170_SINC5_AVG || val =3D=3D AD4170_SINC3)
> -			setup->filter_fs =3D clamp(val, AD4170_SINC3_MIN_FS,
> +			setup->filter_fs =3D clamp(setup->filter_fs,
> +						 AD4170_SINC3_MIN_FS,
>  						 AD4170_SINC3_MAX_FS);
>  		else
> -			setup->filter_fs =3D clamp(val, AD4170_SINC5_MIN_FS,
> +			setup->filter_fs =3D clamp(setup->filter_fs,
> +						 AD4170_SINC5_MIN_FS,
>  						 AD4170_SINC5_MAX_FS);
> =20
>  		setup->filter &=3D ~AD4170_FILTER_FILTER_TYPE_MSK;

How do you think about to use the following code variant?

		setup->filter_fs =3D (val =3D=3D AD4170_SINC5_AVG || val =3D=3D AD4170_S=
INC3)
				   ? clamp(setup->filter_fs,
					   AD4170_SINC3_MIN_FS, AD4170_SINC3_MAX_FS)
				   : clamp(setup->filter_fs,
					   AD4170_SINC5_MIN_FS, AD4170_SINC5_MAX_FS);


Regards,
Markus

