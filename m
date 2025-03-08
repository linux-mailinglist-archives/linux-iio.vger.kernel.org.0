Return-Path: <linux-iio+bounces-16553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C4A57AD6
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 15:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2380188E66A
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6781049620;
	Sat,  8 Mar 2025 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpBzIgWz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C94B7482;
	Sat,  8 Mar 2025 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741442513; cv=none; b=KoLb0o82PHFKB6ZJtxO/QGkvyvOEs3gNrrwNfgzDtge8RXBIP4/TtQDKJv8XaWVZkcipITpL7j1SIuDtX648TrPsIAENN9bZSPbMUNszCPwhb6RTWCgxueG/WL8pr+YDsnn6rmIELhVEdwot/I3ovYtgpuYI36X3Bgex0GELY3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741442513; c=relaxed/simple;
	bh=wtpHMdMGkiIMoaObAdXJh/8mZCXy/1mOy5K+kCxcYGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nt1ZXesve8CGb9VIzNrLMySseMwTAINUL/tKrb/uhFzB4wU/U8dRwsHaVxcRLC+xfq7WnYjCcxT4kL/PpjVeeXp14ov05dtVN4zn9nbhhllT85qeQH8WDjFs7MskHyGO1abiFs7w0nGgva9ZWVo6DwV7nPAiwaDlPps88SatGmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpBzIgWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B51C4CEE0;
	Sat,  8 Mar 2025 14:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741442513;
	bh=wtpHMdMGkiIMoaObAdXJh/8mZCXy/1mOy5K+kCxcYGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KpBzIgWzZfbaU4awH4BedtqLNmprUoJ68WlXyO7idQ5tczyDem0+/N398Co+btFHL
	 cqFGTH8GjD7/WvWLnsmpE+L1tkdVmGeQZn48ilD9bnPfvP8y5oQ7/6qg34w5zLvmQg
	 vku+U0pLiYbPs4nVVU529EjLlTR5zAWsyJwtkJGT/uiuy8tyjvSrXyOor4unH8njZN
	 FYohTUwrIG9bZWcafkmnfTbT12DsGI/iZX0UI/2ocrjI0TBp0wMzphjSSmjviIsdwQ
	 8p+ADlCcEG6aryIiz9qsktcyxzGH+lNaDSXEEkqWT60bb3AEzsnn/fp9jy0ZZMfkw/
	 XlKTLeOlMYYBw==
Date: Sat, 8 Mar 2025 14:01:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, antoniu.miclaus@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, bpellegrino@arka.org
Subject: Re: [PATCH v6 6/6] iio: filter: admv8818: Support frequencies >=
 2^32
Message-ID: <20250308140143.411caf7b@jic23-huawei>
In-Reply-To: <20250307150216.374643-6-sam.winchenbach@framepointer.org>
References: <20250307150216.374643-1-sam.winchenbach@framepointer.org>
	<20250307150216.374643-6-sam.winchenbach@framepointer.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Mar 2025 10:02:16 -0500
Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:

> From: Brian Pellegrino <bpellegrino@arka.org>
> 
> This patch allows writing u64 values to the ADMV8818's high and low-pass
> filter frequencies. It includes the following changes:
> 
> - Rejects negative frequencies in admv8818_write_raw.
> - Adds a write_raw_get_fmt function to admv8818's iio_info, returning
>   IIO_VAL_INT_64 for the high and low-pass filter 3dB frequency channels.
> 
> Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
> Signed-off-by: Brian Pellegrino <bpellegrino@arka.org>
> Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
I only have that minor comment on patch 5.  If nothing else comes up
and the dt binding ack comes in I may just tidy that up whilst applying.

> ---
>  drivers/iio/filter/admv8818.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
> index e9602bfd4af7..9785533d0cdd 100644
> --- a/drivers/iio/filter/admv8818.c
> +++ b/drivers/iio/filter/admv8818.c
> @@ -402,6 +402,19 @@ static int admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
>  	return ret;
>  }
>  
> +static int admv8818_write_raw_get_fmt(struct iio_dev *indio_dev,
> +								struct iio_chan_spec const *chan,
> +								long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> +		return IIO_VAL_INT_64;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int admv8818_write_raw(struct iio_dev *indio_dev,
>  			      struct iio_chan_spec const *chan,
>  			      int val, int val2, long info)
> @@ -410,6 +423,9 @@ static int admv8818_write_raw(struct iio_dev *indio_dev,
>  
>  	u64 freq = ((u64)val2 << 32 | (u32)val);
>  
> +	if ((s64)freq < 0)
> +		return -EINVAL;
> +
>  	switch (info) {
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		return admv8818_lpf_select(st, freq);
> @@ -571,6 +587,7 @@ static int admv8818_set_mode(struct iio_dev *indio_dev,
>  
>  static const struct iio_info admv8818_info = {
>  	.write_raw = admv8818_write_raw,
> +	.write_raw_get_fmt = admv8818_write_raw_get_fmt,
>  	.read_raw = admv8818_read_raw,
>  	.debugfs_reg_access = &admv8818_reg_access,
>  };


