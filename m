Return-Path: <linux-iio+bounces-3880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715C98902D2
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 16:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA82AB21A19
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 15:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A30128389;
	Thu, 28 Mar 2024 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7x6u5ww"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAEA80622;
	Thu, 28 Mar 2024 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639009; cv=none; b=rQOYnw1Owtvanr1mZNbLEU1dwhswEQ3f7//jlTv5B+YygCr9HT8Ax00Fj1aAx1Vp6kQ9a2kTqF0d3LSiRPM2xGxrI19dhg1LUGEN6QpNV3V8mXEVdbQsF+HuMSVQJhVeN7Lf3NIpiQvIjxt/YqnnciyOY6jbD+3UONxp9+oGZog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639009; c=relaxed/simple;
	bh=4OC790Uz+ZASa0TMfc6v67Ce4aLwwJBv5c/8p/8OraE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVjYa+JnshvKu+KSsw7p0sl3ONFVSslxAPpWQYGbbwxLtGjpZ2EIarHxeeqNDWMRvWERjwudMBP0KgVQghrCIqyHQVNWtznso6+H4vl2qPctcD6iG7Dr4Wt8L4xfTwYC5XYAbIhI0k1UaEpnXcm2NhbxwvdrNNAZswdNq7/42J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7x6u5ww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FADC433C7;
	Thu, 28 Mar 2024 15:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711639008;
	bh=4OC790Uz+ZASa0TMfc6v67Ce4aLwwJBv5c/8p/8OraE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V7x6u5ww8Vv2HhccvEVFPLpbKD82Ov9uSeskJxkFNA1roj7gTuxVtad0gZZ9nfQLB
	 BJtcZG91Ii7zJCxPWBVj6EDe+cJiH9PtSgzlLqod8t0YZ090yhVTh5kIq2d8v7rOO7
	 KNKX7aiBJvi4Sox/vGEHf+K19BwllAmLLYDxjUae11/eRv80pfK/fum6nK8ZRAxH5/
	 1lzLlt1C0/MdtiBjh7+01W93H3RkPVBh3ooQb7FfQuD+cuvOJCxGxJp7z7NcH30Fsc
	 ZNzItWpBZL8tVUQY53Qxa0wRJShJ/oF7Uy2sV/SC5RQOWjiRYAUaOP8HaE0PvtnSuc
	 4sYEnK3V51iCA==
Date: Thu, 28 Mar 2024 15:16:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Dragos Bogdan <dragos.bogdan@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 08/10] iio: backend: add new functionality
Message-ID: <20240328151632.298bd95f@jic23-huawei>
In-Reply-To: <20240328-iio-backend-axi-dac-v1-8-afc808b3fde3@analog.com>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
	<20240328-iio-backend-axi-dac-v1-8-afc808b3fde3@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 14:22:32 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> This adds the needed backend ops for supporting a backend inerfacing
> with an high speed dac. The new ops are:
> 
> * data_source_set();
> * set_sampling_freq();
> * extend_chan_spec();
> * ext_info_set();
> * ext_info_get().
> 
> Also to note the new helpers that are meant to be used by the backends
> when extending an IIO channel (adding extended info):
> 
> * iio_backend_ext_info_set();
> * iio_backend_ext_info_get().
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
I'm pretty flexible on this so far as I think we are still learning how front
ends and backends should interact. Maybe we'll figure that out in the medium
term and rework this stuff. For now it looks fine. A few minor things inline.
>  
> +/**
> + * iio_backend_ext_info_get - IIO ext_info read callback
> + * @indio_dev:	IIO device
> + * @private:	Data private to the driver
> + * @chan:	IIO channel
> + * @buf:	Buffer where to place the attribute data
> + *
> + * This helper is intended to be used by backends that extend an IIO channel
> + * (trough iio_backend_extend_chan_spec()) with extended info. In that case,
> + * backends are not supposed to give their own callbacks (as they would not
> + * a way to get te backend from indio_dev). This is the getter.

te->the?


> +/**
> + * iio_backend_extend_chan_spec - Extend an IIO channel
> + * @indio_dev:	IIO device
> + * @back:	Backend device
> + * @chan:	IIO channel
> + *
> + * Some backends may have their own functionalities and hence capable of
> + * extending a frontend's channel.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
> +				 struct iio_backend *back,
> +				 struct iio_chan_spec *chan)
> +{
> +	const struct iio_chan_spec_ext_info *ext_info = chan->ext_info;
This is getting confusing.  So this one is the front end value of ext_info?
Name it as such frontend_ext_info

> +	int ret;
> +
> +	ret = iio_backend_op_call(back, extend_chan_spec, chan);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Let's keep things simple for now. Don't allow to overwrite the
> +	 * frontend's extended info. If ever needed, we can support appending
> +	 * it.
> +	 */
> +	if (ext_info && chan->ext_info != ext_info)
> +		return -EOPNOTSUPP;
> +	if (!chan->ext_info)

