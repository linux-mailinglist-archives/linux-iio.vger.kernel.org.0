Return-Path: <linux-iio+bounces-25357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A072BBFDAAD
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 19:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFC054F5A02
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57602D838C;
	Wed, 22 Oct 2025 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wgeqf0sg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154622C1598
	for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155079; cv=none; b=m6sEBc49oXZocmz5T6pLq2J7a+bZDk1PKnyIrivpPKrln0Qk9b23FCSlqmaMpZWLPji3xXTHU3kMFT9+3XzWQ2TfUMjoX8lxjYWgDt6uH80HzzsXh/WI46pqWSLr9rB1IBT1gd6O8UKb7N9SGsDcchGh6COHlFxGX0Fudd5rcLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155079; c=relaxed/simple;
	bh=kteB4/kowIdy/psXHbTb/iM1rYQtzQ7WD8JWMn5hIWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ay2KY/yVHpXLuRYzTNBNW6wKqiVazknCVkJsPSD5mftnl3d0dOp2cWLajgSKCHUEzB4Q5KGDiZFb9BQ2H8r2sGPgvxWkoX+Gumrev+VH9bErXKqiBjURHaIYomriLldckZfG63jL/Q94i4cecXsF0pojGXsIMv+g75FrO0QimdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wgeqf0sg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-269af38418aso89717935ad.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761155077; x=1761759877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4fm2E82WNhrm3YM/PP7dtOHOzOR89sCiQPNNmL9tQ0=;
        b=Wgeqf0sgiIurA3NYFPA6lyZc3Imbfxak793ZQCJkkRlDAfnuryToVSR64HvZpAWqJf
         YFQE7+RNuYVbcioxbFAeXMg0bTqnfViPyxBPMLp6Sk403daaFXc1Iz/1oxg6vq5goiuP
         qzSCPBB2Jv/9WXkbGmVifE3hEYZ9wFMoXYTcSnVsYvF82ei3t5vQtHwZvWJP0QUYhufI
         ea5eeOQSXpZz+2oZh3w4M0u08jKQJXcynzbGOegogwJhMCfknTsRCT5WoZusezvTTu1B
         IngnuB0nvOV4nVSSpmM8Mtk4FgylyBnlh0M+ft7MZCei5rPxB7CJX1UM9k0qpK7krEhl
         aong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155077; x=1761759877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4fm2E82WNhrm3YM/PP7dtOHOzOR89sCiQPNNmL9tQ0=;
        b=HZuYz21fpaZzd7dl4NTKdsmxheIjdJMVMfMHKTy2LQvk3t3X/2o+D2+AgHcGRAl9GV
         4fvHXC4t1umM4THF2+qltYUzD+9q05yTr+ARuRBTgYzDarTaoUfn2Ds0k+NXG7+Mon4T
         9ntoy9r4kqXnBDe9Da5cagk+spIK1cRY1+AQveTxkv6K3zafAvmJOx0NPz1cia6B0YR5
         53sEP3wEEClMKEALU/5ZlvPuP6ogn/AIrV/hSkaoIaQmKcZJ3tdwTT6tkL89iubfTSsR
         ZzAc/qW7QPK9WljtAaD09fbEmA/ilnA3d28wEFTFNrRLVKCXdq4bJ1Zj/kRBxud4/3/k
         n2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVCLawd2cepIGoArBuLzT3oy1ltFkwgFpCLZuMF0vUj22mY+7wUFrTWKI1KDyxw79IxQHwDRFnuf0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRp4gW1jESy7YkDurxr8WkdkYA8QjN9/SY6ot4nzt9+I6FNY6n
	QMpIqMNXn3Lj2deWaSp8LQ0FURP+DxkMRNHkC+1UKpdZfk1tUXT84i/t
X-Gm-Gg: ASbGncssWH2QT/W5arvl1CdSxP1Xa9TXqQMOxOQWH4jf3r244NswnHgyqOJF6vpASdw
	cbOzPi3fb9cndhYhcvd8CAWCb1BBWyzXMWlSDnUpT5ExfQ6kk9xa3L4Qb1uWvhFlxB/5qySK4e2
	QVbu+VwLjN1F/lOKoDbKn6IMwgT6JGsw54fLWCgkfdwqckucv74TAkFQaXr9E6/OtCZpC2Ezx9b
	ZckUO0wVlZjCxW1owl+GcTOZ6kpUFScuJvHGgwxp6YhMqjMwBhP8FrMPAsYuyGgVnjrKttMAS3H
	e/wziwISwSSUeXkcauyv8yY2bdUgI1S4ftVQ2etz5i9RYKG9QaJmSDguBvx7PxnmIoowlkcdr3F
	P1ghrtLsmDPRimpVwhFyh4oCH2T7hsOxygY5WlZadJzlf5X1r7IPJCHmVzJoJorBoCa9nsC7a2/
	OYHAlEb7w=
