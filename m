Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE022C619E
	for <lists+linux-iio@lfdr.de>; Fri, 27 Nov 2020 10:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgK0JY3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Nov 2020 04:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgK0JY2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Nov 2020 04:24:28 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9832DC0613D4
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2020 01:24:28 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id r17so4011863ilo.11
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2020 01:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=bItLH0hkec9ukuL0j0sr1H9BtSW9n2NqPfJmuGxo8HA=;
        b=i4EAtnLbo4t/W0ULGyPtWcjm9047r/VP4P3qVkVLG0ZYkYszV0oJrge9G0DxTrmwUN
         tmyRixga96KUQ3snK2XS6ZV4XrC1zD8yHC85aTp+8D8tt2S/9iqRi1sMnaH4Gn/qSUwo
         Vj4LxVOKSzsu9dJpCzQrWKXJyc+l/Wf9ORdNFBoC6Zr15bhHtMeP8ctVNknxwCw8sd6D
         xOxzB3XeDFrmZsNBMxy9Ld8zRTCdSOAFXhp30FeYaG1SpybVkF+k5ynkaY7AYFlH2GFA
         kaTZugkH1BybLv3DdExacB87dlX4/bA/trf1CdWDovRKkqfm5mTt3xwmURSRJzdkQsVx
         7EJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=bItLH0hkec9ukuL0j0sr1H9BtSW9n2NqPfJmuGxo8HA=;
        b=Uc9/GYAg6b0xlBq+pGsw8T3C7OTQMHGwJdd8rEUSRCHVJ8tJNS7QSiwvJ2AYdgpbtX
         w2OdVxMdyZvshN3ij6wFwO58U7QEPOOtFq/oYhtw35JRcx8Ay/piCGwJrnx1qa4biIuS
         pqfYIaM2Cw2OjL/35QPX7aEMdQZvTMqPcsjzBfttMHAlWU45gjMNNe5ADLIfL36hZ/0g
         sjQ0Gmk/SsH4obPa/2a8TEhIPHL2v0L5qYMAFDKXtiFK5ROYK5anC0sqNcd7c47DqrHo
         SXxWdD5duktRDlp71Pp7Y56gMeMKKv00hTYOCOPJRbtp+weOGHaKenQ62adICp6sNXi8
         rU6w==
X-Gm-Message-State: AOAM532QsylZT3GWS+4WmtFa+db5e+je69oHxldIDxHxab0yXBTe0zFJ
        m4Tj9JGG5x2ouo0wcF+K0G8utTbsLK5WYDidSgs=
X-Google-Smtp-Source: ABdhPJzHp5RtPiLJICs3ztItA1ljbWPAbeaBVguIUp8XrcmDj6nPDMO22p0ZLQjkjdKDasGER9L0yKO9RCQJ6e0XEiQ=
X-Received: by 2002:a05:6e02:e01:: with SMTP id a1mr6231223ilk.101.1606469067950;
 Fri, 27 Nov 2020 01:24:27 -0800 (PST)
