Return-Path: <linux-iio+bounces-12536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28419D69AF
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714F3281C14
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FF733080;
	Sat, 23 Nov 2024 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Swdxg81U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7723098E;
	Sat, 23 Nov 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732376232; cv=none; b=M5syeT7oK0lixZHRb0lxP0/zvYO7nkM54KPJWI1+NxOatiNYjyX4y2LUp3FtpekcfeGY8Cg4ANEHBIkv7SauK3n6CtghS6M3s3wX1eKU5ax+QI/BuRV5Z7FTBHz+lyMZsBAsk6ttm0TeTe6zoj4LRdhBm2jJ4UJ83X7YsYDpJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732376232; c=relaxed/simple;
	bh=RPiOqidyOV/NWVQ9oXhA/VUulFLzx1Lvj2UzV1aNtnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lO7YIbTcxamxY2wIEejWDyPZOzdEZoIawmZ7pCWcQ+UjjXjHRbsP0bo4iCbEIyKaiaUgrCAOYY5yNCpV/qlfJpVL//7bmenuNO7UmRXS+t7ElQUo3EMMxNlMGhESKU4zeLrpzBPC0SS3VBcUVlx5bDEW/mdzfXFkLvX4PL/VAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Swdxg81U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9D2C4CECD;
	Sat, 23 Nov 2024 15:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732376232;
	bh=RPiOqidyOV/NWVQ9oXhA/VUulFLzx1Lvj2UzV1aNtnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Swdxg81U3ta3VJQSnie2oqvQcr6TiAaqw1AH5Es5uDrU+1D9P7c23qmT6Icm2xS8m
	 llRakM7FbuvUxOCgTufMzUkDVUoid7KNt/Q66drJLqtEsJksk2iN4b0PTzekUQ2XJ2
	 o+ACpXjZkM9MwsXkNLqoT728BJPDpcvC7hBC8KwINGOFMS12osGRSXLeKZXCUjq74d
	 wyCnZJaFOHHujQH+QcqymW+H6hPBSdTauwvaMFdMDpCyobhS3xgmAqSjW1VRI4RFr4
	 fYe6XoxGdH14yBtnLXK9lIkbEj6CpTHSckHAstJXM7kEqZ47qo6V5o4J8/Tfp7IWSq
	 ecbUuYLdzEPgg==
Date: Sat, 23 Nov 2024 15:37:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, Han Xu <han.xu@nxp.com>,
 Haibo Chen <haibo.chen@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v2 0/4] iio: accel: fxls8962af: add fxls8967af and
 fxls8974cf
Message-ID: <20241123153702.38ae115c@jic23-huawei>
In-Reply-To: <20241115-fxls-v2-0-95f3df9228ed@nxp.com>
References: <20241115-fxls-v2-0-95f3df9228ed@nxp.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 15:23:56 -0500
Frank Li <Frank.Li@nxp.com> wrote:

> fxls8967af and fxls8974cf are similar with fxls8962af, only change ID.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied to the togreg branch of iio.git and initially pushed out as testing
for 0-day to take a look.  I'll rebase on rc1 once available.

Thanks,

Jonathan


> ---
> Changes in v2:
> - make nxp,fxls8967af and nxp,fxls8974cf fallback to nxp,fxls8962af.
> - Link to v1: https://lore.kernel.org/r/20241113-fxls-v1-0-5e48ff1b1fb8@nxp.com
> 
> ---
> Haibo Chen (1):
>       iio: accel: fxls8962af: add fxls8974cf support
> 
> Han Xu (3):
>       dt-bindings: iio: accel: fxls8962af: add compatible string 'nxp,fxls8967af'
>       dt-bindings: iio: accel: fxls8962af: add compatible string 'nxp,fxls8974cf'
>       iio: accel: fxls8962af: add fxls8967af support
> 
>  .../devicetree/bindings/iio/accel/nxp,fxls8962af.yaml      | 14 +++++++++++---
>  drivers/iio/accel/fxls8962af-core.c                        | 14 ++++++++++++++
>  drivers/iio/accel/fxls8962af-i2c.c                         |  2 ++
>  drivers/iio/accel/fxls8962af.h                             |  2 ++
>  4 files changed, 29 insertions(+), 3 deletions(-)
> ---
> base-commit: bd05b9a700c10473c2f52bf12c5c5938c30e80b0
> change-id: 20241113-fxls-d93a888889f7
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
> 


