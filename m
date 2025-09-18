Return-Path: <linux-iio+bounces-24246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE07B84207
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 12:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72403B60874
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 10:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D672FCBF3;
	Thu, 18 Sep 2025 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvGjiAYL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46EF2FAC06
	for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191665; cv=none; b=IXMHN1rM+ziVCfh1Ohm4udR7zRg5qnK8F2nz0vnqB5JhYC/xVqLTykf1SUtXRH2Hz/3OYVcP0++AncnHXg6nCxmK1Dy5FF1soLke5t+6AoJxlgdnRgJ/Q918xP3f+tfvMD6bIV+/JaI9ULZ9RIhZidak6xRqw0BlkOKEy/kiMew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191665; c=relaxed/simple;
	bh=89eZzIenumM/etskzqecj0ZPBKG2sGRZ3UVXpp1vhtk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cSzyz51QUapubiAONbEGo1WGEn8mKcZgmgNPv6P6Vf0rBijyqeSDbL/J1SQbneZrvtJ2ZV0hpZzsnCUstSwPjjaP+sLNfuZzVE7ISARv9KD+VRxhUe3bgsW89Hsn2Zffn2ukUyy4br1p3xLjQncKyh7m8bo1I+eXfiIDQS5+iTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvGjiAYL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so4815565e9.1
        for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 03:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758191662; x=1758796462; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PMx9PPfLF3LJfsj44ObeuMnY7LqVMuESEdKW87t1UVs=;
        b=QvGjiAYL+nz/45LcC4YNcdCI6gbOJ8ELnaCWtN2MERFc2Wa7Myr57DMZRY5EjML+bZ
         H/LYWh44uizXe0tdrgUZwhxVi4Gw6nGrchULyIRLgqlvyEoYcQx1AgizuE0XAJwMC9wp
         Tpb2vi8bOdGm9IkRQ8AS2RJIPk6G0uFMRAIojNUgREPSqQD6YNZroTqV9OCMd2tJTYny
         bx+Vwn0caa/Tm5Jmex3/4ttRFOAHlXVgyp7PKAKTJBF4UX5Sf+7/ujRmwib4/SbPuQaN
         OSDmcDzghnHLi7qZz5KGo2gUBnPEq8aG1Tw8GiYuC4fRL4HkW8USWDsoZBlwtPJpi7p5
         +7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191662; x=1758796462;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMx9PPfLF3LJfsj44ObeuMnY7LqVMuESEdKW87t1UVs=;
        b=WGX7eBkOFL30oUJVn5N5PL2j0/GWNtZI2sZKX6G06qvMmLTht3BOQ8PmCu2BORewGu
         fG9+NRv5LZmDPwcN0ouQ6TcTeov1/9I67aCG7MwKp3BcugOhnAT80FABRhlulaidsHtX
         SAsEc1tNUXqrAWVAu/BbMtpSWbzzBH/o/s3UrbUc6v8FV0kdfyuky3dnPPH4EwefUQPg
         8Og3i37WFaj5hCgzOIbjy/7HUquLURXwosoklo3X2aYl77+mRMijNqA4eAcysosdDY3Q
         +bzLQmWj/ky2NDPfbXpTdfoL7W0vfFksJNHDZZppm++PhDfP0C0GPNC8HCNTV/zEhAou
         y5RA==
X-Gm-Message-State: AOJu0Yzw8zliTOicQHJ3GKjQ+RvTC6LMU3+y/dY/hGzfkA+1TVPfRDV+
	Gf8knbpzjekVGRdmr3Rf/dx16++leTeDLpifJ+Olf1+M6T0IvicVXMXy
X-Gm-Gg: ASbGncvPyTWFK5RBlrLkPq/x5d8+PJlCpXpz9DAWpW++bYuU1R1vzw6+yXZHWISRBxF
	TvkxgaUIreTIXKMn04VQQWQvlTJuIfuNrzyZWKwyfBm7WxNo+MLlwzc20iRFWhlFz6M8b2nCpM6
	pmsMSStwbrYK0/eD4pP9X6srEEJIrRTfn+lneGqHn+/Qf/d089pkvohC83ZVPAsVDWx/iL3TmcI
	skGKRwIfQvZL9ONR61KOb2QavXCkLRwaGETQ8ysqgbaiOK4nPDxN48Y3TCRVulWiBmJWPtBg3ce
	HSOMvobThu/EHYN2gmWRgL2ZQd2GUiSwL+tUHgzSm+uigarXGkZfnv07U6bRk0PVf0RnKsJVfS3
	F50ll5Z3hYT70vZS+O/pU+TnByl0M434gNQu3gFd8ucMOZVt9Zg==
X-Google-Smtp-Source: AGHT+IFugyy0ocy8UP28ikspPQ1sy2+axnI89kd++eT9nodIqmusOLrzql9TTMajSBLMtOxMBSUoQw==
X-Received: by 2002:a05:600c:1991:b0:45f:2869:c3b2 with SMTP id 5b1f17b1804b1-462072d723emr53018235e9.33.1758191661918;
        Thu, 18 Sep 2025 03:34:21 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f5a285efsm39007105e9.18.2025.09.18.03.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:34:21 -0700 (PDT)
