Return-Path: <linux-iio+bounces-9836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 438D698902E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCA11F21C25
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30CF5478E;
	Sat, 28 Sep 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3vn+iXD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A418030;
	Sat, 28 Sep 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727539062; cv=none; b=lwYPal/JmhOKjxEVhpPZaCoUzNi3YNSQNdOvhOpleV/wrt8xlHSc44ePkM7v1hdyYK8pTMPh9BAx1XHJj/n3N0keRGyx1KUmS/W8sqW7U2Sv2C6goMXLnea1dSqDdjWhRL5P2OC6OacyWteIatmnumHUgOFVx2RVXjWaTsKtwI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727539062; c=relaxed/simple;
	bh=wGj282cuzEInS8/dLr0Pj5jeNenvFwH+aquZbxThikE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTi0A8envHo/+1eDWtuF3wuLR3zxUV0IiFPMXfaxW+ELGvLAN/H3HCKnVHB+hsRdUUnvh1l/ojUQa2gyOngeEi1WOqA3O1kUmbpPcyl8d6uKLE+5F202rK0ZGMkrC+UatMYcZn4ZWCkb1M8Tw7mNBkgfh9X9lWPoalSshRzFBG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3vn+iXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AD0C4CEC3;
	Sat, 28 Sep 2024 15:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727539062;
	bh=wGj282cuzEInS8/dLr0Pj5jeNenvFwH+aquZbxThikE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A3vn+iXDHx+yhf6IQLO1qg8PkzO2iM50HgSmdHAjPsn0et6CRqKSd2sqittlSkkF+
	 WzBvB+B6PtxUEyKzTuUFN5UHegv/rNPDZ+StBNCbhLhmjV8a/QXD9tX8AtyuVLrVDY
	 Y+H/rGa/tAfZGh4//0gQXrNAbB6vkBXK4g0D1opwg3pRMhrxx4pF+GrERfNMhidKJp
	 4vyzf8kYUSWdCiK7t592GqEgiQbzjobyQOU+v7qL9+bzBMApM1UlEz5OxTm5Ayd287
	 5FcE+Vwi0+x/fODoBHpzt3KzzuOIjGSYmpk6UEVv5DukTVYdZYTA359cM7PIgOyLJi
	 CfyZFomH6CABA==
Date: Sat, 28 Sep 2024 16:57:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Emil Gedenryd <emil.gedenryd@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v3 1/3] iio: light: opt3001: add missing full-scale
 range value
Message-ID: <20240928165737.6ed1e4ff@jic23-huawei>
In-Reply-To: <20240916-add_opt3002-v3-1-984b190cd68c@axis.com>
References: <20240916-add_opt3002-v3-0-984b190cd68c@axis.com>
	<20240916-add_opt3002-v3-1-984b190cd68c@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Sep 2024 16:56:37 +0200
Emil Gedenryd <emil.gedenryd@axis.com> wrote:

> The opt3001 driver uses predetermined full-scale range values to
> determine what exponent to use for event trigger threshold values.
> The problem is that one of the values specified in the datasheet is
> missing from the implementation. This causes larger values to be
> scaled down to an incorrect exponent, effectively reducing the
> maximum settable threshold value by a factor of 2.
> 
> Add missing full-scale range array value.
> 
> Fixes: 94a9b7b1809f ("iio: light: add support for TI's opt3001 light sensor")
> Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
This one is already queued up, so you can drop it from future
versions of this series posted for review.

Thanks,

Jonathan

> ---
>  drivers/iio/light/opt3001.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 887c4b776a86..176e54bb48c3 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -138,6 +138,10 @@ static const struct opt3001_scale opt3001_scales[] = {
>  		.val = 20966,
>  		.val2 = 400000,
>  	},
> +	{
> +		.val = 41932,
> +		.val2 = 800000,
> +	},
>  	{
>  		.val = 83865,
>  		.val2 = 600000,
> 


