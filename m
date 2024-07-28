Return-Path: <linux-iio+bounces-8009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89F993E8B1
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 18:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C261C216D4
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272A657333;
	Sun, 28 Jul 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVMiBQqs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6697A35;
	Sun, 28 Jul 2024 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722185928; cv=none; b=Fdu1KNhJc5GvY0ckliguVkzlK5qAee68Wc143I+cyCk1uE57faBWW1M9SRIZoJRTEe2Db08oFEzfeynLq4+wTrj0LMouxcC4b5pvt4Su0RZJv5LPHrYjD/uL64Dx94lyIQ0wARCnOgQ/WOBycZPnScy01rNOc5ZQpqunSQ/WIxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722185928; c=relaxed/simple;
	bh=XZSBk3JJomRK7hzplafWAGQGVVQ8bJDO4s0Rz73Sf+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fzq49H9qNdWzbQNuH5wL0U/PCvcSmJauH0zpCdaB5c8S+EJCpdgysUNPiVM3hk219bL/mXYpbyr4SwU4PfAxxijNT9L84n1TK+ou3VJwiqgR+8VM4uR58EuElTN+gct4VHQc2ixAg+YwaHMHhhNzTIFGgWrTfi+b9myCX14vzgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVMiBQqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF28C116B1;
	Sun, 28 Jul 2024 16:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722185928;
	bh=XZSBk3JJomRK7hzplafWAGQGVVQ8bJDO4s0Rz73Sf+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IVMiBQqsWn/Zd20bFqZklwt/OVi9tvlsUyCS8i/U+YnM4wWIUJgoIg/h9zFMujHnh
	 NiJ4zMBchMpgqTPXNQOHvI5F51TtP4zbUXpIXbRhBs1yvXHa5vdsBrgOlnfyPkIzgY
	 1Vo94BQBcCl7j7xDHppRRdcbo51N+RGl6VLf/20JfMQbJ9xeNrfTl3kmOlrqoqsBs1
	 bkvse1PiDEj0EpZjxK+EAoqcdyshhDBK4XnRM5X4T1XREHI/VYimy/zDV1uZXpgPv0
	 jcyko50/mWRXKOSsW/rW0WJoYH5iW2msdNILoGxlxwovUHtSMyX75V2aWxSbDAud2e
	 5/AmlArVd2FHQ==
Date: Sun, 28 Jul 2024 17:58:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: light: ltr390: Add ALS channel and support
 for gain and resolution
Message-ID: <20240728175841.7ca04e58@jic23-huawei>
In-Reply-To: <20240728151957.310237-2-abhashkumarjha123@gmail.com>
References: <20240727132735.052502ad@jic23-huawei>
	<20240728151957.310237-1-abhashkumarjha123@gmail.com>
	<20240728151957.310237-2-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jul 2024 20:49:55 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

>     Add new ALS channel and allow reading raw and scale values.
>     Also provide gain and resolution configuration for ALS channel.
>     Add automatic mode switching between the UVS and ALS channel
>     based on which channel is being accessed.
>     The default mode in which the sensor start is ALS mode.
Same issue with indent as in patch 1.

> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
Later patches should not be in reply to the first one.
Use a cover letter.

Minor comments inline on using the enum to maintain the type of the mode
setting.


> ---
>  drivers/iio/light/ltr390.c | 111 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 96 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index 9f00661c3..d1a259141 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -62,11 +62,17 @@
>   */
>  #define LTR390_WINDOW_FACTOR 1
>  
> +enum ltr390_mode {
> +	LTR390_SET_ALS_MODE,
> +	LTR390_SET_UVS_MODE,
> +};
> +
>  struct ltr390_data {
>  	struct regmap *regmap;
>  	struct i2c_client *client;
>  	/* Protects device from simulataneous reads */
>  	struct mutex lock;
> +	int mode;
enum ltr380_mode mode;

>  	int gain;
>  	int int_time_us;
>  };
> @@ -94,6 +100,28 @@ static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
>  	return get_unaligned_le24(recieve_buffer);
>  }
>  
> +static int ltr390_set_mode(struct ltr390_data *data, int mode)

pass in the enum lt380_mode.

> +{
> +	if (data->mode == mode)
> +		return 0;
> +
> +	switch (mode) {
> +	case LTR390_SET_ALS_MODE:
> +		regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
> +		break;
> +
> +	case LTR390_SET_UVS_MODE:
> +		regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
> +		break;
> +
> +	default:
> +		return -EINVAL;
Should be able to drop this if passing in the enum as the compiler can see you
have cases for every value.

> +	}
> +
> +	data->mode = mode;
> +	return 0;
> +}
> +


