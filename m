Return-Path: <linux-iio+bounces-19097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FDDAA93BB
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 14:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4978F7A543A
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2302505AF;
	Mon,  5 May 2025 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sB/Z3aLi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40381146D53;
	Mon,  5 May 2025 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746449851; cv=none; b=nD27o5tamtct9O23Gmz4EIN0pjXo5bM4r8BX5PFMiAmVCk35xTgxP48Npr0LZtz3HJWqzrJRh71imPLzJhLJbctj3KrYPcgZYGeBRmoC9zIrYxp8Vvzwj3F1q0WkVHG1qEhMfjzRxrjzGIlrTd73YJPGkrakuRD1V16kQZGk6fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746449851; c=relaxed/simple;
	bh=BfQINhywxNEE/d5oF5VRqStlHY1hf0YQW1XNyzwHuEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tve+tjY4M5S2Hzth2RJWxMrQujPGE8hxSp8E/5pzNH9DhOdZmLo59CAFwjhxwuz8XF/5fDYFu3DZVCnRh5oreneYxghDadZO634l74HfNu66g0jeCc2rVSBQYH98qjRNAAV3uRey2ADkDDcKb6H+QSvj35hYC6PtBhOMMxH7LtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sB/Z3aLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A898AC4CEE4;
	Mon,  5 May 2025 12:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746449850;
	bh=BfQINhywxNEE/d5oF5VRqStlHY1hf0YQW1XNyzwHuEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sB/Z3aLigpGFgkEpfi8dQumwgTOe+fKctjKH2ddW+R3j0VDdxZ9VI4CPsckzLr4Np
	 /vwvRD+ha6oxh5IZYnpy/PfbWOZ15lC0b+hR0iQSFgrPH/tNQfcA/Rmk6hmdBvAAU1
	 OUD8eqhiZyY//VRjtjx4EBNdj2xn0/BX4fItQqTLO6zhebzDNt7nkVUgRgW0t7o8Pw
	 2kPGSOl3qehc6SAdcgO7H21TKgNy3HcGH3PlW0wTy1Ntew66LALpj2q8I8dNWFFFak
	 Q9LwSor0IZTzp6LlXHKanMYfhx3Hy/DfcmcfpJ9wxjOAkG7UcwOQX4nuifVdWf7+/Z
	 B443zfC+hFtIQ==
Date: Mon, 5 May 2025 13:57:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>, Lars-Peter Clausen <lars@metafoo.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Kent Gustavsson
 <nedo80@gmail.com>, devicetree@vger.kernel.org, Lukas Rauber
 <lukas.rauber@janitza.de>
Subject: Re: [PATCH v2 0/3] MCP3911 fixes
Message-ID: <20250505135721.1ef655d7@jic23-huawei>
In-Reply-To: <20250428-mcp3911-fixes-v2-0-406e39330c3d@gmail.com>
References: <20250428-mcp3911-fixes-v2-0-406e39330c3d@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 08:54:10 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> This series contain two fixes for the MCP3911 driver:
> - Add support for reset signal
> - Fix wrong mapping for the coversion result registers
> 
> The register map for the conversion result registers of the MCP3911
> differs from the other variants so make sure we read from the right
> register by introducing device-dependent .read_raw() callbacks.
Applied to the togreg branch of iio.git and initially pushed out as testing
for 0-day to take a look.

Thanks,

Jonathan

> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
> Changes in v2:
> - Fix review comments from Andy Shevchenko (Thanks Andy!)
> - Link to v1: https://lore.kernel.org/r/20250423-mcp3911-fixes-v1-0-5bd0b68ec481@gmail.com
> 
> ---
> Marcus Folkesson (3):
>       iio: adc: mcp3911: fix device dependent mappings for conversion result registers
>       dt-bindings: iio: adc: mcp3911: add reset-gpios
>       iio: adc: mcp3911: add reset management
> 
>  .../bindings/iio/adc/microchip,mcp3911.yaml        |  5 ++
>  drivers/iio/adc/mcp3911.c                          | 58 ++++++++++++++++++++--
>  2 files changed, 58 insertions(+), 5 deletions(-)
> ---
> base-commit: 1e26c5e28ca5821a824e90dd359556f5e9e7b89f
> change-id: 20250423-mcp3911-fixes-ef3b2145577d
> 
> Best regards,


