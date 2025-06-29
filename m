Return-Path: <linux-iio+bounces-21120-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 091F7AECEE1
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 19:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 362167A1EBC
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 17:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1747D22FF39;
	Sun, 29 Jun 2025 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7g6yf4j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C976249641;
	Sun, 29 Jun 2025 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751216847; cv=none; b=IK1mHwpNlBOuRcm2ID0yMmqkxNw7zHWXUbnxDu6iasdGPWarEVCp6np6blOmqiB/eiwcH/v8Nt1n4xefTItqRXpBwBUm/FJjtT5wE13ayHf2wNXD2S+jJZwlNFOJLI1vv0AwumL9lo0bce55k7uzIWA/o3mzD8+MtBTcOqFQ3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751216847; c=relaxed/simple;
	bh=VaT2VO9nDKPP2JS4Dp+XvX6jBNPRAYSmNGQGia/lTFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6noMHU3SktGRi0H27+UZpPvKPL4t770cpby8jKotK0QdP8SxiY38oolYFKEY/GiR3zvaZ8Z18PdCWDncojLDux6vc7Jqo1MfW52XCjluHaea5yUj8bNSEv9+aQknvBxATJUYpFP1dDkeXQdqmH9ZY3NeZMrhJffW8X0BNWTNgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7g6yf4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF48EC4CEEB;
	Sun, 29 Jun 2025 17:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751216847;
	bh=VaT2VO9nDKPP2JS4Dp+XvX6jBNPRAYSmNGQGia/lTFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F7g6yf4j0B9oCSYtgXNcAeawSrJC5a/2vGRorb8TGMwlkCHgRU1KTMs4z8RsB9qJ5
	 I6fhxuA1/vTIMISOgEt7cmrXljfzP0y3sPoCzY5T6nwdpNiEtzNahNHtuqNyOJ06kT
	 3PtLY6czZtXgF7QGTS+cUa2LCm82VTqsbt+frqXhovjTm7WIE6Xgg8HtYzRwadbT3f
	 42uALZUeOO3bds4tq/oTneMcde4CcKdmXNovZBGfMxo2yK7yV85ifIMrI2BB4i7VZ4
	 DX7At6XPBM9z+QvrrpgpG5WWeTNMUQIg17cbgX2mYcnb19u5nPZQ5L43aeHGSfz8Jl
	 4h3m3lee0Jnnw==
Date: Sun, 29 Jun 2025 18:07:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] iio: common: hid-sensor-attributes: make
 unit_conversion const
Message-ID: <20250629180721.32eb61b7@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-14-v1-1-4faa8015e122@baylibre.com>
References: <20250628-iio-const-data-14-v1-1-4faa8015e122@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 12:09:26 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct unit_conversion[]. This is read-only data
> so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied as seems to be 'obviously correct'.

+CC rest of the hid-sensors maintainers. 


> ---
>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 2055a03cbeb187743e687c2ce3f8a339a2bd4cfc..a61428bfdce372ea0511fb7c3e80f4c43f427eb4 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -11,7 +11,7 @@
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/iio.h>
>  
> -static struct {
> +static const struct {
>  	u32 usage_id;
>  	int unit; /* 0 for default others from HID sensor spec */
>  	int scale_val0; /* scale, whole number */
> 
> ---
> base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
> change-id: 20250628-iio-const-data-14-b3250e000af7
> 
> Best regards,


