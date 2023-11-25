Return-Path: <linux-iio+bounces-357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2297F8C87
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 17:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31EC5B210B2
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D6A28383;
	Sat, 25 Nov 2023 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG5WG1ci"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B56FFBF5;
	Sat, 25 Nov 2023 16:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D65C433C7;
	Sat, 25 Nov 2023 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700930741;
	bh=kC67tlW47eQO8hIkRqPMLcnEKgkghYrvxLkHQPnjYIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PG5WG1cil8UVXUZ+TJ6SDZt0pEnC8sBNnLwATz+ip+qJd0BYmRHf9mourflb6J2RG
	 rgYDKodTH+9brjJQE6wjDkvHBDF5lQ3Wl/jocRE77W4YriCE5aHFYpTFfav4n2ljiN
	 QxbAIZ8jIi00mapBRw/I/rt2pf+HCkhQQ3cyUJS0yOFaKuIKF50JKAQJysq7/6sxyn
	 /NTAFTxqkZ7o4LlfZvvf14l2sK4MPbp9YArbCoYWMGIUmW6zHOjeu6xeLKF18ucVkD
	 vmJ0gKCDxazeaYdWWQAwyeUTZ8cKGWr0D/t5p7B3CO3tidA4wL0szbFRCiC+OasbE0
	 65adPTDu9VAtg==
Date: Sat, 25 Nov 2023 16:45:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: light: add VEML6075 UVA and UVB light
 sensor driver
Message-ID: <20231125164533.57abf756@jic23-huawei>
In-Reply-To: <659d5d74-4861-45c4-8b95-218f3a7e60cf@gmail.com>
References: <20231110-veml6075-v2-0-d04efbc8bf51@gmail.com>
	<20231110-veml6075-v2-3-d04efbc8bf51@gmail.com>
	<20231125151116.6d9b6e46@jic23-huawei>
	<659d5d74-4861-45c4-8b95-218f3a7e60cf@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Nov 2023 17:17:06 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 25.11.23 16:11, Jonathan Cameron wrote:
> > On Sat, 25 Nov 2023 12:56:57 +0100
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >   
> >> The Vishay VEMl6075 is a low power, 16-bit resolution UVA and UVB
> >> light sensor with I2C interface and noise compensation (visible and
> >> infrarred).
> >>
> >> Every UV channel generates an output signal measured in counts per
> >> integration period, where the integration time is configurable.
> >>
> >> This driver adds support for both UV channels and the ultraviolet
> >> index (UVI) inferred from them according to the device application note
> >> with open-air (no teflon) coefficients.
> >>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> > 
> > Hi Javier,
> > 
> > A few more minor things. Looks good in general.
> > 
> > Jonathan
> >   
> >> +struct veml6075_data {
> >> +	struct i2c_client *client;
> >> +	struct regmap *regmap;
> >> +	struct mutex lock; /* integration time/measurement trigger lock */  
> > 
> > Could perhaps be clearer. Maybe something like
> > 	/* Prevent integration time changing during a measurement */
> >   
> It prevents integration time changing as well as measurement triggers
> while a measurement is underway. I just wanted to cover both usages with
> a short comment in the same line.

Ah.  Well I misunderstood it, so burn a few more lines :)

> >> +
> >> +static int veml6075_uva_comp(int raw_uva, int comp1, int comp2)
> >> +{
> >> +	int comp1a_c, comp2a_c, uva_comp;
> >> +
> >> +	comp1a_c = (comp1 * VEML6075_A_COEF) / 1000U;
> >> +	comp2a_c = (comp2 * VEML6075_B_COEF) / 1000U;
> >> +	uva_comp = raw_uva - comp1a_c - comp2a_c;
> >> +
> >> +	return clamp_val(uva_comp, 0, U16_MAX);
> >> +}
> >> +
> >> +static int veml6075_uvb_comp(int raw_uvb, int comp1, int comp2)
> >> +{
> >> +	int comp1b_c, comp2b_c, uvb_comp;
> >> +
> >> +	comp1b_c = (comp1 * VEML6075_C_COEF) / 1000U;  
> > 
> > Any of units.h appropriate here?  I'm not sure if the / 1000U is a units
> > thing or not.
> >   
> These divisions are used to scale the coefficients down, as they are
> defined as entire numbers. These coefficients have no units and the
> resulting value is a count.
Fair enough.
> 
> I have nothing to add to the rest of your comments. I will start working
> on v3.
> 
> Thanks again for your thorough review.
> 
> Best regards,
> Javier Carrasco


