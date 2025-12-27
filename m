Return-Path: <linux-iio+bounces-27367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F036CDFEAE
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 029E63010AA7
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 15:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FF2263C7F;
	Sat, 27 Dec 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL41XJPA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083D73FFD;
	Sat, 27 Dec 2025 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766850936; cv=none; b=QQmSPAwrdQcJw1QN/XWu7e7vob9YfnMFA5tw3IeyK1fauBVYrjjQpFupaAIFur2EbS2cZjn/X2L6Uy47n0TiobxkJJT9YS0R3r989CwAqW1giLWbTSlgVjOytGuXDKFXGSYd3RKDl06NWl++K4+CFAiw1qlarruzrYLfXJDP+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766850936; c=relaxed/simple;
	bh=Kl/7xxvBstaH0Xn6m52c1MEEPvuxhhjl9pM+od8b+go=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9Ed9iQTBB2r/qeqGK7PsDqzgu6S1Ix58IHXnM2mNY7MvQSPUagSYNFd/sN06W/R7HTNULPqhl0bOXc3xSWsGhYFEUh2BbcMzcOy/0f4su/1f8pIPHX/HaM7+9qAebWwQHvRMXN11Y1IXBFdl3m3tRdmCuA5QKK3KyAu22SwIio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LL41XJPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9C7C4CEF1;
	Sat, 27 Dec 2025 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766850935;
	bh=Kl/7xxvBstaH0Xn6m52c1MEEPvuxhhjl9pM+od8b+go=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LL41XJPAJH99cv4UPjLpWdJtk+fdKMWTArXake4XT0FXwCnh1EqlEdmgvrwmnrjna
	 2AwMwO1ZW8XV+pi6kn7OGGgZHqnMceB6imEyj6GNDjQJLupKINx++VClusoBUzQiYI
	 pO4m5qrVDn7w23B6MoZrDBNM3vE0D3/9z/DY2jK0H5w5AaJOHxXWR9roqbu4jO76MC
	 tWafIBtOFNzSa6/cRBnmrwvJ4eZvnT8zu7UPXOTgODWxlfO7LLWUEiMZ89g/pbL2eb
	 hrybfC4sBa2sr68LVFjozYN+NSO/U04y/5lr9JvbHi2UEGgIxda6EfjjXH4TU0hasl
	 FrDK0KCazjwFw==
Date: Sat, 27 Dec 2025 15:55:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jonath4nns@gmail.com>
Subject: Re: [PATCH v5 3/5] units: add PERCENT and BASIS_POINTS macros
Message-ID: <20251227155525.6d712f42@jic23-huawei>
In-Reply-To: <43504217d5b3c32da946bed0ce4d81e216f7c7c7.1765900411.git.Jonathan.Santos@analog.com>
References: <cover.1765900411.git.Jonathan.Santos@analog.com>
	<43504217d5b3c32da946bed0ce4d81e216f7c7c7.1765900411.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Dec 2025 02:52:45 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Add macros for percentage related units, with basis points defined as
> 1/100th of a percent. Basis points are commonly used in finance and
> engineering to express small percentage changes with precision.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v5 Changes:
> * Included PERCENT macro along with BASIS_POINTS.
> * Adjusted commit description and comment in the code to add more context and
>   examples.
> 
> v4 Changes:
> * New patch.
> ---
>  include/linux/units.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/units.h b/include/linux/units.h
> index 00e15de33eca..9c2fbcf04c81 100644
> --- a/include/linux/units.h
> +++ b/include/linux/units.h
> @@ -21,6 +21,20 @@
>  #define PICO	1000000000000ULL
>  #define FEMTO	1000000000000000ULL
>  
> +/*
> + * Percentage and basis point units
> + *
> + * Basis points are 1/100th of a percent (1/100), commonly used in finance,
> + * engineering or other applications that require precise percentage
> + * calculations.
> + *
> + * Examples:
> + *   100% = 10000 basis points = BASIS_POINTS
> + *   1%   = 100 basis points   = PERCENT

I don't understand the final equality in these examples.
The top line is as it says 10000 basis points but you have it equal
to BASIS_POINTS?  

> + */
> +#define PERCENT		100UL
> +#define BASIS_POINTS	10000UL
> +
>  #define NANOHZ_PER_HZ		1000000000UL
>  #define MICROHZ_PER_HZ		1000000UL
>  #define MILLIHZ_PER_HZ		1000UL


