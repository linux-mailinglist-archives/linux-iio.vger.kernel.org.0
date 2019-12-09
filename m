Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F820117427
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2019 19:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfLIS10 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Dec 2019 13:27:26 -0500
Received: from sender4-op-o18.zoho.com ([136.143.188.18]:17863 "EHLO
        sender4-op-o18.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLIS10 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Dec 2019 13:27:26 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575916033; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Uqeax3GWXw+lN2aiuuJ2WAdj6XJgf83shDkh4o75FqkeAl5csykPMHKyW4TQgimjl7U/UDhVIoUSh4vziZCAakMLOIYaF0zvEpDrlgJDyKMdpbVvsvDRYXVGyTNBr9NHYrPtnoNCCLelDAQvT5W7l89MYQdTzvP1nSfu2R9JMJg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1575916033; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=qST48LGbEeti0hVqrKe4JVhTVDhvY4DFmAgNm3h8veo=; 
        b=E9VH1LQn7SoUzRt1ikBlGnECa3C35ZQVKcifJtkVMROrNZO1tS7iu2OcZS2NBXd+AMClI7pBPvL1ZmX/z8iZmu4r8HfBJHjxKc6/xJUy6uq8qlBEgFBNzoilmDcVVRtcmIGSxIFjD8agU+C8AOFZxqv4IE1x/hnnqDMcyFQynAw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1575916032260346.62116454289855; Mon, 9 Dec 2019 10:27:12 -0800 (PST)
Date:   Mon, 9 Dec 2019 18:11:53 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v5 2/2] iio: (bma400) add driver for the BMA400
Message-ID: <20191209181153.GA13304@nessie>
References: <20191209014320.13149-1-dan@dlrobertson.com>
 <20191209014320.13149-3-dan@dlrobertson.com>
 <cf3f2297-dc01-b2c9-657b-933f24b15594@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf3f2297-dc01-b2c9-657b-933f24b15594@infradead.org>
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 08, 2019 at 06:54:44PM -0800, Randy Dunlap wrote:
> On 12/8/19 5:43 PM, Dan Robertson wrote:
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index d4ef35aeb579..dc9bc646d403 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -112,6 +112,22 @@ config BMA220
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called bma220_spi.
> >  
> > +config BMA400
> > +	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
> > +	select REGMAP
> > +	select BMA400_I2C if (I2C)
> 
> What's with the parentheses?  I see that there are roughly 2700
> "select ... if X" without parens and around 95 like
> "select ... if ("  [using rough grep expressions].
> The parens are unnecessary.  They are often used on complex
> expressions, but certainly not on simple ones (except in iio).

Good point. I'll remove it. I'll need the parentheses if/when SPI support is
added, but I'll add it when it is needed.

> > +	help
> > +	  Say Y here if you want to build a driver for the Bosch BMA400
> > +	  triaxial acceleration sensor.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called bma400_core and you will also get
> > +	  bma400_i2c for I2C.
> 
> iff I2C is set/enabled, so could be confusing.

Good catch.

Cheers,

 - Dan

