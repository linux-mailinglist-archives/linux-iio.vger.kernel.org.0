Return-Path: <linux-iio+bounces-20836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63842AE2BEC
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 21:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0331C162F06
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 19:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A28C224893;
	Sat, 21 Jun 2025 19:55:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9BF7E1
	for <linux-iio@vger.kernel.org>; Sat, 21 Jun 2025 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535755; cv=none; b=pJfiqM9NNTr1V4k6Gb3CrMDspDdJSPmHPntrGpV/p/op0trGRKu8goTtRq+AifdtZP10WljWnjpMBDaFpJ8IaWuhCD8BuUc1HPm+XSnHqXbc31MJEsP4jchsngOGdY3Avo9FFReHScajGFf2xAqsl8F7NwyqPuM7xQYgIS7/Eag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535755; c=relaxed/simple;
	bh=XN9dgj8KZxF+ZFA7X5ypPmDNQHGVkzrlJsyw+f1Ohzs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlFxVWD4y6OzePVRS5N3oAl0mt2qYVJaRqNesHwW5l3aEpKS3d5xSRpMMUG7joF7y0AwCWODUXi3Tt5CjIx97q5tN1zpJGFGTugzA1EHzU+Cc5tc398Q2GHSiX8Ch3vYlodv5a2AzogmvyVcerh/vDMoJT//sBd5J7zlaiglXzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id b672fed3-4ed9-11f0-a5a7-005056bdf889;
	Sat, 21 Jun 2025 22:55:43 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 21 Jun 2025 22:55:42 +0300
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v9 07/11] iio: accel: adxl345: add activity event feature
Message-ID: <aFcOPky_EsatfsJu@surfacebook.localdomain>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
 <20250610215933.84795-8-l.rubusch@gmail.com>
 <aEq_SJMDzPYGSMu6@smile.fi.intel.com>
 <CAFXKEHbdeomMfEBwO+Cvkn5dkN4h47CEAMfmEGQC2V82zQ+U8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFXKEHbdeomMfEBwO+Cvkn5dkN4h47CEAMfmEGQC2V82zQ+U8Q@mail.gmail.com>

Sat, Jun 21, 2025 at 08:06:49PM +0200, Lothar Rubusch kirjoitti:

[...]

> > > +     ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &axis_ctrl);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     switch (type) {
> > > +     case ADXL345_ACTIVITY:
> > > +             en = FIELD_GET(ADXL345_ACT_X_EN, axis_ctrl) |
> > > +                     FIELD_GET(ADXL345_ACT_Y_EN, axis_ctrl) |
> > > +                     FIELD_GET(ADXL345_ACT_Z_EN, axis_ctrl);
> >
> > Something happened to the indentation.
> > Ditto for several places in the code (upper and lower from this).
> 
> What is the matter with the indention here? I'm doing `checkpatch.pl
> --strict --codespell` on that and don't get an issue? Would you expect
> cases like the FIELD_GET() calls on the next line, linked by a binary
> OR, to be indented by yet another TAB?

All 'F':s should be on the same column (since the email already mangled
[not by me], here is just an example).

             en = FIELD_GET(ADXL345_ACT_X_EN, axis_ctrl) |
                  FIELD_GET(ADXL345_ACT_Y_EN, axis_ctrl) |
                  FIELD_GET(ADXL345_ACT_Z_EN, axis_ctrl);

> > > +             break;
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     if (!en)
> > > +             return en;
> > > +
> > > +     /* Check if corresponding interrupts are enabled */
> > > +     ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     return adxl345_act_int_reg[type] & regval;
> > > +}

...

Really, cut the unrelated context in the replies!

-- 
With Best Regards,
Andy Shevchenko



