Return-Path: <linux-iio+bounces-13645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BB89F7E08
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B986618891C3
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 15:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C687228377;
	Thu, 19 Dec 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyG0E2ZB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AD0227594;
	Thu, 19 Dec 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734621929; cv=none; b=G+7tFef3XO87Q4i2jPHGRTAB42XXj2VEqxlwXLGrHKMaZddDhk9qHGAGXzIyZJL8xA7nwkQFI34s9gZLsOCXfS+ea8B9AbaT3FaoHm7qQMyKhB4i1qAnk1NPcDecwVeT0Iy4fxsFsVVmBKHmGw2nVlLbcnV72igmf/VFLarr+DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734621929; c=relaxed/simple;
	bh=KZUqHkCuJ9WN3Zrdz5tFlkKd5jeCgxhWZRSVBwS9N0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qH5ksjB2pY4XuzlBYZbnPtiZd2DkOcKwGpxq7BMO17/4Lcjdt9K1KXbbofjhNU5y8FlQsHL/IqJ1hfujdu0K6Q9qKORaFj2naJo5gLnRopTwF9sTzlMhuTNzcs393NftFmo1S88nYlR8Aq5arf9IMbkiywmYj9IyXxzZu7et0cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyG0E2ZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FC3C4CED0;
	Thu, 19 Dec 2024 15:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734621928;
	bh=KZUqHkCuJ9WN3Zrdz5tFlkKd5jeCgxhWZRSVBwS9N0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gyG0E2ZBrQxieMkwlRvCKKWcKU7QaMQ53VMoXxtgw9b+hM9A5bUCFIjqVAKsSp3XH
	 9boL5PW1nJTugnH1s7niTFoP4wPDSUYZcevq1NsXI4f20PHadYjHN8UYJlSIzhMzVU
	 gUjfmOday/LjAPqWsKIVjrZNZhi19AD31d6PaYp8FWRfRusi+VIQ0WoB/f8tJ1lmaB
	 O6EL9VQWonYvZ6B/fKfXQefG660x0nRBR6Ta3eI9jxfhE9oDMsFBcoZW2HT9JpPWZW
	 khJZMytyVuZ5kXWiLbSulu7bUOjuxkCAzgr+thfobRxTESpjF7Gz1Rj6in7ssKByIF
	 2x8AfUU1/AfVw==
Date: Thu, 19 Dec 2024 15:25:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
 <kernel@axis.com>
Subject: Re: [PATCH v10 0/2] Support for Texas Instruments OPT4060 RGBW
 Color sensor.
Message-ID: <20241219152519.4ac94595@jic23-huawei>
In-Reply-To: <20241218104836.2784523-1-perdaniel.olsson@axis.com>
References: <20241218104836.2784523-1-perdaniel.olsson@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 11:48:34 +0100
Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:

> This patch series adds support for Texas Instruments OPT4060 RGBW Color sensor
> using the i2c interface.
> 
> The driver exposes raw adc values for red, green, blue and clear. The
> illuminance is exposed as a calculated value in lux, the calculation uses the
> wide spectrum green channel as base. The driver supports scale values for red,
> green and blue. The raw values are scaled so that for a particular test light
> source, typically white, the measurement intensity is the same across the
> different color channels. Integration time can be configured through sysfs as
> well. The OPT4060 sensor supports both rising and falling threshold interrupts.
> These interrupts are exposed as IIO events. The driver also implements an IIO
> triggered buffer with a trigger for conversion ready interrupts.

Looks good to me.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day to
take a first look at it and see if it can find anything we missed.

Thanks,

Jonathan

