Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261972C65A3
	for <lists+linux-iio@lfdr.de>; Fri, 27 Nov 2020 13:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgK0MQH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Nov 2020 07:16:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2168 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgK0MQG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Nov 2020 07:16:06 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CjD7r6q6dz67JcP;
        Fri, 27 Nov 2020 20:14:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 27 Nov 2020 13:16:04 +0100
Received: from localhost (10.52.122.48) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 27 Nov
 2020 12:16:04 +0000
Date:   Fri, 27 Nov 2020 12:15:46 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        <colin.king@canonical.com>, linux-iio <linux-iio@vger.kernel.org>
Subject: Re: iio: adc: ad7298: rework external ref setup & remove platform
 data
Message-ID: <20201127121546.00004604@Huawei.com>
In-Reply-To: <CA+U=DsrMeqrH-vy4-S8+uKRb5XJB+uaDY4ejH6mDCPMdgTc7Zw@mail.gmail.com>
References: <442ef85b-47a0-09a9-7f6a-882f1817e51a@canonical.com>
        <DM6PR03MB4411E6C39D991B5C5AAC1F86F9F80@DM6PR03MB4411.namprd03.prod.outlook.com>
        <CA+U=DsrMeqrH-vy4-S8+uKRb5XJB+uaDY4ejH6mDCPMdgTc7Zw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.48]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Nov 2020 11:24:16 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Fri, Nov 27, 2020 at 8:24 AM Ardelean, Alexandru
