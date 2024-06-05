Return-Path: <linux-iio+bounces-5835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5008FD290
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 18:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F7A6B22810
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716CE154BFC;
	Wed,  5 Jun 2024 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2IRzr77"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5D2575A;
	Wed,  5 Jun 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604021; cv=none; b=a9lBkgaIX9OfIYM+JokSzS0mUEjIpWYkW+We4TbwkN/gObqYpcNXEvGJjacwp3Dbmbl+QX+n293Y8L28/k0IUyoRkGrv4mIBs+efARrdJ/ly1xyObksVtxKKSb0ngX5WM5o4XEeUEAVj3I/tMD8jjVEAKlWltF7RB2zI1vZCK6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604021; c=relaxed/simple;
	bh=xOMMuTmFafOBZoFgW+ylCUc2IiwmGERlE/npYTHqpj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnWNOuXNxb55SKwpovgFcfnMIxmpD4jQ0zjMge05wiR4v7UTzTlyJ/U86CNk4RjGuB+kx4UI9JXa0gI2JK6VwA+Ob7ATJ39Ihk+wZUWW4H/c6MJMr1p5re27n6z8oyui9Wie770nkGfqh/5QjC4W7aQUO5A1ceiFVGw5Q/RA5BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2IRzr77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457C5C2BD11;
	Wed,  5 Jun 2024 16:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717604020;
	bh=xOMMuTmFafOBZoFgW+ylCUc2IiwmGERlE/npYTHqpj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r2IRzr775nQzqud0EzuWd8pj1F3rd7fC2g0l9tQaXPIQYgezvxSvBJnBs5jCfeAWz
	 3PRXDWr14tTmU6D9hhQLz0GUTb6+PisQsOO8fIH3wIwkkSfh05S6l8M9OSBnq1G8rN
	 DoCsL1M1k419l4ep+liEHMSogMEyhhZmEMwV0KgD+hOmKFIXkAyGATWpyoBcR1huDZ
	 G5hppLh1nINaHnPL9dAsptnLF18CiGVK4houAzQpWAnZ6vn2D1TgYA+cVCwUFT1sGy
	 yEPXiWZzA2n99txWgecgAjgmJ52if8+prSkzpoc/wK+aKPpNyXrNDIKl7QMlAE4QPa
	 7RQ3YBn61mtaQ==
Date: Wed, 5 Jun 2024 10:13:37 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Konstantin Porotchkin <kostap@marvell.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-phy@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 4/7] dt-bindings: phy: armada-cp110-utmi: add optional
 swap-dx-lanes property
Message-ID: <20240605161337.GA3256958-robh@kernel.org>
References: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
 <20240602-cn9130-som-v6-4-89393e86d4c7@solid-run.com>
 <20240604-tucking-aggregate-0496e393f21c@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604-tucking-aggregate-0496e393f21c@spud>

On Tue, Jun 04, 2024 at 06:41:03PM +0100, Conor Dooley wrote:
> On Sun, Jun 02, 2024 at 05:49:39PM +0200, Josua Mayer wrote:
> > Armada CP110 UTMI supports swapping D+ and D- signals.
> > usb251xb.yaml already describes a suitable device-tree property for the
> > same purpose but as child usb controller node.
> > 
> > Add optional swap-dx-lanes device-tree property to armada cp110 utmi phy
> > with same semantics as usb251xb:
> > The property lists all ports that swap D+ and D-, unlisted ports are
> > considered correct.
> > 
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > ---
> >  .../devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml      | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
> > index 9ce7b4c6d208..2ef02aac042a 100644
> > --- a/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
> > @@ -41,6 +41,12 @@ properties:
> >        Phandle to the system controller node
> >      $ref: /schemas/types.yaml#/definitions/phandle
> >  
> > +  swap-dx-lanes:
> 
> Missing a vendor prefix.
> Otherwise, to me naive eye, seems okay.

Already have the same property elsewhere, so it's fine.

> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description: |
> 
> This | probably isn't needed though, there's not any format here that
> seems worth preserving.
> 
> Thanks,
> Conor.
> 
> > +      Specifies the ports which will swap the differential-pair (D+/D-),
> > +      default is not-swapped.
> > +
> >  # Required child nodes:
> >  
> >  patternProperties:
> > 
> > -- 
> > 2.35.3
> > 



