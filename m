Return-Path: <linux-iio+bounces-14365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D7CA10D35
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 18:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C78161C76
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 17:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555C01D5143;
	Tue, 14 Jan 2025 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhNF4xkg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BBB1B21AD;
	Tue, 14 Jan 2025 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874777; cv=none; b=Tl6+1sD/zd/LDeoTwkcK23OCl2PDP9X3Tp6pPG9f2KH8EO4UQyWhTlMK1/bXrvSLKW4jctHfefC45QxEINmSreWTE3y5nTy05SyvujyVjrRtsBD1zuX6W2/XYhhovAFl4fjvL7uVwQlKy9FvsvNSvx6jgJ9W0o0+D9vK+BdcwZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874777; c=relaxed/simple;
	bh=nxEW5S/T8AqZBEPbTm9NV2ETEBrvK93Xp4DbfoXBKe8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FKT5MGFInilGidu2qkkr4i27upme+z0sG/AH/x3VS7WpzOU9ubvvtiNgSVoCfi0uBzvuL4c06NcDtW6dGdF8U2P2JnMcOLWxrNhFoKfIc24l2Vn7ndvhx/HT/SjYzhYHawRS4NCGem4BO+H3pUzzCymygnvT+Xxl8rPuhrh8ECY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhNF4xkg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736874775; x=1768410775;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=nxEW5S/T8AqZBEPbTm9NV2ETEBrvK93Xp4DbfoXBKe8=;
  b=WhNF4xkgOuiN63UETKrmUvu0XzkoT9F/Vl0C8eOvyrJEdpINvd6tjXUO
   ThjtG5E3U+DmqJwQ3gP1dSzoW43hRzDl/fxy2kJov75mwEOrOEZmEhV5c
   bFc2h9rty0zQYhrZJLdmIfLtYxDANwy5l3LnywrhJ3z9GbKiNb+/eSUe6
   QF50o9IVy7VgBqOhfr8/O3oFlfPl9K/WNQM1yOgUoWZkzopBWtaAhBNjU
   rLMAIySah2jsaH0pFO856mcam/IpCLzIGKZMnTg8CuG7UZkEIjpXEMtrw
   wkzn4t1mDEcsAWHiMlrNwZ/w9+/Tm779VNtohUYzyfVMRz2oml2juFTSp
   w==;
X-CSE-ConnectionGUID: 1ZqzPjh4Q9yYxdQP4DMbvA==
X-CSE-MsgGUID: rwOMn6NmSemDYSV3vp/GBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="47847177"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="47847177"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:12:54 -0800
X-CSE-ConnectionGUID: mnv0C+v0RjyKAfeR7pC95w==
X-CSE-MsgGUID: fD9Dh3IjQz23XLuNzPhjoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142143325"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:12:54 -0800
Message-ID: <9929d10e1d61f63e4fe461eea9efc42eb91fa44a.camel@linux.intel.com>
Subject: Re: [PATCH v2] iio: hid-sensor-attributes: validate sensitivity
 attributes
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, Jonathan Cameron
	 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Peter Zijlstra
	 <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina
	 <jikos@kernel.org>
Date: Tue, 14 Jan 2025 09:12:54 -0800
In-Reply-To: <75131fa5a35f8ffae23087aa19c8a8238f381d4d.camel@linux.intel.com>
References: <20250114070227.1778298-1-acelan.kao@canonical.com>
	 <75131fa5a35f8ffae23087aa19c8a8238f381d4d.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-01-14 at 05:28 -0800, srinivas pandruvada wrote:
> On Tue, 2025-01-14 at 15:02 +0800, Chia-Lin Kao (AceLan) wrote:
> > An invalid sensor device was observed in HP 5MP Camera (USB ID
> > 0408:5473)
> > which provided valid index and report_ids for poll, report_state
> > and
> > power_state attributes, but had invalid report_latency,
> > sensitivity,
> > and
> > timestamp attributes. This would cause the system to hang when
> > using
> > iio_info to access attributes, as runtime PM tried to wake up an
> > unresponsive sensor.
> >=20
> > Fix this by validating both sensitivity.index and
> > sensitivity_rel.index
> > during sensor probe. Since valid sensors must initialize these with
> > non-negative values, reject the sensor if either index is negative.
> >=20
>=20
> These are optional fields by spec. So we can't reject sensor. I worry
> that this will cause more regressions.
>=20
> We will need a blocked list. We don't process "Persistent Unique ID"
> or
> "Sensor Manufacturer/Model". Please check if the report descriptors
> have any of these fields described in section 1.5 of spec.
>=20
> >=20
We probably may not be able to read the above features, I suggest add
this device Vendor=3D0408 ProdID=3D5473=20
hid_ignore_list[].

Thanks,
Srinivas



> > [=C2=A0=C2=A0=C2=A0 2.594565] [453] hid-sensor-hub 0003:0408:5473.0003:=
 Report
> > latency attributes: ffffffff:ffffffff
> > [=C2=A0=C2=A0=C2=A0 2.594573] [453] hid-sensor-hub 0003:0408:5473.0003:=
 common
