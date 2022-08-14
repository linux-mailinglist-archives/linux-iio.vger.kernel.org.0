Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556AF592614
	for <lists+linux-iio@lfdr.de>; Sun, 14 Aug 2022 21:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiHNTBr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Aug 2022 15:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiHNTBq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Aug 2022 15:01:46 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AFF1D0E7
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2022 12:01:45 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id y18so4265055qtv.5
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2022 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=U6JfFQFT80vYLw0RLBv3MzTA19bCjUYMSJtsgkqtaBM=;
        b=JYOSJ/Mzeo/4ng6OY2avGNQTDZOiF/WgxneKrlWhQsIFkvwW23mOhGDk22R0vxJEkD
         uSRHDzPZ+NLgj4oA39LBdPbnKeRNKkqTefdCDnbDXiWW6L7iVb6zfbvCAq7t+44DCmbw
         bFmi+bpFAGKSUoGYV2uzHMO8pwe3gu0x5iKjHqNfX0WzfAc0XuqVNXraxTdPaJqE29G0
         1iRE8pZy8KOW4/gKOIrwZtIjIJNWM+QjHkUqrRSLyRn1w4d51gcMWA8hZkex93/h0ztQ
         Jy6iFAch0Phwr+hLYGw5zkLPKJsyRlFcLluNTaFU44UwnplZLVpsBEQG22VG3xUyoGKQ
         9cIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=U6JfFQFT80vYLw0RLBv3MzTA19bCjUYMSJtsgkqtaBM=;
        b=IOu2K9V7bdRciXnuZeDrnEBNBi8hjNXVvpTDmjA8KnU2OCrsVFY+iEz7cd0VicL2Eh
         Q9UMzuy62TG5bMl0M7OQfepOysPmz3K0L6DJ6E2BtjBivORLPW/SFamVti7hrjfHtddo
         E3xE5ibRgqjACpBwz7Ke8SBnbO3/Hz5zS2dpkWfttS0eIoHU0GPVM5bg6zOAtGvHOUOr
         tCdSRMvIWsn3DHQbrVpq+BLz92eK3DlMS6fGIGsFM5VYUtvW3IYeSkksc77l9AV1f9ut
         gwr2jBsNTCcup0h5vfn4KuhBLLcApbBhcdi/PHVVkNZhOJ43VJ/PQ319IxA5CyZ/myw3
         COvg==
X-Gm-Message-State: ACgBeo06K+ubaok8zTBtu3XBBUoRK1ZrNBjlAXECovSTsoQXdx8D0gOP
        mSZPfGNNLBPXddL0HbcpPIcnSDIz52Kq0PJHA5Y=
X-Google-Smtp-Source: AA6agR5vNEkRLCqxEeyfpI8IjKnY6JkryJl2iYAGDtj/XKDvL05k5QCt/zLhpaxYVnjxku33D5/Flml91AVucOywx3k=
X-Received: by 2002:ac8:7f8e:0:b0:344:62c7:e6aa with SMTP id
 z14-20020ac87f8e000000b0034462c7e6aamr454991qtj.384.1660503704423; Sun, 14
 Aug 2022 12:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
 <20220808204740.307667-6-u.kleine-koenig@pengutronix.de> <20220813173142.76774c97@jic23-huawei>
In-Reply-To: <20220813173142.76774c97@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 14 Aug 2022 22:01:08 +0300
Message-ID: <CAHp75VeUV2+-V=TbQwx4Chr-xWU4AmRq-mG8Z8XTkwQmx4qvhQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] iio: adc: rockchip_saradc: Benefit from
 devm_clk_get_enabled() to simplify
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Michal Simek <michal.simek@xilinx.com>,
        David Wu <david.wu@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 13, 2022 at 7:21 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon,  8 Aug 2022 22:47:33 +0200
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
>
> > Make use of devm_clk_get_enabled() to replace some code that effectivel=
y
> > open codes this new function.
> >
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> This might have side effects as it now enables the clock before calling
> the clk_set_rate(). Also changes the clock start up ordering. Neither is =
that
> scary a change, but on really fussy hardware they might cause problems.
>
> Add a few rock-chips people who have sent patches in last few years
> to hopefully take a look or even better run a test.

I believe you found a bug in the patch. The possible solutions are:
- not take the patch
- disable and re-enable clock around clk_set_rate()

IIRC clk_set_rate() will spit a WARN if clock is enabled.

--=20
With Best Regards,
Andy Shevchenko
