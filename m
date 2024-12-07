Return-Path: <linux-iio+bounces-13202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D79A9E816F
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 19:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC371883E46
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 18:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C8D54652;
	Sat,  7 Dec 2024 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D51a5frh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A51F602;
	Sat,  7 Dec 2024 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733594530; cv=none; b=o8H7aszayZmvNxohaJZVMnmlYLLgjiZBIuw+NOBJRl58mvxlw6A9Fh++Pdug3uAHkfZC+92rDm36RFs4u5uw5CwEjCBMEMrLXvZy/aN18E1bM8hl77i+HO6CCb7NUpgB6/ET7BdXlinFyWf+M2e0kHVzPw1P2uizrmATBZ+9omI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733594530; c=relaxed/simple;
	bh=Jxot+HTaLU1cfK7uzk3/7NQ3O+57RfGJvvYTPRIrdn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JvA+/caMoYzgbRBAUIikZPjSXKS+/o2jDPprFU1H2vW6nPMvT4r/OKxHL2HQL4GR9BQnoykwnh0bM4nuGx9i4hmEtZQnJH9IADdSQrMxHzGX5CuN7ArpWqCBMGsi3v1NJkRK9CzuIxW0Ffasyi+Hh+e12T6oYRlkCUS1yGLJVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D51a5frh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F08AC4CECD;
	Sat,  7 Dec 2024 18:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733594530;
	bh=Jxot+HTaLU1cfK7uzk3/7NQ3O+57RfGJvvYTPRIrdn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D51a5frhTXDeYuGxp/LWuRSrsieCcCnGdcbZArScctOgdSRq2CTDCS8p32OwRnVva
	 Vd/V9bB3vXF014ebgivJAm+Eg0gDyw99L++1sr2a+QznoLb/cgdDUqZd+10iNi+gNQ
	 5vuHdyoxV1f4TTZtMkuy6cUbGDzHgipJLm2piNuLttEAEvSGxkcy4LUD9IRWSax7kF
	 P0M5WrZBImPY0eY9+FpRDC8R1q4oIcsZdIFymHmqVaWVJV5pL5VKj5d5K13k+YhjQI
	 o5Y2L3Cw3WyuVo+G1A6EFZN831FFG3kww5SRO2u0bPyTTTuOz4ZZ2YFRJa18/hR5I1
	 ESutZRXedFFog==
Date: Sat, 7 Dec 2024 18:02:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Mehdi Djait <mehdi.djait@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: kx022a: document new chip_info structure
 members
Message-ID: <20241207180201.51deb7ce@jic23-huawei>
In-Reply-To: <Z1LDUj-naUdGSM6n@mva-rohm>
References: <Z1LDUj-naUdGSM6n@mva-rohm>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Dec 2024 11:26:42 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

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
Applied to the togreg branch of iio.git. Initially pushed out as testing.

Mehdi, if you want to give a tag (or more feedback) I am happy to rebase
for a few days.

Jonathan

> ---
> Revision history:
> v1 => v2:
> - Improved wording based on discussion with Mehdi.
> 
>  drivers/iio/accel/kionix-kx022a.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> index 142652ff4b22..d18d56cef098 100644
> --- a/drivers/iio/accel/kionix-kx022a.h
> +++ b/drivers/iio/accel/kionix-kx022a.h
> @@ -137,6 +137,14 @@ struct kx022a_data;
>   *
>   * @name:			name of the device
>   * @regmap_config:		pointer to register map configuration
> + * scale_table:			An array of tables of scaling factors for
> + *				a supported acceleration measurement range.
> + *				Each table containing a single scaling
> + *				factor consisting of two integers. The first
> + *				value in a table is the integer part, and
> + *				the second value is the	fractional part as
> + *				parts per billion.
> + * scale_table_size:		Amount of values in tables.
>   * @channels:			pointer to iio_chan_spec array
>   * @num_channels:		number of iio_chan_spec channels
>   * @fifo_length:		number of 16-bit samples in a full buffer
> 
> base-commit: 05ff9c9c53c643551fe08fe52bd714310b9afc2e


