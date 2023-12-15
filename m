Return-Path: <linux-iio+bounces-967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4A8814EE4
	for <lists+linux-iio@lfdr.de>; Fri, 15 Dec 2023 18:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE241F2306C
	for <lists+linux-iio@lfdr.de>; Fri, 15 Dec 2023 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070D582EC8;
	Fri, 15 Dec 2023 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzUwk+aL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E13C82ECA;
	Fri, 15 Dec 2023 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702661598; x=1734197598;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NwKPs1sHl/0sAHhRL2vq6ph7EZTS+u5I2ScffWuwONg=;
  b=AzUwk+aLsJkSvh0fL6nLxoIFa8YRwvQPGrb2gEnSxZrpeGK1kMaKlcyb
   BTcrueu+E6P5DmNOQ1LBFkNw3f/PWXkoORTp04K0jS9LO+BbyA/qzWwRP
   xKnQ59dbzCHS9I4QHPhrUBEn6yQbsSevbYs2kPgLmR6Mv4kNSyOF5C/v7
   13S/Pe7JAby2y+Q5+6AiESa88IRE/pH9kAHakb0yflKMzcs+mloXiS/9R
   1JrtM8ddOAc2xttSwyhtSgAmib+gNz0ID8eSCryXOu2vkZDuUXeIu1mvk
   ooeJ7X/0yFxMjQK+xld5knISzGfSxMeynxOm+MSILKtYOjrQAY6mvY6DX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="461766241"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="461766241"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:33:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="751003690"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="751003690"
Received: from skiddyam-mobl.amr.corp.intel.com (HELO [10.212.94.203]) ([10.212.94.203])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:33:15 -0800
Message-ID: <0500bfe6e16fe01d34363f46ca7bbef79c5e8939.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/9] Support light color temperature and chromaticity
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>, Jonathan
 Cameron <jic23@kernel.org>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
 <thomas@t-8ch.de>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, jikos@kernel.org, 
 benjamin.tissoires@redhat.com, lars@metafoo.de,
 linux-input@vger.kernel.org,  linux-iio@vger.kernel.org
Date: Fri, 15 Dec 2023 12:33:15 -0500
In-Reply-To: <d3d6fe7a-d6e1-4ea6-a8f6-2430731691b2@leemhuis.info>
References: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com>
	 <4441bd6b-01cd-4f26-bf85-bde2e1bf404e@t-8ch.de>
	 <20231210110735.52f8dc53@jic23-huawei>
	 <d3d6fe7a-d6e1-4ea6-a8f6-2430731691b2@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-15 at 11:04 +0100, Linux regression tracking (Thorsten
Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
>=20
> Thomas, Jonathan, was any progress made to resolve below regression?

A patch is posted
https://patchwork.kernel.org/project/linux-iio/patch/20231215160159.648963-=
1-srinivas.pandruvada@linux.intel.com/

Thanks,
Srinivas

>=20
> Side note: vormally I would not prod you at this time of the cycle,
> but
> with the festive season coming up I thought it would be wise to ask a
> bit earlier for a status update.
>=20
> Ciao, Thorsten
>=20
> On 10.12.23 12:07, Jonathan Cameron wrote:
> > On Thu, 7 Dec 2023 00:39:28 +0100
> > Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> wrote:
> > > On 2023-09-19 13:40:45+0530, Basavaraj Natikar wrote:
> > > > This series adds support for light color temperature and
> > > > chromaticity.
> > [...]
> > > > Basavaraj Natikar (9):
> > > > =C2=A0 iio: hid-sensor-als: Use channel index to support more hub
> > > > attributes
> > > > =C2=A0 iio: Add channel type light color temperature
> > > > =C2=A0 iio: hid-sensor-als: Add light color temperature support
> > > > =C2=A0 HID: amd_sfh: Add support for light color temperature
> > > > =C2=A0 HID: amd_sfh: Add support for SFH1.1 light color temperature
> > > > =C2=A0 iio: Add channel type for chromaticity
> > > > =C2=A0 iio: hid-sensor-als: Add light chromaticity support
> > > > =C2=A0 HID: amd_sfh: Add light chromaticity support
> > > > =C2=A0 HID: amd_sfh: Add light chromaticity for SFH1.1=C2=A0=20
> > >=20
> > > This series is breaking probing of hid-sensor-als on Framework 13
> > > AMD
> > > laptops [0].
> > > The problem is that the patches require hid-sensors-als sensors
> > > to also
> > > report chromaticity and color temparature which they don't.
> > Gah.=C2=A0 Missed that in review.=C2=A0 Sorry about that and thanks for
> > digging into
> > this.
> > >=20
> > > When I remove the 'if (ret < 0) return ret;' checks in
> > > als_parse_report() probing works and the illuminance/intensity
> > > channels
> > > that show up behave as expected.
> > > Unfortunately this still leaves behind a bunch of unusable
> > > channels.
> > > A nice fix would be to have something like sysfs/hwmon
> > > .is_visible()
> > > callback but that's not supported by IIO.
> >=20
> > It's tricky to do because there is no simple association between
> > what is registered as channels and the resulting attribute.=C2=A0 We
> > could probably
> > make it work, but not a simple thing to do.
> >=20
> > >=20
> > > One aproach would be to detect the usable channels in
> > > als_parse_report()
> > > and then adapt the indio_dev->channels based on that information.
> > >=20
> > > [0] https://bugzilla.kernel.org/show_bug.cgi?id=3D218223
> >=20
> > Agreed that adapting the channels is the way to go.
> > Easiest option probably to set the relevant masks to 0 if the
> > chromacity and
> > temp channels aren't there + set their scan index values to -1.
> > That 'should' suppress any attributes being created.
> > Having a gap in scan indexes is common anyway so any userspace
> > should cope
> > with the timestamp being after a gap.
> >=20
> > Alternatives would be to rebuild the chan_spec array to not have
> > the entries,
> > or pass in and fill in two copies of the array, picking the
> > relevant one only
> > on discovering if the temp and chromacity channels are present.
> >=20
> > Jonathan
> >=20
> > >=20
> > > #regzbot introduced: 5f05285df691b1e82108eead7165feae238c95ef
> > > #regzbot monitor:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D218223
> > >=20
> >=20
> >=20
> >=20


