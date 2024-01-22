Return-Path: <linux-iio+bounces-1842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7BE836C35
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 17:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C871F26538
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42204779E;
	Mon, 22 Jan 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9qlLw84"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931FC3D97D;
	Mon, 22 Jan 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937679; cv=none; b=ZxkIYTqGu+ScETOCyVEQWH0KhWdbc9KxIq8wM7X3uXuPQxKYoCLcYFkg/a7EpPkpUiyz0qmK9DrcUZ/oy3yYTES43w5TptX3qWtmRyWMY7zXP2RpOJfVY/dCjLE8Ep45qrWxk2q2tQmYjXwmjZAI7+3ZV6p8zafClFgmZo5Ytco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937679; c=relaxed/simple;
	bh=VS2uVYY8cOrzn8MUQBmfTEcxP+2D9pJdzyJ5unOsIgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3P9KiZtb54pAVWKMyUj93MxMVsxVHx89S/EBLl4Ig5A4r2q4wXMhn2wHx6XFjkkN15aKMXrbvuVYopZJ9VFYTIs+F99ZBlAStPIkv95x1yV/MMb4GKLCc2YQaj/9xQGuXjU/y4otuez5xmZXpsm3z79WXquRrr5886b9H0Bevk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9qlLw84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4977C433F1;
	Mon, 22 Jan 2024 15:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705937678;
	bh=VS2uVYY8cOrzn8MUQBmfTEcxP+2D9pJdzyJ5unOsIgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E9qlLw846MWmaqT4eDHC9kp9lmSTkwUE5RyTFlMt/qdvv74X9QBSvxDztxHFAzO0D
	 85hR07zPIFCB/IHRgLtv1YnW6StxovbUrYHTnfB2ssCfN1eTZwJptcwKFyEK0GGBVb
	 nt+XDuEM7vVAS68penmo4Rm43TXn650nEPHt9viSQn7sRp0BDpwZ1xw1/9cBadYm4J
	 naWqVD52qLxy+p+vlvggIDsNDKlJQhLrVJ7wObkCo8gTh1cYFtR3LG/jNTZvIrCYVq
	 KiYEA+tnUpixe0/6aParqHu83enqHZOdgEZmD/laBrSbXGGdWDXCHIXnivKus5mmCS
	 Xnt8PA6HLY0CQ==
Date: Mon, 22 Jan 2024 09:34:36 -0600
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v6 2/8] dt-bindings: adc: axi-adc: update bindings for
 backend framework
Message-ID: <20240122153436.GA601827-robh@kernel.org>
References: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
 <20240119-iio-backend-v6-2-189536c35a05@analog.com>
 <170568455347.599801.4301742729712962299.robh@kernel.org>
 <20240121171720.47b61298@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121171720.47b61298@jic23-huawei>

On Sun, Jan 21, 2024 at 05:17:20PM +0000, Jonathan Cameron wrote:
> On Fri, 19 Jan 2024 11:15:56 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Fri, 19 Jan 2024 17:00:48 +0100, Nuno Sa wrote:
> > > 'adi,adc-dev' is now deprecated and must not be used anymore. Hence,
> > > also remove it from being required.
> > > 
> > > The reason why it's being deprecated is because the axi-adc CORE is now
> > > an IIO service provider hardware (IIO backends) for consumers to make use
> > > of. Before, the logic with 'adi,adc-dev' was the opposite (it was kind
> > > of consumer referencing other nodes/devices) and that proved to be wrong
> > > and to not scale.
> > > 
> > > Now, IIO consumers of this hardware are expected to reference it using the
> > > io-backends property. Hence, the new '#io-backend-cells' is being added
> > > so the device is easily identified as a provider.
> > > 
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >   
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > ./Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml:45:5: [error] syntax error: could not find expected ':' (syntax)
> If this is all that comes up for v6, I can fix it up whilst applying.

I would not recommend that unless you run the DT checks. This is a YAML 
error which is just the first thing that has to be valid. After that, we 
check against the DT meta-schema. Then we check all the examples 
(because any example could use any schema).

Though, it looks like the above is the only issue.

Reviewed-by: Rob Herring <robh@kernel.org>

Rob

