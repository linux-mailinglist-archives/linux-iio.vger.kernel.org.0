Return-Path: <linux-iio+bounces-22808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A0EB28DAE
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95653B3E1C
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DCE2C3745;
	Sat, 16 Aug 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ec/hCk1f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CDC2288D5;
	Sat, 16 Aug 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755347541; cv=none; b=UJgh6GG8XFQf2odjpA7V4wZ6nOe84HuiBcHL0mHEBOJV1d0gQXySVoCAieTAkHDmjqFiJEgHAIOWIpCzpkuQamS14x8F3SD7yUDoe3VhZkjFWNhQ7kTotpYxemXrlwjGvSqATBEDRmPtL4X0+gS30jsEvU8reQA7+1+6ePvWquM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755347541; c=relaxed/simple;
	bh=jHJgHjhXE4hy8ohd07eRQXE4pbWJuR7KFLNDqnturro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdzhUPpAKzSqxT3CpKjFx0c2ZsGVn3sXUu1xnesLrALNUvVFQBjtBbs4ZRH2qPMq3vlJUkd6aTmXBJ0VgVTdLIbnR2vLBysaEhVkGVjuY50YTV8oy3uBGGrUemz+rfGIfdncXdYdEhb+AfHuWK2vLPG00lz/fyzNCYlC1dqQGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ec/hCk1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01404C4CEEF;
	Sat, 16 Aug 2025 12:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755347541;
	bh=jHJgHjhXE4hy8ohd07eRQXE4pbWJuR7KFLNDqnturro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ec/hCk1fLjVNcG0EI2rMoiyPS3op8K6IKK2gRKDj6++zRYYi1GmX8nfNH0bzEv8Le
	 bYgKpcCx3U5c8/KtnbUPkbGt1hWXCodz+KzQx8VypnBE4yKeqj0eVW4lj4pazeXRuI
	 o3yMZeJ6aXM0Px3pCHMXWG14J/26DUJfxZOwqjdXDcHUl59iL6qDISWG3NHrAe4LRN
	 0u3Ciyc/utCaxb9sossCXJeOISyDRXJFyEkOrPwK0EusVr3nnxoQSH/oBt8DwR1NzM
	 Nzqqc766I1QAfG8pmO5y4FlvkPKwNF1qCdzxPopFNIaHoRsY23NUylrCdabcC5WHiC
	 nP3empU1zAOng==
Date: Sat, 16 Aug 2025 13:32:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sukrut Bellary <sbellary@baylibre.com>,
 Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: adc128s052: Simplify matching chip_data
Message-ID: <20250816133211.39a9a0ac@jic23-huawei>
In-Reply-To: <20250816132823.0d987b20@jic23-huawei>
References: <cover.1755159847.git.mazziesaccount@gmail.com>
	<b91ca4c576aac225525bbd7cd904bf684e796987.1755159847.git.mazziesaccount@gmail.com>
	<d817f2c9-063f-4506-888f-f3c6faef53c4@baylibre.com>
	<20250816132823.0d987b20@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Aug 2025 13:28:23 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 14 Aug 2025 09:53:21 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 8/14/25 3:35 AM, Matti Vaittinen wrote:  
> > > The adc128s052 driver supports a few different ICs. IC specific
> > > configuration data is stored in an array. IC data, residing in a
> > > specific point of the array, is pointed from the SPI device match data.
> > > 
> > > There is no need to have the chip config data structures in an array
> > > and splitting them out of an array has at least following benefits:
> > > 
> > > - Chip-specific structures can be named after the chips they support.
> > >   This makes referring them a tad cleaner, compared to using a generic
> > >   array name with a numerical index.
> > > 
> > > - Avoid all potential 'out of bounds' errors which can result if the
> > >   array is changed.
> > > 
> > > Split the chip configuration data array to individual structures.
> > > 
> > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > 
> > > ---    
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> >   
> Any racing series get to rebase on top of this.
> 
> Applied this patch as it is good in it's own right.
Dropped again given rename discussion on patch 3.
> 
> Thanks,
> 
> Jonathan
> 


