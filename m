Return-Path: <linux-iio+bounces-26054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B15FC43D40
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 13:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA383AE79A
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 12:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C112EBBAF;
	Sun,  9 Nov 2025 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGr1dF+G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1F12C11EB;
	Sun,  9 Nov 2025 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762690602; cv=none; b=JNS4Lt95qMC7hIdxl6F5ViqWvItIM4WD9os+Gf9AULiUGppxoUm3nx+eneHzWMt6aHgKND4MElQe11jtAXF4Pga7w7pNU7qP+EwSfVxSbw4eGNRMms4xTJS4eBnikiDkbqblMGlTwE83s1eVz3XXzXzHZZqoTVZee2Dqlf6Eud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762690602; c=relaxed/simple;
	bh=kz3tmzeJ3KnVrD6iMiTnXlqKxp3Zc03s5dzITi21zr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4Qu6jCAbzyDDtmQu+Ie4/AS56fBG0CJ4DsGm1LLal/ciIgS3wgAFdNyabOUl2d5+1T2Od+EgP03Cylf39An/c2pU2IxN0nsXfsSZXWxPrn+9MaIqWkYyTiLDTOmH6sdlrBuv1NNpw1DRPfLS0L2zXSdo6QiwV93LTfJ5bBEj3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGr1dF+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88889C4CEF7;
	Sun,  9 Nov 2025 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762690602;
	bh=kz3tmzeJ3KnVrD6iMiTnXlqKxp3Zc03s5dzITi21zr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sGr1dF+G9IaB07Hcgnu7+Os9kLv5Tfz1OKipWSG9PojV+wIYuIEGJ9RF2cqZTeDWa
	 Wu8t/0uxwDlquQrxs+XLPwney26RQS5ULrQe18o082zNaqvEPy5QQ4WfTJWikZYp2z
	 6qwUFlrM71QEP7Ztmolq9hVL8UmXZJ/SRCfOLZbpF7DQZdqy7l2imJQYStVnx6iMpX
	 C5+lRstEdQLZO/x/duaPxm++P+TlAhM6x/C9/iPI4yjPCzGqAKttOT21gVlG7NnSUe
	 gC3OeTstOGP5/cfZ/pehsDnlypGmrUNDSXD53e6EgaMf3G4Fqtl9d1Yemn2WxWdx0D
	 FVY+5eBJZsDhg==
Date: Sun, 9 Nov 2025 12:16:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/7] docs: iio: New docs for ad4062 driver
Message-ID: <20251109121635.6c920f33@jic23-huawei>
In-Reply-To: <ryiifvt7vedgyjgwx3bydty5fvlkffnsjpptj2sc462h3ji4hc@nrna47ekhmni>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
	<20251013-staging-ad4062-v1-2-0f8ce7fef50c@analog.com>
	<20251018162113.002d92f7@jic23-huawei>
	<skcjf6tdo7bktdx4g2bm42gkzd5vdtckxsxzgu7s6dwmiwfdpw@hxhol4g4adcs>
	<20251102123727.0aa4c031@jic23-huawei>
	<6zxwgpdz6zz3owrr5h277otv4b3gbbc47amgatkyatjdv2ruqv@kgsekg6utqqc>
	<ryiifvt7vedgyjgwx3bydty5fvlkffnsjpptj2sc462h3ji4hc@nrna47ekhmni>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > > > > +
> > > > > > +Device attributes
> > > > > > +=================
> > > > > > +
> > > > > > +The ADC contains only one channel with following attributes:
> > > > > > +
> > > > > > +.. list-table:: Channel attributes
> > > > > > +   :header-rows: 1
> > > > > > +
> > > > > > +   * - Attribute
> > > > > > +     - Description
> > > > > > +   * - ``in_voltage_calibscale``
> > > > > > +     - Sets the scale factor to multiply the raw value.    
> > > > > That's confusing.  This should be hardware 'tweak' to compensate for
> > > > > calibration or similar.  The text doesn't make it clear where that multiply
> > > > > is happening. Sounds too much like _scale.    
> > > > 
> > > > The user does raw * _scale * _calibscale to get the value in volts.  
> > > 
> > > That's not ABI compliant so no general purpose user space is going to do that.
> > > So a hard no for this being what userspace needs to apply.
> > > 
> > > I'm not particularly keen on calibscale for things other than tweaking so
> > > that raw * _scale is in milivolts.
> > > 
> > > Normally if we have other forms of controllable scaling it's a question
> > > of wrapping up any such scan factors into a writeable _scale.
> > >   
> > 
> > Ack, will update to raw * _scale, embedding the _calibscale into the
> > _scale value.
> >   
> 
> Fixup on my side, there is no need to "embed _calibscale into _scale".
> The only change that needs to be made is re-wording the doc to clarify
> that it is the hw that compensates for calibration errors:
> 
>     * - ``in_voltage_calibscale``
> -     - Sets the scale factor to multiply the raw value.
> +     - Sets the gain scaling factor that the hardware applies to the sample,
> +       to compensate for system gain error.
> 
> (datasheet p22, Gain Scaling)
> The mv reading is raw * _scale.

Good. That aligns with normal use of calibscale.

> 
> Best regards,
> Jorge

