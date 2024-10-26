Return-Path: <linux-iio+bounces-11319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C013A9B1764
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58575B21B28
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056671D2B26;
	Sat, 26 Oct 2024 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GL42m+bv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B680C217F29;
	Sat, 26 Oct 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729941700; cv=none; b=ikhZ8G7SQYn6QpYkyceoT1H5DtcNnx3NeRaK/D9d5mcG7oipkE2pB9iFi0BH2sI8qwGPybTJcrIWl0OD97lAFPTrjFRqh3bK6OYm6+8V3WRA5fxT/+e98be3bJ+KfPNrbJJtf8CIUiTZZh/7q8JRAVe9E15ZS2H4leme5KiKjeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729941700; c=relaxed/simple;
	bh=PNmyCe5Sy4Zjw/MAuEUNYFfubocM9DhMbEw+L1LO3vk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvtwFfm4m4wk+EccqtHQiuGYKZ51DIQOp/2bXrNhsgh0gx5D1JnevP13Hqno16O/n6zx9pVqDeo7IT0u9PX90ihayoa05IbOE6R5IAos6tS20GPEBu0F1sc+aUygwsNYJjMnb7PWBepIZE0RRMWGCwQd7UatDVRJF4VfjwtZGoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GL42m+bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94934C4CEC6;
	Sat, 26 Oct 2024 11:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729941700;
	bh=PNmyCe5Sy4Zjw/MAuEUNYFfubocM9DhMbEw+L1LO3vk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GL42m+bvwIrjIQQRxUiRk+3lojhppRXKDg4Dsa/gha0nNeNyQg4t8sDpq5vt8e0P/
	 7GTvxhbf6cKzWoaNSljd/bvl7fDhibblT/Zo232XaJ2zmzaK5ntzQthxQ23rKY2AjH
	 rPF/VR31hftfPDrh6elSN8pVfMPBZ/ZVJiV9e0K4j+LgRMuCB5MNCDvHj4u3w4mX8m
	 p3su64eTJ6tN6uNeW+wlAQ9xafApNDxmvfBa0GnoUpaU+8RxF+NSLeh3+M4pXBBDhT
	 KnnId6xzwsQJc8or+4Mrjyxq0ZdjP6ccMLKSjHa1P/Vurzm9pN+mCwgzteZ+jxWqNl
	 g8bxK564UlPXw==
Date: Sat, 26 Oct 2024 12:21:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 10/24] iio: accel: kxcjk-1013: Rename kxcjk1013_info
Message-ID: <20241026121944.656fd27b@jic23-huawei>
In-Reply-To: <20241024191200.229894-11-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-11-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:04:59 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Rename kxcjk1013_info to kxcjk1013_iio_info in preparatory of
> further cleaning up changes.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.
> ---
>  drivers/iio/accel/kxcjk-1013.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index a5411d920025..f97bdbbe71ed 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1211,7 +1211,7 @@ static const struct iio_buffer_setup_ops kxcjk1013_buffer_setup_ops = {
>  	.postdisable		= kxcjk1013_buffer_postdisable,
>  };
>  
> -static const struct iio_info kxcjk1013_info = {
> +static const struct iio_info kxcjk1013_iio_info = {
>  	.attrs			= &kxcjk1013_attrs_group,
>  	.read_raw		= kxcjk1013_read_raw,
>  	.write_raw		= kxcjk1013_write_raw,
> @@ -1533,7 +1533,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
>  	indio_dev->available_scan_masks = kxcjk1013_scan_masks;
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->info = &kxcjk1013_info;
> +	indio_dev->info = &kxcjk1013_iio_info;
>  
>  	if (client->irq > 0 && data->acpi_type != ACPI_SMO8500) {
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,


