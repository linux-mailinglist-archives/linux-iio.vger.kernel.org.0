Return-Path: <linux-iio+bounces-20976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9462AEA578
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 20:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D162D1C43790
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 18:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F137201278;
	Thu, 26 Jun 2025 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daOF0gNg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0120FABC
	for <linux-iio@vger.kernel.org>; Thu, 26 Jun 2025 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962955; cv=none; b=WKApJcctQL/fQFGeI/c5F/yziFfXX5ZKXxE3sCM0EfA3qYPdFC0keP+44G1LN5ZEcy1nslYfCFHHEYkl8piV74oqW++Zu+T3471ONXir3v51l1jZX4x+ubBw4J9wkhdcUidn17Jae66HH52Dk9ekqEzsNI/jrInYv2MlUQ65lp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962955; c=relaxed/simple;
	bh=mmdI8GK0E6kDYd3PSgw+JlKtLQKlwS1OiTOWv20xT6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrm1SgNtUm3bI1NDOFUxACQ6FEKnsTc7Zbarqf3axU0Ip3gsK+x4hJFRt6dBiGDu6KcT4C2yXPU41jT7twoJnjfJDCSm6luc625UO10ZiISxwDAoQ4QNME1FRJr9Rv/CD6snX6GTguJLre2WCYrnPZs5MB5Bgy/aJpcKoC3O8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daOF0gNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBE2C4CEEB;
	Thu, 26 Jun 2025 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750962955;
	bh=mmdI8GK0E6kDYd3PSgw+JlKtLQKlwS1OiTOWv20xT6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=daOF0gNgl6iK7HlZFDf837ZlFdWTzzYnXrvbR15QchDxwKbXGTGmP/eSXo3b2MfSB
	 ZO346QvZsuGFCKUg/HlciT+aMy9q6xzLfl1GKfW2uIPcV6o2F8B/NsKS7zha8joWcZ
	 t76xJbLn7NzsO0dqWl6PgqUb/FpMR50qe+zoUshMnZA/N5zcdWEPZsGT0m27nognVJ
	 cHHMv7Qul8lAbhklPbOjHx8+gBZw8njfKFtwKQrMB57D0BhcLcMyIj2Ci2iTqAMmYF
	 mZO5yd3IdhtfZgr+LQwfylfjrp8mVOLaFtPh/8L086Mv9fKnGig3KHn/sCG51Rkkws
	 08/XCaA+/L8GQ==
Date: Thu, 26 Jun 2025 19:35:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com>
Cc: linux-iio@vger.kernel.org, Cesar Bispo <cesar.bispo@ime.usp.br>
Subject: Re: [PATCH v4] iio: adc: Modernize single regulator call
Message-ID: <20250626193549.74b7b197@jic23-huawei>
In-Reply-To: <20250607163353.47e83e77@jic23-huawei>
References: <20250607011846.50362-1-gabrielfsouza.araujo@gmail.com>
	<20250607163353.47e83e77@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Jun 2025 16:33:53 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri,  6 Jun 2025 22:15:22 -0300
> Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com> wrote:
> 
> > Replace a single instance of legacy regulator with devm_regulator_get_enable().
> > This change improves code clarity and aligns with modern kernel APIs.  
> I made one final change whilst applying which was to include the driver name in the patch title.
> 
> Applied but I'll be rebasing my tree on rc1 once available so for now it will only go out
> as testing.
> 
> Ideally follow up with a patch to use devm_iio_device_register() and get rid of the remove()
> callback entirely.
> 
> > 
> > Signed-off-by: Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com>
> > Co-developed-by: Cesar Bispo <cesar.bispo@ime.usp.br>
> > Signed-off-by: Cesar Bispo <cesar.bispo@ime.usp.br>

After looking again via your other patch I notice this is wrong and I've dropped it for
now.  Look again at what devm_ does and consider the remove() callback for this function.

If you want to continue please send a little series with both patches in it that resolves
the problem (hint drop the regulator_disable in remove() as it will be disabled by the
devm_ at the right point in the remove sequence.

Thanks,

Jonathan

> > ---
> > The first version [1] did not compile due to incorrect use of pointers and improper
> > parameterization of the devm_regulator_get_enable() function. 
> > These issues have been fixed, and the code now compiles successfully.
> > Additionally, version two [2] had an incomplete patch, which has also 
> > been addressed in this version. In version three [3], dev_err_probe() is used for improved error handling.
> > 
> > [1] https://lore.kernel.org/linux-iio/20250429160526.5934-1-cesar.bispo@ime.usp.br/
> > [2] https://lore.kernel.org/linux-iio/20250514185239.10078-1-gabrielfsouza.araujo@gmail.com/
> > [3] https://lore.kernel.org/linux-iio/20250521185807.139828-1-gabrielfsouza.araujo@gmail.com/
> > 
> >  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 17 ++++-------------
> >  1 file changed, 4 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> > index 31f88cf7f7f1..ab1ed79f9f39 100644
> > --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> > +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> > @@ -911,21 +911,15 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
> >  	adc->map = map;
> >  
> >  	/* Bring up regulator */
> > -	adc->vref = devm_regulator_get(dev, "xoadc-ref");
> > -	if (IS_ERR(adc->vref))
> > -		return dev_err_probe(dev, PTR_ERR(adc->vref),
> > -				     "failed to get XOADC VREF regulator\n");
> > -	ret = regulator_enable(adc->vref);
> > +	ret = devm_regulator_get_enable(dev, "xoadc-ref");
> >  	if (ret) {
> > -		dev_err(dev, "failed to enable XOADC VREF regulator\n");
> > -		return ret;
> > +		return dev_err_probe(dev, ret, "failed to enable XOADC VREF regulator\n");
> >  	}
> >  
> >  	ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0),
> >  			pm8xxx_eoc_irq, NULL, 0, variant->name, indio_dev);
> >  	if (ret) {
> > -		dev_err(dev, "unable to request IRQ\n");
> > -		goto out_disable_vref;
> > +		return dev_err_probe(dev, ret, "unable to request IRQ\n");
> >  	}
> >  
> >  	indio_dev->name = variant->name;
> > @@ -936,7 +930,7 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
> >  
> >  	ret = iio_device_register(indio_dev);
> >  	if (ret)
> > -		goto out_disable_vref;
> > +		return ret;
> >  
> >  	ret = pm8xxx_calibrate_device(adc);
> >  	if (ret)
> > @@ -948,9 +942,6 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
> >  
> >  out_unreg_device:
> >  	iio_device_unregister(indio_dev);
> > -out_disable_vref:
> > -	regulator_disable(adc->vref);
> > -
> >  	return ret;
> >  }
> >    
> 
> 


