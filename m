Return-Path: <linux-iio+bounces-16540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D040A57A58
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B711687FE
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 13:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720A71C3C04;
	Sat,  8 Mar 2025 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G67tpNNr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202041EEE6;
	Sat,  8 Mar 2025 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741439323; cv=none; b=UaR8bfuIFhsLDxXK7d//930kqCbFXp29Mp6xnMdHzk3eZkdPkY6+asJUs0oDek5OLdFmTDmTnvGm4UYFi1S4fcIK5RA5hDF/WUQUjG3mjCs8PvZvrDBQuyYV3XAdMrEg3Vfc1rRHGdHJo8SZAgGC7kzZdNecgcrEswnU6/Alii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741439323; c=relaxed/simple;
	bh=LmBiU5PiyOSxhnBucFy1GOl4q8RVr3YecX9BnA5oF8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzHXseZC55apkpfS0dxMUzsQ96h9E8GA9XH5K5i48+8bYG60WSwX4ZAYsli+HZ9t4MTjap3Rj+XTrz2gbs3y95lBBOW2xp1xbSLa7edAYa0t+hPMCeqa07OkfA71cIqYNL1UkVUqwQQSt/9p+qj50METNtBDjFbgVT54W8Rnv30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G67tpNNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AFAC4CEE0;
	Sat,  8 Mar 2025 13:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741439322;
	bh=LmBiU5PiyOSxhnBucFy1GOl4q8RVr3YecX9BnA5oF8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G67tpNNrPO/XZ5O10xtQtfAwEvKFvLuSqKkYPmJy8duxJEXEFTCVJ6pzFjIc2CLy3
	 PC3n6c+ReCciGA3wxBuxazLOqprjAdmkFTsiOiPcrbZsx84Dy7LMFRO6h0GfsZkMFK
	 WeqzipIcaAB6ddnWSVvi+x0QLmyKnKRM7z4IbQMhb2W5TmPgyz78tybqxoGsYHvi1k
	 p05LmH59qL3AYvFzvUfPsWMDwgfXHGQtIx8f0LCAC2kybijz9W6Q7LYOyp1ONU8Uxe
	 xu6aRbftirQwTbSDkcMHkEyBj5z2VlU6uM7VLLmKWcbfX8jLOBmtjril+VxMb8iQTO
	 yqe9+JqHl/QUw==
Date: Sat, 8 Mar 2025 13:08:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
 lgirdwood@gmail.com, broonie@kernel.org, dlechner@baylibre.com,
 jonath4nns@gmail.com
Subject: Re: [PATCH v4 11/17] iio: adc: ad7768-1: add regulator to control
 VCM output
Message-ID: <20250308130831.4ec56dcf@jic23-huawei>
In-Reply-To: <Z8sDlsOX0Elauabg@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
	<40c586006b5cee0570ae577db2b58e6e7e36a6e6.1741268122.git.Jonathan.Santos@analog.com>
	<Z8sDlsOX0Elauabg@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 11:32:54 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Looks ok. One minor commnet inline.
> 
> On 03/06, Jonathan Santos wrote:
> > The VCM output voltage can be used as a common-mode voltage within the
> > amplifier preconditioning circuits external to the AD7768-1.
> > 
> > This change allows the user to configure VCM output using the regulator
> > framework.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>  
> 
> Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>


...

> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index e88e9431bb7a..2a6317f5b582 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -12,8 +12,10 @@
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/regulator/driver.h>
> >  #include <linux/sysfs.h>
> >  #include <linux/spi/spi.h>
> >  
> > @@ -80,9 +82,15 @@
> >  #define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
> >  #define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
> >  
> > +/* AD7768_REG_ANALOG2 */
> > +#define AD7768_REG_ANALOG2_VCM_MSK	GENMASK(2, 0)
> > +#define AD7768_REG_ANALOG2_VCM(x)	FIELD_PREP(AD7768_REG_ANALOG2_VCM_MSK, x)  
> 
> Should we enforce macro argument evaluation here?
> #define AD7768_REG_ANALOG2_VCM(x)	FIELD_PREP(AD7768_REG_ANALOG2_VCM_MSK, (x))
> 
Yes.  Seems there is another case above as well that needs fixing up.

> > +
> >  #define AD7768_RD_FLAG_MSK(x)		(BIT(6) | ((x) & 0x3F))
> >  #define AD7768_WR_FLAG_MSK(x)		((x) & 0x3F)
> >  


