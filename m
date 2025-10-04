Return-Path: <linux-iio+bounces-24728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD52BB8F71
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 17:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB973C35CB
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 15:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F132737F3;
	Sat,  4 Oct 2025 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAUgfDUR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C177F17A2EA
	for <linux-iio@vger.kernel.org>; Sat,  4 Oct 2025 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759592860; cv=none; b=IGyApTUzgrso0Scg5EVhSQspwW/LumLzPEDKQJR4WCEYJmKmxOeSORgRwJ9vEkGmWO/4Cw/91WDf4fnCE7kJK3jrfJj1gIr3CBTTRR11V2T92mGvmjxA0hMGp/ARBaPdidm+3mHC2VBbGqduYIEiJaZxJaLbwUP3SDhtvFYnXhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759592860; c=relaxed/simple;
	bh=rJWAaFGCXtX2RlMfthVchEReFpbdTqpDgXjzMYQrsbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DALnk/e03gkeqFrVJofN56cp/6A/ZM8LSaRnKWPkyZV4f03OuBHWd9racgdqOpr8wLcuq8ZwnVbqsEwecCU6Kka7doBTuaqKxBFTU8ba8tSqXxy0R6XAEtEPbTOG5GbLxFylJX7J4Xco4nTthto0ZFHk4CotuKu0ii9cv/vIGNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAUgfDUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5167EC4CEF1;
	Sat,  4 Oct 2025 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759592860;
	bh=rJWAaFGCXtX2RlMfthVchEReFpbdTqpDgXjzMYQrsbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DAUgfDURShz3KrKwmRvstFm494M9Bajnr6tyw6fYNABNzpw8XrwLw9CoQucZWN4bS
	 arKbXRp9fcqat4NoQj79Zolfic8jV8tQcBLE2+nikbHc5AjNr9duFRe+fzrXVJmYzm
	 eYKbw3zdGTLlK9uuE2JQ/LWVIGTaJRMz4MZb1L1ueUAp4CaUJoBytyBde+Jkqe0U+R
	 bEjrFaKbQDaDjBxwZHp4qAhs3y1tK4KpQBBp7HDBF/l8KXAXB4JlFJwkeQXFBNw40s
	 sjXpXEYHYvWO67e0wV45ShL2bTugDg7Ud0JH+pw8vk0kROGBioFMVkIljt2G9Am30A
	 2nrBu7e6jr16Q==
Date: Sat, 4 Oct 2025 16:47:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrej Valek <andrej.v@skyrain.eu>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Puranjay Mohan
 <puranjay@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 David Lechner <dlechner@baylibre.com>, Kessler Markus
 <markus.kessler@hilti.com>
Subject: Re: [PATCH v3] iio: accel: fix ADXL355 startup race condition
Message-ID: <20251004164732.3d70091c@jic23-huawei>
In-Reply-To: <20251001143702.587073-1-andrej.v@skyrain.eu>
References: <20250909085528.68966-1-andrej.v@skyrain.eu>
	<20251001143702.587073-1-andrej.v@skyrain.eu>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 Oct 2025 16:37:02 +0200
Andrej Valek <andrej.v@skyrain.eu> wrote:

> From: Valek Andrej <andrej.v@skyrain.eu>
> 
> There is an race-condition where device is not full working after SW reset.
> Therefore it's necessary to wait some time after reset and verify shadow
> registers values by reading and comparing the values before/after reset.
> This mechanism is described in datasheet at least from revision D.
> 
> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
> Signed-off-by: Kessler Markus <markus.kessler@hilti.com>

Hi Valek,

One process thing is to not reply to an existing thread with a new version.
Whilst it seems nice and tidy when we only have one patch in a series, it can
get very complex to read if we have deep threads with many versions being commented
on at the same time.  Also tends to end up way off the top of the screen in
threaded email clients.  Hence this is about the last patch I'm replying to today
just because for once I've more or less caught up with all my IIO related emails.

So just send a fresh series that isn't in reply to anything.

Mostly good, but can you reply with a fixes tag and are you fine with me
adding the error check I call out below?


> ---
>  drivers/iio/accel/adxl355_core.c | 41 ++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> index 2e00fd51b4d5..782085d74ab8 100644
> --- a/drivers/iio/accel/adxl355_core.c
> +++ b/drivers/iio/accel/adxl355_core.c
> @@ -56,6 +56,8 @@
>  #define  ADXL355_POWER_CTL_DRDY_MSK	BIT(2)
>  #define ADXL355_SELF_TEST_REG		0x2E
>  #define ADXL355_RESET_REG		0x2F
> +#define ADXL355_BASE_ADDR_SHADOW_REG	0x50
> +#define ADXL355_SHADOW_REG_COUNT	5
>  
>  #define ADXL355_DEVID_AD_VAL		0xAD
>  #define ADXL355_DEVID_MST_VAL		0x1D
> @@ -294,6 +296,8 @@ static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
>  static int adxl355_setup(struct adxl355_data *data)
>  {
>  	unsigned int regval;
> +	u8 *shadow_regs __free(kfree) = kzalloc(ADXL355_SHADOW_REG_COUNT, GFP_KERNEL);
> +	int retries = 5; /* the number is chosen based on empirical reasons */
>  	int ret;

	if (!shadow_regs)
		return -ENOMEM;

Whilst very unlikely to happen we still need to handle memory allocation failure.
>  
>  	ret = regmap_read(data->regmap, ADXL355_DEVID_AD_REG, &regval);
> @@ -321,14 +325,41 @@ static int adxl355_setup(struct adxl355_data *data)
>  	if (regval != ADXL355_PARTID_VAL)
>  		dev_warn(data->dev, "Invalid DEV ID 0x%02x\n", regval);
>  
> -	/*
> -	 * Perform a software reset to make sure the device is in a consistent
> -	 * state after start-up.
> -	 */
> -	ret = regmap_write(data->regmap, ADXL355_RESET_REG, ADXL355_RESET_CODE);
> +	/* Read shadow registers to be compared after reset */
> +	ret = regmap_bulk_read(data->regmap,
> +			       ADXL355_BASE_ADDR_SHADOW_REG,
> +			       shadow_regs, ADXL355_SHADOW_REG_COUNT);
>  	if (ret)
>  		return ret;
>  
> +	do {
> +		if (--retries == 0) {
> +			dev_err(data->dev, "Shadow registers mismatch\n");
> +			return -EIO;
> +		}
> +
> +		/*
> +		 * Perform a software reset to make sure the device is in a consistent
> +		 * state after start-up.
> +		 */
> +		ret = regmap_write(data->regmap, ADXL355_RESET_REG,
> +				   ADXL355_RESET_CODE);
> +		if (ret)
> +			return ret;
> +
> +		/* Wait at least 5ms after software reset */
> +		usleep_range(5000, 10000);
> +
> +		/* Read shadow registers for comparison */
> +		ret = regmap_bulk_read(data->regmap,
> +				       ADXL355_BASE_ADDR_SHADOW_REG,
> +				       data->buffer.buf,
> +				       ADXL355_SHADOW_REG_COUNT);
> +		if (ret)
> +			return ret;
> +	} while (memcmp(shadow_regs, data->buffer.buf,
> +			ADXL355_SHADOW_REG_COUNT));
> +
>  	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
>  				 ADXL355_POWER_CTL_DRDY_MSK,
>  				 FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK, 1));


