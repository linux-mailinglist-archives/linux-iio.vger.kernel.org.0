Return-Path: <linux-iio+bounces-13223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B99C9E8639
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8630A1604C0
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 16:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5759A15A856;
	Sun,  8 Dec 2024 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7RKLXI6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E381591EA;
	Sun,  8 Dec 2024 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733674488; cv=none; b=Ny1mMe3f/pnzZFH7rivS5c54rUlFMELKv6NHk8hsuJSK6TXkrzgvUh2+nK5N6w5l02digKen5NmTVbJUeM51qIc6wrwTlpPnkMr6K1hzsvvWfDn+RS3yf5w59LKmkPIs7CfG+RlV8GrkBzR9EGrnFntcGQ7KLXeCAiBMKZ9wKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733674488; c=relaxed/simple;
	bh=/oUxQOgGhtw7cy0KuYCAMS4UA1F+BonCPtvsDjNMjUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWsr/PZ5XZ+387Mayanq7HXWpyWKPlVr2mVlvBC9ERTQbk2a6GG/tksALg+eYLAx+4ij5fLvNaF3DxM0x8v5MkBjbSlfFjZbhhtAInOByzu0W+/Ou+iWZKA9QreJpp7l1ki4TLIN4KIuxS92qa8LjLWLIHubLWrRJ6hbkfIZjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7RKLXI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C63C4CED2;
	Sun,  8 Dec 2024 16:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733674487;
	bh=/oUxQOgGhtw7cy0KuYCAMS4UA1F+BonCPtvsDjNMjUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B7RKLXI6jG+2liVECtBJosdYqZOWP73CT2QpgvIaKTm1gix+yaWpK7bB4zHt8lNbX
	 M3hvzUIYVhIB/LZckohyC3KFomc7trJ+t+OPSrY97BvExpvhGDNFP6zectuhXvHv7u
	 +uqoS/gFxW4M0e9JvcEJh5jTIvTzI0iUFLeM7fBwZ0aEnCvXNYzFzdsW+bE5FAlDlc
	 dR7N7rltXZhnurVZf1ncCaE+C2cWiahF+JBeXrnX3AOTqEB7j3uJaUmU5+NMdZM+97
	 V7c0DzL0s+kOQcHnGTzPruhx77R7W8GiFjY7vBV355TA16uUBJ8qrM/0UVjP2atjIn
	 CZlTCQeVLAKbQ==
Date: Sun, 8 Dec 2024 16:14:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 07/10] iio: accel: adxl345: introduce interrupt
 handling
Message-ID: <20241208161438.0b2916fb@jic23-huawei>
In-Reply-To: <20241205171343.308963-8-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
	<20241205171343.308963-8-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Dec 2024 17:13:40 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the possibility to claim an interrupt. Init the state structure
> with an interrupt line obtained from the DT. The adxl345 can use
> two different interrupt lines for event handling. Only one is used.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 1d020b0d79c..e0a8b32239f 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -11,6 +11,7 @@
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/units.h>
> +#include <linux/interrupt.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -18,8 +19,10 @@
>  #include "adxl345.h"
>  
>  struct adxl345_state {
> +	int irq;
Ordering is non obvious. I'd keep the pointers first and have
this before intio.
>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
> +	u8 intio;
>  };
>  
>  #define ADXL345_CHANNEL(index, axis) {					\
> @@ -212,6 +215,17 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  
>  	st = iio_priv(indio_dev);
>  	st->regmap = regmap;
> +
> +	st->intio = -1;
It's a u8 so negative doesn't seem sensible choice.

> +	st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> +	if (st->irq > 0)
Where one leg needs {} convention is to use it for all of them.
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#placing-braces-and-spaces
last part.



> +		st->intio = ADXL345_INT1;
> +	else {
> +		st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
> +		if (st->irq > 0)
> +			st->intio = ADXL345_INT2;
> +	}
> +
>  	st->info = device_get_match_data(dev);
>  	if (!st->info)
>  		return -ENODEV;


