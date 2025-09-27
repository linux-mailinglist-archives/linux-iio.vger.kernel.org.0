Return-Path: <linux-iio+bounces-24501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105D5BA61DB
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 19:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D0C1639C4
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3818B21A444;
	Sat, 27 Sep 2025 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzbUTwtP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E469146B5;
	Sat, 27 Sep 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758992466; cv=none; b=cHGIoD2MRZA5Z40yoGrU461oK5qt9RFzGBCUWLwtUIv/0ZtlpQEfwa55iSFH7TaG+io6C/9s1Xb+1UBYDnh4v004An6fFa77JoVWOX+Z0OTszLwmR6RtthEBA+6O/RQAUwm0ASxNr1a9uf6HiTDpf3KX2OEACNj0C+p8sk9sReM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758992466; c=relaxed/simple;
	bh=n2nTeLhnB1YwsJtcxhRWqzFPO9O7HrX45d/S+eWqvMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xs725kGbTZHfR5kfIjW/vU2ggasWwxxyOh4CWfLV5OKF+4W2rSZ6Jbf0DbiIZjh2+0xG3Yb70OyuBmI13CvhvC0pcImOi8L1cwyrL/KE2ckptdLH75XGpZ5xdVAFHa/0tNGeKMczdMwrohWMRdBU5vTPFVv2tS0hE+WgeTKePqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzbUTwtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892C7C4CEE7;
	Sat, 27 Sep 2025 17:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758992465;
	bh=n2nTeLhnB1YwsJtcxhRWqzFPO9O7HrX45d/S+eWqvMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZzbUTwtPaepm7BU3gzNW3C/3tcL51N1rHjfYclMdMQLlRhpSe/8rXbvAmla/6MD37
	 qVacOxe8an+wDefu+XyevgV5L+1b7tFaIQbifdK/jljH7efDKkT0zm0JaQ2sKqZSiA
	 i0wpJcbER7ST6t5nZeUxKP59eKxBL4jFgXHzzVPAoDnBefLWjIfMDOcOHhBH/xYvXr
	 mk3RK81zIpnWEEC6dxhm5NF/4wshSNE52I4IK1QadeFd/X6ptr5ukfT9vT/c0rNZrf
	 2LQyIWtEuOgMLF4mD4fralo3bvRxbpUGCGsSOerWcD6AAFS2/yKpR6Zpi/h567N11A
	 51EbdsW2hgxFg==
Date: Sat, 27 Sep 2025 18:00:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: adding support for Microchip
 MCP47FEB02
Message-ID: <20250927180056.38b1822f@jic23-huawei>
In-Reply-To: <7836f862-5320-4a81-b15b-4ada08e78077@baylibre.com>
References: <20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com>
	<20250922-mcp47feb02-v1-1-06cb4acaa347@microchip.com>
	<7836f862-5320-4a81-b15b-4ada08e78077@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > +  vref-supply:
> > +    description: |
> > +      Vref pin is used as a voltage reference when this supply is specified.
> > +      Into the datasheet it could be found as a Vref0.
> > +      If it does not exists the internal reference will be used.  
> 
> It looks like there is also the possibility to use V_DD as the reference
> voltage. Not sure the best way to handle that though.

Indeed that's awkward.  I suppose a custom property as choice of VDD or internal
reference is unusual and it might be critical to how what is downstream of the DAC
so we can't even do it via userspace _scale control.

I'm lazy so haven't checked the values. If the internal reference is near VDD
it is probably safe enough to just make this a userspace problem if anyone
ever needs it.


