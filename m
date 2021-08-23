Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057B43F4B22
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 14:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbhHWMwT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 08:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbhHWMwS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Aug 2021 08:52:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02326C061575
        for <linux-iio@vger.kernel.org>; Mon, 23 Aug 2021 05:51:36 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso1108154wmi.5
        for <linux-iio@vger.kernel.org>; Mon, 23 Aug 2021 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SiwDD4z/fjxoo7eiSlRvgsnE2wX1XNbapHhLZ4jHtX4=;
        b=BOSWs2psrLhOlmxXNM0IhBUxk6Qwbgv6P4xWG1JUjkHTA1fFWH7NrWOCMi6ZNcAYTg
         IG9pGvyLsiV6oFNM/KxDSkgaIzUXau3dChguLxIBAayX72XVrDFrOPBCpPBP28Ftby1I
         napDX0fPCZyQLTEmGSld/mF5ZsXxEIHl4gKP21PGVeLP7lrDxInGe3I53dvPdBRNKU7i
         jytUzYiFWWub1BBq7neiAkVvKQk+7roqkvj/NeJPrH4jTt0X7qM35pYoE3xgfSA90L84
         x/dFBPJ7L17EzmZ0ZwOCd6DzDk7pH75pFYfk+l/ECz0rGQMNxvFirS/Tsjng8pshFvxD
         rmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=SiwDD4z/fjxoo7eiSlRvgsnE2wX1XNbapHhLZ4jHtX4=;
        b=QAdkNi8YcKaKrK0m9Ia7aLpaQtuWHPd7oAQch62b6FWV4mfGLUqLoeIrVH8UmOeiwA
         YnZ6xcGGJPVvqsQJdae+uX1xwQ0rB+H3M4GokLNA8xPonrr3y6nW292geVz0X/ud9XpP
         Fgx3wDuDEL+Ze2lOrPm6Tl4Q1sDnBXDM99k7u8ZHgEHPf4DPn2WaTEGoFSKHlWnv9yVV
         LchyN0Epu0pXMb19rdrCwbyDMVt/lubdv+rVSQvDqdW7mk/lK6a4/NOoom/jxH5hTRQM
         Oz8UUmjWa4GA7wNfCX+NwLVffds3cpezTNeW4uLBLE/Tev8Z5Gmnk/s59DwZ6T2/BAIo
         lN5g==
X-Gm-Message-State: AOAM532Eoeu332JMn2xkFodEf1CZYYp1+NPItRzcmxVuwEIxs7vU+Odu
        ZgTKDtY6wcE+wZO5/yjRpCc=
X-Google-Smtp-Source: ABdhPJxBoz7xRoGEkyX9tCi1oH2amMRHDCuH3c6UPwzY8BOAK8ZxcuNIkFYthwIKdhP5riexbv7uLQ==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr6355287wmk.80.1629723094594;
        Mon, 23 Aug 2021 05:51:34 -0700 (PDT)
Received: from nunojsa-N551JK ([2001:a61:2531:cb01:1061:e4b5:709f:d9ad])
        by smtp.googlemail.com with ESMTPSA id b15sm15371280wrq.5.2021.08.23.05.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:51:34 -0700 (PDT)
Message-ID: <e81553af88194c89f6d31bf83e6e486fe75bd4ea.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: ltc2983: add support for optional reset gpio
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Drew Fustini <drew@pdp7.com>
Date:   Mon, 23 Aug 2021 14:51:33 +0200
In-Reply-To: <CAHp75VdDkXT=6d8HKAgeSH-h8O0ERvsNidwrbnyvGZHD0GjgAQ@mail.gmail.com>
References: <20210820065535.6994-1-nuno.sa@analog.com>
         <CAHp75VdDkXT=6d8HKAgeSH-h8O0ERvsNidwrbnyvGZHD0GjgAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2021-08-23 at 14:14 +0300, Andy Shevchenko wrote:
> On Fri, Aug 20, 2021 at 9:53 AM Nuno Sá <nuno.sa@analog.com> wrote:
> > Check if an optional reset gpio is present and if so, make sure to
> > reset
> > the device.
> 
> ...
> 
> > +               usleep_range(1000, 1005);
> 
> The delta should be at least 20%, otherwise I'm not sure why such a
> strict range?
> 

No special reason... I just had no hard requirement for delta so I just
gave something small. Is 20% documented anywhere? I did a quick look on
the API's and I could not find nothing related. Anyways, if that is a
best practise for being more power friendly I'm happy to change it...
(well, we might end up just having 100ms here which means 'msleep()'). 

- Nuno Sá

