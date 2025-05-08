Return-Path: <linux-iio+bounces-19339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CACFAAB0353
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 21:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238331C262A2
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D26284B25;
	Thu,  8 May 2025 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seKaoui1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301A01E1E1D;
	Thu,  8 May 2025 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746731108; cv=none; b=YaBHVeBM3PBvy48fMppOSsPvkM9PY3DpTMkqb50IX2W33iG9hEOQPyiRi/OcJ6dzM1KCCOY2P5jCSaDNXUUMfhV8QYoTZZ1Isp0N2WzYOXQnTqQPfxx0qy5dUOYDAhBRZe61axn9od5QUBpIqY6D9V2LaSToOrAn4RLD0YwgGZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746731108; c=relaxed/simple;
	bh=+JAxNAl5UUAJGF52hw5wf/fhIzgv71raNX+SUGyckaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YS0/p2QUqn6X3HTuUzHIid0P3cvWn23WGJ2TmCaFMcd3X7DSdNXMgxdc1kQV6gojkdDGrQpKveJVEqv54W2Mu+t67/4gE5Y1ITc7zqaN+qbbpBkWxqrM9WERo/J2BKSQlBkZ4aDIWq9cHczxaPecXQfQbnFZFoudJSwPhi+u6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seKaoui1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C01C4CEE7;
	Thu,  8 May 2025 19:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746731107;
	bh=+JAxNAl5UUAJGF52hw5wf/fhIzgv71raNX+SUGyckaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=seKaoui1zE3H/QN3++7DkkxSHsDSoTq3I2C1dQCSYcTc/5wUute5Twg3x3S1L39Gr
	 kPmL9QyVLHlUEu3OJvnEShAORsE/LnSASqPN0/4TnCBqU1DAwhqooHOkr9sP6hkUKO
	 G4h1bbRzr2cj+oGbLbX9IuR2rN1O1+c2OeNsim57GFsB5SsL0PKrw1bK3h3x1wHwVF
	 ZfseoUV0i/5E4JltfbhZaauIXJCYs0qrjxTin7CFiznT0cLuszbRvOPbpeyLvfZX5H
	 Oh1TiByaYzOhMv5auTdCkWEqW2DGyX+5KvKxP8N3MRFH38HKkC9MZng8CEdmRcakJo
	 +Bv7TeT2fs04w==
Date: Thu, 8 May 2025 20:05:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 mazziesaccount@gmail.com, linux-iio@vger.kernel.org, Fabio Estevam
 <festevam@denx.de>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Fix scan mask subset check logic
Message-ID: <20250508200500.15a1ef28@jic23-huawei>
In-Reply-To: <CAOMZO5BPBV5CyTE1-TyutJctLHeKE0s24JxyiZF1T_xmeKuZfA@mail.gmail.com>
References: <20250429150213.2953747-1-festevam@gmail.com>
	<20250429183301.326eaacf@jic23-huawei>
	<CAOMZO5DBpF+iO4NY4-tn3ar+Ld+c=SA6W-UKN0haWmAK=4g-+g@mail.gmail.com>
	<CAOMZO5B0nxVEW1Q-a05j8f+=waAYijvBq573Ha8DNbOgF0287w@mail.gmail.com>
	<20250430141112.00004bb8@huawei.com>
	<CAOMZO5CYuv94N_8ZepH04y8ez1CAmOJOq4eim=dLGmMFoStQ3g@mail.gmail.com>
	<20250430182537.00007eab@huawei.com>
	<CAOMZO5BCLWFJ=83r0saT=NxVP0f9G-P-2QosDNGArYAtX6v5Lw@mail.gmail.com>
	<20250504180420.73b96437@jic23-huawei>
	<CAOMZO5DeMNGqpF4T7tuvBBN=i95uReSTXkj-sNW2jZTUO++5ZA@mail.gmail.com>
	<20250505161645.5bca37c5@jic23-huawei>
	<CAOMZO5BPBV5CyTE1-TyutJctLHeKE0s24JxyiZF1T_xmeKuZfA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 May 2025 10:29:47 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Hi Jonathan,
>=20
> On Mon, May 5, 2025 at 12:16=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
>=20
> > That would be perfect! If you can do it by modifying the macro as that =
is
> > going to be the simplest path to ensure there are no others even better=
. =20
>=20
> I'm sorry, but I am unsure I understood your proposal correctly.
>=20
> Do you plan to submit a formal patch?
>=20
> Thanks
>=20

I'm snowed under.  If you have the time to write one that would be great.
If not I'll get to it but not until maybe 2 weeks time.

Jonathan

