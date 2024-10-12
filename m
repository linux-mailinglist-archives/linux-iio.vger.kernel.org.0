Return-Path: <linux-iio+bounces-10494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A8599B48B
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 13:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36501283654
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 11:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0D916DEA7;
	Sat, 12 Oct 2024 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HANsJ3hK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36382155330;
	Sat, 12 Oct 2024 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728733170; cv=none; b=my6DAx8ig1pNzjriPKF3cR4/hOpa/R3NMOxYsK0ljnOMHbo44tbuWeaZug2EsD/hvfMrBbFufPdJJ9Z8xsj3euLgRzBRXD9wQNZleTDz/06/ZzsokNPt1W6JWujo3kXsACYhpPHuiHPWZbaRDlavimSpehrNZLQlP3l8ID8ss7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728733170; c=relaxed/simple;
	bh=SATIOYC0pUAjVvWgqSZAYEdj8X8oAw70shO6UzHSb2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQj9SoNJQu/oe/NyEsFdFJNLxw5RTMbP5lv6l5VQGJYvxCErqKZkt8bxfuY8ks4aB/rzO5jsPRMWPhK8015nZEoSN4tZWFWTSOSZTlDHlDWhcfAjwH+o4/GbSkhOdyCB+dVz3WOFsXHf8+Y6cvzqQuz+15Uehq37Yz4GO1YK8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HANsJ3hK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D461C4CEC7;
	Sat, 12 Oct 2024 11:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728733169;
	bh=SATIOYC0pUAjVvWgqSZAYEdj8X8oAw70shO6UzHSb2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HANsJ3hK/PYykH4O2iy1zyzNhn/jJrjcEqXXRXVooOfepwcSNk7R9081C9KMpLFlP
	 0hys12rmceSQ4g2DyH+NH7Oaqfyq4WK0j88Y2sdVFFAw+5bveLmXdaxbSF0s1AwQ3L
	 XVIXDrRucBiwNGQYaG+xaRSjK0HffZgMGkPuOOn8VaAAZrYgOuZAfcdWqHuJHOEP1w
	 W5FxZbw+c+QpicvntdmCsaMXnp+kR3cKfkaAPfpfiMlLFusyRkRWfIv7eMRSyTNloU
	 zzSKghbOSUBKo7E5NOM/T9xsm7nwX6CL9BYaysYJ2H6AabId3bGHrJhzaXw+xfiueL
	 4t62vs+3TsPHg==
Date: Sat, 12 Oct 2024 12:39:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <victor.duicu@microchip.com>
Cc: <matteomartelli3@gmail.com>, <lars@metafoo.de>,
 <marius.cristea@microchip.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iio: adc: pac1921: add ACPI support to Microchip
 pac1921.
Message-ID: <20241012123923.23000c34@jic23-huawei>
In-Reply-To: <20241011134454.45283-1-victor.duicu@microchip.com>
References: <20241011134454.45283-1-victor.duicu@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 16:44:54 +0300
<victor.duicu@microchip.com> wrote:

> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This patch implements ACPI support to Microchip pac1921.
> The driver can read shunt resistor value and label from ACPI table.
> 
> The patch was tested on a minnowboard(64b) and sama5(32b).
> In order to avoid overflow when reading 64b values from ACPi table or
> devicetree it is necessary:
> - the revision of .dsl file must be 2 or greater to enable 64b arithmetic.
> - the shunt resistor variable in devicetree must have the prefix "/bits/ 64".
> 

Change log should be below the --- as it doesn't want to end up in the git history.


> Differences related to previous versions:
> v3:
> - simplify and make inline function pac1921_shunt_is_valid. Make argument u64.
> - fix link to DSM documentation.
> - in pac1921_match_acpi_device and pac1921_parse_of_fw, the shunt value is
> read as u64.
> - in pac1921_parse_of_fw remove code for reading label value from
> devicetree.
> - in pac1921_write_shunt_resistor cast the multiply result to u64 in order
> to fix overflow.
> 
> v2:
> - remove name variable from priv. Driver reads label attribute with
> sysfs.
> - define pac1921_shunt_is_valid function.
> - move default assignments in pac1921_probe to original position.
> - roll back coding style changes.
> - add documentation for DSM(the linked document was used as reference).
> - remove acpi_match_device in pac1921_match_acpi_device.
> - remove unnecessary null assignment and comment.
> - change name of function pac1921_match_of_device to
> pac1921_parse_of_fw.
> 
> v1:
> - initial version for review.
> 
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
A few comments in line.

J

 int pac1921_parse_of_fw(struct i2c_client *client, struct pac1921_priv *priv,
> +			       struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct device *dev = &client->dev;
> +	u64 temp;
> +
> +	ret = device_property_read_u64(dev, "shunt-resistor-micro-ohms", &temp);
> +
No line break here.  Want to associate that error check with the line above
as clearly as possible.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Cannot read shunt resistor property\n");
> +
> +	if (pac1921_shunt_is_valid(temp))
> +		return dev_err_probe(dev, -EINVAL, "Invalid shunt resistor: %u\n",
> +				     priv->rshunt_uohm);
> +
> +	priv->rshunt_uohm = (u32)temp;
> +	pac1921_calc_current_scales(priv);
> +
> +	return 0;
> +}

