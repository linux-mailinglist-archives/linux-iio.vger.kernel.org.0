Return-Path: <linux-iio+bounces-20634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE27FAD9C82
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744451711C6
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 11:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33BB2C08D7;
	Sat, 14 Jun 2025 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGraheyN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA21F0E58;
	Sat, 14 Jun 2025 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749901100; cv=none; b=nEPbyEGoBiVWarH3TIpbcDSAQy6bX5u7GwjSnMqjsmXe1hv4mmCT8tdV5ZiIzc94CmcCDou1iNo5eKFpcub24vUNmcc97qQtmTj5/DeG6U+Rzi3+dqQSf3G9q0qL98c4G5iO0cCzzgzj6P9M8RjJmW3ELqqUH/lduARZ4Zc99Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749901100; c=relaxed/simple;
	bh=fpbBffDgjhog3qXMyHUoM68Q8rOI2jUHMB121Vi9XHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dto1NfXu2KypZXBo5NT4c62V9Ef64oGwYOI1ncF3rtn09EOdzR8qOqvuTJeSnafKv78V9xaRMfFJJ3J7zdkOmwPVidwbIqwZgs3QsbcByB8nYt44ec1CKn+s0yQ12VfG4Ytuqoh5YWqoaFbVPDL3lIGxr6/sjF/8OuWoGhnEfUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGraheyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16486C4CEEB;
	Sat, 14 Jun 2025 11:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749901100;
	bh=fpbBffDgjhog3qXMyHUoM68Q8rOI2jUHMB121Vi9XHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BGraheyNjgq7rmP2OW6sETnjy1RJVbvX2IrD5bOtFvQE6EagmFOVc244Lm1+7CWOf
	 BakLQuTykgIh8aaF3eFpPlVXIuQva6lg601038oVgP2YmqkiLgTKoQWwsCg/6v1NjY
	 Gz0ei/isYqshh4xPqbH1mZNbE+kLaFeaVfVFx+h90/CRcxzN7vSPEcLXxohUeRoa6q
	 u7IVUWpHorwViXLKdG+jCm3Euoy5Z62HdrnH1oMXpo2WyDtydi/izEMrz/z2wkswpq
	 JIeHqWnS3PSmnhoRVaW3IVg+9Yxrrh0omYuRtJ9Eq2gz8VcWcIC/Qp0wsaZzTsYoNp
	 +ZTTPEem4qAZw==
Date: Sat, 14 Jun 2025 12:38:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v11 00/11] iio: adc: ad7768-1: Add features,
 improvements, and fixes
Message-ID: <20250614123807.3ded6764@jic23-huawei>
In-Reply-To: <aEweNqhLsL_Hg_gl@smile.fi.intel.com>
References: <cover.1749569957.git.Jonathan.Santos@analog.com>
	<aEweNqhLsL_Hg_gl@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 15:48:54 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Jun 11, 2025 at 08:49:34AM -0300, Jonathan Santos wrote:
> > 
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
> (for all except DT patches)
> 
> The nit-picks can be addressed either in next version (if needed) or whilst
> applying. Up to maintainers and you.
> 

Applied patches 1-10 (with 10 tweaked as suggested).

For 11 I'll wait on answers to questions.

Thanks,

Jonathan

