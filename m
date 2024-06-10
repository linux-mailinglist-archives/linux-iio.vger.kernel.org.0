Return-Path: <linux-iio+bounces-6169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 753AB902AE1
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 23:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA251C213DD
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 21:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F099112F397;
	Mon, 10 Jun 2024 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcAE+08L"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A016AB6;
	Mon, 10 Jun 2024 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056195; cv=none; b=fXRrd/3p41jn4R7H4/0Me2Jp6BMv2v9ui3Ler5nsPXBBUSMUZWzyQUBIJn9M54eTQa2uuUxEFsCXu7/tOn3q+Pm4byoi8jiVNK7slAO+JR5ndnd9mLuKNHhlLRMooQfK6ZW2iL+28I1xK1/a08LOSBjjomDyhJeKkd3BOg6WMQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056195; c=relaxed/simple;
	bh=iqoeqU7qrd7+cqZSSIW9HJHlvFu1ZrsTtWb1zfe2NEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xr+XcsC1NFbRRAfCRz76tqALs0h/eefcxFb687X/RL7BPPgokM25OCW/hJveF3o6aSZkbH7SI2KNE3ORDeT/wDcWi7D2eXIYpx9KfNsuT7W3XmVU5FjS7+LU/J8lWeuBavnrp3065NW8dNcGD7aYm9cbAEnTqWb+pLsxVNXjtxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcAE+08L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071A9C2BBFC;
	Mon, 10 Jun 2024 21:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718056195;
	bh=iqoeqU7qrd7+cqZSSIW9HJHlvFu1ZrsTtWb1zfe2NEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcAE+08LJLvIeH1O5c/0fRi76GuNfP6Cuyb7ml4RWOzjFj8R1PrjnmA/XhR8Nmvn6
	 n/jcXxhQly2HiTRB6BYiW+O5sYjqTQmaMtr7U5MUqxNb+++EtY4f4nWiCFPCZ8azAI
	 6cJbGMov8EFNNT+TACSr4w6D4M35B4dH8yrm1n/HK0cFCzH2WvAdR2z8qU750YLIFV
	 0oOQpMpf80gU6OOIpqKVGkNihXM3FddFKoMZqSIoX3feVs/wiK2xOjfERX9uvLAljU
	 ieJzoFNUWpQgLx27C+0HIfz4GXHW0Bkio5izHEc0pkrdrt6Yd8TMfEySCeFDwPhhIj
	 SLFZJAX9flCsw==
Date: Mon, 10 Jun 2024 15:49:53 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org,
	Gregory Clement <gregory.clement@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Lars-Peter Clausen <lars@metafoo.de>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Daniel Baluta <daniel.baluta@nxp.com>,
	linux-kernel@vger.kernel.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Konstantin Porotchkin <kostap@marvell.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 4/7] dt-bindings: phy: armada-cp110-utmi: add optional
 swap-dx-lanes property
Message-ID: <171805619146.3132064.3390412132436424626.robh@kernel.org>
References: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
 <20240602-cn9130-som-v6-4-89393e86d4c7@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602-cn9130-som-v6-4-89393e86d4c7@solid-run.com>


On Sun, 02 Jun 2024 17:49:39 +0200, Josua Mayer wrote:
> Armada CP110 UTMI supports swapping D+ and D- signals.
> usb251xb.yaml already describes a suitable device-tree property for the
> same purpose but as child usb controller node.
> 
> Add optional swap-dx-lanes device-tree property to armada cp110 utmi phy
> with same semantics as usb251xb:
> The property lists all ports that swap D+ and D-, unlisted ports are
> considered correct.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  .../devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


