Return-Path: <linux-iio+bounces-14263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2D8A0B1BA
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 09:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB1218863B7
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 08:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8039C23497B;
	Mon, 13 Jan 2025 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU4RTToS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E99518A6CF;
	Mon, 13 Jan 2025 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758305; cv=none; b=hWQZz2Lg1szHRDbrVVAi+T4jJnllAH80pRSVFA4KkqYRjxmYDL2tA9hSCUWKm1KAY6/OHncAt+8SmF9vhNVcwi5O2Cv3YiE9RZ48p5O48/BQkxsrAgwv+cuu8NyAxQ0jv5qLB+eHrbhk2bopIYTf/oWIQTpP0dBDqHiOhGtNc6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758305; c=relaxed/simple;
	bh=R8ygc5Gstv3PS1qdjeaxjpSIh4lZSioldTZUPlpp0y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edLCnHOqgdUUv+dJPcw4JEDJWEGspwM2B+5lNDZypBLXLU6n+xkCIDZYkhjFfxYArnQp0q0gN8DLzS/YRHfVGq2r5zO46JXnuGhxEXSOa3WRR/sxYx5rB2of2Vpw1IS21NA4AwyS4IEDiyIfX21jvn70JFZoel3XfAAX613fx7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU4RTToS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01660C4CED6;
	Mon, 13 Jan 2025 08:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736758304;
	bh=R8ygc5Gstv3PS1qdjeaxjpSIh4lZSioldTZUPlpp0y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QU4RTToSzRVClYW9CB6Mo060F2sgCbInFvA2EcnTJaP0gtEbGimcSzU5MGCUFuiRy
	 gFIAYUEwAI/cbaDXeKZNTqI89MYhko7vxRyg9oRQ86FmXGOKFSUHEV3itHNKlOCSCP
	 Mn9+502YPku/Mswt910z1vqSOy3ypYzDNlNopqeKQIOXbMcGf9+4ZGWasjx+1WyRmt
	 DtXVvaHaA3GGJJ2pdI6DjW/95HkRdKJ6KJdOYkjfbi0+9VwUHVsnIfEk9GVqV8Vm3Z
	 Ew+S+7dC7+RWhEXsTfjGHEpRk8VPtjcKjehfpoz0Q2Suij09cKbl87RUy7MGW9U5Yi
	 pe5bdd2epGdAQ==
Date: Mon, 13 Jan 2025 09:51:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasiliy Doylov <nekodevelopper@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/5] iio: accel: mc3230: add mc3510c support
Message-ID: <vad4luqvwrvivdd4mmr74564iz473gzgyoadkkncjntu563qb3@7ofgqwxdvaxs>
References: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
 <20250112-mainlining-mc3510c-v3-5-9ee6520ab69d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250112-mainlining-mc3510c-v3-5-9ee6520ab69d@gmail.com>

On Sun, Jan 12, 2025 at 03:25:39PM +0300, Vasiliy Doylov wrote:
> This commit integrates support for the mc3510c into the mc3230 driver.
> 
> Tested on Huawei MediaPad T3 10 (huawei-agassi)
> 
> Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
> ---
>  drivers/iio/accel/mc3230.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> index 1b58f3ea50655b6563a78a2531b16a8088e8f8d5..92934975edc77b11ed6dc3da077a28d317314fab 100644
> --- a/drivers/iio/accel/mc3230.c
> +++ b/drivers/iio/accel/mc3230.c
> @@ -46,6 +46,14 @@ static struct mc3230_chip_info mc3230_chip_info = {
>  	.scale = 115411765,
>  };
>  
> +static struct mc3230_chip_info mc3510c_chip_info = {

const

Best regards,
Krzysztof


