Return-Path: <linux-iio+bounces-11512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B2C9B39E6
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 20:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1662C1C21E10
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 19:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3C81DDC36;
	Mon, 28 Oct 2024 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kg7Va6Qc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E518B03;
	Mon, 28 Oct 2024 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142216; cv=none; b=KgPcQk/RgQqEF9Wv6uFRUe7DMO1rS1xrSJLfYi1An2+GA2IYx4GTwLyKy7FaHyvZVdnb/04la02n/aeCEZ9a3jWpBIFv3pyJZ+icx9TQLN3+LEKH1YF6JcodXIvpY3R450wE9gR4PokYl3uQTWlFDHKyJoEbK5zUiqPu/CFX2tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142216; c=relaxed/simple;
	bh=9HQJv16h5LhhxIogkby1ewurJuAMF6zMm/cYD8ioHCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H313FyvsKrfONNmRSJ5dkkyJG8kSxwpW/+ILhMYQ9NmQSDbWLU7b/aJ0b8idiW2TsSchaE3XOFramRcWlQyjNtVkjqFhc6uLyI00qmdXdnZLHe+i1LOsboLvC2hkdjw6cFByONYrOdTw/Sw9v0O6rBbPjPmv3qM1DjoQmQTVcRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kg7Va6Qc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD569C4CEC3;
	Mon, 28 Oct 2024 19:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730142214;
	bh=9HQJv16h5LhhxIogkby1ewurJuAMF6zMm/cYD8ioHCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kg7Va6QcfXaTNnUc44ccKdbV3fWXzCjMMnxHNMarc+dZwCvTwq5facf942KHO482C
	 lVns3rw4iJP15JjvBCQJFPm3hDLV2L3agHrLQng59gSz+GtiHyrt4h27+rFjzh6yxh
	 Wck/sufsaatjtiXjvfubG5qnbMYJSk0Ea4ZnyoNNHVsrtMYM0OI0rJibyNYXbRg+uB
	 +25j4SSYWJHfi4GK/HJmZg1ZRXigsYGNQTCTKTsAFgupw1KZMSfUfy4F/47oVo468O
	 hDuYuomO9y0iBNmwUTnLGtFguQXcDPyqVFJSibD8HM50ayvLR7RgFeUj8xsA8mISOx
	 U1TLxaFCfFH8Q==
Date: Mon, 28 Oct 2024 19:03:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: accel: kxcjk-1013: Add missing terminator
 entries
Message-ID: <20241028190328.3b694d97@jic23-huawei>
In-Reply-To: <20241028075123.615813-1-andriy.shevchenko@linux.intel.com>
References: <20241028075123.615813-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 09:50:26 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Add missing terminator entries to struct kx_odr_start_up_time
> initializators.
> 
> Fixes: d381089dda44 ("iio: accel: kxcjk-1013: Convert ODR times array to variable in chip_info")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Jonathan, sorry for the last minute update, but it seems I was thinking,
> but forgot to modify the initializers. Feel free to fold this one into
> the original commit if you can / want to do it.
No problem. Folded in.

Thanks for the quick fix,

Jonathan

> 
>  drivers/iio/accel/kxcjk-1013.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index a6621cd69707..28ed0e09d099 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -190,6 +190,7 @@ static const struct kx_odr_start_up_time kxcjk1013_odr_start_up_times[] = {
>  	{ 0x05, 3900 },
>  	{ 0x06, 2700 },
>  	{ 0x07, 2100 },
> +	{ }
>  };
>  
>  /* KXCJ9-1008 */
> @@ -206,6 +207,7 @@ static const struct kx_odr_start_up_time kxcj91008_odr_start_up_times[] = {
>  	{ 0x05, 3900 },
>  	{ 0x06, 2700 },
>  	{ 0x07, 2100 },
> +	{ }
>  };
>  
>  /* KXCTJ2-1009 */
> @@ -222,6 +224,7 @@ static const struct kx_odr_start_up_time kxtj21009_odr_start_up_times[] = {
>  	{ 0x05, 4000 },
>  	{ 0x06, 3000 },
>  	{ 0x07, 2000 },
> +	{ }
>  };
>  
>  /* KXTF9 */
> @@ -232,6 +235,7 @@ static const struct kx_odr_start_up_time kxtf9_odr_start_up_times[] = {
>  	{ 0x04, 11000 },
>  	{ 0x05, 5100 },
>  	{ 0x06, 2700 },
> +	{ }
>  };
>  
>  /* KX023-1025 */
> @@ -249,6 +253,7 @@ static const struct kx_odr_start_up_time kx0231025_odr_start_up_times[] = {
>  	{ 0x05, 4400 },
>  	{ 0x06, 3000 },
>  	{ 0x07, 3000 },
> +	{ }
>  };
>  
>  enum kx_acpi_type {


