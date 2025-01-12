Return-Path: <linux-iio+bounces-14208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 167F0A0A9A4
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 14:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038463A74F0
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8031B6539;
	Sun, 12 Jan 2025 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b14iEPYK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF25175BF;
	Sun, 12 Jan 2025 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688935; cv=none; b=HsJ5s5N9VYU5KVZte8/ZcX+wOpcxTN1pYZ7gLCbMOEoHqQJNuE+IeqUSgpt14YXLhvFqMQK1KnrNi16K+ywSR9TMrhvJgL9qapiMsOw+eLU4aEg32UwAbYu3LEpgO+EE3g19EpOMoAb4OHXFD9GgXzueZN7U6hg6upJkOWPNezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688935; c=relaxed/simple;
	bh=nZWmGxBf/FzLuekQQdytPq8ssxAaXAXGfRiihdWeMiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/F0Bd0h43PNkSW2z+a5nt213EzAUVTHLDTyBJnTl3fmdBWsSf8UF3dJcEtqFE2cgqQF8OI/EUbhHc2Yg+jT85gp0dfpxGVZe4FxlOt6rn8JZWjYPngozRzihzUqTCTj7F4Uo+P7t0mlUW4xt+wtbI2RYdlcsaCGEhlQ53Uz8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b14iEPYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E25C4CEDF;
	Sun, 12 Jan 2025 13:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736688935;
	bh=nZWmGxBf/FzLuekQQdytPq8ssxAaXAXGfRiihdWeMiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b14iEPYKs1b5DxiAOqYQmDEWDvLga2bx/PuH+l1lNEpMliZ2s1i07km9fuLSdczqu
	 htvLOd3EHUm4b5ne2P9C9D4AQMxzjnaCRlBF9uFjILgp7/cFnZtdZrczNFJA7K5mQ3
	 3Vt3FP1Xl84OYjKamGW8ICBA9xALg67aW1iL4jjjrNR7O48CmmLAKksTWmJxIpECeA
	 g/foP5lADaWd6+PxxjtIxgHh0qzV2NIjxGSKrQ1BBDqs38IJmmc50bKeWH7JPofjl/
	 nlsoEXSQfV6d2CQDjTV8/b5juzLucrb5L6vFFBW+XroM5zFwY4OaP6pehPySjVn1+X
	 mmC9VaUCo1S5g==
Date: Sun, 12 Jan 2025 13:35:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Mihail
 Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] iio: dac: ad3552r-common: fix ad3541/2r ranges
Message-ID: <20250112133526.4f7bdb00@jic23-huawei>
In-Reply-To: <2c43b7a8-1005-4364-83fd-b2a06cb18a25@baylibre.com>
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
	<20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-1-2dac02f04638@baylibre.com>
	<2c43b7a8-1005-4364-83fd-b2a06cb18a25@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jan 2025 14:43:22 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/8/25 11:29 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Fix ad3541/2r voltage ranges to be as per ad3542r datasheet,
> > rev. C, table 38 (page 57).
> > 
> > The wrong ad354xr ranges was generating erroneous Vpp output.
> > 
> > In more details:
> > - fix wrong number of ranges, they are 5 ranges, not 6,
> > - remove non-existent 0-3V range,
> > - adjust order, since ad3552r_find_range() get a wrong index,
> >   producing a wrong Vpp as output.
> > 
> > Retested all the ranges on real hardware, EVALAD3542RFMCZ:
> > 
> > adi,output-range-microvolt (fdt):
> > <(000000) (2500000)>;   ok (Rfbx1, switch 10)
> > <(000000) (5000000)>;   ok (Rfbx1, switch 10)
> > <(000000) (10000000)>;  ok (Rfbx1, switch 10)
> > <(-5000000) (5000000)>; ok (Rfbx2, switch +/- 5)
> > <(-2500000) (7500000)>; ok (Rfbx2, switch -2.5/7.5)
> > 
> > Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

