Return-Path: <linux-iio+bounces-27438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E71BCEC530
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 18:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD28830124F3
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 17:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34FD29ACD1;
	Wed, 31 Dec 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVhutx06"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91534C97;
	Wed, 31 Dec 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767200910; cv=none; b=W6CrhImAfaT7vr//MA2WNdIPQnPq/M/rt9N6be7X0U1Hf0M7yIZxKUFgIJgsVGOplpSOICY3RwnLravdFVYLo7j+Ziyr2WSY73rTBM1TTTDTShLcXamY1cGCBHLV1iOSm1CeWMjec2cE0OjBFN6HtTZtbYPdfRA6DcwfVltPfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767200910; c=relaxed/simple;
	bh=PZcpK0mhuqzphPZ9SnvX2vthk11n+Ui3EKmxkT5J8tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lghrUO0DOcghvDFICSScLZOJQ+8oo+OdJ3k+BJWe8k652DuuG1EcE4p1aPU8kQ+2m5TZqF6pw6+xzc/Iem+2+1dhu8juALDdfmDymosHB3asZ3wEBlY0X3eMCrBzsWUI7YEdWWumuOTL42kEsTdrHAnTKCMjWW4h29JhBBAOIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVhutx06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF68C113D0;
	Wed, 31 Dec 2025 17:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767200910;
	bh=PZcpK0mhuqzphPZ9SnvX2vthk11n+Ui3EKmxkT5J8tQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AVhutx060HZPSMJrE6Z9wd0oZFWVsukE0L+MBnD0WXmcii86yHU/z8d6JWcNc72RF
	 AaYSBye1Xr8dDEJb3OT5TQ/V9/66VYap4c3rxqdlvImz27VjkGA4bXq5t0dPO/e8mJ
	 2UvSssq+sDGR4+4a+ti7bNKfhqDwmthadkpcXV84azY0hSHvEz861CtrimyLCwXzx2
	 /+gvnfN696eSCti0Hrg0sphMNSkU8b1WNHzIyFpaYoiSyXVBfQoDhsmZ4q79pXwqM1
	 EbVAoi8bj3kL9yw4VEeNJmocY30D0KTinjNoyMZfw+ClhANBAh+zSnGREE5ce4kauf
	 SdMds/BrtcggQ==
Date: Wed, 31 Dec 2025 17:08:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shrikant <raskar.shree97@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 heiko@sntech.de, neil.armstrong@linaro.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] iio: proximity: Add interrupt support for
 RFD77402
Message-ID: <20251231170819.0365d731@jic23-huawei>
In-Reply-To: <CAHc1_P6m11M=1bP-0k_ndgtkLtfnkSCMScznCC+HnWWQ1XtGHw@mail.gmail.com>
References: <20251221083902.134098-1-raskar.shree97@gmail.com>
	<20251227174559.33539640@jic23-huawei>
	<CAHc1_P6m11M=1bP-0k_ndgtkLtfnkSCMScznCC+HnWWQ1XtGHw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Dec 2025 00:15:43 +0530
Shrikant <raskar.shree97@gmail.com> wrote:

> On Sat, Dec 27, 2025 at 11:16=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Sun, 21 Dec 2025 14:08:58 +0530
> > Shrikant Raskar <raskar.shree97@gmail.com> wrote:
> > =20
> > > This patch series adds:
> > >  - Add RF Digital vendor prefix
> > >  - YAML binding for RFD77402
> > >  - Add OF device ID for enumeration via DT
> > >  - Use kernel helper for result polling
> > >  - Interrupt handling support
> > >
> > > These changes enable DT-based configuration and event-driven
> > > operation for the RFD77402 Time-of-Flight sensor. =20
> >
> > Hi Shrikant,
> >
> > I'm only seeing this cover letter (and lore doesn't seem
> > to have the patches either).  Probably need to resend them. =20
> Hello Jonathan,
> Apologies for the confusion. I have tried re-sending the patch
> series multiple times, but each time only the cover letter is getting
> delivered, while the individual patches do not seem to go through due
> to Gmail's daily sending limit.I haven't fully resolved the issue yet,
> but I'm trying to figure out a solution on my end. If you have
> any suggestions or best practices to avoid such delivery issues, I
> would really appreciate your guidance.
>=20
> Sorry for the inconvenience, and thank you for your patience.
> Regards,
> Shrikant

If you continue having problems, take a look at the b4 tool
and it's options for using a web gateway.=20

https://b4.docs.kernel.org/en/latest/
sending your work.

Jonathan

