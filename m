Return-Path: <linux-iio+bounces-11966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E2C9BFF00
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 08:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C041C2129E
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 07:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9681819539F;
	Thu,  7 Nov 2024 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfkzgtGm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5441A194A64
	for <linux-iio@vger.kernel.org>; Thu,  7 Nov 2024 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730964083; cv=none; b=FcYIjZ3FHRRgWmisLCIo4M/i4CzH6kUVCEfaDCJAz5k3lmoLPNLfkWru37+mmRctn+l/KIEh7D5ah7OvJz1qN7n9ESzD7NS/kEOIENJ1891IA/vHvm9JFpwgL5g3mExqGulM7Gs4kecNaokIDnn75MIS7XY4b1Z2HSi2ORrWp3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730964083; c=relaxed/simple;
	bh=pTBSmNq4iTQyovCxlkx1Ns1i3WA3Q1nqJCw+0KF0WCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avITNuQd+J2CYwmAYMJIH8KVz4P+PYpXRoC5+2rL8gTtYwlUj+R7RE3EcKgrZnUpf4t1VEVdMkjH0moxFiGEW3LIt4tw8kI7YyOEdwmGdYfzbUQjx3tlhqsEjVAVuyZxhl/B1G2+nlzw5Mih6bC3wkyvx1QuED2LJoDPRQj33OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfkzgtGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA0CC4CECC;
	Thu,  7 Nov 2024 07:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730964083;
	bh=pTBSmNq4iTQyovCxlkx1Ns1i3WA3Q1nqJCw+0KF0WCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfkzgtGm3JBja2dd7g2Z30mNO/h3IoWG000tSlrUNZc+Q2aG+aTJ7vD8z3R/5tpCk
	 mZRJ+7MZJnu7bfBtBI+G/+9SDvWnGZ1EbyxYEUgt+N/DZJ0ZXMjQ0SovDFMSDt0s5o
	 HwqmRpyRTtU0OARyKotCPwJxaln1aQ3j5Cv1K0HauX68ouvdvS/f5XXIPV1/cnqcRD
	 PgaK7udKUX/eBQN2ypWwAA0ZePj7CLeBAVEMXl7PVJBpN0WuEs0rBuSgbMUVZLSkNX
	 SA93Y4rm5sbcjbtoVFPEQBSR3s6iosWdR6yMECFwTI724TNYJHNQEM+/7A+JbBH93i
	 g0AQtMd8A5LmQ==
Date: Thu, 7 Nov 2024 16:21:17 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter fixes for 6.12
Message-ID: <ZyxqbT7gnZ1Onf3v@ishi>
References: <ZyxmZi-xVcDV4lVL@ishi>
 <2024110757-armband-carmaker-f8f4@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OyhvFZsF8odUJs9z"
Content-Disposition: inline
In-Reply-To: <2024110757-armband-carmaker-f8f4@gregkh>


--OyhvFZsF8odUJs9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2024 at 08:08:50AM +0100, Greg KH wrote:
> On Thu, Nov 07, 2024 at 04:04:06PM +0900, William Breathitt Gray wrote:
> > The following changes since commit 9852d85ec9d492ebef56dc5f229416c92575=
8edc:
> >=20
> >   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
> >=20
> > are available in the Git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/co=
unter-fixes-for-6.12
> >=20
> > for you to fetch changes up to 1437d9f1c56fce9c24e566508bce1d218dd5497a:
> >=20
> >   counter: ti-ecap-capture: Add check for clk_enable() (2024-11-05 09:2=
0:11 +0900)
> >=20
> > ----------------------------------------------------------------
> > Counter fixes for 6.12
> >=20
> > Fix device_node handling in stm32-timer-cnt by calling required
> > of_node_put() after device node is no longer needed. Check and handle
> > clk_enable() failures in stm32-timer-cnt and ti-ecap-capture.
> >=20
> > Signed-off-by: William Breathitt Gray <wbg@kernel.org>
>=20
> Can these wait for 6.13-rc1?  I'd like to not have to send another pull
> request for this tree for 6.12-final if at all possible.  But if these
> are issues that people are hitting now, I'll be glad to do so.
>=20
> thanks,
>=20
> greg k-h

Sure, these would probably be fine going in for 6.13-rc1 instead. These
issues are theoretical but I'm not aware of them being active problems
for people currently.

Thanks,

William Breathitt Gray

--OyhvFZsF8odUJs9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZyxqbQAKCRC1SFbKvhIj
K5FdAQDk9INpFAY48qKX/L76FxLmx8Npx33jN6d58/6iVmn6oAD+Mg5Ho6eAlDRH
CYzKr0jHVzChZQ/8AmDoXJwB8pJtDgQ=
=kKfR
-----END PGP SIGNATURE-----

--OyhvFZsF8odUJs9z--

