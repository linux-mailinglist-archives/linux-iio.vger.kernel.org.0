Return-Path: <linux-iio+bounces-5595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EEA8D7490
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 11:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B692A1F2152C
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509572D058;
	Sun,  2 Jun 2024 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4B4mmCB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C82A1A4;
	Sun,  2 Jun 2024 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717320330; cv=none; b=e2RzTtrhV5Aph3xke2Pyidl3AETLAn8jQORVr2M1p6L0YYV+giAR4QqEecHrr+3CY2FDBT9wSfPSsyyysOkIew86fy7msFr989uy2Wmyn0Ga8rfKrgdPLbjxUsYubPl6rYVEICIky9xxNKd5Bb0tRD7ADx7TnRLThPJ/40BvJXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717320330; c=relaxed/simple;
	bh=5G59ZGZ8Bb9BUnNuLFJr5g+hoeRVgjc6AjAo+T/emE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yp27kqXEk1rM3ehdUgP8+okUNGxRtAOtjRSocuTIX/KU+MmzqJ4egIPUldDoiLrt4Dmqa+PfBu6MIBaLgnNBUhQW40I/TGjNnhahN307wR1SEIq74P1tw5CSH5sFRMUdeyQAAHnXHbiDoorVn+OkX1XnQFGK00NLEXRVFF3AmEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4B4mmCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818E2C2BBFC;
	Sun,  2 Jun 2024 09:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717320329;
	bh=5G59ZGZ8Bb9BUnNuLFJr5g+hoeRVgjc6AjAo+T/emE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q4B4mmCB0JsdTvvK4drlVkcTbuajYl1u2yOzkq+cO18GtM+D9jf2UNLkn0caQd9wW
	 TQi/1mj6AFIBKQ4T1cjryb6nGuBJYWky0tLY6IMxDf1o/hO2p/4fC104KZfYGA16/X
	 YhV9oloOgRfbOEUfCd+cEkYn0fy8nEzrVHnU4QgtgRu7ao+VIhZvZcnuceCtiIrJ+J
	 12Ol5D6xP0e0gVucAiThrLy/isjbl9Nm79J18N6ilbIY03Cv1J4ecoKSKm6omkT3QB
	 ZQ1DL/kg9uZP27c8x1uclL4vn4aWyz/qHdh6qS0p7xJccrQVYRzPhb/pcWAiXixXn9
	 rCmHO3YqTWzhw==
Date: Sun, 2 Jun 2024 10:25:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Julien Stephan <jstephan@baylibre.com>, Esteban Blanc
 <eblanc@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] iio: add support for multiple scan types
Message-ID: <20240602102517.438b51b8@jic23-huawei>
In-Reply-To: <20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
References: <20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 10:14:07 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Up to now, the IIO subsystem has only supported a single scan type per
> channel. This scan type determines the binary format of the data in the
> buffer when doing buffered reads.
> 
> For simple devices, there is only one scan type and all is well. But
> for more complex devices, there may be multiple scan types. For example,
> ADCs with a resolution boost feature that adds more bits to the raw
> sample data. Traditionally, for slow devices, we've just always used the
> highest resolution mode, but for high performance ADCs, this may not be
> always practical. Manipulating data after every read can hurt performance
> and in the case of hardware buffers, it may not be possible to change the
> format of the data in the buffer at all. There are also ADCs where
> enabling the higher resolution can only be done if oversampling is also
> enabled which may not be desireable.
> 
> To allow for more flexibility, we would like to add support for multiple
> scan types per channel.
> 
> To avoid having to touch every driver, we implemented this in a way that
> preserves the existing scan_type field. See the "iio: add support for
> multiple scan types per channel" the details. The first couple of patches
> are just preparation for this.
> 
> [1]: https://lore.kernel.org/linux-iio/CAMknhBHOXaff__QyU-wFSNNENvs23vDX5n_ddH-Dw3s6-sQ9sg@mail.gmail.com/

Nice series. Applied to the togreg branch of iio.git and pushed out as
testing for 0-day to poke at it.

Obviously this v3 hasn't been on list that long, but there is still time
as I doubt I'll push out a non rebasing tree for a week or so.
This week is looking too busy!

Thanks,

Jonathan




