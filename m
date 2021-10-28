Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB6F43DED3
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhJ1K3L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhJ1K3K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 06:29:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8257AC061570;
        Thu, 28 Oct 2021 03:26:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w15so22802303edc.9;
        Thu, 28 Oct 2021 03:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5pT//UQaL7euDOvojBQvZaQtog7UFRTQVBLvvJ8oFg=;
        b=M+fk3xpPH0QNFxXsT3zunN3ji29hRoUJpjXF7HyNe2bKWAEbx/T00ytqSdvn3TierB
         4P4WhavE47ghsinlNHMjzSgCIFLuul5GnqmDZ4p7q42TelA1Fxr0F9U1ijCFNrIMITb5
         qFuRLlIEA7G/3fpj50tdQ0OlO4vJVzvNeqR56I5DHe2aTx9M5joAP+3fpS/SoGAwQRG2
         a/wh3o/I4vnva9RH7EGTcDcpGVCUX0CssvcDaYfHPO/b5kRk1Kq5TJH0xGL5kpicXqSh
         mzvFrP7tqKEu8RzPCdMWMhghfBxZNtGEmcnZy/ax4G/RqcCOv+10d9yVcXiM1iFw0RqH
         KqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5pT//UQaL7euDOvojBQvZaQtog7UFRTQVBLvvJ8oFg=;
        b=BltHuszqOb7V3Tmw9RAyCaciqoRNm74ZO+8bu2PMlHpzs6EB/E2sPrDD90HQZsqpnE
         Her/ycX+uq1OB7NzftfItRwN3JGJdTkohhIdd8Y4N4CEx9QoVFuJtkTPN7gd45P/z3Ga
         5rRYl3cTlRVG/CzDZNUtBCjUAy5RB2oRdYNEZSPdg+F6qwRnyz+7EPwRo0y5Hh7anAmr
         qCo5sx/8yyDo9x7iVMXp6AmpEXVz3unaMHmJIL5ERfZM6jfOTBGgi0ckcs+Tog0G6olC
         Mt8B7o8RJ0VMGOAHHMwMHGlJxdlcDaET1NNV7aa6f6pMXOlQC1KV/ho9Ex3eOqkbPYc6
         ZxDA==
X-Gm-Message-State: AOAM5314fgCTs4wqF6yG3uogRKKv7GkuKgktGbU+7t1HJZmz0cykoPnB
        g1f6Yf3yce4GTdrZyA74SySh9eLt1Ta9+ehBvso=
X-Google-Smtp-Source: ABdhPJz/zYIXOnJeP7GjMyTLPVa1T7H/UKik6x5mbyUob5+kG0/YmrPcA9VQTRy5QIsk9PXVZ+oeAtYOYM1Oiczwu58=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr4246924ejc.69.1635416801123;
 Thu, 28 Oct 2021 03:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com> <20211028101840.24632-2-andrea.merello@gmail.com>
In-Reply-To: <20211028101840.24632-2-andrea.merello@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Oct 2021 13:25:48 +0300
Message-ID: <CAHp75VdPhNbr6Y7ethsmw_Bd7DZOi4cyFHubPpOxa1LXibkUCQ@mail.gmail.com>
Subject: Re: [v2 01/10] utils_macro: introduce find_closest_unsorted()
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 28, 2021 at 1:18 PM Andrea Merello <andrea.merello@gmail.com> wrote:
>
> This is similar to find_closest() and find_closest_descending(), but, it
> doesn't make any assumption about the array being ordered.

Macros in general are not so welcoming.
Why do you do it as a macro?

...

> +#include <linux/math.h>

Wondering if the current header misses other inclusions it's a direct user of.

...

> +/**
> + * find_closest_unsorted - locate the closest element in a unsorted array

an

> + * @x: The reference value.
> + * @a: The array in which to look for the closest element.
> + * @as: Size of 'a'.
> + *
> + * Similar to find_closest() but 'a' has no requirement to being sorted
> + */

-- 
With Best Regards,
Andy Shevchenko
