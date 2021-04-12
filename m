Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A256635C755
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 15:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhDLNRr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 09:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbhDLNRr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 09:17:47 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22EC061574;
        Mon, 12 Apr 2021 06:17:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i190so9171679pfc.12;
        Mon, 12 Apr 2021 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ox/7/zwJ9G/zMHhhxPhLdh317O35Pln2a/ZEv1W9dCY=;
        b=sxjLPh+YNUKS/u/eGYvFTX1nkW2tNftRbO1aJsfcvStZRRXmDv3poPueQhDIrIR2/d
         sfQzqZ1HSKYNmC2LWOjcGkLj9X3MdxOI56I6owHcxaLHNb0e8VAoxLEByIYwpohxK934
         fFWzoK7/U7kObk4ZYVVl0FCoHEvsaAx0unt941MA52j0rBhd3LLkG5WAQsP+py0yB6OQ
         K/L/8rz7KDw+zfp13I+YwehLV1/RlJmLeHv/cmKIm/Vd9bklyPsFaqLB+p/D5kDZY96O
         iFfpT/vCl+L4LykmAqVPvHy7e4c3/WrQcXTEliGdtNHmu6oa3f3MomD5MWrY/gmbnCLh
         OIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ox/7/zwJ9G/zMHhhxPhLdh317O35Pln2a/ZEv1W9dCY=;
        b=fRra8g8UeKM/lKajzuaCsPBwG5He3ZpsomvU+wXWOaouE5DQSCLKN0i6lbRKPkXPeu
         DSSgUdw2R9jvfVMktupIm8B4jMcMKXxKnkoOWV8iJlHg402qu9buzJrB1w2mwNIk70ET
         bXNivG/il0R39GU/ouqhE1xGk4WV/ksit1IUshAcqQsCi/LGPJdLPdngmC/1gHNl+kMl
         +/LycNY5vG1n8fuZFzWSbXFzYaaGagNp/aHgq+9o1Ar55O1kcpTFZkEjV1CLVL1oqQr0
         i/8IKLZvyLYfa6wjv8Am5EGHedo07nXPwK6pHEFDX4cN/aQcLVe5ROhS589WHDtUQEiq
         BbCQ==
X-Gm-Message-State: AOAM533uh4mtikTF1GrD9a56Ho/h6nDI4CTtPTrs1r+BPGkU3hs/LX+w
        Am+AJGySUDpllt9+EPYCzm+Zm/x8aN+VuSCZtymAdFIP07mJKQ==
X-Google-Smtp-Source: ABdhPJw/jYBRNxsXukXsTXr6y5V+xjD7NrBA8DuMTmr2zjj5cZEsztU9vtw01+eX7d1IYw27BfsMKjDjk4xjHpcPOp8=
X-Received: by 2002:a63:c48:: with SMTP id 8mr26484968pgm.74.1618233448140;
 Mon, 12 Apr 2021 06:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210412130140.64541-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210412130140.64541-1-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Apr 2021 16:17:12 +0300
Message-ID: <CAHp75VdUYAHJ-V9oS7FZ=dpEgeE3aTDBRb2rb=jXSQb1t2qjww@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7298: Enable on Intel Galileo Gen 1
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 12, 2021 at 4:02 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Enable ADC on Intel Galileo Gen 1 board.

Not my day...

> +       { "INT3495", 0 },

Should be INT3494

I'll send v2


-- 
With Best Regards,
Andy Shevchenko
