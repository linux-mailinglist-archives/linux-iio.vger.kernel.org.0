Return-Path: <linux-iio+bounces-14220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE0EA0AA57
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AED3A70C8
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9347A1BBBC8;
	Sun, 12 Jan 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpuP4Abg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF332F56;
	Sun, 12 Jan 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736694399; cv=none; b=kw9TBgzsicVo1IRzTDv6tqGyw/elbjq9sSQ7PhS0E7yLhps2u2llD3sGlfCUrinnMRWJZpOdN2QspPJGOV9GGNJzHhKNdv+V+ZJWkvfqEUc5DLXgfuZVs1gp64uI3wQyDz2zY0D8ehmmGwin3QGM3bna3A+L2kpbT+orr7LCWz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736694399; c=relaxed/simple;
	bh=j9dxERmc0I2noK+FjflMWw0Iot7d9t9l3GzFv7su9qg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meBUc+V+9LBpcbsKJ3LdxVekJ3Pauz3Pk9C7a8JNZfpgGt3vNSSvQP8/WmuLvWvhT24Z6ebclWUsjFq0kXdMzwpicD1Rr5oTpR4aM0W4tnA4/YWwEWHLgom7EuAxfK2AziaVf5fypCN3raZZkC5u8mvquv4rrxAv5eYbh/K8LQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpuP4Abg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98540C4CEDF;
	Sun, 12 Jan 2025 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736694398;
	bh=j9dxERmc0I2noK+FjflMWw0Iot7d9t9l3GzFv7su9qg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jpuP4Abg74N6jpmzZlaKlUEpAaKmxxP82CvA0tnK/hQ2tcfqe6N1ijUmfCc0v6uoB
	 gy2cyw+GSgiWOWXnAIavzN29Gr6q+99QzsSjwUIlcThmzwbXO+E9h7kWwzj7vaNxs7
	 s1HSMK4xctBBASJRe6Jw9u1GW+6I0z68/TEBwSDq6cd1iAFPI1pgKkZNclglk89B75
	 XzP/DaFuT3fHfelEEmvfJg865M6wJ3Mf33NtD1xZXYkPaJr8eXGjCGN649HADikRc5
	 CuklagMG491cq6n2tu0BIRDsqVYDrw8MtFtUGZNuyE1bQTxAYF6aLhELVBiVHptSjn
	 ix/jJCW+NQlow==
Date: Sun, 12 Jan 2025 15:06:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 Sa <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/9] iio: dac: ad3552r-hs: add ad3541/2r support
Message-ID: <20250112150629.6999b500@jic23-huawei>
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-8-ab42aef0d840@baylibre.com>
References: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
	<20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-8-ab42aef0d840@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 11:24:20 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> A new FPGA HDL has been developed from ADI to support ad354xr
> devices.
> 
> Add support for ad3541r and ad3542r with following additions:
> 
> - use common device_info structures for hs and non hs drivers,
> - DMA buffering, use DSPI mode for ad354xr and QSPI for ad355xr,
> - change sample rate to respect number of lanes.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
I think the question I posted on v2 (missing there was a v3)
still applies. Please check that thread.

Jonathan

