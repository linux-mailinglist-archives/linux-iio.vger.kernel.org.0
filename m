Return-Path: <linux-iio+bounces-12245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 661069C883F
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 12:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81571F2459F
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 11:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A030F1F9A9D;
	Thu, 14 Nov 2024 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC2vXuVX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE81F8926;
	Thu, 14 Nov 2024 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582039; cv=none; b=VcSiIyzsOnnXj2Z2fDsoSaOsw/rWadTrmSqeJyi5/l5lTrUl9PwN0Cgci6Mi4kweKJt1sLvTIyfKdsguamq2JjwIfFeX1O1W/uYYVXWOT1mNCgZ3c9NKBdmaWGB4gugAzXU8/G6dBVXqHDTkB+AmYBuia6RozH0amYYwZl9S/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582039; c=relaxed/simple;
	bh=zI+BxUl7aoHl9/r1ycM7hShTw/0kJXmNINMNVCTOLFg=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=sYTOT+szk6RoYqEtIfP2df8U/gYoYRVZcSVLi85yp0P8XjlZQQdoJq/T1aJiLli5hNu9NYZXrhLu5JOQpOmMulFglwP1ljPLQwiJOQBxptmG8gdHA86dp+fsIhGFp5VVi5SRAv1JNxYG3gz4usB7NPaCx/cG4cmF57LDzfdSM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fC2vXuVX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so4255445e9.2;
        Thu, 14 Nov 2024 03:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731582034; x=1732186834; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:subject:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5hKJkE7s1AODBs8heVonTs+4nlWrD8mC2DlTpxvnLgY=;
        b=fC2vXuVXUjZi+nP9qpoCul+ZkuOX945uAe7gWn7hg1/WHR3pX/04Hdq09UY527Qy5d
         VngY5DnGLUBWoJQgMYj3Cur4Xw/7iuukpyeEBd/TSdKm9U8yuw/7z6KQnbyfR/u32Ts+
         W/2Ij2hE0N21wvhDlWScQvRex9NGlWvxYiqfLKwzsY1qEw+jnLxk1wvjiZoSO8sIqkBP
         i4RDia1A2adkllM6L7tQTgm5A0VGZ2wNZVKDYHon+7SQTwB9K/mKu6aPpY4VZXfldX7S
         Eep0cFf1ouHD3oQOiSWXiBMCWpD+hembdBCxOvpwriHKirZ4GywQRnUmSU28Pb+c3u2i
         JWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582034; x=1732186834;
        h=references:in-reply-to:cc:to:subject:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hKJkE7s1AODBs8heVonTs+4nlWrD8mC2DlTpxvnLgY=;
        b=W5VZ6xuXz/f0J7qZ0Y3yPvKcf2b160OCNXfXBuu53W3icPG37qBOuma/rNJuYxRNAx
         V+8iFRE44mi8r8XWZdyYMIBHTWLva6cdJz+ppBq4+A+aEBidnkN3UpKsXJ+mbae3gYyX
         BnSf4M2OxkBYlY+rNarU5msKjd9WD0yflAZxlfNJhJ+by0HtwKnpHaspLDqM1R6GOmJh
         bgz8X/uXVsidb/24iDZ5iv9ki+vK3NxG//a9VSNyI0LMHVlraaXp+RKpJ92D11HySiHq
         2k+st9g7MZaLzvgP4k2MK7vJef2FLlmm8AhNEQhUVBpMdtI/jyvsejfnIpNYn1+S5BLM
         ChTg==
X-Forwarded-Encrypted: i=1; AJvYcCV3lyIUtV9F2L8NVV3MeofC4O0vdT1JX9B0wgT6T1UgnSjD/xexJyepzV2pN1kjkcUHRTJIQPWFEi2JdM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmCX/S+K166WRGngnBeIHpAh+HPiHRBboC4+HV/n7VlNt8HUFw
	N+/h6L/zUYhZEIshNZbjuosWoyVGeN8gYwV4Zw/VXgXK6UwEGVR7YaCqe/DW
