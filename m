Return-Path: <linux-iio+bounces-794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C3E80BAA8
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 13:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516781F20FB9
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 12:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA450BE6E;
	Sun, 10 Dec 2023 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8nHEPhk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4E210A;
	Sun, 10 Dec 2023 12:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBA2C433C8;
	Sun, 10 Dec 2023 12:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702211193;
	bh=BAEGOiXxGiji7Yqd9F2gFQ5MrzDwy3Usblm+rgqjv30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k8nHEPhk3gGqCwrGy4zVJCHVGZVUJrtXP12s0QnFTgo441rpwwHWu7J9cxQLgm5fo
	 25VuSnGBiBJPU/MC05j/IZpl0rO/tR7SYUFZBgVxsAv3sya85ig2aBXxbNxPcY43ft
	 G8Lv8mGh6l5JI7ueaFM/Nwnwe1HTUhhtmZ7wjVyfhq8yBDgCynbpnE6SMlIwQiJL2M
	 Ib0TpHBM+ZruKCqrg3mjJ5SP+TKiOeP7BQnGaK9lvBfOcKjpsiwdVEn8A9hA7ZpCDH
	 1lgsF7gI/X/u8sHES276XDhc3iPgNsZC3lHc9dlKOgYaOJzbeoVCQ4xSiJ1ymaqS8c
	 OjkvVIXTUqI0g==
Date: Sun, 10 Dec 2023 12:26:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, apw@canonical.com, joe@perches.com,
 dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, paul.cercueil@analog.com,
 Michael.Hennerich@analog.com, lars@metafoo.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/13] dt-bindings: iio: Add AD7091R-8
Message-ID: <20231210122624.6a58b8c4@jic23-huawei>
In-Reply-To: <ZXMZ-Y18SwIFEIgA@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
	<53d55f3195b15bd8d47387e296036730ea270770.1701971344.git.marcelo.schmitt1@gmail.com>
	<CAMknhBEFnTUm9FPK-74+GkJs2d80dS+Q9WeGTxd3Ajs-JJGcdA@mail.gmail.com>
	<ZXMZ-Y18SwIFEIgA@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Dec 2023 10:28:25 -0300


> > > +
> > > +    required:
> > > +      - reg  
> > 
> > Missing `unevaluatedProperties: false` for channels?
> > 
> > Bigger picture: since no other properties besides `reg` are included
> > here, do we actually need channel nodes?
> >   
> 
> The channel nodes are not used by the drivers so we can remove them if we want.
> I thought they would be required as documentation even if they were not used
> in drivers.
> Looks like they're not required so will remove them in v4.

A lot of drivers assume that if you paid for a device with N channels you
probably want N channels. Of course there are always boards that wire a subset
but it's optional whether a driver cares about that.

We have drivers where not channel nodes being supplied means they are all
on so this is extensible if we later decide that fine grained information about
what is routed where is needed or need to add per channel controls.

So fine to drop this.

Jonathan

