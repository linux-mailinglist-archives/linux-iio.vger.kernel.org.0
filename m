Return-Path: <linux-iio+bounces-3805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF7888B3EE
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 23:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4F71C3F724
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 22:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DBB74C1B;
	Mon, 25 Mar 2024 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uaYP/XGP"
X-Original-To: linux-iio@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4374425;
	Mon, 25 Mar 2024 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405406; cv=none; b=ZPVgdna85aieUVRanECtzCjVa+YgpBp1ovZ5oDg3z8Y/IqWHQaeGKuQNvGOOJS5OxLlylq+/jAiL0PONEesyN5kkgNFXyM/sgeyN4CPxIHWKaVYhmRqE90NOnCzNSKdtU2ei2lJ2dqDOjq4rL7xtYtfOLZSsLNk+AdYe2YcimUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405406; c=relaxed/simple;
	bh=qhW9rhFDUkH+JTE+MbcNeN6H4W5aicNNvquZESdi4GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCcWcb22dJNCjfhksR5/iFcIHtDm/moNLKd72D7RHbNIK1PnBC7dlZlZO/9/5HOUHNh9jDzQfO0Hdr+rrvbu5HOK79RB9s92zE1nT0h0llCqfgnJp/UuBaaO6WB6K2hOrt2tDEOBFEVJey72nBEYp0MmnpwD7iPMqkEHMJJIdFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=uaYP/XGP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4EB617E4;
	Mon, 25 Mar 2024 23:22:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711405364;
	bh=qhW9rhFDUkH+JTE+MbcNeN6H4W5aicNNvquZESdi4GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uaYP/XGP7KYzrGqIuBwg/+cd9F7590d8ScIbGTVXxjr/UBVG+po6pvGI5boyepIJN
	 DgO+dQIiuNOsY2yNQW/mGBagkX1djkxW3iPILvSa32soutZqVtdciWyZ+gD+S0AccX
	 YGLGalw40uW4yU+Q9QVUTziOmGmLq6KDRq1owJUY=
Date: Tue, 26 Mar 2024 00:23:08 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Trevor Zaharichuk <trevor@au-zone.com>,
	Greg Lytle <greg@au-zone.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: iio: dac: ti,dac5571: Add DAC081C081
 support
Message-ID: <20240325222308.GA31216@pendragon.ideasonboard.com>
References: <20240325203245.31660-1-laurent.pinchart@ideasonboard.com>
 <20240325203245.31660-2-laurent.pinchart@ideasonboard.com>
 <20240325204857.4f2fd468@jic23-huawei>
 <20240325205641.GD23988@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325205641.GD23988@pendragon.ideasonboard.com>

On Mon, Mar 25, 2024 at 10:56:44PM +0200, Laurent Pinchart wrote:
> On Mon, Mar 25, 2024 at 08:48:57PM +0000, Jonathan Cameron wrote:
> > On Mon, 25 Mar 2024 22:32:41 +0200 Laurent Pinchart wrote:
> > 
> > > The DAC081C081 is a TI DAC whose software interface is compatible with
> > > the DAC5571. It is the 8-bit version of the DAC121C081, already
> > > supported by the DAC5571 bindings. Extends the bindings to support this
> > > chip.
> > > 
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Hi Laurent,
> > 
> > Given it's a part number where no one is going to guess it is compatible
> > with the DAC5571 and that we don't have a history of fallback compatibles
> > I'm fine with this change, but just wanted to ask is a fallback compatible
> > useful to you to run with older kernels?
> > 
> > I should have noticed when Peter added the dac121c081. If we add a fallback
> > should do that one as well.
> 
> I've indeed noticed that there should have been a fallback for
> dac121c081, but didn't stop to ponder why that wasn't the case, and just
> went along with the flow :-) I agree a fallback could be useful, which
> would then allow dropping patch 2/5 from this series (*). I can do so if
> you prefer.

And in that case, should I first introduce support in the bindings for
"ti,dac121c081", "ti,dac7571" and deprecate usage of "ti,dac121c081"
alone ?

> * This is not entirely true. While the DAC1081C081 is largely compatible
> with the DAC5573, they have different values for one of the power-down
> resistors (2.5kΩ instead of 1kΩ if I recall correctly). To be completely
> accurate, the driver should report that. We could still use the fallback
> compatible, reporting the wrong power-down resistor value.
> 
> > > ---
> > >  Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > > index 79da0323c327..e59db861e2eb 100644
> > > --- a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > > @@ -21,6 +21,7 @@ properties:
> > >        - ti,dac5573
> > >        - ti,dac6573
> > >        - ti,dac7573
> > > +      - ti,dac081c081
> > >        - ti,dac121c081
> > >  
> > >    reg:

-- 
Regards,

Laurent Pinchart

