Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355643C9EF9
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 14:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhGOMzi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 08:55:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3415 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhGOMzi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jul 2021 08:55:38 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GQYs670FPz6L8SL;
        Thu, 15 Jul 2021 20:41:30 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 14:52:42 +0200
Received: from localhost (10.47.82.59) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 15 Jul
 2021 13:52:41 +0100
Date:   Thu, 15 Jul 2021 13:52:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Anand Ashok Dumbre <ANANDASH@xilinx.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git-dev <git-dev@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Manish Narani <MNARANI@xilinx.com>
Subject: Re: [PATCH v6 2/4] iio: adc: Add Xilinx AMS driver
Message-ID: <20210715135221.00001d4f@Huawei.com>
In-Reply-To: <BY5PR02MB69165A85F14243048187870BA9129@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20210624182939.12881-1-anand.ashok.dumbre@xilinx.com>
        <20210624182939.12881-3-anand.ashok.dumbre@xilinx.com>
        <20210704193108.20e19692@jic23-huawei>
        <BY5PR02MB69165A85F14243048187870BA9129@BY5PR02MB6916.namprd02.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.59]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

...

> >   
> > > +	if (IS_ERR(ams->base))
> > > +		return PTR_ERR(ams->base);
> > > +
> > > +	ams->clk = devm_clk_get(&pdev->dev, NULL);
> > > +	if (IS_ERR(ams->clk))
> > > +		return PTR_ERR(ams->clk);
> > > +	clk_prepare_enable(ams->clk);
> > > +	devm_add_action_or_reset(&pdev->dev, (void  
> > *)clk_disable_unprepare,  
> > > +				 ams->clk);
> > > +
> > > +	INIT_DELAYED_WORK(&ams->ams_unmask_work,  
> > ams_unmask_worker);  
> > > +	devm_add_action_or_reset(&pdev->dev, (void  
> > *)cancel_delayed_work,
> > 
> > I'm not keen on casting away the function pointer type.  Normally we'd just
> > wrap it in a local function, to make it clear it was deliberate and avoid
> > potential nasty problems if the signature of the function ever changes.
> > 
> > It's 3 lines of boilerplate, but will give me warm fuzzy feelings!
> > Same for the other case above.  The fact this isn't done in exising kernel code
> > make this particularly risky.  
> 
> Makes sense. I will revert the code back to its original and handle the cases using goto
> and inside remove()
Ah.  Not what I meant.  I was suggesting you add a little function locally
that has the right type and in turn calls cancel_delayed_work().

As that directly exposes the actual function calls, any signature change in future
will cause compile breakage (or be picked up any automated tools doing that refactor).

> 
> >   
> > > +				 &ams->ams_unmask_work);
> > > +
> > > +	ret = ams_init_device(ams);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "failed to initialize AMS\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = ams_parse_dt(indio_dev, pdev);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "failure in parsing DT\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ams_enable_channel_sequence(indio_dev);
> > > +
> > > +	ams->irq = platform_get_irq(pdev, 0);  
> > 
> > platform_get_irq () can return errors, in particular -EPROBE_DEFER so I'd
> > check that and return before you call devm_request_irq() I'm not sure
> > devm_request_irq() will not eat that error code.
> >   
> 
> Will fix this in next series.
> 
> >   
> > > +	ret = devm_request_irq(&pdev->dev, ams->irq, &ams_irq, 0, "ams-  
> > irq",  
> > > +			       indio_dev);
> > > +	if (ret < 0) {
> > > +		dev_err(&pdev->dev, "failed to register interrupt\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	platform_set_drvdata(pdev, indio_dev);
> > > +
> > > +	return iio_device_register(indio_dev); }
> > > +
> > > +static int ams_remove(struct platform_device *pdev) {
> > > +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > > +
> > > +	iio_device_unregister(indio_dev);  
> > 
> > If this is all you have in remove, then you can use devm_iio_device_register()
> > in probe() and not need an remove() callback at all.  
> 
> I think remove will have more functions since I am getting rid of devm_add_action_or_reset()

See above.

J

> 
> >   
> > > +
> > > +	return 0;
> > > +}
> > > +  
> > 
> > ...  

