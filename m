Return-Path: <linux-iio+bounces-23220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEB8B33E89
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0FA164DD2
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C122E7F16;
	Mon, 25 Aug 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCuoi/2x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEBA220F5C;
	Mon, 25 Aug 2025 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123059; cv=none; b=sBlUkhKRQxqF9zKsUQBD59Xz+iCSy//PZrZSZkj3Tmw3Ir01dFqdwqaD/BXX/u08DyIRUlFQ0GheA5DDKk075LtsuouDOEuMklG7DoLTSc9tNp01PfVVm7zU+TEF7crNqOPVp5SGQfQ7w+jUpxhxrD6CdCRjz50dcoKHZMDuwEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123059; c=relaxed/simple;
	bh=u2aZrMHjp5VNoFtmPYT/Q13ILrdcSo4FSZG4TtJl/mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqHR4+NWI/TQ4SkZgVL36N+UPoU1j1GrwzVwgcxc4FoExvQxX3xDVkG4PzRNsiN5pmcBMWOmMmSlrvJPjmExtJPpMXIO2kc0KZauA24qXRr7hZ73RAhpxl2JDPVAfw6pzr3Tr1fHzh/sL1srynP1ajgDNnEjXD2rSdBkP+++Kag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCuoi/2x; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756123057; x=1787659057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u2aZrMHjp5VNoFtmPYT/Q13ILrdcSo4FSZG4TtJl/mU=;
  b=GCuoi/2xqcWJNHEWuT365QuUw1DYy8VlxyTdgrhea24GfHgILpwlYt9s
   4IKqI5PHbkwxL4ZRdPbfsVtfbmsyYoCiIcACr/vFfMY+OIjPolwZocOw+
   qa5jx4y9s2sYlAqJ1SGYkWybMN2E+EuCBaJP+SSrUdLpt/V9B7+nV3uWk
   Irs+FushW+V4f/Zh0wFdK+8folHlPqVgMsrhAcik5oAyekevS6tRmLMhf
   Hu7DXQmVqbySG6rto/dTtFT947Zt73IMOC50gZp5TiL3v9albIvjfiqKa
   gUi9gHHR4fGtaMnTz2D41U041YwKb2Qc8xroaIw26LsJRTC9+Ug8+Eix3
   A==;
X-CSE-ConnectionGUID: ZlDcDwNHT/+pm6glYM58IA==
X-CSE-MsgGUID: /2RC3fZ9QQupxAOQseY2tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="58479713"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58479713"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 04:57:36 -0700
X-CSE-ConnectionGUID: hdTgoxMQSJ63eWNqPKthrA==
X-CSE-MsgGUID: +r8EtaYQTHi9Cnk+LVEvvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169178170"
Received: from vpanait-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.7])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 04:57:27 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id F1E361203CE;
	Mon, 25 Aug 2025 14:57:23 +0300 (EEST)
Date: Mon, 25 Aug 2025 14:57:23 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Haibo Chen <haibo.chen@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Julien Stephan <jstephan@baylibre.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 02/12] iio: adc: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <aKxPo3Kg0ppOcczG@kekkonen.localdomain>
References: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
 <20250708231152.971398-1-sakari.ailus@linux.intel.com>
 <20250709163756.32b0e1d1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709163756.32b0e1d1@jic23-huawei>

Hi Jonathan,

Thanks for the review.

On Wed, Jul 09, 2025 at 04:37:56PM +0100, Jonathan Cameron wrote:
> On Wed,  9 Jul 2025 02:11:52 +0300
> Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> 
> > pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> > pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> > to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> > pm_runtime_mark_last_busy().
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Some comments for the future as more about what can be improved on the back
> of this than what you have here.
> 
> >
> > diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
> > index cc326f21d398..3a17b3898bf6 100644
> > --- a/drivers/iio/adc/rcar-gyroadc.c
> > +++ b/drivers/iio/adc/rcar-gyroadc.c
> > @@ -163,12 +163,10 @@ static int rcar_gyroadc_set_power(struct rcar_gyroadc *priv, bool on)
> >  {
> >  	struct device *dev = priv->dev;
> >  
> This is a very clear example of where the *_set_power() pattern is a bad idea.
> There are two calls of this function, one with it hard coded as on and one with it
> hard coded as off.  We can just push the pm_runtime_resume_and_get()
> to the on case etc.
> 
> I don't mind that much if we do so as a follow up patch so this one can
> be the mechanical change and then we follow up with the enabled simplification.

Ack. I presume this pattern is due to one driver having used it first and
then other drivers copying that. I haven't seen it elsewhere, or at least
not being used as widely.

> 
> > -	if (on) {
> > +	if (on)
> >  		return pm_runtime_resume_and_get(dev);
> > -	} else {
> > -		pm_runtime_mark_last_busy(dev);
> > -		return pm_runtime_put_autosuspend(dev);
> > -	}
> > +
> > +	return pm_runtime_put_autosuspend(dev);
> >  }
> >  
> >  static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
> >> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> > index 48549d617e5f..f2a93c63ca14 100644
> > --- a/drivers/iio/adc/ti-ads1015.c
> > +++ b/drivers/iio/adc/ti-ads1015.c
> > @@ -374,12 +374,10 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
> >  	int ret;
> >  	struct device *dev = regmap_get_device(data->regmap);
> >  
> > -	if (on) {
> > +	if (on)
> >  		ret = pm_runtime_resume_and_get(dev);
> > -	} else {
> > -		pm_runtime_mark_last_busy(dev);
> > +	else
> >  		ret = pm_runtime_put_autosuspend(dev);
> > -	}
> >  
> >  	return ret < 0 ? ret : 0;
> So this one has a stub version which only brings benefits because
> we have checks on the pm_runtime_put_autosuspend() path failing
> (which it does if we have !CONFIG_PM).
> 
> I think the right option there is check the return value is < 0
> for the resume_and_get() and don't check the _put_autosuspend()
> return value at all.  Then we can just push this down to the
> call sites as all of them hard code the bool value.

Ack.

-- 
Regards,

Sakari Ailus

