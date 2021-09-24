Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70714168DF
	for <lists+linux-iio@lfdr.de>; Fri, 24 Sep 2021 02:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhIXAWk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Sep 2021 20:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243599AbhIXAWj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Sep 2021 20:22:39 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEB3C061574
        for <linux-iio@vger.kernel.org>; Thu, 23 Sep 2021 17:21:07 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id t4so25973260qkb.9
        for <linux-iio@vger.kernel.org>; Thu, 23 Sep 2021 17:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mvUjOthNIPqlliLbrW/fgsF0mOumvANHQaHuVP2SV2g=;
        b=OGMqWVbpBOT2KYJn5X5lQAD+68sq6AsjswAWSHeVqq2L1mxeJFCoCOmAAUuOn3PhJl
         35mzMO6H5YhwCpIAvnAkJIxz+91tlK4aGejLeXeO13L4omelolyHWlcnnjMR7TGH1ky8
         Nz4fZ1SfF+4x6wxZM0G0lFjChO1fSl4kvzunzQUgYJnhjlzX7TzZnDeRAVQ2jZbGcn31
         +6nLoC7mzLlUs4G0SrfEbgibzysPTRbfQ5F0xumWnUu4qr9slGw2nJ8NmX1zvL0x3Tpu
         ZMHhDEHps7JmVY9cyYj+JaM0zAUaAJaYR3AqRaSGjy+QYPVKO0NHNAWBvH4QkR6Nn3EL
         1rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mvUjOthNIPqlliLbrW/fgsF0mOumvANHQaHuVP2SV2g=;
        b=kAbl9ErXdRWetD44cOnA+lcPbwsioJAS/NLoPYOt1rWgKdONzRnqrCl8gohdvImPZV
         rNXzdHjeDfeJkU4RQss0mUPKZ2cq/DKndBX8/kHpKEMyH+yVTdwZubgPnt37qC473VxQ
         AGLFbODjAFES6P8X5lj9Mo5XdwZH2U0AhaoIpKJtI1atE/Z9jm2IDt2t+AK2aDqur0Gl
         AgvhOOJ1wq0wYtAgw45GqnJmi8OWFjQkijU05Jhbj0OU6sdBGljOmx9QEGrIvey9XHV9
         IANx9PwCgOUXB6JsywL7pef1O18RH3e2OFeDff6SEEnr+3jDwALlbeYqGdnk5En5c2ko
         fBqA==
X-Gm-Message-State: AOAM533zM0+0eACDyZHdtj1yeZIwIFKVHXCzoBhHnXhCskUILnyrGOks
        /nnbccHZTbMYTD6WdVmdPgY=
X-Google-Smtp-Source: ABdhPJzppwQWM8Safneu9ZFpXjuToKzDfKiyTvdvTSrpS68z0p+F6A/bi8CX/tng+cFxMFDmllZxYw==
X-Received: by 2002:a37:a54c:: with SMTP id o73mr7952367qke.334.1632442864939;
        Thu, 23 Sep 2021 17:21:04 -0700 (PDT)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l1sm5576073qkj.65.2021.09.23.17.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 17:21:04 -0700 (PDT)
Date:   Thu, 23 Sep 2021 20:21:02 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     lvb@xiphos.com, linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: adc: ad7949: add vref selection support
Message-ID: <YU0Z7sMsu6i9YkYh@shaak>
References: <20210921063509.GA26209@kili>
 <YUq63O3ksdr9R3pE@shaak>
 <20210922060026.GW2116@kadam>
 <YUtCTZ2sV/h6+dZ9@shaak>
 <20210923054358.GX2116@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923054358.GX2116@kadam>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 23, 2021 at 08:47:52AM +0300, Dan Carpenter wrote:
> > > >  		if (ret != -ENODEV)
> > > >  			return ret;
> > > >  		/* unbuffered? */
> > > >  		ad7949_adc->vref = devm_regulator_get_optional(dev, "vref");
> > > >  		if (IS_ERR(ad7949_adc->vref)) {
> > > >  			ret = PTR_ERR(ad7949_adc->vref);
> > > > +			ad7949_adc->vref = NULL;
> > > 
> > > But this also won't work.  Passing a NULL to regulator_enable() will
> > > cause an Oops.  All the reference to ->vref need checks.  :/
> > 
> > I believe it still work since these conditions around
> > devm_regulator_get_optional() also set ad7949_adc->refsel.
> > 
> > ad7949_adc->refsel is then checked before calling regulator_enable() and
> > regulator_get_voltage().
> > 
> > Even without the patch, I don't think we can call regulor_enable()
> > without having it be defined. Am I missing something else?

Hi Dan,

> Actually, you're right.  This warning is a 100% false positive.  Smatch
> doesn't handle bit wise tests very well.  I've been meaning to write
> that code but I haven't done it yet.  When I do the false positive will
> go away.
> 
> Sorry for the noise on this.

No worries, thanks for your support on this.

> regards,
> dan carpenter

Liam
