Return-Path: <linux-iio+bounces-362-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5A47F8CC2
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 18:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BA0FB2106B
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 17:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98BE2C86C;
	Sat, 25 Nov 2023 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbQK1jgy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B59DF66;
	Sat, 25 Nov 2023 17:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20319C433C8;
	Sat, 25 Nov 2023 17:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700933285;
	bh=SdEIJH9TzgPXfaP1Q2Dpkp+FAEfYhe/GjdmyR7hDB+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SbQK1jgydoMznxVji1B2PXND/RwJ/X1wxjP/8wICn9krvA2d74vnYLrabHpMu0QjE
	 Rm5m3ybwhM1S+daLt0AqhBj1djVoe8E4wjf+6AvOvNc1eSN8gpLg61hyTIDwxDXUdE
	 Xfc4mqe5jESNPIgeOoKq3vJeRx/T9Zk8rxc86d1gp8LIWGMzyZxxYdAfAZG9w8nh9v
	 RAfM0aUsTPMR5rFn77Tm0AcIT/9KHHcftFqu4pT15XB+PaRuzMye0bsnc4jXMar2UQ
	 N2U/0YS1Bxm4W3uzGLZENfXGmj01l9ev3ZY6QoIqnwev29aR4mArPjcn3xjBJN9F25
	 ATwXeUnNLoCwQ==
Date: Sat, 25 Nov 2023 17:27:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Crt Mori <cmo@melexis.com>, Rob Herring <robh+dt@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: temperature: add MLX90635 device
 bindings
Message-ID: <20231125172758.04b0254e@jic23-huawei>
In-Reply-To: <ea997987-6a84-445c-a806-527d766569b1@kernel.org>
References: <cover.1700648164.git.cmo@melexis.com>
	<2e8b4a7d3ef4bc1c53bd0a849e4c31eaf2477f6b.1700648165.git.cmo@melexis.com>
	<99d1808a-da04-4bc1-a1f7-cbd269adbbf0@kernel.org>
	<CAKv63uv87srZ3gJxFASuGWV6cULXkN=gYi_L=BCcd3dgOFQEfw@mail.gmail.com>
	<ea997987-6a84-445c-a806-527d766569b1@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 13:35:19 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 22/11/2023 13:28, Crt Mori wrote:
> >>> +  Since measured object emissivity effects Infra Red energy emitted,
> >>> +  emissivity should be set before requesting the object temperature.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: melexis,mlx90635  
> >>
> >> It's the same as mlx90632. Add it there (as enum).
> >>  
> > 
> > Properties are the same, but then you can't have much differences for
> > a temperature sensor. It has a bit worse relative measurement error
> > outside of the human body range and overall different DSP, register
> > map, even physical size - it's 1.8x1.8 mm compared to 90632 3x3 mm. I
> > was not sure how it qualifies for adding it as another enum, but I
> > went with the feeling that if it can reuse the driver, then it is an
> > enum, otherwise it is a new file. And I could not reuse anything from
> > 90632.
> > 
> > Thanks for quick feedback and best regards,  
> 
> Driver is independent choice. There is no need for new binding file if
> everything is the same from bindings point of view.
> 
> Best regards,
> Krzysztof
> 
> 

We got this wrong in the past in IIO and it's a slow effort to merge
the various very similar bindings.  For now we are mostly keeping
to within a vendor though unless a driver supports parts from multiple
vendors.  It potentially gets too confusing to maintain otherwise.

This one is easy case though so definitely merge as Krzystof suggested!

Jonathan

