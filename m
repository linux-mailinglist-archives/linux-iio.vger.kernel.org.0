Return-Path: <linux-iio+bounces-9867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BCE9894F7
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 13:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2F71F2129F
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 11:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A3015F41B;
	Sun, 29 Sep 2024 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqoONKPL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244AD566A;
	Sun, 29 Sep 2024 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727607945; cv=none; b=WBia0C5qZyQStdpx8MVSM3vtipfOH/++f7iuIPeTjRiS9PBS8Eg1Qu1UBfwo4s+zOF7+mHbsBnidGtdv0anxCQ0Bz3456wqQQvDA4Lcu9N0CaHnSMNUzm+MbJoRQS7V1RcG4gAmtht+pZgT67t8b+Ny/HqxEOUw5IMHbyMKqUVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727607945; c=relaxed/simple;
	bh=lpNNnz2zMa2kX8OFRLZ4OPgb40TpGDY4V9dqbRspwJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VksUGIRLbEqJytiUVFlNWV9uKKWi62hp0ia7dyvgovXZtqMGrFZ7ckmkwjc4WtJ8OA7Kg61MPb6be/DHGcihM1x3iPUvdx8xYQqVgreAOSLS4C52h98K4lu9oU6CaO9h9rNMP2HxJJLc1EdOOHxw/62gAEuTQbdsD0lb6OUZB54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqoONKPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D643C4CEC5;
	Sun, 29 Sep 2024 11:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727607944;
	bh=lpNNnz2zMa2kX8OFRLZ4OPgb40TpGDY4V9dqbRspwJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aqoONKPLIvjAPjQeVYc09GYLhmL/6XPjLyGPwXjTFZuE9onpNTxraRXpTngtO/Fh4
	 u3LVu8sMG9g9SiVMfZ1xoA9nypAuHRJZZMdaMsx9eciRWDh5kRt0clhbkmMGbDiDkB
	 3JDdptums7KhoxW2NGIyRZNm3lt1CeP0z2qd4Z5fK1EQNKl25SlJAud0s9d+0spr3U
	 mw7fqaXfvyxsGDcxbCIthmHvWMUTL05p3mQtkEQa7/YpZXvoPcy/FYrx7QfTDf6EO2
	 PBsjxHGTTqRRq5lku178K6rO3ZCp5YaPQexk5A5MChBbw1Obzdsw9noSSXLm6c1Ael
	 2dz1oWse1Gqqw==
Date: Sun, 29 Sep 2024 12:05:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v3 05/10] iio: backend: extend features
Message-ID: <20240929120535.6b41c37e@jic23-huawei>
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-5-a17b9b3d05d9@baylibre.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-5-a17b9b3d05d9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024 11:20:01 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Extend backend features with new calls needed later on this
> patchset from axi version of ad3552r.
> 
> The follwoing calls are added:
> 
> iio_backend_ext_sync_enable
> 	enable synchronize channels on external trigger
> iio_backend_ext_sync_disable
> 	disable synchronize channels on external trigger
> iio_backend_ddr_enable
> 	enable ddr bus transfer
> iio_backend_ddr_disable
> 	disable ddr bus transfer
> iio_backend_set_bus_mode
> 	select the type of bus, so that specific read / write
> 	operations are performed accordingly
> iio_backend_buffer_enable
> 	enable buffer
> iio_backend_buffer_disable
> 	disable buffer
> iio_backend_data_transfer_addr
> 	define the target register address where the DAC sample
> 	will be written.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Hi Angelo,
A few trivial comments inline.

> ---
>  drivers/iio/industrialio-backend.c | 111 +++++++++++++++++++++++++++++++++++++
>  include/linux/iio/backend.h        |  23 ++++++++
>  2 files changed, 134 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 20b3b5212da7..f4802c422dbf 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -718,6 +718,117 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
...

> +/**
> + * iio_backend_ddr_disable - Disable interface DDR (Double Data Rate) mode
> + * @back: Backend device
> + *
> + * Disabling DDR data is generated byt the IP at rising or falling front

Spell check your comments.

> + * of the interface clock signal (SDR, Single Data Rate).
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_ddr_disable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, ddr_disable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_disable, IIO_BACKEND);
				 struct fwnode_handle *fwnode)
>  {
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 37d56914d485..41619b803cd6 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -14,12 +14,14 @@ struct iio_dev;
>  enum iio_backend_data_type {
>  	IIO_BACKEND_TWOS_COMPLEMENT,
>  	IIO_BACKEND_OFFSET_BINARY,
> +	IIO_BACKEND_DATA_UNSIGNED,
>  	IIO_BACKEND_DATA_TYPE_MAX
>  };
>  
>  enum iio_backend_data_source {
>  	IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE,
>  	IIO_BACKEND_EXTERNAL,
> +	IIO_BACKEND_INTERNAL_RAMP_16BIT,
>  	IIO_BACKEND_DATA_SOURCE_MAX
>  };
>  
> @@ -89,6 +91,13 @@ enum iio_backend_sample_trigger {
>   * @read_raw: Read a channel attribute from a backend device
>   * @debugfs_print_chan_status: Print channel status into a buffer.
>   * @debugfs_reg_access: Read or write register value of backend.
> + * @ext_sync_enable: Enable external synchronization.
> + * @ext_sync_disable: Disable external synchronization.
> + * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
> + * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
> + * @buffer_enable: Enable data buffer.
> + * @buffer_disable: Disable data buffer.

This needs more specific text. What buffer?  I think this came
up earlier but it needs to say something about the fact it's enabling
or disabling the actual capture of data into the DMA buffers that
userspace will read.

> + * @data_transfer_addr: Set data address.
>   **/
>  struct iio_backend_ops {
>  	int (*enable)(struct iio_backend *back);
> @@ -129,6 +138,13 @@ struct iio_backend_ops {
>  					 size_t len);
>  	int (*debugfs_reg_access)(struct iio_backend *back, unsigned int reg,
>  				  unsigned int writeval, unsigned int *readval);
> +	int (*ext_sync_enable)(struct iio_backend *back);
I know we've done it this way for existing items, but I wonder if we should
squish down the ops slightly and have new enable/disable pairs as
single functions.
	int (*ext_sync_set_state)(struct iio_backend *back, bool enable);
etc.  If nothing else reduces how many things need documentation ;)

Nuno, what do you think? Worth squashing these pairs into single
callbacks?

> +	int (*ext_sync_disable)(struct iio_backend *back);
> +	int (*ddr_enable)(struct iio_backend *back);
> +	int (*ddr_disable)(struct iio_backend *back);
> +	int (*buffer_enable)(struct iio_backend *back);
> +	int (*buffer_disable)(struct iio_backend *back);
> +	int (*data_transfer_addr)(struct iio_backend *back, u32 address);
>  };

