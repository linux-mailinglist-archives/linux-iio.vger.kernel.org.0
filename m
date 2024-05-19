Return-Path: <linux-iio+bounces-5111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93228C9500
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 16:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7046E281407
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 14:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F124AEFA;
	Sun, 19 May 2024 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1z9MtTT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850D23D96D;
	Sun, 19 May 2024 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716128908; cv=none; b=peiBhk/av2a2j4LLP7iMMkdJ9ZZTivDCXJODXpOOwUUpswHCQ9PMSRaqATyxuKnoZ9BUt5OTkGpAUUqmMX128QZU9NltBF1yRaNBQOXy+iiLMDDhWRCiJyEI3tzHQc3uHc8CFFL4t6KIXkoLTeAkwYnWUpTIZjWUocBvFC7XVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716128908; c=relaxed/simple;
	bh=cBSTNNqNP01K4/ip+KCoAdCRfvtVbABGRgJ90i9SwIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxvFytA2du0ZtXtkHdR9Ny6DyRQxuxIMRnA1/LKOcTOXiMUpq/QW6Pk7aR8RQUcex59O8FoLKADPsFRtCIWf6gO7EmlMb0gyEIjUGlpHzrqleS7IRiJ+vabDuUS4bSDLkDNNnjFDO0LHrXsBP+stS+fcTSQHHTxlv4hOK07fjpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1z9MtTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E387C32781;
	Sun, 19 May 2024 14:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716128908;
	bh=cBSTNNqNP01K4/ip+KCoAdCRfvtVbABGRgJ90i9SwIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U1z9MtTTxGwXZSkTG08z+EbXzQA57bv+iMV7Xshpaq4jQF9UQN955eC1lOQ7OKDMZ
	 5XIPeneTwlSKehmmXyin9QeJwcbnxYn5C+NfdtSZ6OibVP/34PEbkoduhfEiiGbw1e
	 oaEpFhk6WxECxaKbNt3fTL5CGiWoO2cFsZ/VKCJb4sKvfBKnkruGWIE3RlEtU1z2Lf
	 wn9fWYkbhrhJAyWtF+JqCQ8ra/Pi497O9LfDgPwVVWaHp/dc6w+UZ3XmBV2k5eoIw3
	 AhUKcHXNcw7L8XKFJcbE/rTAAFunopfHdj06AQpwy0fEo0yUrrmol61RJ+95mIxIZi
	 23jdF4mnzSgsg==
Date: Sun, 19 May 2024 15:28:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/5] iio: pressure: bmp280: Generalize
 read_{temp,press,humid}() functions
Message-ID: <20240519152813.30605aed@jic23-huawei>
In-Reply-To: <20240512230524.53990-4-vassilisamir@gmail.com>
References: <20240512230524.53990-1-vassilisamir@gmail.com>
	<20240512230524.53990-4-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 01:05:22 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add the coefficients for the IIO standard units and the IIO value
> inside the chip_info structure.
> 
> Move the calculations for the IIO unit compatibility from inside the
> read_{temp,press,humid}() functions and move them to the general
> read_raw() function.
> 
> In this way, all the data for the calculation of the value are
> located in the chip_info structure of the respective sensor.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
This had the earlier missing
int ret; in it, so needs some manual tweaking.

Applied.

Thanks,

Jonathan

