Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA393E83DF
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 21:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhHJTqm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 15:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhHJTql (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Aug 2021 15:46:41 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCA6C0613C1;
        Tue, 10 Aug 2021 12:46:19 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id bl13so5788037qvb.5;
        Tue, 10 Aug 2021 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:subject:from
         :to:cc:references:in-reply-to;
        bh=7uKhEd6eOX5t2b+eg1FPghI/jUcRjPOp/WnfQQyxxWY=;
        b=Cf5gKsRwjqoQHx9oIyDJAKGUxUbuOLczqOVlcz9xPxDXx80ilyxeI0Zb6rqIrBoAL2
         T48RQCZIhT5Fxz53eDY6a1DzGL10RBlx5i7eln1OKUeNnFRt6R1Pf6c7ydwoxgq+s+SQ
         YqEYYgWW6Fi2PTqMj+g7X1tlcTa5eCv+K2UP5vZw9/WlRv4wkmsLaZjclYXR1S5Fln7R
         yDQDPkgCoJvl6Dgtqcg2YH8lwWXK4Nnkrs69XlHWHXh72G9bETAY+PWXOigcGCSxxsYA
         VWU5aRyTx9FG46i3e1Lk4Mz2DTLeA7luZLLX59RBf2pYmGRrrxfnnNHPW/ccfPhqJx90
         qtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:subject:from:to:cc:references:in-reply-to;
        bh=7uKhEd6eOX5t2b+eg1FPghI/jUcRjPOp/WnfQQyxxWY=;
        b=YQUPvOhjAS4qAzI1OnX8gvvl17gU/gNFcpewI2gu2GePxOZBJBSJPGgVngwFHwfywl
         M1GM8N6Hob9/RZOZbGmspTiP+UJKMuZacd49Swt0L1UH3dl5Z9Rj7IgKbPtiGC9JQng5
         KxLxnuZ/M4kqlcUgb1Fd5wrWuxW/+q3RbBwFdsyYG6Vp91TdC6QjLEN1aRehOju6RQMb
         E11OrwIMvDNBwxnX8ePewmFQxUo0vRcRTWmDbSkDlbka05F+HlEx3e99KbMU4f0TLnHV
         EgA0KDPdAXTEOet/fbHcQzubUtgrXDHljOKtPq5saeDlRLtGr/1OHupx71pEYW1N/rwI
         CxSw==
X-Gm-Message-State: AOAM532S58wXVA5WZU9GTZx9tJ945s96QE/xTjk6pXzq6+krwqmSMklN
        XIlQNFaOb/+XOAyj9STzPLE=
X-Google-Smtp-Source: ABdhPJwAAxuvIqF3lzOesrPoEyxuMuaQHzyagNGW6nN0Zo4K+lcCE+lWTZGz/KFNAp0UNnbacp4tXw==
X-Received: by 2002:ad4:4dc5:: with SMTP id cw5mr6748758qvb.62.1628624778573;
        Tue, 10 Aug 2021 12:46:18 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id b22sm3257166qtr.2.2021.08.10.12.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 12:46:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 Aug 2021 15:46:16 -0400
Message-Id: <CDG3ATRV00VV.57ZPL3OPU5N4@shaak>
Subject: Re: [PATCH v5 3/5] iio: adc: ad7949: add support for internal vref
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc:     "Jonathan Cameron" <jic23@kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>,
        <charles-antoine.couret@essensium.com>, <Nuno.Sa@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
References: <20210808015659.2955443-1-liambeguin@gmail.com>
 <20210808015659.2955443-4-liambeguin@gmail.com>
 <20210808173630.5c384a4b@jic23-huawei> <CDEHT583QT0A.2QAXX9AC2FMLO@shaak>
 <CAHp75Vc3o-RrHD_wt_CfJY3P8hoRhJkdiRRySFS_O_7VdtJTQA@mail.gmail.com>
In-Reply-To: <CAHp75Vc3o-RrHD_wt_CfJY3P8hoRhJkdiRRySFS_O_7VdtJTQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue Aug 10, 2021 at 8:15 AM EDT, Andy Shevchenko wrote:
> On Mon, Aug 9, 2021 at 1:50 AM Liam Beguin <liambeguin@gmail.com> wrote:
> > On Sun Aug 8, 2021 at 12:36 PM EDT, Jonathan Cameron wrote:
> > > On Sat, 7 Aug 2021 21:56:57 -0400
> >         ret =3D fwnode_property_read_u32(child, "adi,internal-ref-micro=
volt", &tmp);
> >         if (ret =3D=3D -EINVAL && mode & AD7949_CFG_VAL_REF_EXTERNAL) {
> >                 continue;
>
> >         } else if (ret < 0) {
>

Hi Andy,

> Side note, redundant 'else'

Are you asking to add an 'else' statement?

because, unless I'm mistaken, in this case ret can have other negative valu=
es
that we want to catch with this 'else if'.

Thanks for your time,
Liam

>
> >                 dev_err(dev, "invalid voltage reference in %pfw\n", chi=
ld);
> >                 fwnode_handle_put(child);
> >                 return ret;
> >         }
>
>
> --
> With Best Regards,
> Andy Shevchenko

