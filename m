Return-Path: <linux-iio+bounces-11867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 344E29BA540
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 12:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3AEB218E0
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 11:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC29916BE14;
	Sun,  3 Nov 2024 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMuhZ73R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BCB156C40;
	Sun,  3 Nov 2024 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730632943; cv=none; b=LyWu8bWIZykURiP42dyZxev/QXcVe1PxyTm06JXp6RciYv1yX64FiMlQRGfm1vcnTSCo26jbUlvA3W2bJpRoABwcHDoHA+ssaeklMEWxAy/YBmoYip+ZieRHIlxKQxe3jNvycnoSJtwbBkfONuczelenhldTRDAPx461sqXTH14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730632943; c=relaxed/simple;
	bh=rojxZqDQYmo7DcaabxpY+qtg25SoBSbQIlcnA6osyJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCyb0FbrTshCmqxOX6Fv2q9bDUBoJjVJMQmBy/GKEmf32KNwGOEgs+BmUU5MDPYB5GVklI+CqTR+cTpI9aRKuSYvhpwqwTf5D2LXZCD2V9LnAOHHVecum4fj+imefkkpZaoWQUm3C1iGC09XI1E5PvanFZK6v81e+XMVSQxGaQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMuhZ73R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68023C4CECD;
	Sun,  3 Nov 2024 11:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730632942;
	bh=rojxZqDQYmo7DcaabxpY+qtg25SoBSbQIlcnA6osyJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SMuhZ73RSbfxkOVpJ71Fpb2kdzTjWQp4utVDK1cYMBga+Y9ldKNQNO6JdoVCpiUzi
	 ldZxXWejGjuoh/mttBC91vjRPBeD5CaLuxzqUXg5WNZYRg3LGw7WUhZlnEDQ3IOgWp
	 t0YArjF1QmzwZJ9QErSzlQEe9RdJFLi5l30Yp1ikl2yu8lwJe8R+X/2PtfgtGvJiD6
	 47FfeL33TwgYT1D0YZT/jKVQY3rcRqNJZiPV990lXtONr/brsrv90vrnsiFZs3vS4x
	 CXSYmBxelswPO8yaIDyHklTeDtkona74buBXRZyAW6uti9etKk3CWqAZZtdGGhwGqn
	 XKSVTianPzfMQ==
Date: Sun, 3 Nov 2024 11:22:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Aren Moynihan <aren@peacevolution.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Kaustabh
 Chakraborty <kauschluss@disroot.org>, =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?=
 <trabarni@gmail.com>, Ondrej Jirman <megi@xff.cz>, Uwe =?UTF-8?B?S2xlaW5l?=
 =?UTF-8?B?LUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] iio: light: stk3310: handle all remove logic
 with devm callbacks
Message-ID: <20241103112208.233f7180@jic23-huawei>
In-Reply-To: <20241102195037.3013934-7-aren@peacevolution.org>
References: <20241102195037.3013934-3-aren@peacevolution.org>
	<20241102195037.3013934-7-aren@peacevolution.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Aren,

> @@ -624,7 +640,7 @@ static int stk3310_probe(struct i2c_client *client)
>  	device_property_read_u32(&client->dev, "proximity-near-level",
>  				 &data->ps_near_level);
>  
> -	mutex_init(&data->lock);
> +	devm_mutex_init(&client->dev, &data->lock);
ret = devm_mutex_init()
if (ret)
	return ret;

It is very unlikely to fail but technically it can.  Andy has been fixing
this up across the kernel (including IIO) so let's not introduce another
case that doesn't check it!

If nothing else comes up I can probably tidy that up whilst applying.

Jonathan

>  
>  	ret = stk3310_regmap_init(data);
>  	if (ret < 0)
> @@ -650,29 +666,17 @@ static int stk3310_probe(struct i2c_client *client)
>  		if (ret < 0) {
>  			dev_err(&client->dev, "request irq %d failed\n",
>  				client->irq);
> -			goto err_standby;
> +			return ret;
>  		}
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "device_register failed\n");
> -		goto err_standby;
> +		return ret;
>  	}
>  
>  	return 0;
> -
> -err_standby:
> -	stk3310_set_state(data, STK3310_STATE_STANDBY);
> -	return ret;
> -}
> -
> -static void stk3310_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -	stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
>  }
>  
>  static int stk3310_suspend(struct device *dev)
> @@ -736,7 +740,6 @@ static struct i2c_driver stk3310_driver = {
>  		.acpi_match_table = stk3310_acpi_id,
>  	},
>  	.probe =        stk3310_probe,
> -	.remove =           stk3310_remove,
>  	.id_table =         stk3310_i2c_id,
>  };
>  


