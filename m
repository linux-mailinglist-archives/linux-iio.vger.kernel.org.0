Return-Path: <linux-iio+bounces-12303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 303BD9CDE12
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 13:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC43A28412A
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 12:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA8F1B3949;
	Fri, 15 Nov 2024 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFBcqTnG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E219918871E;
	Fri, 15 Nov 2024 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731672786; cv=none; b=qY3xM9sPBivvVeQ3SmkaaMXVEdu88lAw/RoRhAaN1ywJqe5FQcwW35so5g7HwxcOtp4VoI/dI5D/X2Mcu4q6p6Av3R9heXCXeLMFfxOfltD5DDnLiBq9TUC1CRBOy7owTFlscimaI+xP5TRozlrCA3CZ+fBwGSjD4MZA/Fa+ZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731672786; c=relaxed/simple;
	bh=hosXaFvLazJGYD+naOokJ3f31tMLPDSkGrQK5abSxpU=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=j0dqOkA/Z0DZ0ot14i7hS/eW7Ow2SNaBtn/Qm2lu0KzjTaAYAUlgl9EJhL4AhIpzDDQyuAZYKJPtWEz7tUSQeHxmwTEImYC62NnWQDAbQwwq08sXhdjRx9+kGpoeE6xV7ssVNsdR/RAxlyk3G5OPMJfY/uNfPM82neHjri8Xndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFBcqTnG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38224150a84so571692f8f.3;
        Fri, 15 Nov 2024 04:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731672783; x=1732277583; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:subject:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YLPkGHts6nEhlRCmzabGnF8wFpb2Wdg07ZVILc/dtG4=;
        b=dFBcqTnGjXTlliZExknaypRfTPNy70m+Yu5qngKNUpdzW/gd9aNyJrxkS1yriMdb0V
         bwW+BtT+CGTUh2BxFIXSJdVPL8ie9eEC6SFZ4fr4qjHSFwx5y+AnPsChIBEF0z0lEedI
         MEZDpZF2A8uisxY0FVv9stpHa1Ejs0m7DaBxvLl5Pik+TtTRhuX3peAt5YYuKm8n8ahy
         58NRVURqpuWQcCpiaS6aurf1UUzZQALRiWPU+vzRBtJ+yf1mUFWaJv34rF6jSp1UfkLa
         mds/TSsSJMd5IJZ73Ugghi+8fDL7dblT7/G9pGlZ5qh5rodKJZLov+EJVVsRkiUdh93G
         O/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731672783; x=1732277583;
        h=references:in-reply-to:cc:to:subject:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLPkGHts6nEhlRCmzabGnF8wFpb2Wdg07ZVILc/dtG4=;
        b=togIn0KNXqdatpnhYlW419CpZxg/LqRViUBmhWfVVXNJFtuDJAFALxKC3xLk7jvZnr
         uayAfVBQHuVZiVWPEqLJB934kJLa0qDjdRbHv8FBpY4puWhQT5aYGUZ7s+JteetmrIvY
         lkO550DFWQbAycdWGMHt6K9EhQsghB2SbOUhQqGDzzc+JkoITupBSaKn/3y+Oz9zoIZ1
         INAw3ru4M6MmenovB9V8jg1q0OuvZcuyYQrGL4A9Zkyy34R0S+RR+bIgXwUlI4RnHQke
         3+qxUPrjn6bbEXeApmFDDeoeEaLOyTj59ZoM9Tamqlb6tKxROIns9Otn960J5g4DXnrk
         w64w==
X-Forwarded-Encrypted: i=1; AJvYcCVSAme/9Q3aVyfjhnZyjiqKNdi82ptomyuG7Pg2m9VlNPn0vPLsnX4KO43ASr8LinhWUGxRFW+c8f8=@vger.kernel.org, AJvYcCViuFREN2m+EebicAJqRWZU3ghxp1kjrK8Mm8HaYO9TxMRUZAGzJM6uApavlZvW17JA8kKz5rssCwnFyRsl@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMYkwynuM//1/L6xTN4akqvqPiDZkGuAEck+psgNPrquxkRrC
	Yxu7CnlEbTYGDAS8n4xnZZx3dxw6VSGv304a+6PMJGpdLj8NqIEq
X-Google-Smtp-Source: AGHT+IGT1nJazA03eKPjQgpENEV7t0zhkcfwAxqzSSJFnPLrv48+YkVQKqFuf2S6lrh2B5mmwLprpA==
X-Received: by 2002:a5d:598d:0:b0:37d:4e80:516 with SMTP id ffacd0b85a97d-38225a2163cmr1986725f8f.34.1731672782837;
        Fri, 15 Nov 2024 04:13:02 -0800 (PST)
