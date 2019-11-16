Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B834FECE5
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 16:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfKPPbP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 10:31:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbfKPPbP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 10:31:15 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7F4C20700;
        Sat, 16 Nov 2019 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918274;
        bh=ulnDdJHKwdfdEXyh/6/qggRo59RY9BMy4foFPh8IhkE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ByzMcWNeBaJRMVCRveADho3/Bxv6LRD0izRg9FhESBpGyNg9vob4Y8ukqPZb/YQUG
         uAWn+6c7wuOzrRn7DUV4TrgmGHZ19XKQL0t+4eePBmboH6QZWDLZsJ4gewnX6l5CUI
         QhHYPNJyfPiabRHFR3rXkKyrUWSae5I1813+kmmQ=
Date:   Sat, 16 Nov 2019 15:31:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 0/3] iio: adc: add support for ltc2496
Message-ID: <20191116153108.578020f8@archlinux>
In-Reply-To: <20191114105159.14195-1-u.kleine-koenig@pengutronix.de>
References: <20191114105159.14195-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 Nov 2019 11:51:56 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello,
>=20
> this is v2 of a series sent earlier starting with Message-id:
> 20191111214025.18310-1-u.kleine-koenig@pengutronix.de and addresses the
> comments by Alexandru Ardelean. I'm a bit naughty here because I didn't
> carry out all suggestions. So I didn't use ...-spi.c and -i2c.c as file
> names, because this isn't about a single chip supporting both, but two
> different ones supporting only one bus each. So I thought ltc2496.c,
> ltc2497.c and ltc249x.c was fine.
Not using the particular naming Alex suggested is fine, but wild cards
in names is not.  It's gone wrong far too often in the past.
Much better to just pick a supported part and stick to that for naming.
Obviously that's tricky here as you want to reuse the same name hence..

Clunky though it may seem ltc2497-core.c ltc2497 and ltc2496 would be my
suggestion..

>=20
> Also I didn't merge the binding docs of ltc2496 and ltc2497 for the same
> reason. I'm still not entirely happy with the (now) yaml document. I'd
> like to have a statement that says: This is an spi device, so it might
> have all the properties described in
> Documentation/devicetree/bindings/spi/spi-controller.yaml for an SPI
> device.

I don't think the is any way of doing this.  For standard elements you
normally just list them with no help etc.

>=20
> Uwe Kleine-K=C3=B6nig (3):
>   iio: adc: ltc2496: provide device tree binding document
>   iio: adc: ltc2497: split protocol independent part in a separate
>     module
>   iio: adc: new driver to support Linear technology's ltc2496
>=20
>  .../bindings/iio/adc/lltc,ltc2496.yaml        |  30 +++
>  MAINTAINERS                                   |   2 +-
>  drivers/iio/adc/Kconfig                       |  10 +
>  drivers/iio/adc/Makefile                      |   3 +-
>  drivers/iio/adc/ltc2496.c                     | 100 +++++++
>  drivers/iio/adc/ltc2497.c                     | 237 ++---------------
>  drivers/iio/adc/ltc249x.c                     | 244 ++++++++++++++++++
>  drivers/iio/adc/ltc249x.h                     |  18 ++
>  8 files changed, 433 insertions(+), 211 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/lltc,ltc249=
6.yaml
>  create mode 100644 drivers/iio/adc/ltc2496.c
>  create mode 100644 drivers/iio/adc/ltc249x.c
>  create mode 100644 drivers/iio/adc/ltc249x.h
>=20
>=20
> base-commit: 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c

