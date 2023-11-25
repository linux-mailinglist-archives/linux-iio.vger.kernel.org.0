Return-Path: <linux-iio+bounces-351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 244E37F8C4C
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 17:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F3C1F20F00
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 16:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D312942B;
	Sat, 25 Nov 2023 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pml8R9aX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F003622F12;
	Sat, 25 Nov 2023 16:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C29C433C8;
	Sat, 25 Nov 2023 16:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700928925;
	bh=kfauFDg9XTul9XhggWEJMK5ehWMTcrQkQSMmN0gP4QA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pml8R9aXSofO5GAIws74dWY0B7s0w7d6SZHErOeiCttaFYyUlVJY8qYmGRPkObT1D
	 TYXGmA+tB/9xYCnKN9J+3RF20Qra/N9yYRTG+SNZE5f/p4S0nDQVITXMBhyP/EW07D
	 P74QV1p6FVZUJ9oshulcJLJENbiWEBM0P+IGiSka4dVIudi7ygcAp7LKPBPiSq6RSc
	 b3RNL6LMFXZ3KBGFvTVeabCl3qrNTCrLhpXiQ2Ygciw7vB5wGhjz4aMWo83yI8mplC
	 b6esqnzlRUCmoNCOnNSE1B3JIdW0B65Dfoc2iZVI2Ov8F6O2SX7EKidYZDaH1mpnez
	 v6Z4uKjpW4AiQ==
Date: Sat, 25 Nov 2023 16:15:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <paul.cercueil@analog.com>, <Michael.Hennerich@analog.com>,
 <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] MAINTAINERS: Add MAINTAINERS entry for AD7091R
Message-ID: <20231125161517.5a48b215@jic23-huawei>
In-Reply-To: <1a36ac71c6b9fbde68e29ad3dc030cef10e3d252.1700751907.git.marcelo.schmitt1@gmail.com>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
	<1a36ac71c6b9fbde68e29ad3dc030cef10e3d252.1700751907.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 13:40:48 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The driver for AD7091R was added in
> ca693001: iio: adc: Add support for AD7091R5 ADC
> but no MAINTAINERS file entry was added for it since then.
> Add a proper MAINTAINERS file entry for the AD7091R driver.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Hi Marcelo,

Small patch ordering thing.  If I apply the series in order,
at this point you've not 'yet' contributed much to this driver
so it's not obvious that you are in a position to take over maintenance.

Push it to the end of the series then it's fair enough and thanks
for stepping up to look after this one!

Jonathan

> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e0a91dc8251..008f0e73bead 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1126,6 +1126,16 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>  F:	drivers/iio/adc/ad4130.c
>  
> +ANALOG DEVICES INC AD7091R DRIVER
> +M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	http://ez.analog.com/community/linux-device-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> +F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.c
> +F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.h
> +F:	drivers/iio/adc/drivers/iio/adc/ad7091r5.c
> +
>  ANALOG DEVICES INC AD7192 DRIVER
>  M:	Alexandru Tachici <alexandru.tachici@analog.com>
>  L:	linux-iio@vger.kernel.org


