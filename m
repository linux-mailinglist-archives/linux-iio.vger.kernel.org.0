Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B978280E8E
	for <lists+linux-iio@lfdr.de>; Fri,  2 Oct 2020 10:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgJBINX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Oct 2020 04:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgJBINW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Oct 2020 04:13:22 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CDEC0613D0;
        Fri,  2 Oct 2020 01:13:22 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 60so612640otw.3;
        Fri, 02 Oct 2020 01:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0oYmOhfr0XKp3vpxmoVBm5o07tNQWWrokEYDpjDquk=;
        b=qPZxfOcmXuvymCFAex6oHike17ra9O/Ot9E545hUVvYbuLRuz4dPEb4gUiE+rkK0iA
         HfHcmRbBilqk52cWGYE42n//3ir2V9hGvgCylucbkTdz3yrsY8S3ylG0ageVPn5qBGc0
         GdpZhuNHDjQO3qut6K+ijs7kWPLIilLlIGA8s2wKQis2cTzvdyfGE2y0B5GkRsSX+uAL
         tqaKbIYrEBO1Mwy5M7wJE3w+b2JXdOmrhgWvGMz8MI5A1n2ONwyEmGPCrghLzSX5U/zv
         tz/zcGsXUJJU3ESa9GYFNBNxohPBROHTWu3sH1eo14yLWwmFgGfaYHpOG0KOqRTUpqwS
         RPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0oYmOhfr0XKp3vpxmoVBm5o07tNQWWrokEYDpjDquk=;
        b=b/WQONttkq0oJrwexKmgzVYhZwNN7RAR2BqJEAOK1mCANYG8EWK4pNjsS2WTHzmNEQ
         4XzLrIFTb/IrGBtDuTHzH4NlbirzebKSJjrQScy2Ze/YBe5evIpYQ/9ChaXZPx0TPvEc
         CxUvGi5UC/sQmizHEu/F1RVIjdixhgyVgVAs9D/Gh7tCOcvNY0AcX0q6bbywtUtvLOaD
         4j3caW7g13LyRsMCVD0Z449wCt+yS7mEkzDMuVMy6cBIfg6pUBftpQsFAeCzHjOlgQjK
         YcqRtf9f9HL73RYUDaZ7FUPPOabNfoYmk7ey1Pw1SNCGCaeubIVfpSrupMfklD115fvb
         jMDg==
X-Gm-Message-State: AOAM533oY1XSePxgUUoE10DtzqScF71NQ4cxZCpHRveRF3IGMnafG/W3
        /PayIAdK+4gotEpbXiNuBUtqFTjZcW5rPki6B/w=
X-Google-Smtp-Source: ABdhPJy9UXgiIj1SVh4KLY9v00vYXwXl/fz+xgFGyQyzqwMVcAs6/V9qh2ou3nd9OyVuwG7QmrLBsBAgaaOUHpyYZp4=
X-Received: by 2002:a9d:4d0:: with SMTP id 74mr898849otm.119.1601626401806;
 Fri, 02 Oct 2020 01:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201001141143.925-1-alexandru.ardelean@analog.com> <202010020651.AJIzQmxM-lkp@intel.com>
In-Reply-To: <202010020651.AJIzQmxM-lkp@intel.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 2 Oct 2020 11:13:10 +0300
Message-ID: <CA+U=DspTK=o9azwa1tP=tUzD_ZK5FzvfBqj9Fnzj7gtGYJ-F5A@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7887: invert/rework external ref logic
To:     kernel test robot <lkp@intel.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>, kbuild-all@lists.01.org,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 2, 2020 at 1:47 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Alexandru,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on iio/togreg]
> [also build test ERROR on linux/master linus/master v5.9-rc7 next-20201001]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Alexandru-Ardelean/iio-adc-ad7887-invert-rework-external-ref-logic/20201001-220829
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: c6x-randconfig-r034-20200930 (attached as .config)
> compiler: c6x-elf-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/98dbf5fa747aac2e245826d8c6cd34b087aeaa27
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Alexandru-Ardelean/iio-adc-ad7887-invert-rework-external-ref-logic/20201001-220829
>         git checkout 98dbf5fa747aac2e245826d8c6cd34b087aeaa27
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=c6x
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/iio/adc/ad7887.c: In function 'ad7887_probe':
> >> drivers/iio/adc/ad7887.c:276:22: error: 'struct ad7887_platform_data' has no member named 'use_onchip_ref'
>      276 |  if (!pdata || !pdata->use_onchip_ref)
>          |                      ^~
>

