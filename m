Return-Path: <linux-iio+bounces-6768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047F0913C8D
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 17:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24D7282205
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 15:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD501822DA;
	Sun, 23 Jun 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tw1v0+EG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7496AF9F0;
	Sun, 23 Jun 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719157770; cv=none; b=FanhjgOIhUO1xesJ42CnaTjZ3o94vEgkf2UkpxUtxwZKd7H30PhBSHI+pOrC4P8basjK/NAucMA0fYhXvlLf3npYNv1RA+RHZuv0GnTILHgs0ZyiE42J2aomuNIZtmGdpuB+3eOa9XMjEFRpeT0aHaFmOollD2A9WlQs+USSneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719157770; c=relaxed/simple;
	bh=yTJvxHgHRHuY1rMYzUx6RddPEDw9lS+t+x9ruVt783c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqmcQWtUqbtIfB/x6PLuB1GjmURnklrb9Cd6os2biBdfEhb63ojlCGLY1JYKiGhMGX8SZSIYdJq1zZwND0NhB0CWggtT6guJD8KWIuMUq3PLGt16icMSgY8EqQzGXZVwCUcghFD9HLzA/Zf39If7M2TALQKuV+0rUyHGpgFki4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tw1v0+EG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E998CC2BD10;
	Sun, 23 Jun 2024 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719157769;
	bh=yTJvxHgHRHuY1rMYzUx6RddPEDw9lS+t+x9ruVt783c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tw1v0+EGLX3NUf0lMQL8wS1FwyD696x5mkkJvyRp2t/IwWTw9SY64HIKlTHRgGDWa
	 1YFKCnf4ROfED72rq26laaN3LfgWlokAdIzsX95RQqyiCQjO8FghmsON7xaNSxUjy3
	 lv/UNhLjjvZIg0Uh/WCQykls3oZ4JOtvkB6OircBhidbmhtxXmkBBcTwyUBJt29Scu
	 Ehnw9cpjNDjsQQMTgsQ7VPZIbP6uPGE+v0uPe9jWfXUYPm+lEjRdbxccazcpPdtkxJ
	 RlymGm5AtEiW6zWvukWvGQVY5Go8XZ7Vf5lip2OjNylk5fB7yls0fAl3y7nvWI0Wuu
	 NC4BHFhheuzcw==
Date: Sun, 23 Jun 2024 16:49:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH 9/9] iio: adc: ad7606: fix standby gpio state to match
 the documentation
Message-ID: <20240623164920.48dda649@jic23-huawei>
In-Reply-To: <20240618-cleanup-ad7606-v1-9-f1854d5c779d@baylibre.com>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
	<20240618-cleanup-ad7606-v1-9-f1854d5c779d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 14:02:41 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> The binding's documentation specifies that "As the line is active low, it
> should be marked GPIO_ACTIVE_LOW". However, in the driver, it was handled
> the opposite way. This commit sets the driver's behaviour in sync with the
> documentation
> 
> Fixes: 722407a4e8c0 ("staging:iio:ad7606: Use GPIO descriptor API")
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>

This sound dangerous.  If anyone is using the driver before this an it's
working they indeed have the pin inverted wrt to the docs, but
as it works for them this will be a regression.

So messy corner - do we fix the docs or the driver?  I'm not sure which
is more painful. In theory the DT binding might be in use by another
OS or similar which might have a non broken driver, but I suspect it isn't.
Whereas perhaps the driver as it stands is in use on Linux.

AD folk: You will get the support calls, do you want to risk them or
should we change the docs (and maybe add a note on it being 'odd' wrt
to the documentation as we are treating it as an active !standy pin)
> ---
>  drivers/iio/adc/ad7606.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 502344e019e0..05addea105f0 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -438,7 +438,7 @@ static int ad7606_request_gpios(struct ad7606_state *st)
>  		return PTR_ERR(st->gpio_range);
>  
>  	st->gpio_standby = devm_gpiod_get_optional(dev, "standby",
> -						   GPIOD_OUT_HIGH);
> +						   GPIOD_OUT_LOW);
>  	if (IS_ERR(st->gpio_standby))
>  		return PTR_ERR(st->gpio_standby);
>  
> @@ -681,7 +681,7 @@ static int ad7606_suspend(struct device *dev)
>  
>  	if (st->gpio_standby) {
>  		gpiod_set_value(st->gpio_range, 1);
> -		gpiod_set_value(st->gpio_standby, 0);
> +		gpiod_set_value(st->gpio_standby, 1);
>  	}
>  
>  	return 0;
> 


