Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AF77CAB7B
	for <lists+linux-iio@lfdr.de>; Mon, 16 Oct 2023 16:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjJPO2j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Oct 2023 10:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjJPO2i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Oct 2023 10:28:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7171E9B
        for <linux-iio@vger.kernel.org>; Mon, 16 Oct 2023 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697466517; x=1729002517;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ho3QGzeQld9DlHQRvrg5sPruXbnAT9UV/5Yu7BB+aMo=;
  b=AhxE5PSYyLmp3eqEGhouLAWbBbs/eyyjbc6KnD07lyFQrYyMh0terR8x
   qYX8oQR1ouR4uqeO6vfawQ+1bz14eHB2CftYtNf53XB9QDtAEW0pBDsPr
   SKT+c12pBcPjDdFHnqFKhYD8W98uMGdaMUf7UjyYR1ske/7w00MLvVFFA
   evj/npziqAXeRJkY32A5QPXWTrRxM3Ayp9T2XUWJJGJLwYp7YCIxbSTvw
   qDxkMJuaBr4Dx6MzrHhOgJI1xGFlLLYuIqKfCQk21ZwM3escgU3E9IiVF
   9KnjbyP75OrColW0sEXOmo+ErIkgnLzY4aG3bIBdfgNx4UGpw0jCtRfxK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="382758238"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="382758238"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 07:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="3545533"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.124.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 07:27:33 -0700
Message-ID: <7c09e707455e43d87a0e2368842c9b5b1afcf80f.camel@linux.intel.com>
Subject: Re: [PATCH] IIO: hid-sensor-prox: add missing scale attribute
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Date:   Mon, 16 Oct 2023 07:28:36 -0700
In-Reply-To: <20231016084400.79932e58@jic23-huawei>
References: <20230806130558.89812-2-p.jungkamp@gmx.net>
         <cd33e36768322d4e8f7919711d3474f57c4383ff.camel@linux.intel.com>
         <trinity-2e8c2d00-be4a-4590-ae0f-265289d9256b-1691497330952@3c-app-gmx-bs40>
         <20231014175206.6b2ff811@jic23-huawei>
         <32200d0651ba77d03bad5733d8690f9f1b7b8d1a.camel@linux.intel.com>
         <20231015120448.6279430d@jic23-huawei>
         <20231016084400.79932e58@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2023-10-16 at 08:44 +0100, Jonathan Cameron wrote:
> On Sun, 15 Oct 2023 12:04:48 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Sat, 14 Oct 2023 19:56:26 -0700
> > srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > > On Sat, 2023-10-14 at 17:52 +0100, Jonathan Cameron wrote:=C2=A0=20
> > >=20
> >=20

[...]

> > Phillipp, if a backport makes sense you can request that after this
> > goes upstream.
> Whilst typing up a pull request I saw this again and thought a bit
> more on it.
>=20
> This fix is probably wrong approach.=C2=A0 Proximity sensors are often
> scale free
> because they depend on reflectance off something or a capacitance
> changing etc
> so we don't know the scaling.=C2=A0 So the right response then is not to
> return a scale
> value of 1.0 but to not provide the attribute at all.=C2=A0 Is that
> something that
> could be easily done here?

I think so. But hope that iio-sensor-proxy can handle absence of scale
attribute.

git diff drivers/iio/light/hid-sensor-prox.c
diff --git a/drivers/iio/light/hid-sensor-prox.c
b/drivers/iio/light/hid-sensor-prox.c
index a47591e1bad9..e4b81fa948f5 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -36,7 +36,6 @@ static const struct iio_chan_spec prox_channels[] =3D {
                .type =3D IIO_PROXIMITY,
                .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
                .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_OFFSET) |
-               BIT(IIO_CHAN_INFO_SCALE) |
                BIT(IIO_CHAN_INFO_SAMP_FREQ) |
                BIT(IIO_CHAN_INFO_HYSTERESIS),
                .scan_index =3D CHANNEL_SCAN_INDEX_PRESENCE,

Thanks,
Srinivas

>=20
> For now I'm dropping the patch. Sorry I wasn't paying enough
> attention to notice
> this was a proximity sensor.
>=20
> Jonathan
>=20
> >=20
> > Thanks,
> >=20
> > Jonathan
> >=20
> > > >=20
> > > > Phillipp - this sounds like a fix to me.=C2=A0 Fixes tag?
> > > >=20
> > > > Thanks,
> > > >=20
> > > > Jonathan=C2=A0=C2=A0=C2=A0=20
> > > =C2=A0=20
> >=20
>=20

