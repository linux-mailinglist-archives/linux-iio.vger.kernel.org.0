Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBC93E3605
	for <lists+linux-iio@lfdr.de>; Sat,  7 Aug 2021 17:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhHGPCi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 11:02:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:37737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhHGPCi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Aug 2021 11:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628348528;
        bh=WjUBEM/wpIWu8FjBSrx8sFw9ILP0DGVrd76lOgEqG9g=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=SfYv+F8ftbmpCxr/HiEK/vkitTJ9F+GgT6Iz3HtRWNtJBdVlbdkeahbGrAt0JrSbJ
         mbeUZveFycVt2VAe+DOWvT7BA0MyWR/rsr5pbzw4jU+LFntd12zt4eg//hBV01OgmO
         tErPbpQDmRcU7UzHM6OwVbagno6tIRUtGB4N8HPM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvbBk-1n1T5a0AJ4-00shje; Sat, 07
 Aug 2021 17:02:08 +0200
Date:   Sat, 7 Aug 2021 17:02:06 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-hardening@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/iio: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <20210807141711.GC2688@titan>
References: <20210801171157.17858-1-len.baker@gmx.com>
 <20210801205528.211c4e9c@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801205528.211c4e9c@jic23-huawei>
X-Provags-ID: V03:K1:SY41mXTtN/r5p3fUCAB+dCcVU5Tm70F9SpAn4XVE0g04UNgcE/h
 Oz55/MbIMuD8PMKkXuF8Di9lokw7mpm5VftC+Bymex4o/gPQkrPxJd3d8uEtacTZt8Qkh7Y
 9H9E2kml5jZMUzznHnyK4T8RWRu+a0PudtFKvRRN+zCVUsopdWIIctkKe3h6dRsy9qawnpp
 6eQpIOddwGSO3yCyTodtA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zXPRmHOLj3I=:CzhTGpn/r4cYLdYBEw9KDb
 PiHuwbpH8BhpFC5C0fo9VDvcwcrlM/xYZbVJ7MtuJVPNuflVVjj4lwBMayGB/VRwFt1q3BbBA
 r95xmL3C0HVvXQmxv5zFabKUTjTMmKehByjQo3cq3YIguZNbpRmrpnr7mq1N+v1NnvCHiNkyC
 Je45zzhVrcwIjBfCx2A8EQpqeseHitvTk5OvsVrdIEfbpIy8rw/vsahM5JCadbdM03tV05Llr
 7DMEfZKbiro96hNzRhFGbqyMWNMB0sSzyiDAo1+p1Dyyn/QMukfyNE/hryxx3Qr5kyeWmPgOc
 7YN5ecDHdMOPC8ptl8KdevcHVMfqUo9PGXXNopUqCyItQj1BCRLHUqqZnd1SrVnH1EjajyKYT
 NFTcuQ1ggfJQxByGYQg/ZOWJIzm8+XN+cidbOeVSVQDGusq+8kQyzyM9HX2q/8th2LZ326qkD
 5qKLN3uowGWPZp/El2jMFL4SoEV8FtXc8RUVuGWHfAZ34R5k7vPT/WCgnQqCLqL9Wc6scTLeL
 jHRoCsJX+VkYElRfV9CPa3WgMadWQG+t/sVDW3eckf3chb2fpWUPhOSfJclFlEltVFrthHijG
 Jsvk+gWiqDimFtfdaGgYzQqKxR3oSheNUks5CMA+U1PWuBRKnbeW6FOROjijiHQdwkixOfG8x
 57hKPrvsscArvNHMGDDfmdwNPc+h99f4QjgrgiaVd0aa6DZ4JzYGTdXwvxzgbP2haYdtieXwb
 Qky1GmkgazJgqdfOaRZwLgRjT9m4UY3HKQwFvB5X907lmM/GMEQCJUp15tOxPwmASZ/va+hzI
 W6oxKht6wZiotxkTsyAthAhWSO77xGv8b01urPFroiXHPpFDZl7k5XBEtqUZrzdcik16k1lKS
 iHjd0uKkbiAa2Y5r6bG+/urLXufKUUukH80Hhw+XeRXi4QG+CpCds7P48KWbO6+q+0r6tPMPh
 CvKJKstIY9TiuSQiY159WBL+oficEYVvmSmHM50VZSP0vqhU7G+yPCQNxgPXoUbBoIYcljbPm
 q5KObz1hLMg1IaqqHYKJfbwqcVWlL3JsAQa/KSBRaIzy6Sc8tWYpqtt6qkU9CrsSkCMosMS95
 ouRbz7zuru2KJ40aAsqdgNqXdgIOpAcfcBPz2K6gQNDijont9dof/LlYw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Sun, Aug 01, 2021 at 08:55:28PM +0100, Jonathan Cameron wrote:
> On Sun,  1 Aug 2021 19:11:57 +0200
> Len Baker <len.baker@gmx.com> wrote:
>
> > strcpy() performs no bounds checking on the destination buffer. This
> > could result in linear overflows beyond the end of the buffer, leading
> > to all kinds of misbehaviors. The safe replacement is strscpy().
> >
> > Signed-off-by: Len Baker <len.baker@gmx.com>
>
> Hi Len,
>
> I'm not convinced this is terribly useful in this particular case.
> As the code stands today, it is easy to verify that the buffer is
> large enough by looking up a few lines. As you need to do that
> anyway to check that n, n -1 in the strscpy is correct, what do we gain?
>
> I don't mind this if it's part of a general removal of strcpy(), but
> if so the patch description should state that.

Ok, I will send a new version with the commit changelog updated.

Regards,
Len
