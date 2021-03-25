Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C19349A55
	for <lists+linux-iio@lfdr.de>; Thu, 25 Mar 2021 20:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhCYThC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 15:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhCYTgg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 15:36:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9A6C06174A
        for <linux-iio@vger.kernel.org>; Thu, 25 Mar 2021 12:36:33 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 15so4726140ljj.0
        for <linux-iio@vger.kernel.org>; Thu, 25 Mar 2021 12:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLJhf6Pq8M3br+vUFeKdAHCXxfEwlRMxAhokRlNzL+Q=;
        b=yZPqbLDiV4B23r3fiWRV/yz/hZduKM+h05EJOfZ0dM8LJ8AUa8tT1tsWd+lxpWpK36
         3ZA7i2TffzxDUHRllh2+qme09TJanhzL09x1Khv1Upxq3M8ffA8YWYc+DBwsVW+fHe7/
         a7mPUFRQCZaJ8WQDZzLRWBNVrUpFDpMoxdDEYBbS0FxyebcY0gAosAL96RKxEyi8fNKm
         Hti79W6htGLfZ7be9nVQPbcivQhURjSwxIxQNKu8YUVnuik7weMCJGQbCHx4k7mqYP3P
         YxHZNwuDpZMQparv0znOso1dNkfaEF29quaLpFkoIV304wVobA7wRy+PDqTSAltSmipF
         q6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLJhf6Pq8M3br+vUFeKdAHCXxfEwlRMxAhokRlNzL+Q=;
        b=Pmc18QKrr46sKJTt72bxY8cZP8Hj2/QWIe/a+YqmknsKHzLl0MGsYw+USg6D4AZ6iU
         gqGugUmOtPFetg5ZAqcrT7UEBP/A+8V1fKIhAcn/HANMQDhoA2BqkDtdWsoU7sxSktbZ
         SVrHc+KSPY/u1dbhGMmsC+4tXPIatXmzqoL4+rpmrbAiYcV+FaiSjTVWuySFFC/uudQQ
         qi4kdNc/PV5sHr92DIxwnvQfKhhvxkIwirAj1cOaDQHPnT9sUNfYM+nS8jsFwQRP7Hoa
         dmsZJmOGoExGLJYZ72AC4err9k4H0VFYCfobZpVVP/dFDe3CujRN0bR0vs7SzFEZ8gIm
         iEIw==
X-Gm-Message-State: AOAM531FaRaudkZf7qR34PvgEa+iwqDnq4RO5gz+2wSkx2OaIzVKEouU
        tdzB77ZpGiyjEz7pSX7YT4P66punTlPbMQSrPgzIdg==
X-Google-Smtp-Source: ABdhPJw7LmlR5fAyfhlIOtoYPdsdesEBRVz2T2z/SWgGzgPJ64fNhbeQ+jsF7+Y9baQEE5oDNA+SCC24FildF8kXumE=
X-Received: by 2002:a2e:9cb:: with SMTP id 194mr6609153ljj.438.1616700991904;
 Thu, 25 Mar 2021 12:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210322132408.1003443-1-linus.walleij@linaro.org> <BL0PR12MB501168E715C96BBDF34D1ACCC4629@BL0PR12MB5011.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB501168E715C96BBDF34D1ACCC4629@BL0PR12MB5011.namprd12.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Mar 2021 20:36:20 +0100
Message-ID: <CACRpkdaLkMfsBDi-fp+6pN4SgaYjjRbH3o=0VFEF2jYG2wozyg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Use as standalone trigger
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 25, 2021 at 6:08 PM Jean-Baptiste Maneyrol
<JManeyrol@invensense.com> wrote:

> Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
>
> We're lucky this is working without any sensor running, it was not obvious.
> On which chip have you tested that?

This was tested on the Samsung GT-I8190 (Galaxy S III mini)
mobile phone, I don't know which version of MPU6050 it is.

Yours,
Linus Walleij
