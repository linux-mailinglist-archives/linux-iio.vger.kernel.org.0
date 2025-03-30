Return-Path: <linux-iio+bounces-17366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD95A75B61
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B54A188BBB8
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED11D7E57;
	Sun, 30 Mar 2025 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+24Q5v3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D00235973;
	Sun, 30 Mar 2025 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743355590; cv=none; b=KZ/ilMLlpG1pBzI3h6lpPh/2xKR4Eq/yV94MZ2jPQKmFSOanjZHTPBWBqB7JiZzHZU7XtAbYSYKn7C89nguvPQsa8J681QdML2C6IZeCVj/4dXXxHGPcNZ17SxFv2YHPJmkMcpUMK8mMn+nUhale8zdkYlwEn7c/T//3GUS/VAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743355590; c=relaxed/simple;
	bh=jdL58PCllKHBIvS44vFW+1+R0r+CF7p06KsU5L/lG5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNSmiPrYDULvRq/YOjS+5w+BINYJiKgw3dpe5lus+GdamMw8TEJ2CAtLmwAga8gyAN4Qj8snL9swZcdOybZN9DUSG0pGD3Pb49wy+sRid3hmwIlN495DJHqYojh/kPf7Ix0hgHQBKzKalckzpVCp0yeEiIgz6J5IFe8hsHvwIuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+24Q5v3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF20FC4CEDD;
	Sun, 30 Mar 2025 17:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743355589;
	bh=jdL58PCllKHBIvS44vFW+1+R0r+CF7p06KsU5L/lG5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M+24Q5v3TXulsdOSlWWjR+Bu36AEq/frEWHHnu2N3ukr7P4afqH6DeWRdrKbiqP/l
	 fkFzPjJ9plf5mkALm6ETWIUHPRIIkhMe34l7lFkCIWn996nshiKOQX3BBBRZP+xHR6
	 8m7wv3cae1zRDMR2MpFnitdfckugePxdPDc5uRlwMk0/Smm03W+IT/e7036k3UinuY
	 djr5vo84aW8Ac0+7uU6yD/AVZQW7Bev1zmvkmB8uBq34WG1DaUi9asRlaGkUzjX8GC
	 fTbgdfHW+hq0Gq19uwRTFs9vkDoNykYAGRDY0tRsZivOp0l6hQfDB2hJvccAVGDwxZ
	 2MSSqL8wKSVSg==
Date: Sun, 30 Mar 2025 18:26:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] iio: light: al3010: Use unsigned int for the
 indexing
Message-ID: <20250330182622.7cb826d9@jic23-huawei>
In-Reply-To: <20250319-al3010-iio-regmap-v2-1-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
	<20250319-al3010-iio-regmap-v2-1-1310729d0543@ixit.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 21:59:40 +0100
David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> From: David Heidelberg <david@ixit.cz>
> 
> The integer is used as array index which cannot be negative.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
I do find it hard to care about these, but you are making
other changes so fair enough I guess.

Applied patches 1-2

> ---
>  drivers/iio/light/al3010.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
> index 7cbb8b203300907a88f4a0ab87da89cabdd087f3..4c2fd88ab32cd73f4735b0fa3014af084037c94d 100644
> --- a/drivers/iio/light/al3010.c
> +++ b/drivers/iio/light/al3010.c
> @@ -145,7 +145,7 @@ static int al3010_write_raw(struct iio_dev *indio_dev,
>  			    int val2, long mask)
>  {
>  	struct al3010_data *data = iio_priv(indio_dev);
> -	int i;
> +	unsigned int i;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> 


