Return-Path: <linux-iio+bounces-12868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBEB9DF24A
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B40F162B3A
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820291A725C;
	Sat, 30 Nov 2024 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVdMRJex"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A031A3A8D;
	Sat, 30 Nov 2024 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732988276; cv=none; b=OtQIjM8ZoUrq/pHNNbAvGXpfYBuBHRgSxaMP9gI1zXnMdSU/FyOTwCZZbCxNL/18aNT2Nx+0s1kPlZ+E8e9i5r17OFmWh1qB0l28snh0m3vk6QH6F9oKSIlmO+nmSVf/wNlVCSXmjd8bWvccyYJNpZT61R6NWQ+lRAbrPnHdYXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732988276; c=relaxed/simple;
	bh=kCOuUEuvajqw8g2jrtCdEozPv6Hbu6aXVg+GWPVlp64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZucVerz/jIo8dF9d++SBw1oEvVBUrJ0bymTEcMOBkY0ffVD/JDBfiAwxgW6q6kAnwvKH0Rj4bsLEBwPRj1FkVJVjbHSIX3/0K+X+iHc63GJzV3l6ReiGhfKTACrBzrnlLBuLLsRUh12k4dN/lNBsDfmCW+z8kMnHFkV+cOoSNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVdMRJex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8D4C4CECC;
	Sat, 30 Nov 2024 17:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732988275;
	bh=kCOuUEuvajqw8g2jrtCdEozPv6Hbu6aXVg+GWPVlp64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OVdMRJexHC6QlZVd0Qon7qUmZgzhLcnUdjZU2pXIJ57UQnaYd7j6ad4CAd7fddmb2
	 gn3txEDBs5kHEBF7w2wnoS57OzU+ETaZ3NkQqyiQTD3S0+SuYzPee19gANK8bsnTde
	 PgS3EFDK7NB1oSM36SeAxK/c1ba8hF3aF02L0cFyzbdw3rGrrAXZqPfW5yzbsy82qH
	 oBNH3d7m6ooVThzEcZutSolzGazWFjyAZry7OBJ2qcbENA0jK+ho2TAFyXKeqitUjX
	 1Qpw57hiYpfPaN45bh84YCInxqxKXTKaImAnN9wuriGhzRC6gpVj7lGVZxCkX+NJgj
	 X9WVCPJPyyShA==
Date: Sat, 30 Nov 2024 17:37:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH v5 2/4] iio: adc: ad4000: Add timestamp channel
Message-ID: <20241130173745.52dd528a@jic23-huawei>
In-Reply-To: <b151d6ec2eeae52718ab985a24b237049dbd283b.1732885470.git.marcelo.schmitt@analog.com>
References: <cover.1732885470.git.marcelo.schmitt@analog.com>
	<b151d6ec2eeae52718ab985a24b237049dbd283b.1732885470.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Nov 2024 10:13:52 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The ADC data is pushed to the IIO buffer along with timestamp but no
> timestamp channel was provided to retried the time data.
> Add a timestamp channel to provide sample capture time.
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
H Marcelo,

Given you are going to be spinning a v6 anyway, trivial comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad4000.c | 98 +++++++++++++++++++++++-----------------
>  1 file changed, 56 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> index b3b82535f5c1..21731c4d31ee 100644
> --- a/drivers/iio/adc/ad4000.c
> +++ b/drivers/iio/adc/ad4000.c
> @@ -49,6 +49,7 @@
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
>  			      BIT(IIO_CHAN_INFO_SCALE),				\
>  	.info_mask_separate_available = _reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0,\
> +	.scan_index = 0,							\
>  	.scan_type = {								\
>  		.sign = _sign,							\
>  		.realbits = _real_bits,						\
> @@ -62,6 +63,12 @@
>  	__AD4000_DIFF_CHANNEL((_sign), (_real_bits),				\
>  				     ((_real_bits) > 16 ? 32 : 16), (_reg_access))
>  
> +#define AD4000_DIFF_CHANNELS(_sign, _real_bits, _reg_access)			\
> +{										\
> +	AD4000_DIFF_CHANNEL(_sign, _real_bits, _reg_access),			\
> +	IIO_CHAN_SOFT_TIMESTAMP(1)						\
Add a trailing ,
In theory we can add more channels after this.
> +}
> +
>  #define __AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access)\
>  {										\
>  	.type = IIO_VOLTAGE,							\
> @@ -71,6 +78,7 @@
>  			      BIT(IIO_CHAN_INFO_SCALE) |			\
>  			      BIT(IIO_CHAN_INFO_OFFSET),			\
>  	.info_mask_separate_available = _reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0,\
> +	.scan_index = 0,							\
>  	.scan_type = {								\
>  		.sign = _sign,							\
>  		.realbits = _real_bits,						\
> @@ -84,6 +92,12 @@
>  	__AD4000_PSEUDO_DIFF_CHANNEL((_sign), (_real_bits),			\
>  				     ((_real_bits) > 16 ? 32 : 16), (_reg_access))
>  
> +#define AD4000_PSEUDO_DIFF_CHANNELS(_sign, _real_bits, _reg_access)		\
> +{										\
> +	AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _reg_access),		\
> +	IIO_CHAN_SOFT_TIMESTAMP(1)						\
As above. Trailing comma should be here.
The only exception to that is when we have a terminator entry (NULL or similar) 
where we want to make it hard to add anything after it.


> +}
> +

