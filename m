Return-Path: <linux-iio+bounces-23973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 004B6B529FA
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 09:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29874189259E
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 07:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB468266580;
	Thu, 11 Sep 2025 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxfXsnuX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F8133F3;
	Thu, 11 Sep 2025 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575873; cv=none; b=QaDz+jx7RxwmQeNKcR+md2f0eSZU3y5JM2Two/ihg2m59HORqq7qwblAb9n3AgtH0taKUrNx+VSk3gayLZcXY0/opit5UO2GeVWrHylpUsVcSzSA+j4nbN4mBxBZMfusMQujLd1jZI1Brg5oNWmHOZfkb1meQ2zDhBtHIxryPco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575873; c=relaxed/simple;
	bh=l0lmASDcgHczk3wTtybtHoU75GOWscbEu6GFvUeGbQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWwcSaL1+cyFeJzNQlxhFWI91w1zeY0oYRHXmMHuf5lvyOKESYOf1TKhflEahCIsu7dK5EoMqupPQ5nE9aHjWWxXXVHKpm5kmmauxMOG1VDaQmo0N1FDCp50LKQcxVjoIiLn1sTWY2QaJibKqN5j2ONbjoBVAvB80jglIftlEvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxfXsnuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E91DC4CEF1;
	Thu, 11 Sep 2025 07:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757575873;
	bh=l0lmASDcgHczk3wTtybtHoU75GOWscbEu6GFvUeGbQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dxfXsnuXavcvwb8LtF53lfrA4RB3I9x852H94+8mzxg0OWwo40giU9q0Nx0rbq8fF
	 aDWStbUWMt91zQ+icxznr25KnII9UKLt6qbmoSs4cA44SH6FLk+ZaWpLa8jl9zHlNl
	 eqK4hCsT72UaTIVSRgihazQaBXRDbvLBGxhebP9yLi7cxqRg5FnaCoGV/z191iPkjf
	 xOKJRWmR6U3cICTuJz9Am+YqLoPVrKuXsM8Zt6WQcTsoh7F94/rhEHuYSPWfTZqsEt
	 RPugtLVvdzPlsFzLJ4PpgrgNaeaAVjpysOpNC7pC9vUmFZyO2Sn57amCSUAzV3hBJD
	 O+68dZ0qL2qPg==
Date: Thu, 11 Sep 2025 09:31:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] dt-bindings: iio: accel: bosch,bma220 cleanup
 typo
Message-ID: <20250911-dazzling-augmented-mouse-d3c2df@kuoka>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-1-e23f4f2b9745@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910-bma220_improvements-v2-1-e23f4f2b9745@subdimension.ro>

On Wed, Sep 10, 2025 at 10:57:06AM +0300, Petre Rodan wrote:
> Cleanup typo present in the title.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> ChangeLog:
> - split out from a bigger patch file
> ---
>  Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


