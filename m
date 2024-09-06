Return-Path: <linux-iio+bounces-9231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EA296EB9C
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 09:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1FA3B245C0
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 07:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDF614BF8A;
	Fri,  6 Sep 2024 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6fhoq+W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D51474CE;
	Fri,  6 Sep 2024 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725606546; cv=none; b=HxMDRJTWsNfXxrz1WG2HeFGhTKnCz2EnmEVCCV8oA7BF8+Ef+K5DvPsjoQI57kXHk1F9U1EpX6S9psA6StBfjlQPa5w0/16fd+R2fKC2MZe9c91EXIw+924CQdeIKnOQKA7o6RwwWxHFqd0pMZWOnJAYfN0viCLtbkVegoRdt8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725606546; c=relaxed/simple;
	bh=zPMcePp0RVg5/049pHJ22NBOBSQq36t+RYTT79rRCew=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mXN0Z+RGN69Gijy5wq4CHbdY6pbGswqmh5VHSZdVLsLaP1Bsyh+5sedRp12+Mpihbb0ZdZM7ZsCFuJJVkJ3+gfmjD2ZPRKmV+9iAVDglVBh/mThZte5qN0EZLySCAddcB4MSzcn1IU8U9Fwp2v1jCOOW7LVJXJ5YAYxJnvqdTBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6fhoq+W; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42c94e59b93so15082965e9.1;
        Fri, 06 Sep 2024 00:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725606542; x=1726211342; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PjooSsPaOejFzuDxwk+67dF2l9L7tjfAna01DaRuy0g=;
        b=f6fhoq+WkiXdOwYduC0JNBKcL86QBM2GNC1SYBdUsDu+LOC3u5rvkgc7BIAKWCkyMT
         kEJQddAn0NGawYm3A+Lmdfwr071jq1X9w0VE0J2kh6MEI6rCio0+UO3u8MBa3zZrJwA6
         eVxJ9LA8wDLBJc2zpB99bUgRvjD6Zt5Nt80iRZAR9Jon2qieeFVl+l5ZlyrBf4Ip5ZD5
         dnvnZoK6CWUk634PMQvzCr7F/CF01elQzKfCZRujDUQbRrmdhJoN69y/UKVC4o+ThaqI
         lSNQuBk5TbJMwt9lT1aAQ8vzWewz2m1g8GVR6qPo5KY8ANPB2F++FRj5dN6MfXDldNsK
         zudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725606542; x=1726211342;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjooSsPaOejFzuDxwk+67dF2l9L7tjfAna01DaRuy0g=;
        b=YiOq1ki8dDzFPmeIg0Uw7bCcEyvlj/fZ+HUj/yX+8TpkKA2EUODAge2g9Bq06Rkd9M
         KiQZaJT7RUCZGbdV5HvfISChZS2A2x+sLPhhzQDGqdFF20Cb/9AQ1Hm8eiFzYUFnmiij
         R60/51uobTkU260QlUM7FBobfVY9IIZRokoeK5u3A3JgtF/grhXek1oh9+L7vSyDFgXS
         1WPf56qcNr0cvIYAfL1nIqsDSyoz0r0EpDPeINvSEvZkoC0+kyXXfSdbFgA8XljQmVgE
         n097FaNyJaCs1JGcnHd2T1OC5W7WLS8ReJ2eRaM1SaQ1moI7rcBlyRZK54T1S1o2fi+d
         pYtg==
X-Forwarded-Encrypted: i=1; AJvYcCWJo9G9+ly/qJgg5oZGcF/AhYv07iI4aqJz613J+pe+WB4uLZeuVITWYjBdobOcvI4izS7KspTxi+7CRmib@vger.kernel.org, AJvYcCXuTFNPub6GZP71HKltbsoUqX03kx9ls/7VHvojNFCjbhhoOIX2sDftKjtapS9hvmqrsP+Ld3hqtRFH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/0M2sWOW0tkP//MnvPgAtCo7JiG+VkKyX4zIKFvlW4Ouq+VY
	nQdtQ5IX8KV19+e8llvunOA+/UUO0l/C6VpqGRk4vwojd8t7M1qt
X-Google-Smtp-Source: AGHT+IFRRdNUdHHxRWRmyvcaVkm4uOzoOUmx1JqInEed6ThHae8cBiaT82LQ5b6PJlmbcpZIYS78UA==
X-Received: by 2002:a05:6000:a8c:b0:374:d006:ffae with SMTP id ffacd0b85a97d-378885c04ebmr961335f8f.6.1725606540749;
        Fri, 06 Sep 2024 00:09:00 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3788ad0d9f5sm809660f8f.109.2024.09.06.00.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 00:09:00 -0700 (PDT)
