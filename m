Return-Path: <linux-iio+bounces-5101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D5F8C94A2
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 14:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B3F1B20DB2
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 12:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2218447A5C;
	Sun, 19 May 2024 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzifGzCt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC74E14F90;
	Sun, 19 May 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716122000; cv=none; b=Eao0oyeBSprM7PpwpoU6zsXT6FQtT7LxJp+oZbclAK5VuPIxES0uvICKSBGDS9n9HkZsAWieXb+vgKr17BIVR8WNcZjBu5VndZcNi/0+Mz3qENDDDmEbls4QCCYzq2CJsQutxNkil/RhPSibKhEsIejAMISQ0E0Ho5I9rRON7FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716122000; c=relaxed/simple;
	bh=wbexZ8wB1sbBoEDLTe39njlC00h9VMxfoCaQQap7wAU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InDyaNkgakcF02+RWcXYAP+eB1W1WKn1mLreOxYyphjszcNLZt3fdR53ZbhwA55VKwr0IWOVAFu7YWoj2Eii8lRg4gJW7ukqJ9xVZSfgQ0c+5uSx65caQKeoyQyGdxalKVd0weVRwjGlj351YbgPYpWMTu8qzA8nEdSob3Zoi0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzifGzCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0D3C32781;
	Sun, 19 May 2024 12:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716122000;
	bh=wbexZ8wB1sbBoEDLTe39njlC00h9VMxfoCaQQap7wAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OzifGzCtLi2+gxXyR17nDNKNdHavwjblvYPWjfmjEX2SrbqCo/EobtAJTJJToGcw1
	 JJjZU/Za7Q9cmPtmll4wN8/SZQdII68WFckfIQvO/JDPfBOieOlk/emweVohvb1QMB
	 u76W9FGkYRq3RV3MYhP+B86cvMMHQ7JNKej8viD8PS0W6kszEdpIbJxdqjn5oq9VjS
	 gRAcWr7n8zRRgcFq79v32aqERuRwzqA2bDQC9eJRlMoHBIG3G9khW3g8+SdkivFoCa
	 aKY8ZSgqBnW1AMl6Q7YJGQveeP1tIIpqgHXDfLGT1NIQ5XQwO5+6czgYamdSBREoYn
	 JmSvxQzSaOIYQ==
Date: Sun, 19 May 2024 13:33:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Gustavo Silva <gustavograzs@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, lars@metafoo.de,
 christophe.jaillet@wanadoo.fr, gerald.loacker@wolfvision.net,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: Add ENS160 as trivial device
Message-ID: <20240519133311.3752bb58@jic23-huawei>
In-Reply-To: <20240513-entree-ferris-cbaf7c57b0b5@spud>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
	<20240512210444.30824-3-gustavograzs@gmail.com>
	<20240513-entree-ferris-cbaf7c57b0b5@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 17:09:46 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Sun, May 12, 2024 at 06:04:38PM -0300, Gustavo Silva wrote:
> > ScioSense ENS160 is a multi-gas sensor.
> > 
> > Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>  
> 
> Looks like this device has two supplies, Vdd and Vddio.
> Jonathan generally likes supplies to be documented, so that would
> disqualify this as a trivial device.

Agreed. History here is that we have put lots of IIO supported
devices in trivial-devices in the past and then it's turned out
someone has them on a board where they are controllable supplies.
So we end up having introduced insufficient binding docs + need
to move it later.

Much better to just have them documented from the start + just
turn them on at driver probe and off at remove (relying on regulator
subsystem support for fake supplies / fixed regulators where these
operations do nothing).  If someone wants to later do better power
control then that can be added without adding to the binding.

Jonathan

> 
> Cheers,
> Conor.
> 
> > ---
> >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> > index e07be7bf8..cdd7f0b46 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -318,6 +318,8 @@ properties:
> >            - samsung,24ad0xd1
> >              # Samsung Exynos SoC SATA PHY I2C device
> >            - samsung,exynos-sataphy-i2c
> > +            # ScioSense ENS160 multi-gas sensor
> > +          - sciosense,ens160
> >              # Semtech sx1301 baseband processor
> >            - semtech,sx1301
> >              # Sensirion multi-pixel gas sensor with I2C interface
> > -- 
> > 2.45.0
> >   


