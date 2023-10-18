Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBC57CD20D
	for <lists+linux-iio@lfdr.de>; Wed, 18 Oct 2023 03:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjJRB4l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Oct 2023 21:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJRB4k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Oct 2023 21:56:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476ECC6
        for <linux-iio@vger.kernel.org>; Tue, 17 Oct 2023 18:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697594199; x=1729130199;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=wg2GqSF4/xw05SDpARE7Ugy2pKRO35vXu9r273tHoEQ=;
  b=jOaVq0r3AmXJvsco2k/Fe4QItliXY/J/4T0Z35kDcrdQdYMWXJ3yZoZ5
   64RPkaLlFMkBREUZFO6flbubvGzpoALWahoQ8QeCQTDqgb84HNwI1LNlh
   CfAEQQWu9z8WHPpRBgILI2GpbRsPQQ3DPIXliDB8pe8D+oOo4zJmKKLKQ
   4VjSLoESI3Gl8gWMen7bpdMI+72x+uINgMHV42mOaA14Ad/P+fd8HnNiQ
   XW+pQZ1ws8h/dpF0dteqA1/zjNlHSufDboXA4uSEabV33Wcpw8rro+Ret
   hyod/98at36KmjtLJjqny2ltlFMvJeSLvtJAhVgmXJWsvtgl6XpAYwNrG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="450138553"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="450138553"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 18:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="706246439"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="706246439"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.89.232])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 18:56:38 -0700
Message-ID: <861ee3a58a52afb9e3f4001e4f25a2fd5c318618.camel@linux.intel.com>
Subject: Re: [PATCH] IIO: hid-sensor-prox: add missing scale attribute
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Date:   Tue, 17 Oct 2023 18:56:38 -0700
In-Reply-To: <20231017201116.63d54c60@jic23-huawei>
References: <20230806130558.89812-2-p.jungkamp@gmx.net>
         <cd33e36768322d4e8f7919711d3474f57c4383ff.camel@linux.intel.com>
         <trinity-2e8c2d00-be4a-4590-ae0f-265289d9256b-1691497330952@3c-app-gmx-bs40>
         <20231014175206.6b2ff811@jic23-huawei>
         <32200d0651ba77d03bad5733d8690f9f1b7b8d1a.camel@linux.intel.com>
         <20231015120448.6279430d@jic23-huawei>
         <20231016084400.79932e58@jic23-huawei>
         <7c09e707455e43d87a0e2368842c9b5b1afcf80f.camel@linux.intel.com>
         <20231017201116.63d54c60@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2023-10-17 at 20:11 +0100, Jonathan Cameron wrote:
> On Mon, 16 Oct 2023 07:28:36 -0700
> srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>=20
> > On Mon, 2023-10-16 at 08:44 +0100, Jonathan Cameron wrote:
> > > On Sun, 15 Oct 2023 12:04:48 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > > =C2=A0=20
> > > > On Sat, 14 Oct 2023 19:56:26 -0700
> > > > srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > wrote:
> > > > =C2=A0=20
> > > > > On Sat, 2023-10-14 at 17:52 +0100, Jonathan Cameron wrote:=C2=A0=
=20
> > > > > =C2=A0=20
> > > > =C2=A0=20
> >=20
> > [...]
> >=20
> > > > Phillipp, if a backport makes sense you can request that after
> > > > this
> > > > goes upstream.=C2=A0=20
> > > Whilst typing up a pull request I saw this again and thought a
> > > bit
> > > more on it.
> > >=20
> > > This fix is probably wrong approach.=C2=A0 Proximity sensors are ofte=
n
> > > scale free
> > > because they depend on reflectance off something or a capacitance
> > > changing etc
> > > so we don't know the scaling.=C2=A0 So the right response then is not
> > > to
> > > return a scale
> > > value of 1.0 but to not provide the attribute at all.=C2=A0 Is that
> > > something that
> > > could be easily done here?=C2=A0=20
> >=20
> > I think so. But hope that iio-sensor-proxy can handle absence of
> > scale
> > attribute.
> >=20
> > git diff drivers/iio/light/hid-sensor-prox.c
> > diff --git a/drivers/iio/light/hid-sensor-prox.c
> > b/drivers/iio/light/hid-sensor-prox.c
> > index a47591e1bad9..e4b81fa948f5 100644
> > --- a/drivers/iio/light/hid-sensor-prox.c
> > +++ b/drivers/iio/light/hid-sensor-prox.c
> > @@ -36,7 +36,6 @@ static const struct iio_chan_spec prox_channels[]
> > =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .type =3D IIO_PROXIMITY,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .info_mask_shared_by_type =3D
> > BIT(IIO_CHAN_INFO_OFFSET) |
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SCALE) |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_HYSTERESIS),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .scan_index =3D CHANNEL_SCAN_INDEX_PRESENCE,
> >=20
> > Thanks,
> > Srinivas
>=20
> Just to check. Are we guaranteed that there is never a scale
> parameter?
> Some proximity sensors do have absolute units (time of flight sensors
> for example).
>=20
This driver is implementing:
Biometric: Human Presence (Usage ID 0x11) from HID sensor hub
specification.

"Biometric: Human
PresenceCA,CP =E2=80=93 An application-level or physical collection that
identifies
a device that detects human presence (Boolean yes or no)."


It is not implementing Biometric: Human Proximity (Usage ID 0x12).
This has range of values, then unit will be applicable.

Thanks,
Srinivas

> Jonathan
>=20
> >=20
> > >=20
> > > For now I'm dropping the patch. Sorry I wasn't paying enough
> > > attention to notice
> > > this was a proximity sensor.
> > >=20
> > > Jonathan
> > > =C2=A0=20
> > > >=20
> > > > Thanks,
> > > >=20
> > > > Jonathan
> > > > =C2=A0=20
> > > > > >=20
> > > > > > Phillipp - this sounds like a fix to me.=C2=A0 Fixes tag?
> > > > > >=20
> > > > > > Thanks,
> > > > > >=20
> > > > > > Jonathan=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > > =C2=A0=20
> > > =C2=A0=20
> >=20
>=20

