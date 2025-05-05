Return-Path: <linux-iio+bounces-19091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00962AA92CC
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 14:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3EC218994A0
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 12:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FD9231C9C;
	Mon,  5 May 2025 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUZZn/BC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125B4230D35;
	Mon,  5 May 2025 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746447352; cv=none; b=cYNa44233cHxFnbb1KB7GFhs9KQ6EVUHe3zJMj0Xfz7Q/fYbCXzyXZiY8a3zZnLkUtiYfaSQi/gcFUKSZbZj6ZueZMeuzrCSN9XrX9QMyWp/3FG4VWjvCDh9EQQg7vBw4VuYEykO74ntLRkUxBaXAVVwa2I0H4urqw7biL3r3gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746447352; c=relaxed/simple;
	bh=8HcZtQz1mapFyWoKYVTxOoPRxBF6cFTSSmO5hGEgwm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHabDTxc1/tYu4jnLU3F9tjuZAXIHdVg367vStneke5A6Ky4GfKBeC0q8NdpGUdPfEFQuKAI2HJKcjpN8IEWUU+9cA7Hp1oyUTMAh/Dl0gaiDebpP2w0vgDXMQvmXqujRwIlTne1IYLaMQnm9IMaIRyJflTgjPedVXL4v+Ron9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUZZn/BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D187AC4CEE4;
	Mon,  5 May 2025 12:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746447351;
	bh=8HcZtQz1mapFyWoKYVTxOoPRxBF6cFTSSmO5hGEgwm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qUZZn/BCagIKPJ3HpU8S1QJtkEhQblDG/Cz6F+DyqGUhWr160HM0Drk7zRivbxzEE
	 BQv97MjSsBHOUq8t7tk/IYCDbtjzG6r4NvTUGMRWpHtkJlNx18oIPR+rO+OTPPo5px
	 wUNplKFuZ9Ib/4hkybtOLJcB/FniSsMzoGUVToNJ69IPnx9md1nmD7DR2TFX6Xlb+3
	 HCoizfD+ZmdIyth0dyDwZ066fczAXb8ij/qPlgYwDR2EEEVHKaMm9+WfrOXexbdAUz
	 vBZg5tROHQMT3c1Q1q2k7dEZMzVCBczLp1cTtyAYTI8/rY1KDLZfyd1TXh4sgUkfZs
	 HR7jB4vPCrfWw==
Date: Mon, 5 May 2025 13:15:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Beniamin Bia
 <beniamin.bia@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: ad7606: fix serial register access
Message-ID: <20250505131544.0a7477a2@jic23-huawei>
In-Reply-To: <o3jxdmchpmn5edbeznqecslkw4tnrdei4qqnb66oyyqeizavmg@5uke2kr4hte7>
References: <20250418-wip-bl-ad7606-fix-reg-access-v3-1-d5eeb440c738@baylibre.com>
	<o3jxdmchpmn5edbeznqecslkw4tnrdei4qqnb66oyyqeizavmg@5uke2kr4hte7>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 May 2025 13:35:06 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> Hi Jonathan,
> 
> any news on this patch ? I would need it to proceed on other new ad7606
> features, 
> 
Oops. I applied this and marked it as such in patchwork but didn't
reply to the mail. Sorry!  It was in the pull request Greg took last week
for fixes but hasn't quite made it to upstream yet.  

Just list it as a dependency in cover letter for new feature patches.

Jonathan

> Thanks a lot,
> angelo
> 
> On 18.04.2025 20:37, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Fix register read/write routine as per datasheet.
> > 
> > When reading multiple consecutive registers, only the first one is read
> > properly. This is due to missing chip select deassert and assert again
> > between first and second 16bit transfer, as shown in the datasheet
> > AD7606C-16, rev 0, figure 110.
> > 
> > Fixes: f2a22e1e172f ("iio: adc: ad7606: Add support for software mode for ad7616")
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> > Changes in v3:
> > - fix typo in commit descritpion.
> > - Link to v2: https://lore.kernel.org/r/20250418-wip-bl-ad7606-fix-reg-access-v2-1-8b1ade67e185@baylibre.com
> > 
> > Changes in v2:
> > - improve bug description.
> > - Link to v1: https://lore.kernel.org/r/20250417-wip-bl-ad7606-fix-reg-access-v1-1-0ce341f3cfc3@baylibre.com
> > ---
> >  drivers/iio/adc/ad7606_spi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> > index 997be483ebb93293481b922e13ece4edb47e940a..bd05357a542cf7234d5bb6b718829d6b720262cd 100644
> > --- a/drivers/iio/adc/ad7606_spi.c
> > +++ b/drivers/iio/adc/ad7606_spi.c
> > @@ -103,7 +103,7 @@ static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int addr)
> >  		{
> >  			.tx_buf = &st->d16[0],
> >  			.len = 2,
> > -			.cs_change = 0,
> > +			.cs_change = 1,
> >  		}, {
> >  			.rx_buf = &st->d16[1],
> >  			.len = 2,
> > 
> > ---
> > base-commit: 8dc6b228d746b1a900bed28568defb2266fa4c43
> > change-id: 20250417-wip-bl-ad7606-fix-reg-access-729c21478d1f
> > 
> > Best regards,
> > -- 
> > Angelo Dureghello <adureghello@baylibre.com>
> >   
> 


