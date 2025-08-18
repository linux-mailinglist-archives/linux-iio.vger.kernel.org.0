Return-Path: <linux-iio+bounces-22940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1E5B2B044
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 20:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDB256662D
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 18:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FBE3314B1;
	Mon, 18 Aug 2025 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VU+zvF3C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093783314A2;
	Mon, 18 Aug 2025 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541614; cv=none; b=BRmoLQOVDcwd3adG+BCkRI+3K594r5erCXbK+LFv0PBixWMi5WytMo1hf6cXtwWP19VD6jbnAKNkvAnD/wLEWPUAoRqsIwwerz5uQrHUgFtEvtpzcdGTL8LhiOvhbWBTjNhemVQej8U6EdlpOLcw7Ek2oYA3tHn7AzsVMWbL0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541614; c=relaxed/simple;
	bh=cJtUW+vi9Bpqx+2oOXE9Ny2QyDh2KiaJnBmjqvxVePw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5kc9gA8jQydOBDE9SsAuO/bR+MUd7EPE5zmvED21kXbB++7kvgB/06PQYJbBenRVevHBWyr/L/p4Sxo2WRcULEqp0J7s62xt5CoBDP90MHcgIonmSENuP5WA780q12DWtQlG5sEzLYsbSRI4+rIVqNsh8xwhuX4PEo8jqDvLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VU+zvF3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763A9C4CEEB;
	Mon, 18 Aug 2025 18:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755541613;
	bh=cJtUW+vi9Bpqx+2oOXE9Ny2QyDh2KiaJnBmjqvxVePw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VU+zvF3CVjS8P3Ser0xAJh/8tN9iIuRBdsYurn7nbLgTscoJcby5dBZuPwxWS7zWz
	 TJzZCuVkgkn+I9uxz9mKTPl9DRnMWPk1ZAxTYeFuru5OsvXz0NlMMdMsUTCzOPSZl2
	 b2SCWZfbjnZyMV2/QGokXUc8oBYPLK6Wm5RVYwrEWnJuDfvl/8XoZKTmBHE3Qnmr43
	 2NKdT7dyFDN4IlcuY6j4wWaMJ92eXzhnml+XqOrcsED4gGFBi6HPCAPvKOs1Xzax3Q
	 xLSwktgrjPbhzS5tjD7Q69X88hG/0CGIWsG6dPHTlZDXagkkSkaNCs1GqfPs0Imboj
	 8/MmwzRbmNj2w==
Date: Mon, 18 Aug 2025 19:26:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ioana Risteiu <Ioana.Risteiu@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ramona Nechita
 <ramona.nechita@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] iio: adc: adi-axi-adc: add axi_adc_num_lanes_set
Message-ID: <20250818192641.61f9af06@jic23-huawei>
In-Reply-To: <20250818131253.8854-2-Ioana.Risteiu@analog.com>
References: <20250818131253.8854-1-Ioana.Risteiu@analog.com>
	<20250818131253.8854-2-Ioana.Risteiu@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 16:12:47 +0300
Ioana Risteiu <Ioana.Risteiu@analog.com> wrote:

> Add axi_adc_num_lanes_set in the adi_axi_adc_ops structure to support
> setting number of lanes used by AXI ADC.
> 
> Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>

So far we only have this set for a specific compatible.  Why does it
now make sense to set it for the 'generic' case? Please add something
to the patch description.

Jonathan

> ---
>  drivers/iio/adc/adi-axi-adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 2d86bb0e08a7..20bb59c24acf 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -617,6 +617,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
>  	.chan_status = axi_adc_chan_status,
>  	.interface_type_get = axi_adc_interface_type_get,
>  	.oversampling_ratio_set = axi_adc_oversampling_ratio_set,
> +	.num_lanes_set = axi_adc_num_lanes_set,
>  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
>  	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
>  };


