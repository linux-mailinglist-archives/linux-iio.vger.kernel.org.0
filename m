Return-Path: <linux-iio+bounces-9097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50C896A7B6
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 21:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739CF280AAD
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 19:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D06B1DC739;
	Tue,  3 Sep 2024 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHdZ9whQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023151DC720;
	Tue,  3 Sep 2024 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392867; cv=none; b=B2zYb8GdbUyv8M/9RPX1cz1/n4bTBBSwG4tz18lve3Vq4960tj6PDPF5JrVq0/kq0YVx7Aaml7sXJ6txUwRB69r8LkAtD2asVWor4fhcP+D2drlVlxiBcETX0J0lbYKWmT4OOFb0bJevXmJ4tnD0paHPsMJaV65ICPGom+wSJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392867; c=relaxed/simple;
	bh=U4A3pCwQ8/EbM4aeqrIb3zzmf5B948+U++dXeaD+0fw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0/qca92SaegFFCbOz5Hw2LNkqsDtClLN0ahUEusq9z1q9oYDD19At+yfXAz0k9tuVXHQ6mjB6am8dnYF0XxcnrukxQUmy/UgHrfWSxwq9te1VTyLuFuThKUV0XPl8mkNMgKAPzhAkdOHTFxFBHDD3TitiaGuvZr9B3Qngh1XNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHdZ9whQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E49C4CEC4;
	Tue,  3 Sep 2024 19:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725392866;
	bh=U4A3pCwQ8/EbM4aeqrIb3zzmf5B948+U++dXeaD+0fw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vHdZ9whQz0I8ZtZX+b5pM9uapfWQ3scd83hcOx1cfd3dtzT88FYDiQ156i7hspdVn
	 j7oT28rCz/kUAJGswxxcP3/Ggff6k9cksqEUxEEDprkLyrINe4rpWE1rLI+YmE2ULZ
	 zTlnh9h67IBwtfo4wo4D+3behY4F8S8oQF4OSI1wjmCVL7wZIyf4RRJ6qqXh/6FKWn
	 y8rLOIYk1FwvQ8aglJoHyhkHprTG7LvEocRordvMwFtKEIy5gDh+2mv1NYcW4Uvq4l
	 GDoRiYfAzCt6UUOjlD8Ld3qgQol0uylZFlumh4CSJDl+MIw6EFzreHFRbL5/r9O+jp
	 fi0m74R6vPLeg==
Date: Tue, 3 Sep 2024 20:47:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina
 <jikos@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 10/22] iio: dac: max517: Get platform data via
 dev_get_platdata()
Message-ID: <20240903204737.710e49dd@jic23-huawei>
In-Reply-To: <20240902222824.1145571-11-andy.shevchenko@gmail.com>
References: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
	<20240902222824.1145571-11-andy.shevchenko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Sep 2024 01:16:55 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Access to platform data via dev_get_platdata() getter to make code cleaner.
> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/dac/max517.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
> index 685980184d3c..96781ae04f9d 100644
> --- a/drivers/iio/dac/max517.c
> +++ b/drivers/iio/dac/max517.c
> @@ -143,10 +143,10 @@ static const struct iio_chan_spec max517_channels[] = {
>  
>  static int max517_probe(struct i2c_client *client)
>  {
> +	const struct max517_platform_data *platform_data = dev_get_platdata(&client->dev);
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct max517_data *data;
>  	struct iio_dev *indio_dev;
> -	struct max517_platform_data *platform_data = client->dev.platform_data;
>  	int chan;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> @@ -176,7 +176,7 @@ static int max517_probe(struct i2c_client *client)
>  
>  	/*
>  	 * Reference voltage on MAX518 and default is 5V, else take vref_mv
> -	 * from platform_data
> +	 * from platform_data.

I guess this is accidental?  

J

>  	 */
>  	for (chan = 0; chan < indio_dev->num_channels; chan++) {
>  		if (id->driver_data == ID_MAX518 || !platform_data)


