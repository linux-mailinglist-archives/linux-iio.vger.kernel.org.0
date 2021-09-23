Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11394167DA
	for <lists+linux-iio@lfdr.de>; Fri, 24 Sep 2021 00:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbhIWWOF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Sep 2021 18:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhIWWOF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Sep 2021 18:14:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EFFC061574;
        Thu, 23 Sep 2021 15:12:32 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so32107158lfu.5;
        Thu, 23 Sep 2021 15:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzKfTb+iGUsH3mWhIrSbIbsPD44CEKOd50V1lDVVLdA=;
        b=LCh/98K/jr97CoCn3AQApNer4bPQNBbqmOd2gYXSSbZE2Y6DWmQgIJM6wwPkH+Bn2h
         UhvSxV1cbC3PsMIcXjlhDMwLTAsDFtcsnaznuPwrF5jgxdNhIrOcd+egsjJkWJmJT+iY
         9zfwyZGpwQxk7yQny3BvSu7xBXHSOaynpyLL6YO/h+mKK7CtFHuT1XpdgmSj1TqOFkvd
         XB2QKLy9snWd4PqESNJDOvbmhyMEQzh2YouhF+peJYyShpCCdWT15x0+BvLgIUkFFNZ5
         miW4fI0ZkNqz5pUKo9c3wY4TPpJ8uzwJ5kgfSzwsZS3ft27Vv0hgsXhAHDyK/foCkM4I
         zYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzKfTb+iGUsH3mWhIrSbIbsPD44CEKOd50V1lDVVLdA=;
        b=G9uRaF64vuIOR6h42jJxCviFbPxUrkQ4ljkueqzLCoBLgqfYHyzqfT5pgw6gT+wJIm
         USrgbct9d52Ba1ELPGt7R22f96N3UlAjP1VPzj++HFAH5JLQGMdrrC04B/Wyaomm8JFB
         Adn0ENLZ35AW1Sw4ejsVbta18dsEnYTbe6SS75yAfWuJ6ZJ22TQURrAmZKyquAyA4s/K
         VBLVqtiurXQxlqzaxrbvfZyK4wXK79c8MNVQMIkTeuZHVi+doXR1bKtn+KL64aTN59sY
         zSHxgQEl5OuWF9lRUSxXaofxU6TE7Q0Zkr/krLzuMiGeCihf1Xr4exWrd9zDGZCR60PP
         W1IQ==
X-Gm-Message-State: AOAM5327NGM31a3DIO8u2Z2dqV/LwXAmeWpHzrQ41vIhsqM5y5UhHlBP
        DGiRbxpQEfreQPwNzalYw2ujGLXo/vlCBKf/EATv8aHU7NY=
X-Google-Smtp-Source: ABdhPJwCe68hYsNL0xBCm5+FwBvnV0A6IqGx4zL4pZFssd9TFn7I1EDkwLYqI3Pvner4QOM73k7I5anCUCH//3xv52w=
X-Received: by 2002:ac2:514e:: with SMTP id q14mr6492757lfd.154.1632435151284;
 Thu, 23 Sep 2021 15:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210921052821.91-1-caihuoqing@baidu.com> <20210921052821.91-2-caihuoqing@baidu.com>
In-Reply-To: <20210921052821.91-2-caihuoqing@baidu.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 23 Sep 2021 19:12:20 -0300
Message-ID: <CAOMZO5CDgFHVyVAF6a5WKwsAE60t5zBBu-T+hScUO6WsmTQUvQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] iio: imx8qxp-adc: Add driver support for NXP
 IMX8QXP ADC
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Cai,

On Tue, Sep 21, 2021 at 2:29 AM Cai Huoqing <caihuoqing@baidu.com> wrote:

> +error_iio_device_register:
> +       clk_disable_unprepare(adc->ipg_clk);
> +error_adc_ipg_clk_enable:
> +       clk_disable_unprepare(adc->clk);
> +error_adc_clk_enable:
> +       regulator_disable(adc->vref);

Please rename these labels to indicate the action that will be performed.

Something like this:

error_ipg_clk_disable:
       clk_disable_unprepare(adc->ipg_clk);
error_adc_clk_disable:
       clk_disable_unprepare(adc->clk);
error_regulator_disable:
       regulator_disable(adc->vref);
