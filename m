Return-Path: <linux-iio+bounces-21969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CA2B10AA9
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 14:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 900307BA1D2
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BA62D46C4;
	Thu, 24 Jul 2025 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMCKtgTh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BCB2E36F2;
	Thu, 24 Jul 2025 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361492; cv=none; b=Bpge9SyLD0giw80RQHa1TDdsGcWbyVKN94qlqbaBu/n0hkz1wmIkTeFpZI6OBSuMPfXuYlYlF2rH1MgYGnOK9oA+LwO6LKMMcFB03+ahxBHY8ymKde0WLnTRMKq5yWMnTqFUJKBPqZdLmqHLOYah0s2IE5LuP5Eocg1q87rWYfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361492; c=relaxed/simple;
	bh=3y1PNsPbnB0pOF5i2gWS2cEdMRHLJqBmwjxZghX0ySQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wa1P4Dy+rYqW7YhQmzHSivcSpiZSLPs2Wz/npBo4tptGaV9djN2hoVKoCrJoRyTXz77Ss7AsoCtIW1RS3cjuS9W9bqZftJr8btJQ8b9F3m0gRgwgL6DlIK6QpUrfKzcpB64SZQhWSVx2CYXyjg2Eu3DfwE5DHukIbn2gj2j0N9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMCKtgTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF41C4CEED;
	Thu, 24 Jul 2025 12:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753361492;
	bh=3y1PNsPbnB0pOF5i2gWS2cEdMRHLJqBmwjxZghX0ySQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BMCKtgThAJinRmRuodxqFNoFKMLjluaGP1BCkSy2iEOriC5ksQy0o3Ii8y/3gwJBI
	 K1+fvHyBKKHNZiO+XuyI1QWd9R+rIguTFaHgax1yqEqv7INU9fvzn4VY6KrcSBF9n5
	 u6ge6czf+b3e2IvrMDtKFPhYb++TX1hSFWEoNxiU9tVVorXzVlOVbgXJ+gAuT9csVK
	 XZjZWOE1M0mO50OOPpDNFhkRgSJe62djeuYlvTSCH974IHtx4KmVzzj+3sR+xzo8Mj
	 x8qgZHH+pcV4wSYW3aWCRh54Ac8wZd3zatNxR4Q3wvsK8TuROvj2RmiRiniYc2sMUq
	 oWfN0tuVTlCUw==
Date: Thu, 24 Jul 2025 13:51:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, dan.carpenter@linaro.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, Markus.Elfring@web.de, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 1/1] iio: adc: ad4170-4: Correctly update filter_fs
 after filter type change
Message-ID: <20250724135125.5dabddb1@jic23-huawei>
In-Reply-To: <aH4n6kMQAN1zZP_V@smile.fi.intel.com>
References: <1c354ff9f41ff964a66ece44b0d356e0bda3d210.1753024756.git.marcelo.schmitt@analog.com>
	<aH4n6kMQAN1zZP_V@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 14:43:38 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Jul 20, 2025 at 12:37:24PM -0300, Marcelo Schmitt wrote:
> > Previously, the driver was directly using the filter type value to update
> > the filter frequency (filter_fs) configuration. That caused the driver to
> > switch to the lowest filter_fs configuration (highest sampling frequency)
> > on every update to the filter type. Correct the filter_fs collateral update
> > by clamping it to the range of supported values instead of mistakenly
> > using the filter type to update the filter_fs.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Link: https://lore.kernel.org/linux-iio/c6e54942-5b42-484b-be53-9d4606fd25c4@sabinyo.mountain/  
> 
> You mean Closes: here?
> 
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Fixes: 8ab7434734cd ("iio: adc: ad4170-4: Add digital filter and sample frequency config support")
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>  
> 

I picked up v1 and made that a closes tag.  Links to email threads are fine
(there was a question in v1 on this).

Applied to the fixes-togreg-for-6.17 branch.