MIME-Version: 1.0
References: <442ef85b-47a0-09a9-7f6a-882f1817e51a@canonical.com> <DM6PR03MB4411E6C39D991B5C5AAC1F86F9F80@DM6PR03MB4411.namprd03.prod.outlook.com>
In-Reply-To: <DM6PR03MB4411E6C39D991B5C5AAC1F86F9F80@DM6PR03MB4411.namprd03.prod.outlook.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 27 Nov 2020 11:24:16 +0200
Message-ID: <CA+U=DsrMeqrH-vy4-S8+uKRb5XJB+uaDY4ejH6mDCPMdgTc7Zw@mail.gmail.com>
Subject: Re: FW: iio: adc: ad7298: rework external ref setup & remove platform data
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        colin.king@canonical.com, linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 27, 2020 at 8:24 AM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Colin Ian King <colin.king@canonical.com>
> > Sent: Wednesday, November 25, 2020 4:37 PM
> > To: Ardelean, Alexandru <alexandru.Ardelean@analog.com>; Jonathan
> > Cameron <Jonathan.Cameron@huawei.com>
> > Subject: re: iio: adc: ad7298: rework external ref setup & remove platform data
> >
> > [External]
> >
> > Hi there,
> >
> > Static analysis with Coverity on Linux-next today found a potential null pointer
> > dereference. I believe it was triggered by the following commit:
> >
> > commit 28963f2f6b46d75bda8fed15bd5ce9923427a40d
> > Author: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > Date:   Thu Oct 1 17:10:48 2020 +0300
> >
> >     iio: adc: ad7298: rework external ref setup & remove platform data
> >
> > ..however the issue may have existed before now and this change triggered the
> > bug being found.
> >
> > The analysis is as follows:
> >
> >
> > 282 static int ad7298_probe(struct spi_device *spi)
> > 283 {
> > 284        struct ad7298_state *st;
> > 285        struct iio_dev *indio_dev;
> > 286        int ret;
> > 287
> > 288        indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> >
> >    1. Condition indio_dev == NULL, taking false branch.
> >
> > 289        if (indio_dev == NULL)
> > 290                return -ENOMEM;
> > 291
> > 292        st = iio_priv(indio_dev);
> > 293
> > 294        st->reg = devm_regulator_get_optional(&spi->dev, "vref");
> >
> >    2. Condition !IS_ERR(st->reg), taking false branch.
> >
> > 295        if (!IS_ERR(st->reg)) {
> > 296                st->ext_ref = AD7298_EXTREF;
> > 297        } else {
> > 298                ret = PTR_ERR(st->reg);
> >
> >    3. Condition ret != -19, taking false branch.
> >
> > 299                if (ret != -ENODEV)
> > 300                        return ret;
> > 301
> > 302                st->reg = NULL;
> > 303        }
> > 304
> >
> >    4. Condition st->reg, taking false branch.
> >    5. var_compare_op: Comparing st->reg to null implies that st->reg might be
> > null.
> >
> > 305        if (st->reg) {
> > 306                ret = regulator_enable(st->reg);
> > 307                if (ret)
> > 308                        return ret;
> > 309        }
> > 310
> > 311        spi_set_drvdata(spi, indio_dev);
> > 312
> > 313        st->spi = spi;
> > 314
> > 315        indio_dev->name = spi_get_device_id(spi)->name;
> > 316        indio_dev->modes = INDIO_DIRECT_MODE;
> > 317        indio_dev->channels = ad7298_channels;
> > 318        indio_dev->num_channels = ARRAY_SIZE(ad7298_channels);
> > 319        indio_dev->info = &ad7298_info;
> > 320
> > 321        /* Setup default message */
> > 322
> > 323        st->scan_single_xfer[0].tx_buf = &st->tx_buf[0];
> > 324        st->scan_single_xfer[0].len = 2;
> > 325        st->scan_single_xfer[0].cs_change = 1;
> > 326        st->scan_single_xfer[1].tx_buf = &st->tx_buf[1];
> > 327        st->scan_single_xfer[1].len = 2;
> > 328        st->scan_single_xfer[1].cs_change = 1;
> > 329        st->scan_single_xfer[2].rx_buf = &st->rx_buf[0];
> > 330        st->scan_single_xfer[2].len = 2;
> > 331
> > 332        spi_message_init(&st->scan_single_msg);
> > 333        spi_message_add_tail(&st->scan_single_xfer[0],
> > &st->scan_single_msg);
> > 334        spi_message_add_tail(&st->scan_single_xfer[1],
> > &st->scan_single_msg);
> > 335        spi_message_add_tail(&st->scan_single_xfer[2],
> > &st->scan_single_msg);
> > 336
> > 337        ret = iio_triggered_buffer_setup(indio_dev, NULL,
> > 338                        &ad7298_trigger_handler, NULL);
> >
> >    6. Condition ret, taking true branch.
> >
> > 339        if (ret)
> >
> >    7. Jumping to label error_disable_reg.
> >
> > 340                goto error_disable_reg;
> > 341
> > 342        ret = iio_device_register(indio_dev);
> > 343        if (ret)
> > 344                goto error_cleanup_ring;
> > 345
> > 346        return 0;
> > 347
> > 348 error_cleanup_ring:
> > 349        iio_triggered_buffer_cleanup(indio_dev);
> > 350 error_disable_reg:
> >
> >    8. Condition st->ext_ref, taking true branch.
> >
> > 351        if (st->ext_ref)
> >
> > Dereference after null check (FORWARD_NULL)
> >    9. var_deref_model: Passing null pointer st->reg to regulator_disable, which
> > dereferences it.
> >
> > 352                regulator_disable(st->reg);
> > 353
> > 354        return ret;
> > 355 }
> >
> >
> > My initial thought was to just add:
> >
> >       if (st->ext_ref && st->reg)
> >               regulator_disable(st_reg);
> >
> > ..however it may be just that the code in line 302 should be aborting earlier
> > when the st->reg is set to NULL.

I think a slightly better option would be to finalize the conversion
to devm_ functions here.
That way, we can cleanup/reduce some of the code.
I do remember seeing that 'st->ext_ref'  is being checked for some
regulator_xxx() function calls, and that isn't pretty.
But 'st->ext_ref' is zero when 'st->reg' is NULL.
So, this is a bit of a false-positive (I think).

I'll do the cleanup/conversion and then this should go away of coverity's radar.

Thanks
Alex

> >
> > Colin
