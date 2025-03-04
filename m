Return-Path: <linux-iio+bounces-16334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E899A4DD27
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 12:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9A5189B135
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 11:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECB920371A;
	Tue,  4 Mar 2025 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBuL8Bq3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C005E201256;
	Tue,  4 Mar 2025 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089281; cv=none; b=KI352r0hdU0x00nEHNb2WO2YjEyzG28XHxSDxPxzsFlH5xa9XCJ7+21y95veC9wc6bwbn2MdYni92DyT1nscXn5++oHD2Yzl1E7ySdH8cx6WtQ08jVHJYfYet6OFmShKCSKisNVCOpV75/m5oqO0syuW68PzXWxKjCJ4r43DVRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089281; c=relaxed/simple;
	bh=LUW0zHkOVQAa4MQP7h10oZ7A6fUqsf4kB4qq0+a2HpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHwWir7/va7luyyZhiMh+PC8swx40sbFEs8nXXkyxNC3zM3fLxtD0vXyTk3613ieLXmklkJET4ujfpdS31LOKnH2LyOcW1wJ43e17L8N4lbZRF9nQqMLzlWW/sbMWdeIhD7t+ASq9pMxMyBiesWF8ua8roZLBPBVedS0vn/MLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBuL8Bq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD18C4CEE5;
	Tue,  4 Mar 2025 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741089281;
	bh=LUW0zHkOVQAa4MQP7h10oZ7A6fUqsf4kB4qq0+a2HpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UBuL8Bq3Ngmn7f9GkjwYnrGI3+hvjmRyN4OGiX4QFdcJjtfdTmadnOaPjdQWvhLQw
	 yFgeYHdBjhx50aJzlU+7ezQ0PKP7x0dsxm8CAbXmP8K/8OnH8iQS+FpJQy/eQw/qMN
	 LLM1isF0KKEOP7Qzjfr/kyJASPoHfdNbx0P9iIPvhEHuT+Ole4PYLq9p953JBLpn/r
	 7609wHlkdZ8RnjwynHDqTh+rgng/cWn5VsMaLJyRiRo0UEq8DSqPZ8cE6YcGM/0m/2
	 ZOu/WbkYkocbVWFAul8WFI4kzUe4WRxZfEJdt2NPPKqMcoeZrpbbT2gfQy8PzxUrBo
	 ioI4/5jLpRudA==
Date: Tue, 4 Mar 2025 20:54:37 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v6 1/3] include: uapi: counter: Add
 microchip-tcb-capture.h
Message-ID: <Z8bp_RJSPSXOLV5C@ishi>
References: <20250227144023.64530-1-csokas.bence@prolan.hu>
 <20250227144023.64530-2-csokas.bence@prolan.hu>
 <Z8bNFjh85p2jqK9C@ishi>
 <8cf056d7-22d0-4bf2-8dd6-79a45977bfc1@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HCA7+K3tzLJF8OJn"
Content-Disposition: inline
In-Reply-To: <8cf056d7-22d0-4bf2-8dd6-79a45977bfc1@prolan.hu>


--HCA7+K3tzLJF8OJn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 12:14:04PM +0100, Cs=F3k=E1s Bence wrote:
> Hi,
>=20
> On 2025. 03. 04. 10:51, William Breathitt Gray wrote:
> > On Thu, Feb 27, 2025 at 03:40:18PM +0100, Bence Cs=F3k=E1s wrote:
> > > Add UAPI header for the microchip-tcb-capture.c driver.
> > > This header will hold the various event channels, component numbers e=
tc.
> > > used by this driver.
> > >=20
> > > Signed-off-by: Bence Cs=F3k=E1s <csokas.bence@prolan.hu>
> >=20
> > Oops, I almost missed this one! Make sure I'm included in the To field
> > for the next revision. ;-)
> >=20
> > By the way, b4 is a nifty tool that can save you some work and help you
> > prep patch series for submission.[^1]
>=20
> Yes, I have considered it, but unfortunately it still has quite a few bug=
s,
> for example [1], which has mangled my tags before, when a maintainer using
> it tried to apply one of my patches with it.
>=20
> [1] https://github.com/mricon/b4/issues/52

Oh that is unfortunate, you'll have to continue submitting manually for
now until those bugs are fixed. :-(

> > > +/*
> > > + * The driver defines the following components:
> > > + *
> > > + * Count 0
> > > + * \__  Synapse 0 -- Signal 0 (Channel A, i.e. TIOA)
> > > + * \__  Synapse 1 -- Signal 1 (Channel B, i.e. TIOB)
> > > + */
> > > +
> > > +enum counter_mchp_signals {
> > > +	COUNTER_MCHP_SIG_TIOA,
> > > +	COUNTER_MCHP_SIG_TIOB,
> > > +};
> >=20
> > Are these meant to be used to identify the Signals in the
> > microchip-tcb-capture.c file. You should set the the counter_signal id
> > members to these enum constants then. However, this enum doesn't need to
> > be exposed to userspace in that case.
>=20
> The thought was to let userspace figure out which
> `signal%d_action_component_id` to read, but now I see that this is not the
> way to go.
>=20
> > If that is the only purpose of enum counter_mchp_signals, then we can
> > omit this patch from the series and you won't need to send it in the
> > next revision.
>=20
> Alright, I'll drop this enum. Then this header will be empty at the start,
> save for the block comment. I hope that will be alright.

No, it'll better to drop this patch and introduce the header in the IRQ
handling patch. You can merge the MAINTAINERS change there as well.

William Breathitt Gray

--HCA7+K3tzLJF8OJn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ8bp/QAKCRC1SFbKvhIj
K/3JAP4s2rB+FgZXHuQec3IkwA03zPOiw3XbhpvrtKIxRAv6zAEApHotPB/FA3ig
swg7lg9VXcf6u25HL0rGvfjLYWmFxww=
=mlmk
-----END PGP SIGNATURE-----

--HCA7+K3tzLJF8OJn--