Message-ID: <d20225be2339e7b08f65edf18f9fa71ae5840f0c.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7124: add debugfs to disable single cycle
 mode
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 18 Sep 2025 11:34:48 +0100
In-Reply-To: <20250917-iio-adc-ad7124-add-debugfs-to-disable-single_cycle-v1-1-c83ab725faca@baylibre.com>
References: 
	<20250917-iio-adc-ad7124-add-debugfs-to-disable-single_cycle-v1-1-c83ab725faca@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-17 at 18:03 -0500, David Lechner wrote:
> Add a boolean debugfs attribute to allow disabling the SINGLE_CYCLE
> bit in the FILTER registers.
>=20
> This causes data to be read on every conversion instead of doing the
> usual 3 or 4 conversions per sample (depending on the filter). This is
> only needed for very specific use cases, such as validating the
> performance of the ADC. So we just expose this feature through debugfs
> for the rare cases where it is needed by people who really know what
> they are doing.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> In a recent discussion with an engineer who has used these chips a lot,
> we confirmed that we made the right choice in [1] about always enabling
> the SINGLE_CYCLE bit. That is what is needed in normal operation and is
> the expected behavior.
>=20
> But there are some occasions where we might want to turn it off for
> hardware debugging (e.g. to peer into what the filter on the ADC is
> doing). Hence, this patch to add a debugfs entry to allow it.
>=20
> FYI, there will be some trivial fuzz between this patch and the "iio:
> adc: ad7124: change setup reg allocation strategy" patch, but I expect
> changes to be requested on that one, so will likely work itself out
> by the time it actually gets picked up.
>=20
> [1]:
> https://lore.kernel.org/linux-iio/20250910-iio-adc-ad7124-fix-samp-freq-f=
or-multi-channel-v4-1-8ca624c6114c@baylibre.com/
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7124.c | 25 +++++++++++++++++++++++--
> =C2=A01 file changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index
> 910b40393f77de84afc77d406c17c6e5051a02cd..ad6edbc792db35a644df37fce62bf95=
b7988
> 1455 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/cleanup.h>
> =C2=A0#include <linux/clk.h>
> =C2=A0#include <linux/clk-provider.h>
> +#include <linux/debugfs.h>
> =C2=A0#include <linux/delay.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/err.h>
> @@ -223,6 +224,7 @@ struct ad7124_state {
> =C2=A0	 */
> =C2=A0	unsigned int gain_default;
> =C2=A0	DECLARE_KFIFO(live_cfgs_fifo, struct ad7124_channel_config *,
> AD7124_MAX_CONFIGS);
> +	bool enable_single_cycle;
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ad7124_chip_info ad7124_4_chip_info =3D {
> @@ -560,13 +562,15 @@ static int ad7124_write_config(struct ad7124_state =
*st,
> struct ad7124_channel_co
> =C2=A0	 * sampling frequency even when only one channel is enabled in a
> =C2=A0	 * buffered read. If it was not set, the N in
> ad7124_set_channel_odr()
> =C2=A0	 * would be 1 and we would get a faster sampling frequency than wh=
at
> -	 * was requested.
> +	 * was requested. It may only be disabled through debugfs for testing
> +	 * purposes.
> =C2=A0	 */
> =C2=A0	return ad_sd_write_reg(&st->sd, AD7124_FILTER(cfg->cfg_slot), 3,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(AD7124_FILTER_FI=
LTER, filter) |
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(AD7124_FILTER_RE=
J60, rej60) |
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(AD7124_FILTER_PO=
ST_FILTER, post) |
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD7124_FILTER_SINGLE_CYCLE |
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(AD7124_FILTER_SINGLE_=
CYCLE,
> +					=C2=A0 st->enable_single_cycle) |
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(AD7124_FILTER_FS=
, cfg-
> >odr_sel_bits));
> =C2=A0}
> =C2=A0
> @@ -1609,6 +1613,18 @@ static void ad7124_reg_disable(void *r)
> =C2=A0	regulator_disable(r);
> =C2=A0}
> =C2=A0
> +static void ad7124_debugfs_init(struct iio_dev *indio_dev)
> +{
> +	struct dentry *dentry =3D iio_get_debugfs_dentry(indio_dev);
> +	struct ad7124_state *st =3D iio_priv(indio_dev);
> +
> +	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> +		return;
> +
> +	debugfs_create_bool("enable_single_cycle", 0644, dentry,
> +			=C2=A0=C2=A0=C2=A0 &st->enable_single_cycle);
> +}
> +
> =C2=A0static int ad7124_probe(struct spi_device *spi)
> =C2=A0{
> =C2=A0	const struct ad7124_chip_info *info;
> @@ -1629,6 +1645,9 @@ static int ad7124_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0	st->chip_info =3D info;
> =C2=A0
> +	/* Only disabled for debug/testing purposes. */
> +	st->enable_single_cycle =3D true;
> +
> =C2=A0	indio_dev->name =3D st->chip_info->name;
> =C2=A0	indio_dev->modes =3D INDIO_DIRECT_MODE;
> =C2=A0	indio_dev->info =3D &ad7124_info;
> @@ -1686,6 +1705,8 @@ static int ad7124_probe(struct spi_device *spi)
> =C2=A0	if (ret < 0)
> =C2=A0		return dev_err_probe(dev, ret, "Failed to register iio
> device\n");
> =C2=A0
> +	ad7124_debugfs_init(indio_dev);
> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
>=20
> ---
> base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
> change-id: 20250917-iio-adc-ad7124-add-debugfs-to-disable-single_cycle-
> c378ef330b89
>=20
> Best regards,

