Return-Path: <linux-iio+bounces-21282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1260AF6BBB
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 09:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9F01C47354
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 07:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB792989B2;
	Thu,  3 Jul 2025 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft1vF1I4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31450298262;
	Thu,  3 Jul 2025 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751528297; cv=none; b=UHAuVMXLsSl56MF8eaDcqliQl5pknBP97YaVJYVIP04uD3rYHcxVBONb0fkEku1mQNRXwL3v2Pq8KqBUhXSzwsDszfVlUdD+KlvWbbR0ixJx2I5iTvy9RytR/aZHeWiyQvQ4izi3UEwjvxldejrZuhvPIUqJfhW/LL9NJhB1RGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751528297; c=relaxed/simple;
	bh=bPAdNa3X8EhTJmuygX9fPL1Pr2+T2oa+I0dsXMyn1Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEaM+cvJVvGOgO2vF0us377MYK61KOcNO12JH4PTqkXUDl84HWvgVxshEcorc79hD/FID62PqiAH/+jVwlUW9I+COceVGUqrsqUzK2aPoslrAiIgG2lRS1YwBbl70eXtJ3RyFs76vPA+yzx1Zz8OiQrLPENXVMtZUn3ZckRNMVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft1vF1I4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE2DC4CEE3;
	Thu,  3 Jul 2025 07:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751528296;
	bh=bPAdNa3X8EhTJmuygX9fPL1Pr2+T2oa+I0dsXMyn1Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ft1vF1I4iki46Sz33pbkWqT+1CaYUE1DFOm1VaBY8+ycOn5fpbIsyrONvLpQHwfxl
	 3BWTzlzw+kLWfsMRehs4lE8YbUPBwI7KtpN3fJTMszPH8qW6SFbD2uyiimsmOI74xV
	 RYqboYFAiMN8q5k5aEQs+VCyVLWyPWXX9c1xN8WyiaNJCp/gazkBsxG02Me4crP0t+
	 HVlp6yQt3Uw98WTsvZ8LwyQt62SN9zkbf4q49IPGxEf9TlT1X6ioGzfPTWcRXkcpd4
	 KFmdnPVNHa44Q0kB3zUTGsghsjRw3277FaQa/ZOHyD0cveb+a/n9doSc3knRfqhe6j
	 E3dv9Pwr3Jv3g==
Date: Thu, 3 Jul 2025 09:38:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	jean-baptiste.maneyrol@tdk.com, ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: pressure: add invensense,icp10100
Message-ID: <20250703-rational-laughing-hedgehog-cc0eec@krzk-bin>
References: <20250701221700.34921-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250701221700.34921-1-rodrigo.gobbi.7@gmail.com>

On Tue, Jul 01, 2025 at 07:05:43PM -0300, Rodrigo Gobbi wrote:
> +$id: http://devicetree.org/schemas/iio/pressure/invensense,icp10100.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: InvenSense ICP-101xx Barometric Pressure Sensors
> +
> +maintainers:
> +  - Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> +
> +description: |
> +  Support for ICP-101xx family: ICP-10100, ICP-10101, ICP-10110, ICP-10111.

The problem with title and description here is that they do not match
compatible. oneOf:

1. Your statement is correct, but then compatibles are incomplete and
will encourage people to use incomplete compatibles for e.g. ICP-10111.
2. Compatible is correct but your statement is not correct, so then fix
the statement - drop other devices.

Assuming 1 is closer to truth, then I suggest to express it with
documenting these compatibles and using invensense,icp10100 as fallback.


Best regards,
Krzysztof


