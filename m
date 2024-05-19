Return-Path: <linux-iio+bounces-5132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F3E8C95FE
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 21:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF5C2810BA
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 19:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7FC535C9;
	Sun, 19 May 2024 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkIXLoeT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB4DD2EE;
	Sun, 19 May 2024 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716145973; cv=none; b=hYhpnVMN+6WzVFfP2YECwFLPV50OJqieVOSKDDlMHFU6lJIAEO5UgFcD/paPUDJTZgOvT43rQsJcVxJjZxIBhZx5V5xZRmechyeHsrBmpV9gOvFY59JkJiwKDpaocX51fYW+dgwvs+Cr9zAaUO5P141NYBYyEvyz8vVwNqo8m2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716145973; c=relaxed/simple;
	bh=P34NKSklVsYLnu3eDNayZ3uJz6ljvNnmtRy3oFcgwyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F038/uB3dN2n0zRr960whFNG3eZfqfAmlDXpX8CwP9ZqpFEuQqIx8ARlAjqWYfAxiRdS/Kxs0rp4ExMge0Hpp3D93vH52Rw/ZB2clRGHtjfai+gB+90/gDJbMOYUtt4MrGkZNL8cSW3qC7xieWrJojlCSj45MZPnpDCrnSWNnt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkIXLoeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6E8C32782;
	Sun, 19 May 2024 19:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716145972;
	bh=P34NKSklVsYLnu3eDNayZ3uJz6ljvNnmtRy3oFcgwyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QkIXLoeTUfoSAms6MbwgvyWS0dQL0rvRFGlvOApvtFtZG+pTHH1oPRQaqfvQKH07p
	 EJY5Gr9QTDarsZgkSg9dg212dGBI0qlLOdV+9ZqHSyWToN+RQrczUInd/rQRD49aUC
	 nP7C4bxIGQweo1OgY2MG637Ih9Kr0TYAOId1gRYSmt2Fl+h+djPu7gle8OY16jRoiL
	 kKC/pCQWAGkE9BVVQAEK/ucRJktnOwwcqgOGIAcdeqO3j/A2rESmrECOHrpu/1J3iM
	 ehlJmlI44aaKxAeEJ6RfvXsOZkz9z7EqxaRHoI4k3lzwZz1UoFX8OMHVP8paTL+fGC
	 4PtRx6HbC/isg==
Date: Sun, 19 May 2024 20:12:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Julien Stephan <jstephan@baylibre.com>, Esteban Blanc
 <eblanc@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] iio: add support for multiple scan types per
 channel
Message-ID: <20240519201241.7c60abac@jic23-huawei>
In-Reply-To: <20240507-iio-add-support-for-multiple-scan-types-v1-3-95ac33ee51e9@baylibre.com>
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
	<20240507-iio-add-support-for-multiple-scan-types-v1-3-95ac33ee51e9@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 May 2024 14:02:07 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This adds new fields to the iio_channel structure to support multiple
> scan types per channel. This is useful for devices that support multiple
> resolution modes or other modes that require different data formats of
> the raw data.
> 
> To make use of this, drivers can still use the old scan_type field for
> the "default" scan type and use the new scan_type_ext field for any
> additional scan types.

Comment inline says that you should commit scan_type if scan_type_ext
is provided.  That makes sense to me rather that a default no one reads.

The example that follows in patch 4 uses both the scan_type and
the scan_type_ext which is even more confusing.

> And they must implement the new callback
> get_current_scan_type() to return the current scan type based on the
> current state of the device.
> 
> The buffer code is the only code in the IIO core code that is using the
> scan_type field. This patch updates the buffer code to use the new
> iio_channel_validate_scan_type() function to ensure it is returning the
> correct scan type for the current state of the device when reading the
> sysfs attributes. The buffer validation code is also update to validate
> any additional scan types that are set in the scan_type_ext field. Part
> of that code is refactored to a new function to avoid duplication.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 19de573a944a..66f0b4c68f53 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -205,6 +205,9 @@ struct iio_scan_type {
>   * @scan_index:		Monotonic index to give ordering in scans when read
>   *			from a buffer.
>   * @scan_type:		struct describing the scan type
> + * @ext_scan_type:	Used in rare cases where there is more than one scan
> + *			format for a channel. When this is used, omit scan_type.

Here is the disagreement with the patch description.

> + * @num_ext_scan_type:	Number of elements in ext_scan_type.
>   * @info_mask_separate: What information is to be exported that is specific to
>   *			this channel.
>   * @info_mask_separate_available: What availability information is to be
> @@ -256,6 +259,8 @@ struct iio_chan_spec {
>  	unsigned long		address;
>  	int			scan_index;
>  	struct iio_scan_type scan_type;
> +	const struct iio_scan_type *ext_scan_type;
> +	unsigned int		num_ext_scan_type;

Let's make it explicit that you can't do both.

	union {
		struct iio_scan_type scan_type;
		struct {
			const struct iio_scan_type *ext_scan_type;
			unsigned int num_ext_scan_type;
		};
	};
should work for that I think.

However this is I think only used for validation. If that's the case
do we care about values not in use?  Can we move the validation to
be runtime if the get_current_scan_type() callback is used.


>  	long			info_mask_separate;
>  	long			info_mask_separate_available;
>  	long			info_mask_shared_by_type;
> @@ -435,6 +440,9 @@ struct iio_trigger; /* forward declaration */
>   *			for better event identification.
>   * @validate_trigger:	function to validate the trigger when the
>   *			current trigger gets changed.
> + * @get_current_scan_type: must be implemented by drivers that use ext_scan_type
> + *			in the channel spec to return the currently active scan
> + *			type based on the current state of the device.
>   * @update_scan_mode:	function to configure device and scan buffer when
>   *			channels have changed
>   * @debugfs_reg_access:	function to read or write register value of device
> @@ -519,6 +527,9 @@ struct iio_info {
>  
>  	int (*validate_trigger)(struct iio_dev *indio_dev,
>  				struct iio_trigger *trig);
> +	const struct iio_scan_type *(*get_current_scan_type)(
> +					const struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan);
>  	int (*update_scan_mode)(struct iio_dev *indio_dev,
>  				const unsigned long *scan_mask);
>  	int (*debugfs_reg_access)(struct iio_dev *indio_dev,
> @@ -804,6 +815,28 @@ static inline bool iio_read_acpi_mount_matrix(struct device *dev,
>  }
>  #endif
>  
> +/**
> + * iio_get_current_scan_type - Get the current scan type for a channel
> + * @indio_dev:	the IIO device to get the scan type for
> + * @chan:	the channel to get the scan type for
> + *
> + * Most devices only have one scan type per channel and can just access it
> + * directly without calling this function. Core IIO code and drivers that
> + * implement ext_scan_type in the channel spec should use this function to
> + * get the current scan type for a channel.
> + *
> + * Returns: the current scan type for the channel
> + */
> +static inline const struct iio_scan_type *iio_get_current_scan_type(
> +					const struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan)
> +{
> +	if (indio_dev->info->get_current_scan_type)
> +		return indio_dev->info->get_current_scan_type(indio_dev, chan);
> +
> +	return &chan->scan_type;
> +}
> +
>  ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
>  
>  int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
> 


