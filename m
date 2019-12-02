Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0BB10ED6F
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 17:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfLBQsO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 11:48:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbfLBQsO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 2 Dec 2019 11:48:14 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49C4F2084F;
        Mon,  2 Dec 2019 16:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575305293;
        bh=YC1D92Q2/C1s5BHdiFIxUIytMAKtToyeLtGa1l/noTo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bykY119De2Dhrk6aOlyWBaRhw24DgNOII7pSeQbvYq6wu3HB8bZucLCeyDiyMphHb
         waaA0naFVT+GSbvm42jVpSwMwWClCWu9aVLJjhdONOMfBEtPbh8DDN4Gg0dgfCKWQz
         9uRWPv0Sk1cVyfOOCZjMHG+h5prDjgvLgkc+MIT4=
Received: by mail-qk1-f170.google.com with SMTP id d124so145995qke.6;
        Mon, 02 Dec 2019 08:48:13 -0800 (PST)
X-Gm-Message-State: APjAAAXshZvn9lPzSco0kryhudLWxr0rR+BUs6OjoIhpbwX6inNy5B4G
        5N7B8sWrTFzEx9bHsMb9VrieYsIDXGgQ/oRemg==
X-Google-Smtp-Source: APXvYqzEf6nK0R9FJCeFAuVHbm+2+Z+yErAyrcxTHZY90AVZEGsjtOmw8+JlCpW8cD4sggibZAOibC9Zpx1Hu5OeO3U=
X-Received: by 2002:a37:81c6:: with SMTP id c189mr34076068qkd.223.1575305292430;
 Mon, 02 Dec 2019 08:48:12 -0800 (PST)
MIME-Version: 1.0
References: <20191116205026.dvlevawj5obq7weh@smtp.gmail.com>
 <CAL_JsqJzi_0eYj=rMxwQe+OTh_m3ngocOvcPZd-tykAwAJAw6g@mail.gmail.com> <20191123122548.54f0f529@archlinux>
In-Reply-To: <20191123122548.54f0f529@archlinux>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 Dec 2019 10:48:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKOdmCn2cxGcjioUibXc=_2cTWtZb81nEx08CMv2fo6Pw@mail.gmail.com>
Message-ID: <CAL_JsqKOdmCn2cxGcjioUibXc=_2cTWtZb81nEx08CMv2fo6Pw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ad7292: Update SPDX identifier
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 23, 2019 at 6:25 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 22 Nov 2019 10:05:52 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> > On Sat, Nov 16, 2019 at 2:50 PM Marcelo Schmitt
> > <marcelo.schmitt1@gmail.com> wrote:
> > >
> > > Update SPDX identifier to the preferred dual GPL-2.0 OR BSD-2-Clause
> > > licensing.
> > >
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > ---
> > > I split the changes into 2 different patches since they are about
> > > different issues.
> > >
> > >  Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> I've applied this to the fixes-togreg branch so it'll go in during
> the early RCs.  Nice not to have a release with a different
> license, particularly as this was me running too fast at taking
> patches.

Please send patch 2 sooner rather than later. I would like 'make
dt_binding_check' to pass in rc1 (or rc2 at the latest) rather than
rc5/6 as happened in 5.4 cycle. It's hard to complain that patches
fail it when mainline is already broken.

Rob
