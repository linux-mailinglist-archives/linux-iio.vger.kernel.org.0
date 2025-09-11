Return-Path: <linux-iio+bounces-23972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256DBB529F7
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 09:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F493A541F
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 07:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3F726563F;
	Thu, 11 Sep 2025 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxnrsehE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F5633F3;
	Thu, 11 Sep 2025 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575865; cv=none; b=If+pyRwPiErCNFGN30mWooFQ8guXYHNdIWg34UfzPyt2HjmL/xAgwVZ0gPOQFfz5Fs49cQbB75572ZhI04JBE8XjQipRpnS4pj21roPYnJHE3RXzPPRURdMSLgksE662MCdTY8qFKn2WMm6rkAHUbytu3ZT1Xu0zyHhc/NbDGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575865; c=relaxed/simple;
	bh=iulG6YlV+rxLbaUJFrX5Mpmx7kwlvIyaCE6DoHhzqag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDSx3iYTjsfDFNSoVwrKXHRUFTrnkt0zyUDSESt6uODW7p8gHPHo0ykrI7LXXRstcEQGRBa50j3GmZWfsVQ5SsuBO/uq6Jg/pFCl5uWFDZuswEB6LNTG0p3ey59ML3eATLOo/hDDWG/47mhs3DcFkFTlJQVL54KTFfOG/cjSmFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxnrsehE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC03C4CEF1;
	Thu, 11 Sep 2025 07:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757575864;
	bh=iulG6YlV+rxLbaUJFrX5Mpmx7kwlvIyaCE6DoHhzqag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxnrsehEaGPYQXmlFbceqBljhQdR4ineXoZGUwWLBB0yzmMndIWpOsbXBg/0U6u7i
	 8P6Ng6MfBLL4pmAnNXG/VEHdMZ4hxYd1ZhiYuGOKT0NCGhpharF19u1bHEeaSH7AOT
	 PauVjNBgxXrW1k0K+uSqZksVF0wK/2n0Qn3DpsUvh4+10lLib8+1OPQNiqujt1vy2a
	 JIXUo2V0muloja5BfHxC4HL9oL5YPl15Cy8BBN3PiToY4oISTkp5j2+Z16lhaPJWHn
	 OYilPFW8N/19ZAY1D9nZRl/k0Sl7IXb9znSM8u6J117PF3oA3XLFOe/3RAfXLeEjF7
	 wUX+qt23LtP0A==
Date: Thu, 11 Sep 2025 09:31:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] dt-bindings: iio: accel: bosch,bma220 setup SPI
 clock mode
Message-ID: <20250911-radiant-rigorous-magpie-eaf3f8@kuoka>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-2-e23f4f2b9745@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910-bma220_improvements-v2-2-e23f4f2b9745@subdimension.ro>

On Wed, Sep 10, 2025 at 10:57:07AM +0300, Petre Rodan wrote:
> Assert CPOL for a high-idle clock signal and CPHA for sampling on the
> trailing (rising) edge.
> 
> Quoting from the datasheet:
> 
>  "During the transitions on CSB, SCK must be high. SDI and SDO are driven
>  at the falling edge of SCK and should be captured at the rising edge of
>  SCK."
> 
> The sensor does not function with the default SPI clock mode.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> ChangeLog:
> - split out from a bigger patch file

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


