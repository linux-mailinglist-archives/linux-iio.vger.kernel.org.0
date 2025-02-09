Return-Path: <linux-iio+bounces-15192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 011FEA2DFA4
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4783A147B
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 17:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC5C1DFD85;
	Sun,  9 Feb 2025 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw/m2tDP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F00E1D934D
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739123702; cv=none; b=Ipohvc08soGrTSTXkTtOjSln1tt8SEfay0/GwNpAHPWfQ5q2Sz1DajTowqZ5BxlbelXYLYn+AHUyDKXq9LbyhWe1udYFhfC4dYEQJbCLT2gbXMgXOM4/yGlc2IJ2Inka19UXr9TBgfNV3CIUaHVdwJvgAIOYgx9Wv99fX+eQzEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739123702; c=relaxed/simple;
	bh=ctR41YpJjJUg+QaT5ER+nQ+jcY0sAyM6n/zUc7ESZDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SsMBjAmnh4/8REWX4w+X5zoRxm+ocF5FCfxbh5IoFCw/5+8HZOAKWG8EuY5CY5R+tX8kkp/OwEO5rwwtp8ZFyrSzWmLHvOm/k+nDuC+KdQa2+2qTwXpXak1UuTLvxnabHmeKtpJeIatgZ5qpdLgzTMgVHUVUeyLDv8ixOmwBATY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw/m2tDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA27C4CEDD;
	Sun,  9 Feb 2025 17:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739123701;
	bh=ctR41YpJjJUg+QaT5ER+nQ+jcY0sAyM6n/zUc7ESZDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cw/m2tDP3XyagAEXMYeJSpDQv58DQ/dITUXHAZATIXpNzbC9qcH8LNLaiRlKvzOM5
	 afT7OdmIoJqwuRKNNdpCPCY2oBpWaEn+h3yF92Z6EZrklBKNCETZ1Q2JShROjBpzAn
	 OMStUUV9mda5AsSPN/0pYa85NU84pJoWLpEVyvW4CR6E6gC3jkNoOBZPsJEW+NREaH
	 EmznaQlL8A5WZ1DwEMMX2OHOdImGGaassLEHetGJ/LbZbnBr5UfhZI1YkOmb31JKQd
	 1yOXYUd7LzolRuTGrhkELJQVlRtJX0+fx3esHy2cWdGEsRpEIj9A3jheAARZvtEkZN
	 Oa6z5avP1EU+Q==
Date: Sun, 9 Feb 2025 17:54:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Mudit Sharma <muditsharma.info@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, Mariel Tinaco
 <Mariel.Tinaco@analog.com>, Angelo Dureghello <adureghello@baylibre.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, Ramona
 Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols <gstols@baylibre.com>, Cosmin
 Tanislav <demonsingur@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Gwendal Grignou <gwendal@chromium.org>,
 Antoni Pokusinski <apokusinski01@gmail.com>, Tomasz Duszynski
 <tomasz.duszynski@octakon.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 11/27] iio: adc: ad4695: Stop using
 iio_device_claim_direct_scoped()
Message-ID: <20250209175449.024d3b68@jic23-huawei>
In-Reply-To: <896ab8aa-3cd6-4e78-9374-8883bacd1fff@baylibre.com>
References: <20250204200250.636721-1-jic23@kernel.org>
	<20250204200250.636721-12-jic23@kernel.org>
	<896ab8aa-3cd6-4e78-9374-8883bacd1fff@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 17:28:42 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/4/25 2:02 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This complex cleanup.h use case of conditional guards has proved
> > to be more trouble that it is worth in terms of false positive compiler
> > warnings and hard to read code.
> > 
> > Move directly to the new claim/release_direct() that allow sparse
> > to check for unbalanced context.  In some cases code is factored
> > out to utility functions that can do a direect return with the  
> 
> s/direect/direct/
> 
> > claim and release around the call.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: David Lechner <dlechner@baylibre.com>
> > ---
> >  drivers/iio/adc/ad4695.c | 240 ++++++++++++++++++++++-----------------  
> 
> FYI, we still have a patch [1] hanging out in patchwork waiting for dependencies
> that will have a merge conflict with this. Should be able to pick up that patch
> since -rc1 and then rebase this one on it. Or we can do it the other way around.
> 
> [1]: https://patchwork.kernel.org/project/linux-iio/patch/20250109-ad4695-oversampling-v2-1-a46ac487082c@baylibre.com/

I tried that yesterday. Depends on your SPI offload series I think, so
no way to move that forwards yet.

I'm sending a v2 anyway for this series as enough small tweaks +
I'd like it to sit on list a little longer.

Jonathan

> 


