Return-Path: <linux-iio+bounces-14219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66DBA0AA56
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC7D7A2B49
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF271BBBC0;
	Sun, 12 Jan 2025 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRtckopE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B002F56;
	Sun, 12 Jan 2025 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736694249; cv=none; b=TTGtvK0OZiQsNRlTMnqdTFXvkjrhaO49Slwv/H7rVq6BvGlFWEZ55Z2BaO5ib03nV9X3si126y962gd47huJdCziZvGbSEnY7SmPTgfOcK6BWrlqTDMpGgfRRJ8N/H+ZOOZ8vej5a7vZUFXOIpn3oKvLYqnz9vR7G6Fl33sceDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736694249; c=relaxed/simple;
	bh=YurLqbC9YmOCZ+Ugyvo6p9VzhoHheXYkG2LQ9oWKqEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYUgUHkvOdrsFY2+t43lV9yYjGmJQJ6/9FjH7l+F2E+fE+JfS7VU6ZzMEIs8Z/qD7gjqagNiwnSlr/w6BZle+q7kXz3J6ZGIWeAX/WLjpsLKbMlcpvXyqQmfVqe6IFF4x9dxH+bVA7ZLiTCUHlZj0XTIzlJc94v5ACjc4KS2gfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRtckopE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B89C4CEDF;
	Sun, 12 Jan 2025 15:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736694249;
	bh=YurLqbC9YmOCZ+Ugyvo6p9VzhoHheXYkG2LQ9oWKqEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oRtckopEua5E/dDoAkl32yHBCh78gS31SZQOjGPZlqGMoti+sy1EzzSVPxZu+UDOG
	 32FrEU+Gt1/4Hcr3XqkSvJaFoZy0L9x/EzhDXetz5YP3ZKptGb3F1jqZssPDuOGiga
	 iU9JCMEmWbknaG43CEyqZ+y3sb2NocJDh8GY1tpKdsujyO2b/SbujkUl1fzCQuHc/E
	 v4YZFLMKY/oq2TcclveRQV6nrP0QulJyLIQHaKvsUWpCS3X3gDNCEPeLDR/67yrPjG
	 QDvp+sAXId/++nFFXxw7v6WLll4IyyLfAJE+W0Urb7WiuK0wamdi7IFkrCx0t7TUl2
	 zeE+ApvsxRWxQ==
Date: Sun, 12 Jan 2025 15:04:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 Sa <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] iio: dac: ad3552r-hs: clear reset status flag
Message-ID: <20250112150404.6ffb7160@jic23-huawei>
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-2-ab42aef0d840@baylibre.com>
References: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
	<20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-2-ab42aef0d840@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 11:24:14 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Clear reset status flag, to keep error status register
> clean after reset (ad3552r manual, rev B table 38).
> 
> Reset error flag was left to 1, so debugging registers, the
> "Error Status Register" was dirty (0x01). It is important
> to clear this bit, so if there is any reset event over normal
> working mode, it is possible to detect it.
> 
> Fixes: 0b4d9fe58be8 ("iio: dac: ad3552r: add high-speed platform driver")
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Ah. I should have checked for newer versions. Anyhow, picked up v2 of patches
1 and 2. 

> ---
>  drivers/iio/dac/ad3552r-hs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 216c634f3eaf..8974df625670 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -329,6 +329,12 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
>  		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
>  			 AD3552R_ID, id);
>  
> +	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
> +	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
> +				      AD3552R_MASK_RESET_STATUS, 1);
> +	if (ret)
> +		return ret;
> +
>  	ret = st->data->bus_reg_write(st->back,
>  				      AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
>  				      0, 1);
> 


