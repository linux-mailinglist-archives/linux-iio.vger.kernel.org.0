Return-Path: <linux-iio+bounces-165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673DA7F06D4
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 15:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662041C208CA
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601521094C;
	Sun, 19 Nov 2023 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMQo7IKW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031C3D269;
	Sun, 19 Nov 2023 14:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CBDC433C7;
	Sun, 19 Nov 2023 14:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700403959;
	bh=9IicQLoKgbPMOx935wvUZr6B2SQDDBnP1LwHZpDqu6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CMQo7IKWZi9ZhX06FvE50+MntX84iK6xRgFPwTILyeKCC+A0CrY7Neghy6fdgSqf6
	 H0/0BA25yDMQ0b50s44al3amWyu67POZbJb+PrS9qQlOHeIdtQzk+hVgpXKBpkzARc
	 vjrfoVBIO+k7DHqo/gftT/KrY55RgQF/kAvIsXlWj4Zl7VvV2VJoA2zp/2fyR32vcm
	 eus6hIIAaNHIxy4AGqas+z0tZKM98gYmB1eoLtQRKM7Pcx0H/YvHUOKIsHuDnUpqZB
	 Zqh2mQQmsDITbgWpi1ly+Jd8hhHlvqWuMCPy8StaPCZVevanrIvfTwbjZf7Xhzwl4I
	 RWAnJeMFR9B5Q==
Date: Sun, 19 Nov 2023 14:25:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: add VEML6075 UVA and UVB light sensor
 driver
Message-ID: <20231119142547.6524160d@jic23-huawei>
In-Reply-To: <4dbcd233-cdd7-49ad-8db6-4bd3d706e82d@gmail.com>
References: <20231110-veml6075-v1-0-354b3245e14a@gmail.com>
	<20231110-veml6075-v1-1-354b3245e14a@gmail.com>
	<4dbcd233-cdd7-49ad-8db6-4bd3d706e82d@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Nov 2023 06:08:25 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 19.11.23 05:58, Javier Carrasco wrote:
> > The Vishay VEMl6075 is a low power, 16-bit resolution UVA and UVB
> > light sensor with I2C interface and noise compensation (visible and
> > infrarred).
> > 
> > Every UV channel generates an output measured in counts per integration
> > period. Available integration times are 50 ms, 100 ms, 200 ms, 400 ms
> > and 800 ms,
> > 
> > This driver adds support for both UV channels and the ultraviolet
> > index (UVI) inferred from them according to the device application note
> > with open-air (no teflon) coefficients.
> > 
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Hi Javier,

One process note highlighted by this email.
Please crop to only relevant text when replying.  Scrolling takes time!
+ makes it hard to be sure we didn't miss anything buried in hundreds
of lines of unnecessary context.

I'm jet lagged so may be more grumpy than average today :(

Thanks,

Jonathan


> > +static int veml6075_uva_comp(int raw_uva, int comp1, int comp2)
> > +{
> > +	int comp1a_c, comp2a_c, uva_comp;
> > +
> > +	comp1a_c = (comp1 * VEML6075_A_COEF) / 1000U;
> > +	comp2a_c = (comp2 * VEML6075_B_COEF) / 1000U;
> > +	uva_comp = raw_uva - comp1a_c - comp2a_c;
> > +	pr_err("JCC: uva=%d, c1=%d, c2=%d, c1ca=%d, c2ca=%d, uvac=%d\n",
> > +	       raw_uva, comp1, comp2, comp1a_c, comp2a_c, uva_comp);  
> Obviously this debug message should be gone and it will be removed for v2.
> > +
> > +	return clamp_val(uva_comp, 0, U16_MAX);
> > +}
> > +
> > +static int veml6075_uvb_comp(int raw_uvb, int comp1, int comp2)
> > +{
> > +	int comp1b_c, comp2b_c, uvb_comp;
> > +
> > +	comp1b_c = (comp1 * VEML6075_C_COEF) / 1000U;
> > +	comp2b_c = (comp2 * VEML6075_D_COEF) / 1000U;
> > +	uvb_comp = raw_uvb - comp1b_c - comp2b_c;
> > +	pr_err("JCC: uvb=%d, c1=%d, c2=%d, c1cb=%d, c2cb=%d, uvbc=%d\n",
> > +	       raw_uvb, comp1, comp2, comp1b_c, comp2b_c, uvb_comp);  
> Same here.
> > +
> > +	return clamp_val(uvb_comp, 0, U16_MAX);
> > +}
> > +

