Return-Path: <linux-iio+bounces-9246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182F396F5DA
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 15:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377421C23EAC
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 13:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778FE1D0147;
	Fri,  6 Sep 2024 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFE9GxAH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1921CF7AD;
	Fri,  6 Sep 2024 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630737; cv=none; b=UF7BQZXxzzJKDSTcSVF3Wqh9uZiStQo72YDRFsTTRiBhjdUACqc0ThHymxZp4DFJcp6pX1koJsEQV37URAA/T4cXroZb2iTjsDOsgaP+JOjv+Dfq9NSCZEEPfHwvhu8srK1cz1dU/LQ5IFduOP0Iiae9FGu0npMYPjTvMZLs7Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630737; c=relaxed/simple;
	bh=S0Q8JR94MyDcaz7CYB4dhMAmtdWKDfnBT3Z81yQL2wA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qOCywNMAoejT8i/nP2jmewH3epQwxS7r75/++wFveA9zww7GhSvvZi7xcIcK2PzNtKkvx5D/uDaDVDghR3AmmF+i8ayRAwST1cNI417nvS8cVb6SA6FN8gly9+pDllB7+xJVcrRsTxNgGTIZdjEdcHjCwDuTWbDhMu6UFnN0TIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFE9GxAH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bbd16fcf2so16775725e9.2;
        Fri, 06 Sep 2024 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725630734; x=1726235534; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S0Q8JR94MyDcaz7CYB4dhMAmtdWKDfnBT3Z81yQL2wA=;
        b=gFE9GxAHsODeUt5tbFGwYih5gRWIo+Lqk4BnUTCh5YNYFLr2YqQ34457G2kEcPmlws
         CIjsdl9JBR0r2y3qeDry2DOKOO/8Xz/Dq99FHcs2Uorx6SeUXoSegHxHEMc3A0UfAC7N
         l/JKz+AuxyhC97ezzE0hfFNWLGeMt5AZ4qFJWAOE2DjDe3nJIV6fWp5cou4S790uKU0g
         Rt1HkBjdRvVP6B9CGQR+L7+sAxXmQhCmDLgyxuubgHzeZG7A0x5nVIpusRZ66pfmy87d
         7nuWiW6s6WAK/gDu/mcFNx1qB9WyRsKrQfD0xYxXY2alm6sNdxAoyB+52a70YpFStOec
         RADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725630734; x=1726235534;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0Q8JR94MyDcaz7CYB4dhMAmtdWKDfnBT3Z81yQL2wA=;
        b=UnhygmS4ifrqmfecCI+U+K6P7h/pxnG0obxus1yWreeKy3jeLwSSwA2lWozLnlGiEw
         5OninKkjOEDc8JG0z7kbevsKLXnq/yK3E9PjxzmzByx9lG1M6cmiO9ClKMSJjoxWTC15
         mEs2wgWWzZF29x3/XminR+mNvHskfeORxYcyhHTTukfl4VaRWbhZcv2qktfMUKxAVNpW
         FnxmLT7JXwz9bCHaKx/Mjfl5g1JpbR6GI7fHXoeGfg9grvf5NJzcs9KJa3desaIancu3
         tibt2+GcVtYUhL/U5vObsgrHN0XqliQfKFPTxsywMp0S/mnZv/0kv8cZrFhP3SV3dgMY
         A2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCV8hjv8LrCRAJauK4RBaOQFm7zDCwPqwm3T40EeQuJ+9IPRatZMsnFMmgYSof8JUHVkDLzf0psyMQ38@vger.kernel.org, AJvYcCVXvaf2MNANiMzNiT+poWOTrE639ZK7sGi6s1Zh2iNsCqXtc52dNoan/96nJDYS2CjiTxtd7ofeyjh/lJby@vger.kernel.org, AJvYcCWcrCVLo9hG5lwE5YVi8Z+0EBo0mIMPoUzOYx4EWBBSn/OBoLlKU0QGYz1Uz2mc56Jc6i4liUXXRL0T@vger.kernel.org
X-Gm-Message-State: AOJu0YzlU09D5yYrDQMyhGThxM7N4zjJd7T1sFpBDUuNPjQTK8kpN09C
	3qn5GWZ7txEStX21zMNj+bMviGgFaS73OLQPNCDrLqGPw3dYu1LB
