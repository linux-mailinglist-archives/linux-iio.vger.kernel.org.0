Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6A23E7CA0
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243209AbhHJPn7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 11:43:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:47579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242153AbhHJPn7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Aug 2021 11:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628610195;
        bh=f9yoZklWAOjRko5GEHne/rB2HxvyimqQxu/6RVsxWfM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gaNLTcUfYmNM6APGQiF0FHtnKBz1zKej6HpnDaAgzlhG4E4nolV22WYw1d9mw+2Ns
         K4MT7IXSfb7VXEFBMevPZ93nvFZJOqq3FBeug+5SrVpcPSfkZDKKLRaxJJc/VKO03P
         hI6cHuNhjDVvTJGl2HqqzCULIGUdIq1dWdsNecnU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McpJq-1mlzNZ1L0s-00a0AJ; Tue, 10
 Aug 2021 17:43:15 +0200
Date:   Tue, 10 Aug 2021 17:43:03 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Len Baker <len.baker@gmx.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drivers/iio: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <20210810154303.GA2508@titan>
References: <20210807152225.9403-1-len.baker@gmx.com>
 <20210808172503.5187cd24@jic23-huawei>
 <CAHp75VfSX-7UqH9Lbr_GxQRY3dGjGo7H8++kBdrrSds1p6nB1Q@mail.gmail.com>
 <20210809102131.000021eb@Huawei.com>
 <20210809161422.GA2619@titan>
 <CAHp75VfyJ1zSmgenn3V-2tF-X9uZJ1tByyJfJOydXZSV1as3GA@mail.gmail.com>
 <CAHp75VeAf_GYcF--=wXJmJZPr1YHn_gLFAFGHwsMCDX7Mxs5zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeAf_GYcF--=wXJmJZPr1YHn_gLFAFGHwsMCDX7Mxs5zw@mail.gmail.com>
X-Provags-ID: V03:K1:cRHTKwbL0WqT843vcAOgaEC2gKAhlW/Nz3Siys7qUczMedk2Sbz
 CYN4XnCy+VCfuctiQz9MiYdV5tnke7l4479UWw9mSEI7qzLnwIdoeFbWEj+BKtMZaWPVbkn
 trYBZMDm8S+jM0W5vVjDREqytula4FEoFEuF9qybQUNsUbJquEdW6/QwOOnaRB2rKHsA2vY
 rY+5uB2126WMJm6t9xDQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VZWlOome2sY=:7hkCJf7Tk4hkI7kJ3dIFPt
 8tK3bg5/XlCkE+AeqXrX3+HxOLVmNaM3vuMDqj4LOmQhbUdI5OG10C1d5a8IYyu6Ti8TAuQ9D
 ja0T8XxUpLRI8vZDqvMzHXJIbW+lHdCsKhCXD7miGhVSFQL7xAlsLKVVsEmZVfJBRYUOo+TeQ
 qGtjyQJwUVWUkcz366Y0nS9ZWuuXgVUUX3H8GQn5m2CT3uWiAMVtaChiHZXucm/HBS9S/BdKG
 L87yLEBZr7EpTguHVMTtWOZVEbGm5j/L9U/c1CkzWhbwcvoH5RO+YKul+tirAhxWjMVAk60Sf
 8atQrQSdktM3B0SeDoTIVjFu2WdQo+Pd7xASoCgfXJbzonvTBGcBvB1e12BCF5QusxjPjse3E
 2EjOHLvaZjaBVqz7WW1Vo827qgK387et7r4e9Ru+DxzoE9q4CQR0b8hepQRXefNN9SVNB8dCF
 g0X6jmJe+Szpmlm34awqWB9ulCH4DGIAqirzrmefkVC+7A+861RExTO7Ux2lD6n1kId2/NyUB
 FtGe16ELqiNdDE20+xndkX3Pg2mL5LsfZ4Pwa3METKwCglQuoecOA8X2gxZw4HwoEcfpzW+Ae
 d18+S4wbAWjuV2X8oZq92I+V3aCLBrZvJnZprjbyZpY7D68U4fFABoJktK7ZbDhrmhBp0gWgJ
 f4uAT3B5vK0xCW2KsTjqeXWFz1OAhfu5hKKZPc3udIJcObwzoznA0T+/75EMzxq/LQujctCbH
 h4z+7Oto8UCefyDxkuQyI2jJTjoyvRCKmtUzsIiMmHMuJYBRhF/pJ6NdALjTTsUuMTcrDpLI+
 L3L4vZQjrXdrsWg0/PhJLdAixhndGMgpJGMwat5GiBEnwnHRsAafTGrOE1sNWO8LqGn8OdOHY
 +PPMCz9IxfTkTwk4xnaPYBKOugp9H7hWPQvF46tyb+wDon3hRVia6F2rGUxfvIkLFRHpIpCef
 YYajSEVtSy3oDeIyqGjdwWPV/ziEkt3X8kUVBksfPDKwKkvJn7aalvw1laAyxytI1kWcL20fE
 q4omv7Dh6htr5og+YV42Dv5kuP4vyGY2IxEEP0XwCh2x+zDACsxFoFAhTVmekBqdw2thwwJZf
 G2R1JA6i5fBOWbUdUbZxVa7HucMs/pFqNOYX6A57Quk9dPKwT5rGBT7LQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy, David and Jonathan

First of all thanks you very much for your code snippets ;)
More below.

On Tue, Aug 10, 2021 at 03:11:01PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 10, 2021 at 3:06 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Aug 9, 2021 at 7:14 PM Len Baker <len.baker@gmx.com> wrote:
>
>
>
> > Even if we leave the logic as is, this might be better
> >
> > if (orient[0] =3D=3D '-')
> >    str =3D devm_kstrdup(dev, orient + 1, GFP_KERNEL);
>
> > else if (orient[0] !=3D '0' || orient[1] !=3D '\0')
> >    str =3D devm_kasprintf(dev, GFP_KERNEL, "-%s", orient);
> > else
> >    str =3D devm_kstrdup(dev, orient, GFP_KERNEL);

I think the above snippet is the right one: Is compact and easy
to understand.

>
> Or these two swapped for better reading
>
>  else if (orient[0] =3D=3D '0' **&& orient[1] =3D=3D '\0')
>     str =3D devm_kstrdup(dev, orient, GFP_KERNEL);
> else
>     str =3D devm_kasprintf(dev, GFP_KERNEL, "-%s", orient);
>
> And with a comment added that we negate the result according to the
> rules: 1) drop leading '-' (minus); 2) leave 0 as is; add leading '-'
> (minus).
>
> > if (!str)
> >    return -ENOMEM;

Also, I think that it is better to leave the logic as is and don't
try to use always the +/- sign.

Again thanks to all for the feedback.

Regards,
Len
