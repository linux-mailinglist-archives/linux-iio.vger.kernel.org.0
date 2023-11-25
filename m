Return-Path: <linux-iio+bounces-353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7647F8C53
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 17:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC6A1C20C19
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 16:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCDA29432;
	Sat, 25 Nov 2023 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GL9xjaOo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AECEB65C;
	Sat, 25 Nov 2023 16:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A391FC433C8;
	Sat, 25 Nov 2023 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700929128;
	bh=EaJyO/m/g95FBqHOnwDYmQe9cCbHuHP/FAMaf64auWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GL9xjaOocUk1p+2gflGqmQOHjTDo0GoY+YUdrHJ1AGTVPLf2bb2Ad/eDPVZ2jtO2S
	 RWpiKE4LKp6phybeeWXs8YImvTo/37vnEJpWLlpFuDtwadZW+irt8l0W5DHA+rVkCp
	 2bp/S+H5BZvt8ltzxzlnuI3x8AuO/4ZH+m+UcoztmHadWp5bXNSBBkv9j6p0vW1f10
	 A5MDzwbZBw7MIObnGxKxslxWZfedHzaa7nCbtSLC0/aRjQAQq0PAf/E8HlABguFeV0
	 fl7tI6xv/Tf3nf1Q3yhSM/H8TrYbO556omM+ajUZHQIUHdd2oRI4DvucXgEsINDhQq
	 wQcOJXvz4rVjA==
Date: Sat, 25 Nov 2023 16:18:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <paul.cercueil@analog.com>, <Michael.Hennerich@analog.com>,
 <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] iio: adc: ad7091r: Move defines to header file
Message-ID: <20231125161839.74129fc2@jic23-huawei>
In-Reply-To: <60e3914b06997ecb8a153170602272f63c579c57.1700751907.git.marcelo.schmitt1@gmail.com>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
	<60e3914b06997ecb8a153170602272f63c579c57.1700751907.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 13:41:28 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Move AD7091R register, channel and event definitions to the header file
> so other AD7091R device drivers may use those declaration in follow up
> patches.
Hi,

This is moving stuff into the base.c file as well, but the patch description
doesn't talk about that or the exports added.  It should describe those parts.

Looks good otherwise - one trivial comment below.

Jonathan

> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

> diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> index 509748aef9b1..6ff539cd1d39 100644
> --- a/drivers/iio/adc/ad7091r-base.h
> +++ b/drivers/iio/adc/ad7091r-base.h
> @@ -8,6 +8,27 @@

...


>  
> +bool ad7091r_volatile_reg(struct device *dev, unsigned int reg);
> +
Trivial but I'd not have a blank line here. 
> +bool ad7091r_writeable_reg(struct device *dev, unsigned int reg);
> +
>  #endif /* __DRIVERS_IIO_ADC_AD7091R_BASE_H__ */