X-Google-Smtp-Source: AGHT+IFDzY0NEQxWdWS+sq1QyhvJBJJ6m28agyKpNYCXbv7XXUddq0XrknI6nMQFQ8fH+yn3j/yB6Q==
X-Received: by 2002:a05:6000:541:b0:371:8db9:939e with SMTP id ffacd0b85a97d-3749b586c9cmr18129332f8f.51.1725630732736;
        Fri, 06 Sep 2024 06:52:12 -0700 (PDT)
Received: from ?IPv6:2001:a61:341e:1201:c434:b5b1:98a6:efed? ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374bfbfc7b7sm16805768f8f.88.2024.09.06.06.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:52:11 -0700 (PDT)
Message-ID: <a0d213442b4de0b06991be2be1d7b2bb091f2b52.camel@gmail.com>
Subject: Re: [PATCH v2 5/9] dt-bindings: iio: dac: add ad3552r axi-dac
 compatible
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Angelo Dureghello
	 <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Sep 2024 15:52:10 +0200
In-Reply-To: <47c56239-51a0-4ff2-9db2-0e0184cfb086@kernel.org>
References: 
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-5-87d669674c00@baylibre.com>
	 <boahpvyzzmocnnpae2u6meub34yvqr2q3v5pzf2egp2fretlwk@ibas62hdypwo>
	 <fd3f4874-b410-4e98-acba-d0fac041a40e@baylibre.com>
	 <1928d0ce-cad9-4737-880e-3759c47fddbc@kernel.org>
	 <058937fa93d484f3e81807d08a39bd8dfd3358e8.camel@gmail.com>
	 <47c56239-51a0-4ff2-9db2-0e0184cfb086@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-06 at 14:13 +0200, Krzysztof Kozlowski wrote:
> On 06/09/2024 13:53, Nuno S=C3=A1 wrote:
> > On Fri, 2024-09-06 at 11:37 +0200, Krzysztof Kozlowski wrote:
> > > On 06/09/2024 11:11, Angelo Dureghello wrote:
> > > > Hi Krzysztof,
> > > >=20
> > > > On 06/09/24 9:22 AM, Krzysztof Kozlowski wrote:
> > > > > On Thu, Sep 05, 2024 at 05:17:35PM +0200, Angelo Dureghello wrote=
:
> > > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > >=20
> > > > > > Add a new compatible for the ad3552r variant of the generic DAC=
 IP.
> > > > > >=20
> > > > > > The ad3552r DAC IP variant is very similar to the generic DAC I=
P,
> > > > > > register map is the same, but some register fields are specific=
 to
> > > > > > this IP, and also, a DDR QSPI bus has been included in the IP.
> > > > > >=20
> > > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > > ---
> > > > > > =C2=A0 Documentation/devicetree/bindings/iio/dac/adi,axi-dac.ya=
ml | 1 +
> > > > > > =C2=A0 1 file changed, 1 insertion(+)
> > > > > >=20
> > > > > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-=
dac.yaml
> > > > > > b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > > > index a55e9bfc66d7..c0cccb7a99a4 100644
> > > > > > --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yam=
l
> > > > > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yam=
l
> > > > > > @@ -24,6 +24,7 @@ properties:
> > > > > > =C2=A0=C2=A0=C2=A0 compatible:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,axi-dac-9.1.b
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,axi-dac-ad3552r
> > > > > I am sorry, but what is the product here? It looks like either wr=
ong
> > > > > order or even completely redundant. What is ad3552r?
> > > > >=20
> > > > > And why versions are mixed with real products but without any
> > > > > compatibility. What does the version express in such case?
> > > >=20
> > > > dac-ad3552r IP (fpga) is a variant of the dac IP, very similar,
> > > > about the version, it still reads as 9.1.b
> > > >=20
> > > > so i can eventually change it to:
> > > >=20
> > > > adi,axi-dac-ad3552-9.1.b
> > > >=20
> > > > Should be more correct.
> > >=20
> > > No. First ad3552r is the product, so axi-dac is redundant. Second why
> > > adding versions if you have product names? Versioning was allowed
> > > because apparently that's how these are called, but now it turns out =
it
> > > is not version but names.
> > >=20
> >=20
> > Let me try to explain on how this whole thing works...
> >=20
> > We have a generic FPGA IP called axi-dac (same story is true for the ot=
her axi-
> > adc
> > IP) which adds some basic and generic capabilities like DDS (Direct dig=
ital
> > synthesis) and the generic one is the compatible existing now. This IP =
is a so
> > called
> > IIO backend because it then connects to a real converter (in this case =
DACs)
> > extending it's capabilities and also serving as an interface between an=
other
> > block
> > (typical DMA as this is used for really high speed stuff) and the devic=
e. Now,
> > depending on the actual device, we may need to add/modify some features=
 of the IP
