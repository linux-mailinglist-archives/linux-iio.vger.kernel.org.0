Return-Path: <linux-iio+bounces-7056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F118B91CE9C
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 20:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98ABB1F21C1C
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 18:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1237132118;
	Sat, 29 Jun 2024 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M77/zfRF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6B24B5A6;
	Sat, 29 Jun 2024 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719686915; cv=none; b=Hv27YCD1DBbOCw69f6Iij0M189HNIChfsi27abjq5D2ubJ+IOCwRvgS8w/j8RhWFr+WgkWzHcRodttNG3xIjUjcl7yWBPVV8yZRDOnFhdZoMzKc1dLSOQF2j/rrf4n9JfXdbzvEUKv5e3hAKvuoifMSt7U4I9vV7G/zkJFiiOIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719686915; c=relaxed/simple;
	bh=SyeHIANG/tstZIPdGumaX+hV7y+ZmqVNm9hjqofAdGc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i66Ryee5yO6yPrLfZOQi369lX6mCaNfB7YG7h0q/4Og4gfwicMI+tiEFFiTnYfdEysg0kJWryxIGjUJjcmcRuu+rPt4fXjwd1KQH0S+kHd3fGU4a9ThkIjQTGRjohR1AbCzM31TdJW5IWu2zyC6ei8NgdxtmLpwk3myk+GeQBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M77/zfRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73288C2BBFC;
	Sat, 29 Jun 2024 18:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719686915;
	bh=SyeHIANG/tstZIPdGumaX+hV7y+ZmqVNm9hjqofAdGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M77/zfRF/uPQnpxoh81sG2jEZG9mRWWxSdvU17jiDrAZAxdbMIEskC5m/algdrg4R
	 HI+07VQmpunNM0cx1dfnGpZFaIEDSvvbtbz1yIf2RCrB4MnglmVA2oYAiOuDdZ42OY
	 6e6jy4eOTA/JeBEgjJNyLvn2StgzRWuoPnyS6qY4b3bt8U6mxASNxM/Ryln+UTZFVC
	 K0Rl9lnocQsYkklsCKgCTPsxiEMeKR5BEA4tehkQ+WF48K6GoyJzQ7lkPr2Jv4h2N7
	 nvHJ7SQhYXLgYicts4cU6Zg3Xdh/NaktrUXF0CTR8xzY5zoH+yqp502Uhlh2IoZiO9
	 gTzuNHKPxBVEA==
Date: Sat, 29 Jun 2024 19:48:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: <fabrice.gasnier@foss.st.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] iio: add read raw service to iio backend
 framework
Message-ID: <20240629194826.39339c5a@jic23-huawei>
In-Reply-To: <20240625150717.1038212-2-olivier.moysan@foss.st.com>
References: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
	<20240625150717.1038212-2-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 17:07:09 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Add iio_backend_read_raw() service to support attributes read
> from an IIO backend.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Other than line wrapping moans this looks good to me.

J
> ---
>  drivers/iio/industrialio-backend.c | 21 +++++++++++++++++++++
>  include/linux/iio/backend.h        |  6 +++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 929aff4040ed..0e2653de1956 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -357,6 +357,27 @@ int devm_iio_backend_request_buffer(struct device *dev,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_iio_backend_request_buffer, IIO_BACKEND);
>  
> +/**
> + * iio_backend_read_raw - Request a channel attribute from the IIO backend.
> + * @back:	Backend device
> + * @chan:	IIO channel reference
> + * @val:	First element of the returned value
> + * @val2:	Second element of the returned value
> + * @mask:	Specify value to retrieve
> + *
> + * This callback replicates the read_raw callback of the IIO framework, and is intended to
> + * request miscellaneous channel attributes from the backend device.

For IIO code, please still wrap at 80 chars unless there is a good reason to
got longer.

> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_read_raw(struct iio_backend *back, struct iio_chan_spec const *chan, int *val,
Likewise. Wrap this shorter.

> +			 int *val2, long mask)
> +{
> +	return iio_backend_op_call(back, read_raw, chan, val, val2, mask);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_read_raw, IIO_BACKEND);
> +
>  static struct iio_backend *iio_backend_from_indio_dev_parent(const struct device *dev)
>  {
>  	struct iio_backend *back = ERR_PTR(-ENODEV), *iter;
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 8099759d7242..24185718b20d 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -81,6 +81,7 @@ enum iio_backend_sample_trigger {
>   * @extend_chan_spec: Extend an IIO channel.
>   * @ext_info_set: Extended info setter.
>   * @ext_info_get: Extended info getter.
> + * @read_raw: Read value from a backend device
>   **/
>  struct iio_backend_ops {
>  	int (*enable)(struct iio_backend *back);
> @@ -113,6 +114,8 @@ struct iio_backend_ops {
>  			    const char *buf, size_t len);
>  	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
>  			    const struct iio_chan_spec *chan, char *buf);
> +	int (*read_raw)(struct iio_backend *back, struct iio_chan_spec const *chan, int *val,
And here.
> +			int *val2, long mask);
>  };
>  
>  int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
> @@ -141,7 +144,8 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
>  				 const char *buf, size_t len);
>  ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
>  				 const struct iio_chan_spec *chan, char *buf);
> -
> +int iio_backend_read_raw(struct iio_backend *back, struct iio_chan_spec const *chan, int *val,
and here.

> +			 int *val2, long mask);
>  int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
>  				 struct iio_backend *back,
>  				 struct iio_chan_spec *chan);


