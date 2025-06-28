Return-Path: <linux-iio+bounces-21071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4107AAEC955
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613961897E48
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE70E2494FF;
	Sat, 28 Jun 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkcF3d/J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639401D7989;
	Sat, 28 Jun 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131013; cv=none; b=kAN464beybxpywRkNZOv77EuJled6OPPHoZE9rdXk9x+ALb5wohuROR116krgqxTzsoKPcKbbAXigJJLCqjxiBq3T5tqlhpeO6RenGimZfJNY7nntMiHvlRgt7gYnNZpEq4txMujNuUarG2eooiJjhs+nVVcChN+QyuYa/w133w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131013; c=relaxed/simple;
	bh=OVwnK5LjDyyWCDfonPA5ouzc4VF00Zt6fdG58WAc2zA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+4tsWE6vqCn3nZMw6ckzvVBNp1rz1aDlZyfScfVe+9l2Tsi1uNK1oBzDIwJ8028FbvC7rgJya83rz75reVfkOEl5DkGyw+MdkUUKz4Ms4DOVEVccGb33c3JvY9Kr/gmspFSWPReqDPeW7KqTX107ei/GaGCzOLTSadSooWlNTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkcF3d/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291DBC4CEEA;
	Sat, 28 Jun 2025 17:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751131013;
	bh=OVwnK5LjDyyWCDfonPA5ouzc4VF00Zt6fdG58WAc2zA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mkcF3d/J0hmIqADYdpCztIdE9vwjqWivcuz+p/CEyjbO2mC9KSG49RQUzdmDG1xSl
	 ovD7hpDYiYNQXIsErIDhTr/gL/0tdf7K5iiwu5y7cmgoec2Dl7n2T44p1qu2/gKmFy
	 k2jmV8/n7SlZTznjdE5g8t3V6pPPcMORfIgSOLVkNTYsIXvI0XpaWDWAWlcfGhaf6+
	 cJ0/KPFCVfmQ67aZbYVHSlwCPhbIMX6ajjcf/bXh5NBiZvPlOhDjLJo3O9EUJi9Zfc
	 ksVHy2EbAXRBuMcUhosCQWk2ZlvPARSJs4bUk2lRDCl1vIUC8eO9r0xuoeNNrYa+1e
	 w7m3pTI0yfuiA==
Date: Sat, 28 Jun 2025 18:16:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/8] iio: accel: adxl313: add buffered FIFO watermark
 with interrupt handling
Message-ID: <20250628181643.0ce0ed51@jic23-huawei>
In-Reply-To: <20250622122937.156930-4-l.rubusch@gmail.com>
References: <20250622122937.156930-1-l.rubusch@gmail.com>
	<20250622122937.156930-4-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Jun 2025 12:29:32 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Cover the following tasks:
> - Add scan_mask and scan_index to the IIO channel configuration. The
> scan_index sets up buffer usage. According to the datasheet, the ADXL313
> uses a 13-bit wide data field in full-resolution mode. Set the
> signedness, number of storage bits, and endianness accordingly.
> 
> - Parse the devicetree for an optional interrupt line and configure the
> interrupt mapping based on its presence. If no interrupt line is
> specified, keep the FIFO in bypass mode as currently implemented.
> 
> - Set up the interrupt handler. Add register access to detect and
> evaluate interrupts. Implement functions to clear status registers and
> reset the FIFO.
> 
> - Implement FIFO watermark configuration and handling. Allow the
> watermark level to be set, evaluate the corresponding interrupt, read
> the FIFO contents, and push the data to the IIO channel.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar,

One thing inline. If nothing else comes up I can tweak the naming of that
function whilst applying.

Jonathan

> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index 99a7f3755031..ac4cc16399fc 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -8,11 +8,23 @@

>  static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
>  			      unsigned int writeval, unsigned int *readval)
>  {
> @@ -359,6 +551,7 @@ static const struct iio_info adxl313_info = {
>  	.read_raw	= adxl313_read_raw,
>  	.write_raw	= adxl313_write_raw,
>  	.read_avail	= adxl313_read_freq_avail,
> +	.hwfifo_set_watermark = adxl313_set_watermark,
>  	.debugfs_reg_access = &adxl313_reg_access,
>  };
>  
> @@ -407,6 +600,19 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
>  	return adxl313_set_measure_en(data, true);
>  }
>  
> +static unsigned int _get_int_type(struct device *dev, int *irq)

Andy mentioned this in review of your other series  Intent was an adxl313
prefix which I agree makes sense.


> +{
> +	*irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> +	if (*irq > 0)
> +		return ADXL313_INT1;
> +
> +	*irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
> +	if (*irq > 0)
> +		return ADXL313_INT2;
> +
> +	return ADXL313_INT_NONE;
> +}