oh, i really did miss part;
another day of too much multi-tasking


> vim +276 drivers/iio/adc/ad7887.c
>
> 6fe8135fccd66ae drivers/staging/iio/adc/ad7887_core.c Jonathan Cameron   2011-05-18  234
> fc52692c49969ec drivers/iio/adc/ad7887.c              Greg Kroah-Hartman 2012-12-21  235  static int ad7887_probe(struct spi_device *spi)
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  236  {
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  237        struct ad7887_platform_data *pdata = spi->dev.platform_data;
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  238        struct ad7887_state *st;
> 82429e0d33ece55 drivers/iio/adc/ad7887.c              Sachin Kamat       2013-07-23  239        struct iio_dev *indio_dev;
> fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  240        uint8_t mode;
> bf5d2613c9083b8 drivers/staging/iio/adc/ad7887_core.c Lars-Peter Clausen 2012-11-05  241        int ret;
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  242
> 82429e0d33ece55 drivers/iio/adc/ad7887.c              Sachin Kamat       2013-07-23  243        indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  244        if (indio_dev == NULL)
> f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  245                return -ENOMEM;
> f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  246
> f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  247        st = iio_priv(indio_dev);
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  248
> 98dbf5fa747aac2 drivers/iio/adc/ad7887.c              Alexandru Ardelean 2020-10-01  249        st->reg = devm_regulator_get_optional(&spi->dev, "vref");
> 98dbf5fa747aac2 drivers/iio/adc/ad7887.c              Alexandru Ardelean 2020-10-01  250        if (IS_ERR(st->reg)) {
> 98dbf5fa747aac2 drivers/iio/adc/ad7887.c              Alexandru Ardelean 2020-10-01  251                if (PTR_ERR(st->reg) != -ENODEV)
> 82429e0d33ece55 drivers/iio/adc/ad7887.c              Sachin Kamat       2013-07-23  252                        return PTR_ERR(st->reg);
> bf5d2613c9083b8 drivers/staging/iio/adc/ad7887_core.c Lars-Peter Clausen 2012-11-05  253
> 98dbf5fa747aac2 drivers/iio/adc/ad7887.c              Alexandru Ardelean 2020-10-01  254                st->reg = NULL;
> 98dbf5fa747aac2 drivers/iio/adc/ad7887.c              Alexandru Ardelean 2020-10-01  255        }
> 98dbf5fa747aac2 drivers/iio/adc/ad7887.c              Alexandru Ardelean 2020-10-01  256
> 98dbf5fa747aac2 drivers/iio/adc/ad7887.c              Alexandru Ardelean 2020-10-01  257        if (st->reg) {
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  258                ret = regulator_enable(st->reg);
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  259                if (ret)
> 82429e0d33ece55 drivers/iio/adc/ad7887.c              Sachin Kamat       2013-07-23  260                        return ret;
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  261        }
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  262
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  263        st->chip_info =
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  264                &ad7887_chip_info_tbl[spi_get_device_id(spi)->driver_data];
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  265
> f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  266        spi_set_drvdata(spi, indio_dev);
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  267        st->spi = spi;
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  268
> f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  269        indio_dev->name = spi_get_device_id(spi)->name;
> 6fe8135fccd66ae drivers/staging/iio/adc/ad7887_core.c Jonathan Cameron   2011-05-18  270        indio_dev->info = &ad7887_info;
> f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  271        indio_dev->modes = INDIO_DIRECT_MODE;
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  272
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  273        /* Setup default message */
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  274
> fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  275        mode = AD7887_PM_MODE4;
> fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05 @276        if (!pdata || !pdata->use_onchip_ref)
> fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  277                mode |= AD7887_REF_DIS;
> fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  278        if (pdata && pdata->en_dual)
> fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  279                mode |= AD7887_DUAL;
> fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  280
> fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  281        st->tx_cmd_buf[0] = AD7887_CH_AIN0 | mode;
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  282
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  283        st->xfer[0].rx_buf = &st->data[0];
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  284        st->xfer[0].tx_buf = &st->tx_cmd_buf[0];
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  285        st->xfer[0].len = 2;
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  286
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  287        spi_message_init(&st->msg[AD7887_CH0]);
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  288        spi_message_add_tail(&st->xfer[0], &st->msg[AD7887_CH0]);
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  289
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  290        if (pdata && pdata->en_dual) {
> fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  291                st->tx_cmd_buf[2] = AD7887_CH_AIN1 | mode;
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  292
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  293                st->xfer[1].rx_buf = &st->data[0];
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  294                st->xfer[1].tx_buf = &st->tx_cmd_buf[2];
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  295                st->xfer[1].len = 2;
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  296
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  297                st->xfer[2].rx_buf = &st->data[2];
> fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  298                st->xfer[2].tx_buf = &st->tx_cmd_buf[0];
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  299                st->xfer[2].len = 2;
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  300
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  301                spi_message_init(&st->msg[AD7887_CH0_CH1]);
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  302                spi_message_add_tail(&st->xfer[1], &st->msg[AD7887_CH0_CH1]);
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  303                spi_message_add_tail(&st->xfer[2], &st->msg[AD7887_CH0_CH1]);
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  304
> fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  305                st->xfer[3].rx_buf = &st->data[2];
> fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  306                st->xfer[3].tx_buf = &st->tx_cmd_buf[2];
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  307                st->xfer[3].len = 2;
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  308
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  309                spi_message_init(&st->msg[AD7887_CH1]);
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  310                spi_message_add_tail(&st->xfer[3], &st->msg[AD7887_CH1]);
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  311
> b0ec7a44393e0d7 drivers/iio/adc/ad7887.c              Beniamin Bia       2019-11-25  312                indio_dev->channels = st->chip_info->dual_channels;
> b0ec7a44393e0d7 drivers/iio/adc/ad7887.c              Beniamin Bia       2019-11-25  313                indio_dev->num_channels = st->chip_info->num_dual_channels;
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  314        } else {
> b0ec7a44393e0d7 drivers/iio/adc/ad7887.c              Beniamin Bia       2019-11-25  315                indio_dev->channels = st->chip_info->channels;
> b0ec7a44393e0d7 drivers/iio/adc/ad7887.c              Beniamin Bia       2019-11-25  316                indio_dev->num_channels = st->chip_info->num_channels;
> 596d06097f7843e drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  317        }
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  318
> 65dd3d3d7a9bca6 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  319        ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> 65dd3d3d7a9bca6 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  320                        &ad7887_trigger_handler, &ad7887_ring_setup_ops);
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  321        if (ret)
> f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  322                goto error_disable_reg;
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  323
> 26d25ae3f0d8ffe drivers/staging/iio/adc/ad7887_core.c Jonathan Cameron   2011-09-02  324        ret = iio_device_register(indio_dev);
> 26d25ae3f0d8ffe drivers/staging/iio/adc/ad7887_core.c Jonathan Cameron   2011-09-02  325        if (ret)
> 26d25ae3f0d8ffe drivers/staging/iio/adc/ad7887_core.c Jonathan Cameron   2011-09-02  326                goto error_unregister_ring;
> 26d25ae3f0d8ffe drivers/staging/iio/adc/ad7887_core.c Jonathan Cameron   2011-09-02  327
> 26d25ae3f0d8ffe drivers/staging/iio/adc/ad7887_core.c Jonathan Cameron   2011-09-02  328        return 0;
> 26d25ae3f0d8ffe drivers/staging/iio/adc/ad7887_core.c Jonathan Cameron   2011-09-02  329  error_unregister_ring:
> 65dd3d3d7a9bca6 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  330        iio_triggered_buffer_cleanup(indio_dev);
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  331  error_disable_reg:
> bf5d2613c9083b8 drivers/staging/iio/adc/ad7887_core.c Lars-Peter Clausen 2012-11-05  332        if (st->reg)
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  333                regulator_disable(st->reg);
> f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  334
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  335        return ret;
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  336  }
> 2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  337
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
