Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE736566C
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2019 14:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfGKMMn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Jul 2019 08:12:43 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40534 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbfGKMMk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Jul 2019 08:12:40 -0400
Received: by mail-yw1-f68.google.com with SMTP id b143so3151643ywb.7
        for <linux-iio@vger.kernel.org>; Thu, 11 Jul 2019 05:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JLpZTDyH6Q/WVfB7D3ohVeoj0U2p4Tl2uxiI/qIEuhc=;
        b=EfH6sWliBwbfu8sqP4opjoREUcenXWr13a17h77Bpj68HtnncvSRktKCJdngvBVDGj
         iQx8/rI+Ht34P/XquSJHbApJUdh/UZEkkZEz6DXXyvlFkxrKzcbRGI11PUWT4qaM5eeY
         RplKIYBYyVnToeLtjPy3d7F1sWPNJA7VDNZTfUw9nlEj/xUpi1Mzv19F2vrUPMFbxpiZ
         1v0pI61zsb31WW2gsjIrMIAhYnAM3rAFhzTNgZnEKm2OShiMCPC/5+n9YVP7gjT/fXCp
         9XvWqs7A+pS5OONot6+lyJ8pIxT6uzZFhhl2voygxFNNN5eSCQm/I10uk6fgYHZtUFc2
         mG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JLpZTDyH6Q/WVfB7D3ohVeoj0U2p4Tl2uxiI/qIEuhc=;
        b=svf3KPJhWHAUEbrEJH8F9MmnLbemHFmEO5KH8hbUYdVBjTCjcRp9FdUxYKFz+jw82f
         IT6Yb+Bebsby2aFF421+mNx0Cpzx0Vh1+NzcvOE9j6fYp5US2eiKjJU1W+VGmRWBbkUD
         njyHlCXbaQhuNQ1UQuKu0PNc+1PM18yAr7/DuEFBZRiIsWrA8FD7grjFnYwOmO2GzWLl
         hOhv/WGv31OMNspqbSZs3vlBuRuTEa014A1dJX9tCmNfIV/7TvCluMlsCeu5H8d7Q7gg
         Mat8nACeGT+qKNlvLnGlCBfuQCLL4ZGvMcj8QDqdMpxf6Au6cx8WK7Zdvzw1hkOwIdzv
         Boyg==
X-Gm-Message-State: APjAAAUrsvpjt7UMtmVPna3U6IPl6+zvI+xqVeFu3oxj8E0edhO6ShKS
        AdHJdythYunxyc/xOWIqg+sKqkr9o/Yv28WBzkMJjg==
X-Google-Smtp-Source: APXvYqzGVBbdyzATQFuVMW3IFDJn0oZE3752K4RBlif7yTSyE6BtlJCKiTmlzKVDg38zAYQuNx/xDs549BoClqzTLhQ=
X-Received: by 2002:aed:3f47:: with SMTP id q7mr1946820qtf.209.1562847159155;
 Thu, 11 Jul 2019 05:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190507091224.17781-1-benjamin.gaignard@st.com> <20190711115059.GA7778@icarus>
In-Reply-To: <20190711115059.GA7778@icarus>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 11 Jul 2019 14:12:27 +0200
Message-ID: <CA+M3ks42Whd=QVQ-4==n5bRJKEwYpQtRHs=gBGEZ_Hr=_8YU1g@mail.gmail.com>
Subject: Re: [PATCH] IIO: stm32: Remove quadrature related functions from
 trigger driver
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le jeu. 11 juil. 2019 =C3=A0 13:51, William Breathitt Gray
<vilhelm.gray@gmail.com> a =C3=A9crit :
>
> On Tue, May 07, 2019 at 11:12:24AM +0200, Benjamin Gaignard wrote:
> > Quadrature feature is now hosted on it own framework.
> > Remove quadrature related code from stm32-trigger driver to avoid
> > code duplication and simplify the ABI.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>
> What is the status of this patch? Are there any objections currently for
> its inclusion?

You were the only one asking for more details about it :-)
If you agree I think that Jonathan can merge it.

Benjamin
>
> William Breathitt Gray
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
