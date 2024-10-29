Return-Path: <linux-iio+bounces-11579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B2D9B54C4
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 22:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3052C1C228D1
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 21:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D07207A22;
	Tue, 29 Oct 2024 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3THdEC4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BD51991CD;
	Tue, 29 Oct 2024 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236390; cv=none; b=tle9ywviuYuUCvRrHxqQvQyyHW3oX885XQkRl56i0qb6+tCdUSmG3y7zxRMN2gZPTHLWfGpWNEPss4cVAlX0irUkmVNSPSNKpTaMs58Xsm8KQsIRcCtdui9MYIvdrAHtfmiF8yX6OLVNgeni9T26VGUVEjD3Cdq+bSLI67a7WIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236390; c=relaxed/simple;
	bh=UIloyf9GWceu9AJZ1bOJRHkzgWSMZfwaSaOXTr6hSWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ck1oHePYguiyXn+XFOcV2Kg0P85qT6sy9TjB/qOLDedxm4grUtsmbLkC2H6+6/NMRq1BOd+bdUJEtX2o0850+ppTEJxZVNHke1cejJYOVKwAY7/UcUit0JZhYC24gHqlG5Rx4Re5IhZhvzSg2YiKuAlvFSbayWB1oHiw5VfClbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3THdEC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C49FC4CECD;
	Tue, 29 Oct 2024 21:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730236390;
	bh=UIloyf9GWceu9AJZ1bOJRHkzgWSMZfwaSaOXTr6hSWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B3THdEC4+mCzDFFO+9NnivZNL8WsxjwdSz0b+2uDs7XLYmGOf46gQaNCBpltNWK6z
	 xeb+0U3psqxDHBYONlKxWvbDvgZ1iWmURfjWNR8z2VCa1xpgMMIjfYXUB1RKArfqG0
	 8hJMORdV7jzBy8q3uzzA3L5TGXfVCFxCYwDM6Q6R083+YhTywC100HyI/rb4vQtbuY
	 iKvfntpybks9woR1iD9KufwIPvn2S+wrAvOVzI/YQMfRqTpCOVKmHRHy+AZwY6gRyE
	 YmX4zYabVzKEFH6hGbacjnaJFuJ47mkDWgXcsTsVET1FB/GGyRhSS7XOf0lSdOSRPV
	 N3rdbkvhbA7Lg==
Date: Tue, 29 Oct 2024 21:13:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: veml6070: add support for
 integration time
Message-ID: <20241029211303.430c13c5@jic23-huawei>
In-Reply-To: <20241028-veml6070-integration-time-v3-2-dd7ace62f480@gmail.com>
References: <20241028-veml6070-integration-time-v3-0-dd7ace62f480@gmail.com>
	<20241028-veml6070-integration-time-v3-2-dd7ace62f480@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 18:14:02 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The integration time of the veml6070 depends on an external resistor
> (called Rset in the datasheet) and the value configured in the IT
> field of the command register, whose supported values are 1/2x, 1x,
> 2x and 4x.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Minor thing inline about not necessarily papering over wrong
settings in DT.  If someone has a genuine out of range value then we don't
want to carry on with a default. If it is a dt bug then we have no idea
what the correct value is.  Either way I think printing a shouty message
and failing the probe is the way to go.

Jonathan

> ---
>  drivers/iio/light/veml6070.c | 134 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 126 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
> index d11ae00f61f8..89b3ccb51515 100644
> --- a/drivers/iio/light/veml6070.c
> +++ b/drivers/iio/light/veml6070.c
> @@ -6,7 +6,7 @@
>   *
>   * IIO driver for VEML6070 (7-bit I2C slave addresses 0x38 and 0x39)
>   *
> - * TODO: integration time, ACK signal
> + * TODO: ACK signal
>   */
>  
>  #include <linux/bitfield.h>
> @@ -15,6 +15,7 @@
>  #include <linux/mutex.h>
>  #include <linux/err.h>
>  #include <linux/delay.h>
> +#include <linux/units.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -29,18 +30,84 @@
>  #define VEML6070_COMMAND_RSRVD	BIT(1) /* reserved, set to 1 */
>  #define VEML6070_COMMAND_SD	BIT(0) /* shutdown mode when set */
>  
> -#define VEML6070_IT_10	0x01 /* integration time 1x */
> +#define VEML6070_IT_05		0x00
> +#define VEML6070_IT_10		0x01
> +#define VEML6070_IT_20		0x02
> +#define VEML6070_IT_40		0x03
> +
> +#define VEML6070_MIN_RSET_KOHM	75
> +#define VEML6070_MIN_IT_US	15625 /* Rset = 75 kohm, IT = 1/2 */
>  
>  struct veml6070_data {
>  	struct i2c_client *client1;
>  	struct i2c_client *client2;
>  	u8 config;
>  	struct mutex lock;
> +	u32 rset;
> +	int it[4][2];
>  };
>  
> +static void veml6070_calc_it(struct device *dev, struct veml6070_data *data)
> +{
> +	int i, tmp_it;
> +
> +	data->rset = 270000;
> +	device_property_read_u32(dev, "rset-ohms", &data->rset);
> +
> +	if (data->rset < 75000) {
> +		dev_warn(dev, "Rset too low, using minimum = 75 kohms\n");
> +		data->rset = 75000;
Why are we papering over a DT issue?  Are there known DT out there that hit this
we want to keep working?

If not I'd just error out on out of range values - that way they get fixed
faster!

> +	}
> +
> +	if (data->rset > 1200000) {
> +		dev_warn(dev, "Rset too high, using maximum = 1200 kohms\n");
> +		data->rset = 1200000;
> +	}
> +
> +	/*
> +	 * convert to kohm to avoid overflows and work with the same units as
> +	 * in the datasheet and simplify UVI operations.
> +	 */
> +	data->rset /= KILO;
> +
> +	tmp_it = VEML6070_MIN_IT_US * data->rset / VEML6070_MIN_RSET_KOHM;
> +	for (i = 0; i < ARRAY_SIZE(data->it); i++) {
> +		data->it[i][0] = (tmp_it << i) / MICRO;
> +		data->it[i][1] = (tmp_it << i) % MICRO;
> +	}
> +}