> > attributes: 5:1, 2:1, 3:1 ffffffff:ffffffff ffffffff:ffffffff
> > [=C2=A0=C2=A0=C2=A0 2.595485] [453] hid-sensor-hub 0003:0408:5473.0003:=
 Report
> > latency attributes: ffffffff:ffffffff
> > [=C2=A0=C2=A0=C2=A0 2.595492] [453] hid-sensor-hub 0003:0408:5473.0003:=
 common
> > attributes: 5:11, 3:11, 1:11 ffffffff:ffffffff ffffffff:ffffffff
> >=20
> > T:=C2=A0 Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D03 Cnt=3D01 Dev#=3D=C2=A0 2=
 Spd=3D480=C2=A0 MxCh=3D 0
> > D:=C2=A0 Ver=3D 2.01 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=
=3D=C2=A0 1
> > P:=C2=A0 Vendor=3D0408 ProdID=3D5473 Rev=3D00.07
> > S:=C2=A0 Manufacturer=3DQuanta
> > S:=C2=A0 Product=3DHP 5MP Camera
> > S:=C2=A0 SerialNumber=3D01.00.00
> > C:=C2=A0 #Ifs=3D 6 Cfg#=3D 1 Atr=3Da0 MxPwr=3D500mA
> > I:=C2=A0 If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D0e(video) Sub=3D01 Prot=3D01
> > Driver=3Duvcvideo
> > E:=C2=A0 Ad=3D87(I) Atr=3D03(Int.) MxPS=3D=C2=A0 16 Ivl=3D16ms
> > I:=C2=A0 If#=3D 1 Alt=3D 0 #EPs=3D 0 Cls=3D0e(video) Sub=3D02 Prot=3D01
> > Driver=3Duvcvideo
> > I:=C2=A0 If#=3D 2 Alt=3D 0 #EPs=3D 1 Cls=3D0e(video) Sub=3D01 Prot=3D01
> > Driver=3Duvcvideo
> > E:=C2=A0 Ad=3D85(I) Atr=3D03(Int.) MxPS=3D=C2=A0 16 Ivl=3D16ms
> > I:=C2=A0 If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3D0e(video) Sub=3D02 Prot=3D01
> > Driver=3Duvcvideo
> > I:=C2=A0 If#=3D 4 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID=C2=A0 ) Sub=3D00 Prot=
=3D00
> > Driver=3Dusbhid
> > E:=C2=A0 Ad=3D84(I) Atr=3D03(Int.) MxPS=3D=C2=A0 64 Ivl=3D16ms
> > I:=C2=A0 If#=3D 5 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D01
> > Driver=3D(none)
> >=20
> > v2. add fixes tag and the device info
> These change description goes below "---" line.
>=20
> Thanks,
> Srinivas
>=20
> >=20
> > Fixes: bba6d9e47f3e ("iio: hid-sensor-attributes: Fix sensor
> > property
> > setting failure.")
> > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> > ---
> > =C2=A0.../hid-sensors/hid-sensor-attributes.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 23 +++++++++++----
> > --
> > --
> > =C2=A01 file changed, 14 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > index ad1882f608c0..b7ffd97e6c56 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > @@ -564,8 +564,21 @@ int hid_sensor_parse_common_attributes(struct
> > hid_sensor_hub_device *hsdev,
> > =C2=A0	} else
> > =C2=A0		st->timestamp_ns_scale =3D 1000000000;
> > =C2=A0
> > +	ret =3D 0;
> > +	if (st->sensitivity.index < 0 || st->sensitivity_rel.index
> > <
> > 0) {
> > +		ret =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > =C2=A0	hid_sensor_get_report_latency_info(hsdev, usage_id, st);
> > =C2=A0
> > +	ret =3D sensor_hub_get_feature(hsdev,
> > +				st->power_state.report_id,
> > +				st->power_state.index,
> > sizeof(value), &value);
> > +	if (value < 0)
> > +		ret =3D -EINVAL;
> > +
> > +out:
> > =C2=A0	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x,
> > %x:%x
> > %x:%x %x:%x\n",
> > =C2=A0		st->poll.index, st->poll.report_id,
> > =C2=A0		st->report_state.index, st-
> > >report_state.report_id,
> > @@ -573,15 +586,7 @@ int hid_sensor_parse_common_attributes(struct
> > hid_sensor_hub_device *hsdev,
> > =C2=A0		st->sensitivity.index, st->sensitivity.report_id,
> > =C2=A0		timestamp.index, timestamp.report_id);
> > =C2=A0
> > -	ret =3D sensor_hub_get_feature(hsdev,
> > -				st->power_state.report_id,
> > -				st->power_state.index,
> > sizeof(value), &value);
> > -	if (ret < 0)
> > -		return ret;
> > -	if (value < 0)
> > -		return -EINVAL;
> > -
> > -	return 0;
> > +	return ret;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, "IIO_HID");
> > =C2=A0
>=20


