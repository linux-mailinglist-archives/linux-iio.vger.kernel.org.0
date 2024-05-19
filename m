Return-Path: <linux-iio+bounces-5124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB848C95A3
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 19:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE721C20AB0
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 17:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC434F200;
	Sun, 19 May 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT7tMcKw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A217F2E3E4;
	Sun, 19 May 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716140739; cv=none; b=VPMQ4u60teRjA2LyqxgG2n2NzuA97aBI3A5R/CuNUIiN6YKOHE5UwYOlo6H4DGY18H+2unTvCMm1aONS8gI1e6dKssi9/GHbdfXeJ2izF2F3RJiRFYkGo75auky82efWJbSRDF5bTK3LOxY+6VmLgG6/L7RG7i42B/LXJqliYSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716140739; c=relaxed/simple;
	bh=x+fICK3jU4fuNsoUgsyQNFBRbjYOgrloY86wnCF2fUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCR0rqZ/E1D5N/GtPwEszAzjoRd40X4T3WgOk78b9Rs4a2XWgLEw/4jE4kdyeVIVuvRl0j4CR7X1ct67db477znnu6rNmhnjdoOrc3vR8AxZGB7VR6Ow8iNjEFq69XNhnWsewXNxlibJAmyx1O5PZEvj8u6MM9FSq81UbCxDixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pT7tMcKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDEFC32781;
	Sun, 19 May 2024 17:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716140739;
	bh=x+fICK3jU4fuNsoUgsyQNFBRbjYOgrloY86wnCF2fUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pT7tMcKwlWXsj6l8o1dmeOZbFH9yNcRk39u3J0wlM2RNzWb//KA7VdH6uuCJxWrj5
	 +CgiJgulRjSY3iqtl6zGzAX07CG0z5py5gmM5XKO8BjmK8lAMRAOE+VNcAfPPb1l7h
	 jUew+iaVMlHMCQzpSiFhhJsYhTY+C8pNUX1TSXM1cbp9XD71RbUleiesnxN550igOK
	 Ruoqke0X6RXRPPKFJt8lLuzU/xp/7pPbaK7sCe+Cl3mAP+2g+6TOWv3nS+5Z+fQdLo
	 qe7iGEqxQmsPXEgMlsa1wbWXqVnAqcJLd5HUnJpt0WiRIrTnh31D2lupyzzIOd/VTU
	 Q18Lwv4+rjFzQ==
Date: Sun, 19 May 2024 18:45:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
 alisa.roman@analog.com, marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
 liambeguin@gmail.com
Subject: Re: [PATCH v8 1/6] iio: adc: ad7192: Use standard attribute
Message-ID: <20240519184523.03794b53@jic23-huawei>
In-Reply-To: <20240514120222.56488-2-alisa.roman@analog.com>
References: <20240514120222.56488-1-alisa.roman@analog.com>
	<20240514120222.56488-2-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 15:02:17 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> Replace custom attribute filter_low_pass_3db_frequency_available with
> standard attribute.
> 
> Store the available values in ad7192_state struct.
> 
> The function that used to compute those values replaced by
> ad7192_update_filter_freq_avail().
> 
> Function ad7192_show_filter_avail() is no longer needed.
> 
> Note that the initial available values are hardcoded.
> 
> Also moved the mutex lock and unlock in order to protect the whole
> switch statement since each branch modifies the state of the device.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
I'm going to work my way through these, picking things up until I
hit anything that needs non trivial changes (hopefully I won't!)

Applied

