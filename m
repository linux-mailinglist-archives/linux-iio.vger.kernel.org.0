Return-Path: <linux-iio+bounces-6081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0709790131D
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 19:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0EA1F21B65
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6A41CA8A;
	Sat,  8 Jun 2024 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTxP8hL3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863DF1BDDC;
	Sat,  8 Jun 2024 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717869091; cv=none; b=CTNKUQC8i3B+P8qy4sYHnn2o/LWVCwDPq7MN/UITpBctSFwHQgQ3VEhCXZlcMLR8EbrMErjVCztQXyJcaYgGZ7huqmckAvsOZ+OxhDPN+aOXlljqtIMYzFuzT2mLtd7sV5odBN79SdlAC077XBR9a/EOL5ZRGZagiPQe/+pU8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717869091; c=relaxed/simple;
	bh=e1fsE7fB4ewFPaZ8JWr2CP9i5TSif1c3QeBzFO8sI1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swYPvWC5ajpIuG/Zy3QxK8FUOOVatw0xb1tTXnV9L7j2BShLjn1c+lSI7NyV8GGvIK4TkrhqKOBMxpJKwwFdX+AezZ3kKzpX5MlHFl/1fVsvCAmD/7iMENa7DPQ0bKUsxIswoAN42p6/m5IWck1+LZkasBKtq/5ELLe1FZX5WRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTxP8hL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE518C2BD11;
	Sat,  8 Jun 2024 17:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717869090;
	bh=e1fsE7fB4ewFPaZ8JWr2CP9i5TSif1c3QeBzFO8sI1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fTxP8hL37N96nCLipmzp1T5UNqthOLzfa0wl3ZlHVKHF/l15hlxKLiGIBKHAObd9l
	 1/IO2wBZ56/Dv3HKkw486Lz6x0Lux4JW5tHlytd/U1ZMveZ3k2xUjtU1rN/Ms6g5mp
	 G0M4Cyr+mgB6hUqQfIfZhtAB7eUumdUsql6mgLFMi0dcYeyDDMqLjTigfWgSHlgo/y
	 bbHmucT0RJbEVoOpmNml1Iv1FwUZnRLQguCA6Kv71xQXLZWHMz5cg6OUtk5r/oDfrW
	 HcjDOkpqpbRjlR+K9dHHa/OmQovecXU19Hiy30LVgFTnZSJ1bBUDDxs/iVxSG9ngwj
	 YvuKNwX4rKWTg==
Date: Sat, 8 Jun 2024 18:51:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kevin Hilman
 <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: amlogic,meson-saradc: add
 optional power-domains
Message-ID: <20240608185121.31a40d62@jic23-huawei>
In-Reply-To: <20240606-clothing-deceit-910ad6aebe1e@spud>
References: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-sardac-v1-1-40a8de6baa59@linaro.org>
	<20240605-abdomen-starch-4fd4d7ead431@spud>
	<1a82eeb8-bb95-4fad-acce-798ba0cda170@linaro.org>
	<20240606-clothing-deceit-910ad6aebe1e@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 17:21:17 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Jun 06, 2024 at 09:54:22AM +0200, Neil Armstrong wrote:
> > On 05/06/2024 18:58, Conor Dooley wrote:  
> > > On Wed, Jun 05, 2024 at 11:37:08AM +0200, Neil Armstrong wrote:  
> > > > On newer SoCs, the SAR ADC hardware can require a power-domain to operate,
> > > > add it as optional.  
> > > 
> > > What about the older socs that don't have power domains, the property is
> > > now usable there?  
> > 
> > Old SoCs doesn't necessarily have an associated power domain, or was handled
> > by firmware, does it harm if we make it optional for older ones as well ?  
> 
> I mean, really all of these devices have a power domain, even if the DT
> doesn't describe one as it's hardly gonna work without power, so the
> commit message just seems odd to me. I don't care enough to ask for a
> new commit message though.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied

