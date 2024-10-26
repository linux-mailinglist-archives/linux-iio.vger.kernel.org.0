Return-Path: <linux-iio+bounces-11321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B78329B1773
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11206B225D8
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B611C7B7F;
	Sat, 26 Oct 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljGN+pog"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3207E1FC3;
	Sat, 26 Oct 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729942259; cv=none; b=kg2XIX3zHxVyGVMof08Ry75EpvuP/05XqRZSArSYRtlOJSK3L3S2fwDrWBDNnImoPxZmLwzuqp2RrkoNtUXouZVeaTEegA7p3F6wU9ky4CZ8O0RJvvvoOguWq6iInI4Lt8xP2VAVFAh67eSpMdsX9shU9E7fxWgkNWmbWajLw90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729942259; c=relaxed/simple;
	bh=XFI5r8r+bM0BwVFeKPVTdFrsDR4cs638R5wjnpH+bHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLpxsQNMmo19XAbam+XG7Uq+uDJWPuih2LSDT9EyEfZ1UWYvTyXQNAPTHAcX6h/TwbX0MfAXIQMzUl4ngqFiboSwCpRrRSMen2LQCl9b3XhAjHBy2Lh2inGbDMkBu7J06BTk/2h4PWsNKMB5UpYEt7bU57HIlsV5Jvl+gu66rxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljGN+pog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1627FC4CEC6;
	Sat, 26 Oct 2024 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729942259;
	bh=XFI5r8r+bM0BwVFeKPVTdFrsDR4cs638R5wjnpH+bHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ljGN+pogzCPwABNCsbgQDeT8cxqRbe+HMUUFgcspwujawZV2szQW0u+Cg0PvBUwSe
	 VXFDD4IB0TwM6D6y95l+VwLqd6W/yUCFIwZEx7EyvOH7azt87OcXFE44a47Q+t29E6
	 uPhvPZ4ycPh7LCuwFFFuCVKVArsaJmdMmApgx60dmKYIoxpDz7H6X6G1+uPv1Y3KCZ
	 mkdKJ6gbIYJqzZviMc33iyqLgqVpjCnCDI7ZEXoTBgE3PTNHskiz5jpI5w4EQcLNYS
	 TiO016VIRz7HmXfCclSqMAwiw5aTU5iLxzzCRV5ZLXT/SasqbyzzwquYaS8be70bJS
	 9Z6VgOGy4Ezcw==
Date: Sat, 26 Oct 2024 12:30:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 12/24] iio: accel: kxcjk-1013: Move
 odr_start_up_times up in the code