Received: from localhost ([82.56.18.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbbd82sm4199120f8f.52.2024.11.15.04.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 04:13:02 -0800 (PST)
Date: Fri, 15 Nov 2024 13:12:59 +0100
Message-ID: <a19261928f6563ffce6f1d0dadef77a9@gmail.com>
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: Re: [PATCH v12] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
To: victor.duicu@microchip.com, jic23@kernel.org, lars@metafoo.de,
	andy.shevchenko@gmail.com
Cc: marius.cristea@microchip.com, victor.duicu@microchip.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241115100756.8923-1-victor.duicu@microchip.com>
References: <20241115100756.8923-1-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

Hi Victor,

Below just a few very minor styling points. Sorry I didn't notice them
before. However, I am also fine with this version as it is.

Acked-by: Matteo Martelli <matteomartelli3@gmail.com>

On Fri, 15 Nov 2024 12:07:56 +0200, <victor.duicu@microchip.com> wrote:
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
> v12:
> - in pac1921_match_acpi_device reformat the instructions that
>   were over 80 characters width.
> - remove PAC1921_MAX_SHUNT_VALUE_uOHMS. Now the maximum acceptable value
>   of shunt resistor is INT_MAX. In pac1921_write_shunt_resistor
>   change the shunt check to respect the new limit and to avoid
>   overflow in val * MICRO.
> 
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
>  drivers/iio/adc/pac1921.c | 100 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 90 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index b0f6727cfe38..a78ae34057a1 100644
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
> @@ -67,6 +68,14 @@ enum pac1921_mxsl {
>  #define PAC1921_DEFAULT_DI_GAIN		0 /* 2^(value): 1x gain (HW default) */
>  #define PAC1921_DEFAULT_NUM_SAMPLES	0 /* 2^(value): 1 sample (HW default) */
>  
> +#define PAC1921_ACPI_GET_uOHMS_VALS             0
> +#define PAC1921_ACPI_GET_LABEL			1
> +
> +/* f7bb9932-86ee-4516-a236-7a7a742e55cb */
> +static const guid_t pac1921_guid =
> +			GUID_INIT(0xf7bb9932, 0x86ee, 0x4516, 0xa2,
> +				  0x36, 0x7a, 0x7a, 0x74, 0x2e, 0x55, 0xcb);
> +
>  /*
>   * Pre-computed scale factors for BUS voltage
>   * format: IIO_VAL_INT_PLUS_NANO
> @@ -782,7 +791,7 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
>  					    const char *buf, size_t len)
>  {
>  	struct pac1921_priv *priv = iio_priv(indio_dev);
> -	u64 rshunt_uohm;
> +	u32 rshunt_uohm;
>  	int val, val_fract;
>  	int ret;
>  
> @@ -793,10 +802,17 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> -	rshunt_uohm = val * MICRO + val_fract;
> -	if (rshunt_uohm == 0 || rshunt_uohm > INT_MAX)
> +	/*
> +	 * This check validates the shunt is not zero and does not surpass
> +	 * INT_MAX. The check is done before calculating in order to avoid
> +	 * val * MICRO overflowing.
> +	 */
> +	if ((!val && !val_fract) || (val > INT_MAX / MICRO) ||
> +	    ((val == INT_MAX / MICRO) && (val_fract > INT_MAX % MICRO)))
>  		return -EINVAL;

Can the unnecessary parenthesis be removed?

	if ((!val && !val_fract) || (val > INT_MAX / MICRO) ||
                                    ^.....................^
	    ((val == INT_MAX / MICRO) && (val_fract > INT_MAX % MICRO)))
             ^......................^    ^...........................^

>  
> +	rshunt_uohm = val * MICRO + val_fract;
> +
>  	guard(mutex)(&priv->lock);
>  
>  	priv->rshunt_uohm = rshunt_uohm;
> @@ -1151,6 +1167,61 @@ static void pac1921_regulator_disable(void *data)
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
> +	status = acpi_evaluate_dsm(handle, &pac1921_guid, 1,
> +				   PAC1921_ACPI_GET_uOHMS_VALS, NULL);
> +	if (!status)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Could not read shunt from ACPI table\n");
> +
> +	priv->rshunt_uohm = status->package.elements[0].integer.value;
> +	ACPI_FREE(status);
> +
> +	status = acpi_evaluate_dsm(handle, &pac1921_guid, 1,
> +				   PAC1921_ACPI_GET_LABEL, NULL);
> +	if (!status)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Could not read label from ACPI table\n");
> +
> +	label = devm_kstrdup(dev, status->package.elements[0].string.pointer,
> +			     GFP_KERNEL);
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
> @@ -1179,14 +1250,16 @@ static int pac1921_probe(struct i2c_client *client)
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

For consistency: if (ret) instead of if (ret < 0)

>  		return dev_err_probe(dev, ret,
> -				     "Cannot read shunt resistor property\n");
> -	if (priv->rshunt_uohm == 0 || priv->rshunt_uohm > INT_MAX)
> -		return dev_err_probe(dev, -EINVAL,
> -				     "Invalid shunt resistor: %u\n",
> +				     "Parameter parsing error\n");
> +
> +	if (!priv->rshunt_uohm || priv->rshunt_uohm > INT_MAX)
> +		return dev_err_probe(dev, -EINVAL, "Invalid shunt resistor: %u\n",

The error string in a new line to keep it 80 char wide.

>  				     priv->rshunt_uohm);
>  
>  	pac1921_calc_current_scales(priv);
> @@ -1246,11 +1319,18 @@ static const struct of_device_id pac1921_of_match[] = {
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

Thanks,
Matteo Martelli

