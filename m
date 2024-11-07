Return-Path: <linux-iio+bounces-11990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6429C0A98
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 16:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805BC1C22815
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDEB215F6F;
	Thu,  7 Nov 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5R1QBds"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74BF2144C6;
	Thu,  7 Nov 2024 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995090; cv=none; b=ocHlcs4IyWxWzCgtj/eQ0hpzS23QNqfRmeRAxVs0Ip0Jy5VEUjzEtj9ehfa1Og0cZTmu2cZ6TNb83T2hBSmmNZZvNYtnrkz98DuMKUf3eIuN5wbdFLBGNqb/Dm/ooch26ayVw6opOZkjSd49iIyuoVK/Qp75fNEr5buASltRjTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995090; c=relaxed/simple;
	bh=plneM+1V2CG3gd7U8Ad6Sjsx9i7GasALEPDMYwfBw2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZX2n9sA+q2sSHnkSghewge1XrLfkshVSSbIYDmbpGV7qcqFSAwQ4JBl1Jqfkv7lQZO9+VDiUS9DVhW64u/OY7voJ7wqAFk4xUEsfXDFAxtWhn+exxeCRHVfOx748yYzfUA5exBBr63ZSJEJ4ibqRTb++97FOxYnX3iYWb5cJjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5R1QBds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57078C4CECC;
	Thu,  7 Nov 2024 15:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730995088;
	bh=plneM+1V2CG3gd7U8Ad6Sjsx9i7GasALEPDMYwfBw2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5R1QBdsymTWTWsOmTxNzAz3SHFGp+ZoOIcA+gQNUHQXTT46U6KOhwYkmJX/nyGdA
	 RsDJzh6ge3p/9ha6GZ6FnNIMbhLqo/81pKaZ/9lfJ/UVQn2tu6YAE4c79azgUDkWnE
	 awBVFCYLIuYNHW6ccZkVS+xPl6v4dhxMdJT40Hcw0UZKdmU0lu8BHfi3eiB0t1DWlk
	 8ItD4zHQWL8dK7TAXMF6vI+Ft8h1/DUoylQglUZsJJH4fLdhygiLVFgzSA0X4J1Gek
	 q/BXdj/tXrHU06j4e6Pi3vLvcjgjPjD8qxK6arlpBBW63SSJVa1b/IFTDVtTFsnlls
	 79RiiTYuW83BA==
Date: Thu, 7 Nov 2024 09:58:06 -0600
From: Rob Herring <robh@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: mfd: sprd,sc2731: reference
 sprd,sc2731-efuse bindings
Message-ID: <20241107155806.GA2774753-robh@kernel.org>
References: <efd200c3b5b75405e4e450d064b026f10ae2f8e0.1730709384.git.stano.jakubek@gmail.com>
 <cd8cc95b59c31418b174bba521dd2599a7929fda.1730709384.git.stano.jakubek@gmail.com>
 <20241106090509.GL1807686@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106090509.GL1807686@google.com>

On Wed, Nov 06, 2024 at 09:05:09AM +0000, Lee Jones wrote:
> On Mon, 04 Nov 2024, Stanislav Jakubek wrote:
> 
> > Directly reference the sc2731-efuse bindings to simplify the schema.
> > Remove the duplicate example from the efuse bindings.
> > 
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> > Changes in V3:
> > - new patch due to a missing dependency in the MFD tree 
> > 
> > Link to V2: https://lore.kernel.org/lkml/ZyExK01iprBHhGm6@standask-GA-A55M-S2HP/
> > Link to V1: https://lore.kernel.org/lkml/Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP/
> > 
> >  .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 10 +------
> >  .../bindings/nvmem/sprd,sc2731-efuse.yaml     | 29 -------------------
> 
> Srini, you happy for this to go in via MFD?

Can you? AIUI, you don't have nvmem/sprd,sc2731-efuse.yaml in your tree.

So take patch 1 now and this one will have to go next cycle.

Rob

