Return-Path: <linux-iio+bounces-20287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC127AD0D72
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 14:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A12116ED77
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 12:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225CE22128C;
	Sat,  7 Jun 2025 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4UcRZaX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44621F462D;
	Sat,  7 Jun 2025 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749299681; cv=none; b=WKDScc5MJk5ehmpzRYoshWPiMvekNNQKoM2p6Te23ue4BHLvoFn8zpT1bKbGzZyrHczqLF0hzpPii9VkPo8AoQw5neBdaw6NRrWohH5nd/12jIZmDu/VSZqU6QdyhjBvh/+jihZ57vAibKbVZyJflepgzrJns2jHBxl+hcncjZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749299681; c=relaxed/simple;
	bh=o50AnIX5FndYPO19t/MYO76E1k+iW9pu2w/VMKxgdPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dC1uxeyBCoDn6NdE5RSWHAz7xVk6eZ4gu2gxiIrM1O3OU9FnDvgAUF0cvU6GIunLaeFgG1pSs+rDQP7t/UsayCDcOR7DyTi0y1/ZZ6Waq6/laD9mJqcyGzhwlBM47+kaG6y5hcHF6cmQEKsSd63tRMwHWUutPy/csrZUftfABiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4UcRZaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F87C4CEE4;
	Sat,  7 Jun 2025 12:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749299681;
	bh=o50AnIX5FndYPO19t/MYO76E1k+iW9pu2w/VMKxgdPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V4UcRZaX6a2jfTfDFPu5tthVA0a//HoJ+PchNZFvNu+zkQrGeknj9y8Ec9h2O5C1+
	 UwS51CrRcQzzxkfeVgjRnb0XN4io4wxFtRdU+CsQqaCvtMjQ+86njGwPqxj1021TFO
	 lZROd22KCNuSSVIDREZgUuw7QrQhCLlHxxuswJ3UhJmRqnCovkDv3sKypUEakDCRr+
	 0hn95RrkHzCDzNI13wxxnQvoQZXEb1B3bgVqw70dGIiT1WH1G9IdCORMjkXImElIxk
	 2cBLlbgamau4hrawRIkQJ9MYjbE0oxLDNTJe6RUZO8tUu9s1mmiEI3scXaxDxl8ErQ
	 x6LVKy+jWGmjg==
Date: Sat, 7 Jun 2025 13:34:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v10 00/12] iio: adc: ad7768-1: Add features,
 improvements, and fixes
Message-ID: <20250607133430.64199072@jic23-huawei>
In-Reply-To: <aEE32At2OOlbY-xH@smile.fi.intel.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
	<aEE32At2OOlbY-xH@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Jun 2025 09:23:20 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Jun 04, 2025 at 04:35:06PM -0300, Jonathan Santos wrote:
> > This patch series introduces some new features, improvements,
> > and fixes for the AD7768-1 ADC driver. 
> > 
> > The goal is to support all key functionalities listed in the device
> > datasheet, including filter mode selection, common mode voltage output
> > configuration and GPIO support. Additionally, this includes fixes 
> > for SPI communication and for IIO interface, and also code improvements
> > to enhance maintainability and readability.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> (Note, some of the lines here and in changelogs all over the series have
>  trailing spaces.)
> 

I took a look through the remainder and other than that __free thing
it looks fine to me.  So with that resolved I should be able to pick up
patches 2-12 from v11.

Thanks,

Jonathan

