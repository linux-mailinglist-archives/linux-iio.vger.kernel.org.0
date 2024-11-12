Return-Path: <linux-iio+bounces-12192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFA59C6546
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 00:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3B6B3C8E3
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 23:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E752B21C180;
	Tue, 12 Nov 2024 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="QSjWisTh"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D886121A71D;
	Tue, 12 Nov 2024 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453109; cv=none; b=Yo824P4nSJX26NdVywh7MJQv1DK+pYSTJ2cagofLJt5TP7hGmoRDDOsB2GqUDlORB98hd6T6wGdj0EoB8aUCVnm7bS452/bu3hkT6iwRkPdD495TBKIUlNU1jAYlySAVO69BN2xtYtgaFhtibqMYVmfExH9flcu+hXoftv+BXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453109; c=relaxed/simple;
	bh=NmO64Sjewa/+GsTTNydYxbpRHAP/H0Q6gTgckdfbwNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8t2LILVja1mLC0VJ2zoEKE4vJ6s/yNDI88fxW9JRd2WszGaHxgMDPsPh454Y1XySFqmHJOE3jmTAxm7Q9pQ02HL+TJO4lDMoNPv9cjBOuV2WmP61gE8iLGR+pxHBJUg6iuh/U7zCFPFTHieUF3jx1P1liMKEh4xRUGUI96nNJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=QSjWisTh; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id D08794C739;
	Tue, 12 Nov 2024 23:11:39 +0000 (UTC)
Date: Tue, 12 Nov 2024 18:11:37 -0500
From: Aren <aren@peacevolution.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Kaustabh Chakraborty <kauschluss@disroot.org>, =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, 
	Ondrej Jirman <megi@xff.cz>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] iio: light: stk3310: use dev_err_probe where
 possible
Message-ID: <6jwurbs27slfpsredvpxfgwjkurkqvfmzccaxnfgtuh4aks3c6@ciapprv3wsex>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-11-aren@peacevolution.org>
 <ZyiIcDaANjxwtCz-@smile.fi.intel.com>
 <m7x526sv5krgt4t2whn5ykyktoz5u7ihsxv3qa5yue3ucbk6lb@37spwsmlcylm>
 <ZzEPACoblmcQD9yu@surfacebook.localdomain>
 <xubjmxig4luag27ifnmqmv3x3bvzhwczwvw34kw6tssaa2d24t@ysnqh5e3g7sz>
 <ZzHSE9Nrf4YySJrq@smile.fi.intel.com>
 <4ibd5tgpt3uzbmouqdiiv5pvfxebo5qsmgn3xh6rlb73qevatv@cajznxqnlca3>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ibd5tgpt3uzbmouqdiiv5pvfxebo5qsmgn3xh6rlb73qevatv@cajznxqnlca3>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1731453101;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=/XvnojsbDU2iklE9xJFwgVgRWENV+XinNVMN6pOt4es=;
	b=QSjWisTh28m3ad1tuS8ksPEWHblcKQJX1GVqDMfbdGFRlCO9UKjCCII5U0UztBmrE6NUW1
	ajTb4KKLxsSIaHAKj3gbmwqW91BnTF6mZ0TQDRXEPGHJTR0fJFipdfoO1DNQLMvoEaffwy
	Uz5hZTjJ+fCuSFtKzzlpepmg9SJyEi0=

On Tue, Nov 12, 2024 at 11:15:54AM +0100, Uwe Kleine-König wrote:
> Hello Andy, hello Aren,
> 
> On Mon, Nov 11, 2024 at 11:44:51AM +0200, Andy Shevchenko wrote:
> > On Sun, Nov 10, 2024 at 04:34:30PM -0500, Aren wrote:
> > > On Sun, Nov 10, 2024 at 09:52:32PM +0200, Andy Shevchenko wrote:
> > > > Sun, Nov 10, 2024 at 02:14:24PM -0500, Aren kirjoitti:
> > 
> > You can do it differently
> > 
> > #define STK3310_REGFIELD(name)							\
> > do {										\
> > 	data->reg_##name =							\
> > 		devm_regmap_field_alloc(dev, regmap, stk3310_reg_field_##name);	\
> > 	if (IS_ERR(data->reg_##name))						\
> > 		return dev_err_probe(dev, PTR_ERR(data->reg_##name),		\
> > 				     "reg field alloc failed.\n");		\
> > } while (0)
> > 
> > > #define STK3310_REGFIELD(name) ({						\
> > > 	data->reg_##name = devm_regmap_field_alloc(dev, regmap,			\
> > > 						   stk3310_reg_field_##name);   \
> > > 	if (IS_ERR(data->reg_##name))						\
> > > 		return dev_err_probe(dev, PTR_ERR(data->reg_##name),		\
> > > 				     "reg field alloc failed\n");		\
> > > })
> > 
> > I am against unneeded use of GNU extensions.
> > 
> > > > > replacing "do { } while (0)" with "({ })" and deindenting could make
> > > > > enough room to clean this up the formatting of this macro though.
> > > > 
> > > > do {} while (0) is C standard, ({}) is not.
> > > 
> > > ({ }) is used throughout the kernel, and is documented as such[1]. I
> > > don't see a reason to avoid it, if it helps readability.
> > 
> > I don't see how it makes things better here, and not everybody is familiar with
> > the concept even if it's used in the kernel here and there. Also if a tool is
> > being used in one case it doesn't mean it's suitable for another.
> 
> Just to throw in my subjective view here: I don't expect anyone with
> some base level knowledge of C will have doubts about the semantics of
> ({ ... }) and compared to that I find do { ... } while (0) less optimal,
> because it's more verbose and when spotting the "do {" part, the
> semantic only gets clear when you also see the "while (0)". Having said
> that I also dislike the "do" starting on column 0, IMHO the RHS of the
> #define should be intended.

Thank you, this sums up my opinion on this better than I could have (and
some bits I hadn't considered).

> So if you ask me, this is not an unneeded use of an extension. The
> extension is used to improve readabilty and I blame the C standard to
> not support this syntax.
> 
> While I'm in critics mode: I consider hiding a return in a macro bad
> style.

Yeah... probably worse than any of the formatting options here. I guess
the proper way would be to use devm_regmap_field_bulk_alloc, but that's
well outside the scope of this series. Perhaps it would make sense to
move the macro definition to just before the function it's used in so
it's at least a little easier to spot?

 - Aren

