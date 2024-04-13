Return-Path: <linux-iio+bounces-4215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06DA8A3B96
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 10:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C13B2164A
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 08:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409241D55D;
	Sat, 13 Apr 2024 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbKbnhs6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C5A1D54F
	for <linux-iio@vger.kernel.org>; Sat, 13 Apr 2024 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712995792; cv=none; b=P1Uji9v0Uex2f0yEVMbd67ZOa9Uc7zEg2dWy4z4nTq1xN8ldETT7tVAaYpHKQwNSPGh4+VF84g8QosJTKa5xqgJo2AfT2BCQ8Rys61XTL8shk4SLT0QxGLUTk9MCoeuKfgZ/34NWR32EjJcVbrYYdOiespDoLDlgun8Ho+YH4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712995792; c=relaxed/simple;
	bh=APnm7LXpcHb4ZCh332GH/q7XCNbXWuojiptOVmUTWM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8AhwWgjAPW8iIUpLluxBXBRQbRdke8v6yxwBHR3VHT0QvI/oq+8EHvFlJnxI7ubzbcPWjqZtwOqo6OcjPjSrtBnhyVh3XoX8wZycWsPzlVMtUjRHkJIJs6ZqhIPB2TE7j8uo6/O/TNK8h5XO7QfnmG21nxYicJLLhjwF+c+2Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbKbnhs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB151C113CD;
	Sat, 13 Apr 2024 08:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712995791;
	bh=APnm7LXpcHb4ZCh332GH/q7XCNbXWuojiptOVmUTWM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QbKbnhs6w2Ul5QOPh+rV/PKD0xBvj2Mq1pMz9GzYzN2lP1HJj4I0GgmMYEFOEFVWp
	 iHO3/yGEclrTeV3oFFV6rBIpCEt51jO9oo5ytESmWQbtmdd8uLDFH8wD1+HhmA7Ca2
	 V2DZCOH0tskQbf+66ygEZanz1sN8EnZCJJ00EnFzfKIUSFfbX739uPsD/a1HOJLuLJ
	 1cCk5vLJgPLOQMOZUZquVToiHgUsUMViCQ5eDs1WkfMeBfd7LWCW5nygnhl+2L8ma2
	 6CKZvBW0wgxJsLRcHAj63Ni8kTEJaT69MO9eOnf4rVuq9MX+LU2vDpA2aLoqJLG9Nk
	 la8c+LmNa+7eg==
Date: Sat, 13 Apr 2024 04:09:48 -0400
From: William Breathitt Gray <wbg@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter updates for 6.9
Message-ID: <Zho9zH489TTk4Sbq@ishi>
References: <ZeyMLe1lmfyMcrss@ishi>
 <2024041131-implicit-decipher-76f4@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pr0Plz8H+ZrC3GXq"
Content-Disposition: inline
In-Reply-To: <2024041131-implicit-decipher-76f4@gregkh>


--pr0Plz8H+ZrC3GXq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 02:45:45PM +0200, Greg KH wrote:
> On Sat, Mar 09, 2024 at 11:19:57AM -0500, William Breathitt Gray wrote:
> > The following changes since commit 6613476e225e090cc9aad49be7fa504e290d=
d33d:
> >=20
> >   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
> >=20
> > are available in the Git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/co=
unter-updates-for-6.9
>=20
> Did this ever get taken?  If so, should it be for 6.10?
>=20
> confused,
>=20
> greg k-h

Sorry, I should have submitted that sooner for the 6.9 cycle. I've
created a new tag[^1] for 6.10 that includes these commits, so please
pull that one instead.

Thanks,

William Breathitt Gray

[^1] https://lore.kernel.org/linux-iio/Zho9QUfTfT-uHptA@ishi/

--pr0Plz8H+ZrC3GXq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZho9zAAKCRC1SFbKvhIj
K80XAQDGOrZPGwqY1+6e8v28noPIeLe+rWtLRgFytZ3tlqVvmgEA35bsxVXfSyuA
LOGhgY8FqUsNTs9NEOFblijJBePxXgA=
=CoLP
-----END PGP SIGNATURE-----

--pr0Plz8H+ZrC3GXq--