> <alexandru.Ardelean@analog.com> wrote:
> >
> >
> >  
> > > -----Original Message-----
> > > From: Colin Ian King <colin.king@canonical.com>
> > > Sent: Wednesday, November 25, 2020 4:37 PM
> > > To: Ardelean, Alexandru <alexandru.Ardelean@analog.com>; Jonathan
> > > Cameron <Jonathan.Cameron@huawei.com>
> > > Subject: re: iio: adc: ad7298: rework external ref setup & remove platform data
> > >
> > > [External]
> > >
> > > Hi there,
> > >
> > > Static analysis with Coverity on Linux-next today found a potential null pointer
> > > dereference. I believe it was triggered by the following commit:
> > >
> > > commit 28963f2f6b46d75bda8fed15bd5ce9923427a40d
> > > Author: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > Date:   Thu Oct 1 17:10:48 2020 +0300
> > >
> > >     iio: adc: ad7298: rework external ref setup & remove platform data
> > >
> > > ..however the issue may have existed before now and this change triggered the
> > > bug being found.
> > >
> > > The analysis is as follows:
> > >
> > >
> > > 282 static int ad7298_probe(struct spi_device *spi)
> > > 283 {
> > > 284        struct ad7298_state *st;
> > > 285        struct iio_dev *indio_dev;
> > > 286        int ret;
> > > 287
> > > 288        indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > >
> > >    1. Condition indio_dev == NULL, taking false branch.
> > >
> > > 289        if (indio_dev == NULL)
> > > 290                return -ENOMEM;
> > > 291
> > > 292        st = iio_priv(indio_dev);
> > > 293
> > > 294        st->reg = devm_regulator_get_optional(&spi->dev, "vref");
> > >
> > >    2. Condition !IS_ERR(st->reg), taking false branch.
> > >
> > > 295        if (!IS_ERR(st->reg)) {
> > > 296                st->ext_ref = AD7298_EXTREF;
> > > 297        } else {
> > > 298                ret = PTR_ERR(st->reg);
> > >
> > >    3. Condition ret != -19, taking false branch.
> > >
> > > 299                if (ret != -ENODEV)
> > > 300                        return ret;
> > > 301
> > > 302                st->reg = NULL;
> > > 303        }
> > > 304
> > >
> > >    4. Condition st->reg, taking false branch.
> > >    5. var_compare_op: Comparing st->reg to null implies that st->reg might be
> > > null.
> > >
> > > 305        if (st->reg) {
> > > 306                ret = regulator_enable(st->reg);
> > > 307                if (ret)
> > > 308                        return ret;
> > > 309        }
> > > 310
> > > 311        spi_set_drvdata(spi, indio_dev);
> > > 312
> > > 313        st->spi = spi;
> > > 314
> > > 315        indio_dev->name = spi_get_device_id(spi)->name;
> > > 316        indio_dev->modes = INDIO_DIRECT_MODE;
> > > 317        indio_dev->channels = ad7298_channels;
> > > 318        indio_dev->num_channels = ARRAY_SIZE(ad7298_channels);
> > > 319        indio_dev->info = &ad7298_info;
> > > 320
> > > 321        /* Setup default message */
> > > 322
> > > 323        st->scan_single_xfer[0].tx_buf = &st->tx_buf[0];
> > > 324        st->scan_single_xfer[0].len = 2;
> > > 325        st->scan_single_xfer[0].cs_change = 1;
> > > 326        st->scan_single_xfer[1].tx_buf = &st->tx_buf[1];
> > > 327        st->scan_single_xfer[1].len = 2;
> > > 328        st->scan_single_xfer[1].cs_change = 1;
> > > 329        st->scan_single_xfer[2].rx_buf = &st->rx_buf[0];
> > > 330        st->scan_single_xfer[2].len = 2;
> > > 331
> > > 332        spi_message_init(&st->scan_single_msg);
> > > 333        spi_message_add_tail(&st->scan_single_xfer[0],
> > > &st->scan_single_msg);
> > > 334        spi_message_add_tail(&st->scan_single_xfer[1],
> > > &st->scan_single_msg);
> > > 335        spi_message_add_tail(&st->scan_single_xfer[2],
> > > &st->scan_single_msg);
> > > 336
> > > 337        ret = iio_triggered_buffer_setup(indio_dev, NULL,
> > > 338                        &ad7298_trigger_handler, NULL);
> > >
> > >    6. Condition ret, taking true branch.
> > >
> > > 339        if (ret)
> > >
> > >    7. Jumping to label error_disable_reg.
> > >
> > > 340                goto error_disable_reg;
> > > 341
> > > 342        ret = iio_device_register(indio_dev);
> > > 343        if (ret)
> > > 344                goto error_cleanup_ring;
> > > 345
> > > 346        return 0;
> > > 347
> > > 348 error_cleanup_ring:
> > > 349        iio_triggered_buffer_cleanup(indio_dev);
> > > 350 error_disable_reg:
> > >
> > >    8. Condition st->ext_ref, taking true branch.
> > >
> > > 351        if (st->ext_ref)
> > >
> > > Dereference after null check (FORWARD_NULL)
> > >    9. var_deref_model: Passing null pointer st->reg to regulator_disable, which
> > > dereferences it.
> > >
> > > 352                regulator_disable(st->reg);
> > > 353
> > > 354        return ret;
> > > 355 }
> > >
> > >
> > > My initial thought was to just add:
> > >
> > >       if (st->ext_ref && st->reg)
> > >               regulator_disable(st_reg);
> > >
> > > ..however it may be just that the code in line 302 should be aborting earlier
> > > when the st->reg is set to NULL.  
> 
> I think a slightly better option would be to finalize the conversion
> to devm_ functions here.
> That way, we can cleanup/reduce some of the code.
> I do remember seeing that 'st->ext_ref'  is being checked for some
> regulator_xxx() function calls, and that isn't pretty.
> But 'st->ext_ref' is zero when 'st->reg' is NULL.
> So, this is a bit of a false-positive (I think).

Agreed it's a false positive though would make sense to check st->reg rather than
st->ext_ref here.

> 
> I'll do the cleanup/conversion and then this should go away of coverity's radar.
> 
> Thanks
> Alex
> 
> > >
> > > Colin  

