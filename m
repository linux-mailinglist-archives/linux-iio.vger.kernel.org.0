Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629AF3EC823
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 10:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbhHOIVR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 04:21:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:38443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236557AbhHOIVQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Aug 2021 04:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629015606;
        bh=PpZ1IwO1xy5d7pEJEtSYj/nr6ZTLQUTPO0m/aaPn+eM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=k4P2Li+qiPh0pJuVuDkn3KwVkBEHSr5zXHuHZudHrXL5JZo73XHUQ3Cx0aqn3fTSB
         IW7cs4vl26UE0MYNMcWWw6kfsKj0pFFYBsbIU9OLeDCwy5RTYFAkDPiy7kzh4mIRUM
         OfLF+hBLaP+nGF4HOZ1yp6UfB6A3Jptjc5LHSt6k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6Db0-1m8ajN3Bvs-006fND; Sun, 15
 Aug 2021 10:20:05 +0200
Date:   Sun, 15 Aug 2021 10:19:49 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Len Baker <len.baker@gmx.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] drivers/iio: Remove all strcpy() uses
Message-ID: <20210815081949.GA1664@titan>
References: <20210814135509.4500-1-len.baker@gmx.com>
 <CAHp75VdBuQTzCbz1CJciSA1+UOw0ZmJKAh8u2cbr5eDLSsRJEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdBuQTzCbz1CJciSA1+UOw0ZmJKAh8u2cbr5eDLSsRJEw@mail.gmail.com>
X-Provags-ID: V03:K1:+hRc3R4BbYYxKlZo2I/daE+WKavdXS4JcH6Lm90V+m/EB1TodoP
 LATca3p0o+pa1RG1I0VPY2c3xCY/4ApEnC8CJK5SlpcdmPjudALObmlOazkdqaf8m0oVwCe
 51oNAd2UZLBdibuP0kosIeAUl+Ic9GueUIjcXMd3fB2ZyL/qJRdCRRNLpPqmC7h3DTVlBaM
 fuw9TzaUiZQB9ACNhYRyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EPeiWAhPrYE=:egxmqAUCFkC+9s4IwZEsV+
 MFgfmw51aPHnDU84zaMcwhfk9Ib/OzzveP3UaToYKm7SYwil7XJuYM8HoyYuwnKCSrRJrzI2s
 DXBpDIUpTMMqDjgUjAYBCNznQAFEtmAbUKnx9oOmaV85myr/XV5IOdGDP47wghceKrUXyRZvy
 /TmzehIE4/W1Lu5V3/FZ89/QcE4nBWJra0CnvPKfMtXN1dDR4ZSN+lRCMv0IvgCQ2F+T1lXLd
 Z/crz7sso74Qen680XV+SkMNoCXYG2BPVRekuF9BXt3zPrgSLP/OpFKh3JZRHfgWyOVdC6W99
 4HkAFSqFN1QemU7GOy7y/oYRbrBVpbAxX/IZ2akvGS0X8L4btmLE6xrp7+p3v1jbiOcbPlNPI
 HMpHjH+SdEdP56JL91CN/rd8kdhnJJRi2RhgoTOtuuylMF8nVCoIiypinMMNr+3m5vx8TYplX
 VCUICDcmQf3118Oc2XH3LuGwNZpNtFigNz906ppsgkwvDveKB7aZK1vzZdoVLJQ7mBNpHrROi
 JUyIPN7JZLU9RPvQP8/6Vv8bZzJADxhhH/ZfY5fCcgsibEIibj1k2yo06gdSR/FFDuyQQH++R
 vSOFqMJUErNYgJYc7qWFenipiexsAlWeoU03/7gPWcn/h2OwMTY7dvbzVeWBb8Xb7m6oOsDtP
 Ta/32TuM3mURPqeGdt488eJshPbrnRfliYYbBLyvnmUrpxBrnb7kHuPRt9nm2S5CDbSGIhC/3
 YTYGzLOEaDNZ/2zNgUsaAEMmk+gfn8uCNNnsAmeDNQUF5awwPYpMfvg23FkhGh139S2cGoSAL
 NEN7rxnASwkPDYGIsZOLDs2uvZQmfD8GYIi3nBM6Z/IN1Cn9bRe1tZfbfKaDp9AA++ka2q3FO
 nFSHFC3dcgBr1BF30HWi7pWhRDsxpPxLvLubGKn+FIkaDQ0RqiJVlTDSdyj04HsJyYCCtt/OD
 5FGFT5hhMJmaPwxVvXrxg5WB054eC8GOwEkAGauIB2FmB4M9mg/trd3s1LxU69OvalsFPJ627
 om9WhE+hh2rsYq+Ts9t8H8jtzBD1vBzCNJWjHBCOZke57d5iHeqXOK7EIS2WDZV2W4sEJL6sU
 krm9gFvaC4Y8xvEW/k8XpbaRNyicg9m2jwn4sm/y/z1+S8D+29UfJvN3Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On Sat, Aug 14, 2021 at 10:36:18PM +0300, Andy Shevchenko wrote:
> On Sat, Aug 14, 2021 at 4:55 PM Len Baker <len.baker@gmx.com> wrote:
> >
> > strcpy() performs no bounds checking on the destination buffer. This
> > could result in linear overflows beyond the end of the buffer, leading
> > to all kinds of misbehaviors. So, remove all the uses and add
> > devm_kstrdup() or devm_kasprintf() instead.
> >
> > This patch is an effort to clean up the proliferation of str*()
> > functions in the kernel and a previous step in the path to remove
> > the strcpy function from the kernel entirely [1].
> >
> > [1] https://github.com/KSPP/linux/issues/88
>
> Thank you very much for doing this!
> Now I like the result,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thank you too Andy (and folks) for your help on this.

Regards,
Len
