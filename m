Return-Path: <linux-iio+bounces-3800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DCD88B21D
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 21:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB3E29C618
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 20:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572875B5DD;
	Mon, 25 Mar 2024 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WkH5Ay4Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DCB2F2D;
	Mon, 25 Mar 2024 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400212; cv=none; b=baBtFtWQT9m7dpDPYaR+48lc0JKJrAzA4KQ45wWx3fZFAthzBkUjvWkXkejvTHFZa/efGspNL3xU3sbhWSZXeIQDJIz+YpTdKD/Fu8HozRqpxfsqiBrFblO71EMOrCTT2eL2tMSFxSLn7K5q2d9UJePRMuGkq7MHORKjRHc8Klk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400212; c=relaxed/simple;
	bh=jZAaZSV8+oeKiKviZ1HtHAmT0OJ5cJAbq/XwTAhv4Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AM2dmk7gYY6fMUqDwUTRXv6hG3w3yP+ohiG14E5d6qrxn7uCFBpTvB7UmgoI5fPm4TQQhCyX7ArH2Gli7qqcn+fUyDL5Gv67cr0CYMvofgAgmlvssiI3ZutdiXrBJGVRltTWBgg9EvXG+maGHlr/HCwNmgyBB0i+HZFgAobqjes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=WkH5Ay4Y; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E4DBC7E4;
	Mon, 25 Mar 2024 21:56:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711400178;
	bh=jZAaZSV8+oeKiKviZ1HtHAmT0OJ5cJAbq/XwTAhv4Z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WkH5Ay4YO65Efcg8u+F3/kraIMLvPDeJo/fzZf51YWL3VgPRDsc+cFPhDTiD6eBZT
	 m4Gl67UD6OVYRs5tS+4GWkTR3FReLcNPdrV29i8Okyz6jJcy3aHj6YGNj1R0buhf0z
	 qnqQBXINhnHz5v2pojkw/D4bAG6n1prJr9TrCiYs=
Date: Mon, 25 Mar 2024 22:56:41 +0200
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
Message-ID: <20240325205641.GD23988@pendragon.ideasonboard.com>
References: <20240325203245.31660-1-laurent.pinchart@ideasonboard.com>
 <20240325203245.31660-2-laurent.pinchart@ideasonboard.com>
 <20240325204857.4f2fd468@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325204857.4f2fd468@jic23-huawei>

Hi Jonathan,

On Mon, Mar 25, 2024 at 08:48:57PM +0000, Jonathan Cameron wrote:
> On Mon, 25 Mar 2024 22:32:41 +0200 Laurent Pinchart wrote:
> 
> > The DAC081C081 is a TI DAC whose software interface is compatible with
> > the DAC5571. It is the 8-bit version of the DAC121C081, already
> > supported by the DAC5571 bindings. Extends the bindings to support this
> > chip.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Hi Laurent,
> 
> Given it's a part number where no one is going to guess it is compatible
> with the DAC5571 and that we don't have a history of fallback compatibles
> I'm fine with this change, but just wanted to ask is a fallback compatible
> useful to you to run with older kernels?
> 
> I should have noticed when Peter added the dac121c081. If we add a fallback
> should do that one as well.

I've indeed noticed that there should have been a fallback for
dac121c081, but didn't stop to ponder why that wasn't the case, and just
went along with the flow :-) I agree a fallback could be useful, which
would then allow dropping patch 2/5 from this series (*). I can do so if
you prefer.

* This is not entirely true. While the DAC1081C081 is largely compatible
with the DAC5573, they have different values for one of the power-down
resistors (2.5kΩ instead of 1kΩ if I recall correctly). To be completely
accurate, the driver should report that. We could still use the fallback
compatible, reporting the wrong power-down resistor value.

> > ---
> >  Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > index 79da0323c327..e59db861e2eb 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > @@ -21,6 +21,7 @@ properties:
> >        - ti,dac5573
> >        - ti,dac6573
> >        - ti,dac7573
> > +      - ti,dac081c081
> >        - ti,dac121c081
> >  
> >    reg:

-- 
Regards,

Laurent Pinchart

