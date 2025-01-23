Return-Path: <linux-iio+bounces-14544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23343A1A8A5
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jan 2025 18:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DA716EA7D
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jan 2025 17:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F3B14AD2E;
	Thu, 23 Jan 2025 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab0hsUkp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A8146A7B;
	Thu, 23 Jan 2025 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652284; cv=none; b=iX8C6SeHQFyGWMYQxeKvj2ySJ8+0AIKlrKyL3mt43WVXj3DzyckCgvxrBvJxxgCWzSJe9324NHGP6NvdgBhIPSZQKwiftzrsjS70DExuGD2O+luvwz8il1VblxS6Eb1uc2NNoEvLK4DnfiWRPz1nFDsyRieW14LHKHm0F1td5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652284; c=relaxed/simple;
	bh=0GGKE+gZAwaQ30PvubhwldYIUbt/bZPQgSlEY6BuNZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOJeiO3ebl+UDRNc2P8EwiOng4h0r+MELMP77AsoJHg5tOkthB0gzgLoj78DawZEk7bQIj0pb45QViBnDELDRnen4fTVdiu/h1/++7K7MOW8juUqNw0IlYm1pZZmIfRWOpJZ+zjsWPR/tyf8Xtfsrnc743tWrjmUMNzddGZJ44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ab0hsUkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D509C4CED3;
	Thu, 23 Jan 2025 17:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737652284;
	bh=0GGKE+gZAwaQ30PvubhwldYIUbt/bZPQgSlEY6BuNZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ab0hsUkpuPVjDPNgwdDJAOCovaBXGku9Y/F4feLz4uhQuP1aX0cZrUfc0qVi0ysVc
	 BQvCri5mQRBzWzfGGSwgFmX+tJlg+wWWf5XmPwzkh7JMBmClQDwZGfo+f3LrNAzz4A
	 zqm8N9lfg9rLaaeyTvLNA3MB+gp+6mkRe9MVMHWxCn1sevRhxSNa3uv23n37iPRXrZ
	 SkrPlg2j01BQh+viZXo+MGH63/XXwOFcp9ubGLD74nPtgA5Y8qg7ihhH0/JDoLSBB7
	 WtibbZAkptYoYAqlkplzSiCFhQgaQ+V9+jzYcRf87oQu1VRABfzsqlCvZId5AKGhyw
	 fC77F/KxdDQPQ==
Date: Thu, 23 Jan 2025 11:11:21 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Jonathan Cameron <jic23@kernel.org>, llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Justin Stitt <justinstitt@google.com>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: light: Add APDS9160 binding
Message-ID: <173765228044.4030438.369561953783516171.robh@kernel.org>
References: <20250122-apds9160-driver-v5-0-5393be10279a@dimonoff.com>
 <20250122-apds9160-driver-v5-1-5393be10279a@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122-apds9160-driver-v5-1-5393be10279a@dimonoff.com>


On Wed, 22 Jan 2025 17:59:33 -0500, Mikael Gonella-Bolduc wrote:
> Add device tree bindings for APDS9160
> Note: Using alternate email for maintainer
> 
> Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> ---
>  .../bindings/iio/light/brcm,apds9160.yaml          | 78 ++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


