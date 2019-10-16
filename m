Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C584D8BA6
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2019 10:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfJPIsC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Oct 2019 04:48:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42827 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfJPIsC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2019 04:48:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id f14so8758043pgi.9
        for <linux-iio@vger.kernel.org>; Wed, 16 Oct 2019 01:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0lJcF2qqemmKV9yipbEKYMvFxvnwhy8C+zT+65RH72A=;
        b=hOVbPtBw+b0kgTWSqlZB69BUW0RaVlT/enZSJKk/l6GX0BPGS7sgcuin03OVxIzdV7
         nabZMuR6zNmE8I9ohRk19nXPXeJXTorsqSi8Rxqm+PsFabzumNSHk38hKvV5Im9tyeWJ
         R0R5e3+vBMAf7mZ8GnW/XVGlu/4Bu9r8AxpJ4AJCJjrpr4QOPEfoKDEkGPChJ9icWdbn
         Cc74f3e01zmZEtpS4frg5WOcA2w5RT9aydC8ZCPGaC21e4CNhPUQ1L4tXl877U3/cHh/
         DnXlLDfH1p6kCI+WbtE9aHQPKk6VyggmdHPD6F6k5kxVb+F0r1nShN7O9tfPEcq/Xbjm
         wn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0lJcF2qqemmKV9yipbEKYMvFxvnwhy8C+zT+65RH72A=;
        b=HYll/z57WNEKzZT5kRuYgyN+FaNlcfJru14ViByHl5RR3D4jOrhEoZrurseJwfpSWm
         x1cFxLTQUmhIxGtB6MybzivAolz2/qSUoQX4WVwUlZq76L4mQIcXKZmKkOkEYurGVvLK
         /4LGbm9sehcjpZSOk0US21xl6Dnh40BKIDqqDDsH85Qq1lOYECHuW/W4SBgk2wvqJUcz
         lhNfUnEoKfSvOAFcfka/q2lLuDfa+MUaqyPz2YAJYfddyRCnl6OThwhBU1ZqS4Yiovtt
         7whsXN6SoUiQt4jZJO5+juNa120A5wx4SvXKIwdzsxrg3eN+DnfGkir+at7oo0QR+Efd
         KY5g==
X-Gm-Message-State: APjAAAW7Y0hGeItE+adxrJ/3cuA52RSs4YJhJ0ujF8qzOp5yG7RZEUCR
        zruLu5kckGEF6CwcQLiZMt1L
X-Google-Smtp-Source: APXvYqz6D6eMHxfsEjx8Idf1IzLVhlk+DgNzWF7y3oPhuQcRbOxVslGyLxvB+KUzZSs5VgWpE6EIMw==
X-Received: by 2002:a65:4844:: with SMTP id i4mr3654896pgs.389.1571215681124;
        Wed, 16 Oct 2019 01:48:01 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6099:7d36:58bc:3eb9:a64a:7942])
        by smtp.gmail.com with ESMTPSA id x9sm3809364pje.27.2019.10.16.01.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 01:48:00 -0700 (PDT)
Date:   Wed, 16 Oct 2019 14:17:56 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: light: adux1020: Drop an unwanted semicolon.
Message-ID: <20191016084756.GC2288@Mani-XPS-13-9360>
References: <20191013173852.2265620-1-jic23@kernel.org>
 <20191015211215.1c78c8a5@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015211215.1c78c8a5@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Tue, Oct 15, 2019 at 09:12:15PM +0100, Jonathan Cameron wrote:
> On Sun, 13 Oct 2019 18:38:52 +0100
> jic23@kernel.org wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Suggested by coccinelle
> > 
> > CHECK   drivers/iio/light/adux1020.c
> > drivers/iio/light/adux1020.c:747:2-3: Unneeded semicolon
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 0-day sent me the same patch as well.
> 
> I've rolled it into the original code as that was still on 
> testing only which was getting rebased anyway.
>

Makes sense!

Thanks,
Mani
 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/light/adux1020.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
> > index 830e5e95d58f..b07797ac10d7 100644
> > --- a/drivers/iio/light/adux1020.c
> > +++ b/drivers/iio/light/adux1020.c
> > @@ -744,7 +744,7 @@ static int adux1020_chip_init(struct adux1020_data *data)
> >  	if ((val & ADUX1020_CHIP_ID_MASK) != ADUX1020_CHIP_ID) {
> >  		dev_err(&client->dev, "invalid chip id 0x%04x\n", val);
> >  		return -ENODEV;
> > -	};
> > +	}
> >  
> >  	dev_dbg(&client->dev, "Detected ADUX1020 with chip id: 0x%04x\n", val);
> >  
> 
