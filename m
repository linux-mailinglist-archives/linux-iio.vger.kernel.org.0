Return-Path: <linux-iio+bounces-14261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAF3A0B1A8
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 09:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4794B166AB7
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 08:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFA02343C9;
	Mon, 13 Jan 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sflatk+H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33922233D69;
	Mon, 13 Jan 2025 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758199; cv=none; b=CfY5mFKCpsYK/DLmAXRhGOWjfeWiDFvBi8VXdJu3A3hsWtvYnBCsjoypeY9HCkSOd0PeNkDI1ggFGvHfF5/uTIHSm3ylQI1EqHL96v+TWXZKY8uRLdqSb4fifzyvJ+AfFnr1X/7A+8+8+eDHG/nG1uUT9qAbUmSct/nn5NRvhBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758199; c=relaxed/simple;
	bh=3yOwW39eSZOxiVcnSWfm765ULka/0vE9T6SZA1eXiOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/tD3lHjEs3stZ4JArbVJh57z3NITg1tiqRUFata3/WH/a326SXeRSa1HllQkcm89P1fealWu34OmlrJiJAvTIYUmrCdt7e53f0nqRVEYdjuNCTPpXSzQweoWfhsQax8d0Gic+AJ+en68aLBds7Yd/So9IlOP1er9/ejsU8neOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sflatk+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2222C4CEE3;
	Mon, 13 Jan 2025 08:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736758198;
	bh=3yOwW39eSZOxiVcnSWfm765ULka/0vE9T6SZA1eXiOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sflatk+HoLfDp37FS5Shs2mK4QeasbVJNGpNOlKYUtgJKC73hYiP+pZ67s3YVibRL
	 XKeYrp7hSlHpRnceYZg/iGfQ2Bwz6h1lYxcsODzfs4Uk6y0GKItjrf79ITN7KFOSY5
	 51g6EMkltEQFRayY4G4WjFhEa4wVyi6d8yRl+TfhWMCQ/WImCB9kgTpyA3HPqgZv5d
	 5FxIefgKNTKb9QTaWUcm79DfPJGW0iENyxCCpX/OGrpUZLQxu7Vg/1BolLs0eTzCJS
	 FuftpTTeGFnU3wLhTkvHCTF6QPXq9oBYbZky4uaEFAfpNUs5oqtIzK+P6g4UsLLnO9
	 HXjA5h+FCfWiw==
Date: Mon, 13 Jan 2025 09:49:55 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasiliy Doylov <nekodevelopper@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: iio: accel: mc3230: document mc3510c
Message-ID: <v523adinr6o2zxvkpbijqg4io5s5u4ov7fvgyca6sbbwgeeny2@7dx7m2oqsrqz>
References: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
 <20250112-mainlining-mc3510c-v3-1-9ee6520ab69d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250112-mainlining-mc3510c-v3-1-9ee6520ab69d@gmail.com>

On Sun, Jan 12, 2025 at 03:25:35PM +0300, Vasiliy Doylov wrote:
> The MC3510C is a 3 asix digital accelerometer.
> It handled by the same driver as MC3230.
> Document it as a trivial device.

How did you implement the comment about proper wrapping? Your style
makes it less readable than it should be, for no real gain.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


