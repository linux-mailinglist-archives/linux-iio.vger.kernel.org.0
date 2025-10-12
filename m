Return-Path: <linux-iio+bounces-24970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54241BD0599
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51031188E6CD
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 15:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C2B2EB5C6;
	Sun, 12 Oct 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g15LZRdY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9A2EC0AA;
	Sun, 12 Oct 2025 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760282600; cv=none; b=eZB52deshxN70ABNa6fslvV6NOMikyuYSebomzOONnEXyN03FsASiHyao9TuHNYNccJ9aCJxge6vvpn3XMUnHVs+OITiOu68euubJQGnm7aekZmx/qV+4JKz6f51wrcbgoEZT6hd8EHKtuVqGRpe//3uCIbf55jG4M309Ebi7hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760282600; c=relaxed/simple;
	bh=9X5D3gE5jGP/3FwrCSYsyv/KGFZNyBK4E5mSj9kxgp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tf1inH46mo0Cqmf/WLBg+RZjQUtHiEKLa0MRAHh9Xnfpii64wV/y0bnw8OGwnpORfWGfb8rqWWixG2udOQVvP3N1mhgcw5dRGMJ7W51/Bb3sHnyXMEs6V60EU+cRHpYfRpa3QdzDaHwvM6q4q9AXzbUfNd/Ir3wX+OzUBB1ip4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g15LZRdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3B5C4CEE7;
	Sun, 12 Oct 2025 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760282598;
	bh=9X5D3gE5jGP/3FwrCSYsyv/KGFZNyBK4E5mSj9kxgp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g15LZRdY47+oVD24qGtuDgRKH5szM0yVShcokfcsbjrOcouODFVsJZHniDebk86Z+
	 MxG7fvu7nldEJFZQ1puoNyhReai8X83UHDkRphfoz8MuzjYhCGQDAljKBbyOvPkB2W
	 aPtOMjhvbQhQYcWJrL9RdeP62Mpg1yvuw8NK6B9UNKqkYhZHRqBmMlnQJi03DkpxpX
	 1dISyuG5DuYyD3h8AX5Ik0ncZNshl4vP1AxuACroF99fWncBo7/24+qDG9+WoDh385
	 BJL3ADagJMxbF7joiEBrrNOpVMoyLoMpiIIOJBOZxEfGal7ae/xOT4qgi9iTZJr058
	 iDq46a5PckV7w==
Date: Sun, 12 Oct 2025 16:23:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/19] iio: accel: bma220: add LPF cut-off frequency
 mapping
Message-ID: <20251012162311.2915122e@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-17-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-17-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:26 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add mapping for the low pass filter cut-off frequency.
> Make valid values visible for both the cut-off frequency and the scale.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied.

