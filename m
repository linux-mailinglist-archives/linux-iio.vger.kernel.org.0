Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DFF6C02BD
	for <lists+linux-iio@lfdr.de>; Sun, 19 Mar 2023 16:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjCSPVg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Mar 2023 11:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCSPVe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2023 11:21:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1491BAFF
        for <linux-iio@vger.kernel.org>; Sun, 19 Mar 2023 08:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3AF7B80B9D
        for <linux-iio@vger.kernel.org>; Sun, 19 Mar 2023 15:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6ECC433D2;
        Sun, 19 Mar 2023 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679239286;
        bh=YwPBBz+8/sesUBpkrkwQBru5iOtj0gcgbawFBiC7HxQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=phtKcdf1qcdukFiQAbTlQe8v1RgeBOFN4lWPxjfO0hKr2QHfXlAQzwcsls/Yw9zII
         t/7Votai0xWS2OjTgR9U7A0hudKhwW88tQ9nNfpcrH5Es2SHjHKZuXMeQ6Qy/rvKPe
         yRwW6ndHpddM/YwZ/SW7qx5/tXwqqVle14yustDhc5VKYA1KszWdP6OOkoaGrloC+v
         szwUPriLvOTDH0yiuprFceUAjcgoseapifEQb3nLqtVH4Dx9RDfuXDD/WLEqYVX2lN
         tm0uHadb30TBigOs21YdUdFljVMkqlLntX6r+donpP3a0HQgEMjii9fp8RqltoQeZP
         sfdBAs2KdpVvw==
Date:   Sun, 19 Mar 2023 15:36:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrik =?UTF-8?B?RGFobHN0csO2bQ==?= <risca@dalakolonin.se>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] iio: adc: palmas: Take probe fully device managed.
Message-ID: <20230319153621.5205ecf4@jic23-huawei>
In-Reply-To: <20230319142106.GA3806863@dalakolonin.se>
References: <20230318163039.56115-1-jic23@kernel.org>
        <20230319142106.GA3806863@dalakolonin.se>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 19 Mar 2023 15:21:06 +0100
Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:

> The changes look good and I've tested it on Omap5-uevm board:
> * module loads and unloads without issues
> * I'm able to read ADC values
> * the values change when I turn my potentiometer
>=20
> Feel free to add the relevant tags, e.g. Tested-by or Reviewed-by. I'm
> still new to the kernel development process.
Hi Patrik,

Both make sense here given your comments.  You tried it so Tested-by
and you said it looks good which is Reviewed-by

I failed to cc the original author of this driver though, so +CC HNS for th=
at
and this will have to wait for your fix to be available in upstream so it
will take a while.

If you are sending additional patches on top of this and your patch,
state that in the cover letter for those additional patches as I'll probably
forget otherwise and wonder why they don't apply.

Thanks

Jonathan


>=20
> On Sat, Mar 18, 2023 at 04:30:39PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Review of a recent fix highlighted that this driver could be trivially
> > converted to be entirely devm managed.
> >=20
> > That fix should be applied to resolve the fix in a fashion easy to back=
 port
