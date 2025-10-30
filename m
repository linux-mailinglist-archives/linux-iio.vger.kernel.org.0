Return-Path: <linux-iio+bounces-25698-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C03DC21B39
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 19:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DA824F68A1
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 18:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C611E37DBC6;
	Thu, 30 Oct 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcY7RJLI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD5237575A;
	Thu, 30 Oct 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847342; cv=none; b=s+VWnj7tp8vmHGo9+g/TRLjYEk14kQ4Cpa4eXschdxcCwhG/qbcx3jmh33CgaPk8GKFq9HOARirbjFeO3VfQUR8d7Q2mQx41kbZr1Emea6YMNA16F/RJo6xdDynOSfAsrHB2wO4juJgmaYt6j3dwvz7nbo2EiTcdodK9xQTx+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847342; c=relaxed/simple;
	bh=xBFviO3lUiCIiSk8WGyCe12z+4knQ8Rp0VUfyCMMyAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8cITgu3+MWTKnnFW6ajiZb6BOMYM8oDuByNpg8UqPDbCIoVAqQJA1O4uEGpSawKCxlUNtmtgxJCV2bxzMRZKE6/2xKxgz9J6mLBXkYaxxyUdxixa+5MZ8Dcp4R8FVJm5OUeUWWWNJrE5rqmoqSxwfFh7c71hjhq0vGla4JBpcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcY7RJLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06D8C4CEF8;
	Thu, 30 Oct 2025 18:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761847342;
	bh=xBFviO3lUiCIiSk8WGyCe12z+4knQ8Rp0VUfyCMMyAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcY7RJLIB4tR5C++Q3CFQcQmEKNYPVxwcAjhC5//4ej/Qv7Mg5Q8O1ts8FZG5Sgm8
	 BYy1N++yozXCF9mMwwNKRc4r757tWEIjBv6+Hmgwkj1cltdMM7obLBypS2sm6Dlmr8
	 RENX/nSw6pPLOm/3SMA+N0sjRYHjmY0RjvPVCDd3+3DYgmdQMBXYboCISTO6E01PIC
	 dmW9GAAi0TEwmmy1e7/rr/FIo0caR+B/wkv2Z++TV2T7l6dCFiLmrbeReD3poOfRHQ
	 63ZMki+helEvqohPejcliJSx0HKZrEVpZurg5QpABWy5QgDTgtug744z1dV6R95QQt
	 xnvpYHlgyv80Q==
Date: Thu, 30 Oct 2025 13:02:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-renesas-soc@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: Add the Renesas RZ/N1 ADC
Message-ID: <176184733915.110506.880834344127076775.robh@kernel.org>
References: <20251029144644.667561-1-herve.codina@bootlin.com>
 <20251029144644.667561-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029144644.667561-2-herve.codina@bootlin.com>


On Wed, 29 Oct 2025 15:46:41 +0100, Herve Codina (Schneider Electric) wrote:
> The Renesas RZ/N1 ADC controller is the ADC controller available in the
> Renesas RZ/N1 SoCs family.
> 
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
> ---
>  .../bindings/iio/adc/renesas,rzn1-adc.yaml    | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzn1-adc.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


