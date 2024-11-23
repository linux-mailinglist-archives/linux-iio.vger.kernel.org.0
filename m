Return-Path: <linux-iio+bounces-12552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A669D6A0A
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 17:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4B0B211E8
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C907C42A91;
	Sat, 23 Nov 2024 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQv+bEcO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3F3C466;
	Sat, 23 Nov 2024 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732378968; cv=none; b=MFCibSC6TPRH6VATr2+/Hhr64ToEnP3U0mUIVj8CZ/+tO5CTg4hApgph34+EDn5XCp40r5UW7M2zJxz1hn0e2FTQqPBQ0CFSNh7kVIZ2vVcwHFo9LtU+Pn1wApVLIjwdNfcLnhlShKNoSIXGyjYwTI56aYSfs/o7vabi8NI3lEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732378968; c=relaxed/simple;
	bh=NGzu+qxvjshYZ+Xn/Bt7dxddiy1OMzwvA7ZxFh9nu5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxdX5FybapVYUgMewNoUZ46jPrpnC1WUmHSHDCWvA7n+ek2EINQWYulGvu7k0BFpdobr7vnsQVv0IIsApT3fANfCR3uVLebzLkBQktvbI7WX2yPPdtZb9EC1n6KuCWBo/6CwcnhF7g4ydDCVUxDKS0kkWJpxtWTlw0feCdidqK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQv+bEcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6465C4CECD;
	Sat, 23 Nov 2024 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732378968;
	bh=NGzu+qxvjshYZ+Xn/Bt7dxddiy1OMzwvA7ZxFh9nu5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hQv+bEcO2B6vcm9Pe181pgLduBAKZIFY8pSIRhiS5BMqws23zZe7/+IrbKCmhRmHw
	 ymyC6R8uFZdmKbRjUsU9aHAdOAAOVRncjov+KFXWloJTvVv33OANxz1WD9uTJ3YY6N
	 Gp0crvJb5De/Z+7Ww7uP6rUXFEV5xV/KGD95jKmECEyUoLnaBUDbOq+3Dqb7V/XUVK
	 7ycf9nHAZngAHgvrtMvFow3/GJ1Mykyw6xk1ANRvH2u1UWMmjpO3PaRv2n9OG6J6q6
	 uy48/fUNWWisyCKwR8kE71EKtilSfT8xI9Gt0xfoiecu8wFe5rWGqL0+fplxtI9M2Y
	 TnSBjfCfHWhhQ==
Date: Sat, 23 Nov 2024 16:22:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] iio: dac: Fix converters spelling typo.
Message-ID: <20241123162241.7b09fbce@jic23-huawei>
In-Reply-To: <20241111-dackconfigcodespell-v1-1-2498567be34c@gmail.com>
References: <20241111-dackconfigcodespell-v1-1-2498567be34c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 14:55:05 +0000
Karan Sanghavi <karansanghvi98@gmail.com> wrote:

> Correct the converters typo error
> 
> "convertors" => "converters"
> 
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
Applied.
Thanks
> ---
>  drivers/iio/dac/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 45e337c6d256..059994c7caa3 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -61,7 +61,7 @@ config AD5421
>  	depends on SPI
>  	help
>  	  Say yes here to build support for Analog Devices AD5421 loop-powered
> -	  digital-to-analog convertors (DAC).
> +	  digital-to-analog converters (DAC).
>  
>  	  To compile this driver as module choose M here: the module will be called
>  	  ad5421.
> 
> ---
> base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> change-id: 20241111-dackconfigcodespell-2c39aae651a0
> 
> Best regards,


