Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8794A6DDB
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 10:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbiBBJeE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 04:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiBBJeD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 04:34:03 -0500
X-Greylist: delayed 5064 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Feb 2022 01:34:03 PST
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B53C061714
        for <linux-iio@vger.kernel.org>; Wed,  2 Feb 2022 01:34:03 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0B0362000C;
        Wed,  2 Feb 2022 09:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643794442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6iU+Q8PhD/7GHQ721Mg92Mo1BCVLDLKwHWjg6zvejtc=;
        b=YIMoaSlpJShfRgdxuBCZA/WVLbG0MO4iqXK1lju0mJtt6zBIjT1WMsuOw2L97OcdhWzWcE
        I+0xUGLDYq7eNA8IpRZz3ihcvfitTf13RV/ZRDv/yctpycAWFqyhPLIEKa8vu0YWfVgnpX
        M3uSFmvpE1f4tGAlodItYPi2rMJSYSuJYPmeScI1slQ52Is7oOK5fmswWhLChcmgjCLEXz
        zdhM21X+JRaeuIwQMA2SvflMZaC9bgGnrd/5yfhDncxiXNB+UPJWMkD7x5At6VjMM23Ocp
        63hmY6nMTNxb44ZDc/mTU9aKyZM/7csci/OOE8M3vTcRiAj/6QhCK7duCK1Fzw==
Date:   Wed, 2 Feb 2022 10:33:59 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Olivier MOYSAN <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 04/10] iio: adc: stm32-dfsdm: Avoid dereferencing
 ->currentmode
Message-ID: <20220202103359.3d4c5fb7@xps13>
In-Reply-To: <ff1ddd2b-acbb-3154-5712-87c1d9a7f8b7@foss.st.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-5-miquel.raynal@bootlin.com>
        <CA+U=DspvsLxYyhrvNfEBGPKuJ1a6-L=WjnQE-hvjMVp2g-9nxQ@mail.gmail.com>
        <20211216092235.56e69441@xps13>
        <20220115160619.746a9246@jic23-huawei>
        <20220128160443.44016830@xps13>
        <ff1ddd2b-acbb-3154-5712-87c1d9a7f8b7@foss.st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Fabrice,

fabrice.gasnier@foss.st.com wrote on Tue, 1 Feb 2022 09:41:03 +0100:

> On 1/28/22 4:04 PM, Miquel Raynal wrote:
> > Hi Jonathan,
> >=20
> > jic23@kernel.org wrote on Sat, 15 Jan 2022 16:06:19 +0000:
> >  =20
> >> On Thu, 16 Dec 2021 09:22:35 +0100
> >> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >> =20
> >>> Hi Alexandru,
> >>>
> >>> ardeleanalex@gmail.com wrote on Thu, 16 Dec 2021 08:47:02 +0200:
> >>>    =20
> >>>> On Wed, Dec 15, 2021 at 10:03 PM Miquel Raynal
> >>>> <miquel.raynal@bootlin.com> wrote:     =20
> >>>>>
> >>>>> This is an internal variable of the core, let's use the
> >>>>> iio_buffer_enabled() helper which is exported for the following pur=
pose:
> >>>>> telling if the current mode is a buffered mode, which is precisely =
what
> >>>>> this driver looks for.
> >>>>>
> >>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >>>>> ---
> >>>>>  drivers/iio/adc/stm32-dfsdm-adc.c | 5 ++---
> >>>>>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/st=
m32-dfsdm-adc.c
> >>>>> index 1cfefb3b5e56..a3b8827d3bbf 100644
> >>>>> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> >>>>> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> >>>>> @@ -466,8 +466,7 @@ static int stm32_dfsdm_channels_configure(struc=
t iio_dev *indio_dev,
> >>>>>          * In continuous mode, use fast mode configuration,
> >>>>>          * if it provides a better resolution.
> >>>>>          */
> >>>>> -       if (adc->nconv =3D=3D 1 && !trig &&
> >>>>> -           (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)) {
> >>>>> +       if (adc->nconv =3D=3D 1 && !trig && iio_buffer_enabled(indi=
o_dev)) {       =20
> >>>>
> >>>> This may become tricky if other modes get added later.
> >>>> STM does a relatively good job in updating and re-using their drivers
> >>>> (even if some of them do look quirky sometimes).   =20
> >>
> >> Their hardware is crazy/complicated so tends to push the limits!
> >> =20
> >>>>
> >>>> So, the question here would be: is "iio_buffer_enabled(indio_dev)"
> >>>> going to be valid [in this place] once INDIO_BUFFER_TRIGGERED or
> >>>> INDIO_BUFFER_HARDWARE get added?     =20
> >>>
> >>> I would argue, is this a real problem? Today iio_buffer_enabled() seem
> >>> to handle well what this driver is expecting. If tomorrow someone adds
> >>> another mode, that is his/her responsibility to state "okay, this
> >>> section is not common to all buffer styles *anymore*, so we need to do
> >>> a more fine grained check against ->currentmodes than
> >>> iio_buffer_enabled() does". In that case using the ->currentmodes
> >>> getter would be the right way to go, but only at that particular
> >>> moment, not today.   =20
> >>
> >> It should be isolated to this driver, so I think it is fine to use
> >> the broader check today, but I'll leave this to the st folks as
> >> it's their driver and I don't feel that strongly about it. =20
>=20
> Hi Miquel, Alexandru, Jonathan, all,
>=20
> First, sorry for the delay.
>=20
> Indeed, I don't expect any functional changes here by using
> iio_buffer_enabled(indio_dev).
> So it should be fine to use it. You're right, the driver looks for
> buffer mode in both places where this gets used.
>=20
> Just an additional statement is: the driver also checks for no trigger,
> and single channel in both places (to select desired mode in the dfsdm).
> As I see, only INDIO_BUFFER_SOFTWARE is expected then.

Ok, thanks for the validation, do not hesitate to drop a Reviewed-by to
the next version of this series if you agree with the changes made here.

> For my own understanding (I'm just asking), why not using the
> currentmodes getter routine ?
>=20
> I've had a look at the whole series [1], It seems used elsewhere. I may
> miss something... It would be 100% equivalent to current code to use:
> iio_get_internal_mode(indio_dev) & INDIO_BUFFER_SOFTWARE ?
>=20
> This would be safe in case new modes gets introduced later ?
> (another note: unless these new modes gets set by default in the 'modes'
> field, this should have no impact here as well anyway ?)

I would argue that this is more a conceptual change. IMHO:
- currentmode is a variable that should have been kept internal
- checking against its value directly is kind of a hack and should be
  avoided when possible because we want the core to have full freedom
  over the way it manages these flags
- if you want to verify if buffers are enabled, then the core offers
  you a dedicated helper that does exactly this, and will do it better
  than if hardcoded by individual writers, generally

And it's not "used elsewhere" anymore thanks to this series :) only two
drivers _really_ need to check the actual current mode to do specific
actions, but that's all.

I hope it clarifies a bit.

Thanks,
Miqu=C3=A8l
