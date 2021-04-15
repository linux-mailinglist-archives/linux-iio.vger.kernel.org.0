Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AE536013D
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 06:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhDOE6s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 00:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhDOE6r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 00:58:47 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7C5C061574;
        Wed, 14 Apr 2021 21:58:20 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b26so10113637pfr.3;
        Wed, 14 Apr 2021 21:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SKRLPo3oVdZsOtlFDjKnXNMAzM66ox1FZB40ACHkvdI=;
        b=B4QuludhGPzK9ikzYeG2n3wg22LrWFFJVrjrhfX7khpWK1l1IIzv7MbTZZvtSqN3Pk
         6Rvcbfn2+UCBk6X7E2W14RF2LJQ1oUPCPLV01mpLSMCYJGDrt3piqx399H72IY07fQY8
         aW7aNfD9h1yMK4wIi21j1PMYKUFYL2Ae2lAmaiW9dJsBZyevW/y8+QZp09WKtd7TcwYj
         Y2m91TJZuAo/xkoZX0N+QXSWpg7FWZd2IlYTlJF2x0fZd9r52jU9FKCYO97U9E1UN10B
         REo+NHTxGj4clCcvlIEtSM9N4S3PZt5+vKTwZfqC7u11vSs4ttt2hfWbCt04gAJXUJxE
         4tJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SKRLPo3oVdZsOtlFDjKnXNMAzM66ox1FZB40ACHkvdI=;
        b=XrE5eiqx+Z4N76ELKFP6Rgr5tDJ5oUzx7yYsErbAeMmEITqMmMCvFLL5IQVrXdDUho
         l9YNysz/+UMP3uAwtysKTaBrbF+/qDk6g3ThpFRPczVm6IrtcOJpLPJDkwUKMuSdzLb9
         KmLjVYOw5CRFEq7aoMhVA9Ocr5KHmJrWxVOXLil0NECvupS5NuAoJKBqt5AwAwSmwaV9
         n6ow6KgRreHqgOrhBE1/hoy9vvUGzu05f65hqZXcBq6wdm1mKIfIrVchdeCNatK0TZao
         30jcAd3XLSZUAAm7UQQkAcoq0emjcRUIFijmJIugU+xo0sme1KF6Tapi8D1e9Jczz56t
         TNNw==
X-Gm-Message-State: AOAM531qVNkSXX4kP2Fg+AG0hrG4SgeEKycZwELNb3CO7I8iYZSnLSv1
        /FB+Fl1TxkS7eYVUYuKnhtE=
X-Google-Smtp-Source: ABdhPJxVSLffqST+4s1DOHpT7YcPVdZC/l4DSUdAHaafrSXNzkCOBmF1JZHrmZxj+9317ZYcDVl1ag==
X-Received: by 2002:a65:43c9:: with SMTP id n9mr1774047pgp.19.1618462700288;
        Wed, 14 Apr 2021 21:58:20 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4d7e:4d10:d9a7:9fa4])
        by smtp.gmail.com with ESMTPSA id g14sm837029pjh.28.2021.04.14.21.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 21:58:19 -0700 (PDT)
Date:   Wed, 14 Apr 2021 21:58:17 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [Ping for Dmitry] Re: [PATCH v5 3/3] iio: adc: add ADC driver
 for the TI TSC2046 controller
Message-ID: <YHfH6T5GpN63PNfH@google.com>
References: <20210329073131.1759-1-o.rempel@pengutronix.de>
 <20210329073131.1759-4-o.rempel@pengutronix.de>
 <20210329115826.03bc5745@jic23-huawei>
 <20210413093105.lbqe46srqvv7tj6s@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413093105.lbqe46srqvv7tj6s@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Oleksij, Jonathan,

On Tue, Apr 13, 2021 at 11:31:05AM +0200, Oleksij Rempel wrote:
> Hi Dmitry,
> 
> probably this mail passed under your radar. Can you please add your
> statement here.

Sorry, my bad, I saw "iio" and thought there is nothing for me to
comment on ;)

> 
> On Mon, Mar 29, 2021 at 11:58:26AM +0100, Jonathan Cameron wrote:
> > On Mon, 29 Mar 2021 09:31:31 +0200
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > 
> > > Basically the TI TSC2046 touchscreen controller is 8 channel ADC optimized for
> > > the touchscreen use case. By implementing it as an IIO ADC device, we can
> > > make use of resistive-adc-touch and iio-hwmon drivers.
> > > 
> > > Polled readings are currently not implemented to keep this patch small, so
> > > iio-hwmon will not work out of the box for now.
> > > 
> > > So far, this driver was tested with a custom version of resistive-adc-touch driver,
> > > since it needs to be extended to make use of Z1 and Z2 channels. The X/Y
> > > are working without additional changes.
> > > 
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Hi Oleksij,
> > 
> > Couple of things in here I missed before, but big question is still whether
> > Dmitry is happy with what you mention in the cover letter:
> > 
> > "This driver can replace drivers/input/touchscreen/ads7846.c and has
> > following advantages over it:
> > - less code to maintain
> > - shared code paths (resistive-adc-touch, iio-hwmon, etc)
> > - can be used as plain IIO ADC to investigate signaling issues or test
> >   real capacity of the plates and attached low-pass filters
> >   (or use the touchscreen as a microphone if you like ;) )"

I am all for code unification and reuse, so please go ahead. If there
are regressions we can re-evaluate and see if they can be addressed in
this driver or if we need to resurrect ads7846.

Thanks.

-- 
Dmitry