Message-ID: <38cc5356fc737460f6962d6aae274e72f5b5c73d.camel@gmail.com>
Subject: Re: [PATCH v2 4/9] iio: backend adi-axi-dac: add registering of
 child fdt node
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 06 Sep 2024 09:08:59 +0200
In-Reply-To: <7bd162bb-dce8-4aff-9f56-1ab73b091a28@baylibre.com>
References: 
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-4-87d669674c00@baylibre.com>
	 <7bd162bb-dce8-4aff-9f56-1ab73b091a28@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-05 at 14:19 -0500, David Lechner wrote:
> On 9/5/24 10:17 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > Change to obtain the fdt use case as reported in the
> > adi,ad3552r.yaml file in this patchset, with the DAC device that
> > is actually using the backend set as a child node of the backend.
> >=20
> > To obtain this, registering all the child fdt nodes as platform
> > devices.
> >=20
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > Co-developed-by: David Lechner <dlechner@baylibre.com>
> > Co-developed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/dac/adi-axi-dac.c | 15 +++++++++++++++
> > =C2=A01 file changed, 15 insertions(+)
> >=20
> > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-da=
c.c
> > index cc31e1dcd1df..e883cd557b6a 100644
> > --- a/drivers/iio/dac/adi-axi-dac.c
> > +++ b/drivers/iio/dac/adi-axi-dac.c
> > @@ -783,6 +783,7 @@ static int axi_dac_probe(struct platform_device *pd=
ev)
> > =C2=A0{
> > =C2=A0	struct axi_dac_state *st;
> > =C2=A0	const struct axi_dac_info *info;
> > +	struct platform_device *child_pdev;
> > =C2=A0	void __iomem *base;
> > =C2=A0	unsigned int ver;
> > =C2=A0	struct clk *clk;
> > @@ -862,6 +863,20 @@ static int axi_dac_probe(struct platform_device *p=
dev)
> > =C2=A0		return dev_err_probe(&pdev->dev, ret,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to register iio backend\n");
> > =C2=A0
> > +	device_for_each_child_node_scoped(&pdev->dev, child) {
>=20
> This should use fwnode_for_each_available_child_node() so that it skips
> nodes with status !=3D "okay".
>=20
> Would be nice to introduce a scoped version of this function too.
>=20
> Also, if we are allowing multiple devices on the bus, the DT bindings
> need to have a reg property that is unique for each child.
>=20
> > +		struct platform_device_info pi;
> > +
> > +		memset(&pi, 0, sizeof(pi));
>=20
> struct platform_device_info pi =3D { };
>=20
> avoids the need for memset().
>=20
> > +
> > +		pi.name =3D fwnode_get_name(child);
> > +		pi.id =3D PLATFORM_DEVID_AUTO;
> > +		pi.fwnode =3D child;
>=20
> Need to have pi.parent =3D &pdev->dev;
>=20
> It could also make sense to have all of the primary bus functions
> (reg read/write, ddr enable/disable, etc.) passed here as platform
> data instead of having everything go through the IIO backend.

Note that ddr enable/disable is something that makes sense to be in the bac=
kend
anyways as it is something that exists in LVDS/CMOS interfaces that are onl=
y running
the dataplane. Bus operations like read/write could make sense but that wou=
ld mean an
interface directly between the axi-dac and the child devices (bypassing the=
 backend
or any other middle layer - maybe we could create a tiny adi-axi-bus layer =
on the IIO
topdir or any other place in IIO) which I'm not so sure (and is a bit odd).=
 OTOH,
this bus stuff goes a bit out of scope of the backend main idea/goal so yea=
h... Well,
let's see what others have to say about it but I don't dislike the idea.

>=20
> > +
> > +		child_pdev =3D platform_device_register_full(&pi);
> > +		if (IS_ERR(child_pdev))
> > +			return PTR_ERR(child_pdev);
>=20
> These devices need to be unregistered on any error return and when
> the parent device is removed.
>=20

Definitely this needs to be tested by manually unbinding the axi-dac device=
 for
example. I'm not really sure how this will look like and if there's any pro=
blem in
removing twice the same device (likely there is). The thing is that when we=
 connect a
frontend with it's backend, a devlink is created (that guarantees that the =
frontend
is removed before the backend). So, I'm fairly confident that if we add a d=
evm action
in here to unregister the child devices, by the time we unregister the chil=
d, it
should be already gone (unless driver core somehow handles this).

All of the above needs careful testing but one way out it (and since in her=
e we have
the parent - child relationship), we could add a boolean flag 'skip_devlink=
' to
'struct iio_backend_info' so that devlinks are skipped on these arrangement=
s. Or we
could automatically detect that the frontend is a child of the backend and =
skip the
link (though an explicit flag might be better).

- Nuno S=C3=A1

>=20

