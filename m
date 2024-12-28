Return-Path: <linux-iio+bounces-13827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 798B09FDAA4
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 14:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DAA7A1528
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 13:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C79115854A;
	Sat, 28 Dec 2024 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIC/HVki"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4044A0C;
	Sat, 28 Dec 2024 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735391979; cv=none; b=AtgS9uNCaGEBeS28n9K6Y07w4RQ7GLK4Um9GFode5kRGks56FRWHXVXIcpGA5FqlHr8+PDxNgxCk/FW6gUvTo7vLdzShZ4hO7NoQiRME7H2l+25YXgBhbdQIWlqGesStc/BFa546nnByt6at9rF/XxE4RMDUD//d2G3bEJ3cTgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735391979; c=relaxed/simple;
	bh=W1gPdwZJT9/UkD+0ajbugFzfJHap13mBYnKskhDpNFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHfwmFFSU+af6QpExTLx82sTwwnrjIGSLa85LyR5e8dT2eQtjJcnxqK5PBy2puk710vJetssxoZ1zEMSP4dBUmqv32YOMfUwNGNhTntPw8C2NWEsawCSj3oW9Mp7UwBQWz0sbL8El7X1HpCtoMUoiv95Wvcsewxvx70caoTQFts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIC/HVki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12386C4CECD;
	Sat, 28 Dec 2024 13:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735391978;
	bh=W1gPdwZJT9/UkD+0ajbugFzfJHap13mBYnKskhDpNFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pIC/HVkioqgXy0cq36uM8EKD2FOsBsof9G3s3zjHJ5RNf6UvcIpTe28LECBRwZgJu
	 r+ds8eiVb1GwuKh7F8WG9es+j6G4BUFs7d7R66Z3rd41/mysefcmh7Jg4gnqyRivjX
	 JXx1IjsAFDQAA73MiyA8W+51GHZ/BkLoP9HlhXFGZsMqGa8nUNyeB5px5rHJ3NWwcp
	 09JKvlAPn6ZzPb+UZAmWIIBOgOM0NaLIxQGnJwYDz7cBXXkzj+HejrupKlzK2q0fuB
	 Ypi+kCdH0+pR2omi3cVsMNnQ7JNKUlc4Eu6CTLZ0HnQvSP7Dx+aNFOXWPRixI5WN9V
	 hgvGSEI+9BB4w==
Date: Sat, 28 Dec 2024 13:19:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "andriy.shevchenko@linux.intel.com"
 <andriy.shevchenko@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Emil
 Gedenryd <emil.gedenryd@axis.com>, Andreas Dannenberg <dannenberg@ti.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] dt-bindings: iio: light: opt3001: add compatible for
 opt3004
Message-ID: <20241228131929.49e4a90d@jic23-huawei>
In-Reply-To: <PN0P287MB2843E7005997F1728B0F9B2CFF0F2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
References: <20241227131134.10810-1-hardevsinh.palaniya@siliconsignals.io>
	<qgottqtq5lvp6fifi37xzq7supalvm7leue755yjatyun6k5um@pju4v3kqoizq>
	<PN0P287MB2843E7005997F1728B0F9B2CFF0F2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Dec 2024 10:54:33 +0000
Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io> wrote:

> Hi Krzysztof,
> =C2=A0
> > On Fri, Dec 27, 2024 at 06:41:32PM +0530, Hardevsinh Palaniya wrote: =20
> > > Add Support for OPT3004 Digital ambient light sensor (ALS) with
> > > increased angular IR rejection.
> > >
> > > The OPT3004 sensor shares the same functionality and scale range as
> > > the OPT3001. The compatible string is added with fallback support to
> > > ensure compatibility.
> > >
> > > Datasheet: https://www.ti.com/lit/gpn/opt3004
> > > Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignal=
s.io>
> > > ---
> > >
> > > v2 -> v3:
> > >
> > > - Reverse the order of compatible string
> > >
> > > v1 -> v2:
> > >
> > > - Use fallback mechanism for the OPT3004.
> > > - Drop 2/2 patch from the patch series[1] as per feedback.
> > >
> > > Link[1]: https://lore.kernel.org/linux-iio/20241224061321.6048-1-hard=
evsinh.palaniya@siliconsignals.io/T/#t =20
> >=C2=A0
> >
> > And where is any user of this, the DTS? We don't take bindings just
> > because there is such device out there.
> >
> > I looked and nothing:
> > https://lore.kernel.org/all/?q=3Dti%2Copt3004 =20
> =C2=A0
> I added compatibility for the OPT3004 into the driver. However,=C2=A0
> based on Andy's feedback, it seems there might not be a need=C2=A0
> to include this directly in the driver.=C2=A0
> (Refer to Link [1] from the changelog.)
> =C2=A0
> we could follow a similar approach to how we handled the ADXL346,
> by just adding it to the bindings, since the ADXL346 is similar to the=C2=
=A0
> ADXL345.
> =C2=A0
> If I misunderstood then please let me know.

Perhaps give some more information on the device in which this is found?
If that's a board that you plan to support upstream in the longer term
then that would provide more justification for this patch.

The note on the opt3001 page does give a hint as to how the parts are diffe=
rent
but saying the opt3004 has better IR rejection.  They also have a somewhat =
different
sensitivity curves. However, those are details we don't expose in the ABI a=
nd the
devices unhelpfully report the same ID register value, so it is not obvious=
 that
we need to treat them differently.

Jonathan

> =C2=A0
> Best Regards,
> Hardev


