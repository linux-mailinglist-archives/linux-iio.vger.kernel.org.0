Return-Path: <linux-iio+bounces-12762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585549DB2E3
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 07:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5B4164D8A
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 06:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3978C145A09;
	Thu, 28 Nov 2024 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMractug"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C013B590;
	Thu, 28 Nov 2024 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732776465; cv=none; b=E0FtywHgbqDNyPj1nPSbgJeQOxmdI0dRzncTqOdCC+alSGAY0GBTDslOoHnT50H3MVhbHqpTDu8C1Bj4WKmTg07w79sjkIpSKZwqU4fkttjOgEo+CUifgfttVf3Ma0FowiZKyBVv++zjHdvaFuI9UdMbTkNrAwZ2blC90Sevp9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732776465; c=relaxed/simple;
	bh=jBXgpaQP1eI/KCfl+2JBXjAOMn5OCahmtnPqy7Bfc6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M10xG3sF2svQcQWl0JyrABBvv9/H8sa4gUH4lPfVQ+aI4Yxpo2/Xc3nCMpgpWnOEvogeC8CB2Plmt4KNVam2DPyPfoiinwCKsVfslT3JrTxqNVH4xJgkdSSt4vV/4y8UOz6FXlPf6pg9QHL5ymKh6SDio+NUYRn+Emluk26awdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMractug; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa55da18f89so66442266b.0;
        Wed, 27 Nov 2024 22:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732776460; x=1733381260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+/onNw4dPtoUj2kkDEjvmidWPXurXnPmbX2bIBEGWk=;
        b=RMractugnNw4nnp3Rf24lIKa1BHfU7/OwKyiCRYACP6OYxy4dpOwJuT29jkHMtCIYQ
         DrhawK9ogJnvoOGgrKRXloVE6O8XHka3id8e1Izi37JQvYIOi/dF0L4XxXV1R6KMmIYY
         IdoXIqdSol3s36EZ5ntclQD+s1P88QpMMCEnLs6z9Q8GyIRWb3uvWFjBuYIoOjqn//nb
         6WfsfZsogpYEVrdzR79Y9FQ4rndq1DI2sE9zTjaLnxFV3v2OhORCyrSomPgdoZk5yIjt
         dyHs/zZr42Fm+UOJ3ktDNKCJXXMRF6v0lhfltrHI1EhiZJL0W/tZbx6UGxjwJdh2+SLy
         wUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732776460; x=1733381260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+/onNw4dPtoUj2kkDEjvmidWPXurXnPmbX2bIBEGWk=;
        b=oSkKKR5DofWp+E8v2WzEzUai02+/AGq04r3PDzTrvz8twZvJsfBgIoeFYhYW3HQrQi
         DDsG7XvSb688MwfQky/6u7OZ6uUpjMAj3/xA3J/7330/SlNLKQjARZO+KXP5TlvIBKNp
         YzT3FhLZsmbCTh02wIHJ7fiFEyW79gjT25bOph+GxTzUruL08TjVVcJxo09gifKrS/mq
         63cyhkb9SmqCzeqw5xxQowzFHd9e7hgGRgSX/gcYeCStOs64gyB3McNtx3JXhYQxXoim
         EgP75QCqqXvuwRUXb5M0PMzT4g4aElv7UnSWI9DH4548/4PJLMmT8nDOPeev2vy83xXW
         GzyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoUO7ghbsTrLhmPS/K8EyiIckdDeyTJOwodGOaBmx6MtZgY3tn9zzwv4yVOvIbx708U7HBcmdJeteXh2rI@vger.kernel.org, AJvYcCXeKjPx4KoS14TKXcKr8E25kjyeQWdV/WWINJOBeRcBNRe1p1oSBvHOmzjKdKSY0KfmB9uVCp5Nhzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLoNkpNN76tA6W0/v6DR4fFdwzPmIGKY/IxfQ7T6cWcr9djvt
	MbisDIT2SY9Wmk+03IFTI+ZMKlNYohzbrQkzxQAYRtQ6H1z4hBqqvY05iYKe2pBDMPDqSCpe+UB
	s+QcM3iZt3FCmnxnERpm/3EVZ/PnCic9L
X-Gm-Gg: ASbGncu+WGrsB8445UNXNoazs1jV6cr7M0jrp0eovcZt0KIEw93ZXe7sBwrT8II0aVx
	DVUmIilcPoH0WowDDCgbk/uRKV/m5+vs=
X-Google-Smtp-Source: AGHT+IH3OmxB5ucSHmbc1Jj1mfbiKVD/38p0/X0BMFGgIKwvmpalLAxUbgb3H14UZcyKITQQ9kcgh4gQLij6GblVYAo=
X-Received: by 2002:a17:907:7241:b0:a9e:c947:8c5e with SMTP id
 a640c23a62f3a-aa5810634e2mr597487366b.57.1732776460356; Wed, 27 Nov 2024
 22:47:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
 <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-2-b6d7022b7466@baylibre.com>
In-Reply-To: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-2-b6d7022b7466@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 28 Nov 2024 08:47:04 +0200
Message-ID: <CAHp75Vc9BGu5FnUTcRkNuNSjtS5+tqXwOm-BND72v2_C2Fm8FQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: adc: ad7173: remove special handling for irq number
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Michael Walle <michael@walle.cc>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Guillaume Ranquet <granquet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 10:02=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Remove the int irq_line field in struct ad_sigma_delta_info and all code
> that referenced it.
>
> This struct is intended to be used as static const data. Currently, the
> only user that doesn't uses the static const struct directly, namely the
> ad7173 driver is making a copy of this struct to be able to modify the
> irq_line field. However, this field is written and never used due to the
> fact that ad_sd_init() which reads the field is called before
> ad7173_fw_parse_device_config() which writes it.
>
> The runtime behavior does not change since ad_sd_init() was already
> (unintentionally) being called with irq_line =3D 0.  But, even though
> this could be considered a bug, the behavior was still correct. The SPI
> subsystem always uses the first interrupt in the interrupts array from
> the devicetree and the devicetree bindings for this family of chips
> specify that the RDY interrupt is always the first interrupt. Therefore,
> we don't actually need the special call to fwnode_irq_get_byname(), so
> it is removed in this patch instead of moving it to the correct place.

...

>  struct ad7173_state {
>         struct ad_sigma_delta sd;
> -       struct ad_sigma_delta_info sigma_delta_info;
> +       struct ad_sigma_delta_chip_info sigma_delta_info;
>         const struct ad7173_device_info *info;
>         struct ad7173_channel *channels;
>         struct regulator_bulk_data regulators[3];

Has this patch been compile-tested? Because I don't understand this
change and how it's going to be compiled.

--=20
With Best Regards,
Andy Shevchenko

