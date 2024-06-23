Return-Path: <linux-iio+bounces-6759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F373913BE4
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 17:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468B01F222CB
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD6118131A;
	Sun, 23 Jun 2024 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUTDTxB0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F02E20E6;
	Sun, 23 Jun 2024 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719154928; cv=none; b=QG3AyeibfUSqtJOH4sklGtpcOnWDmxJl1Eni8NSnCLDx0csbvlDQE39VfsPc4Bqywa3ShAK9idty4qQ7fZ8hunL1/qSATftcteaS0sUzqYvW4QK/1CAtXo5iOwWdx5j6mDBkOz7MtneI5tE0hrLfzKQ4FemK46SXaTvgeey2FVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719154928; c=relaxed/simple;
	bh=ISrxbHoDsgdg8jZ5QeZIYDTqqYNzfT5aOQ66p+EPqGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kckZO+7gJOFXkIZzz9JJVOJXif6d/jJYRCIxyclpf373Gtn3tK8IOHOAc4qUPmPYD+tfsCAUom1eB7e4tdHppem9RlMRBCe8i9iddMMdusumvGyF4GhE10lehFgHVrJ+/i7YLvTrCCU0Emnv34u4wCCJKSCK32vcLLnChqjQgWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUTDTxB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4865CC2BD10;
	Sun, 23 Jun 2024 15:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719154928;
	bh=ISrxbHoDsgdg8jZ5QeZIYDTqqYNzfT5aOQ66p+EPqGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AUTDTxB066M0zP5PMnojHiP1J9VHW5O8wI8HefXUNgg6ViyiR7lynsdfZGq264K6U
	 IW4Ea5yErWl4FfQyuG8vIAehENxpLg5icImCG8oxz/qLBjTQb4Bk6kpJANxvEJ5wYD
	 PrjphOlKGgCzYIfmAOr+12xKh6tN5iTDr5+UcorXUOpyjdZwJ3AwiULMN4GHkAJqDb
	 eUWjQBZsXWE03LxzzGgbyxGgKNRMqdXdlwAfGxljoGFPOlFJDE3iYqcLDS3uBRj4JN
	 efREL+yQKPQTMEGlMmIqSlWt+v2fJnjLEdxB1bweeVrR9fdjtANEtfQWZVXgb08OJ2
	 Qy6wWz68wH1GA==
Date: Sun, 23 Jun 2024 16:01:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, <alsa-devel@alsa-project.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] dt-bindings: iio: dfsdm: move to backend framework
Message-ID: <20240623160157.2bed9ff9@jic23-huawei>
In-Reply-To: <20240618160836.945242-5-olivier.moysan@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
	<20240618160836.945242-5-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 18:08:30 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Change the DFSDM binding to use the new IIO backend framework,
> along with the adoption of IIO generic channels.
> This binding change allows to add scaling support to the DFSDM.
> 
> Keep the legacy binding as deprecated for backward compatibility.
> 
> The io-backends property is supported only in generic IIO channel
> binding.
> 
> - Channel description with the generic binding (Audio and Analog):
> 
>   Properties supersed by generic properties:
superseded

>     st,adc-channels: becomes "reg" property in channel node
>     st,adc-channel-names: becomes "label" property in channel node
>   Properties moved to channel child node:
>     st,adc-channel-types, st,adc-channel-clk-src, st,adc-alt-channel
> 
> - Analog binding:
> 
>   DFSDM filter channel is configured as an IIO backend consumer.
>   Add io-backends property in channel child nodes.
> 
>   DFSDM is no more configured as a channel consumer from SD modulator.
>   Use of io-channels in DFSDM node is deprecated.
> 
> - Audio binding:
> 
>   DFSDM audio DAI is configured as a channel consumer from DFSDM filter.
>   No change compare to legacy.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