> > and
> > this is what's happening for the ad3552r DAC (it's still build on top o=
f the=20
>=20
> What is "ad3552"? DAC right? Then as I said axi-dac is redundant. We do
> not call ti,tmp451 a ti,sensor-tmp451, right?
>=20

Yes, I agree the DAC part is redundant. But I think the axi prefix (or suff=
ix) is
meaningful to differentiate it from the bindings for the device itself.

> If ad3552 is something else, then the order of naming is not correct.
> Product name is always the first.
>=20
>=20
> > generic axi-adc). And in this design the IP is also acting as a qspi co=
ntroller
> > for
> > actually controlling the configuration of the device while, typically, =
IIO
> > backends
> > are meant to only care about the dataplane. With all of this, there are
> > discussions
> > still happening on the RFC (Angelo was too fast with this version) betw=
een using
> > different properties or new compatibles for changes so significant like=
 this on
> > the
> > generic IP. See the thread where Conor is also involved.
>=20
> 1. Then what does it mean for "adi,axi-dac-9.1.b"?
>=20

IIUC, it means that the generic IP cannot really be used with the ad3552r D=
AC given
the qspi specific bits.

> 2. Is there any real customer product which uses this compatible alone?
>=20

Yes, we do have devices that can work with the generic IP.

> If you need to come up with customized compatibles, it means versioned
> one is not enough.
>=20

Note this was something that was suggested to Angelo. There's also the opti=
on to just
use typical FW properties like the original RFC to describe the HW changes =
in the IP.
But Conor made some good points on using different compatibles when changes=
 go this
far as being also a bus controller...

> If this is 9.1.b but not usable as 9.1.b ("for changes so significant
> like this on"), then I claim 9.1.b compatible is useless.
>=20

The 9.1.b versioning refers to the generic IP version and the custom design=
 for
interfacing with the ad3552r DAC is also based on that version of the gener=
ic IP. It
already happened (for non upstream versions of the IP) for the HW folks to =
increase
the versioning (major) of the generic IP with some breaking change and then=
 new
designs will be based on the newer version. On the driver we use the major =
number to
detect mismatches between driver expectations and what we really have in HW=
.

> >=20
> > > Third, versions are useless if you do not use them as fallbacks.
> > >=20
> >=20
> > In this particular case we can't use the generic IP as a fallback since=
 without
> > the
> > bus controller feature the device can't really work. But it can happen =
we
> > increase
> > the version on the generic core and use the existing version as fallbac=
k=20
> >=20
> > > Something this is really broken and I don't know if the binding or th=
is
> > > patch.
> >=20
> > Having said the above, I'm really not sure if what we have is the best =
approach
> > but
> > these are also early days (upstream) for this so we should still be abl=
e to
> > change
> > things if we need too. I'm fairly sure there's still no one relying on =
this so we
> > should be able to change things in a breaking way (if we need to be tha=
t
> > extreme).
>=20
> DT maintainers consistently (before someone here calls me inconsistent)
> propose not to use versioned compatibles if they map one-to-one to
> products or if they cannot be used alone. Several generic IP blocks like
> Synopsys or Cadence, match the latter - the customization from customer
> is needed, thus snps/cdns IP-block compatible is not usable.
>=20

Given what you're saying above (and IIUC) one thing I can see we doing woul=
d be to
forget about the version and assume the generic compatible cannot be used a=
lone (so
adi,axi-dac). I mean, it always has to connect to real device. So we could =
use the
device name in the compatible and code the expected version for that projec=
t (instead
of being part of the compatible name). I guess it's similar on what's happe=
ning on
the macb driver? But in that case we do have a cdns,macb compatible that ca=
n be used
alone I think.

Only problem I could see with this is that if we have a project adi,axi-foo=
 based on
version 9.1.b and then HW folks move on and introduce 10.0.a and re-do axi-=
foo on top
of the new core version. Would it then be ok to come up with a compatible l=
ike axi-
foo-v2 or axi-foo-10-0-a?

Not sure if any of the above makes much sense...

- Nuno S=C3=A1=20


