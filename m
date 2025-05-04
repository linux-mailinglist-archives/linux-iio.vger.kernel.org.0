Return-Path: <linux-iio+bounces-19046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF268AA8774
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D24F57A5CE7
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1B01D9A50;
	Sun,  4 May 2025 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sU0XZNwp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583D1EEE6;
	Sun,  4 May 2025 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746374133; cv=none; b=kDSuQlQaWj2h6awzUsbkF3XjYZ7DTXFE5MME5DZIIEjYuFTGIBjXHZoEXF7auJcGZSx2yGNUKGZHi+YeLtEbqDc6pI3IzZTxJ2NOQwZ6rDFTFyBDIHi9sg2QbIIzrJLbOdwRKvWf2H4exNsn2S88jUbcw772lYYNXdX5gVjAixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746374133; c=relaxed/simple;
	bh=X/5ydm+/iZVBatwWrHh8Wcm4pJOdYrKTLklVpa11xIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5/Dj8rOMESq+ngeoFL2CY2BT/m2jbH/cq2qpD/unvSNpZRZygOEkm2NnVo288X8VAEV+6kdRldVpsDydDhqADOch4mtWpZOFGbWeuo2c49fUyJx80kedSSIkQk+eE/oQjaXHG/czLa4SYlG7ImB9YmtyKECs4BX00FY0McGkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sU0XZNwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C10C4CEE7;
	Sun,  4 May 2025 15:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746374133;
	bh=X/5ydm+/iZVBatwWrHh8Wcm4pJOdYrKTLklVpa11xIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sU0XZNwpwR/5YOpq3qAeJJD6xWo1XHLfFZbrOkvlZ8MJ7RiG5DAYFyvxg353S5sDU
	 bocqvThjw3MzEjAizxj4b9DKe8BbibANK+vmAc1S1g9M9Q63HR90KgQO7HsXJbbf5O
	 S2bydE+PL3MDDz/B04PheJ41+PNwfpE7AyUqVQOzMB2ZbkrO+ZIgheccBCRIm7aty3
	 ivQo55n6HmQNT13CQge7l2ZLFvPDCHZGZcURhu9iTUc1h1qViR22aRnCwvRXHyOqoM
	 yMRK/jz3e1+8362fEe+YLDd6vPxs02pGsXJ3Td8XTV+WG27Del3SIjmOtCAaMdst4r
	 cx+7gdRCVhEdA==
Date: Sun, 4 May 2025 16:55:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Sayyad Abid <sayyad.abid16@gmail.com>, linux-iio@vger.kernel.org,
 lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, javier.carrasco.cruz@gmail.com,
 olivier.moysan@foss.st.com, gstols@baylibre.com, tgamblin@baylibre.com,
 alisadariana@gmail.com, eblanc@baylibre.com, antoniu.miclaus@analog.com,
 andriy.shevchenko@linux.intel.com, stefan.popa@analog.com,
 ramona.gradinariu@analog.com, herve.codina@bootlin.com,
 tobias.sperling@softing.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] iio: adc: Kconfig: add Kconfig entry for TI
 ADS1262 driver
Message-ID: <20250504165520.4fc0920d@jic23-huawei>
In-Reply-To: <213ae3d3-b6d1-4808-9af3-36a8cc1f1335@baylibre.com>
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
	<20250501100043.325423-3-sayyad.abid16@gmail.com>
	<213ae3d3-b6d1-4808-9af3-36a8cc1f1335@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 May 2025 12:37:35 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/1/25 5:00 AM, Sayyad Abid wrote:
> > Adds the Kconfig option `CONFIG_TI_ADS1262` under the IIO ADC menu.
> > This allows users to select the TI ADS1262 driver for compilation
> > during kernel configuration.
> > 
> > Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
> > ---  
> This can be in the same patch as the driver. Same with the makefile - it doesn't
> need to be a separate patch.

Change that from can to should / must.  There are some bits of the kernel
that run a different approach for complex multi patch drivers but for
IIO we want everything to be building at each step of the series.
Personally I see that as good practice and I don't know of any part of the
kernel where the maintainers reject that approach, just some where they
don't mind as much if a complex driver is built up and only compiled in
the final patch

Thanks,

Jonathan

