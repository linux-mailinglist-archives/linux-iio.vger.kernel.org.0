Return-Path: <linux-iio+bounces-19028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 902BEAA858C
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 11:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE15D3B5888
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 09:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E127F1531E8;
	Sun,  4 May 2025 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6wiGaqN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B4A923;
	Sun,  4 May 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746351412; cv=none; b=IqzRVn4oDClb6tG3Wr8rZa1Gausrw9yE8SuIX8GTs+uOpzk+ZRZ4hnu3wg9bLzBAR4Ujva67Wxo5QMH5sNRcL6IT72bbFBlSZpr2Usi7NIgcAi/SBYtTiPY+9JXuriwyijCuttiB8aTVNOM68nfQXRiCEoFJRao7idAxk6fCocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746351412; c=relaxed/simple;
	bh=y+QO4wdiyY/5YUroTNg++eaudNfYMl5saJSbZlue32k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j1wEMrH4R+iJS0JQjbYkPW5iD0oI1nLxztHBsmVFKXq5/O9ZQsjeObXJ6QYmYK0+8xDVrYcv+U1PUPB2qgJCJSCyt/Csu7g5e7VBy29BKwvpTr0vqVLUDDzwyQ8AZB0v1l17ZRI/7a3oK7kF7+inqDJUcaOac4ajqO+fm9ldhOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6wiGaqN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso14822975e9.3;
        Sun, 04 May 2025 02:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746351409; x=1746956209; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mq4YxAu2rRcNgM3YBVf23JtR9YIlVeHime/ANWk0XVk=;
        b=C6wiGaqN13yvUem7/Acr/HoUzBwEb/pXMHqxXcO7wwNHDprdPSzM2yMnYMOkBhG9Kf
         eZS3B/77s1decoMiK4sH5uPbdiKAZIZtMg7CFVFomkaShfB8oAeIDPK9YPXLP+O98wc8
         BBAUiegg84Xgoao9ebpklTybnUyC8HE/a8ck/apHyUm7+ZqaTa+o/YzG0PYNM1bKKWSn
         i6/CwAvXGAFgxDYG4x+SeN32JlwYNcgfZ1iOQwt36dkn7SQkU0/At9llItGzO5KuRycr
         1p8Z2jhZ2vI4qk+RnqJZMhMfz9Bth7oBu63uCkUYJ9mreL0wChwC7O/coAupUCCiJgd0
         DDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746351409; x=1746956209;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mq4YxAu2rRcNgM3YBVf23JtR9YIlVeHime/ANWk0XVk=;
        b=X3jFDB0dKGfCJ7JpmeqJa0yl5Feb+//46xmq9vW7WPgBSmUVe2ZFITUgkhH2LdXZfo
         HKFodw6KP7JZOF08/I76hvIrdvYoLzZmC+QDblAlvU/O/c4Mg9nuWiZNe1GuOyOnQ/SS
         kwiWyLxoLEbgjch5PJ+/iiwfSQ2VNPBvBrrtoC2YGflPkCC5/OWkjitH7OR1Skcyzsbr
         eR/dL4pbJPaw60Nx/e2WLek411YGsZ3g8ChFpGMs0iVYXFx3tFHFLf6PkOf/GvGwlJbK
         yyESUp5dAA/3Rp1ZDjuAIywj2/EqAQ+TXi57rkq8aREyaXQy39SU4wLTKWBd3e6yEMwx
         +d9A==
X-Forwarded-Encrypted: i=1; AJvYcCUi1fsYl13n9u5S8/dqJlfQz6xX7qBNveNuOhmtyRg/jBBW37oTmbXOyMWwKC4/KXM/rSv0NAVYzXU=@vger.kernel.org, AJvYcCWZIa0LkSk7fLaRmACg2qgB35Slq5aTY6nZcDKQARjls/btF7AkcfSPuFXWYc3M34uNxVzTX7m+h7id8VQY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgnup4G1REogVgSsmxq8XWvkFxZA3xn6vSlonliRtrdWOqmkaG
	CaQ/vhkB19UlxV/G+LMxxui4M4dnRq0jmKdaV4RVO7HxhvcIjLxmSKRP7NWp
