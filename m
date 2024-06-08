Return-Path: <linux-iio+bounces-6083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8E0901329
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 20:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD991C20E9B
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 18:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783201CAAD;
	Sat,  8 Jun 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pI1G8e4R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C4C1C2BD;
	Sat,  8 Jun 2024 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717869968; cv=none; b=MRayvKAYH98ajUUnyer6ikP1sfltfZrkvMx9mOePAy8l2jQYQEEmerk3sNuKTk3TtAA3AwA/TRqXyxGuq2re/rysDDBNrl0LzgicAjwyYOkzMSIcYEmKgVUtt2WC+4K2fjAxsUjV/tfM32YuIwEt4CHss5s6K6QUMHrsqx1nNdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717869968; c=relaxed/simple;
	bh=lkZe0nZhvWF0Nm8oZxgbBtz8kQqTGMv4JWMHvMMB8WI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVJFOEnx0ob/FWjHHOt3ePweldcBTIyyTgpnHHubyJO5c2hPK2TMttLOR4eVhDZO0bDvhVtrMakq8JT8Fm5QD3w5wNdeXAAW2XD0LBBSpE82t+tedLe5Yeyp5I/KHdyh59hI96bl5xnO3voI7RE/IaGBBeO7ru1QBzndsPCIT6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pI1G8e4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3482C2BD11;
	Sat,  8 Jun 2024 18:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717869967;
	bh=lkZe0nZhvWF0Nm8oZxgbBtz8kQqTGMv4JWMHvMMB8WI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pI1G8e4R7WTm65VnBEcjWAvTup4XKR4phr6NM/ZpBB3ZguoIf7Tz24uZc3CL5bOrG
	 1BkFWVnrByOlpWaIHguVCRDoxGiLBjBQ03ramcikt/kucbCnsUvJ8KwIm7goRv70mt
	 91NPKFDnO9JaBfAIUKnrvG0wv8TNUtzo/DodmCY+rzvLpf7BUtzMhJDmECfyHVz8oK
	 dCmG5T9wd+WU5bmqwZAstQs4BoZV9hiNZLY7IslmKbK8SJnVuGs+A2UwX+Q+eQCbd5
	 XSmg9tSNz6Myqz7iECeXm8csrGdQf54uL9Uv1ECh09OWr4lMk7zW//fDAkfvQj7yZp
	 hunsgbgUCYEZA==
Date: Sat, 8 Jun 2024 19:06:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: Petr Mladek <pmladek@suse.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Jyoti Bhayana
 <jbhayana@google.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, Chris Down <chris@chrisdown.name>,
 John Ogness <john.ogness@linutronix.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, Andi Shyti <andi.shyti@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] iio: temperature: ltc2983: convert to
 dev_err_probe()
Message-ID: <20240608190600.622dfd7f@jic23-huawei>
In-Reply-To: <20240606-dev-add_dev_errp_probe-v3-2-51bb229edd79@analog.com>
References: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
	<20240606-dev-add_dev_errp_probe-v3-2-51bb229edd79@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 09:22:38 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> Use dev_err_probe() (and variants) in the probe() path. While at it, made
> some simple improvements:
>  * Explicitly included the err.h and errno.h headers;
>  * Removed some unnecessary line breaks;
>  * Removed a redundant 'else';
>  * Added some missing \n to prink.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---


> @@ -1296,8 +1268,8 @@ static int ltc2983_reg_access(struct iio_dev *indio_dev,
>  
>  	if (readval)
>  		return regmap_read(st->regmap, reg, readval);
> -	else
> -		return regmap_write(st->regmap, reg, writeval);
> +
> +	return regmap_write(st->regmap, reg, writeval);
>  }

Unrelated.

Otherwise updates look correct to me.

