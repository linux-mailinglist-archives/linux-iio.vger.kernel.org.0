Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E336B71591
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2019 11:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfGWJ7A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Jul 2019 05:59:00 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:33275 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfGWJ67 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Jul 2019 05:58:59 -0400
X-Greylist: delayed 535 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jul 2019 05:58:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1563875937;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=+Lo3YUCAK18UnQnxhj/jtm4MqcSui7lw5QLvXTCvfXY=;
        b=afr+vVJyULBsjGgi6bQeakmDDKGYGZnzJ25f09BWpreEde1OZY3vlpJfQ4dhEHFjOI
        oJvmRAo6r5ChNvij0cRgSaaA5h5OWE4hapZX15AzurmVZd6WqqKdVfqh7qVVh+L1gjyX
        IZdd5btn89xwD62GSrR3gH/R6q3rManIFYSIt4kB7I236yZqvW1RIHIY8nCGzAZ/ozHF
        3Zrd/wX5BCVSfHMb+XLOp2ILdm5y12T4ronidPz/8EVdE6pGDq/mUAW4PFnSBB66TVyt
        aZT2ZuElguxgswnA2Hh0dpu21/CDiowL/FH0xiFseyHN4ZWpqZD/P/e4/nH7nwIJIgKE
        Qiiw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlaYXAcKqg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id j00b6dv6N9knLWx
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 23 Jul 2019 11:46:49 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 02/10] iio: document bindings for mounting matrices
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CACRpkdZ5Z9VY457Fywt6X=K5XONgiPVcwbwSkwL_U+GCqZ+u5g@mail.gmail.com>
Date:   Tue, 23 Jul 2019 11:46:49 +0200
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C901747-1657-47AD-A9D7-10E41AFB35CB@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com> <32025b2a8ccc97cc01f8115ee962529eb5990f00.1550768574.git.hns@goldelico.com> <CACRpkdZ5Z9VY457Fywt6X=K5XONgiPVcwbwSkwL_U+GCqZ+u5g@mail.gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Linus,

> Am 23.07.2019 um 09:42 schrieb Linus Walleij =
<linus.walleij@linaro.org>:
>=20
> Hi H. Nikolaus,
>=20
> On Thu, Feb 21, 2019 at 6:03 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>=20
>> From: Linus Walleij <linus.walleij@linaro.org>
>=20
> It is fair for you to change authorship to yourself at this point.
> Just keeping my Signed-off-by is sufficient.

Well, I think my contribution is less than yours :)

>=20
>> The mounting matrix for sensors was introduced in
>> commit dfc57732ad38 ("iio:core: mounting matrix support")
>>=20
>> However the device tree bindings are very terse and since this is
>> a widely applicable property, we need a proper binding for it
>> that the other bindings can reference. This will also be useful
>> for other operating systems and sensor engineering at large.
>>=20
>> I think all 3D sensors should support it, the current situation
>> is probably that the mounting information is confined in magic
>> userspace components rather than using the mounting matrix, which
>> is not good for portability and reuse.
>>=20
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Gregor Boirie <gregor.boirie@parrot.com>
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Cc: Samu Onkalo <samu.onkalo@intel.com>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>=20
> Did this patch fall off somewhere? I think it's really neat, even in =
this
> form it is great help for developers. If you want I can try picking up =
the
> comments and resend it.

Well, I had planned to review it again and promised to send out a new
version. But as usual this ToDo becomes hidden by always more important
tasks.

So I am fine if you can pick comments and resend it. I think there will
be others who help to make it even better in the future if the mount =
matrix
is more widely used.

BR,
Nikolaus

