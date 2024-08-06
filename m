Return-Path: <linux-iio+bounces-8280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F3E949569
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6CE9B2F5CF
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A4D44366;
	Tue,  6 Aug 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlC2lEzS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB11643AD5
	for <linux-iio@vger.kernel.org>; Tue,  6 Aug 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959912; cv=none; b=KmPobzSWXtHl9TjKubzZxDCuyoMGhdbA/t0rBVgUOGyeMr11B3nQ8kJ3P6WFX885j/Sc9Iou0P4jwf5DeWfiwnc6qRI53VHrY8TmvYMvSxJtHQe3fNgb/86CS/jlSia1EA5bsYHe9k2yn6YFt+Xt5LIiLa5S8hniwayd5Aaer7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959912; c=relaxed/simple;
	bh=sbZ00yfzNjLOTxJ3M5N/9CqkqyrGqDUCyMF1fuWeas4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKN1SRZbYBQOeSXVpTO/l13LptVZMOzNLCGLVRN4W/fSuoRkxjcT2cmnLRqxUAkiltyK4mk/exU0UH9SObTUmdu+PQaLiFS72EpkNmjG3czoUWoZy3aQUgpwk73YB9YpGbbCmMJe/TjnPrlFBnrBlzr5RJ7qR6a2uDWnkGAmftM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlC2lEzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F36AC32786;
	Tue,  6 Aug 2024 15:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722959910;
	bh=sbZ00yfzNjLOTxJ3M5N/9CqkqyrGqDUCyMF1fuWeas4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hlC2lEzSrjZohO6/1XHst5moEdVv2OPN80EZuMAn0TzipoUTlS1zxqKg9yLpeXysS
	 rdsJywfmmVYTXL22KQ9eWuw/y9TRnjMLUSKmxBjuFiDNTU8IF2UwEiTSLGA8S2wsBA
	 b3HGxiVz0yW8du4YzUUTYMwYmhWmh7yKy8PCXOWqX5ynQIqKElkyQpfDFyrbDEDykl
	 IrY9Jp1g3PfCO87a1RcMTM4I11OSYA3WpgckAx3lWWvL1HfZXnZ0xJTwGK9yvP7zW4
	 sy4Sr8C/FOvxrfImIc45qXsPh13Mgp00RCPYCJxeZ6Pud++e7yfTLoOap9xU+P63rh
	 SIHIgZZOEA8cA==
Date: Tue, 6 Aug 2024 16:58:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: fix irq_flags on irq request
Message-ID: <20240806165823.17d0eaf7@jic23-huawei>
In-Reply-To: <20240806-dev-fix-ad-sigma-delta-v1-1-aa25b173c063@analog.com>
References: <20240806-dev-fix-ad-sigma-delta-v1-1-aa25b173c063@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 06 Aug 2024 17:40:49 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
>=20
> With commit 7b0c9f8fa3d2 ("iio: adc: ad_sigma_delta: Add optional irq
> selection"), we can get the irq line from struct ad_sigma_delta_info
> instead of the spi device. However, in devm_ad_sd_probe_trigger(), when
> getting the irq_flags with irq_get_trigger_type() we are still using
> the spi device irq instead of the one used for devm_request_irq().
>=20
> Fixes: 7b0c9f8fa3d2 ("iio: adc: ad_sigma_delta: Add optional irq selectio=
n")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad_sigma_delta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_=
delta.c
> index 389930186bb6..e2bed2d648f2 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -569,7 +569,7 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_validate_trigger, IIO_AD_S=
IGMA_DELTA);
>  static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *=
indio_dev)
>  {
>  	struct ad_sigma_delta *sigma_delta =3D iio_device_get_drvdata(indio_dev=
);
> -	unsigned long irq_flags =3D irq_get_trigger_type(sigma_delta->spi->irq);
> +	unsigned long irq_flags =3D irq_get_trigger_type(sigma_delta->irq_line);
>  	int ret;
> =20
>  	if (dev !=3D &sigma_delta->spi->dev) {
>=20
> ---
> base-commit: 593737c18ae789dc6e4b493510a0c00977972e2e
> change-id: 20240806-dev-fix-ad-sigma-delta-3d10146d22a6
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


