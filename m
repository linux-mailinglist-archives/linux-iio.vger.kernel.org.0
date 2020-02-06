Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45CAD154219
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 11:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgBFKoY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 05:44:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728540AbgBFKoY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:24 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5385121741;
        Thu,  6 Feb 2020 10:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580985863;
        bh=WqthPeN8XW+A1P/VLpauWQvtFCSVnOy6j96NZv1w9cM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XGpVlxGWa0UXX7qXfkZAcROgDg6u7fq1EvVGpDosyoHN0x6hDVEMayJ6klf86mm9O
         VbutKnKAbBFZ9iaGkTxaKNViKRru8dSusmvWeOIHrSJLQJ2oXLF6huY9WpkmWuk8OY
         i0O70e3GQbfrKEaR/WlKWLAO4v1gntuAo8OmiYxY=
Date:   Thu, 6 Feb 2020 10:44:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Silvan Murer <silvan.murer@gmail.com>,
        linux-iio@vger.kernel.org,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, kernel@pengutronix.de
Subject: Re: [PATCH 4/3] iio: dac: ltc2632: remove some unused defines
Message-ID: <20200206104418.2272c18c@archlinux>
In-Reply-To: <20200206103443.hki3hxeiigowjlxj@pengutronix.de>
References: <20200130131549.1170-1-u.kleine-koenig@pengutronix.de>
        <20200203203126.7003-1-u.kleine-koenig@pengutronix.de>
        <20200206102915.2e32cb5e@archlinux>
        <20200206103443.hki3hxeiigowjlxj@pengutronix.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 Feb 2020 11:34:43 +0100
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> On Thu, Feb 06, 2020 at 10:29:15AM +0000, Jonathan Cameron wrote:
> > On Mon,  3 Feb 2020 21:31:26 +0100
> > Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:
> >  =20
> > > These two defines are unused since the driver was introduced in commit
> > > 02b829f9e11f ("iio: dac: Add support for ltc2632 DACs").
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=
 =20
> > A bit of fuzz and the mysterious bit of this being patch 4 of 3 aside a=
ll good.
> >=20
> > Applied to the togreg branch of iio.git and pushed out as testing. =20
>=20
> If you applied patches 2 and 3 of the series before, the fuzz should
> disappear. I assume the threading didn't work as intended for you and
> you don't have the original patch series grouped with my patch 4/3?
Yup.  Just realised that after sending :) =20

I'll apply them in the right order.

Jonathan

>=20
> Best regards
> Uwe
>=20

