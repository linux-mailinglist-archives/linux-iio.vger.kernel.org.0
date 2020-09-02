Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83D225A894
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 11:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIBJ2Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 05:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBJ2W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Sep 2020 05:28:22 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D568AC061244;
        Wed,  2 Sep 2020 02:28:20 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id l9so2015279plt.8;
        Wed, 02 Sep 2020 02:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYsI9E74JqXQ9TWSs6VTDxNOzuc+u1whLZyqXwkgTYI=;
        b=K6vCIo+hnFO3LSA776wB9Bn0pryOQtbIhmVmrzu+RY/eVBpBsvwRZJtL43uXknw0+P
         NguHCTqYMQO7E2egsRpCaJyi5Lr5fhqqkF6nkffU+lCaihaAZzjE7I9m54FBZGmV4poq
         t/RtRviqX2E7ELLNVI5KmuVFi+yn6VPBNDZsgDaq3eoFQgbSKmSC8/qCSdBh6ODgDyPK
         +mihHSb9fRbymsPIBIrXAC31SoMlWAShPvyUE45D7ptN15NT5OeaoJr3nf5VkiWNw5MU
         kSJo6a+nXv8hmNg/6f4XCLi08PAGQ0Gz3SbmOXuhgMotKFNUmL4UvBI80qHrvmqU6bHa
         dgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYsI9E74JqXQ9TWSs6VTDxNOzuc+u1whLZyqXwkgTYI=;
        b=AwVBIaYlONhM+Fm6pVuvRZ00c10y7h7ePfYqSs2hJn4xiKl1XOjEJA0q+Q6cHDf45z
         ronFF2/NGXmHYcT2aEMoDstH3/uaXTYBwYByXk687ax1kXPSouvP7SVc6jVMysjv2wzV
         OVt56DGsp/LaIR5EeSW5zar72D2zDJr/wf2gcwCt8rzqCXpe/wu+AjZWENfIR8twT/Gx
         I0C7NnW88dRKnNzJp5BLH7+IfDMJNYcz7JyWTSK1epe1gpk1RYXeAVyO8raN09JEAiXA
         w/AT1OWtXtxqbLSmi+xYpk4LKpeukefbLsG9tvMa1y1hPzwEBJytTvKc+OCmwvNlKeDf
         iUNQ==
X-Gm-Message-State: AOAM531ZaLiu9bG7SEWT7Rg/7Lja4yuoEZlDiEhasucuOsfnXWe20TMR
        y3+OmHr+VAaSgfR3xcBW4Sc+jq+g7hwAWiyvRJU=
X-Google-Smtp-Source: ABdhPJzc/H+QnaH7vgTcF+rFn3Hwsg7evMrZ3miHYORCeNF8yzP0pOKxDPAFHwNf6srZ051bfdrfy7dmw/3rR42Vtc0=
X-Received: by 2002:a17:90a:2c06:: with SMTP id m6mr1519839pjd.129.1599038900228;
 Wed, 02 Sep 2020 02:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
 <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
 <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
 <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com>
 <BN6PR03MB25968259EBEAD55E040367308E2F0@BN6PR03MB2596.namprd03.prod.outlook.com>
 <CAHp75VdvnUsEf=fsRQRmyxQO=1m09M5U19GBtSPkjxSGA5cRBA@mail.gmail.com> <BN6PR03MB259650CEEEC9647AB5C9D8338E2F0@BN6PR03MB2596.namprd03.prod.outlook.com>
In-Reply-To: <BN6PR03MB259650CEEEC9647AB5C9D8338E2F0@BN6PR03MB2596.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Sep 2020 12:28:02 +0300
Message-ID: <CAHp75VcXLyw40JaU42jQ3fSL7mtHPv++xqcka-oTKUbsW4erpg@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        William Sung <william.sung@advantech.com.tw>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Campion Kang <Campion.Kang@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 2, 2020 at 12:12 PM Hennerich, Michael
<Michael.Hennerich@analog.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Mittwoch, 2. September 2020 10:52
> > On Wed, Sep 2, 2020 at 11:09 AM Hennerich, Michael
> > <Michael.Hennerich@analog.com> wrote:

...

> > I see. Can we consider this email as the official answer from AD that this ID is
> > being allocated for this certain component?
>
> To my knowledge only PNP/ACPI vendor IDs need to be registered with the UEFI
> ACPI working group.

Correct.

>  AD part numbers are unique. The ID chosen uses the
> part number prefixed with the PNP Vendor ID. ADxxxx->ADSxxxx
> Please consider this as allocated.

Thank you for confirming this!

-- 
With Best Regards,
Andy Shevchenko
