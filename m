Return-Path: <linux-iio+bounces-23563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BCFB3DAD2
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 09:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C661B7A9492
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 07:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D28265632;
	Mon,  1 Sep 2025 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eODTA7j9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5528225A322;
	Mon,  1 Sep 2025 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756710625; cv=none; b=Ax8+esiz8MZA5qVW9vX0nCjhD/pGSwLrNr/oeKza9vH8wPZ6dqcnNWwmHS5ycUBVZWOBUE2XL0ioj6DaFj877RbIp9SKriE+D2Ijin96gV2fhXycalHJb3K/kXnWB2JvveesbysaNmCfpbMid6E9J5Up3PGOgiW2Zffr7r7gfpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756710625; c=relaxed/simple;
	bh=NTMXFokxaiRJzs9Mo6wvmzD6Foc2YjZyaToi3MONoPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwSrDb0QxDLraaFkGz3F/KXP7nbrNZaUrshDlGqq/PAoUb7uemjgBF0d9n6L+bDsLDSwRm9wOmoiaMluffgmZvPQ7vGNcSui44FAJzmehRbClogSjAgUSN5TjdR/qSXp4bjll2LjxN916qNk1ofcSQbsex1emOMGtzt/TYMan2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eODTA7j9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA5AC4CEF0;
	Mon,  1 Sep 2025 07:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756710624;
	bh=NTMXFokxaiRJzs9Mo6wvmzD6Foc2YjZyaToi3MONoPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eODTA7j9VMA2b7Q3ehvseuVyG/h3ABylYM/dh1RGAC4AcsRuivW7YjRlhYdmbUJah
	 ptfLM+3fS22Xmcg/bWlLwcWytJlKaHS+VUhKoVMDXUxhnLIKOpEuzH9WTC++A2mbjG
	 UoN25rkhJXSdRR2B06OjQPVldVy1Vas6KBV3MUZg=
Date: Mon, 1 Sep 2025 09:10:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: add mutex to serialize
 SPI/GPIO operations
Message-ID: <2025090147-tapeless-pursuant-3234@gregkh>
References: <20250901065445.8787-1-moahmmad.hosseinii@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901065445.8787-1-moahmmad.hosseinii@gmail.com>

On Mon, Sep 01, 2025 at 10:24:45AM +0330, Mohammad Amin Hosseini wrote:
> From: mohammad amin hosseini <moahmmad.hosseinii@gmail.com>
> 
> The ad7816 driver was accessing SPI and GPIO lines without
> synchronization, which could lead to race conditions when accessed
> concurrently from multiple contexts. This might result in corrupted
> readings or inconsistent GPIO states.
> 
> Introduce an io_lock mutex in the driver structure to serialize:
> - SPI transactions in ad7816_spi_read() and ad7816_spi_write()
> - GPIO pin toggling sequences
> - Updates to device state via sysfs store functions (mode, channel, oti)
> 
> The mutex ensures proper mutual exclusion and prevents race
> conditions under concurrent access.
> 
> Changes in v2:
> - Fixed mismatch between From: and Signed-off-by lines
> 
> Signed-off-by: mohammad amin hosseini <moahmmad.hosseinii@gmail.com>

I think your old "From:" line was correct, as capital letters are
proper, right?

Also, the "v2" information goes below the --- line.

thanks,

greg k-h

