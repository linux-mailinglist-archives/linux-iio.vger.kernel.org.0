Return-Path: <linux-iio+bounces-10790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D6E9A4EA0
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 16:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE5B1B26AD7
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9226D5589B;
	Sat, 19 Oct 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hb72xYIP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5A713C682;
	Sat, 19 Oct 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729347713; cv=none; b=dQ+jia0QttEOs/Mx2WZ66xFzcCQ3MlIBTsvkVqNUAR5Cq+sXMEk25PkEtJo6kDQyTdo7PlywOCi77HQSmy0Z3ZEDGOyQvKtPE86YIx7SU3HGIBLbLylff6z9dcbALLfN91v0MAUq9NoI/PW0IEwTTw7YZC91h3keuQee4BNaZT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729347713; c=relaxed/simple;
	bh=4HnROe9W0kMqs79sJaxmryYynScWYajMz1eXQBV0F1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IB5xFc5GssvESdCcre1IcvDDMzOviHZ27BRVFHzFxNpq335Goh0CBRgBbDWY3VqmJFRsnJ60htbrgJUhNikjbXg6nDKYgEp/o5S1/eeEq5lz5awJw8QvBDaOOnPui2x+RQEextKrOqUEz6747Z4B7AZJa4YjkofJNqJO6LMkHYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hb72xYIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A21C4CEC5;
	Sat, 19 Oct 2024 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729347712;
	bh=4HnROe9W0kMqs79sJaxmryYynScWYajMz1eXQBV0F1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hb72xYIP6PTPoYpxd70AvtCtCTjmxyDy+OpxYL2fciDBFNV6YxdtkGNyBUlIXDaiZ
	 nKZ66xhvJxygLOl0e0ZmXC/q6v7zQexcfgiO5NA/DLI+oMdk8sN4Sxnj8cEsZoFWsd
	 zUqnWBmvEW70u4+ylHNHODYidgxVPkq4+3OILy/mTx4smu5Wp3/AH1am+awFgPvr9r
	 1M12fFs6inlMOnooMAvgyGB7rzOXJZ53c6vSg4lUGMZYGeu6j7xdtbJyEjeQrxvER7
	 26bDVIdOcMbqRbexb6fEqVzzDa8XK0VEGYTkVoJMaZvnb1KP1wQqn8byR4raLI8suR
	 Lnr2X9DnnsHyg==
Date: Sat, 19 Oct 2024 15:21:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: light: veml6070: add support for integration
 time
Message-ID: <20241019152123.5f60e8b9@jic23-huawei>
In-Reply-To: <20241017-veml6070-integration-time-v1-4-3507d17d562a@gmail.com>
References: <20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com>
	<20241017-veml6070-integration-time-v1-4-3507d17d562a@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 23:39:28 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The integration time of the veml6070 depends on an external resistor
> (called Rset in the datasheet) and the value configured in the IT
> field of the command register.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Other than your self review (which I would probably have failed to
notice!), this looks fine to me.

Jonathan

