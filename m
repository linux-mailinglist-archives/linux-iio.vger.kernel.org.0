Return-Path: <linux-iio+bounces-9327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E47970777
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 14:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB18F1F210D1
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 12:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ABF1DA26;
	Sun,  8 Sep 2024 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+3o9JDI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1711843;
	Sun,  8 Sep 2024 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725799142; cv=none; b=OD8epf4Ax5U5qa10CyQbdFsyDAOaZoZPb0A6qMV3grZR5802Y8c5eyBOkWDnMI8ELkxydnT8Gfaneg3XoXDQRfoecO43KyDVPt3uu984dS1GTkX90s7OeI6ZChvW+F9p1zKUKzwqYryGe1Gn7jIJI2Na6ZH4KXp1lmjtTodXR+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725799142; c=relaxed/simple;
	bh=j7MjqD0Uy+ztK0YQRZtbjpz9aAWhj7Ch/oB6PCH3LWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YdmMOO4f+jus/BUvk2IilHHZ6CsVcS1YNl7NaTyRydy3SiUow+BT+/tIxT0WNKPRTtWsxqDIGfnQlNMU9ersk3f5gCmTaC30BTePGbW5aSxU8CrbHhqSiCcgqMJ5gmxmqA80W1zv2YIOdq0XhbmAkPWE7yyRp84meX+8ivFlWik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+3o9JDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29F0C4CEC3;
	Sun,  8 Sep 2024 12:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725799142;
	bh=j7MjqD0Uy+ztK0YQRZtbjpz9aAWhj7Ch/oB6PCH3LWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E+3o9JDIfmcxpeIVWZQV+2aj/ne6K97LHSp36jMzJVuZg1pFYYhJpkacX8hb7LNF/
	 i4nQwbINENYo0H6xgbKgHdvlu3PRKOkZOhA1cWIXAy2FzMZNZS6qU13VOmALhE8fqZ
	 fHhxMFIL3oGd3g8BmpzKcGasn8SosYi5czSjpDGN2a0nkCMNOpWVE+zMmk+0gQqlRI
	 wavstQ3WLA2yZYDKpOUVM4GhMp51q2/TwG1QqyWj6miIpg8w1joCcgIAZWd+vKc66a
	 TTRARINC71zyazWRaKpHSiE2tGRVCENgy+RVE7beDQJsN1ZjO8JXBepV5NPLb5Y9r9
	 imJNfc95nT1rw==
Date: Sun, 8 Sep 2024 13:38:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH v2 2/9] iio: backend: extend features
Message-ID: <20240908133852.2599297a@jic23-huawei>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-2-87d669674c00@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-2-87d669674c00@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Sep 2024 17:17:32 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Extend backend features with new calls needed later on this
> patchset from axi version of ad3552r.
> 
> A bus type property has been added to the devicetree to
> inform the backend about the type of bus (interface) in use
> bu the IP.
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
> iio_backend_bus_reg_read
> 	generic bus read, bus-type dependent
> iio_backend_bus_read_write
> 	generic bus write, bus-type dependent

The RAMP_16 definition doesn't seem immediately connected to the rest.
+ I'm not sure what it is from the name.

> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/industrialio-backend.c | 157 +++++++++++++++++++++++++++++++++++++
>  include/linux/iio/backend.h        |  33 ++++++++
>  2 files changed, 190 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 20b3b5212da7..231bef4b560e 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -718,6 +718,163 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
>  	return 0;
>  }
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 37d56914d485..eb8c5bb74bb5 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
>  
>  enum iio_backend_data_source {
>  	IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE,
>  	IIO_BACKEND_EXTERNAL,
> +	IIO_BACKEND_INTERNAL_RAMP_16,

Not obvious what this is so maybe this enum needs docs in general.

>  	IIO_BACKEND_DATA_SOURCE_MAX
>  };

