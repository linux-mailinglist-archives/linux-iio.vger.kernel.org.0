Return-Path: <linux-iio+bounces-354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B247F8C59
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 17:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00088B21026
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 16:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4368829434;
	Sat, 25 Nov 2023 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBUlDWDB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CDB28E27;
	Sat, 25 Nov 2023 16:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36919C433C8;
	Sat, 25 Nov 2023 16:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700929324;
	bh=47slQ7C1k9AETzS9asZhacrAtG9GZsJQSECZIsdAGjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hBUlDWDBADGfqaINi7P44RSLl1DHvL1kAkuCDYaDJ1K1oYFoFYGZP8xO9r33MoOEP
	 o/nlZv20qLVTDGLVY09grPf1KLBw740Eig6hefAJ0Ak1OhroWuQv8wBbJfLmbto8vq
	 ydDaDAWC2IE8zkuiyvfoW0QUMPoXnm4+PoIcYeLNRmbdp3O99BXnnyCcO51dtVR+Mb
	 AGPeddIo+cZWuhqso81ECejiUT3qHRiJnSuP7uOJXSCOP58ilvlcdFxIOqtsw2rlzg
	 Ez0Nr7mdg7CvnyRAxNWpXYaVFM1QpDJRin33jq/NiXqRIs5dxIQQxIsrP7DNeFE1jf
	 wXIdo8otFungQ==
Date: Sat, 25 Nov 2023 16:21:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <paul.cercueil@analog.com>, <Michael.Hennerich@analog.com>,
 <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iio: adc: ad7091r: Alloc IIO device before
 generic probe
Message-ID: <20231125162155.2a3f980f@jic23-huawei>
In-Reply-To: <0a648afb9a06471380a7993b20cb44a9026c8248.1700751907.git.marcelo.schmitt1@gmail.com>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
	<0a648afb9a06471380a7993b20cb44a9026c8248.1700751907.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 13:41:59 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Rework ad7091r probe functions so the IIO device is allocated before
> the generic device probe function is called.
> This change is needed for a follow up patch that passes a pointer to the
> IIO device to a couple of regmap callback functions.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Why the gmail sign off? That's unusual enough that if it makes sense I'd like
to see a comment below the --- on why.

Patch is fine, though I'll need to read further for why this is needed!

Jonathan

