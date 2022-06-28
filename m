Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFAF55D884
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345572AbiF1MSO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 08:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345486AbiF1MSL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 08:18:11 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0BD237CB
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 05:18:10 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id p7so20465475ybm.7
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARGpcuHWlsFNHUK3Ok/qzhru8mBex35DJ2g/O69GfS0=;
        b=PF1OE2OX2fB0MsvcV8etrEIYLeurWT1jhIyc7JYQflu6nvSTV1LakkTykmSWR9FAqo
         uiCgTLtXMKnHgF2xED04IqmNlh5IILsdF3HcZuv+0Hbi3rkkldLPA6c7s2QE7RBoXOOb
         4zDDZSeIeCLJ+Wg/GbtwNxwfg+Tp9U1A8mHSHooo9bihzymI0KBlPZws2ZWo1B8MSCUb
         vtZdnJogcesf9npgTSQY6t9GeFNPN/niI8Situ5wATA+HuduJp2JY+M28R/9ePxMmKsk
         ZmPcVipOY8bnNb/sad+qzgJW2Gqxob/Lltu9NwQRxQhuGnYfkJNf2KjRfpDR72xfK2/M
         FqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARGpcuHWlsFNHUK3Ok/qzhru8mBex35DJ2g/O69GfS0=;
        b=jzz6QFNEZ+mUme5WYYBysxOlkeorb+D5eTnuSOOOpH1aNM2tWhgwDoJSVcc98l/GGz
         7T0QOuKoFKMPWdbByGkTkpyWNKS+xcZoBZpm4AVozINIAluksIN7gzq9ScgDiWCBAGEX
         TBa2myyDEOK5WDq0rlh1ZyglTkXJUlPBH7iWu/dYhsW20Vah9CvY6uWIVS+dmV5feKFK
         IbnWXET5LB10osJ0ZYWg2X14htLLPTWNsChcqaSN/Lu/cMQpr2FCIZwPxCMCgl6ZZTn8
         jEYIvrVLxthC4Kqi+LsKO4RHbmjhqvxJOzp5xkRJFuc42Y9uOFKx7jLA1SsZYX7OP2wy
         Wiqg==
X-Gm-Message-State: AJIora8Y4+7FDyYdEv+yKoygaTAM/ab+QDeEIVEUXErDc7c8n6IqF4jc
        ivDs2/2T+gUyafjSaNbRL+uAtqlo/BzjK56xV4I=
X-Google-Smtp-Source: AGRyM1uhfTQXpdbErGIlQwWbyxRbXLqIzVE10Uy2iWr1G3X8RwKhlfn8g4VwCFn9Y//nW1MN0zfY9uel8uNtRjSbj3c=
X-Received: by 2002:a25:187:0:b0:66c:eaea:71ec with SMTP id
 129-20020a250187000000b0066ceaea71ecmr8733661ybb.570.1656418689978; Tue, 28
 Jun 2022 05:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220626122938.582107-1-jic23@kernel.org> <20220626122938.582107-12-jic23@kernel.org>
In-Reply-To: <20220626122938.582107-12-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 14:17:33 +0200
Message-ID: <CAHp75VcSaW08brrFRhKQYVCLbNdQz=SG80OmYkPrv028wSuk6g@mail.gmail.com>
Subject: Re: [PATCH v3 11/17] iio: core: Introduce _zeropoint for differential channels
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 26, 2022 at 2:20 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Address an ABI gap for device where the offset of both lines in a
> differential pair may be controlled so as to allow a wider range of
> inputs, but without having any direct effect of the differential
> measurement.
>
> _offset cannot be used as to remain in line with existing usage,
> userspace would be expected to apply it as (_raw + _offset) * _scale
> whereas _zeropoint is not. i.e. If we were computing the differential
> in software it would be.
> ((postive_raw + _zeropoint) - (negative_raw + zeropoint) + _offset) * _scale
> = ((postive_raw - negative_raw) + _offset) * _scale
> = (differential_raw + _offset) * _scale
>
> Similarly calibbias is expected to tweak the measurement seen, not
> the adjust the two lines of the differential pair.
>
> Needed for in_capacitanceX-capacitanceY_zeropoint for the
> AD7746 CDC driver.

...

> +What:          /sys/.../iio:deviceX/in_capacitanceY-capacitanceZ_zeropoint
> +KernelVersion: 5.19

5.20?

> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               For differential channels, this an offset that is applied
> +               equally to both inputs. As the reading is of the difference
> +               between the two inputs, this should not be applied to the _raw
> +               reading by userspace (unlike _offset) and unlike calibbias
> +               it does not affect the differential value measured because
> +               the effect of _zeropoint cancels out across the two inputs
> +               that make up the differential pair. It's purpose is to bring

makes

> +               the individual signals, before the differential is measured,
> +               within the measurement range of the device. The naming is
> +               chosen because if the separate inputs that make the
> +               differential pair are drawn on a graph in their
> +               _raw  units, this is the value that the zero point on the
> +               measurement axis represents. It is expressed with the
> +               same scaling as _raw.

-- 
With Best Regards,
Andy Shevchenko