X-Google-Smtp-Source: AGHT+IH3joS94FYeJrE/DjLAIX71BB3hAydyGpc4kPZZ+6PJf/szx6DB87Rev6gSLO+C8S20A8vRRQ==
X-Received: by 2002:a05:600c:3b87:b0:431:6060:8b22 with SMTP id 5b1f17b1804b1-432cce7203fmr94690665e9.10.1731582033561;
        Thu, 14 Nov 2024 03:00:33 -0800 (PST)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab721b7sm16640705e9.8.2024.11.14.03.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 03:00:32 -0800 (PST)
Date: Thu, 14 Nov 2024 12:00:32 +0100
Message-ID: <c1b30741bec25e25c6e57389bf45d04f@gmail.com>
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: Re: [PATCH v11] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
To: victor.duicu@microchip.com, jic23@kernel.org, lars@metafoo.de,
	andy.shevchenko@gmail.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	marius.cristea@microchip.com, victor.duicu@microchip.com
In-Reply-To: <20241114084702.3499-1-victor.duicu@microchip.com>
References: <20241114084702.3499-1-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

On Thu, 14 Nov 2024 10:47:02 +0200, <victor.duicu@microchip.com> wrote:
> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This patch implements ACPI support to Microchip pac1921.
> The driver can read the shunt resistor value and label from the ACPI table.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
> ---
> 
> The patch was tested on minnowboard and sama5.
> 
> Differences related to previous versions:
> v11:
> - credit Andy Shevchenko for code review.
> 
> v10:
> - fix coding style mistakes.
> - add UL to PAC1921_MAX_SHUNT_VALUE_uOHMS.
> - edit comment in pac1921_write_shunt_resistor.
> - in pac1921_probe use is_acpi_device_node instead of
>   ACPI_HANDLE.
> 
> v9:
> - put limits.h in sorted order.
> - remove guid_parse and implement GUID_INIT.
> - remove pac1921_shunt_is_valid.
> - change maximum acceptable value of shunt resistor to 2146.999999.
>   This change was made so the readings for dt and ACPI share
>   the same range.
>   With this value the maximum current that can be read is
>   0.1V / 2146.999999 = 46.576 uA
>   If we use INT_MAX the maximum current is
>   0.1V / 2147.483647 = 46.566 uA
>   The relative error between the two is 0.0214, so it is
>   small enough to allow for code simplicity.
>   A shunt value over a few hundred Ohms is quite unusual.
> 
> v8:
> - fix multiple coding style errors.
> - in pac1921_match_acpi_device change error type to ENOMEM
>   at label is NULL branch.
> - in pac1921_match_acpi_device when reading label,
>   change accesing method of string.
> - change name of PAC1921_ACPI_GET_UOHMS_VALS to
>   PAC1921_ACPI_GET_uOHMS_VALS.
> - add limits.h in include list.
> - change integer constant in PAC1921_MAX_SHUNT_VALUE_OHMS
>   to INT_MAX / MICRO.
> - change pac1921_shunt_is_invalid to pac1921_shunt_is_valid.
> - in pac1921_match_acpi_device change name of variable rez to status.
> 
> v7:
> - in pac1921_shunt_is_invalid remove brackets in return.
> - in pac1921_match_acpi_device and pac1921_parse_of_fw move checking of
>   shunt value and scale calculation to pac1921_probe.
> - in pac1921_match_acpi_device change devm_kmemdup to devm_kstrdup
>   and add label check for NULL.
> - in pac1921_match_acpi_device and pac1921_parse_of_fw remove unnecessary
>   entry arguments. Now indio_dev is the only entry argument.
> - in pac1921_probe, pac1921_match_acpi_device and pac1921_parse_of_fw
>   standardised structure accesing.
> 
> v6:
> - set maximum acceptable value of shunt resistor to INT_MAX UOHMS
>   in devicetree, ACPI table and user input.
> - in pac1921_match_acpi_device remove temp variable.
> 
> v5:
> - set maximum acceptable value of shunt resistor to 2KOHM in devicetree,
>   ACPI table and user input. The chosen value is lesser than INT_MAX,
>   which is about 2.1KOHM.
> - in pac1921_match_acpi_device and pac1921_parse_of_fw change to only
>   read 32b values for resistor shunt.
> 
> v4:
> - change name of pac1921_shunt_is_valid to pac1921_shunt_is_invalid.
> - fix coding style.
> - in pac1921_parse_of_fw change back to device_property_read_u32.
> 
> v3:
> - simplify and make inline function pac1921_shunt_is_valid. Make argument u64.
> - fix link to DSM documentation.
> - in pac1921_match_acpi_device and pac1921_parse_of_fw, the shunt value is
>   read as u64.
> - in pac1921_parse_of_fw remove code for reading label value from
>   devicetree.
> - in pac1921_write_shunt_resistor cast the multiply result to u64 in order
>   to fix overflow.
> 
> v2:
> - remove name variable from priv. Driver reads label attribute with
>   sysfs.
> - define pac1921_shunt_is_valid function.
> - move default assignments in pac1921_probe to original position.
> - roll back coding style changes.
> - add documentation for DSM(the linked document was used as reference).
> - remove acpi_match_device in pac1921_match_acpi_device.
> - remove unnecessary null assignment and comment.
> - change name of function pac1921_match_of_device to
>   pac1921_parse_of_fw.
> 
> v1:
> - initial version for review.
> 
>  drivers/iio/adc/pac1921.c | 110 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 100 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index b0f6727cfe38..9da94d14132a 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -12,6 +12,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/limits.h>
>  #include <linux/regmap.h>
>  #include <linux/units.h>
>  
> @@ -67,6 +68,27 @@ enum pac1921_mxsl {
>  #define PAC1921_DEFAULT_DI_GAIN		0 /* 2^(value): 1x gain (HW default) */
>  #define PAC1921_DEFAULT_NUM_SAMPLES	0 /* 2^(value): 1 sample (HW default) */
>  
> +#define PAC1921_ACPI_GET_uOHMS_VALS             0
> +#define PAC1921_ACPI_GET_LABEL			1
> +/*
> + * The maximum acceptable shunt value is 2146.999999 OHM.
> + * This value, which is below INT_MAX, was chosen in order to
> + * allow the readings from dt and ACPI to share the same range
> + * and to simplify the checks.
> + * With this value the maximum current that can be read is
> + * 0.1V / 2146.999999OHM = 46.576 uA
> + * If we use INT_MAX the maximum current that can be read is
> + * 0.1V / 2147.483647OHM = 46.566 uA
> + * The relative error between the two values is
> + * |(46.566 - 46.576) / 46.566| * 100 = 0.0214
> + */
> +#define PAC1921_MAX_SHUNT_VALUE_uOHMS		2146999999UL
> +

Just a minor point about this: if I understand correctly that value
comes from (INT_MAX / MICRO - 1) * MICRO + MAX_MICRO. This was to
simplify the check in a single statement in pac1921_write_shunt_resistor()
which is called when the shunt resistor is set from *sysfs* (neither
from DT nor ACPI). I'm fine with this value and the new check but I find
the explanation comment a bit confusing. If you could come up with a bit
more clear explanation about the reason of such value I think it would be
better otherwise I am fine with it as it is. Also, maybe use the full room
for 80 characters per line and UOHMS instead of uOHMS to avoid mixed case if
you are going with a new version.

> +/* f7bb9932-86ee-4516-a236-7a7a742e55cb */
> +static const guid_t pac1921_guid =
> +			GUID_INIT(0xf7bb9932, 0x86ee, 0x4516, 0xa2,
> +				  0x36, 0x7a, 0x7a, 0x74, 0x2e, 0x55, 0xcb);
> +
>  /*
>   * Pre-computed scale factors for BUS voltage
>   * format: IIO_VAL_INT_PLUS_NANO
> @@ -782,7 +804,7 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
>  					    const char *buf, size_t len)
>  {
>  	struct pac1921_priv *priv = iio_priv(indio_dev);
> -	u64 rshunt_uohm;
> +	u32 rshunt_uohm;
>  	int val, val_fract;
>  	int ret;
>  
> @@ -793,10 +815,17 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> -	rshunt_uohm = val * MICRO + val_fract;
> -	if (rshunt_uohm == 0 || rshunt_uohm > INT_MAX)
> +	/*
> +	 * This check validates the shunt is not zero and does not surpass the
> +	 * maximum value. The check is done before calculating in order to avoid
> +	 * val * MICRO overflowing.
> +	 */
> +	if ((!val && !val_fract) ||
> +	    ((u32)val > PAC1921_MAX_SHUNT_VALUE_uOHMS / MICRO))
>  		return -EINVAL;
>  
> +	rshunt_uohm = val * MICRO + val_fract;
> +
>  	guard(mutex)(&priv->lock);
>  
>  	priv->rshunt_uohm = rshunt_uohm;
> @@ -1151,6 +1180,58 @@ static void pac1921_regulator_disable(void *data)
>  	regulator_disable(regulator);
>  }
>  
> +/*
> + * Documentation related to the ACPI device definition
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC193X-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
> + */
> +static int pac1921_match_acpi_device(struct iio_dev *indio_dev)
> +{
> +	acpi_handle handle;
> +	union acpi_object *status;
> +	char *label;
> +	struct pac1921_priv *priv = iio_priv(indio_dev);
> +	struct device *dev = &priv->client->dev;
> +
> +	handle = ACPI_HANDLE(dev);
> +
> +	status = acpi_evaluate_dsm(handle, &pac1921_guid, 1, PAC1921_ACPI_GET_uOHMS_VALS, NULL);

For consistency with the rest of the code, could you reformat to stay in
80 characters width?

> +	if (!status)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Could not read shunt from ACPI table\n");
> +
> +	priv->rshunt_uohm = status->package.elements[0].integer.value;
> +	ACPI_FREE(status);
> +
> +	status = acpi_evaluate_dsm(handle, &pac1921_guid, 1, PAC1921_ACPI_GET_LABEL, NULL);

Could you reformat to stay in 80 characters width?

> +	if (!status)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Could not read label from ACPI table\n");
> +
> +	label = devm_kstrdup(dev, status->package.elements[0].string.pointer, GFP_KERNEL);

Could you reformat to stay in 80 characters width?

> +	if (!label)
> +		return -ENOMEM;
> +
> +	indio_dev->label = label;
> +	ACPI_FREE(status);
> +
> +	return 0;
> +}
> +
> +static int pac1921_parse_of_fw(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct pac1921_priv *priv = iio_priv(indio_dev);
> +	struct device *dev = &priv->client->dev;
> +
> +	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +				       &priv->rshunt_uohm);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Cannot read shunt resistor property\n");
> +
> +	return 0;
> +}
> +
>  static int pac1921_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -1179,14 +1260,16 @@ static int pac1921_probe(struct i2c_client *client)
>  	priv->di_gain = PAC1921_DEFAULT_DI_GAIN;
>  	priv->n_samples = PAC1921_DEFAULT_NUM_SAMPLES;
>  
> -	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> -				       &priv->rshunt_uohm);
> -	if (ret)
> +	if (is_acpi_device_node(dev->fwnode))
> +		ret = pac1921_match_acpi_device(indio_dev);
> +	else
> +		ret = pac1921_parse_of_fw(indio_dev);
> +	if (ret < 0)
>  		return dev_err_probe(dev, ret,
> -				     "Cannot read shunt resistor property\n");
> -	if (priv->rshunt_uohm == 0 || priv->rshunt_uohm > INT_MAX)
> -		return dev_err_probe(dev, -EINVAL,
> -				     "Invalid shunt resistor: %u\n",
> +				     "Parameter parsing error\n");
> +
> +	if (!priv->rshunt_uohm || priv->rshunt_uohm > PAC1921_MAX_SHUNT_VALUE_uOHMS)
> +		return dev_err_probe(dev, -EINVAL, "Invalid shunt resistor: %u\n",
>  				     priv->rshunt_uohm);
>  
>  	pac1921_calc_current_scales(priv);
> @@ -1246,11 +1329,18 @@ static const struct of_device_id pac1921_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, pac1921_of_match);
>  
> +static const struct acpi_device_id pac1921_acpi_match[] = {
> +	{ "MCHP1921" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, pac1921_acpi_match);
> +
>  static struct i2c_driver pac1921_driver = {
>  	.driver	 = {
>  		.name = "pac1921",
>  		.pm = pm_sleep_ptr(&pac1921_pm_ops),
>  		.of_match_table = pac1921_of_match,
> +		.acpi_match_table = pac1921_acpi_match,
>  	},
>  	.probe = pac1921_probe,
>  	.id_table = pac1921_id,
> 
> base-commit: 20fd1383cd616d61b2a79967da1221dc6cfb8430
> -- 
> 2.43.0
> 

Best regards,
Matteo Martelli

