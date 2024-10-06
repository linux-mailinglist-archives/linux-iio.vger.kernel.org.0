Return-Path: <linux-iio+bounces-10230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE36991E2C
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71330282884
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 11:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE67B172798;
	Sun,  6 Oct 2024 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEjn6yFZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CCE14D2B9;
	Sun,  6 Oct 2024 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728214884; cv=none; b=pH4gaYg0SJVVpHY+puoPoaadX2HaAUoET10IK7fP5neOWgWPjo2l7IlICr4qJOQ5Y0blzVeTiBXHYRWBeUBWachsZIineJlWD/ciDKGP0+qODroAR/+wOJPPzN/BIykJtk/x7eHSDNf/p96p0VnvaWgx9g2bDzBp4QFE/y1gj7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728214884; c=relaxed/simple;
	bh=6Kasd3D/Muis1KXGAZpAHOMvjPz7XQr4mvRZQTa1MY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAY1570Kd8dNMZ+o/gtYvg0bVl4qFdNvdQnQ6iInnddVwro84onSPBgW7lC/JweZCVeASICzOjTuO3OSaD/A4JSiA7PQGDgQp88dadPpGrW1xBsQi/vMOE66wc6oGmgVp3wYXYnENIt37cK0U57joXZ3aNKFCvM7aPEIE7day9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEjn6yFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDCCC4CEC5;
	Sun,  6 Oct 2024 11:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728214884;
	bh=6Kasd3D/Muis1KXGAZpAHOMvjPz7XQr4mvRZQTa1MY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SEjn6yFZk4CJPOvooNzyt/uUT9XrIvITw09n3lwdE9vT6ZJQPd0bKzJDGxD+Rz4Pm
	 9SLfboEhtM9rdxsCnqp9MDHoG8Y+xYZDleUoR/r1yxzvDtfnuXqlea4viO7QLKBfnL
	 WZzrYoMAbYGcxF1BM4VzaBA7Xef6TBDB/qGykP4k2MvzISqxZ1UQoFVinsbO1XFoQy
	 e9PotvAsC5x2mNpNnV7vV7diFZZzje7/nLPOxOkuX7RxnzOLhAzak7JSYirr9FVzPL
	 6Enp1u+3LDA5iAgzA4gqObfjYZgiRcll/yZZeOpwWzO8lVfbz52icCdhVn27MaD1CG
	 2b2EZmo/sVO1A==
Date: Sun, 6 Oct 2024 12:41:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <victor.duicu@microchip.com>
Cc: <matteomartelli3@gmail.com>, <lars@metafoo.de>,
 <marius.cristea@microchip.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: pac1921: add ACPI support to pac1921
Message-ID: <20241006124116.6c58920a@jic23-huawei>
In-Reply-To: <20241002125445.7570-1-victor.duicu@microchip.com>
References: <20241002125445.7570-1-victor.duicu@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 15:54:45 +0300
<victor.duicu@microchip.com> wrote:

> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This patch implements ACPI support to Microchip pac1921.
> The driver can read shunt resistor value and device label
> from ACPI table.
> 
> Differences related to previous versions:
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
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>

One additional thing from me.

> +
> +static int pac1921_parse_of_fw(struct i2c_client *client, struct pac1921_priv *priv,
> +			       struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct device *dev = &client->dev;
> +
> +	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +				       &priv->rshunt_uohm);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Cannot read shunt resistor property\n");
> +
> +	if (!pac1921_shunt_is_valid(priv->rshunt_uohm))
> +		return dev_err_probe(dev, -EINVAL, "Invalid shunt resistor: %u\n",
> +				     priv->rshunt_uohm);
> +
> +	pac1921_calc_current_scales(priv);
> +
> +	if (device_property_present(dev, "label")) {
> +		ret = device_property_read_string(dev, "label",
> +						  (const char **)&indio_dev->label);

That cast looks odd and the equivalent core code doesn't have it which makes
me wonder why you need it here?
Anyhow as the other review pointed out the iio core code should handle this anyway.

> +		if (ret)
> +			return dev_err_probe(&client->dev, ret,
> +					     "Invalid rail-name value\n");
> +	} else {
> +		indio_dev->label = "pac1921";
> +	}
> +
> +	return 0;
> +}

