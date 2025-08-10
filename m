Return-Path: <linux-iio+bounces-22517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3462EB1FB88
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD1F18831D3
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 18:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6918D226D00;
	Sun, 10 Aug 2025 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGR04YNG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC48F66
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754849074; cv=none; b=UgfkthVPiWDvdq01OkaIRzKm/Y+gPnzTWG760I3zfBoNwR237jLgcLYyC4/NB2pC8FIVrhs5GfDOPnlzpkEcm2xTqUps5U+FVcMD7M3JVLpEOOnIqTxVh7vF9g+KfZcyY2ZynSTbUWTL+ZIvcv/j/LA645hgihsBTFHKHKzGsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754849074; c=relaxed/simple;
	bh=lAUGWwwvKUp65D+DlUj7GyYAICBa/CPr5fZicrdUv1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xnl5Wh0WTEQSbGN0rWFbjwkH6Pp5jRI79i8fui/uSESzcTkMKokFOvSKAl/QKvzAvGJxG2tf/k5gL/tTzdcMVGXf0vJD4kv+sgvraj44UYesFqflPfK5MpADEHFLEKB7Ie2lQD4bTWMkaNap2+wTvjIahZ2SByny4QPsPBxsAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGR04YNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB3AC4CEEB;
	Sun, 10 Aug 2025 18:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754849073;
	bh=lAUGWwwvKUp65D+DlUj7GyYAICBa/CPr5fZicrdUv1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UGR04YNGl6IS1TTrQG2I8zs7Uw3Cfd7rtjV4/7imtcexLMH9CRVAqvrYjzurqyDj0
	 PMS4Ya19LL6GohiXH4pHolu2RAs7dUg2J9PXv2TKL6O4/qQLzKRaOORWYuPn8RGUTc
	 XILJJxWudHesAxmFaRsCl526z8PDBO79B7qxw+qM7ZaOoZn/DG7+9rTiZr2G7ZgSqe
	 MQicOcJLP3q3+naW6dFIBM+1FR49gS7cPuIwQpcDXsiUBjXKPWcyMbN5T6PjopIZF6
	 FgBg3GVzm5YyR2/rNz2JgLMWx16tsTbN9tC+QdTibG7DyG3ADmK+RLlgU8DhJjpP8p
	 8ihd0pxTSJprA==
Date: Sun, 10 Aug 2025 19:04:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: ASSI <Stromeko@nexgo.de>
Cc: linux-iio@vger.kernel.org
Subject: Re: [bmp280 v1 1/6] iio: pressure: bmp280: correct meas_time_us
 calculation
Message-ID: <20250810190426.75a84359@jic23-huawei>
In-Reply-To: <87ectomj4c.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-2-Achim.Gratz@Stromeko.DE>
	<20250806164625.0000217e@huawei.com>
	<87ectomj4c.fsf@Gerda.invalid>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 06 Aug 2025 19:53:55 +0200
ASSI <Stromeko@nexgo.de> wrote:

> Jonathan Cameron writes:
> > I'm not following this. Why are we now effectively adding MP280_MEAS_OFFSET
> > that we weren't before whether or not oversampling is enabled?  
> 
> Because that is a constant part of the actual measurement cycle that
> happens entirely independent of any later measurements (whose individual
> durations depend on the oversampling settings for the respective
> channel).  The graphics early in the datasheet don't show explicitly
> where in the cycle it happens (my conjecture is at the end when it has
> to update the IIR filters and swap the registers), however section 9.1
> in Appendix B is abundantly clear that it's there.
> 
> 
> Regards,
> Achim.

Hi Achim. I'm a bit behind on reviews this weekend after a garage door related
crisis (now resolved) so might be a few days before I fully catch up.

I have few mins now though so quick replies where I can!

For this, thanks for the description.  Please add something on this either
as a comment alongside that constant referring to the datasheet stuff you
mention, and/or something in the patch description.

Thanks,

Jonathan

