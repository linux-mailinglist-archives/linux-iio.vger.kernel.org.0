Return-Path: <linux-iio+bounces-3816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8AA88C9D0
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 17:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480BD3261FC
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 16:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403DA1B970;
	Tue, 26 Mar 2024 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="milUpa8T"
X-Original-To: linux-iio@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4E612E75;
	Tue, 26 Mar 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471857; cv=none; b=oM8INb8gzbDl65SQRZLEbHh+QV5orTXe+sogZu7DpQuDY7B5nLTuYVU39fmha0vvI2WOwhSwCuFCmtzCkupb3rJrE0EB0uu397zVTP9+H1WpH8idktcj3QArpQkXiv7ZWlxo7n+3vj+gifngywZ03BjITC/f5uhMyjp+CLRIr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471857; c=relaxed/simple;
	bh=AFwsZIFN5v5W4l6gSL6hHE2kQ2JZb5YaRIVIFmnNG2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhWZayJSYcxOqFg428mukOOAgblt8YQWKElAS2mBHo6Bq6p8FuLoeq0s7jLDVIOpc12hvEvkBmWFE+LDDhY1YyLKtA0bj4MRRpMCPUa+SLTzNqTpJtR6TY4RPbKF4cR8u3Ror25e4Osf6tBOjnz3qaNpPZGc/gPQU1r/Uh+DD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=milUpa8T; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 502CE497;
	Tue, 26 Mar 2024 17:50:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711471820;
	bh=AFwsZIFN5v5W4l6gSL6hHE2kQ2JZb5YaRIVIFmnNG2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=milUpa8TS4hsQHJXSbPDSgc2lv0xGxrggMCHGugFP6uPQfXByX9PW0utWIMprGsS0
	 BWdDBQLnI7aPyXG5H/xAXhlKK+8Lzhj2c4Z1AVxCR7az00HKLy9GTdwBKQSwNbRdxw
	 J76mAM/s9G1U9fHBEZ9cQOmcwwJvVvCj3abROIjE=
Date: Tue, 26 Mar 2024 18:50:43 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Trevor Zaharichuk <trevor@au-zone.com>,
	Greg Lytle <greg@au-zone.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: iio: dac: ti,dac5571: Add DAC081C081
 support
Message-ID: <20240326165043.GB28895@pendragon.ideasonboard.com>
References: <20240325203245.31660-1-laurent.pinchart@ideasonboard.com>
 <20240325203245.31660-2-laurent.pinchart@ideasonboard.com>
 <20240325204857.4f2fd468@jic23-huawei>
 <20240325205641.GD23988@pendragon.ideasonboard.com>
 <20240326152927.00006229@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240326152927.00006229@Huawei.com>

On Tue, Mar 26, 2024 at 03:29:27PM +0000, Jonathan Cameron wrote:
> On Mon, 25 Mar 2024 22:56:41 +0200 Laurent Pinchart wrote:
> > On Mon, Mar 25, 2024 at 08:48:57PM +0000, Jonathan Cameron wrote:
> > > On Mon, 25 Mar 2024 22:32:41 +0200 Laurent Pinchart wrote:
> > >   
> > > > The DAC081C081 is a TI DAC whose software interface is compatible with
> > > > the DAC5571. It is the 8-bit version of the DAC121C081, already
> > > > supported by the DAC5571 bindings. Extends the bindings to support this
> > > > chip.
> > > > 
> > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>  
> > > 
> > > Hi Laurent,
> > > 
> > > Given it's a part number where no one is going to guess it is compatible
> > > with the DAC5571 and that we don't have a history of fallback compatibles
> > > I'm fine with this change, but just wanted to ask is a fallback compatible
> > > useful to you to run with older kernels?
> > > 
> > > I should have noticed when Peter added the dac121c081. If we add a fallback
> > > should do that one as well.  
> > 
> > I've indeed noticed that there should have been a fallback for
> > dac121c081, but didn't stop to ponder why that wasn't the case, and just
> > went along with the flow :-) I agree a fallback could be useful, which
> > would then allow dropping patch 2/5 from this series (*). I can do so if
> > you prefer.
> > 
> > * This is not entirely true. While the DAC1081C081 is largely compatible
> > with the DAC5573, they have different values for one of the power-down
> > resistors (2.5kΩ instead of 1kΩ if I recall correctly). To be completely
> > accurate, the driver should report that. We could still use the fallback
> > compatible, reporting the wrong power-down resistor value.
> 
> Hmm - Would anyone really care about that value being wrong?

I don't have enough expertise with IIO to be sure, but my guess is that
nobody would.

> I think perhaps that's just about significant enough that maybe a fallback
> compatible doesn't make sense here.

Then let's keep it simple and just merge this patch as-is ? :-)

> > > > ---
> > > >  Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > > > index 79da0323c327..e59db861e2eb 100644
> > > > --- a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> > > > @@ -21,6 +21,7 @@ properties:
> > > >        - ti,dac5573
> > > >        - ti,dac6573
> > > >        - ti,dac7573
> > > > +      - ti,dac081c081
> > > >        - ti,dac121c081
> > > >  
> > > >    reg:  

-- 
Regards,

Laurent Pinchart

