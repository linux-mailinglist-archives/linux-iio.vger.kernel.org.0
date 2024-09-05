Return-Path: <linux-iio+bounces-9187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE4596D637
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 12:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 129BCB21364
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 10:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDDC198E96;
	Thu,  5 Sep 2024 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMl5jDaa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BF21EBFEC;
	Thu,  5 Sep 2024 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532662; cv=none; b=nhjbaRvc/Jsw4ZYqscygp8Sg1jUqMNotxFYOw0SgKnmXvYbE0wBTGI14S1MH1IHx5vY6lHhihc0jiUM5ChO7P/yeXvnsKf1K+0INCCEJTSQrn6XSe2cin0RDHgXsAGxKc7WXqKnHqDqYh+kcCuAMnckO2vxSlTphgU2gkQalTwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532662; c=relaxed/simple;
	bh=cO2jkjsWjht1ipiWgNnsXnnaFAXs+KDdEIduPW2dVcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJ3edeP39YXN5Ag35HzF10yvhV0K1W1JV1AS+PFqB1pQxuuIh9gi/DkN5UgZqo+Ox2WnEKNC3wbZ/V/E89o/fLX9hIhBsq5kmuyabRoJrNLCRkPdjUlRdylakSUDK9QRS8SIzlSf8rAHjAdZHmCIpjW9JTgXKy8UWDAD0vWcrjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMl5jDaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DF3C4CEC6;
	Thu,  5 Sep 2024 10:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725532661;
	bh=cO2jkjsWjht1ipiWgNnsXnnaFAXs+KDdEIduPW2dVcQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jMl5jDaaFNHoc6jyK1TBmOFJ8j3P3Cz7GdCwhvge5+ZcCPLFJKTquZ91dGS83fDLT
	 wmcvxPj6r9puCobyc2YF4/RxgmJWaCyP4py5SN4c7FRuJOd6SsZNFP+ye36iCTGvuv
	 1Z1i/bdf5BknuxIsUKXb/RKUTsOKJC9g8470f3WXEexWa2+qNgncSO1tl6cEdjN73b
	 Z+D8gbVfFfV20wWNUh230bEfdUa353sg0cey5NpL5DF4IFf+1kUu19b5YZZcbMQQlj
	 IaBpq/oDZ1tjQAsKWqGcX/dj2IrFMDFb1JN/b8300E1Uv+BnHoNbxNyBY82ht4gqdm
	 26/PV+js7RhQQ==
Message-ID: <cf9d3887-f76e-48d8-a1a5-de6c6e6db96b@kernel.org>
Date: Thu, 5 Sep 2024 12:37:34 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
To: Emil Gedenryd <emil.gedenryd@axis.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@axis.com
References: <20240905-add_opt3002-v1-0-a5ae21b924fb@axis.com>
 <20240905-add_opt3002-v1-2-a5ae21b924fb@axis.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240905-add_opt3002-v1-2-a5ae21b924fb@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2024 12:20, Emil Gedenryd wrote:
> TI's opt3002 light sensor shares most properties with the opt3001
> model, with the exception of supporting a wider spectrum range.
> 
> Add support for TI's opt3002 by extending the TI opt3001 driver.
> 
> See https://www.ti.com/product/OPT3002 for more information.
> 

...

>  
>  	mutex_init(&opt->lock);
>  	init_waitqueue_head(&opt->result_ready_queue);
> @@ -769,10 +892,18 @@ static int opt3001_probe(struct i2c_client *client)
>  		return ret;
>  
>  	iio->name = client->name;
> -	iio->channels = opt3001_channels;
> -	iio->num_channels = ARRAY_SIZE(opt3001_channels);
>  	iio->modes = INDIO_DIRECT_MODE;
>  	iio->info = &opt3001_info;
> +	switch (opt->chip_info->model) {
> +	case OPT3001:
> +		iio->channels = opt3001_channels;
> +		iio->num_channels = ARRAY_SIZE(opt3001_channels);
> +		break;
> +	case OPT3002:
> +		iio->channels = opt3002_channels;
> +		iio->num_channels = ARRAY_SIZE(opt3002_channels);
> +		break;
> +	}
>  
>  	ret = devm_iio_device_register(dev, iio);
>  	if (ret) {
> @@ -826,13 +957,15 @@ static void opt3001_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id opt3001_id[] = {
> -	{ "opt3001" },
> +	{ "opt3001", 0 },
> +	{ "opt3002", 1 },

Use the same match data for all ID tables. Otherwise you run into
problems for different match methods.

>  	{ } /* Terminating Entry */
>  };
>  MODULE_DEVICE_TABLE(i2c, opt3001_id);
>  
>  static const struct of_device_id opt3001_of_match[] = {
> -	{ .compatible = "ti,opt3001" },
> +	{ .compatible = "ti,opt3001", .data = &opt3001_chip_info },
> +	{ .compatible = "ti,opt3002", .data = &opt3002_chip_info },
Best regards,
Krzysztof


