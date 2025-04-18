Return-Path: <linux-iio+bounces-18267-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E6DA93A2F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 17:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADD23B3A0F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342AD2144CE;
	Fri, 18 Apr 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMDUQT2I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3004213E71;
	Fri, 18 Apr 2025 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744991818; cv=none; b=ElonUwdB46vZBmM7WK2URYWXEeG4zmmjKh7PIqjRCM/BLRvdm0MyB5yHpYLrcDKc9hsJbu4OfQ4zm5vRm2gixjNjVY0yRh71HDiXjP3gHO9dZf+p52ihdRFFE0s/LJHoUTJClIAXzKc6YuX0QprUZ0Ss3b8yloTndscy+DYUnRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744991818; c=relaxed/simple;
	bh=kAkUEz69oJCELBzCTlECNHedtSRMFyPaN9/Bbtue/z4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMYIPugHFVpBFlWvcB7qSJar+KYzb+4wiUgCUwsjFTsW9Co2UQaxmVfdSZXl3mae+PQ/3fAJ2TUop8yX96vAEsJYIvfGgy6tkhVPzbZGyLSUCd31KPliRQ7lICnxVQKabDKD8W6Rd4zyzanqEgauvB4DWAKTI3ENJvyEsb+dQx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMDUQT2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183FEC4CEE2;
	Fri, 18 Apr 2025 15:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744991817;
	bh=kAkUEz69oJCELBzCTlECNHedtSRMFyPaN9/Bbtue/z4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qMDUQT2IrPcckBqQ9XeOFzjtwmXgggNvKwVsamHPO0HyjCFdc9zov8guqGIpfDIqi
	 52NKMU0BGiGE/XMLJJxCOgkGSKG+6f1955I1cHSH9F/ch8CM6uMLumM5+/Qn0YN13G
	 i0gBH2lnwdMgGb3FxoI3W345xhycOWReGMnNKeXekGW0CDvLMDc8yf9al4RXvP68ER
	 TknO7ebeAIA2+QH4aH8rmgC6w0GuCU7hXIV5rW7UPns50/O1BNq7+csp5bp2HFouX3
	 SZvitIxHV0aLabOkEcRah1g0OeskERf3/6ZrnYDj3fkt//xE0MSUTQoN3OnQF0jnr4
	 Cu68WpZC2Kcvw==
Date: Fri, 18 Apr 2025 16:56:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Beniamin Bia <beniamin.bia@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7606: fix serial register access
Message-ID: <20250418165649.64ebef8b@jic23-huawei>
In-Reply-To: <20250417-wip-bl-ad7606-fix-reg-access-v1-1-0ce341f3cfc3@baylibre.com>
References: <20250417-wip-bl-ad7606-fix-reg-access-v1-1-0ce341f3cfc3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 23:42:51 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Fix register read/write routine as per datasheet.
> 
> When reading multiple consecutive registers, only the first one is read
> properly. This is due to missing chip select between first and second
> 16bit transfer.
In what sense of missing? Given code you mean missing being unselected
briefly between transfers I think.

chip select itself is always set in current code and hence the 'missing'
description had me confused!

Anyhow, looks fine to me but I'd like this on list a little longer before
I pick it up.

Thanks,

Jonathan

> Add chip select between the two 16bit transfers as per datasheet
> AD7606C-16, rev 0, figure 110.
> 
> Fixes: f2a22e1e172f ("iio: adc: ad7606: Add support for software mode for ad7616")
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/adc/ad7606_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index 997be483ebb93293481b922e13ece4edb47e940a..bd05357a542cf7234d5bb6b718829d6b720262cd 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -103,7 +103,7 @@ static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int addr)
>  		{
>  			.tx_buf = &st->d16[0],
>  			.len = 2,
> -			.cs_change = 0,
> +			.cs_change = 1,
>  		}, {
>  			.rx_buf = &st->d16[1],
>  			.len = 2,
> 
> ---
> base-commit: 8dc6b228d746b1a900bed28568defb2266fa4c43
> change-id: 20250417-wip-bl-ad7606-fix-reg-access-729c21478d1f
> 
> Best regards,


