Return-Path: <linux-iio+bounces-21366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE970AF9B71
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 22:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BA61C85BB7
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 20:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8147322FF2E;
	Fri,  4 Jul 2025 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hTjESYOR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3222836C
	for <linux-iio@vger.kernel.org>; Fri,  4 Jul 2025 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751659251; cv=none; b=o/0DyFnI78bgq7vhZHNqd5D+iqY3HNlJFJ86ibzXAQpodDBX6Mpc8wpe2ytS9DSXuhBCc9bum3eRDPDy77HQiy+p7CrU4ozy+Mcm9NrX9RkWooVTvwRCvI+UUHbMXRlG9GXnOsc9s2qcqWjBcp+HFG9q5EYh8A+lOUQqjjc4iJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751659251; c=relaxed/simple;
	bh=aeB4oXRcQ8OAUIyfIF7uQHmd/L4CEVP+RnGStMaB3x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWyllj3E3LHPYBK9d3LtD9KHUQYFnAL2Qy0d/v45toxOUrree1meYGmrr8l+svjtOodFfHg0h8Lp/NwLwS13w5mdL62w8lg5k7SG/roq7kSfWq888Vpazo5CxnGyByg6GKKUU0RC0zyZFFaWHKIXbuY4ELMRl58/jBopgh2zK+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hTjESYOR; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=p07v
	3z9Zd86AhBvzQSDg2PZ0BEIdAQ9soxmB8U1OvxM=; b=hTjESYORW3CClSzVaoMJ
	7ba5ISXy/Q3Qdmn5qy+3jnBk6PwLi5iNc6mnTg5Qe99AkLHzzTLDqLxli5cWmhZY
	r+JHJEWVSq/oJ2jTf+TaJb7Rf6yOo7D7KsVRHgYQVSfSCp9s3PWa3cO2pKXqomzB
	KtWVu4qcWIu4o7EB3hoa+dk0wfqBQIQ5p/Me236pZl1DOQUQdrKbzi2ihcmT6lHa
	WiIDjJnVQJ0Ba1F59d81uxmbOpW84gbO1qmQ+zIOPZbD+K9HqmiM12wsU34TZzYs
	PhH1zCBhtuGVPVZ8WXP1FNU60gLlbU57JtZCU+Bc4sDcpVa/ypUjI/WfLhtR8LTU
	rg==
Received: (qmail 255534 invoked from network); 4 Jul 2025 22:00:38 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jul 2025 22:00:38 +0200
X-UD-Smtp-Session: l3s3148p1@sOOn8h85+okujnsj
Date: Fri, 4 Jul 2025 22:00:37 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Claudiu <claudiu.beznea@tuxon.dev>, linux@armlinux.org.uk,
	gregkh@linuxfoundation.org, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, dakr@kernel.org,
	len.brown@intel.com, pavel@kernel.org, andersson@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	mathieu.poirier@linaro.org, vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	broonie@kernel.org, robh@kernel.org, jirislaby@kernel.org,
	saravanak@google.com, jic23@kernel.org, dmitry.torokhov@gmail.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
	bhelgaas@google.com, geert@linux-m68k.org,
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	fabrizio.castro.jz@renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v5 0/3] PM: domains: Detach on device_unbind_cleanup()
Message-ID: <aGgy5cLWiGcYaEYp@shikoro>
References: <20250703112708.1621607-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFoznqfdX7Dvu3VPa5Me10VHGphnRRHrU17w-fie7HrQ5g@mail.gmail.com>
 <CAJZ5v0gH9ZAK9br58KB0VEtG+4VdwO7vEKtrKbpcYOKnZPf7bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fH5YvR5XnWRLoSCZ"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gH9ZAK9br58KB0VEtG+4VdwO7vEKtrKbpcYOKnZPf7bg@mail.gmail.com>


--fH5YvR5XnWRLoSCZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > The series looks good to me, please add:
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Rafael, do you intend to pick this via your tree?
>=20
> I do in general, but I haven't looked at this version yet.  I'll get
> to it early next week.

For the I2C part:

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--fH5YvR5XnWRLoSCZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmhoMuEACgkQFA3kzBSg
KbaGFBAAm10gs13N1AdPHST1j6hXR+tNypeS5BKbZ+zmyASGICTNP4lWWXPPeQSe
DTyN4qJTJbTF4AgWp7EMST8L7TsxVTgx1Od6gb85sgGujMuKQ+veduuh7jLPl8Mm
bwaP6BdkuodLNT9jNSGxG+2R2Z9jbKKL450e7VO8AXSiF3/H2CsGY9Awatdc0Msw
i6cfmK0BXy7gyumKnAjISaGGIQxALwdbwAH0QeclCsHCtnjxB8u83FAMx/R22WDT
Mn60COq6xMPYmZNCeCy2BxxoBo2skLpLw7ksgBp+cSsJBNIRq+G4iiux1RtTPKqT
Db3aGgAdWyYy0Fxbd8avkZzQ2+Khtp18vKvSQYCxSCPxeZz/xyatLwYUUFO/kfzX
5iUk0hrrQ4VRUfTAewY0/7NDtwp042Lfo2pWclyXW43UqNl93xwSXfYCQg7aKA9s
B2iL0H8OAJIWTQhw9b7M4fXCgUaGlXrSzD8Ro8iuEKe6zyDWHBF1PufExTYq7w62
GUgYeaLYg4Cg58h23Ar0iLvjvZ6eEcieHHd5VNFH4l3mDVrrjZnVI65YBjIsveXf
7EBpNBKXISI6B94Rzcaz/dUin3ghl0tPkix/xFbweInSRxgajfnGiKk4RZ+3UtaL
WO7fI/30J3na+ki82GylH26E4ftVwez5QXv103slsdXZRwY/DdA=
=f5Md
-----END PGP SIGNATURE-----

--fH5YvR5XnWRLoSCZ--

