Return-Path: <linux-iio+bounces-21416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD6AAFAE37
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 10:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C8B42218A
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 08:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5088128ECC0;
	Mon,  7 Jul 2025 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbu+3ye7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F228E611;
	Mon,  7 Jul 2025 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875569; cv=none; b=gnursqbEO+frIJWB3mPIcLJeoPBnjW8VqpBwBwWa3A34NsYEYezkK0VeNWHhXrREOJpHvkKBx+SF9tDdtQqAm5mKC41I3fNnkCy4bYN87AftEhtSd1EY/LSIxWhs6k6TmX+RH1Fn/xGfztm8e9vQ7wGjRrHQ+a5u9H8n5gmU0zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875569; c=relaxed/simple;
	bh=XDfWIMxWUeHrbbXI8QCVF0GGTp/5rM+MI4T8JkvNJeI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OuJ27w0Wn8XMfbQlASXui5t11n5CQAdW4clYNtSSzpLklNPUMNV01mZfiPFtxKQ1HytrmvzeoyO23D6f71B3yRMpjGDw6nrr3mWgPpXEjqKO368DI0GhbJrsryUcjije4oFBYnFAl4KwEVsYV14qhM2Jrsf9GlwuOLi+yFc5aKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pbu+3ye7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4539cd7990cso15293805e9.0;
        Mon, 07 Jul 2025 01:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751875565; x=1752480365; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lJ5fTuEdw7YqQY7xYpqA1BOH/dSbL0Ja1NH1d9NSPy4=;
        b=Pbu+3ye74HLNfamFWoYp86ID8ed+RM+rJNXjhNr8lVSIzJzCgNlcJkg/arGP6wWJR7
         ohWbpmg3Le20uHjLjSQOGLDYqENGK/Ynkw/44AztbXnRP71PPU45kX8dnbqe+pRZ+muV
         vrVWnDcZnQyvVohVjyxPdYosTqM77Tmh5+B3m2y1DikrehMdV6wiyukCC3PWzJEB6qQW
         xiD5sxE7DIzcr7/TG7WV5NTrIyixQClUzR4HIIkq30zmd/GAd1uWE+G1/sU8lwKo/Jxo
         0zyLv3XtCcfZLKQRlHhln85Lkugvr2L9yJBsPhKaECKSGpMFhY5V8jgdw+wIANPzpapX
         1O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751875565; x=1752480365;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lJ5fTuEdw7YqQY7xYpqA1BOH/dSbL0Ja1NH1d9NSPy4=;
        b=dWKv3fhy1cy86uU2es6fHmUIHSjO23GuZSVeKKku/5I/5waowgls8ahi8RIW1zdxN4
         3dtij0Vx6WQ75MXVW1RggzP5P3deKJFUOJ0F/yXtXXNxPqHpxjOY3vpGW0lFRbfutbSY
         N373ghvCMM1NCPgZd5dFWi8SYHEvtkcW7xUGWBqXBqs3c4x5LE2pwdK4RBNSDnYFUx49
         UKu3w2N5trF1fFbMmWYSpisZ3I0oB3H8az3+VwOQhLbjgP9BlJ3Pt7Hj49IIJT8HXMrn
         uyDMpCBcEpHXEirR3r4yalr+Ve6jdXHw9eJh1wNHv77ZyUYGIFZkpzwmQmvqmpl2CToB
         9F2w==
X-Forwarded-Encrypted: i=1; AJvYcCV0a5G/tw5FL5+br+WOuFthP0OQXYyBPoN4sHeTIjzZ5fHvebG1pxYPbmnTQCZHD9oQ+1nwB0RDtp2S/t1D@vger.kernel.org, AJvYcCX2reT49qRqhlzL8X5fVDxkUKSGokDXcJ1ewor+OwEd5FFq05DbJL6WL+VNcfueU6B1znVpn4Z/qj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytutE91TGH0p9qdRigXVGfOm+x0cCb27v0weFv82X9TvC2IaUx
	x+YU6QwaO0eNYvgH0UB+AJ8z9K87sgFXFvNaXlse35PkcJ4PxAJU7wWaixGQxpH9
X-Gm-Gg: ASbGncsYYMKEN31kZhZBIo0hXVr0MDqjVdu/b433lbRO+SqkS/Ix310IeGo4bj6Ug4W
	KsfJHnJZ82nKSrbQHs8HjXZUw7VMvZHDPU0FXEjStIFNLGSeEvkfCIt+WbS8jRYdtalo16tJTqg
	XXcRMFkSTu8fdraJIE04ISO8NiTmcy3LBdY5F8mrv8K/azbPQXIK24dtBADFNi5OoQ98kLzN6dE
	QmoYTbLrdK+sXfDO7Ud71213yoQfz0744PNdUoqvY42m6uPL8Lo3ZBzL4kZyPLOP/l1Vemx2RVs
	uaRZGMwWWWXCYMYvD6H7pFnOmd+HMcV/oY8HhaVkdSBbfh3wBRq49OblTvJfx28InYanIw==
