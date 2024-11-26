Return-Path: <linux-iio+bounces-12675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C2B9D93BA
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 10:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27220B2716D
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 09:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737191B4147;
	Tue, 26 Nov 2024 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="zKG1pIbu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FF81ABEBF;
	Tue, 26 Nov 2024 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732611609; cv=none; b=EZDc7IzLjw5NYiP5wOr592d8NLTqDWixdgkMUEq1zTY6gc07XDu3PAUqmARMQutu3eeZfV7uaM8htFMe2pJIbrCEp7Qcb+c+laZ8V0FQ1bBsXMRc0iG40AXDQSbtd8NfKMpy48EOaj5eeExljKPKtTjtIpN0CFGpjWqtycziIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732611609; c=relaxed/simple;
	bh=HoPGrXDeyiP3vLgB+rubUVJ6LgEJvWoYrTiBr02UaCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kY+yOJmQqO4eiRJlyEe1xXZrT113RqJgSofVaPZQ0GLl7Wg8uIstbfcWuHGfDa/S53CaxUNlX/C1yB2l04C09uqEGq0EwifjTKBmStSgXo/l4vtOwOIrxe4mDA+34ZfBQtARqVelLB6bGU0KZGBTOtMhjUioEWAOFcdwhh9JGwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=zKG1pIbu; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7E7371FA63;
	Tue, 26 Nov 2024 10:00:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1732611603;
	bh=HYLlL2py6KvR3LGQTUWtWU+jRFBXwR9XUix4zOYXRis=; h=From:To:Subject;
	b=zKG1pIbuXG6nmaMjlfaosLQnohBA7rJGFu4h2cbjKPjl2zyS3/SnGE6QGUuUTzluR
	 YOlHUZJZDongAW+DrCsnA3CGUZDIYoZJ+TBCi9LP5MDBlkd+0o2w1QPkoDs5OMaxWJ
	 eZKDxtRr3PZraMtYsJY9cbk5cj9RHmRXN9fc0Cx8tvh+OUe1r1/qctUE/YCuvMEDco
	 +k4rwPGHZSRkpV9IqebD6BQ0IvwSgLGQJIi54WD/2CZ9wtEqiQ4sMEbBOiWd6M/P4w
	 b0tYLMnsuIWjQwz4wDvsvZZiu1qzbzwExwO6FtGtPlUuV4Y3swwH0zU8vsgwgkNg2C
	 i4CLCWr6KC0cA==
Date: Tue, 26 Nov 2024 09:59:58 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 02/11] iio: adc: ti-ads1119: fix information leak in
 triggered buffer
Message-ID: <20241126085958.GA13577@francesco-nb>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
 <20241125-iio_memset_scan_holes-v1-2-0cb6e98d895c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125-iio_memset_scan_holes-v1-2-0cb6e98d895c@gmail.com>

On Mon, Nov 25, 2024 at 10:16:10PM +0100, Javier Carrasco wrote:
> The 'scan' local struct is used to push data to user space from a
> triggered buffer, but it has a hole between the sample (unsigned int)
> and the timestamp. This hole is never initialized.
> 
> Initialize the struct to zero before using it to avoid pushing
> uninitialized information to userspace.
> 
> Cc: stable@vger.kernel.org
> Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1119.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
> index e9d9d4d46d38..2615a275acb3 100644
> --- a/drivers/iio/adc/ti-ads1119.c
> +++ b/drivers/iio/adc/ti-ads1119.c
> @@ -506,6 +506,8 @@ static irqreturn_t ads1119_trigger_handler(int irq, void *private)
>  	unsigned int index;
>  	int ret;
>  
> +	memset(&scan, 0, sizeof(scan));

Did you consider adding a reserved field after sample and just
initializing that one to zero?

It seems a trivial optimization not adding much value, but I thought about
it, so I'd like to be sure you considered it.

In any case, the change is fine.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Thanks,
Francesco


