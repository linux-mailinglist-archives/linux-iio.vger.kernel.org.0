Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41C13139C41
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 23:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgAMWPZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 17:15:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgAMWPZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jan 2020 17:15:25 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 181452072B;
        Mon, 13 Jan 2020 22:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578953724;
        bh=IM/N4j7+xe7IxMun527SYXMDUncwj/0c2VWaIWkvdzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ecp1/MC7WbjOeY9jr9s1wNHC5S0032h4boKsI/olcYk7Ao3ycqJ2J6imsxh+kFq8S
         OcVdM4NnD1grSdHgOj7fne6cwEpg3Z+Xm0eJKp1FkYXyO+WfMQNs6FjXvAd5omMmTp
         DZYU11T2nJ7D0whLfuAO4a9B3iOI2JV+D8X4geMg=
Date:   Mon, 13 Jan 2020 22:15:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu/mpu6050: support dual-edge IRQ
Message-ID: <20200113221519.51557378@archlinux>
In-Reply-To: <20200111150735.GA16291@qmqm.qmqm.pl>
References: <MN2PR12MB33737F067F25B2F7477C4FE5C43C0@MN2PR12MB3373.namprd12.prod.outlook.com>
        <e5b39c16dc6dcb25324f6e8389cc0d0f895c1cbd.1578309319.git.mirq-linux@rere.qmqm.pl>
        <20200111121047.79e16365@archlinux>
        <20200111150735.GA16291@qmqm.qmqm.pl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 11 Jan 2020 16:07:35 +0100
Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl> wrote:

> On Sat, Jan 11, 2020 at 12:10:47PM +0000, Jonathan Cameron wrote:
> > On Mon, 06 Jan 2020 12:17:54 +0100
> > Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl> wrote:
> >  =20
> > > Make mpu6050 usable on platforms which provide only any-edge interrup=
ts.
> > > This also covers shared interrupt case. =20
> >=20
> > So this had me confused for a bit because I assumed we were trying to m=
ake
> > a level interrupt providing device work with edge interrupts.  Seems
> > device supports a pulsed  mode and the driver supports this.
> >=20
> > Why do we want to detect on both edges?  Do you have a crazy board
> > with this shared and some devices using the rising edge and some the fa=
lling one?
> >=20
> > For shared case it should return that it did not handle the interrupt
> > to allow spurious interrupt detection to work... =20
>=20
> Hmm. The shared interrupt is a red herring. I'll remove the sentence
> from commitmsg as it looks like the driver needs a few more fixups
> to be able to share the interrupt line.
>=20
> The patch is required on platforms that support only dual-edge
> interrupts, like eg. AT91SAM9G45-based one I have.

Yikes. That's a new one to me.  You have my sympathies.
Hmm. Normally I'd just call that a broken platform and ignore
it but I suppose this change isn't too harmful.

I'll aim to pick up v2, with the adjusted message.  If you haven't
done it yet, state the example platform as well.

Thanks,

Jonathan

>=20
> Best Regards,
> Micha=C5=82 Miros=C5=82aw

