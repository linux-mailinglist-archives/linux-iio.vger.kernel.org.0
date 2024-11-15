Return-Path: <linux-iio+bounces-12306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570D39CEFEC
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 16:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199F0288166
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 15:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFEE1D47B6;
	Fri, 15 Nov 2024 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ws6M9J8f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D6E1DA23;
	Fri, 15 Nov 2024 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684609; cv=none; b=Jmlw7yXNlZg/I471G+evZYt9N0+HhHrq+6n5bzcY5XwBrPhg1D4KVKI7fJxAw5xkRP39fhwQXOHtxmxI85TIpO1g9DYFpQDDcrNV6M9PQo57DSfZ89cgW6WEliXMLHT/PYqwR240cPnoJbCcY6je0CcuQA2UCXdaIXJ5KHq08XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684609; c=relaxed/simple;
	bh=YuZdnJ90kFCavSaZheCH7K6qRntu8+VqqEKzttiCeeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5IOVuwxfyt3jG0awoIGXvnN9umtBmcLg+2L06YJu5zWwFzJIVG8N4U6/NGmXJWf6idtTsIjKodDLk1oQAybtc9D3nPfzRc7funBjnQbniI6QhCO9Sq8coMMEIU7kJ7ewBsIX+fKRV6/jGgimjHXs8gx2axVSrCs02bBiGYKruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ws6M9J8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED51C4CECF;
	Fri, 15 Nov 2024 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731684609;
	bh=YuZdnJ90kFCavSaZheCH7K6qRntu8+VqqEKzttiCeeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ws6M9J8fJ+fx7qzB8UhGtNlcvekXZP5NieHc8N9s9bh3lDYNZVJmnjJxaAh3DULtn
	 llYA3j7G5s9DEe7G/w24eB4vDL4WQTK92Suvxi2jceAaUpnEz/rQ9nZQJqK3nZ7uCx
	 B5yYPfJBlJRazlS+oWu4E9H/um68f2/8zPl2+qQrkNJxloNR6hMQUkFEDSK/po5a9X
	 6Gk2zN+/ZbsIgpUs/bBGmsEb8fgn+Iq3miPSofUIfuhYkI2BG17v3jAvqagkF9mINd
	 koYKMeCUGQDDxCv/rr5K9TqSjoh69RIV76Z0bjCyaNs4PRqnmHL+K5CHK2MtWw4g6y
	 PQDV1SPlDq9Rg==
Date: Fri, 15 Nov 2024 09:30:06 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: adi,ad4695: change include
 path
Message-ID: <173168460641.2928809.15269057471622553003.robh@kernel.org>
References: <20241113-iio-adc-ad4695-move-dt-bindings-header-v1-0-aba1f0f9b628@baylibre.com>
 <20241113-iio-adc-ad4695-move-dt-bindings-header-v1-2-aba1f0f9b628@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-iio-adc-ad4695-move-dt-bindings-header-v1-2-aba1f0f9b628@baylibre.com>


On Wed, 13 Nov 2024 10:55:20 -0600, David Lechner wrote:
> Change the include path for the adi,ad4695.h header since it has been
> moved to the include/dt-bindings/iio/adc/ directory.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


