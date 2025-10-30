Return-Path: <linux-iio+bounces-25636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20B8C1EBCA
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 08:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A50640200C
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 07:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC05336EF4;
	Thu, 30 Oct 2025 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRes+EpO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A0336EDE;
	Thu, 30 Oct 2025 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809107; cv=none; b=VzawoC7FKcijDAGSQfu013qrzFDvxJ5mUjzCqRVrpO+eBpLosJfBkXuiviFjK3b0r2qeCOSzWynpN2R4SB7iFqonFRWzqhOhUdDbfuFhHpKsWZYNpfn98xWzDgGovlpYxSXrOf1HxlYtaPHUdNcLRU/X1k392SV2lB+N22LDIaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809107; c=relaxed/simple;
	bh=0rIugVszyT34QGRppHHd9SZR9iNqZFH+IuaNiT3T9+8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SvGCw0zIpbRLe9LYVfxJeAP9fClBCsGB63ELz7EZ5MWD3Eosq5vRuN+2ltaVq8xhr5+cKwXdtxSPlWIhrogKbb93nv9+PyOu0v0qhHRdpmhbWAhSuZwXdoIovze8UFXK3KgyEFQilWdh79STRSJYseWlEx+M0GCJ1qjY4G7D+Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRes+EpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82701C4CEF1;
	Thu, 30 Oct 2025 07:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761809104;
	bh=0rIugVszyT34QGRppHHd9SZR9iNqZFH+IuaNiT3T9+8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=BRes+EpOEwjryV0Z8sofpJLsQT18kgdgVRmN0yF7WYWYjOqslFATDklrk7PMRbSr9
	 iSOs6bU7aSsc2JDNXNlnxaazpGbttXSYTDuSXVG0BxWn91fQdrE1jScQNOwK/NFx+2
	 oDnz9NsxyaVOqfcNuCwKDAqouFNG1qIzV+5j6j2DmJQ2YO4mAC7bCTu6JvldluiQZp
	 DUgaczZnA9YZfXjPMdGpDP472EbCVWbbefGyks3zxWA5Grlk92hjsULkokfKYO6FFi
	 WDjtcJ/2g0RGLVzBMBpeW9zsG4NEqaAyU4YYtarexsUMAYTaXasfsBwXwakl12ZlAT
	 YgOi5KjpIdvxg==
Message-ID: <b573d80c-bd93-4592-86b4-e6c398d5862e@kernel.org>
Date: Thu, 30 Oct 2025 08:24:59 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v1 1/6] media: vidtv: Rename PI definition to PI_SAMPLES
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
References: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
 <20251027143850.2070427-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
In-Reply-To: <20251027143850.2070427-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/2025 15:34, Andy Shevchenko wrote:
> The definition of PI in the driver is not the actual value in radians,
> but rather degrees. Since we are going to have a value in radians
> defined in a global header, rename this definition to avoid potential
> collisions. No functional changes.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>

Feel free to merge this through a non-media subsystem. If you want me to
take this as a separate media subsystem patch, then let me know.

Regards,

	Hans

> ---
>  drivers/media/test-drivers/vidtv/vidtv_s302m.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/test-drivers/vidtv/vidtv_s302m.c b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
> index 9da18eac04b5..b3217d643b1e 100644
> --- a/drivers/media/test-drivers/vidtv/vidtv_s302m.c
> +++ b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
> @@ -45,7 +45,7 @@
>  #define FF_S302M_DEFAULT_PTS_OFFSET 100000
>  
>  /* Used by the tone generator: number of samples for PI */
> -#define PI		180
> +#define PI_SAMPLES		180
>  
>  static const u8 reverse[256] = {
>  	/* from ffmpeg */
> @@ -259,10 +259,10 @@ static u16 vidtv_s302m_get_sample(struct vidtv_encoder *e)
>  		if (!ctx->last_tone)
>  			return 0x8000;
>  
> -		pos = (2 * PI * ctx->note_offset * ctx->last_tone) / S302M_SAMPLING_RATE_HZ;
> +		pos = (2 * PI_SAMPLES * ctx->note_offset * ctx->last_tone) / S302M_SAMPLING_RATE_HZ;
>  		ctx->note_offset++;
>  
> -		return (fixp_sin32(pos % (2 * PI)) >> 16) + 0x8000;
> +		return (fixp_sin32(pos % (2 * PI_SAMPLES)) >> 16) + 0x8000;
>  	}
>  
>  	/* bug somewhere */


