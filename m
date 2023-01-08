Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5E466152E
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 13:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjAHMsq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Jan 2023 07:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAHMsp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2023 07:48:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB0D92;
        Sun,  8 Jan 2023 04:48:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DFE9B80975;
        Sun,  8 Jan 2023 12:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4FFC433EF;
        Sun,  8 Jan 2023 12:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673182122;
        bh=Uhlc99022Ls0RTWOv48mkmJNl6QEEfWEdVTIJlk76sI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DIAG724NZZLEidXWg1jC1XYmyNiNI61x6bP7gcuowLviyKULbyXPN36yNlsBaP5O3
         bWn0cOmZM/X3JvYYfsJPJLlj2AtuPoQQRKEbiiLKYzf7QymlvKxr3cTdtNk1pcDph9
         GdYtHznCWH9t3WYIh32j9UmVkW0saMAFzP2nJbpAY39fQx03vc22XJPD0hK5ty1/Jw
         tMYRWuzGB7kMkP8QIbofCm52XN5ec3wM9q4QFdR7ZwARuIuEj48X7j9ct+GlCEQtSe
         uV5tot3cCauwKHhjxRw6aiCeOG610+dBLYaXfls+ayYlfT0zj1eJXamVh3bA8Nee47
         5P8FM2AacXgfQ==
Date:   Sun, 8 Jan 2023 13:02:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 0/3] iio: st-sensors: Add LSM303C
 accelerometer+magnetometer
Message-ID: <20230108130137.302a79d6@jic23-huawei>
In-Reply-To: <CACRpkdbiQFumJek5WUh=dcxXDvOV=Dhd+WqCrzzyWJY+i-xKuQ@mail.gmail.com>
References: <20230106102239.9647-1-stephan@gerhold.net>
        <CACRpkdbiQFumJek5WUh=dcxXDvOV=Dhd+WqCrzzyWJY+i-xKuQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 8 Jan 2023 00:56:22 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Jan 6, 2023 at 11:24 AM Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> > Add support for the ST LSM303C [1] accelerometer and magnetometer combo
> > sensor in st_accel and st_magn. LSM303C seems to be more or less
> > a combination of LIS2HH12 as accelerometer and LIS3MDL as magnetometer
> > so this series just adds two new compatibles for the two sensors that
> > are already supported.
> >
> > [1]: https://www.st.com/resource/en/datasheet/lsm303c.pdf
> >
> > Stephan Gerhold (3):
> >   dt-bindings: iio: st-sensors: Add LSM303C accelerometer+magnetometer
> >   iio: accel: st_accel: Add LSM303C
> >   iio: magnetometer: st_magn: Add LSM303C  
> 
> This patch set:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Series applied to the togreg branch of iio.git and pushed out as testing 
for 0-day to take a poke at it.

Note, still time for others to review as I'll probably not push this out as
a non rebasing tree until next weekendish.

Thanks,

Jonathan

> 
> Yours,
> Linus Walleij

