Return-Path: <linux-iio+bounces-22817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA52FB28E0D
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959853B7A12
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF852E424B;
	Sat, 16 Aug 2025 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHCV/+0/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20426BE46;
	Sat, 16 Aug 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755350211; cv=none; b=AQlsslzXQv/lYGt3dkavQfC41ypq/nb15JSAKSDq/x5L2xJZ8xXbFJWfkmuuAs19YvUJMsN3oqPlo9BFq1d32RV+5WG1qFUfKkhQWD4ozmzXwdUJzDIHjmrp20eqc98wd31kK88VfFD7sn28VQr+O760D7xpM2jAJyltIagohJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755350211; c=relaxed/simple;
	bh=xg5WwaXC31zocxGYhM43TBO5weENvX9hgjSvsSRgut8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvSQ9skyYs7QZzeN8R3U95d3VufaVozz5i891XxQ6wTH40aMyKF3r5efYQ3cyoAgFHQxfwBlqp3P26khJdz5iZXzBeCT6gEL+lwsH+ZyBsJNllQauNWp6cCGKicieTnEzduzDP/ujUSCYcEPOlTSqHbu6RJv+bpW7gb3stwNfs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHCV/+0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC30C4CEEF;
	Sat, 16 Aug 2025 13:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755350210;
	bh=xg5WwaXC31zocxGYhM43TBO5weENvX9hgjSvsSRgut8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DHCV/+0/eYi0UmiBwxBy22tY+RpoiqHVFqF/PC+75eLeALQ0sTdt63hRe0AFUp80z
	 mckas/JjNiZ6nzv96CoxQVJkxW1OYr1kaxfowq61YZNqZvQASb8jw7SP8veDjeTZuC
	 /k4qBoxS/F+uA/gJfQO718eUx2z7oFh7Dq1QfkXxNyv5phYZ3cY24vbcGf5G2pmqn2
	 MLytbaLgZxoLqmEeb0Lq1OJk+BfaC7s58MtNPQ3x2wAnh2zomxXEkNWUz4ANZnow8u
	 u+TXg4x33nYSAdIdssBcKN6g6LgT8mRzwk+GTU/6KfJg/mYVdNZP1SbCZF7UIIEnyZ
	 GXbKJZQRjP8Vw==
Date: Sat, 16 Aug 2025 14:16:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <Michael.Hennerich@analog.com>,
 <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <jonath4nns@gmail.com>
Subject: Re: [PATCH 2/4] iio: adc: ad7768-1: introduce chip info for future
 multidevice support
Message-ID: <20250816141640.4059d337@jic23-huawei>
In-Reply-To: <22ea35425827176a842ea0e523040acd20e27bcc.1754617360.git.Jonathan.Santos@analog.com>
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
	<22ea35425827176a842ea0e523040acd20e27bcc.1754617360.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 23:48:57 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Add Chip info struct in SPI device to store channel information for
> each supported part.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Some minor comments

> ---
>  drivers/iio/adc/ad7768-1.c | 76 ++++++++++++++++++++++++++------------
>  1 file changed, 53 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index a2e061f0cb08..36ba208fc119 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -106,6 +106,7 @@
>  #define AD7768_GPIO_READ_MSK		GENMASK(3, 0)
>  
>  #define AD7768_VCM_OFF			0x07
> +#define AD7768_CHAN_INFO_NONE		0

I'm not convinced this is worthwhile vs 0 which is fairly obviously
a 'nothing to see here' value.

>  
>  #define AD7768_TRIGGER_SOURCE_SYNC_IDX 0
>  
> @@ -213,6 +214,13 @@ static const struct iio_scan_type ad7768_scan_type[] = {
>  	},
>  };
>  
> +struct ad7768_chip_info {
> +	const char *name;
> +	const struct iio_chan_spec *channel_spec;
> +	const unsigned long *available_masks;
> +	int num_channels;

I guess hole concerns pushed num_channels after the pointers.
That's fine but if you move available_masks up one line, then
we can still have channel_spec and the thing that says
how bit it is next to each other.

> +};

