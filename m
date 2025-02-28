Return-Path: <linux-iio+bounces-16206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B56A4A3A8
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 21:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C7919C12A9
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 20:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B9120299C;
	Fri, 28 Feb 2025 20:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAP1IMNo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F8C202986;
	Fri, 28 Feb 2025 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773222; cv=none; b=Xi0bGvmYdI+wl1it1omOwAJFaICCBMylmrUQBinCsBkFO5wlI918pnZg6ANBifwNJubawH90Gi3qcaVvVP7uSmHQIKH92Q0OAEjwShCyAb71Fi2o6+aR9cILXFHeiiL5nzN8P05fXuQbvueTHkUih3dir2X+SmJNu+KloSqCk0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773222; c=relaxed/simple;
	bh=tZRFoklkUux8FCQb6KBOPuB3nq0cmUFuwcY/POd6QUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDpyxsrtqKv+qfFXg8UFKyFE+BRnbdPEG2deAH72ZT/ImN70NnhkOnD8SVtFOMg/FY8/L0Rw3dp945YGbQtwwc0N5hJGC6eWeYFSpwVKlPBO6xP/5RkRFTleUOHs9gv2bjIDE+zu6eW4K/299kvlSVFR/pbO+OQ0shqfMBois4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAP1IMNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E717C4CEE2;
	Fri, 28 Feb 2025 20:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740773221;
	bh=tZRFoklkUux8FCQb6KBOPuB3nq0cmUFuwcY/POd6QUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAP1IMNoNo6NGUJpkv/r6RUuAyInFtcWGTOZBrFXXeP8WxPkleWTkU0AS+V+7PnfP
	 jTawWceiUhVUmTde+jyywIAcSRUf7Ru1h9nLoGTFJlTK825IMvrXijynBXDb8aXLgF
	 shBI0tFoyofL8GH7c9u6gACDDNbwwPTtZTCceJKSsdjSt8H9vv6fUIrv3Akt4O9wZY
	 Sg10MxheIcwnqpyZ1nOL5FUYcWLqaVs7sewniJsIT6DYhnkUz1H+fPsWFFDfA1KvFZ
	 QmI/mR5wwc8QB6lVK6gjcqcz13vfZhu8b5miNl8H0W9j7ZVmOwmVQs2IOsaT8QfCJZ
	 OrceR3y9XpFDw==
Date: Fri, 28 Feb 2025 14:06:59 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>, heiko@sntech.de,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add rockchip,rk3562-saradc
 string
Message-ID: <174077321955.3490993.13046330315407577605.robh@kernel.org>
References: <20250227110343.2342017-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227110343.2342017-1-kever.yang@rock-chips.com>


On Thu, 27 Feb 2025 19:03:42 +0800, Kever Yang wrote:
> Add rockchip,rk3562-saradc compatible string.
> The saradc on rk3562 is v2 controller, with 10bit width which is different
> with rk3588.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v2:
> - fix dtb check error
> 
>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


