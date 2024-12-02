Return-Path: <linux-iio+bounces-12944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BC79E04F0
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 15:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1743B39151
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 13:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85196200B99;
	Mon,  2 Dec 2024 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9xa3qbX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE321FF7DD;
	Mon,  2 Dec 2024 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733146898; cv=none; b=ch78DsASz3vbb2HvSlb88V3rnDN4uV/jjsuTxRqQcD66LrcAbduAzJtn1cpVl0Rsqvya69IssRKfkjenCZDUjzGt+WIUAN6bmYaqRzdIgQY+2a/piGBhyH6VxWlD5XaCWpFbYBZojXs3Gp+uAEHWV62fTzBKUvKgmfxGh4C4g+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733146898; c=relaxed/simple;
	bh=OLFECxwfG50Q5CtxAQ2mfziAW/8aO5dA6PED1F2PKVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IA7CdMftYG84RRiz2O8vn1IhGBP11EIL5FOopntx/Msvxi6TIXXxhiuiYu7zz/NSN6HLRcCGnWcsu4ZMJdDBFqapsB6f6qUAbUxjIJlE2oHn//DWjYA4nLREZy2L/HRQzde54ezVXBEBCwDGXpsl9WnVDCyo1Mc3LvGindVtj5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9xa3qbX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733146897; x=1764682897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OLFECxwfG50Q5CtxAQ2mfziAW/8aO5dA6PED1F2PKVc=;
  b=L9xa3qbX+0KttQKq0EK1jAzK0QiGDJahvHUmsXimPBvaSrhxH3xp8e7s
   Z2jFuZieUUutgF6XWjW6vmtwlC71lPUMCyujmXkYvoFCqHomqhan6X+Jb
   z0vmGCISUe7jHc2ARSuKEKtZucOr5Js2sZ4C+idk2ZNJAjxVT+83gaUOT
   u/Fbb2osbyW5wf+GMa9h+0eB4LqDev6eZyBI88afYcK2RqDH7Ij5dveiQ
   /o292ZW8qEYPOAb4weod/n6HEmiFFD5eo7/y290X0WslOAndCSDiI8uSN
   3A6W4sDGH9Xq9sFtc1ueYObhX9HmZdswpPuq2FV4bn0OjFvgsmmujRvK5
   Q==;
X-CSE-ConnectionGUID: tBgFyATDSlKehuBGzZ6n/g==
X-CSE-MsgGUID: 90JjO4xBTQaQ2rGFAJqp7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33236797"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="33236797"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 05:41:36 -0800
X-CSE-ConnectionGUID: lrpfOPvKTfqXZtMUEfKu6w==
X-CSE-MsgGUID: 9tz5oZ6pQnCU+9qS3cX4TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="98214227"
Received: from dneilan-mobl1.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.244.104])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 05:41:34 -0800
Date: Mon, 2 Dec 2024 14:41:26 +0100
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: kx022a: document new chip_info structure members
Message-ID: <hv7kqspym5qkcwbw4r6ogi362sbooohijplxbkro5qdmndvhr6@t2cftbs4n7rz>
References: <Z02eXtrrO8U5-ffo@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z02eXtrrO8U5-ffo@mva-rohm>

Hi Matti,

Thank you for the patch!

On Mon, Dec 02, 2024 at 01:47:42PM +0200, Matti Vaittinen wrote:
> The kx022a driver supports a few different HW variants. A chip-info
> structure is used to describe sensor specific details. Support for
> sensors with different measurement g-ranges was added recently,
> introducing sensor specific scale arrays.
> 
> The members of the chip-info structure have been documented using
> kerneldoc. The newly added members omitted the documentation. It is nice
> to have all the entries documented for the sake of the consistency.
> Furthermore, the scale table format may not be self explatonary, nor how
> the amount of scales is informed.
> 
> Add documentation to scale table entries to maintain consistency and to
> make it more obvious how the scales should be represented.
> 
> Suggested-by: Mehdi Djait <mehdi.djait@linux.intel.com>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Wording is difficult. Especially when not working on ones native
> language. So, I am glad is someone evaluates whether using the 'NANO'
> to describe 0.000 000 001 is correct - or if term like 'ppb' would make
> more sense...
> ---
>  drivers/iio/accel/kionix-kx022a.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> index 142652ff4b22..82c4ced7426d 100644
> --- a/drivers/iio/accel/kionix-kx022a.h
> +++ b/drivers/iio/accel/kionix-kx022a.h
> @@ -137,6 +137,11 @@ struct kx022a_data;
>   *
>   * @name:			name of the device
>   * @regmap_config:		pointer to register map configuration
> + * scale_table:			Array of two integer tables containing
> + *				supported scales. Each scale is represented
> + *				a 2 value array. First value being full
> + *				integers, second being NANOs.

How about: 

Array of tables containing two scaling factors for the supported
acceleration measurement ranges. First value is the integer part and
second value is the fractional part in nano units.

> + * scale_table_size:		Amount of values in tables.
>   * @channels:			pointer to iio_chan_spec array
>   * @num_channels:		number of iio_chan_spec channels
>   * @fifo_length:		number of 16-bit samples in a full buffer
> -- 
> 2.47.0
> 

--
Kind Regards
Mehdi Djait

