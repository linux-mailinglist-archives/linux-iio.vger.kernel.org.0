Return-Path: <linux-iio+bounces-16160-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE6CA48CB4
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 00:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C27617049C
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 23:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8249276D0C;
	Thu, 27 Feb 2025 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydAyX0rq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C817B276D02
	for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698433; cv=none; b=ZVYB7lm53Ozskye/GEIKKcjiZ9UaqReNxIQGHy+xsqqdzM3kwqk6YCu/cE2ZN8BOmGmkeI7QR9MwueHbdSSL37/wtUibx29xLp2rt3O4tz18Res6ccK0FmoiLrH+uTfpN13lX5Aie0zoGzoSqmjxB+8I8PB13CQLrSFMedIUaEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698433; c=relaxed/simple;
	bh=F5gFWd7NyXBKKAhyQwBh6+sD2PO8dFaOkquGSGOTL0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mg0CEGMKDJ/Y0Rv9bJgxqdkWl2MCbUnL9KXBSVQjzF++OKDWi1h+zA09uwFwslD3x9vn381o9/EBZK74UW6RuHEK28klDrv9yoOyFX+14NqFxumpVEJ5ZczNL4XRhQQo4EyDjE42blqef2ww9CI4dZ8QADETtpmYx7uoChKvP84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ydAyX0rq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30a2cdb2b98so15034701fa.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 15:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740698430; x=1741303230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5gFWd7NyXBKKAhyQwBh6+sD2PO8dFaOkquGSGOTL0I=;
        b=ydAyX0rqxF+fCL5DFU75Kco/rsfV9k6WY4TO1ASJLJnRRBua+4iriYMX825d21315K
         mS5QuZy413aAmsTzKAgqOgSUpdcoD5BgmvuCvTFAsiqvA2T4L7uy6Mc4RCGcgI+/BQEf
         /Aagsr4k5DpCdyamDh4wpcuTHM/v5NUmh0SJFvLnH/M0IKlwKtxzUIvtiYZqew5iulGK
         9hqQre+HivpL2tSLFZnc82g1mR269tjLhfNElixiYFQIKK0f3BhxmJbZVNymmbF0+yuN
         iZ0JS0LypFDrHXR0No1luBdDco87r6vz83z4+EWTnFOByNX3zeHwP6PvpYiBX0teaO54
         gEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740698430; x=1741303230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5gFWd7NyXBKKAhyQwBh6+sD2PO8dFaOkquGSGOTL0I=;
        b=OhFmfvQoGyE4Ie2uSxacm/Ru0/puMpMiUkQhd0id5n/Wnpk3Zdh0xSqwSYSdSRPbMJ
         TaR5IU6Aezz/aQnXUlPkNn1j8+Ix5pwJMcmIT8IP4UYgp7iHkiYoKyNFLIu3eagozybL
         oWc5V/7w24Co3mmyDmNXB4/OKEHPoZiV3VJxRNNwq9KgRlLLd2H1gQ5UeoxPK97fpnu/
         XIl/89Mm0ZqJAAUjdYCE9BNdo4+XLKH3OjpCLCvp3RzDtDVCsmwx9a05ylavtgBrxty9
         fgLMPvRaKMlbWZHTQag+Mch+k9tx30yIBBcisjeNOY49XOZrWd7v3Ik+1+XlTIvrOWl2
         lzsg==
X-Forwarded-Encrypted: i=1; AJvYcCVQl9BlQ9slnYprVTdiy3dVetmOVEZ7eBerHZY7RWKr3QtBVcvYcEMKtOWg6uNNEsKL4Qc6xiZ+4uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5n9XiTQzxpoVB/t6mfrvelsFv4D4GDnKDudpxQVaBfZs/ozf
	vHU82PyEmEKk2mATTZtjKbvOy/Tc24h6acFcPBnjOd5uUMCbnp/rG0kqsnAd8BKFfpahsI9n+bF
	upOLBli6piU+U25F3W5ANCJ+oGD/zKHtAKoa5iCuSpNzxKp/w
X-Gm-Gg: ASbGncs7NaekBD08u6rMW1w7svgjdAbCroxAACO34igYCLu1qHPE8vmVz4gg51jhuEF
	4B6Y6ew3ZEfP7kGd3al5C6FiQ1gMVKppOY2dFpkdQ/mcd7ZdvLH6hU3Nj/LSOhfOkfuSZ5giGbc
	rkNLXOz3Y=
X-Google-Smtp-Source: AGHT+IEk5RLYsoUHPzpYi1wiTH6QnjSPGHmuyXIkvEEGGR6cXNNFsRxuzVVGZXZ1pmZBSLNOo5vjsFK1Z56RwpC4YKU=
X-Received: by 2002:a05:651c:509:b0:300:3778:4dbb with SMTP id
 38308e7fff4ca-30b93212bcemr2482041fa.1.1740698429854; Thu, 27 Feb 2025
 15:20:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7xGpz3Q4Zj6YHx7@black.fi.intel.com>
In-Reply-To: <Z7xGpz3Q4Zj6YHx7@black.fi.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 00:20:18 +0100
X-Gm-Features: AQ5f1Jq6Kdz3lQwhwmGuCGSn9vJfu8ox17mGres4abdL1zClg4VTMDJv0wNWJsI
Message-ID: <CACRpkda19xw3YSO3wL4FaDVHz4KV5Vrp4vR7PSHn3yLqK20PGw@mail.gmail.com>
Subject: Re: [GIT PULL] ib-devres-iio-input-pinctrl-v6.15
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linux pin control <linux-gpio@vger.kernel.org>, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:15=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Here is an immutable tag of the "Split devres APIs to device/devres.h and
> introduce devm_kmemdup_array()" series [1], please pull if needed.

Will the pinctrl changes come in from some other tree if I don't do
anything?

Then I prefer to just chill :D

Yours,
Linus Walleij

