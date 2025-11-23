Return-Path: <linux-iio+bounces-26394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C1C7DF72
	for <lists+linux-iio@lfdr.de>; Sun, 23 Nov 2025 11:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59A6D34D0F6
	for <lists+linux-iio@lfdr.de>; Sun, 23 Nov 2025 10:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B5A2D248C;
	Sun, 23 Nov 2025 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrKNDy2b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8EC2C08C2;
	Sun, 23 Nov 2025 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763893514; cv=none; b=kA7zT0AeSsEn7QTV4jjMGxk1/6WcsL1nQMU1it12v3sJxIPlyIHjQ2agB5WR5hsgXpaqWXFoabkU4mWZd+VLpDcUCqpTDAmEJvheA7Cz/DetkbJo5G3TXkHeCXRFsvN8G9OnZerpq41YUWjWYJTEZLz1LPnbJ6zSK3KlaXaEO74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763893514; c=relaxed/simple;
	bh=YFDuGTSodR6gNRk1Q5i9Kj9TtfXkgR6lIRtUYWw+GHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuWlLwx7DehKrYWHhr411XEwS9Jl1zLZsFaEyd38Qvm3xoHEoWSPUSPgb0YsqzE09RgsRaHN7Go/pWAI7fams060hD5d4cJqkafsbrb7A/iKVe/wPCWeuVARtiufgj4D/uEw1TGsCkxVfdBj5+ZAaZOnFW4+YBa08H5P3YgFJbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrKNDy2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949C0C113D0;
	Sun, 23 Nov 2025 10:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763893513;
	bh=YFDuGTSodR6gNRk1Q5i9Kj9TtfXkgR6lIRtUYWw+GHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrKNDy2bHKFisvYR6pGpeXC5Gg5Uus/mTj/tjLbQSvpoe8qa+TdG/xkNkBVdd9ApF
	 K4rAsB+8BVgwUCGkPGXyMRoYtdf0ppMgrqr4Qq8kk3UXI/iTYnpIBWjJ6/eij+RW37
	 aS4OoZ0dUH/i5bIUwMkZkswFTU7+clZJiE4TbqC+5nm4VFPySqf70NbzTEsK7NbYqm
	 S1CRsJcGWDo1r6/9GMkAHnYNdPPggg5b3aKw5OAjoFHRst9ajOX5wIvaa5CAZAEYdw
	 gNb+6W6uBc7PlYv7YDQTxcHiu27dq4QoCP1j8CQr8FbdCWy1JSrUtyOXDyUYD7OJG9
	 UQS97XVs5bbRg==
Date: Sun, 23 Nov 2025 11:25:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: pressure: add honeywell,abp2030pa
Message-ID: <20251123-kickass-malamute-of-improvement-36cf64@kuoka>
References: <20251122-honeywell_abp2_driver-v1-0-7a8e265f9627@subdimension.ro>
 <20251122-honeywell_abp2_driver-v1-1-7a8e265f9627@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251122-honeywell_abp2_driver-v1-1-7a8e265f9627@subdimension.ro>

On Sat, Nov 22, 2025 at 11:42:44PM +0200, Petre Rodan wrote:
> Adds binding for digital Honeywell ABP2 series pressure and temperature
> sensors.
> The i2c address is hardcoded and depends on the part number.
> There is an optional GPIO interrupt that signals the end of conversion.

s/GPIO//. This is not a GPIO pin in this device, but interrupt pin. How
the pin is on the SoC side in your design is irrelevant.

No need to resend just for that.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


