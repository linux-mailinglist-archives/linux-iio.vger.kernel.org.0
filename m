Return-Path: <linux-iio+bounces-4846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E968BD054
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 16:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BD0DB2698A
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A703B13D53A;
	Mon,  6 May 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgSUMliR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA9D13D8BE;
	Mon,  6 May 2024 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005802; cv=none; b=Btp/O0Eowlnz7ZlzDIfp58C3aXUv5Kg3+q2R6bF8NAc6eFSWORmIOnqhBP5nv7Ff32vpbQV/TrISWhfbD4JQkUMr97dyUaCPhluBoXR8cXj68V3DdPTxYFs5N5DVsWUiFhT5AXQwnWv5cUeWo/CQ0S2yHWzb+ZzHiBsSmkj7who=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005802; c=relaxed/simple;
	bh=xLyyQsgBKxOS7ju/Z1jQLkPWqUuski82jXjG4sGoz8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6bYYqT74IESSui24NrkTIGh5iCj/6PGQgPSsHt3+8FAef+oMP2UHm1B85NeP1HOhoRFDnOYEF9R/9Q7SqW61vzjAFV/yxgkouYe0VVdn9UBNQoaoaZVAxZQnIlZsrDgKf2ff84Eic4WqaQQcMffIhDuJKPb+jzMMlp8cZMKwgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgSUMliR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43365C4AF63;
	Mon,  6 May 2024 14:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715005801;
	bh=xLyyQsgBKxOS7ju/Z1jQLkPWqUuski82jXjG4sGoz8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qgSUMliRi/qdlo42bY09VW5dKPEjBw9ldcpgEjzTwevJIj1dfq6O6e1EAFPa+pDrY
	 FLzUrvwfX3bfROez3MCZBCDoVObk4hzZIIa9HsNMrT8oXLPr5YCmUnox0M87In/P+b
	 0+dM+vPrwLdcsagU0+j71jO9yQJZ4H2xbmX6lv1AmuhtV38wZOWXuqT7+hPdajtaIq
	 mLxkoxt2Eh58K6D0Hu7Krf8og2mK7jf7Ur1i7s+Kp2YjlQ98he9GVbRNvWamAubOYp
	 IH9feVvYL0ZJQ320d01epzTNyiK6mDfO15IWg9oCKsv8Aom2/KqkYxez9K7/WDVxzz
	 o9mvjAjlEMazg==
Date: Mon, 6 May 2024 15:29:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, kernel test robot <lkp@intel.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v6 10/10] iio: adc: ad7380: add support for
 resolution boost
Message-ID: <20240506152946.74f1438c@jic23-huawei>
In-Reply-To: <20240501-adding-new-ad738x-driver-v6-10-3c0741154728@baylibre.com>
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
	<20240501-adding-new-ad738x-driver-v6-10-3c0741154728@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 May 2024 16:55:43 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> ad738x chips are able to use an additional 2 bits of resolution when
> using oversampling. The 14-bits chips can have up to 16 bits of
> resolution and the 16-bits chips can have up to 18 bits of resolution.
> 
> In order to dynamically allow to enable/disable the resolution boost
> feature, we have to set iio realbits/storagebits to the maximum per chips.
> This means that for iio, data will always be on the higher resolution
> available, and to cope with that we adjust the iio scale and iio offset
> depending on the resolution boost status.
> 
> The available scales can be displayed using the regular _scale_available
> attributes and can be set by writing the regular _scale attribute.
> The available scales depend on the oversampling status.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> 
> ---
> 
> In order to support the resolution boost (additional 2 bits of resolution)
> we need to set realbits/storagebits to the maximum value i.e :
>   - realbits = 16 + 2 = 18, and storagebits = 32 for 16-bits chips
>   - realbits = 14 + 2 = 16, and storagebits = 16 for 14-bits chips
> 
> For 14-bits chips this does not have a major impact, but this
> has the drawback of forcing 16-bits chip users to always use 32-bits
> words in buffers even if they are not using oversampling and resolution
> boost. Is there a better way of implementing this? For example
> implementing dynamic scan_type?
> 
> Another issue is the location of the timestamps. I understood the need
> for ts to be consistent between chips, but right now I do not have a
> better solution.. I was thinking of maybe adding the timestamps at the
> beginning? That would imply to change the iio_chan_spec struct and maybe
> add a iio_push_to_buffers_with_timestamp_first() wrapper function? Is
> that an option?

