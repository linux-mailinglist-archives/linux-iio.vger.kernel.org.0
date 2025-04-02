Return-Path: <linux-iio+bounces-17543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB4AA789C4
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 10:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01CE7A4B95
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 08:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAC1234973;
	Wed,  2 Apr 2025 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZRqupmN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505C99444;
	Wed,  2 Apr 2025 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743582350; cv=none; b=kZWiJhRuiOWBTkPXpm9CW6H674xJgROJ5fGL/gjOYahlyGKvOlTirbG4jlIRrK8yenRyyV6M4aco4hDPjXjmoi8IPZaEo08iX37fF4Hrnld9kbQcAveabyvsM2zpfHOyIPSUTWaPcS4qs2+1yyd7Wwq046+/MBZChfjM7K6cQGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743582350; c=relaxed/simple;
	bh=otuypYYxO0QSjLeAobJAQo27qrjBeltuzY9/WEqFTxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NL7fmdab9s52VekMauM4k8CYDxrG9WZbMKi+hNCyU9P9vMVjFmmSE8kgCSJdXfx9cCZ8xtp96p/fWxyO8581TnTz0AIxluIIbQXBx+Vh2B2Q8QFpiGVQ6hvqUiJniKJAqdYYxRKaqnJnIz2W93NYdLTsN4bgvE0jOBqDj3hf14w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZRqupmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD18C4CEDD;
	Wed,  2 Apr 2025 08:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743582349;
	bh=otuypYYxO0QSjLeAobJAQo27qrjBeltuzY9/WEqFTxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZRqupmNclgLdDIYFU6xOb1JCVFihifTTRQqzcuoRgBb0kkkPCCMB1hubMpaLU4gN
	 XlB2rkjB98v7gq5ncRRqr2chTy7S/lR0awHtbRjzlSLnao9g49XNo+7oTgJzG+lDgL
	 IE4nTgi5EARczC3MLLqJTowkDwg2uwQRD+3K2fsN+WD1R7s0U12jBf3NaFys2y5q24
	 a9hRUNm9IhO3mjmuxXqlNecZ41UVrKtbFJdtBTl+cVo1MAaoLvz9R/txaG9XGtdwOM
	 8YPLWXcVcm/KkAjrOb1UrVuSmDr/zHO3ieIzzYckstGdWHiCLVVwCFexPDD+J/diVO
	 vWDlbLWESWsfw==
Date: Wed, 2 Apr 2025 10:25:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: iio: adc: ad7380: add AD7389-4
Message-ID: <20250402-winged-ambitious-sparrow-c988c6@krzk-bin>
References: <20250401-iio-ad7380-add-ad7389-4-v1-0-23d2568aa24f@baylibre.com>
 <20250401-iio-ad7380-add-ad7389-4-v1-1-23d2568aa24f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250401-iio-ad7380-add-ad7389-4-v1-1-23d2568aa24f@baylibre.com>

On Tue, Apr 01, 2025 at 05:50:08PM -0500, David Lechner wrote:
> Add compatible and quirks for AD7389-4. This is essentially the same as
> AD7380-4 but instead of having no internal reference, it has no external
> reference voltage supply.

So neither refio nor refin, but your schema says:

> +    then:
> +      properties:
> +        refio-supply: false

So what about refin, which is also external reference?

Best regards,
Krzysztof


