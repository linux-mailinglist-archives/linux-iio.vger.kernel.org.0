Return-Path: <linux-iio+bounces-17682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09887A7CEF2
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 18:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6450F16A5C0
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1702714B950;
	Sun,  6 Apr 2025 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="lKxtG0ei"
X-Original-To: linux-iio@vger.kernel.org
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E90C4A24
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.137.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743956783; cv=none; b=P7nt16in3yj/uGDL4j/8UvimrsgccA9XPrFnG0kkpClbiuWrnvK8nawknAGmdCmojvpgJwVDM9TOhrcNHH9KxKf3l+/29TiyqrxSGzCSxmA+ZYxVyBLBNWv7kb8FgGs+otJnqNIrt7TV9WcSoVaMj/Wr+Ic8KmtPt28YG4PhKjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743956783; c=relaxed/simple;
	bh=hz44YyBR0q+IQGl67whPQcX859csJpyCtxNVO04l+2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnVXNZKnhIflIaadI2FhjO4iovYMM17chNsY3RiiCGE+eoivVDgSN+WPgikZtDr6sZSLTO8OvioPc1KRMQHlMgCf3rRG7NM/wufM0KXldXZjsZf3nzKceu+2gHykDbEl7WrGRRwFpFXTviBRqwq7H4SFcaYu5/260D+ktzoWgow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de; spf=pass smtp.mailfrom=metafoo.de; dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b=lKxtG0ei; arc=none smtp.client-ip=78.46.137.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metafoo.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
	s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Y0fqiDqo9X7eM+GvbseOkQsGk5mucFYk7ErarvvkFgs=; b=lKxtG0eiOvURjHEKLlUIblIweP
	K5bLttlSLJ9nXpHMCP9kMOozUdQTOuI86WR4M4mkgdAIit9rxyQKyYD+dsB5azImNX5YH+s+n9KYA
	u3qz2JbzT4L4bGkExe+wh2vmsEUbD/tqjsBi3K+Al/ndueQyVHNk6X80erUVoA7tV3c5h9LCFuPnS
	Yycjw+9pPBT6mbmDTavJTy68M7QO67oHqB3Zw8ArP/LPVyyI0YAIAdekQyRVB2o3YOYdMYzmFHGAi
	m64iR6hDSi7YBsPJZ3k12ECsKdDGFpXVDEcDB0YLxh03rI6sCsKY8m425FFrRA9+uu5TKgskdXldQ
	6r/ubGGw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <lars@metafoo.de>)
	id 1u1SR5-000Br9-1j;
	Sun, 06 Apr 2025 18:01:27 +0200
Received: from [136.25.87.181] (helo=[192.168.86.26])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lars@metafoo.de>)
	id 1u1SR4-000FRJ-37;
	Sun, 06 Apr 2025 18:01:27 +0200
Message-ID: <2e68dbb9-7df5-43ea-a523-5164fddb7a15@metafoo.de>
Date: Sun, 6 Apr 2025 09:01:24 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: IIO: Update reviewers for the subsystem
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250406153120.2129133-1-jic23@kernel.org>
Content-Language: en-US
From: Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20250406153120.2129133-1-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27600/Sun Apr  6 10:29:47 2025)

On 4/6/25 08:31, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Lars-Peter has not been active in IIO reviewing for some time. Without
> David, Nuno and Andy, along with many others who review IIO patches, I
> would not be able to keep up with the rate of change and would have
> become a bottleneck to development.
>
> Hence update the MAINTAINERS entry to more accurately reflect reality.
> This is not intended to give the 3 of them any more work or to oblige
> them to review any particular series, so if there are any series waiting
> a long time continue to poke me via the list.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

At least I got to review one patch :)

> ---
>   MAINTAINERS | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 559620786634..0762170e9740 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11518,7 +11518,9 @@ F:	drivers/iio/common/scmi_sensors/scmi_iio.c
>   
>   IIO SUBSYSTEM AND DRIVERS
>   M:	Jonathan Cameron <jic23@kernel.org>
> -R:	Lars-Peter Clausen <lars@metafoo.de>
> +R:	David Lechner <dlechner@baylibre.com>
> +R:	Nuno Sá <nuno.sa@analog.com>
> +R:	Andy Shevchenko <andy@kernel.org>
>   L:	linux-iio@vger.kernel.org
>   S:	Maintained
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git



