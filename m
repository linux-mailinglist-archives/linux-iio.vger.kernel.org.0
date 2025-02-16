Return-Path: <linux-iio+bounces-15578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A713A37565
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE10116EE19
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F921194A53;
	Sun, 16 Feb 2025 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFpuXxMd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60CADF78;
	Sun, 16 Feb 2025 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739721981; cv=none; b=FTwMcWLNwBYo5EAtbLI1LWWX1cLD3QuHUzC3YjwWK3/yDywUQvRWPql1RzSgzqn4pwoAL4sVNxBSa1a5sf/lwHD+CR3Z/pb+lL8vPaIKzeUWcp7RVo0xSmNz0l8l+oV2thoyXLDad9jKFxZZlb1xFT+3SkRzU293EMbQKmX7z+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739721981; c=relaxed/simple;
	bh=JweQu+dllQvDOaUoSvaoLQOYmVQ+Zt8DRdK2KAlrKyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeHmnm7NRQgRlSaiAutZtSSTwvHCxrD+/Rn+djhy70Ald89JCL9tonYccEDm+Wa1PkOCq3bShD+fob4G18CVlbAKrG+WGsVABUKQSCZptGW0am3FyKRfwUP7jKS8ZqEly4+bCowfZptWjJybOX9sswgxjbtjLTGEInozD14x0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFpuXxMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CD4C4CEDD;
	Sun, 16 Feb 2025 16:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739721980;
	bh=JweQu+dllQvDOaUoSvaoLQOYmVQ+Zt8DRdK2KAlrKyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bFpuXxMd5EmRAovscgx7oIkZe3CQsMaxXM76QIzvcsRMbC1wIrA5AHx+2YZUP0jkj
	 4ZxyXX1F36p4Ru2Gvc2S4/FKKwBXWoNhDfJoCF6WJ/oep8Qb+DhCkrQ9MWhxsG3X50
	 ttZQm3RAnXq6Zm3Crz8baY3sGRoqLljCQCrqILdSLES9ny+H359+WHkv4QYa9r5K3A
	 4wUbDUp+67Jt0jtqStabYM5PkT4QewHWjJ6uYzjueXSVIDYcfjH3HKVllvrYjmdABH
	 I5X9GJfvJOsqf0v8+8174LHORkJe83sJpAAH4rRvjmhrEA4gr2ANJ16CpiSLWUUkk4
	 CaJEIy71Gz7Lg==
Date: Sun, 16 Feb 2025 16:06:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <jonath4nns@gmail.com>, <marcelo.schmitt1@gmail.com>,
 <dlechner@baylibre.com>
Subject: Re: [PATCH RESEND v3 08/17] iio: adc: ad7768-1: convert driver to
 use regmap
Message-ID: <20250216160610.4cbfb73f@jic23-huawei>
In-Reply-To: <51aa3df84b50bf981bea65690d54feddd3d98a89.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
	<51aa3df84b50bf981bea65690d54feddd3d98a89.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 15:17:16 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Convert the AD7768-1 driver to use the regmap API for register
> access. This change simplifies and standardizes register interactions,
> reducing code duplication and improving maintainability.
> 
> Create two regmap configurations, one for 8-bit register values and
> other for 24-bit register values.
> 
> Since we are using regmap now, define the remaining registers from 0x32
> to 0x34.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Looks good.  Just one passing suggestion that might reduce chance of
future bugs a tiny bit.  Any bug that uses the wrong regmap should show
up quickly in testing but none the less, maybe naming can help too.

Not an important comment though so don't respin the series just for this.

Jonathan


>  
>  static int ad7768_scan_direct(struct iio_dev *indio_dev)
> @@ -233,9 +269,10 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
>  	if (!ret)
>  		return -ETIMEDOUT;
>  
> -	readval = ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
> -	if (readval < 0)
> -		return readval;
> +	ret = regmap_read(st->regmap24, AD7768_REG_ADC_DATA, &readval);
I wonder if it is worth reducing the possibility of reading the register
via the wrong regmap by changing the defintion to
AD7768_REG24_ADC_DATA or something along those lines?

> +	if (ret)
> +		return ret;
> +