X-Gm-Gg: ASbGncsL0XLo3biSzUi78bdNLWDI4yBVEzmMssKvNf5JqUg1eMfhMoZOben/tB/QSz1
	de+1MwWkxPpiO0eX3WNb92azwflJnfmawX33iv04tdF0suMMMgXCQx7XNDdxZpcVd019TN7lnst
	UAqTRB0buIBaA848AyCAu5US/x0bzmsyXR10UiBqLACwXMbqUEdMCBArE86vd2pQLeSqWzQzWTK
	ePOKTVLh7vNRIeFilbXN7Sa4Hf9id2cPNquQAogMwDNwL/ZFMXIxBWTMYio+qaxwXrXIGKoTSjz
	t6GdTwCmhpUzXjYDlShAOonTXZwsacDTHDxM4Kh2gcXDMxRqhMfu8nXo3mqTk5in6seMH0ZidiC
	dumLteChgp/A1iQw=
X-Google-Smtp-Source: AGHT+IFoDAGULCLBBKh318FrEAR1MfItiv/hYoplaO3+Y7sNecsD0Zeb2TVajbheH7bhvfun2ULUJw==
X-Received: by 2002:a05:600c:3e09:b0:43d:2230:303b with SMTP id 5b1f17b1804b1-441c491fce2mr24100975e9.20.1746351409042;
        Sun, 04 May 2025 02:36:49 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af2922sm142017985e9.17.2025.05.04.02.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 02:36:48 -0700 (PDT)
Message-ID: <5bdc6802bc10b71774fb6d839a1a45d94463f4cf.camel@gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7606_spi: add offload scan mask check
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Angelo Dureghello
	 <adureghello@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Sun, 04 May 2025 09:37:12 +0100
In-Reply-To: <20250502-iio-adc-ad7606_spi-fix-offload-scan-mask-check-v2-1-e70c6d71baa3@baylibre.com>
References: 
	<20250502-iio-adc-ad7606_spi-fix-offload-scan-mask-check-v2-1-e70c6d71baa3@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-02 at 10:42 -0500, David Lechner wrote:
