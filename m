Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2188E2C7544
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbgK1VtZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:25 -0500
Received: from mout.gmx.net ([212.227.17.22]:35055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730190AbgK1SiJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 13:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606588597;
        bh=Ny6QiCeDGCHORJw/C9YOctxdZUt6ZvDA6fGQCcljyN0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WlTOQ+NkbLdBgSNORp5fpuwhhKm7qBNH6ySFjoii7hAUCJfDW19T8zZ20DPjiXPQM
         wHl9T1Pt9tNYqNXDec5gLsLOcnYU6ekqxuwzfBV3d7d73qvRbeX1yl0e9Jed00jCl3
         SwllQcHM2qkuNM2d8ChspZBoOZ0SwuM60FUSUpFA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNKlu-1kXNLN1jJK-00OscU; Sat, 28
 Nov 2020 15:22:19 +0100
Subject: Re: [RESEND PATCH 1/2] iio:core: Introduce unlocked version of
 iio_map_array_unregister()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     andy.shevchenko@gmail.com, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1606571059-13974-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201128135435.33e9f6ee@archlinux>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <b933efbe-133e-bece-5516-2ecf3dc120b0@gmx.de>
Date:   Sat, 28 Nov 2020 15:22:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201128135435.33e9f6ee@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m9O8j4/8mg+rIr3+prbSb7yN17fxaCU/Do7u/j+zRcFxJBMD0bG
 keUQDyNgemlmt0XKzy+qoKlmENEULv+teVdTv0r150XuMKtQqXIqNiXbv11Y3flCp7CLJCE
 MJXiVd1AxfBATs+I35l2Nw3fIq41lX0ebpjA2aw7kfdnanbdLH9KQ8YnAQsNveqlBM2zfxL
 s/MPw9cBfyYD53SbxOMVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bEX+KW+AGfM=:SSimNFa5PcAcZfer8COmcP
 G63OTDw1NhrmF28v7DcvDazdkVPgDFxG7320IEdazX44y6yuip3KeKNsPdwTKT/BRWdQLNRDF
 SJHWYF70XHudPoiZytJ1CYystiQEwbPK+HAiuevtI8wWyjtKFRzBWcaxGJGBjdywotndaCdiL
 rU1F6x9fndO8wrn/MTeKmKDPqAqT8KLi9V9kWpDl+rjgba2QNB/KF1Ny4gO6msNkFzUzqnUpA
 urmekwgB+3gZPj3cq9D5v2cJ7KocaxtI5heMqkMjFU+bK8Y579ogU0c6ppiWruBs2D7h4h0YW
 FbsWPbVN0UVsGrXJROEBd3K+2rpxW+I9YLS17tszKUBhPFemjj6c5in5wMXrJBIpIPmXDd6Nk
 kKeDADQOvDFcLsPbW9eJwwRdOkmeyoOLKISeNwFq7XmU5IuTF2FOwjl2ncBCeH0YeFEeo4WYD
 3NCkNliAl/b3pqXYpym9p5HeQAaeHWpKDRyI1OC7sj7yHcShLS7R6u+/9pPujMzTSz22/hZS8
 7PsYQPgaUHAH9l/L1GRDN6r7595Y4wRNBryUFxMN18ePRg5BEvOHNV6iakvRFDyq1rvGWa2r4
 kdHh9/b2PPp9CiTaFR2jO4HiRmY0ePTIAlrOzq4nbDSnKrCpvtH/TncjSBWvUQi39vKUBf1Uo
 Cp6202SWXbpYlHB37drgDqinWYzmBuO/k9xCcM6xTPGhzPgSvbuXY+n7CR6Sz7x9GdcBCXmNN
 34BN1y5MH62svLXa4igZXemxku3TQ9NsYPSrceDIRa7co/z8bsqFb6oGwkiwdTm2CM/GRGS9a
 XaGTkSlP8mf1oX7Pce8RXwoyrTzgAcFYVJ61SiVlWMuWKamFYB6HnwJsJIKpsZPZPhFl+Ciy1
 2Z1mxBUWXB36dGyoUlwA==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 28.11.20 at 14:54, Jonathan Cameron wrote:

> A few notes to make it harder for people to do that in future.
> 1. Don't send patch series (or new versions of older patches) in reply
>    to an existing thread.   They get lost and difficult to pull out.
>    b4 can't automatically figure out which patches to pull from that
>    original thread for example.
> 2. Always version number whole series with same number, even if some pat=
ches
>    are new.   So this should be v3.
>

Thanks for these hints, I will keep it in mind for future patch submission=
s.

Regards,
Lino

