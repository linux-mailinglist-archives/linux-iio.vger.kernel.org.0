Return-Path: <linux-iio+bounces-1368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0797F821442
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 16:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1501C20B13
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 15:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009A46107;
	Mon,  1 Jan 2024 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlbWbjqG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA9DBA32
	for <linux-iio@vger.kernel.org>; Mon,  1 Jan 2024 15:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC6BC433C7;
	Mon,  1 Jan 2024 15:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704123726;
	bh=Cb7xRpbz6LtHKtKvTE4xGva0rKgVrpr4eV2Gp8wZDd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VlbWbjqGmMAlcivYdafSORiUPfGpV0yUzoEvJUIcNDRjB407puqhas+GC4Y/GT9h9
	 E+aN4MBzpsJhu7ULK7gqsnYuEPqtjcf5xeWPWWYF/YF8FrXbAR69cVMd8kBMgVpbf6
	 j0XeV5kXLjNnQB/uDVcciH0pH3Qk26ivJWL5PkiKd1wg0qzGKYmoeAWnBcLJWmy2bi
	 hUaAn+7Bkh7JQyvjdB2YaGuKpHCpRQOLmjEIqsbmtzgH59nkGKvUX/Y9beDsVVzDlE
	 bbSmhckJpDs+0tD+2o8Va+ZhksxMoX2hIuJlE8lUhsNuWrLy4C6rBrKR/syE49vEQo
	 pOuqxOMZu5TDA==
Date: Mon, 1 Jan 2024 15:42:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: da280: Simplify id-matching
Message-ID: <20240101154200.28f32bd5@jic23-huawei>
In-Reply-To: <20240101133234.10310-1-hdegoede@redhat.com>
References: <20240101133234.10310-1-hdegoede@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jan 2024 14:32:34 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> da280_match_acpi_device() is a DIY version of acpi_device_get_match_data(),
> so it can be dropped.
> 
> And things can be simplified further by using i2c_get_match_data() which
> will also check i2c_client_id style ids.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Hi Hans and happy new year,

This runs into a slightly nasty corner case (which can't actually happen because
we know it will match) of a NULL return on failure to match which ends up
being the first enum entry whereas we should probably return an error.

My preferred cleanup would be to make both id tables point to a set of structs
that encode the device differences as data rather than ids.

struct da280_chip_info {
	const char *name;
	int num_channels;
}

or something along those lines.  Then we can rely on the generic lookup function
without taking care about the 0 value.

Jonathan


> ---
>  drivers/iio/accel/da280.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
> index 572bfe9694b0..e4cd4b3a28ab 100644
> --- a/drivers/iio/accel/da280.c
> +++ b/drivers/iio/accel/da280.c
> @@ -89,17 +89,6 @@ static const struct iio_info da280_info = {
>  	.read_raw	= da280_read_raw,
>  };
>  
> -static enum da280_chipset da280_match_acpi_device(struct device *dev)
> -{
> -	const struct acpi_device_id *id;
> -
> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -	if (!id)
> -		return -EINVAL;
> -
> -	return (enum da280_chipset) id->driver_data;
> -}
> -
>  static void da280_disable(void *client)
>  {
>  	da280_enable(client, false);
> @@ -107,7 +96,6 @@ static void da280_disable(void *client)
>  
>  static int da280_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	int ret;
>  	struct iio_dev *indio_dev;
>  	struct da280_data *data;
> @@ -128,11 +116,7 @@ static int da280_probe(struct i2c_client *client)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = da280_channels;
>  
> -	if (ACPI_HANDLE(&client->dev)) {
> -		chip = da280_match_acpi_device(&client->dev);
> -	} else {
> -		chip = id->driver_data;
> -	}
> +	chip = (uintptr_t)i2c_get_match_data(client);
>  
>  	if (chip == da217) {
>  		indio_dev->name = "da217";


