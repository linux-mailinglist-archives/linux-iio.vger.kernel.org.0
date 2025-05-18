Return-Path: <linux-iio+bounces-19634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DB1ABB104
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 19:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9223016961F
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 17:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A950221D3E3;
	Sun, 18 May 2025 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh/28hCv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E72621171B;
	Sun, 18 May 2025 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747588145; cv=none; b=Kg8RlY4KljsUvPQM5ZfW1c7s9VcGDrV89a3u5fcSutbSexjXhS48vPWNTEC4BYZEUhnodK8lGQoBMg3mvi/hr51k7nLFVWJukq/5b1l6wSkrhXzuCL+1JRejHRMS+ea+2XC2aQrVfzvOezgeB04xrKAr6A3huYk31FLul4xhkxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747588145; c=relaxed/simple;
	bh=/2l41MyTiBvFjt2iudsijZS7hDNXUIGT+f+SVyNnfk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGNqra+rwTgDx53eY+uHfJGIlgHCWLu+Sq/+NTbbBdvGdPYAiDCH5ttL47g7sh/jtEZT+npSNcT+jJ3OjnGd+k7tp0doaE+00JJn4Scg8RnKLquFDRCKM3y18/RpEICGE66zbJpVoJwd0+3O3oZ4swZqPmkfnRooItkZKlk5UMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh/28hCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CF1C4CEE7;
	Sun, 18 May 2025 17:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747588144;
	bh=/2l41MyTiBvFjt2iudsijZS7hDNXUIGT+f+SVyNnfk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dh/28hCv08nii5bAtieBShBsp922PU1m351zkHFC5crhSx9v7vA9kT6YlaY1ELyqa
	 gsCMuQ5IW+rtvQHX/fE54UXphoGLTmbZy9RTVjBSasDLdYcmhGOMuQ09u6+1zQNnYH
	 U3F/FFeOqu6KxSzKs1bBLjDzUY5PIzsRRBnIRzcJbpi5AF4yAjsWwcZbY7nQ/zg+iD
	 L1UtYxiUyEijMt/tW7YHew6P4jGvfOnP6/W+0yDHPzSuhuPBc185JekwY0iuHxhjgy
	 L4D6BVe/RAk4fJ40yduOEL6i/wxEfkld4lt6YnHdcpIrA8GKLEEJ0tRMAeGZ9X2rOG
	 ZewhMRuPbLT9Q==
Date: Sun, 18 May 2025 18:08:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v6 02/10] iio: backend: add support for data alignment
Message-ID: <20250518180856.0bb104de@jic23-huawei>
In-Reply-To: <20250516082630.8236-3-antoniu.miclaus@analog.com>
References: <20250516082630.8236-1-antoniu.miclaus@analog.com>
	<20250516082630.8236-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 May 2025 11:26:22 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add backend support for staring the capture synchronization.
> When activated, it initates a proccess that aligns the sample's most
> significant bit (MSB) based solely on the captured data, without
> considering any other external signals.
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v6.
>  drivers/iio/industrialio-backend.c | 23 +++++++++++++++++++++++
>  include/linux/iio/backend.h        |  3 +++
>  2 files changed, 26 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-backend.c
> index 038c9e1e2857..545923310f1f 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -796,6 +796,29 @@ int iio_backend_filter_type_set(struct iio_backend *=
back,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_filter_type_set, "IIO_BACKEND");
> =20
> +/**
> + * iio_backend_data_align - Perform the data alignment process.
Wrong name.  If all else is good I can fix this up.

> + * @back: Backend device
> + * @timeout_us: Timeout value in us.
> + *
> + * When activated, it initates a proccess that aligns the sample's most
> + * significant bit (MSB) based solely on the captured data, without
> + * considering any other external signals.
> + *
> + * The timeout_us value must be greater than 0.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_interface_data_align(struct iio_backend *back, u32 timeo=
ut_us)
> +{
> +	if (!timeout_us)
> +		return -EINVAL;
> +
> +	return iio_backend_op_call(back, interface_data_align, timeout_us);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_data_align, "IIO_BACKEND");
> +
>  /**
>   * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
>   * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 5526800f5d4a..a971a83121b7 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -109,6 +109,7 @@ enum iio_backend_filter_type {
>   * @debugfs_print_chan_status: Print channel status into a buffer.
>   * @debugfs_reg_access: Read or write register value of backend.
>   * @filter_type_set: Set filter type.
> + * @interface_data_align: Perform the data alignment process.
>   * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
>   * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
>   * @data_stream_enable: Enable data stream.
> @@ -161,6 +162,7 @@ struct iio_backend_ops {
>  				  unsigned int writeval, unsigned int *readval);
>  	int (*filter_type_set)(struct iio_backend *back,
>  			       enum iio_backend_filter_type type);
> +	int (*interface_data_align)(struct iio_backend *back, u32 timeout_us);
>  	int (*ddr_enable)(struct iio_backend *back);
>  	int (*ddr_disable)(struct iio_backend *back);
>  	int (*data_stream_enable)(struct iio_backend *back);
> @@ -203,6 +205,7 @@ int devm_iio_backend_request_buffer(struct device *de=
v,
>  				    struct iio_dev *indio_dev);
>  int iio_backend_filter_type_set(struct iio_backend *back,
>  				enum iio_backend_filter_type type);
> +int iio_backend_interface_data_align(struct iio_backend *back, u32 timeo=
ut_us);
>  int iio_backend_ddr_enable(struct iio_backend *back);
>  int iio_backend_ddr_disable(struct iio_backend *back);
>  int iio_backend_data_stream_enable(struct iio_backend *back);


