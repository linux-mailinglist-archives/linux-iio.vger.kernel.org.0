Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688C22557D9
	for <lists+linux-iio@lfdr.de>; Fri, 28 Aug 2020 11:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgH1Jjg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Aug 2020 05:39:36 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:35258 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgH1Jje (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2020 05:39:34 -0400
Received: by mail-ej1-f68.google.com with SMTP id a26so692098ejc.2;
        Fri, 28 Aug 2020 02:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J3vlp/eXlTP4satCeldhRLQ0QerpKVPNZrLh1qxRxlA=;
        b=CCTHANgGmdgjVqzk76xzgL1XxeB1tGtwwPvdSXWlhEQPqvEDSDrAeRSyi+E4T3RbxO
         odhluihZ97YU8+Kdx/1lDcjdIoFJmIzrZoLaw3f91MXODRH2j9jxnZViT8xGiAcVfssv
         kNxJPz/qcdw1B/2FIEdiYF6dpVqEMaSQALSvGhq6WZr1+YMfXgRqdcoBeZ4zI+VanSZy
         eTncW4oMcPb3LBfIJeIh0oklPJOMf1H1B51mtv1avZCSuBkKzWJxOo5WV0EJJj10JAQD
         eWSBN5vC7n9QfIlrLRTH1whw6YOWMgikZ7srFUBSHV8uuWqggcK4U00fkfMhoUWoWUzt
         UhMA==
X-Gm-Message-State: AOAM530YKBKx9Adn2yZsuokwCsRweGBUzoFszfpuv7xoaTG88nj/u9Nc
        lKYuUl/UL4gKlje56japu6I=
X-Google-Smtp-Source: ABdhPJyZ5+gOtMOguXBWcBmM09JnXeWNwgoXx8eub/G6UYR9BlYz7wWYO5xqTGl0eMZqpOArw3OYKw==
X-Received: by 2002:a17:906:a84f:: with SMTP id dx15mr860440ejb.377.1598607572946;
        Fri, 28 Aug 2020 02:39:32 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id a20sm413983ejx.33.2020.08.28.02.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 02:39:32 -0700 (PDT)
Date:   Fri, 28 Aug 2020 11:39:30 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH] MAINTAINERS: Move Hartmut Knaack to Credits
Message-ID: <20200828093930.GA17966@pi3>
References: <20200827202452.27714-1-krzk@kernel.org>
 <CAHp75VdE-Nxr7yDPPyRjG2vJZs-nkZowi+daUJTKK348Su_Pow@mail.gmail.com>
 <20200828090038.GA17717@pi3>
 <CAHp75Vcz7ByVFSTeXLn7AvNcOgr=bw26mrmi=DsCfC9khro_kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Vcz7ByVFSTeXLn7AvNcOgr=bw26mrmi=DsCfC9khro_kQ@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 28, 2020 at 12:30:18PM +0300, Andy Shevchenko wrote:
 > >
> > > > Cc: Hartmut Knaack <knaack.h@gmx.de>
> > >
> > > ...and this?!
> >
> > Since email is not bouncing, he might still receive it.
> 
> Hmm... I'm a bit puzzled now. It seems gmx.net has some policies in
> places that make my replies to your emails (patches) bounced, but this
> one is okay. Strange...

Can you paste here such bounce example?

Best regards,
Krzysztof

