Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9000034365D
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 02:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCVBnu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Mar 2021 21:43:50 -0400
Received: from m12-11.163.com ([220.181.12.11]:37173 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhCVBnX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Mar 2021 21:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=BqNfQ
        UakMBDLi2krA8ty6EC/EqPxqFOZCHSv70m16CQ=; b=L619O9wAP1i9kqoikaIKt
        RxaouCiw+uZ3j7gyVnrLaJa57aXrobAlurYm7/PjahnnDQ+iqjWs0en+K4DBCQHI
        uBT3l9ZhwcBIlR1T8aFyp7EBd75QyGplDtb5fYz0tC+iyHThaBQWs4Sgnaf2Jw6O
        pzRhvcsj1ffisA4/m5I1OY=
Received: from localhost (unknown [218.94.48.178])
        by smtp7 (Coremail) with SMTP id C8CowACHRnf89Vdg1pTeTQ--.47183S2;
        Mon, 22 Mar 2021 09:42:21 +0800 (CST)
Date:   Mon, 22 Mar 2021 09:42:19 +0800
From:   Guoqing Chi <chi962464zy@163.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Michael.Hennerich@analog.com,
        marcelo.schmitt1@gmail.com, pmeerw@pmeerw.net,
        chiguoqing@yulong.com
Subject: Re: [PATCH] iio: adc: ad7292: Modify the bool initialization
 assignment
Message-ID: <20210322094219.000046d4@163.com>
In-Reply-To: <20210320150730.67635739@jic23-huawei>
References: <20210319062706.5135-1-chi962464zy@163.com>
        <20210320150730.67635739@jic23-huawei>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C8CowACHRnf89Vdg1pTeTQ--.47183S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFyrXFy3trWDWrWUAF17trb_yoW8GF17pF
        ZrGF90kFWkGF1kG3W8Zr1UZFyYga1fGrW8KF4Y9a45urZ8ZFnakF45KrW8W3ZrCF18AFsI
        qFyjq34UuF4DZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j89N3UUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pfklmlasuwk6r16rljoofrz/xtbBiB1dRFaD+TyEcAAAso
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 20 Mar 2021 15:07:30 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 19 Mar 2021 14:27:06 +0800
> Guoqing chi <chi962464zy@163.com> wrote:
> 
> > From: Guoqing Chi <chiguoqing@yulong.com>
> > 
> > A bool initializer is best assigned to false rather than 0.
> > 
> > Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>  
> 
> Hi
> 
> This one is a bit marginal as counting as noise rather that a useful
> change in an existing driver. I'll take it this time, but I'm not
> keen to see lots of these unless they form part of larger sets
> cleaning up the drivers in question.
> 
> Applied to the togreg branch of iio.git and pushed out as testing for
> the auto builders to ignore it.
> 
> thanks,
> 
> Jonathan

Hi Jonathan

Okay, I'll be mindful of that.
Thanks for your advice.

Thanks.

> 
> > ---
> >  drivers/iio/adc/ad7292.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
> > index 70e33dd1c9f7..3271a31afde1 100644
> > --- a/drivers/iio/adc/ad7292.c
> > +++ b/drivers/iio/adc/ad7292.c
> > @@ -260,7 +260,7 @@ static int ad7292_probe(struct spi_device *spi)
> >  	struct ad7292_state *st;
> >  	struct iio_dev *indio_dev;
> >  	struct device_node *child;
> > -	bool diff_channels = 0;
> > +	bool diff_channels = false;
> >  	int ret;
> >  
> >  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> >  

