Return-Path: <linux-iio+bounces-3032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAE88626CB
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 19:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7511C20BFA
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FB214264;
	Sat, 24 Feb 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dsl/T+hK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25120EB;
	Sat, 24 Feb 2024 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708799508; cv=none; b=OLVkKFMOMLKeCCPb/WnQOlU2m9pe1RUKEXCQ3YK8aeuHD5L4ZB6Q5+phOeeCzs7Nzlo50XZ6oJq++Hrstgk7qQDS2jPSkhWsdVCQXo/MMhzVQInfMl+piJer/t+oyVfzEAibUoTIS7pT7f3yimW/PV7BacJsgnXCqH5Xken/Zy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708799508; c=relaxed/simple;
	bh=DiGnfS5IHlAds/iJWljtxega/rUdZrykZ+gJceoif34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+AVOvKdP5+mV7cVZYU4jyKMhUnYjvZy44YOFgV/N08Yi56mYt9qYgCqlbiJ7jRtHZ15WEGzrsxG8CFm1fIbp4rDZiWgMJ9pM1q6AVxWnCBprULtRFcKKUVc6kRLT/rzkWEKSqWgaBK509tlOR8VbYcXR86zFh6PDMUiOP8d0zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dsl/T+hK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B73C433F1;
	Sat, 24 Feb 2024 18:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708799507;
	bh=DiGnfS5IHlAds/iJWljtxega/rUdZrykZ+gJceoif34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dsl/T+hKajMcBQAA3Ai+RDHrhX7igQQ8h1bi/D/Lajj7aa/up74NDkrKU1UKYotzo
	 h5zhFRpyTWZXedNUtRVVGEXCUgUiPfKpAYABCzTO4WzM7d1xxCkEQ1wDFrkR5zOSfB
	 TE1YWKIHbuf2OeeBOcUUDL/HqioYHDN/TaD7B6Pc1FOepWIxd41KqmNMjBp4I1yinQ
	 UIEebxXX9+0fySJZfH0LcL5HzC+5oXt2uo5qJGo2hF17R2vHhjLCGT9FiaklUJbJ8Z
	 C42icgyi8lkF+q8AZDZzzm5NY1hrHMo/tMb5Msbrm0LLtaz/i2c8vIu2Kw54Jhq/om
	 P61LcwrlwVBeA==
Date: Sat, 24 Feb 2024 18:31:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH 1/6] iio: temperature: ltc2983: make use of
 spi_get_device_match_data()
Message-ID: <20240224183132.6a81db56@jic23-huawei>
In-Reply-To: <20240222-ltc2983-misc-improv-v1-1-cf7d4457e98c@analog.com>
References: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
	<20240222-ltc2983-misc-improv-v1-1-cf7d4457e98c@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 13:55:52 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> Use spi_get_device_match_data() as it simplifies the code. No functional
> change intended...
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
I'm a sucker for cleanup patches.

Applied 
> ---
>  drivers/iio/temperature/ltc2983.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index fcb96c44d954..acc631857e27 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -1614,9 +1614,7 @@ static int ltc2983_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> -	st->info = device_get_match_data(&spi->dev);
> -	if (!st->info)
> -		st->info = (void *)spi_get_device_id(spi)->driver_data;
> +	st->info = spi_get_device_match_data(spi);
>  	if (!st->info)
>  		return -ENODEV;
>  
> 


