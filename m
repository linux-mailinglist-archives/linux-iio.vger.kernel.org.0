Return-Path: <linux-iio+bounces-10689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D289A2B5E
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 19:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD441285BCC
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FFF1DFD99;
	Thu, 17 Oct 2024 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbUwad6c"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878691D95BE;
	Thu, 17 Oct 2024 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187464; cv=none; b=oiGbA1AYgyzdcHBOOGpzB/zLUwF4HqaF3hWouhyf37gqGUIM9ysIwpXV3uOkAjHcVB3embKpN77ZEaChh+8lnTwRL2udSPngfMXeCM+9lndJRSBhfL1Gfdk8fU9QUlqRBZsIsxRROf87XYbIPFKd8K+4ICmqlAiNUSP4uDYokvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187464; c=relaxed/simple;
	bh=iuO9GwU+XZ+dkOK6CLXnqQXeL2T4SJwSUGNf0/jr4GM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHzXDvL/o4NQQkRPy4aXE/ZdLP68zK5B+elwzN5vi0RC9rkO4WQpMPFsJEypbn1Nw1WYG0Jku+twcnp6C+8HBO+cbrKS2GqeEXEPXeZNOmHsVcRrikf4SXhIDau2ZtM0nxW95x5iMCfF17sJYF3reNMDRiE52/q0GG7w7hIjlX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbUwad6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1250BC4CEC3;
	Thu, 17 Oct 2024 17:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729187464;
	bh=iuO9GwU+XZ+dkOK6CLXnqQXeL2T4SJwSUGNf0/jr4GM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RbUwad6cB88DQhR/RqGrDjMdfmYysu/gTJabEVsfQZ27BgGCSLznpQ00rZ037lUWN
	 gHAeOFyqtV2Ol5EUJhTjlx3/gqxzF/21YPoSoom4gABwECbyjCy+TFYhFbvqtwtvHi
	 C6wYhqp+HoM8AfcULHC7cq2PKpROc+i8fXOa9VzZJ7mRgoK2MbHAKqXTiSUPyj++zo
	 yNir2+5SioIGdIHY2r0rRlSxbcUqGOJ/ULV1u5NW3Lx2DMaOni/w1U73UhVgNUM8oe
	 hRu3sup2skKdbWsbEvFahvyI3GDj2JtfKHxHggPoJXbYnxHauoxTrEccgazSMCrZpf
	 7hzzVAnnQiaLw==
Date: Thu, 17 Oct 2024 18:50:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com,
 dlechner@baylibre.com
Subject: Re: [PATCH v7 5/8] iio: adc: ad7606: rework available attributes
 for SW channels
Message-ID: <20241017185050.0ed82a03@jic23-huawei>
In-Reply-To: <20240919130444.2100447-6-aardelean@baylibre.com>
References: <20240919130444.2100447-1-aardelean@baylibre.com>
	<20240919130444.2100447-6-aardelean@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024 16:04:40 +0300
Alexandru Ardelean <aardelean@baylibre.com> wrote:

> For SW mode, the oversampling and scales attributes are always present.
> So, they can be implemented via a 'read_avail' hook in iio_info.
> 
> For HW mode, it's a bit tricky, as these attributes get assigned based on
> GPIO definitions.
> 
> So, for SW mode, we define a separate AD7606_SW_CHANNEL() macro, and use
> that for the SW channels.
> And 'ad7606_info_os_range_and_debug' can be renamed to
> 'ad7606_info_sw_mode' as it is only used for SW mode.
> 
> For the 'read_avail' hook, we'll need to allocate the SW scales, so that
> they are just returned userspace without any extra processing.
> The allocation will happen when then ad7606_state struct is allocated.
> The oversampling available parameters don't need any extra processing; they
> can just be passed back to userspace (as they are).
> 
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.c    | 52 ++++++++++++++++++++++++++++++++++---
>  drivers/iio/adc/ad7606.h    | 32 ++++++++++++++++++++---
>  drivers/iio/adc/ad7606_spi. |  0

Magic empty file :(

Sending a patch shortly and already queued up.