Message-ID: <20241026122957.3fcbd863@jic23-huawei>
In-Reply-To: <20241024191200.229894-13-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-13-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:05:01 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Move odr_start_up_times up in the code in a preparation of
> the further cleaning up changes.
> 
> While at it, make it clear what values from enum are being used for
> the respective array entries.
I did some cheeky white space additions in this one as well.
Bit naughty in a code move patch, but I really want to get this
stuff cleaned up across IIO and it seems silly to chase your series
with another one changing the same code.

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/accel/kxcjk-1013.c | 154 ++++++++++++++++-----------------
>  1 file changed, 77 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 37c82fdf7c43..f384969a922d 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -178,6 +178,83 @@ enum kx_chipset {
>  	KX_MAX_CHIPS /* this must be last */
>  };
>  
> +/* Refer to section 4 of the specification */
> +static const struct {
> +	int odr_bits;
> +	int usec;
> +} odr_start_up_times[KX_MAX_CHIPS][12] = {
> +	/* KXCJK-1013 */
> +	[KXCJK1013] = {
> +		{0x08, 100000},
> +		{0x09, 100000},
> +		{0x0A, 100000},
> +		{0x0B, 100000},
> +		{0, 80000},
I changed this to
		{ 0x00, 80000 }
as I think it helps readability to have them
all aligned

Spaces added to all entries.

Jonathan

> +		{0x01, 41000},
> +		{0x02, 21000},
> +		{0x03, 11000},
> +		{0x04, 6400},
> +		{0x05, 3900},
> +		{0x06, 2700},
> +		{0x07, 2100},
> +	},
> +	/* KXCJ9-1008 */
> +	[KXCJ91008] = {
> +		{0x08, 100000},
> +		{0x09, 100000},
> +		{0x0A, 100000},
> +		{0x0B, 100000},
> +		{0, 80000},
> +		{0x01, 41000},
> +		{0x02, 21000},
> +		{0x03, 11000},
> +		{0x04, 6400},
> +		{0x05, 3900},
> +		{0x06, 2700},
> +		{0x07, 2100},
> +	},
> +	/* KXCTJ2-1009 */
> +	[KXTJ21009] = {
> +		{0x08, 1240000},
> +		{0x09, 621000},
> +		{0x0A, 309000},
> +		{0x0B, 151000},
> +		{0, 80000},
> +		{0x01, 41000},
> +		{0x02, 21000},
> +		{0x03, 11000},
> +		{0x04, 6000},
> +		{0x05, 4000},
> +		{0x06, 3000},
> +		{0x07, 2000},
> +	},
> +	/* KXTF9 */
> +	[KXTF9] = {
> +		{0x01, 81000},
> +		{0x02, 41000},
> +		{0x03, 21000},
> +		{0x04, 11000},
> +		{0x05, 5100},
> +		{0x06, 2700},
> +	},
> +	/* KX023-1025 */
> +	[KX0231025] = {
> +		/* First 4 are not in datasheet, taken from KXCTJ2-1009 */
> +		{0x08, 1240000},
> +		{0x09, 621000},
> +		{0x0A, 309000},
> +		{0x0B, 151000},
> +		{0, 81000},
> +		{0x01, 40000},
> +		{0x02, 22000},
> +		{0x03, 12000},
> +		{0x04, 7000},
> +		{0x05, 4400},
> +		{0x06, 3000},
> +		{0x07, 3000},
> +	},
> +};
> +
>  enum kx_acpi_type {
>  	ACPI_GENERIC,
>  	ACPI_SMO8500,
> @@ -361,83 +438,6 @@ static const struct kx_odr_map kxtf9_samp_freq_table[] = {
>  static const char *const kxtf9_samp_freq_avail =
>  	"25 50 100 200 400 800";
>  
> -/* Refer to section 4 of the specification */
> -static const struct {
> -	int odr_bits;
> -	int usec;
> -} odr_start_up_times[KX_MAX_CHIPS][12] = {
> -	/* KXCJK-1013 */
> -	{
> -		{0x08, 100000},
> -		{0x09, 100000},
> -		{0x0A, 100000},
> -		{0x0B, 100000},
> -		{0, 80000},
> -		{0x01, 41000},
> -		{0x02, 21000},
> -		{0x03, 11000},
> -		{0x04, 6400},
> -		{0x05, 3900},
> -		{0x06, 2700},
> -		{0x07, 2100},
> -	},
> -	/* KXCJ9-1008 */
> -	{
> -		{0x08, 100000},
> -		{0x09, 100000},
> -		{0x0A, 100000},
> -		{0x0B, 100000},
> -		{0, 80000},
> -		{0x01, 41000},
> -		{0x02, 21000},
> -		{0x03, 11000},
> -		{0x04, 6400},
> -		{0x05, 3900},
> -		{0x06, 2700},
> -		{0x07, 2100},
> -	},
> -	/* KXCTJ2-1009 */
> -	{
> -		{0x08, 1240000},
> -		{0x09, 621000},
> -		{0x0A, 309000},
> -		{0x0B, 151000},
> -		{0, 80000},
> -		{0x01, 41000},
> -		{0x02, 21000},
> -		{0x03, 11000},
> -		{0x04, 6000},
> -		{0x05, 4000},
> -		{0x06, 3000},
> -		{0x07, 2000},
> -	},
> -	/* KXTF9 */
> -	{
> -		{0x01, 81000},
> -		{0x02, 41000},
> -		{0x03, 21000},
> -		{0x04, 11000},
> -		{0x05, 5100},
> -		{0x06, 2700},
> -	},
> -	/* KX023-1025 */
> -	{
> -		/* First 4 are not in datasheet, taken from KXCTJ2-1009 */
> -		{0x08, 1240000},
> -		{0x09, 621000},
> -		{0x0A, 309000},
> -		{0x0B, 151000},
> -		{0, 81000},
> -		{0x01, 40000},
> -		{0x02, 22000},
> -		{0x03, 12000},
> -		{0x04, 7000},
> -		{0x05, 4400},
> -		{0x06, 3000},
> -		{0x07, 3000},
> -	},
> -};
> -
>  static const struct {
>  	u16 scale;
>  	u8 gsel_0;