> Validate the scan mask when SPI offloading is being used.
>=20
> Since this family of ADCs is simultaneous sampling, there isn't a way
> to selectively disable channels when reading sample data. (Technically,
> AD7616 has a sequencer so could have some control, but that is for
> another day).
>=20
> For "regular" IIO triggered buffer reads, this isn't a problem and the
> IIO core will demux the data and ignore data from disabled channels.
> However, since SPI offloading is done completely in hardware, we don't
> have a way to do the same. So before this patch, if less than all
> channels were enabled, the data would be misplaced in the buffer.
>=20
> By adding a check in update_scan_mode, we can fail to enable the buffer
> instead of having bad data returned to userspace.
>=20
> Fixes: e96d35faf357 ("iio: adc: ad7606: add SPI offload support")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v2:
> - Use bitmap_weight() instead of bitmap_equal().
> - Link to v1:
> https://lore.kernel.org/r/20250430-iio-adc-ad7606_spi-fix-offload-scan-ma=
sk-check-v1-1-8b165d9d6c0e@baylibre.com
>=20
> And in case it isn't obvious, the patch this fixes is fairly recent, so
> this goes in togreg rather than fixes-togreg.
> ---
> =C2=A0drivers/iio/adc/ad7606_spi.c | 29 +++++++++++++++++++++++++++++
> =C2=A01 file changed, 29 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index
> 997be483ebb93293481b922e13ece4edb47e940a..5b5b4677273b15956f1da73da41b16c=
5ee64e818
> 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -5,6 +5,7 @@
> =C2=A0 * Copyright 2011 Analog Devices Inc.
> =C2=A0 */
> =C2=A0
> +#include <linux/bitmap.h>
> =C2=A0#include <linux/err.h>
> =C2=A0#include <linux/math.h>
> =C2=A0#include <linux/module.h>
> @@ -329,19 +330,44 @@ static int ad7606_spi_offload_probe(struct device *=
dev,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int ad7606_spi_update_scan_mode(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const unsigned long *scan_mask)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +
> +	if (st->offload_en) {
> +		unsigned int num_adc_ch =3D st->chip_info->num_adc_channels;
> +
> +		/*
> +		 * SPI offload requires that all channels are enabled since
> +		 * there isn't a way to selectively disable channels that get
> +		 * read (this is simultaneous sampling ADC) and the DMA buffer
> +		 * has no way of demuxing the data to filter out unwanted
> +		 * channels.
> +		 */
> +		if (bitmap_weight(scan_mask, num_adc_ch) !=3D num_adc_ch)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> =C2=A0static const struct ad7606_bus_ops ad7606_spi_bops =3D {
> =C2=A0	.offload_config =3D ad7606_spi_offload_probe,
> =C2=A0	.read_block =3D ad7606_spi_read_block,
> +	.update_scan_mode =3D ad7606_spi_update_scan_mode,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ad7606_bus_ops ad7607_spi_bops =3D {
> =C2=A0	.offload_config =3D ad7606_spi_offload_probe,
> =C2=A0	.read_block =3D ad7606_spi_read_block14to16,
> +	.update_scan_mode =3D ad7606_spi_update_scan_mode,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ad7606_bus_ops ad7608_spi_bops =3D {
> =C2=A0	.offload_config =3D ad7606_spi_offload_probe,
> =C2=A0	.read_block =3D ad7606_spi_read_block18to32,
> +	.update_scan_mode =3D ad7606_spi_update_scan_mode,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ad7606_bus_ops ad7616_spi_bops =3D {
> @@ -350,6 +376,7 @@ static const struct ad7606_bus_ops ad7616_spi_bops =
=3D {
> =C2=A0	.reg_read =3D ad7606_spi_reg_read,
> =C2=A0	.reg_write =3D ad7606_spi_reg_write,
> =C2=A0	.rd_wr_cmd =3D ad7616_spi_rd_wr_cmd,
> +	.update_scan_mode =3D ad7606_spi_update_scan_mode,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ad7606_bus_ops ad7606b_spi_bops =3D {
> @@ -359,6 +386,7 @@ static const struct ad7606_bus_ops ad7606b_spi_bops =
=3D {
> =C2=A0	.reg_write =3D ad7606_spi_reg_write,
> =C2=A0	.rd_wr_cmd =3D ad7606b_spi_rd_wr_cmd,
> =C2=A0	.sw_mode_config =3D ad7606b_sw_mode_config,
> +	.update_scan_mode =3D ad7606_spi_update_scan_mode,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ad7606_bus_ops ad7606c_18_spi_bops =3D {
> @@ -368,6 +396,7 @@ static const struct ad7606_bus_ops ad7606c_18_spi_bop=
s =3D {
> =C2=A0	.reg_write =3D ad7606_spi_reg_write,
> =C2=A0	.rd_wr_cmd =3D ad7606b_spi_rd_wr_cmd,
> =C2=A0	.sw_mode_config =3D ad7606b_sw_mode_config,
> +	.update_scan_mode =3D ad7606_spi_update_scan_mode,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ad7606_bus_info ad7605_4_bus_info =3D {
>=20
> ---
> base-commit: a9b169746d2e299159d4dde190552ae620982bbd
> change-id: 20250430-iio-adc-ad7606_spi-fix-offload-scan-mask-check-1d3304=
00c014
>=20
> Best regards,