This is checking if the backend added anything? Perhaps a comment on that
as we don't need a backend_ext_info local variable...

> +		return 0;
> +	/*
> +	 * !\NOTE: this will break as soon as we have multiple backends on one
> +	 * frontend and all of them extend channels. In that case, the core
> +	 * backend code has no way to get the correct backend given the
> +	 * iio device.
> +	 *
> +	 * One solution for this could be introducing a new backend
> +	 * dedicated callback in struct iio_info so we can callback into the
> +	 * frontend so it can give us the right backend given a chan_spec.
> +	 */

Hmm. This is indeed messy.  Could we associate it with the buffer as presuably
a front end with multiple backends is using multiple IIO buffers?

As you say a dance via the front end would work fine.


> +	iio_device_set_drvdata(indio_dev, back);
> +
> +	/* Don't allow backends to get creative and force their own handlers */
> +	for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
> +		if (ext_info->read != iio_backend_ext_info_get)
> +			return -EINVAL;
> +		if (ext_info->write != iio_backend_ext_info_set)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_extend_chan_spec, IIO_BACKEND);

> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index a6d79381866e..09ff2f8f9fd8 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/types.h>
>  
> +struct iio_chan_spec;
>  struct fwnode_handle;
>  struct iio_backend;
>  struct device;
> @@ -15,6 +16,26 @@ enum iio_backend_data_type {
>  	IIO_BACKEND_DATA_TYPE_MAX
>  };
>  
> +enum iio_backend_data_source {
> +	IIO_BACKEND_INTERNAL_CW,

CW?  Either expand out what ever that is in definition of add a comment
at least.

> +	IIO_BACKEND_EXTERNAL,
What does external mean in this case?
> +	IIO_BACKEND_DATA_SOURCE_MAX
> +};
> +
> +/**
> + * IIO_BACKEND_EX_INFO - Helper for an IIO extended channel attribute
> + * @_name:	Attribute name
> + * @_shared:	Whether the attribute is shared between all channels
> + * @_what:	Data private to the driver
> + */
> +#define IIO_BACKEND_EX_INFO(_name, _shared, _what) {	\
> +	.name = (_name),				\
> +	.shared = (_shared),				\
> +	.read =  iio_backend_ext_info_get,		\
> +	.write = iio_backend_ext_info_set,		\
> +	.private = (_what),				\
> +}
> +
>  /**
>   * struct iio_backend_data_fmt - Backend data format
>   * @type:		Data type.
> @@ -35,8 +56,13 @@ struct iio_backend_data_fmt {
>   * @chan_enable:	Enable one channel.
>   * @chan_disable:	Disable one channel.
>   * @data_format_set:	Configure the data format for a specific channel.
> + * @data_source_set:	Configure the data source for a specific channel.
> + * @set_sample_rate:	Configure the sampling rate for a specific channel.
>   * @request_buffer:	Request an IIO buffer.
>   * @free_buffer:	Free an IIO buffer.
> + * @extend_chan_spec:	Extend an IIO channel.
> + * @ext_info_set:	Extended info setter.
> + * @ext_info_get:	Extended info getter.
>   **/
>  struct iio_backend_ops {
>  	int (*enable)(struct iio_backend *back);
> @@ -45,10 +71,21 @@ struct iio_backend_ops {
>  	int (*chan_disable)(struct iio_backend *back, unsigned int chan);
>  	int (*data_format_set)(struct iio_backend *back, unsigned int chan,
>  			       const struct iio_backend_data_fmt *data);
> +	int (*data_source_set)(struct iio_backend *back, unsigned int chan,
> +			       enum iio_backend_data_source data);
> +	int (*set_sample_rate)(struct iio_backend *back, unsigned int chan,
> +			       u64 sample_rate);

Name the parameter that so we know the units.  _hz?  


