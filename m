Return-Path: <linux-iio+bounces-19884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A878AC34C7
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 15:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE5C189532A
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAB31F2380;
	Sun, 25 May 2025 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qh0ykMCE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFDA1F1524;
	Sun, 25 May 2025 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748178612; cv=none; b=FMe8FtQGOL4iOWIB88n+r6w5DrP2wG7FYsnJAgNZJmHeXbs58IKEcH4n1liWxPXLwv6nlQXM+XPsgwvEpjQqej3bgZ1BDWpbt3nvCN5x+O8Jq0LgYL+fFlFnVrjJyCIoo1icioWPwIU4oHpmXJh5LYUrq7kcQgF/Aj8CbZHtJl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748178612; c=relaxed/simple;
	bh=B3rfBSmnDxasENP82FF9YWBJj6fxCwTp8LVgBxidQD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pf0i5acKdD2q50K6du9pcyIv1Y+euyIJne0Zpa01mSFKdI3SXJknSQAWIkdLN/xq5JzoJEOPvWoXxLFEIjTYh+844NO+HxJRUYXzR/8/kseznHQAXv0ZaSbtKN0+NRyOPnQC2iJfhYKkbKbNjI3FbyGpJr685zFgyPKf7F4W4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qh0ykMCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7845C4CEEA;
	Sun, 25 May 2025 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748178611;
	bh=B3rfBSmnDxasENP82FF9YWBJj6fxCwTp8LVgBxidQD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qh0ykMCEf7n7XkeCkHYM6jkJsFE2MeoO+HwdddZevR4dcuGqCFw+wakR+t9LRJA6e
	 1d6imUcKxRfAAi80wlXIHvRqzYOqsMspmqsZ0/1506J/HpFbRZ3d/gbjye56hbdHqc
	 cStkvUsv8qXutACTA1II6JLgRqiIlmzemQKB1HqckHjoV2X6JrL+74s2THdhFqX2Tk
	 QAPB8NlWVuR2lmxPu+hxXbiHf0CkOIGFT/M0sMka9G0uhyzLyi+xmR0SkIjG/nDtMd
	 9PfcZs1Pa061kQ5raa2AHCl+egeQ4iG+g2PF2lCBmoxwi/RG/ju+d5k8OCSLmincgb
	 HHWJSDs+b6Zpw==
Date: Sun, 25 May 2025 14:10:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, linux-iio@vger.kernel.org,
 Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: max1363: Fix
 MAX1363_4X_CHANS/MAX1363_8X_CHANS[]
Message-ID: <20250525141005.626ac223@jic23-huawei>
In-Reply-To: <CAOMZO5CtcmpH6sMpHboEyP50iPG3qGAyzg+TEoR7w2-ykU44_g@mail.gmail.com>
References: <20250516173900.677821-1-festevam@gmail.com>
	<a41491e0-595a-4614-a03e-34848446a815@gmail.com>
	<CAOMZO5CtcmpH6sMpHboEyP50iPG3qGAyzg+TEoR7w2-ykU44_g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 May 2025 21:31:22 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Hi Matti,
>=20
> On Mon, May 19, 2025 at 2:01=E2=80=AFAM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>=20
> > I could argue the problem which is fixed is not related to the
> > 2718f15403fb. I'd say the problem has been the commit which introduced
> > the 'offending' masks instead. The 2718f15403fb is not fixed by this
> > change. It could help identifying the faulty releases if correct commit
> > was pointed here. =20
>=20
> Fair enough, thanks.
>=20
> I am going through this driver's history, and it looks like the masks
> have been always wrong, since the beginning.
>=20
> I was not able to point to an exact commit, though.
>=20
> Maybe I can remove the Fixes line. Jonathan?

Hmm.  I agree this one is misleading and the history
get it right complex (and depends on introduction of various devices
over time.

I'll drop the fixes tag and apply. Note this will only go upstream
after rc1.

