Return-Path: <linux-iio+bounces-6102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9859015C8
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 12:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC191C2123A
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 10:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95356288DB;
	Sun,  9 Jun 2024 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdDtRSKz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C720B33;
	Sun,  9 Jun 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717930621; cv=none; b=WBDgPDsXVQB7ih2IGtjsysqNORc3eJHZqof7FeYoYKG2FSIoxB04ZXPrbQ4nshddpfs76+nQVOIAyyBHwvtKAgMfWN+5jRQwCGEkXIZoj6uFoskrFIjqI4VPcA/uPQtuoU1llqfMIhRJyMYurH+JGcFNJr+gncu/SGWNJBhr9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717930621; c=relaxed/simple;
	bh=fWqjprj7vSuxc742ib4McSqb18a8Ji3GLQrmx/c8FDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxawquNFbt13xDNB70SGYW4oStclbWTEfIT42Lr/giCgWLtNZkBNhwBw7PLB+xR6RC/Ept8tn+94yBKz6EhVo2bDL1ifTAzb1PMyvvpRajma3vtMJ1QJEur/yeZ+PtfjHISF/6V7cbki4Cc7PuejDR06dMjXDEoPaxzgzRA+9E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdDtRSKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389A6C2BD10;
	Sun,  9 Jun 2024 10:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717930620;
	bh=fWqjprj7vSuxc742ib4McSqb18a8Ji3GLQrmx/c8FDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EdDtRSKzx6Np7lCndIun/ftQyWNL8jZrDyp5Y7cLJ4wZiTy6lqzxi4LtbelligPiJ
	 hHxtPY3thC15u8iHG3SkSwuYHzL0cBRLhITL3iaMNYnOmXjXqrA0BJ0TjXWXcG+bhi
	 onlFF1MLHU7ZG0s2aCaS6fD/R8Qbfne3/QoNwqdlwKJ9Yd4HyQ6ElkJ3G+Ee8uc/0p
	 yeVxpRDNwDFyzZun2jrLg5rPFYGiVSYxDMLFneNx+m5vwhGzBFH48WzaZuWCO5Dm2b
	 1EcgDeCzftHlLkE5TkWA+b+zt3EMKWTcAn3LmwRlnysZa0IGvtv32kAwx4FgHWqpfx
	 vcRP+piPUwkwA==
Date: Sun, 9 Jun 2024 11:56:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: dpfrey@gmail.com, himanshujha199640@gmail.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mike.looijmans@topic.nl
Subject: Re: [PATCH v2 06/19] iio: chemical: bme680: Fix read/write ops to
 device by adding mutexes
Message-ID: <20240609115628.2beb4cb1@jic23-huawei>
In-Reply-To: <20240606212313.207550-7-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
	<20240606212313.207550-7-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jun 2024 23:22:58 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add mutexes in the {read/write}_raw() functions of the device to
> guard the read/write of data from/to the device. This is necessary
> because for any operation other than temperature, multiple reads
> need to take place from the device. Even though regmap has a locking
> by itself, it won't protect us from multiple applications trying to
> read at the same time temperature and pressure since the pressure
> reading includes an internal temperature reading and there is nothing
> to ensure that this temperature+pressure reading will happen
> sequentially without any other operation interfering in the meantime.
> 
> Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 66177f7e94a8..92359032254a 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -10,6 +10,7 @@
>   */
>  #include <linux/acpi.h>
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> @@ -52,6 +53,7 @@ struct bme680_calib {
>  struct bme680_data {
>  	struct regmap *regmap;
>  	struct bme680_calib bme680;

Comment needed here on what data this lock protects.
It is far to easy to make wrong assumptions about locks so convention is
to always document their scope.

Otherwise lgtm (as do patches 1-5)

> +	struct mutex lock;
>  	u8 oversampling_temp;
>  	u8 oversampling_press;
>  	u8 oversampling_humid;
> @@ -827,6 +829,8 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct bme680_data *data = iio_priv(indio_dev);
>  
> +	guard(mutex)(&data->lock);
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
> @@ -871,6 +875,8 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
>  {
>  	struct bme680_data *data = iio_priv(indio_dev);
>  
> +	guard(mutex)(&data->lock);
> +
>  	if (val2 != 0)
>  		return -EINVAL;
>  
> @@ -967,6 +973,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  		name = bme680_match_acpi_device(dev);
>  
>  	data = iio_priv(indio_dev);
> +	mutex_init(&data->lock);
>  	dev_set_drvdata(dev, indio_dev);
>  	data->regmap = regmap;
>  	indio_dev->name = name;


