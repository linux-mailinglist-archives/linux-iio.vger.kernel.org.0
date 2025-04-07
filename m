Return-Path: <linux-iio+bounces-17786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB0EA7EC46
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 21:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 843027A1A5D
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 19:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD15224237;
	Mon,  7 Apr 2025 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWVs4z45"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E39221568;
	Mon,  7 Apr 2025 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052126; cv=none; b=nhDfEV6Cq4xYglWuY4EJjI9/QI5/StB+3Pmt/d2zfMRDPQsGlvLMPVN7A7+YLyf7qg2TJia4Gu7PTRszT6wGrQ7eIehNE4FO77Mu0Idge5KJccu+Q9Om226mhL9wKKvStwMqEaEJUfV2zr0bXPXnt9dYZ/kCGPPFkYRF1gP8Jns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052126; c=relaxed/simple;
	bh=Moj/1kZ8srPT+idoTQAOyty7DgC0HH43YMiryJ+T8ek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4iV5/Vvzc/GWhaRWTVsVxukmzBdWyE2fVqaxjbm5nkvk73WZZhmDVFXDn8j7bHPGyTZSqq2i8obbU4ETIwwdb194wtl/QFUgIYbb5TP4hhgqMZFEDRp6Xkvij47leGsLc7PrGyAC+nxBOLgoxQFqCGZklDr2aSS2EvC/zekdaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWVs4z45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F5AC4CEDD;
	Mon,  7 Apr 2025 18:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744052125;
	bh=Moj/1kZ8srPT+idoTQAOyty7DgC0HH43YMiryJ+T8ek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MWVs4z456T4G/IuHwXmA53G4NmBacviUcELzaggWtvakUcOIu3EtGFb7KG/dR445M
	 cByPgGfc25jYJtm/fTuuOyQhjwpIljrRvTu+nigr369l/7mRv1yyulb0wQn0Li2lOh
	 73MGwMM9rpI+XABT58/leWs8p/feYVsxAOiq6GBl14M7pTKzvMiFFEbz0TZHrRywz8
	 IMrIk6Ihfz/NF2EYSz3PL9tPC983lZ8GUikyZ1Gh8PIcY9SLoN7j0nZiFKj3O8t199
	 RFRMal8ms64QXA2JQX4cCe/huomPg2P/mbEWcZuRi9hko6EBWdVU/uqwKTpda3ulBy
	 El7NsexxUNmrQ==
Date: Mon, 7 Apr 2025 19:55:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: ad7606: add SPI offload support
Message-ID: <20250407195515.38b571e0@jic23-huawei>
In-Reply-To: <c146175f-6a21-4039-8c81-5933a9ef5ef6@baylibre.com>
References: <20250403-wip-bl-spi-offload-ad7606-v1-0-1b00cb638b12@baylibre.com>
	<c146175f-6a21-4039-8c81-5933a9ef5ef6@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Apr 2025 11:48:09 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/3/25 11:19 AM, Angelo Dureghello wrote:
> > Add SPI offload support for the ad7606 ADC.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---  
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Dropped the todo and applied to the togreg branch of iio.git.
Initially pushed out as testing for 0-day to work it's magic.

Thanks,

Jonathan

