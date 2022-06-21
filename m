Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644915529CA
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 05:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244781AbiFUDhb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 23:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345055AbiFUDh2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 23:37:28 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF28205C2
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 20:37:26 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id cu16so18044776qvb.7
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 20:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MSnBJxIMajCRdbgjedD4hjClanw8+Ph3IgtMGknCwiY=;
        b=Kxg5RRAOTrisP7gRyvQXdU4/dykXnQY0AURJMlUd4GxSn1g4e69J3KDUoiL2IMf5j5
         hesGNNYUIGLa4H8Kb5WL6G6goKZoiSu2+9/ZvKFCwVNBDPkZwznT4osobntEa54mkh9b
         LlaUv3yMI/9MYPFcxWKON9ryC2ICxxYk27ccTQmAwn8RJiDOLGa/XHGeZ3iJ6GnwEYXH
         DR9WFHaxTdEHG7spA0Hw6YzqgO2npfAO6Rl7c+5AZD9WkOGWEKIUpLPuaX69GNzTrvHO
         gUSq545RRF9IRGiXJzOoCmAy3rG/B5dGSa5kFFdqc9qgWbAFlgu8gmKCG1yE2cgbLmcn
         2pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MSnBJxIMajCRdbgjedD4hjClanw8+Ph3IgtMGknCwiY=;
        b=p3k4vkfktwBWzEeauc4GvycZXvvYpueMGRmn0NqrDxtZsHsRcc7MoxhxDGxPyGNZ0O
         O9UtHPs2WobjKACj6H+sOrGif4Bg1GGUGCUm0kOfFLaFn52+VxE+GE81nJD4l8XR7hep
         S7q1B7yoCatt/XI29t3VXmg3ed1AD8T+HQDtXjSmUzIuX+TsWEoQeWdWTZgASM4UREwl
         FX2b+hplz9HsSJSngrha5+O7YUMajzxvlN7m9c70R4IslVFbRfvv2+3iBywqcUm89Nqd
         /UkjQeGuCTaDtMX0Wii3jnsAhUUjtR/Q4Ruc8S9iavqtdGrnSpaaPo2q0kE+fss2Syxq
         YpUw==
X-Gm-Message-State: AJIora+iY2wFJPlbhhUKwLCmVnCoT50hLeJy2bkan2cx0xCfHnbEYYAr
        7Ny3UbGxu11QpihStivFLom7RR4GB8w=
X-Google-Smtp-Source: AGRyM1sM7tremjaJsRoJ98qu4+4UrIBe6PQLWWTox1huWj9Sn6i7AzIS1zrg+Zw13ZgERiGdUMmGCw==
X-Received: by 2002:a05:6214:21a5:b0:46e:3743:a0b6 with SMTP id t5-20020a05621421a500b0046e3743a0b6mr20968297qvc.19.1655782645264;
        Mon, 20 Jun 2022 20:37:25 -0700 (PDT)
Received: from spruce (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id z13-20020a05622a060d00b00304eb8e880dsm13247074qta.23.2022.06.20.20.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 20:37:24 -0700 (PDT)
Date:   Mon, 20 Jun 2022 23:37:22 -0400
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: Re: [PATCH v2 0/4] 3rd set of IIO export namespaces.
Message-ID: <YrE88tt9469NSNno@spruce>
References: <20220604155306.422937-1-jic23@kernel.org>
 <20220618142054.4571f2f4@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220618142054.4571f2f4@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jun 18, 2022 at 02:20:54PM +0100, Jonathan Cameron wrote:
> On Sat,  4 Jun 2022 16:53:02 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Changes since v1:
> > - Rebase (bit of fuzz in patches 1 and 4)
> 
> If anyone has time to take a quick look through this lot and sanity
> check I haven't done anything stupid it would be much appreciated.

FWIW, 1 through 4 look good to me.

Reviewed-By: Joe Simmons-Talbott <joetalbott@gmail.com>

Joe
> 
> Disadvantage of being the maintainer is there isn't anyone else you
> can moan about when no one reviews your patches. Of course I never
> moan about other maintainers and I'm sure no one ever moans
> about me :)
> 
> > 
> > I sent v1 out in Feb and only got review on one patch (which I've since
> > applied - thanks Nuno).
> > 
> > Looking for a quick sanity check of these 4 that remain from anyone who
> > has the time.  Whilst this is mechanical stuff, I've made enough dumb
> > mistakes in such patches over the years that I still like to get a second
> > set of eyes on them if at all possible! 
> > 
> > Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > Cc: Nuno Sá <nuno.sa@analog.com>
> > Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > 
> > Jonathan Cameron (4):
> >   iio: imu: bmi160: Move exported symbols to IIO_BMI160 namespace
> >   iio: pressure: bmp280: Move symbol exports to IIO_BMP280 namespace
> >   iio: chemical: sps30: Move symbol exports into IIO_SPS30 namespace
> >   iio: adc: qcom-vadc: Move symbol exports to IIO_QCOM_VADC namespace
> > 
> >  drivers/iio/adc/qcom-pm8xxx-xoadc.c  |  1 +
> >  drivers/iio/adc/qcom-spmi-adc5.c     |  1 +
> >  drivers/iio/adc/qcom-spmi-vadc.c     |  1 +
> >  drivers/iio/adc/qcom-vadc-common.c   | 16 ++++++++--------
> >  drivers/iio/chemical/sps30.c         |  2 +-
> >  drivers/iio/chemical/sps30_i2c.c     |  1 +
> >  drivers/iio/chemical/sps30_serial.c  |  1 +
> >  drivers/iio/imu/bmi160/bmi160_core.c |  6 +++---
> >  drivers/iio/imu/bmi160/bmi160_i2c.c  |  1 +
> >  drivers/iio/imu/bmi160/bmi160_spi.c  |  1 +
> >  drivers/iio/pressure/bmp280-core.c   |  2 +-
> >  drivers/iio/pressure/bmp280-i2c.c    |  1 +
> >  drivers/iio/pressure/bmp280-regmap.c |  4 ++--
> >  drivers/iio/pressure/bmp280-spi.c    |  1 +
> >  14 files changed, 24 insertions(+), 15 deletions(-)
> > 
> 
