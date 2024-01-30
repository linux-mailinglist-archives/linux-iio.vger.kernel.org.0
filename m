Return-Path: <linux-iio+bounces-2057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B993842E44
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 21:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F969B211D3
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 20:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8D679DD6;
	Tue, 30 Jan 2024 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fh6flFfP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98E5B1F6;
	Tue, 30 Jan 2024 20:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648071; cv=none; b=PuFpnaldIT1s96zZpLhXdUySIpPeEYBg1uR0z8Uc8rWjV09SlYt8SMWLrYCb3YzqH8HtuRFsdPq8vvhjI9ZCPK/t8MiQW1Y7LNQhogaBA2lXbI+XCJUfJANpQTYdCmcVOJSnhk6W19SDuYODPu1XttEcbrJLlTpwPB0Gmp20Eoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648071; c=relaxed/simple;
	bh=LwAkpfYAfzqJ9BPc+vvV+IDrTYcsO1fpV7GcW0e8K2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWz/ZTUCs7VePZLYhNOJgFouqUF3vc6xCU+izpAMICgLH8fEsECOZuxIneeE2ptVGpRMgOop9xvmuylDJuC0sSwMsn8V5fpGMIO7+av18S2sictM8wiGG2TUmuSVcqBc8S97UcC9M5Wqeh1IvM021crlPI5cZV5U/tBwI9vzfy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fh6flFfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16020C433F1;
	Tue, 30 Jan 2024 20:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706648070;
	bh=LwAkpfYAfzqJ9BPc+vvV+IDrTYcsO1fpV7GcW0e8K2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fh6flFfPlA0PU7kv20yMU1fVq9G/daLSFEeiLS6oQp4MYkBI92SOsrOuX/2ZyMOF8
	 V4p5k63MV5kFLeDHZL11m9eOEK5J1/nk+E4bHFIzv4VHIqrdMDzKI3l4MsHoJJrulf
	 WwsETvl6gIv++tAK8/lwEDz39dKotvsZnYUhJ2H3AhbEPQ5lb42DKKw4P3qdQcFgH3
	 xY/oYUdSzypwMaraMT5Bch4qqCZKowbtmL99GCCNkIiV4j6ILUrdY91Xg0PxDdlM9o
	 9bVJ6q4+0N0ML9yDe7/G2zopYMguwEwGirIwoPRkitU8w94tb1zVzr3ZbPhmEIYWqy
	 2JaQIPZLC5DAA==
Date: Tue, 30 Jan 2024 14:54:28 -0600
From: Rob Herring <robh@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7 1/9] of: property: fix typo in io-channels
Message-ID: <170664806394.2324419.17581898570868149558.robh@kernel.org>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
 <20240123-iio-backend-v7-1-1bff236b8693@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-iio-backend-v7-1-1bff236b8693@analog.com>


On Tue, 23 Jan 2024 16:14:22 +0100, Nuno Sa wrote:
> The property is io-channels and not io-channel. This was effectively
> preventing the devlink creation.
> 
> Fixes: 8e12257dead7 ("of: property: Add device link support for iommus, mboxes and io-channels")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


