Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFE31417FD
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 15:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgARO1O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 09:27:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgARO1O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 09:27:14 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6F662469A;
        Sat, 18 Jan 2020 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579357633;
        bh=dAKbZwpE0mv4pSygMb0TooOW0oSCInBqSZmNiUr4MEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HGmgiR/+ulFgfjII0jI2fy/GjYgueHHN9Fb19hzO1snOMYlS45KudjO8NOBpJpAY1
         RHVlQuDg0TsQMdOro8TGUZ1AHnc3LP/eIAuLjDVkJQSwNjKcsTl3TnLHzMtBe0A4rE
         t4091VK98RRqJtMbyF7um7TvUGJ2wA7tNEgYpevo=
Date:   Sat, 18 Jan 2020 14:27:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] iio: accel: kxcjk1013: Support orientation
 matrix
Message-ID: <20200118142709.4f411677@archlinux>
In-Reply-To: <05662b2a-829a-aa0f-d751-05f01bf6535f@gmail.com>
References: <20200112203301.30235-1-digetx@gmail.com>
        <df95e688271b4cc0e2313daeeae85507c566fc04.camel@linux.intel.com>
        <05662b2a-829a-aa0f-d751-05f01bf6535f@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Jan 2020 05:41:33 +0300
Dmitry Osipenko <digetx@gmail.com> wrote:

> 15.01.2020 20:20, Srinivas Pandruvada =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sun, 2020-01-12 at 23:33 +0300, Dmitry Osipenko wrote: =20
> >> Hardware could be physically mounted in any possible direction and
> >> userpspace needs to be aware of the mounting orientation in order to
> >> process sensor's data correctly. In particular this helps iio-sensor-
> >> proxy
> >> to report display's orientation properly on a phone/tablet devices.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com> =20
> >=20
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> =20
>=20
> Thanks!
>=20
Applied to the togreg branch of iio.git and pushed out as testing
to let the various automated test systems poke at it before I push
out as non rebasing.

Thanks,

Jonathan

