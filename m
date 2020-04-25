Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3498E1B87B7
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 18:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgDYQev (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 12:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgDYQev (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:34:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CF3720644;
        Sat, 25 Apr 2020 16:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587832491;
        bh=qaClsSWOrvG9aIKe3l3sIrsAFVBIMrhm6rCLAMkFKOo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WhXqnLD2JtHndu9xo50Ac/ZFVvAmQw0HPkeo20x4gPzQNKtMabug44gnouG4CDXCi
         RRo+XB6btjcBGUXN2ISG9tTdPkwrvjwSH0jQO2IRcpiRChGmAuA68CWy2vFOJzQXfG
         12D2eME68uYxp/lFSAHojc5ZVJOCDX3eejTUUrm0=
Date:   Sat, 25 Apr 2020 17:34:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 07/16] iio: gyro: adis16130: Use get_unaligned_be24()
Message-ID: <20200425173447.20af3518@archlinux>
In-Reply-To: <BN6PR03MB33476B78E7AB1265F0724E5599D50@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <20200421003135.23060-7-andriy.shevchenko@linux.intel.com>
        <BN6PR03MB33476B78E7AB1265F0724E5599D50@BN6PR03MB3347.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 06:39:39 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>
> > On Behalf Of Andy Shevchenko
> > Sent: Dienstag, 21. April 2020 02:31
> > To: Jonathan Cameron <jic23@kernel.org>; Peter Meerwald-Stadler
> > <pmeerw@pmeerw.net>; linux-iio@vger.kernel.org
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Lars-Peter
> > Clausen <lars@metafoo.de>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>
> > Subject: [PATCH v1 07/16] iio: gyro: adis16130: Use get_unaligned_be24()
> >=20
> >=20
> > This makes the driver code slightly easier to read.
> >=20
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/iio/gyro/adis16130.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >  =20
>=20
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Applied with header added...
J
