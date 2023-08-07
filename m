Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F85773358
	for <lists+linux-iio@lfdr.de>; Tue,  8 Aug 2023 01:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjHGXFC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Aug 2023 19:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHGXFB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Aug 2023 19:05:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4474210F5
        for <linux-iio@vger.kernel.org>; Mon,  7 Aug 2023 16:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691449467; x=1722985467;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=eXyDe8EOkQg0xl/j51XOnUi5YYlxigcMMFZi82nK8Rg=;
  b=jpc2YUvPc9JEq+96Pslg24WVTYuxFSiAwDXZmwRTmLkQYCIBBlRl7OjM
   LmvmwSK7f9Nw15Pah13RMwxY9zbYMctXsDKQMIxzex/VuNSGWswferItf
   biAYoS1IVcdm/K6XJaP8jL4Th77zoq3iQebShUFkzCrdHA3PYQ7ZeJX+G
   dwSU/0j4QHqBWXygUVve2q3Zj/LKxTdaMDtQc3jjWoBWofmxbtwziBeTe
   /6A9TWGjtNby27RBty+emm4JtW4R/qZHpzsc8LHK01Q0ALPWZA1s+OO6Y
   gUlPLXDgWQ1q09ffUhqPs0ShieVG2Qpvv6i3UdlYPw7/DjIBiRq0FwtTd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401629546"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="401629546"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 16:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="734266762"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="734266762"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 16:02:01 -0700
Message-ID: <cd33e36768322d4e8f7919711d3474f57c4383ff.camel@linux.intel.com>
Subject: Re: [PATCH] IIO: hid-sensor-prox: add missing scale attribute
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org
Date:   Mon, 07 Aug 2023 16:02:01 -0700
In-Reply-To: <20230806130558.89812-2-p.jungkamp@gmx.net>
References: <20230806130558.89812-2-p.jungkamp@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On Sun, 2023-08-06 at 14:59 +0200, Philipp Jungkamp wrote:
> The hid-sensor-prox returned an empty string on sysfs
> in_proximity_scale
> read. This is due to the the driver's scale never being initialized.

What is scale value reporting here? Is it 1.

Thanks,
Srinivas

>=20
> Try to query the scale of the HID sensor using
> hid_sensor_format_scale.
>=20
> Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
> ---
> Hello,
>=20
> up until now I've used the sensor directly through the buffered IIO
> interface,
> ignoring the in_proximity_scale attribute. But while integrating it
> with
> iio-sensor-proxy I noticed that a read on scale return an empty
> string,
> breaking the code there.
>=20
> Looking at the code in `hid-sensor-prox.c` it is fairly obvious that
> the scale
> just wasn't being initialized. I now added the
> hid_sensor_format_scale call
> similar to the ones found in e.g. `hid-sensor-als.c`.
>=20
> Regards,
> Philipp Jungkamp
>=20
> =C2=A0drivers/iio/light/hid-sensor-prox.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/iio/light/hid-sensor-prox.c
> b/drivers/iio/light/hid-sensor-prox.c
> index a47591e1bad9..aaf2ce6ed52c 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -227,6 +227,9 @@ static int prox_parse_report(struct
> platform_device *pdev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_dbg(&pdev->dev, "prox=
 %x:%x\n", st->prox_attr.index,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st-=
>prox_attr.report_id);
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st->scale_precision =3D hid_se=
nsor_format_scale(usage_id, &st-
> >prox_attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&st->scale_pre_decml, &st-
> >scale_post_decml);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> =C2=A0}
>=20
> --
> 2.41.0
>=20

