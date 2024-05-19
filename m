Return-Path: <linux-iio+bounces-5096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F4A8C9490
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 13:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1771F212BE
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 11:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14244595B;
	Sun, 19 May 2024 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI7168XN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB442A1D2;
	Sun, 19 May 2024 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716119838; cv=none; b=jAQfK8KCXFkqOcUPh6lhd2d2c8H6nMCtN7ghqxIKlpW21ChzEOMMY7OXGHOFiP8cPLPzSqzno+mPXqnE3LLGPpkO2eXDV9YJR4JeKHuRjrM+/KDcig9j4m1Jw+FaJm0DT/1Q3hVBDxZjuuZ+NrS1k6fR/C5kbLpEkFnQA5yfDqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716119838; c=relaxed/simple;
	bh=ey6MLEniB9vujaIVqdYKXqos4DwJBPLSPhtEc/aWhmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUgEVnlvZIugOGttIUIz13eexz2xUlDrAfdK5zU1+gGz44dizOGesW/tpFBq9q6g57lmF+fYBFNpEJ197vSuF+r5MAWzUlgQwq0nlrxleSa/Oe16uCTahAyjHn0qZylO303ZOUQEqSMMLGMZIp3tR9Qs4FCtueUncFi3Kqnf1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI7168XN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07494C32781;
	Sun, 19 May 2024 11:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716119838;
	bh=ey6MLEniB9vujaIVqdYKXqos4DwJBPLSPhtEc/aWhmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bI7168XNXTR0eADGSnmzaBncTN+GlvwjbX84A0TfzMGwDUVk5gTDus0x3TbB84JBG
	 e2wPqGhePh4SM/PtDyP7NOMwbs4wsgMt3J2zlww0ESYW02/3teUD3I1sxECObSbQ2Y
	 A+FkDkQdqKscd57KlUEfU40MhOntP5CwNQY6BIMjyj60PMs3vpG7O2tnzKRse8EiPv
	 GdYYZACC08y/Ztdp3ffsBlwPTWO/7cDzmwbtgU6qNDPgGJdi2Nq0jzQXKkQLjWpbkj
	 f9T9zH1XNl340wkgUmSLDzxei3V57FAgbL2lGl0DeGVZjLJaa3Iwrczbo+OmQizkfu
	 9ErnLvbw3fR9Q==
Date: Sun, 19 May 2024 12:57:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Arthur Becker <arthur.becker@sentec.com>, "robh@kernel.org"
 <robh@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: light: add veml6040 RGBW-LS bindings
Message-ID: <20240519125705.49967e97@jic23-huawei>
In-Reply-To: <20240513-repulsive-fiftieth-884b3805472f@spud>
References: <ZR1P278MB1117B205886E023F9F72A2E881E22@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
	<20240513-repulsive-fiftieth-884b3805472f@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 17:26:12 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Mon, May 13, 2024 at 02:35:44PM +0000, Arthur Becker wrote:
> > This commit adds device tree bindings for the veml6040 RGBW Light Sensor
> > 
> > signed-off-by: Arthur Becker <arthur.becker@sentec.com>  
> 
> If you're writing a standalone binding for this and not putting it into
> trivial-devices.yaml you should document the supply for this device.

It's a broken email thread. Driver is there, but soemthing has gone
wrong with sending.

Arthur, if this is a company email setup thing, consider the b4 web portal
method for v2.

Jonathan

> 
> > ---
> > 
> >  .../bindings/iio/light/veml6040.yaml          | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/veml6040.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/veml6040.yaml b/Documentation/devicetree/bindings/iio/light/veml6040.yaml
> > new file mode 100644
> > index 000000000000..796c22f75575
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/light/veml6040.yaml  
> 
> Filename matching the compatible please.
> 
> > @@ -0,0 +1,43 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/light/veml6040.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: VEML6040 RGBW Light Sensor
> > +
> > +maintainers:
> > +  - Arthur Becker <arthur.becker@sentec.com>
> > +
> > +description: |  
> 
> This | isn;t needed, you've got no formatting to preserve.
> 
> 
> Cheers,
> Conor.


