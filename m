Return-Path: <linux-iio+bounces-13033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 874869E2A66
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 19:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1186C166AC2
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 18:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82791FC10C;
	Tue,  3 Dec 2024 18:07:40 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A31E868;
	Tue,  3 Dec 2024 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249260; cv=none; b=rfYZZk+CgQLa6ars5mZW9yoS+TrIqkeWV9IKsXWHXst1qfl5WU+36DWYFQ3Rq5j8dmNDZAM/yuzmuZN5NRiKCAr0jBKUZJdlb7Y3+9aejoPArk+8GdKKWkmQL+drmBgQeambvgbsGeRTYk1mcxvmoZsvpVuBnKmGBb4G7XWmRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249260; c=relaxed/simple;
	bh=dqztknOIkm8ntS9wy+GQNN8ohu1VudzQqaeaZ2cvWb4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/nkJ0re27qWWXI8a3nA+wfSjtn3tZ1H7D07A0Xerp94J6nPisPT4YsiJ4ABAJY3I4t0lyC5KBFcBNK9q75c9nLIjCPyXCNtIFzaMtv2kZQQI1TAPXQE98Uh7O869qHDCjz0w1ZFZP7drIsDjTckoLxRYKYm7dw0AqD4C1EXfFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y2pR80KFJz6K6XW;
	Wed,  4 Dec 2024 02:03:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D7E5F140B63;
	Wed,  4 Dec 2024 02:07:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Dec
 2024 19:07:12 +0100
Date: Tue, 3 Dec 2024 18:07:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
CC: Claudiu <claudiu.beznea@tuxon.dev>,
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, <jic23@kernel.org>,
	<lars@metafoo.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <geert+renesas@glider.be>, <magnus.damm@gmail.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<linux-iio@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 06/14] iio: adc: rzg2l_adc: Simplify the locking scheme
 in rzg2l_adc_read_raw()
Message-ID: <20241203180710.0000204d@huawei.com>
In-Reply-To: <6f627195-6c55-4687-b6b6-7fb791d13819@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
	<20241203111314.2420473-7-claudiu.beznea.uj@bp.renesas.com>
	<6f627195-6c55-4687-b6b6-7fb791d13819@bp.renesas.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 3 Dec 2024 13:03:29 +0000
Paul Barker <paul.barker.ct@bp.renesas.com> wrote:

> Hi Claudiu,
> 
> On 03/12/2024 11:13, Claudiu wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > 
> > Simplify the locking scheme in rzg2l_adc_read_raw() by saving the converted
> > value only if the rzg2l_adc_conversion() returns success. The approach
> > simplifies the addition of thermal sensor support (that will be done in the
> > next commits). The downside is that the ret variable need to be checked
> > twice.
> > 
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > ---
> >  drivers/iio/adc/rzg2l_adc.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> > index 62932f9295b6..eed2944bd98d 100644
> > --- a/drivers/iio/adc/rzg2l_adc.c
> > +++ b/drivers/iio/adc/rzg2l_adc.c
> > @@ -227,14 +227,11 @@ static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
> >  		mutex_lock(&adc->lock);
> >  		ch = chan->channel & RZG2L_ADC_CHN_MASK;
> >  		ret = rzg2l_adc_conversion(indio_dev, adc, ch);
> > -		if (ret) {
> > -			mutex_unlock(&adc->lock);
> > -			return ret;
> > -		}
> > -		*val = adc->last_val[ch];
> > +		if (!ret)
> > +			*val = adc->last_val[ch];
> >  		mutex_unlock(&adc->lock);
> >  
> > -		return IIO_VAL_INT;
> > +		return ret ? ret : IIO_VAL_INT;  
> 
> It would be maybe slightly neater to use:
> 
> 	if (!ret) {
> 		*val = adc->last_val[ch];
> 		ret = IIO_VAL_INT;
> 	}
> 	mutex_unlock(&adc->lock);
> 
> 	return ret;
> 
Better I think to use {} for scope and
guard(mutex)()
...
if (ret)
	return ret;

*val = adc->last_val[ch];

Where possible keeping the error path as the out of line element is
easier to follow on basis that is most common pattern so what a reviewers
eye is 'trained' to see.

Jonathan

> Thanks,
> 


