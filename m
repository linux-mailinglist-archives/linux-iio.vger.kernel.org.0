Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500533E9545
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 18:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhHKQCk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 12:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbhHKQCk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 12:02:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951DBC061765;
        Wed, 11 Aug 2021 09:02:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id nt11so4224084pjb.2;
        Wed, 11 Aug 2021 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xp7fAHuStoMf5bIGzrdp1ddyp2JL7ecgJJqJ7viLvyQ=;
        b=g8pWK67UPmKgXGAIsziQSHtJkoZCrnHj0R7Ggcl3aEfFyva6bdZKYXwFiu3mRSw7Dx
         MgJKgC8cXG56ewNREDttPnPqSDLcPAE+66JzmWHXMdOSN2rNZTllI4W5LaJtzy0VxCIi
         9HPQuQKXcJt2+DdEkL76QTy2tXrcInl9y8ALpP7ywysIGOvkkN1ClTM4ioSROnhvxGD0
         4TzAEgHc5YU7MY/iXJx+4wOw0WjxWwDOOROaax1wDb1P9jeatFtKT23OPsEj68VF5xKz
         siUti0ROrc6R4YdJr21x2nU+Y0CnqmmG5RfMVPlx9AsF8LAndllkZcgkJFzH8BIIA55t
         vK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xp7fAHuStoMf5bIGzrdp1ddyp2JL7ecgJJqJ7viLvyQ=;
        b=SGXsDfaS5Og15/zYIwS0kbyPDQHrZsjziTAa/9UyT1MlpUfVQD8EZa9Ee98D6QHITV
         9uQl916mvvSTDL0ZyhJBzwaaGAgK0d6Ig2jpT3TS10pG7PQVBdf9t7ssE+5lwFNpS3E9
         YBgvru0CmN6l8zzyo3NhGJjeAgbvrzScBU/NoCofRBpjN959SjmQIinmxQrqUEkJD7iq
         iHO+3XH+4mUVHLFY1iIH/nz6qsqx+cZSLgkGy89IF1HUL5EguISc63HVOlx+SufG0cwa
         e69FwVjXU6F7TwGI7w3yIM1fC6dtaP2SZj7kF2LqYISx83WlpbFZQ1/NuqVS6rJFMtPd
         rNiA==
X-Gm-Message-State: AOAM533yQHYQSeMXXGGPicPsZ/QNKch9lKM5PIEyw823afkljRGoz6kN
        V5hqlyeBw4BbQpv89HqGw6JeNobeqCYyIn9tmIdIHYb7DRmkF78y
X-Google-Smtp-Source: ABdhPJzlL1aDC2iXEX4fxF9XlKhwbXp4u/YW844FC6pezRpDprQfleemVG7KJi7+PJjT8E8bHqwl5CDP1EqHZpfB4HE=
X-Received: by 2002:aa7:868c:0:b029:3bc:e2ca:4e2f with SMTP id
 d12-20020aa7868c0000b02903bce2ca4e2fmr35296186pfo.73.1628697736067; Wed, 11
 Aug 2021 09:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210811073027.124619-1-puranjay12@gmail.com>
In-Reply-To: <20210811073027.124619-1-puranjay12@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Aug 2021 19:01:36 +0300
Message-ID: <CAHp75VeGKYe_OhAhZJ5zaHnLgrn-yv6viz37yrz5ucqvBw3eFg@mail.gmail.com>
Subject: Re: [PATCH v12 0/2] iio: accel: add support for ADXL355
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 11, 2021 at 10:30 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.
>
> Changes since v11:
> 1. Add forward declaration of struct device in header.

> 2. Use defines for power-of-10s.

TWIMC, Wolfram applied patch against units.h to add the SI prefixes:
https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/commit/?id=26471d4a6cf8d5d0bd0fb55c7169de7d67cc703a

-- 
With Best Regards,
Andy Shevchenko