X-Google-Smtp-Source: AGHT+IFQ2f4St3DLbQs92jBrAAO2X2yEEnK7bcOhaFRHHY6SHpMqgrghbnHgsQ+Fh4ANN+VEfn2gWA==
X-Received: by 2002:a05:600c:604d:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-454b1f69c85mr84113725e9.12.1751875565139;
        Mon, 07 Jul 2025 01:06:05 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454adc71aadsm122123075e9.25.2025.07.07.01.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 01:06:04 -0700 (PDT)
Message-ID: <fca5a3d0a89b82b2e1a6d9e440cc2fe8896b73af.camel@gmail.com>
Subject: Re: [PATCH v3] iio: adc: ad7173: fix num_slots
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 07 Jul 2025 09:06:16 +0100
In-Reply-To: <20250706-iio-adc-ad7173-fix-num_slots-on-most-chips-v3-1-d1f5453198a7@baylibre.com>
References: 
	<20250706-iio-adc-ad7173-fix-num_slots-on-most-chips-v3-1-d1f5453198a7@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-07-06 at 13:53 -0500, David Lechner wrote:
> Fix the num_slots value for most chips in the ad7173 driver. The correct
> value is the number of CHANNELx registers on the chip.
>=20
> In commit 4310e15b3140 ("iio: adc: ad7173: don't make copy of
> ad_sigma_delta_info struct"), we refactored struct ad_sigma_delta_info
> to be static const data instead of being dynamically populated during
> driver probe. However, there was an existing bug in commit 76a1e6a42802
> ("iio: adc: ad7173: add AD7173 driver") where num_slots was incorrectly
> set to the number of CONFIGx registers instead of the number of
> CHANNELx registers. This bug was partially propagated to the refactored
> code in that the 16-channel chips were only given 8 slots instead of
> 16 although we did managed to fix the 8-channel chips and one of the
> 4-channel chips in that commit. However, we botched two of the 4-channel
> chips and ended up incorrectly giving them 8 slots during the
> refactoring.
>=20
> This patch fixes that mistake on the 4-channel chips and also
> corrects the 16-channel chips to have 16 slots.
>=20
> Fixes: 4310e15b3140 ("iio: adc: ad7173: don't make copy of ad_sigma_delta=
_info
> struct")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Here is the patch that actually compiles on the fixes-togreg branch.
> ---
> Changes in v3:
> - Drop supports_spi_offload field.
> - Link to v2:
> https://lore.kernel.org/r/20250704-iio-adc-ad7173-fix-num_slots-on-most-c=
hips-v2-1-a74941609143@baylibre.com
>=20
> Changes in v2:
> - Improve commit message.
> - Link to v1:
> https://lore.kernel.org/r/20250703-iio-adc-ad7173-fix-num_slots-on-most-c=
hips-v1-1-326c5d113e15@baylibre.com
> ---
> =C2=A0drivers/iio/adc/ad7173.c | 36 ++++++++++++++++++++++++++----------
> =C2=A01 file changed, 26 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index
> 1966a9bc331401af118334a7be4c1a5b8d381473..c41bc5b9ac597f57eea6a097cc3a118=
de7b4
> 2210 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -772,10 +772,26 @@ static const struct ad_sigma_delta_info
> ad7173_sigma_delta_info_8_slots =3D {
> =C2=A0	.num_slots =3D 8,
> =C2=A0};
> =C2=A0
> +static const struct ad_sigma_delta_info ad7173_sigma_delta_info_16_slots=
 =3D {
> +	.set_channel =3D ad7173_set_channel,
> +	.append_status =3D ad7173_append_status,
> +	.disable_all =3D ad7173_disable_all,
> +	.disable_one =3D ad7173_disable_one,
> +	.set_mode =3D ad7173_set_mode,
> +	.has_registers =3D true,
> +	.has_named_irqs =3D true,
> +	.addr_shift =3D 0,
> +	.read_mask =3D BIT(6),
> +	.status_ch_mask =3D GENMASK(3, 0),
> +	.data_reg =3D AD7173_REG_DATA,
> +	.num_resetclks =3D 64,
> +	.num_slots =3D 16,
> +};
> +
> =C2=A0static const struct ad7173_device_info ad4111_device_info =3D {
> =C2=A0	.name =3D "ad4111",
> =C2=A0	.id =3D AD4111_ID,
> -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.sd_info =3D &ad7173_sigma_delta_info_16_slots,
> =C2=A0	.num_voltage_in_div =3D 8,
> =C2=A0	.num_channels =3D 16,
> =C2=A0	.num_configs =3D 8,
> @@ -797,7 +813,7 @@ static const struct ad7173_device_info ad4111_device_=
info
> =3D {
> =C2=A0static const struct ad7173_device_info ad4112_device_info =3D {
> =C2=A0	.name =3D "ad4112",
> =C2=A0	.id =3D AD4112_ID,
> -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.sd_info =3D &ad7173_sigma_delta_info_16_slots,
> =C2=A0	.num_voltage_in_div =3D 8,
> =C2=A0	.num_channels =3D 16,
> =C2=A0	.num_configs =3D 8,
> @@ -818,7 +834,7 @@ static const struct ad7173_device_info ad4112_device_=
info
> =3D {
> =C2=A0static const struct ad7173_device_info ad4113_device_info =3D {
> =C2=A0	.name =3D "ad4113",
> =C2=A0	.id =3D AD4113_ID,
> -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.sd_info =3D &ad7173_sigma_delta_info_16_slots,
> =C2=A0	.num_voltage_in_div =3D 8,
> =C2=A0	.num_channels =3D 16,
> =C2=A0	.num_configs =3D 8,
> @@ -837,7 +853,7 @@ static const struct ad7173_device_info ad4113_device_=
info
> =3D {
> =C2=A0static const struct ad7173_device_info ad4114_device_info =3D {
> =C2=A0	.name =3D "ad4114",
> =C2=A0	.id =3D AD4114_ID,
> -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.sd_info =3D &ad7173_sigma_delta_info_16_slots,
> =C2=A0	.num_voltage_in_div =3D 16,
> =C2=A0	.num_channels =3D 16,
> =C2=A0	.num_configs =3D 8,
> @@ -856,7 +872,7 @@ static const struct ad7173_device_info ad4114_device_=
info
> =3D {
> =C2=A0static const struct ad7173_device_info ad4115_device_info =3D {
> =C2=A0	.name =3D "ad4115",
> =C2=A0	.id =3D AD4115_ID,
> -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.sd_info =3D &ad7173_sigma_delta_info_16_slots,
> =C2=A0	.num_voltage_in_div =3D 16,
> =C2=A0	.num_channels =3D 16,
> =C2=A0	.num_configs =3D 8,
> @@ -875,7 +891,7 @@ static const struct ad7173_device_info ad4115_device_=
info
> =3D {
> =C2=A0static const struct ad7173_device_info ad4116_device_info =3D {
> =C2=A0	.name =3D "ad4116",
> =C2=A0	.id =3D AD4116_ID,
> -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.sd_info =3D &ad7173_sigma_delta_info_16_slots,
> =C2=A0	.num_voltage_in_div =3D 11,
> =C2=A0	.num_channels =3D 16,
> =C2=A0	.num_configs =3D 8,
> @@ -894,7 +910,7 @@ static const struct ad7173_device_info ad4116_device_=
info
> =3D {
> =C2=A0static const struct ad7173_device_info ad7172_2_device_info =3D {
> =C2=A0	.name =3D "ad7172-2",
> =C2=A0	.id =3D AD7172_2_ID,
> -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.sd_info =3D &ad7173_sigma_delta_info_4_slots,
> =C2=A0	.num_voltage_in =3D 5,
> =C2=A0	.num_channels =3D 4,
> =C2=A0	.num_configs =3D 4,
> @@ -927,7 +943,7 @@ static const struct ad7173_device_info
> ad7172_4_device_info =3D {
> =C2=A0static const struct ad7173_device_info ad7173_8_device_info =3D {
> =C2=A0	.name =3D "ad7173-8",
> =C2=A0	.id =3D AD7173_ID,
> -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.sd_info =3D &ad7173_sigma_delta_info_16_slots,
> =C2=A0	.num_voltage_in =3D 17,
> =C2=A0	.num_channels =3D 16,
> =C2=A0	.num_configs =3D 8,
> @@ -944,7 +960,7 @@ static const struct ad7173_device_info
> ad7173_8_device_info =3D {
> =C2=A0static const struct ad7173_device_info ad7175_2_device_info =3D {
> =C2=A0	.name =3D "ad7175-2",
> =C2=A0	.id =3D AD7175_2_ID,
> -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.sd_info =3D &ad7173_sigma_delta_info_4_slots,
> =C2=A0	.num_voltage_in =3D 5,
> =C2=A0	.num_channels =3D 4,
> =C2=A0	.num_configs =3D 4,
> @@ -961,7 +977,7 @@ static const struct ad7173_device_info
> ad7175_2_device_info =3D {
> =C2=A0static const struct ad7173_device_info ad7175_8_device_info =3D {
> =C2=A0	.name =3D "ad7175-8",
> =C2=A0	.id =3D AD7175_8_ID,
> -	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.sd_info =3D &ad7173_sigma_delta_info_16_slots,
> =C2=A0	.num_voltage_in =3D 17,
> =C2=A0	.num_channels =3D 16,
> =C2=A0	.num_configs =3D 8,
>=20
> ---
> base-commit: 731bfc181896a4dfd20a8c219bef1c205dd1d708
> change-id: 20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-b982206a20=
b1
>=20
> Best regards,

