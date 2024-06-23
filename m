Return-Path: <linux-iio+bounces-6733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5429137CB
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 07:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 596AAB213F0
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 05:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07861DFE3;
	Sun, 23 Jun 2024 05:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgK+hz6y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5168B8F4E;
	Sun, 23 Jun 2024 05:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719119845; cv=none; b=dSFb7yCuRbAhAm9TTaz2wIUuKzoIoZwSALDWyYHq3kfGxHfdnOL41lVA3qaoa/ICCZf5OF5N5NpldgzY6ix5GR/NUdmM2wcwJIxiF2HRe+3XoHFZnPB1f69yKLlz5V4/Cgm/UA02oZrdVG3LI5pRsGXdgsPGvD3vNnyglmB9K9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719119845; c=relaxed/simple;
	bh=+yntFcL4G05xGhlIwFj2ZjrUDk/Ub7pHF+UKK2NQkZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hj1WWKrzK7tommWuTtOOadEuertlEybUi4Or2i6winBq1I8kHfWblxnLW4o5gGdQ4iHDNZct4rEjUmw8PS2I3aH09NOl1/4lLRjF6KvgLB6MJHOk0BVj+KZ2q7N2U1t3lcPdOYuN5ccLRF0YkcfaPJVH6FRPXlfJifXfmgczAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgK+hz6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E79FC2BD10;
	Sun, 23 Jun 2024 05:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719119844;
	bh=+yntFcL4G05xGhlIwFj2ZjrUDk/Ub7pHF+UKK2NQkZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HgK+hz6y8TDyPHttIRug7u6QMbJnPx4ci19dyRS30rv7p1fcVKx1SXGeJFyCqvaVj
	 dUsJS9x90m0wWC9RQBljWD+7LtTAf42SBveF0DP9UvnFY48mUOTVEd2KDht5rvPJnd
	 G5dOT0YQNt/QQlP1pgXSEl76546HFP0oiHXZ4Qf234P0kUyKTM0M1dPGgdaJv5py1G
	 tPKuuOTShWQNAi5tTxc9XpAubIghEwgQux9uRxboOg5k6MK9KUxWNS568mjlcekf0+
	 em/ObbrMb1cg6cPaiSHRTGq/vDXOieLzTmlLPO8DcEnuPUPJLAEdk2fi38TC0q6oLb
	 OXFW/Q+6TjGRw==
Received: by wens.tw (Postfix, from userid 1000)
	id 060485FA33; Sun, 23 Jun 2024 13:17:21 +0800 (CST)
Date: Sun, 23 Jun 2024 13:17:21 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	broonie@kernel.org, lee@kernel.org, samuel@sholland.org,
	jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	lars@metafoo.de, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: iio: adc: Add AXP717 compatible
Message-ID: <Znev4elL2AGTLRBl@wens.tw>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
 <20240617220535.359021-2-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617220535.359021-2-macroalpha82@gmail.com>

On Mon, Jun 17, 2024 at 05:05:28PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add compatible binding for the axp717.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../bindings/iio/adc/x-powers,axp209-adc.yaml          | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
> index d40689f233f2..267c74fa2d0c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
> @@ -37,6 +37,15 @@ description: |
>     3 | batt_dischrg_i
>     4 | ts_v
>  
> +  AXP717
> +  ------
> +   0 | batt_v
> +   1 | ts_v
> +   2 | vbus_v
> +   3 | vsys_v
> +   4 | pmic_temp
> +   5 | batt_chrg_i

You are missing channels for VMID voltage and backup battery voltage.

ChenYu

> +
>    AXP813
>    ------
>     0 | pmic_temp
> @@ -52,6 +61,7 @@ properties:
>      oneOf:
>        - const: x-powers,axp209-adc
>        - const: x-powers,axp221-adc
> +      - const: x-powers,axp717-adc
>        - const: x-powers,axp813-adc
>  
>        - items:
> -- 
> 2.34.1
> 

