Return-Path: <linux-iio+bounces-7406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095D592989A
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 17:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A811C21D35
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9A537143;
	Sun,  7 Jul 2024 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTCxanOf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0923EDC;
	Sun,  7 Jul 2024 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720365714; cv=none; b=hBQd5kfk9X3kkF9DWrWB+VOAgxP9sWXO71TB1cDqQbd/xWNIdv2TN0xQiHew2v3fos6/VMuHxHpQUy7rvhZ4T5GTo7f/OAkkXEOAhXdkagNpi72ZQEc2m/ulAhPoatHKn7wrlMrZY5mC+h8/RvvKfKmmO2CaOXLPNZik2q1D91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720365714; c=relaxed/simple;
	bh=ZTHfu8WHstnTq0iDPJMZVpdzuIPlhUF3qHQYwWj77zU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njL9mavntGkT7LA5TfE0Sw9wYwotqRYXYaQ/3lQSOCZfqb70ogOyXJ80JyrGCHMlXBt4xo0SE707k031P931jak9fymQWawSQxrCYjXXhAxTv/Y6EQKzGduKSFbIVhxBW9lQ3vQGRhksK5M9e2jU83On0UNbPfgtEexu44OKlK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTCxanOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85403C3277B;
	Sun,  7 Jul 2024 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720365713;
	bh=ZTHfu8WHstnTq0iDPJMZVpdzuIPlhUF3qHQYwWj77zU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VTCxanOfSSdDkk/8LHOTeJaccNd8RmSEyaD7BHh08G2W/sbdqo7u9Iow51ikJEREv
	 AAHFJzDu1oV4jm63Z7nPyNWOn2xmpPAo0Uehm/+5dtWktLZQ6gnTnHSQ5AKJFzLVZm
	 kj/1Sv4aCeBSBFEXkWPZvbcoof3USbQy1Pkl+0JT8/nivShAngLiJ3kKsiXoBLKSqa
	 P+hW6Ptm7CaPrXmhl2UdLBEkVCRzYgN4nHAheSrTyK++g5jjAW40lrg9q0hgQSyTC4
	 u5n/T/c6INdcILMbeN5ftx6XCPzS555heAYeFwpzzUtAR+gnlcm7nsKCCb63A6mNqk
	 bt4UA8ZydhLpQ==
Date: Sun, 7 Jul 2024 16:21:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: <fabrice.gasnier@foss.st.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Nuno Sa <nuno.sa@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 8/8] iio: adc: stm32-dfsdm: add scaling support to
 dfsdm
Message-ID: <20240707162144.19ffc0eb@jic23-huawei>
In-Reply-To: <20240704155338.2387858-9-olivier.moysan@foss.st.com>
References: <20240704155338.2387858-1-olivier.moysan@foss.st.com>
	<20240704155338.2387858-9-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jul 2024 17:53:36 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Add scaling support to STM32 DFSDM.
> 
> When used in an analog context, a DFSDM filter typically converts the data
> from a sigma delta modulator. The IIO device associated to the DFSDM
> filter provides these data as raw data.
> The IIO device can provide scaling information (voltage and offset) to
> allow conversion of raw data into physical values.
> 
> With the new binding based on IIO backend framework, the sigma delta
> modulators are defined as backends providing scaling information.
> 
> The scaling is not supported with legacy binding.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Acked-by: Nuno Sa <nuno.sa@analog.com>

One really minor thing inline.

Jonathan

> @@ -1278,7 +1308,14 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>  				int *val2, long mask)
>  {
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> -	int ret;
> +
> +	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
> +	struct stm32_dfsdm_filter_osr *flo = &fl->flo[fl->fast];
> +	u32 max = flo->max << (flo->lshift - chan->scan_type.shift);
> +	int ret, idx = chan->scan_index;
Trivial but I've been grumping at others about this today so you get it too ;)
Don't mix declarations that include assignments with ones that don't.
It isn't good for general readability.
	int idx = chan->scan_index;
	int ret;

I'm not interested in patches to 'fix' this in other code, but nice to not
introduce more cases in new code.

> +
> +	if (flo->lshift < chan->scan_type.shift)
> +		max = flo->max >> (chan->scan_type.shift - flo->lshift);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:

