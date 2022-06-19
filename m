Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41C9550D8F
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 01:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiFSXUs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 19:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiFSXUr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 19:20:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D786418
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 16:20:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n20so11154336ejz.10
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 16:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Rc5/CHu2Jl8pgnlZF2VJAidUyxBG0Z0t/+1WB/446Q=;
        b=igHVKI1GzaYYhjx+WXw3bDpp5FGl84rUq6QrxIR7pQE2KLvrAv/7/mhW7WDQrvyaXw
         7bMwhq+jvSsvNN/KhzJGJqZ7Jp/6nYSE74Os1D5lDkGaf4GiICCEXkgt1bNvVEVq7ZOL
         T9xGVUrayVCmN4XM3f/BQq3cAojiK1LtEDwvZY8yyQ8xY+Vrx+M1GVJa7J9U6irOYZv7
         AtVtoArcUBSiQGvBPKFxvqLkQv4ZTghAnwQ83egu63J/5oxU4DLnwobMyrLQQBO7Kfnn
         MtOCDATbxql8JT6iUoK3qbgOI2MVAutuV6mwC6PSMq2FfT9BRlXBuHmg/jvKpfsJBaNT
         CfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Rc5/CHu2Jl8pgnlZF2VJAidUyxBG0Z0t/+1WB/446Q=;
        b=ac+QDIKk+Q7EGdddI5SS5l+sBVaOVgLojMAqh/0yGIn5SCcyT2XtYtnPSPEabjYq3D
         Mk8nWDVGWhRcUkxhhpR+39pRgN3hxo0MSf8ZDaIvU6Fsit800D3nKf/pIL7GAWFNh4qN
         Sy4BjvMBvt4HUN0tyk84/Cn3w20ICkiyrQOis6r06C6Je9URfUWne+sg+fK8AS8MUUr+
         liJDlnVszz/Fzl9Wt8QSBv7C/vyOvbKrVGNt99RcVL87x3gzkTst/HaxI/RxkuZpxmoD
         u/LUgsr/fFwYpGjdcdqcRH0Kstp44EoYa4amuNu7zCu6cqdWAjXMpmR3OLBT4Om2aExC
         yZEQ==
X-Gm-Message-State: AJIora+Tn+2DU8R+zhJqBKH0ZCnVROdBMq6o7UZEY44RnVfnXQ43H26H
        0hBygTGZPWI//5aSBg4Sec0Hf2FDyoLff79zGQs=
X-Google-Smtp-Source: AGRyM1uwTDoVhZbXWKiSiMhb1QoCa4YTjUhYvvS/Imx5i2sINMZwSyuvnpQ8u/Z0KIQRCJdopyQvB0NVeqjsnbCf0co=
X-Received: by 2002:a17:907:9721:b0:70c:65e7:2aa5 with SMTP id
 jg33-20020a170907972100b0070c65e72aa5mr18545456ejc.132.1655680845138; Sun, 19
 Jun 2022 16:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220619185839.1363503-1-jic23@kernel.org> <20220619185839.1363503-12-jic23@kernel.org>
In-Reply-To: <20220619185839.1363503-12-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jun 2022 01:20:08 +0200
Message-ID: <CAHp75Vdf3aWaeT17cxsm=a7LUSpc1LnoMGkRQS8O_3ftufprLg@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] iio: core: Introduce _inputoffset for
 differential channels
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

On Sun, Jun 19, 2022 at 8:59 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Address an ABI gap for device where the offset of both lines in a
> differential pair may be controlled so as to allow a wider range of
> inputs, but without having any direct effect of the differential
> measurement.
>
> _offset cannot be used as to remain in line with existing usage,
> userspace would be expected to apply it as (_raw + _offset) * scale
> whereas _inputoffset is not.
> Similarly calibbias is expected to tweak the measurement seen, not
> the adjust the two lines of the differential pair.
>
> Needed for in_capacitanceX-capacitanceY_inputoffset for the
> AD7746 CDC driver.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ---
> I''m not entirely happy with the naming on this one, so if anyone
> has a better idea I'm definitely open to it!

I'm not sure I got the idea behind this, but would be "tare" /
"tarepoint" / alike suitable here?

-- 
With Best Regards,
Andy Shevchenko
