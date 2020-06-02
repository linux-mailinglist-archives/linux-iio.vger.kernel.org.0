Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413D61EC07D
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 18:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgFBQ4J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBQ4I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2020 12:56:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7C2C05BD1E;
        Tue,  2 Jun 2020 09:56:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a4so5313592pfo.4;
        Tue, 02 Jun 2020 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4JhKGkoN16KcWdU2zwJaxiaPXbw0nIdbr0m5DGhJhx4=;
        b=E5jUEF1zOMssQjQjXzCXKr9WKj1tMbo0sJPAVAoZFoBlYmBkd5Y81Qr4GVvq+qiXv+
         rDUxhMoltnZjaDFkBMg8grVdQg6pRcXDHi1W65aW9wuEFHe++lFs/JUfgJGG6+EPZixo
         3+No106niW+lMoJNCHFXEHU3R/57AkbQBOebuuhqxdjcyMIHmCUuL5OrT1DSNQdSjRc8
         aOYP7oS/R55QaaJNum/6teEgiUUUvPzotaYmFp9OLY5SXRR33Wdto6EFOkO8tJbiHE8g
         tHP+qt2HFMSV2ydthgwpyL/HFGrkEN/ETo93PpcKkyJdWZ8YyLqJaVg6fcAHYmr8XelC
         0jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4JhKGkoN16KcWdU2zwJaxiaPXbw0nIdbr0m5DGhJhx4=;
        b=Txm3k0G8r/vRqLkcbzHOlqGeJI0eBeWCnxWfx1Z+EVzvllj+T1ptrU/uwNPmGZdssI
         w4NoaW4VxG6h6SaeFcR2Yy7AnVclMosesdsMC+Dmb26PFn5qZV0Ur+8R5vys04P56Jxe
         hVcTfUfCG5KxWz2EuulmPiwZEa93Uo42iFJw4Xa9zUB3MNrzfpZsa3KwwW5NCya2dpK0
         4CbagnEgoeOEXt1WgzzwvxIACMe5F5pWQ0Waaa3YGWaZiHdz2AeIQiqMzo7IpclQCh79
         QbMOvYP5rFzzKWuA0z+9QHzGLCjYgAB9/HqBPKy+oLG3cMz9G2mRKUMh0QvHE9SzRbkM
         NOcg==
X-Gm-Message-State: AOAM530HMSePLUAzuIxKDtiIMGGDG6vk+l0yUn3OQN+l7eXIbgKAhDap
        LZcCeLIHJRJcMvutW82zTs1AjyDNTlHfpX7ltSaK9+JGKrU=
X-Google-Smtp-Source: ABdhPJyQXCKQk09UHgTiUJHHW83u89d/CQ3bjPEtH7N6A42xbhPdhY3sJZgCk3IGu3pQIHfgLwyO1sm4K+ievPmYDvE=
X-Received: by 2002:a63:ff52:: with SMTP id s18mr8774259pgk.203.1591116967037;
 Tue, 02 Jun 2020 09:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200602164723.28858-1-tomasz.duszynski@octakon.com>
In-Reply-To: <20200602164723.28858-1-tomasz.duszynski@octakon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Jun 2020 19:55:55 +0300
Message-ID: <CAHp75VdPF=LzDn0f_Ljb=S+8L58DS4ofC6fD=Nzu1afR_nD8vQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add support for SCD30 sensor
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 2, 2020 at 7:49 PM Tomasz Duszynski
<tomasz.duszynski@octakon.com> wrote:
>
> Following series adds support for Sensirion SCD30 sensor module capable of
> measuring carbon dioxide, temperature and relative humidity. CO2 measurements
> base on NDIR principle while temperature and relative humidity are measured by
> the on board SHT31. As for sensor communication, both I2C and serial interfaces
> are supported.

Btw, since we have relaxed 80 limit to 100, I recommend to reconsider
some lines to be joined.

-- 
With Best Regards,
Andy Shevchenko
