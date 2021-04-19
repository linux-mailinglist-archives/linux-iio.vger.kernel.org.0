Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E5C364746
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 17:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbhDSPnd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 19 Apr 2021 11:43:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2880 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbhDSPnc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Apr 2021 11:43:32 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FP9r65Pr2z68Brf;
        Mon, 19 Apr 2021 23:35:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Apr 2021 17:43:01 +0200
Received: from localhost (10.52.124.55) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 19 Apr
 2021 16:43:00 +0100
Date:   Mon, 19 Apr 2021 16:41:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/7] iio: adis16475: re-set max spi transfer
Message-ID: <20210419164132.0000714d@Huawei.com>
In-Reply-To: <CY4PR03MB311289981955B0889BE539F499499@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210413112105.69458-1-nuno.sa@analog.com>
        <20210413112105.69458-5-nuno.sa@analog.com>
        <CA+U=DsqeiRRGp+Q+yZ7OVOE719aBiyMoBLsFTZL3amGfWHtgkg@mail.gmail.com>
        <CY4PR03MB3112C342E901F4E308D0AFF0994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
        <CY4PR03MB3112BFAA334A280B0E04CB88994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
        <20210418112058.7bb04fa6@jic23-huawei>
        <CY4PR03MB311289981955B0889BE539F499499@CY4PR03MB3112.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.124.55]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 19 Apr 2021 07:47:55 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, April 18, 2021 12:21 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: Alexandru Ardelean <ardeleanalex@gmail.com>; linux-iio <linux-  
> > iio@vger.kernel.org>; Hennerich, Michael  
> > <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> > <lars@metafoo.de>
> > Subject: Re: [PATCH 4/7] iio: adis16475: re-set max spi transfer
> > 
> > [External]
> > 
> > On Thu, 15 Apr 2021 08:16:30 +0000
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> >   
> > > > -----Original Message-----
> > > > From: Sa, Nuno <Nuno.Sa@analog.com>
> > > > Sent: Thursday, April 15, 2021 9:54 AM
> > > > To: Alexandru Ardelean <ardeleanalex@gmail.com>
> > > > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > > > <jic23@kernel.org>; Hennerich, Michael
> > > > <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> > > > <lars@metafoo.de>
> > > > Subject: RE: [PATCH 4/7] iio: adis16475: re-set max spi transfer
> > > >
> > > > [External]
> > > >
> > > >
> > > >  
> > > > > -----Original Message-----
> > > > > From: Alexandru Ardelean <ardeleanalex@gmail.com>
> > > > > Sent: Wednesday, April 14, 2021 9:29 AM
> > > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > > > > <jic23@kernel.org>; Hennerich, Michael
> > > > > <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> > > > > <lars@metafoo.de>
> > > > > Subject: Re: [PATCH 4/7] iio: adis16475: re-set max spi transfer
> > > > >
> > > > > [External]
> > > > >
> > > > > On Tue, Apr 13, 2021 at 5:45 PM Nuno Sa <nuno.sa@analog.com>
> > > > > wrote:  
> > > > > >
> > > > > > In case 'spi_sync()' fails, we would be left with a max spi  
> > transfer  
> > > > > > which is not the one the user expects it to be. Hence, we need  
> > to  
> > > > re-  
> > > > > set  
> > > > > > it also in this error path.
> > > > > >
> > > > > > Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
> > > > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > > > ---
> > > > > >  drivers/iio/imu/adis16475.c | 4 +++-
> > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/iio/imu/adis16475.c  
> > > > b/drivers/iio/imu/adis16475.c  
> > > > > > index 51b76444db0b..9dca7e506200 100644
> > > > > > --- a/drivers/iio/imu/adis16475.c
> > > > > > +++ b/drivers/iio/imu/adis16475.c
> > > > > > @@ -1067,8 +1067,10 @@ static irqreturn_t  
> > > > > adis16475_trigger_handler(int irq, void *p)  
> > > > > >         adis->spi->max_speed_hz =  
> > ADIS16475_BURST_MAX_SPEED;  
> > > > > >
> > > > > >         ret = spi_sync(adis->spi, &adis->msg);  
> > > > >
> > > > > Purely stylistic here.
> > > > > But, the restore from the cached variable could be done here in a
> > > > > single line.
> > > > > So. just moving [1] here.  
> > > >
> > > > You mean also doing it in the label? I thought about that and the
> > > > reason
> > > > why I didn't is that on a normal run, I want to reset the max freq as
> > > > soon
> > > > as possible so that if someone concurrently tries to read 'direct  
> > mode'  
> > > > attrs
> > > > gets the max freq. This was my reasoning but I admit that it's not  
> > that  
> > > > important so I will leave this to Jonathan's preference...
> > > >
> > > > Hmm now that I spoke about the concurrently access to IIO attr  
> > and  
> > > > being paranoid about
> > > > the compiler, I wonder if we should not use
> > > > WRITE_ONCE(adis->spi->max_speed_hz,
> > > > ADIS16475_BURST_MAX_SPEED)...  
> > >
> > > Hmmm, actually WRITE_ONCE would not be any help since the spi  
> > core  
> > > does not use READ_ONCE. So, if we are going to be paranoid about  
> > the  
> > > compiler and load/store tearing, I guess the only safe way here is to
> > > acquire the adis lock [btw, I'm a bit paranoid with this stuff :)]...
> > >
> > > Anyways, arguably the likelihood for this to happen is really, really  
> > small...
> > 
> > Really small, but needs fixing.  We shouldn't have a window in which
> > this  
> 
> Agreed!
> 
> > can happen.  So either we need to stop those attributes from reading
> > whilst
> > we are in buffered mode (via claim_direct_mode pattern) or we need
> > to put
> > a lock around this.  As an alternative, could we use the speed_hz field
> > in appropriate spi_transfer structures to tweak in this path without
> > affecting others?  That should make this concurrency problem an issue
> > for the spi core (which I'd assume handles this).  
> 
> Hmm, I like the 'speed_hz' approach as there's no reason to grab
> the lock because of a spi core tweak. As you said, with this, we push things
> to spi core. Going one step further, I think the most appropriate thing to do
> is actually come up with a new member in the 'adis_data' struct
> (like burst_max_speed_hz) and tweak the burst mode transfers accordingly in
> 'adis_update_scan_mode_burst()' (as there's no need to set this on every
> burst sample)...
> 
> If we are going the above path, what would be your preference? To add the
> patches to this series? Or to just fix this patch and [1] and push another series
> with the above changes? Hmm, since [1] would also depend on this, I guess the
> later approach would be better?
> 
> [1]: https://patchwork.kernel.org/project/linux-iio/patch/20210413092815.28626-1-nuno.sa@analog.com/

Make a new version of this series with the fix, then provide an update of [1]
that is probably going to be dependent on this series.

Given this is a fix, ideally we'll backport it which we don't need to do
for the new code introduced in [1].

Thanks,

Jonathan

> 
> - Nuno Sá

