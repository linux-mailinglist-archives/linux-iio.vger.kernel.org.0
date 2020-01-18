Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3B6141801
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 15:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgARO21 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 09:28:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgARO21 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 09:28:27 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B95262469A;
        Sat, 18 Jan 2020 14:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579357706;
        bh=5JmeRbrIpCIS8VAdKp6/Qm6DmGHg+3v869KbQ2bWKVU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bhj7Y51K/9DBHKC0C0+tSoAwPGJ/hPgZk/kyIQQw99qjOI9o8u2HjexqP6+1ZTWCj
         GEBtXUWbE1XHiC9aw3Q5hynsHmT3+KPDaZFH6IYyUbUB09oCY3TAAB3N+BO6E+VLHX
         BZcA6uwIWaNxEWowK894OqE4hNsYn9npf1XZMMn0=
Date:   Sat, 18 Jan 2020 14:28:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Robert Yang <decatf@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        =?UTF-8?B?TWlj?= =?UTF-8?B?aGHFgiBNaXJvc8WCYXc=?= 
        <mirq-linux@rere.qmqm.pl>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: iio: accel: kxcjk1013: Document
 mount-matrix property
Message-ID: <20200118142821.4851166a@archlinux>
In-Reply-To: <48acb337-5928-975c-e0cb-046278464203@gmail.com>
References: <20200112203301.30235-1-digetx@gmail.com>
        <20200112203301.30235-2-digetx@gmail.com>
        <20200115153941.GA9685@bogus>
        <48acb337-5928-975c-e0cb-046278464203@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Jan 2020 05:42:01 +0300
Dmitry Osipenko <digetx@gmail.com> wrote:

> 15.01.2020 18:39, Rob Herring =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sun, 12 Jan 2020 23:33:01 +0300, Dmitry Osipenko wrote: =20
> >> The generic IIO mount-matrix property conveys physical orientation of =
the
> >> hardware chip.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  .../devicetree/bindings/iio/accel/kionix,kxcjk1013.txt     | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >> =20
> >=20
> > Acked-by: Rob Herring <robh@kernel.org>
> >  =20
>=20
> Thanks!
Applied.

thanks,

Jonathan

