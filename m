Return-Path: <linux-iio+bounces-22806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44B9B28DA7
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930E6567FE3
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994EE2D1900;
	Sat, 16 Aug 2025 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hyyn2Yko"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51031202963;
	Sat, 16 Aug 2025 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755347313; cv=none; b=atE6wv+tlcYzBWMdpG6wbOSeJq87uiAnAzM2gU9RNODtXlvT2yAdWydbHrA1/3FuDllLkFTzBCljXBWQDkrsEp7QxM6gGW0uISQ+w6w5Aw8xVZQrdRg/xH14NrKjvg/4IWCfoTKbNHglrdI0rVwxK1MzaGBMDXST+/oOZCbcTks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755347313; c=relaxed/simple;
	bh=LJeFZtZTd/y7pEigZxfXECcr2D/HhqEwT40BN7OnCwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7jR5JfV+NZqkxP+7u/+4264evfgEwj5vYMZirOB14cCKof/U3G02fvfHyf0as1tmvI8j/Zhmd8h0i/NPHRbP+KtwokS455vaRDeKWZ5S5AXrDxuq5HBSPdUBVA+bC46y8y9X4t5FuJsTLbk0Ig6quiyKshvGefHh5+NwBUhe4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hyyn2Yko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAB9C4CEEF;
	Sat, 16 Aug 2025 12:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755347311;
	bh=LJeFZtZTd/y7pEigZxfXECcr2D/HhqEwT40BN7OnCwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hyyn2Yko7QeeCmR0DNlCNH3cd4y8EfJ6ln/6wWQJnuXhAAlZ3gAiJZIuxpcWVPP4z
	 F0cznSiLVlmWuG2gudGIZZglWw+mZR1HUTX3t3emy8nRT5Jo4na49PtomzDuhtQZ1E
	 DNgW6m+ceGjNliKFeB+Q3pwShmHDX+TiCL0C+yno9nthZ3WUBw73vykUTx3+rnO8W4
	 cv0UgID+MCDuBWrsQ3iYjqgefVPgW4fNea/nGscBWNewLRCtKkXIYUhWy+JhzF5sWK
	 mT7jk3LMU4HvwY+6DzbPsIua7iwilfxxj+aco4AIzzUAAQ2mH05rrj5k0i0wIYDjVj
	 d49EsVy55WRwA==
Date: Sat, 16 Aug 2025 13:28:23 +0100
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
Message-ID: <20250816132823.0d987b20@jic23-huawei>
In-Reply-To: <d817f2c9-063f-4506-888f-f3c6faef53c4@baylibre.com>
References: <cover.1755159847.git.mazziesaccount@gmail.com>
	<b91ca4c576aac225525bbd7cd904bf684e796987.1755159847.git.mazziesaccount@gmail.com>
	<d817f2c9-063f-4506-888f-f3c6faef53c4@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 09:53:21 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/14/25 3:35 AM, Matti Vaittinen wrote:
> > The adc128s052 driver supports a few different ICs. IC specific
> > configuration data is stored in an array. IC data, residing in a
> > specific point of the array, is pointed from the SPI device match data.
> > 
> > There is no need to have the chip config data structures in an array
> > and splitting them out of an array has at least following benefits:
> > 
> > - Chip-specific structures can be named after the chips they support.
> >   This makes referring them a tad cleaner, compared to using a generic
> >   array name with a numerical index.
> > 
> > - Avoid all potential 'out of bounds' errors which can result if the
> >   array is changed.
> > 
> > Split the chip configuration data array to individual structures.
> > 
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > 
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
Any racing series get to rebase on top of this.

Applied this patch as it is good in it's own right.

Thanks,

Jonathan