> > even though this change removes the relevant code.
> >=20
> > [1] https://patchwork.kernel.org/project/linux-iio/patch/20230313205029=
.1881745-1-risca@dalakolonin.se/
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
> > ---
> >  drivers/iio/adc/palmas_gpadc.c | 110 +++++++++++++--------------------
> >  1 file changed, 42 insertions(+), 68 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gp=
adc.c
> > index 849a697a467e..2921186458e0 100644
> > --- a/drivers/iio/adc/palmas_gpadc.c
> > +++ b/drivers/iio/adc/palmas_gpadc.c
> > @@ -493,6 +493,11 @@ static int palmas_gpadc_get_adc_dt_data(struct pla=
tform_device *pdev,
> >  	return 0;
> >  }
> > =20
> > +static void palmas_disable_wakeup(void *dev)
> > +{
> > +	device_wakeup_disable(dev);
> > +}
> > +
> >  static int palmas_gpadc_probe(struct platform_device *pdev)
> >  {
> >  	struct palmas_gpadc *adc;
> > @@ -532,36 +537,30 @@ static int palmas_gpadc_probe(struct platform_dev=
ice *pdev)
> > =20
> >  	adc->auto_conversion_period =3D gpadc_pdata->auto_conversion_period_m=
s;
> >  	adc->irq =3D palmas_irq_get_virq(adc->palmas, PALMAS_GPADC_EOC_SW_IRQ=
);
> > -	if (adc->irq < 0) {
> > -		dev_err(adc->dev,
> > -			"get virq failed: %d\n", adc->irq);
> > -		ret =3D adc->irq;
> > -		goto out;
> > -	}
> > -	ret =3D request_threaded_irq(adc->irq, NULL,
> > -		palmas_gpadc_irq,
> > -		IRQF_ONESHOT, dev_name(adc->dev),
> > -		adc);
> > -	if (ret < 0) {
> > -		dev_err(adc->dev,
> > -			"request irq %d failed: %d\n", adc->irq, ret);
> > -		goto out;
> > -	}
> > +	if (adc->irq < 0)
> > +		return dev_err_probe(adc->dev, adc->irq, "get virq failed\n");
> > +
> > +	ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq, NULL,
> > +					palmas_gpadc_irq,
> > +					IRQF_ONESHOT, dev_name(adc->dev),
> > +					adc);
> > +	if (ret < 0)
> > +		return dev_err_probe(adc->dev, ret,
> > +				     "request irq %d failed\n", adc->irq);
> > =20
> >  	if (gpadc_pdata->adc_wakeup1_data) {
> >  		memcpy(&adc->wakeup1_data, gpadc_pdata->adc_wakeup1_data,
> >  			sizeof(adc->wakeup1_data));
> >  		adc->wakeup1_enable =3D true;
> >  		adc->irq_auto_0 =3D  platform_get_irq(pdev, 1);
> > -		ret =3D request_threaded_irq(adc->irq_auto_0, NULL,
> > -				palmas_gpadc_irq_auto,
> > -				IRQF_ONESHOT,
> > -				"palmas-adc-auto-0", adc);
> > -		if (ret < 0) {
> > -			dev_err(adc->dev, "request auto0 irq %d failed: %d\n",
> > -				adc->irq_auto_0, ret);
> > -			goto out_irq_free;
> > -		}
> > +		ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_0,
> > +						NULL, palmas_gpadc_irq_auto,
> > +						IRQF_ONESHOT,
> > +						"palmas-adc-auto-0", adc);
> > +		if (ret < 0)
> > +			return dev_err_probe(adc->dev, ret,
> > +					     "request auto0 irq %d failed\n",
> > +					     adc->irq_auto_0);
> >  	}
> > =20
> >  	if (gpadc_pdata->adc_wakeup2_data) {
> > @@ -569,15 +568,14 @@ static int palmas_gpadc_probe(struct platform_dev=
ice *pdev)
> >  				sizeof(adc->wakeup2_data));
> >  		adc->wakeup2_enable =3D true;
> >  		adc->irq_auto_1 =3D  platform_get_irq(pdev, 2);
> > -		ret =3D request_threaded_irq(adc->irq_auto_1, NULL,
> > -				palmas_gpadc_irq_auto,
> > -				IRQF_ONESHOT,
> > -				"palmas-adc-auto-1", adc);
> > -		if (ret < 0) {
> > -			dev_err(adc->dev, "request auto1 irq %d failed: %d\n",
> > -				adc->irq_auto_1, ret);
> > -			goto out_irq_auto0_free;
> > -		}
> > +		ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_1,
> > +						NULL, palmas_gpadc_irq_auto,
> > +						IRQF_ONESHOT,
> > +						"palmas-adc-auto-1", adc);
> > +		if (ret < 0)
> > +			return dev_err_probe(adc->dev, ret,
> > +					     "request auto1 irq %d failed\n",
> > +					     adc->irq_auto_1);
> >  	}
> > =20
> >  	/* set the current source 0 (value 0/5/15/20 uA =3D> 0..3) */
> > @@ -608,11 +606,10 @@ static int palmas_gpadc_probe(struct platform_dev=
ice *pdev)
> >  	indio_dev->channels =3D palmas_gpadc_iio_channel;
> >  	indio_dev->num_channels =3D ARRAY_SIZE(palmas_gpadc_iio_channel);
> > =20
> > -	ret =3D iio_device_register(indio_dev);
> > -	if (ret < 0) {
> > -		dev_err(adc->dev, "iio_device_register() failed: %d\n", ret);
> > -		goto out_irq_auto1_free;
> > -	}
> > +	ret =3D devm_iio_device_register(&pdev->dev, indio_dev);
> > +	if (ret < 0)
> > +		return dev_err_probe(adc->dev, ret,
> > +				     "iio_device_register() failed\n");
> > =20
> >  	device_set_wakeup_capable(&pdev->dev, 1);
> >  	for (i =3D 0; i < PALMAS_ADC_CH_MAX; i++) {
> > @@ -620,36 +617,14 @@ static int palmas_gpadc_probe(struct platform_dev=
ice *pdev)
> >  			palmas_gpadc_calibrate(adc, i);
> >  	}
> > =20
> > -	if (adc->wakeup1_enable || adc->wakeup2_enable)
> > +	if (adc->wakeup1_enable || adc->wakeup2_enable) {
> >  		device_wakeup_enable(&pdev->dev);
> > -
> > -	return 0;
> > -
> > -out_irq_auto1_free:
> > -	if (gpadc_pdata->adc_wakeup2_data)
> > -		free_irq(adc->irq_auto_1, adc);
> > -out_irq_auto0_free:
> > -	if (gpadc_pdata->adc_wakeup1_data)
> > -		free_irq(adc->irq_auto_0, adc);
> > -out_irq_free:
> > -	free_irq(adc->irq, adc);
> > -out:
> > -	return ret;
> > -}
> > -
> > -static int palmas_gpadc_remove(struct platform_device *pdev)
> > -{
> > -	struct iio_dev *indio_dev =3D dev_get_drvdata(&pdev->dev);
> > -	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> > -
> > -	if (adc->wakeup1_enable || adc->wakeup2_enable)
> > -		device_wakeup_disable(&pdev->dev);
> > -	iio_device_unregister(indio_dev);
> > -	free_irq(adc->irq, adc);
> > -	if (adc->wakeup1_enable)
> > -		free_irq(adc->irq_auto_0, adc);
> > -	if (adc->wakeup2_enable)
> > -		free_irq(adc->irq_auto_1, adc);
> > +		ret =3D devm_add_action_or_reset(&pdev->dev,
> > +					       palmas_disable_wakeup,
> > +					       &pdev->dev);
> > +		if (ret)
> > +			return ret;
> > +	}
> > =20
> >  	return 0;
> >  }
> > @@ -834,7 +809,6 @@ MODULE_DEVICE_TABLE(of, of_palmas_gpadc_match_tbl);
> > =20
> >  static struct platform_driver palmas_gpadc_driver =3D {
> >  	.probe =3D palmas_gpadc_probe,
> > -	.remove =3D palmas_gpadc_remove,
> >  	.driver =3D {
> >  		.name =3D MOD_NAME,
> >  		.pm =3D pm_sleep_ptr(&palmas_pm_ops),
> > --=20
> > 2.40.0
> >  =20

