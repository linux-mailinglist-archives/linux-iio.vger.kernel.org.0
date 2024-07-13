Return-Path: <linux-iio+bounces-7590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09733930552
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 13:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A3F1F21A75
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 11:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B3860263;
	Sat, 13 Jul 2024 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVUVj1WW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81C4C8E;
	Sat, 13 Jul 2024 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720868488; cv=none; b=mtvSnp3BW8ihDhcK/eQbxk6rDWuu3LDfQd+xooB46eMMBDybM7Mgf3EChwaGUa+Wbha3xPTglYRGa8hi17ZspCsH9Jbki5Rqj1XZsqDQjoXZvzQqxTDNkicGbG/QTDgADy5nxh+mWQpTfH3ZjMfAgoHxwDK3gC9AZvVeuipBk6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720868488; c=relaxed/simple;
	bh=bTZS6x4uxYP/7fvFmcxrRe472VptIxL6aaOUTbSBiP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNfaHZ07+XEQ41AlSAxxwr+7h/2aI7wRQbn0oCTFj5pKV/fNO4G+qbt/7JYzxBkh9XxBrb1ziSCXqi3TGKPeLmWJ0YgT0ocKsFOD+LPb886JgqqBUfxCcAjnQCzNxUvN3aVmyFeXLH8R+TvRp8bQr8GmO6lWse3nr5ji2b7iumE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVUVj1WW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1A2C32781;
	Sat, 13 Jul 2024 11:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720868488;
	bh=bTZS6x4uxYP/7fvFmcxrRe472VptIxL6aaOUTbSBiP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eVUVj1WWcL3xDSRLC0FU4BPiRO2T4in9LHm25ZGt/ej+nXjrETUCLenYj63C2iQCn
	 p5letp6x27B43JsUprYy4CQGPH1+f+ZecaWkOxidSU9DbQPV77JFBaQE2PZLUH7uDT
	 6+tE6oOtz4b+fmcX9SMArSLsJ4MBCbTDN1dvVivYsVeElMLrBsjdh1wnVeJ05u8bLz
	 4cFIQTZMdTCVz06GNvMPvxPTy8AXaccgXKLdng9ftYxkQJQOfZbDBoMynQiMK1WxER
	 aY3VtCzAuyzfS02S6ZtwFShUgF4E9uHthkE+KnqVuvRbybZMLLyG9o2GOZEqOzDWWJ
	 D/62ApKoDTCng==
Date: Sat, 13 Jul 2024 12:01:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] ROHM BU27034NUC to ROHM BU27034ANUC
Message-ID: <20240713120119.7739ed74@jic23-huawei>
In-Reply-To: <cover.1720176341.git.mazziesaccount@gmail.com>
References: <cover.1720176341.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jul 2024 13:53:35 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> As discussed here:
> https://lore.kernel.org/all/ff8d6d14-6b48-4347-8525-e05eeb9721ff@gmail.com/
> 
> The ROHM BU27034NUC was cancelled before it entered mass-production. A
> replacement was developed and named to BU27034ANUC. (Note the added
> 'A' in the model name). The BU27034ANUC has several changes that make
> the old BU27034NUC driver unusable with it. I was told the old BU27034NUC
> should not be encountered anywhere.
> 
> Hence, this series converts the rohm-bu27034.c to support the new
> BU27034ANUC instead of the obsoleted BU27034NUC. Additionally, the
> series adds a read-only entry for the HARDWAREGAIN to help understanding
> what part of the scale is contributed by the gain, and what by the
> integration time. This is useful when figuring out why some transitions
> from one 'scale' to other are failing.
Series applied with that tweak to fix the typo that is getting moved in patch 1
and to squash the first 2 patches.

Applied for now only to the testing branch of iio.git which will become
togreg after I can rebase on rc1.

Thanks,

Jonathan

> 
> Revision history:
> 	v1 => v2:
> 		- Split the one large patch to patches 3 - 6 for easier
> 		  review. (Please let me know if you wish me to squash
> 		  them to one).
> 		- Introduce new compatible for the BU27034ANUC and drop
> 		  the old one.
> 		- Add styling fixes as suggested by Jonathan
> 		- Fix the lux calculation coefficient selection logic
> 	link to v1:
> 		https://lore.kernel.org/all/cover.1718013518.git.mazziesaccount@gmail.com/
> 
> ---
> 
> Matti Vaittinen (7):
>   dt-bindings: iio: BU27034 => BU27034ANUC
>   dt-bindings: iio: rename bu27034 file
>   bu27034: ROHM BU27034NUC to BU27034ANUC
>   bu27034: ROHM BU27034NUC to BU27034ANUC drop data2
>   bu27034: ROHM BU27034ANUC correct gains and times
>   bu27034: ROHM BU27034ANUC correct lux calculation
>   iio: bu27034: Add a read only HWARDWAREGAIN
> 
>  ...ohm,bu27034.yaml => rohm,bu27034anuc.yaml} |  11 +-
>  drivers/iio/light/rohm-bu27034.c              | 343 +++++-------------
>  2 files changed, 89 insertions(+), 265 deletions(-)
>  rename Documentation/devicetree/bindings/iio/light/{rohm,bu27034.yaml => rohm,bu27034anuc.yaml} (66%)
> 
> 
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0


