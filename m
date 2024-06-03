Return-Path: <linux-iio+bounces-5705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D116F8D888C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 20:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFB9287A84
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6D8137C5B;
	Mon,  3 Jun 2024 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+dt66CK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152FD12F373;
	Mon,  3 Jun 2024 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717438954; cv=none; b=EfO1NLVVKlrPoeGeMEVBR1GoPWRvHlq7Nfkk7wR+aYTG4GjnEiXqk/bnq8lXZIpQ4VW7nA4Jrcgooqq9lNQS5RgWuLxX1OAMhaaAw3kn9T6yl2vqSnHTCQeeDmUFSlRWFVLsQNTzkvDNvX+uGv4tndKME9fA2dY713Bmz29/jQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717438954; c=relaxed/simple;
	bh=ZxIaBBVsVE8FhtO5Aw1+wscbKFCkppWXZJLvVEeBsa0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDh4yUM9xmyrROo88SRB1Hp6+jHE/9zDi1631WpcOwV3jT9j2pi/Ht6RKJLaLT9p4WN20gpMHPfPxW6yYGj51Q1KwJO+p+91R5Lue1oQKOJgiduNALIRoAos6XNAzB2UbgD6KaeR2CJfQWfIVNrYn+7VJ9bVCeGVRq52/F5vGSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+dt66CK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04ED9C2BD10;
	Mon,  3 Jun 2024 18:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717438953;
	bh=ZxIaBBVsVE8FhtO5Aw1+wscbKFCkppWXZJLvVEeBsa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L+dt66CKZY4I5RJiztz2bavOo9ITeUb844lZlUoSPohkL+S4VmOVBCf/hz8V5o/PS
	 3G4oJTehF3kOCI/7s2i8wJsoI0OOieChMrRvb5iyYou0epjc7YZfZzwXFoABtCnWN9
	 yYytNB+PbNplJ9QUw2pXU9ai0wzVQ3GPLWGrz1R69j4s4A4q6DBrkQQ2Rf1RmFmRCU
	 VnOEduAk1ZrTWp5ID6RcrdzqR6srbrhXe9/2BqvOCW1zbA8INJ4AFdNWM6oXzWyoJd
	 ZmuMAnzOv7OSD1ZyUfdCZZG/7C1wHVymgT1/HVuIlxVYHN8XeVqcluJK4ho8KxIBPj
	 rK+wiAne6Y3VA==
Date: Mon, 3 Jun 2024 19:22:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arthur Becker <arthur.becker@sentec.com>
Cc: Arthur Becker via B4 Relay
 <devnull+arthur.becker.sentec.com@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio: light: driver for Vishay VEML6040
Message-ID: <20240603192218.23ad1b99@jic23-huawei>
In-Reply-To: <ZR1P278MB111719C989666990EB0B4D5E81FF2@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
References: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
	<20240527-veml6040-v3-1-6f3bbfd42960@sentec.com>
	<20240602142205.520c2635@jic23-huawei>
	<ZR1P278MB111719C989666990EB0B4D5E81FF2@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 12:18:58 +0000
Arthur Becker <arthur.becker@sentec.com> wrote:

> From: Jonathan Cameron <jic23@kernel.org>
> Sent: 02 June 2024 15:22
> To: Arthur Becker via B4 Relay
> Cc: Arthur Becker; Lars-Peter Clausen; Rob Herring; Krzysztof Kozlowski; Conor Dooley; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; devicetree@vger.kernel.org
> Subject: [EXTERNAL]Re: [PATCH v3 1/2] iio: light: driver for Vishay VEML6040
> 
> > Hi Arthur,
> > 
> > A few really trivial things inline. I'd have just tidied them up whilst
> > applying, but I think you are doing a v4 anyway to merge the bindings
> > so I'll leave the requested tweaks to you.
> > 
> > Jonathan  
> 
> Hi Jonathan,
> 
> Thanks for the feedback!
> Small question about that comment:
> 
> > > +
> > > +     ret = devm_regulator_get_enable(dev, "vdd");
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     int init_config =  
> >
> > Generally we are still sticking to traditional C rules so keep the
> > local variable definition at the top of the file.
> > The only common exception is when cleanup.h functionality is involved and
> > we want to ensure ordering by moving the variable definitions into the code.  
> 
> Do you mean at the start of the function, or rather a #define at the top of the
> file after the masks and register definitions?
> The use of 'FIELD_PREP' discards the 'static const int' option to initialise the
> variable at the top of the file.

start of the function for the variable.
e.g.
int init_config;


stuff..

init_config = FIELD_PREP() where you have it

Thanks,

Jonathan

> 
> Kind regards,
> Arthur
> 
> >  
> > > +             FIELD_PREP(VEML6040_CONF_IT_MSK, VEML6040_CONF_IT_40_MS) |
> > > +             FIELD_PREP(VEML6040_CONF_AF_MSK, 0) |
> > > +             FIELD_PREP(VEML6040_CONF_SD_MSK, 0);
> > > +
> > > +     ret = regmap_write(regmap, VEML6040_CONF_REG, init_config);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret,
> > > +                                  "Could not set initial config\n");
> > > +  
> 
> 


