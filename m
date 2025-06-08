Return-Path: <linux-iio+bounces-20319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC72CAD133D
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 18:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50BC3AB58F
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CB6188A3A;
	Sun,  8 Jun 2025 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9njMEj0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9C8633F;
	Sun,  8 Jun 2025 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749399357; cv=none; b=DI8iK8SguAPMN0XtinNGm6wzl8rFKXVKYdSiFi2tPGXHMItGSxj0Cxd6lwD+9DscMFuR6AvYx4aHrIDf4pMyXhz1FnB1cVgFduvMQu0aIQ8jxybO45deiIVk9TNFAFcVQO6s8vYgmS2G4e7ZX3bcAN1eWbIBNJawlFwMYDV8yVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749399357; c=relaxed/simple;
	bh=gqGaHZGQgOFyeGGY/SL3O19BEfGUgejN1u1eQObhnkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtDE2fWjG+9VaKm0SXAB7p1SVnHyIkze7w1hHEcLT5SMY1+mdG2XPfd5Lb0UHWP5v96Y3a28hIg7cdCoilnDAPvyikpSJuQvupYpoqpjNXbVzyHupWEqXPUPFEa4EW5HcVarvypvnSGnAYnoeHI4YuCKcVKKsECD4u+2qqTPu4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9njMEj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26B9C4CEEE;
	Sun,  8 Jun 2025 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749399355;
	bh=gqGaHZGQgOFyeGGY/SL3O19BEfGUgejN1u1eQObhnkk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p9njMEj0tBwu3WyUedWI9CBno/rJmsrA3UUKVxP/squeTbRCI5XNBBQZzOVEl75HG
	 +l16DfLXUfAKn+pYGKgrdnHz6l+bh2HA8NgOaaSOIX+/9sw18gj5uKFNgYmbXAODBM
	 UqQYL9fcj1hl+Ab1tuqnHLEReuNeEG7HXBCKggbVE9MyWV8pRxjvA9qmGTeJT5x+96
	 fezMkkOCWMDSOYqgRAbWQ9s1mswmO82URzE2k0fGWnD2yJ6W2mx0fk0SfsEiUsUgdX
	 RhmHfHVFce21VlYxiWeWdp6jQreOnU+urYbZDbiIncudP2VpzRbSa28dkVNsJW9UfF
	 91oOx0CzGIeyQ==
Date: Sun, 8 Jun 2025 17:15:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/11] iio: accel: adxl313: implement power-save on
 inactivity
Message-ID: <20250608171547.0f644d5b@jic23-huawei>
In-Reply-To: <20250601172139.59156-10-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-10-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Jun 2025 17:21:37 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Link activity and inactivity to indicate the internal power-saving state.
> Add auto-sleep to be linked to inactivity.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl313.h      |  3 +++
>  drivers/iio/accel/adxl313_core.c | 20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
> index d7e8cb44855b..75ef54b60f75 100644
> --- a/drivers/iio/accel/adxl313.h
> +++ b/drivers/iio/accel/adxl313.h
> @@ -41,6 +41,9 @@
>  #define ADXL313_RATE_BASE		6
>  
>  #define ADXL313_POWER_CTL_MSK		BIT(3)
> +#define ADXL313_POWER_CTL_INACT_MSK	GENMASK(5, 4)
> +#define ADXL313_POWER_CTL_LINK		BIT(5)
> +#define ADXL313_POWER_CTL_AUTO_SLEEP	BIT(4)
>  
>  #define ADXL313_RANGE_MSK		GENMASK(1, 0)
>  #define ADXL313_RANGE_MAX		3
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index c5767d56b0cb..1598562a38e2 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -396,6 +396,7 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
>  	unsigned int axis_ctrl;
>  	unsigned int threshold;
>  	unsigned int inact_time_s;
> +	int act_en, inact_en;
>  	bool en;
>  	int ret;
>  
> @@ -431,6 +432,25 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Set sleep and link bit only when ACT and INACT are enabled.
> +	 */

Single line comment style preferred.

> +	act_en = adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
> +	if (act_en < 0)
> +		return act_en;
> +
> +	inact_en = adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
> +	if (inact_en < 0)
> +		return inact_en;
> +
> +	en = en && act_en && inact_en;
> +
> +	ret = regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,
> +				 (ADXL313_POWER_CTL_AUTO_SLEEP | ADXL313_POWER_CTL_LINK),
> +				 en);
> +	if (ret)
> +		return ret;
> +
>  	return adxl313_set_measure_en(data, true);
>  }
>  


