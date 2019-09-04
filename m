Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C38A7E8D
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2019 10:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfIDIzU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Sep 2019 04:55:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36685 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfIDIzU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Sep 2019 04:55:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so20327728wrd.3
        for <linux-iio@vger.kernel.org>; Wed, 04 Sep 2019 01:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I+BfdmTFxR1lZN20ZU5YsoNLCQMT6F0wa5s9MKGtszk=;
        b=nUF2ZzuFI/kfdVfsUgEollW8Qa+9Z4wtoLxPpZlEHvNwSaFSlvxUB3olM+pZbCLjnr
         5aT+O41Ec3I0FLuHQba3xtK3pLdN2h1ErAo+EQakBPo3Qsk/nm6umMbUEJpIG8AcjgpP
         rcTi/+DNXqBF/G8+MgB/J80ROLBlrm0lM+tzy/XL1v85sb25H+htRHR3O9mYc71OERfn
         C96HDt+yAc6/anJoM5KU5D1t2IbMvzDLG3Cg9cFBfMX2y4xgoolhu6qVijR7ZQ7Z6di9
         m1Sy+tHWKEVKf6ow/MyPWlxURGGci2VfqCTwwj2GZ5Xc2SZdpfa4ItUPUNU7KfV7HV6M
         1BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I+BfdmTFxR1lZN20ZU5YsoNLCQMT6F0wa5s9MKGtszk=;
        b=NFK3+LVex3X02aWAZ/bx5TwLU1Oo7MjUTb+vkGvTqRH9teVQLC2Z8Au8O8LR70xm0L
         hAJN02LDNThkvVpSNJjmfIxoNuiHiCKdCdC5uco9jv53KMYlpZw3nwGiRNFHXzqDExyQ
         ynOOqbvL1BYzUMyWlgNo/MsuhggezWHPCrpKA0KlvIQ5Iq1Q1OMep6Qglg3GGvXaswji
         +wlxDoj5wcRFfGJ5nyEtl804RMP0BU2HkbqLHYGLIp1XxjtDokutDHAHnU3jn3WkhZ0D
         7VlyzQSFjk2m/8BAFbzRSrd1MhvhtzQFtXq93nf7MQ1bJBpdRQxwjHXgCk9nQn4UMRTW
         SJmA==
X-Gm-Message-State: APjAAAW6y8kUKdAjYqV2KN8Adys8qeWfE2qnN/zpoVAtxsl1xYwWLBz3
        RP+1YRg7etj/jy+87rDAKAT5jw==
X-Google-Smtp-Source: APXvYqyrF419qEbCLxjUqLi98XTib6R2yLpjW7eX2zo4SxjrgZoqC0ntyxpJvXDj6KPUVaOEp9yoEw==
X-Received: by 2002:adf:b612:: with SMTP id f18mr5557519wre.97.1567587318781;
        Wed, 04 Sep 2019 01:55:18 -0700 (PDT)
Received: from dell ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id g9sm8604694wrc.11.2019.09.04.01.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 01:55:18 -0700 (PDT)
Date:   Wed, 4 Sep 2019 09:55:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: Re: [PATCH 5/8 v2] mfd: ab8500: augment DT bindings
Message-ID: <20190904085516.GG26880@dell>
References: <20190822145233.18222-1-linus.walleij@linaro.org>
 <20190822145233.18222-6-linus.walleij@linaro.org>
 <20190902093024.GH32232@dell>
 <CACRpkdZfzdFrheihacHUreiSAfC3KLtLr0+o+rHYymaXc-EmvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZfzdFrheihacHUreiSAfC3KLtLr0+o+rHYymaXc-EmvQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> > Besides this, looks okay in general:
> >
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Should I record that as just Acked-by: when I resend or do you want
> me to record the infix when resending for clarity?

As I provide it please.  They mean different things to me.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
