Return-Path: <linux-iio+bounces-13648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78FE9F7E1D
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388B9163B2B
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680B313A41F;
	Thu, 19 Dec 2024 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHz2ea7w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180432AD16;
	Thu, 19 Dec 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622382; cv=none; b=WBaeDpzEkv+LlFFCwsz1yRfeC6vN24LRrUEKFUrrw4h6uroEuCPWaoMV2eWO5IMBV/RY0slEAVtvcbsAbH6Avw9dN3qXGW+DswggTrgsXm6YCubWTPssfHKS9HCr4h9C7yVGCK14OOFmrU6EqjOxaIIT9rcuy9AM3vCu8I1q+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622382; c=relaxed/simple;
	bh=/sVg8YJlbgeFVibg6y68ytLnOLpFfzyu7Lm77ldwzJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXbhiDOEMSXMbCl1Vi5KX/4BBywKlqQ12avnl4TU0iZfGa6vwdQMGF776MVH3O6VSvFXzWilAutW4KxKfibfK333sZ1RF51LQrdObNgFM57EXGwq2shlPfkS/OnzvtIHQ28VacwG2GFMnSUlcM2dv30dK4+ssbqyfDyfzeYGPmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHz2ea7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F070C4CECE;
	Thu, 19 Dec 2024 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734622381;
	bh=/sVg8YJlbgeFVibg6y68ytLnOLpFfzyu7Lm77ldwzJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jHz2ea7wQstqiUE9mm5ueLcY8oKlAgPA5xId8sjHmnmct+k5ZVlyVlIn69LDzA8Wi
	 WtaqYBRGF/C+l3dVRgQz1WA9vSGI3kbNgJGdABR8vb7PUFa2S889QZSAacN5pTWhfS
	 DdvJcbkDOOS/n0c/u4DVVKhn/jBguPzuQ93WnjpWWSJ6+/C2iJritEGf2aVyYgFq22
	 FY82Al/4UaY0bCV5jn/oh97iazgF4v3A9kj8ELZyybNnd4ffSo+xmaM+APTKmbFhJe
	 s1Ly4vnJwJVTRgZBbiAN88YRXejYi4bzD8K0H5MIhV3qZFk3nxxyyFXM6kJo1eeD2d
	 zyXdXXXH9PP/w==
Date: Thu, 19 Dec 2024 15:32:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: mgonellabolduc@dimonoff.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Mikael Gonella-Bolduc
 <m.gonella.bolduc@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: media: clarify stm32 csi & simplify
 example
Message-ID: <20241219153249.39b49561@jic23-huawei>
In-Reply-To: <20241217-brilliant-jubilance-54641c6ba990@spud>
References: <20241216-apds9160-driver-v3-0-c29f6c670bdb@dimonoff.com>
	<20241216-apds9160-driver-v3-1-c29f6c670bdb@dimonoff.com>
	<20241217-brilliant-jubilance-54641c6ba990@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 18:31:09 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Mon, Dec 16, 2024 at 05:55:40PM -0500, Mikael Gonella-Bolduc via B4 Relay wrote:
> > From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > 
> > Add device tree bindings for APDS9160
> > Note: Using alternate email for maintainer
> > 
> > Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>  
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Conor, any idea how we got that title on a reply to a completely different series?

Anyhow, I'll assume you intended to give RB to Mikael's patch!

Jonathan

