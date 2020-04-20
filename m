Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4051B1098
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgDTPqM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 11:46:12 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2065 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729375AbgDTPqL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 11:46:11 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 3D904B99602CD4D5F992;
        Mon, 20 Apr 2020 16:46:09 +0100 (IST)
Received: from localhost (10.47.82.82) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 20 Apr
 2020 16:46:08 +0100
Date:   Mon, 20 Apr 2020 16:45:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 7/7] iio: light: vl6180: swap of.h for mod_devicetable.h
 and drop of_match_ptr
Message-ID: <20200420164557.00005648@Huawei.com>
In-Reply-To: <0d3e8e58e39060ce9a28f2bb3b1d0161f4ed36f1.camel@analog.com>
References: <20200419150206.43033-1-jic23@kernel.org>
        <20200419150206.43033-8-jic23@kernel.org>
        <0d3e8e58e39060ce9a28f2bb3b1d0161f4ed36f1.camel@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.82]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Apr 2020 06:19:17 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2020-04-19 at 16:02 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Enables probing via ACPI PRP0001 route and removes an example of
> > an approach we no longer want people to copy.
> >   
> 
> This doesn't include 'linux/mod_devicetable.h'.
> I'm wondering now if it is needed at all.
> Should we remove it from the rest?
> 
Oops.

So this is one of those classics.  mod_devicetable is included by the spi
and i2c headers but there is no actual 'need' for them to do so. The
could (I think) get away with an appropriate forwards definition.

This is in contrast to the drivers that need to know what that structure
looks like (as does the i2c core device tree code etc).

So should we include it or not?  I'm generally of the view that we should
for resilience but others favour minimal includes.

Jonathan


> With that addressed:
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/light/vl6180.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
> > index d9533a76b8f6..7e67d7b3bfb6 100644
> > --- a/drivers/iio/light/vl6180.c
> > +++ b/drivers/iio/light/vl6180.c
> > @@ -537,7 +537,7 @@ MODULE_DEVICE_TABLE(i2c, vl6180_id);
> >  static struct i2c_driver vl6180_driver = {
> >  	.driver = {
> >  		.name   = VL6180_DRV_NAME,
> > -		.of_match_table = of_match_ptr(vl6180_of_match),
> > +		.of_match_table = vl6180_of_match,
> >  	},
> >  	.probe  = vl6180_probe,
> >  	.id_table = vl6180_id,  