Questions discussed in another branch of the thread.

Jonathan

> 
> Any suggestion would be very much appreciated.
> ---
>  drivers/iio/adc/ad7380.c | 226 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 194 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index 7b021bb9cf87..e240098708e9 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -20,6 +20,7 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/units.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> @@ -58,6 +59,8 @@
>  #define AD7380_CONFIG1_CRC_R		BIT(4)
>  #define AD7380_CONFIG1_ALERTEN		BIT(3)
>  #define AD7380_CONFIG1_RES		BIT(2)
> +#define RESOLUTION_BOOST_DISABLE	0
> +#define RESOLUTION_BOOST_ENABLE		1
If the field is defined, the values should be obvious.
Also you used this as a boolean where simply passing in true
or false would be less confusing.

>  #define AD7380_CONFIG1_REFSEL		BIT(1)
>  #define AD7380_CONFIG1_PMODE		BIT(0)
>  
> @@ -86,6 +89,14 @@ struct ad7380_chip_info {
>  	const struct ad7380_timing_specs *timing_specs;
>  };

> @@ -259,6 +271,8 @@ struct ad7380_state {
>  	struct spi_device *spi;
>  	unsigned int oversampling_mode;
>  	unsigned int oversampling_ratio;
> +	unsigned int scales[2][2];
> +	bool resolution_boost_enable;
>  	struct regmap *regmap;
>  	unsigned int vref_mv;
>  	unsigned int vcm_mv[MAX_NUM_CHANNELS];
> @@ -270,7 +284,10 @@ struct ad7380_state {
>  	 * As MAX_NUM_CHANNELS is 4 the layout of the structure is the same for all parts
>  	 */
>  	struct {
> -		u16 raw[MAX_NUM_CHANNELS];
> +		union {
> +			u16 u16[MAX_NUM_CHANNELS];
> +			u32 u32[MAX_NUM_CHANNELS];
> +		} raw;
>  
>  		s64 ts __aligned(8);

As per earlier comments, roll this timestamp into the union as well
because it will move around.

>  	} scan_data __aligned(IIO_DMA_MINALIGN);
> @@ -359,23 +376,67 @@ static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
>  	unreachable();
>  }

>  
> +static int ad7380_set_resolution_boost(struct iio_dev *indio_dev, bool enable)
You pass 1 or 0 in here rather than true or false which would make more sense.
> +{
> +	struct ad7380_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (st->resolution_boost_enable == enable)
> +		return 0;
> +
> +	ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
> +				 AD7380_CONFIG1_RES,
> +				 FIELD_PREP(AD7380_CONFIG1_RES, enable));
Mapping true / false to 1 / 0 whilst correct doesn't give particularly readable
code. So useful to just have an
	enable ? 1 : 0 
in there to make the mapping more obvious.
> +
> +	if (ret)
> +		return ret;
> +
> +	st->resolution_boost_enable = enable;

Trivial: blank line here.

> +	return 0;
> +}
>
>  static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
>  {
>  	int ret;
> @@ -691,12 +849,16 @@ static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Disable oversampling by default.
> -	 * This is the default value after reset,
> +	/* Disable oversampling and resolution boost by default.

Follow through from earlier.  Wrong comment syntax + wrap lines nearer 80 chars.

> +	 * This are the default values after reset,
>  	 * so just initialize internal data
>  	 */