X-Google-Smtp-Source: AGHT+IGsPd7tAcbXciC8cZDKS+Q/IPC08WB35QvRczlMiT5YvcYcsO56X0YyF/47BabAc9lZEp8wJg==
X-Received: by 2002:a17:902:dac9:b0:28e:9427:68f7 with SMTP id d9443c01a7336-290c9c8a5c1mr274258545ad.6.1761155077199;
        Wed, 22 Oct 2025 10:44:37 -0700 (PDT)
Received: from localhost ([177.107.85.169])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-292472193acsm144358865ad.108.2025.10.22.10.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:44:36 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:45:43 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] iio: adc: ad7124: fix possible OOB array access
Message-ID: <aPkYR_Y8XtTw-iT9@debian-BULLSEYE-live-builder-AMD64>
References: <20251022-iio-adc-ad7124-fix-possible-oob-array-access-v1-1-2552062cc8e6@baylibre.com>
 <aPkMLUhm_UAVzRSA@debian-BULLSEYE-live-builder-AMD64>
 <49c09806-0f58-4d1d-aa0c-4351fc3e7089@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49c09806-0f58-4d1d-aa0c-4351fc3e7089@baylibre.com>

On 10/22, David Lechner wrote:
> On 10/22/25 11:54 AM, Marcelo Schmitt wrote:
> > Hi David,
> > 
> > One minor question inline.
> > Nevertheless, the fix looks good to me.
> > 
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > 
> > On 10/22, David Lechner wrote:
> >> Reorder the channel bounds check before using it to index into the
> >> channels array in ad7124_release_config_slot(). This prevents reading
> >> past the end of the array.
> >>
> >> The value read from invalid memory was not used, so this was mostly
> > What is considered using the value in this context? (see other comment below)
> > 
> >> harmless, but we still should not be reading out of bounds in the first
> >> place.
> >>
> >> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> >> Closes: https://lore.kernel.org/linux-iio/aPi6V-hcaKReSNWK@stanley.mountain/
> >> Fixes: 9065197e0d41 ("iio: adc: ad7124: change setup reg allocation strategy")
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---
> >>  drivers/iio/adc/ad7124.c | 13 +++++++++----
> >>  1 file changed, 9 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> >> index 9d58ced7371d0af7004a81153888714e9795d4f4..ed828a82acb71342fb2eae27abfbbd86861cba53 100644
> >> --- a/drivers/iio/adc/ad7124.c
> >> +++ b/drivers/iio/adc/ad7124.c
> >> @@ -586,13 +586,18 @@ static int ad7124_request_config_slot(struct ad7124_state *st, u8 channel)
> >>  
> >>  static void ad7124_release_config_slot(struct ad7124_state *st, u8 channel)
> >>  {
> >> -	unsigned int slot = st->channels[channel].cfg.cfg_slot;
> >> +	unsigned int slot;
> >>  
> >>  	/*
> >> -	 * All of these conditions can happen at probe when all channels are
> >> -	 * disabled. Otherwise, they should not happen normally.
> >> +	 * All of these early return conditions can happen at probe when all
> >> +	 * channels are disabled. Otherwise, they should not happen normally.
> >>  	 */
> >> -	if (channel >= st->num_channels || slot == AD7124_CFG_SLOT_UNASSIGNED ||
> >> +	if (channel >= st->num_channels)
> >> +		return;
> >> +
> >> +	slot = st->channels[channel].cfg.cfg_slot;
> >> +
> >> +	if (slot == AD7124_CFG_SLOT_UNASSIGNED ||
> >>  	    st->cfg_slot_use_count[slot] == 0)
> > Wasn't the value potentially read from invalid memory used above?
> > It's fixed now, so I guess there's no point in nitpicking on that.
> 
> This code was unreachable with an undefined slot even before
> this change because of the check to channel >= st->num_channels
> before it.
> 
ah, got it. Duh, should have realized channel >= st->num_channels always true
for the invalid access case.

Thanks

> > 
> >>  		return;
> > 
> > Best regards,
> > Marcelo
> 

