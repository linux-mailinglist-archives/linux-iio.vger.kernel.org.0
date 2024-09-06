Return-Path: <linux-iio+bounces-9241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C4D96F31E
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 13:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941F21F22D96
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 11:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309D21CB14D;
	Fri,  6 Sep 2024 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+9W1ugQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0E15852B;
	Fri,  6 Sep 2024 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622334; cv=none; b=Q6kvN3HJfR3IdCYiTILpWJm6uMY9XRKJAimtJPsaAftLWgxWUVc/L4GD/PNKIZG0JfTl6bdb06tYNdnYi7NXnYPEiM0yxSwdCabcIwamL9Ax56RlXiyRDV3Dmok12/YbbQwbgZtSB4gWeUerZJJyYacvGFk1OC9vSVn2WQymOuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622334; c=relaxed/simple;
	bh=lQCRrdaaHU/TDfYp9dlT7sumlkf2U2ubUQmsymdhHVs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qWgPpFxrzWZcQTtxaL9F+6pFS0vFE0SBMLlUl4cli0Cp9E80AD/srwyp1jzXfzEstnLPjbBw57eX01TWirOZXDUoNHx1uDJasZZ5PsO5dmx02FeB4j/TRWkMUJo4ffy6TgUId86jKFxfhkLfz7h+AMXUfd/ZWhXwt/h5tcQvIaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+9W1ugQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42c79deb7c4so14388235e9.3;
        Fri, 06 Sep 2024 04:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725622330; x=1726227130; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lQCRrdaaHU/TDfYp9dlT7sumlkf2U2ubUQmsymdhHVs=;
        b=b+9W1ugQCYtCzgqlR4HJ7XsVF3zIYHO0z47zqSorriDh9SsUKt1zABawaO9SCeR88o
         GdUCtGVZIWj3+bwe0NBu39TvjvmjqhUom6C5yaeX87CT88WRZldcFdYZvhlSIvLVx8Ci
         sGSh+xGshS8mvzKP9/u5fszW4gj4tifQCt7EQa2cP7bWglogMxsPosDTBDOtYrOU0CXJ
         zzN4sgdDWH9BIYKvEkKpLON0VcbsxdaV4Q4FEa+EmC9RQlCV+AqM039HtmIb4Q5XG3vQ
         RyGuUgMmRWuvn8tkUZdFI7JElIn2E/DREEzJ9ZCC1WiOi0u7C+ydnJ+RPDTFiycKoZUF
         4F7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725622330; x=1726227130;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lQCRrdaaHU/TDfYp9dlT7sumlkf2U2ubUQmsymdhHVs=;
        b=Dm0qbThJovZ3kbgtGFUjMT0N491Bpf5qgtE+vlQ8XbhfG9Cc9d2tcQrxWoW0J8CaUa
         pf/Zl08MGeZbbZ54SW41uCY+cLM1f8+Vmpw5XW0CvM3kV0fvWEKGJhtG6OAFz+TjSkeq
         VbPYYYctPUgWrIQF/rglomemYtcN1QYbazdgbBCY7mCOv2fahwikTeVijoGXT9IfknHF
         MiIl64f1x3GzdoW5B5GLevMLkRuNRSkDNMq3+KlzEdS6IN8Iu1JL7S9ni0ssOQbZ3k19
         CciEvzFdZxjIJcmo16ae2L5QpkbiiOjeQwbv6TlUP1AdJMe30AY7Qb6uAD0wfreHpnDo
         5Xug==
X-Forwarded-Encrypted: i=1; AJvYcCUfNGnd+Tg2Ji50tNj/SGh1P8/cGI8Gn7m85+p+B/6JgB3YMxLMs92okezTWj+tNPnD3nKhXxFp+sTG@vger.kernel.org, AJvYcCW7vEfL/NG26EE5t2o/X9TUzAv/8hEx9jnBKZg9MviQ/Zg4NFVnyiPAr3ycn8Igse+JVDyyjyrvv9L3nFu/@vger.kernel.org, AJvYcCXlJSWySVJuUoiyNwhHzWGoH8+44fpi0ioRLRvv1iAf9o3ytHHvStSv4kmHi82qBp/tMh0LHtzsHpDB@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3xKT/K/+KjDJULVGKu0Htxv6VwjY9y1TY+RS9FOsat1Roc6W
	HxNXLJG0SyZG8c7m3Es4O+Dq57K9cDbHLS4lpdKV50uX4mTXd6j7
X-Google-Smtp-Source: AGHT+IHR2a2j+bK/91RR6LZpAxAvRTcTs4mdc5NQieYix0uxLmd2DegBGYLc6MWj+48FlXI9n6sxEg==
X-Received: by 2002:a05:600c:5103:b0:426:5dd0:a1ea with SMTP id 5b1f17b1804b1-42c9f9d3587mr16049245e9.28.1725622330155;
        Fri, 06 Sep 2024 04:32:10 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ccf8dsm17557535e9.19.2024.09.06.04.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:32:09 -0700 (PDT)
Message-ID: <5fd8374285d7dadd68777efabad753b981d29f40.camel@gmail.com>
Subject: Re: [PATCH RFC 4/8] dt-bindings: iio: dac: add adi axi-dac bus
 property
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Conor Dooley <conor@kernel.org>, Angelo Dureghello
	 <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlechner@baylibre.com
Date: Fri, 06 Sep 2024 13:32:09 +0200
In-Reply-To: <20240906-venomous-candle-8348b00640ca@squawk>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	 <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
	 <20240829-stopwatch-morality-a933abb4d688@spud>
	 <d4eddc24-9192-4a4a-ac67-4cfbd429a6a9@baylibre.com>
	 <20240830-quilt-appointee-4a7947e84988@spud>
	 <9015bc26-1a3a-49df-8728-12ceb8993035@baylibre.com>
	 <20240906-venomous-candle-8348b00640ca@squawk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-06 at 10:04 +0100, Conor Dooley wrote:
> On Mon, Sep 02, 2024 at 11:32:37AM +0200, Angelo Dureghello wrote:
> > Hi Conor,
> >=20
> >=20
> > On 30/08/24 5:33 PM, Conor Dooley wrote:
> > > On Fri, Aug 30, 2024 at 10:19:49AM +0200, Angelo Dureghello wrote:
> > > > Hi Conor,
> > > >=20
> > > > On 29/08/24 5:46 PM, Conor Dooley wrote:
> > > > > On Thu, Aug 29, 2024 at 02:32:02PM +0200, Angelo Dureghello wrote=
:
> > > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > >=20
> > > > > > Add bus property.
> > > > > RFC it may be, but you do need to explain what this bus-type actu=
ally
> > > > > describes for commenting on the suitability of the method to be
> > > > > meaningful.
> > > > thanks for the feedbacks,
> > > >=20
> > > > a "bus" is intended as a generic interface connected to the target,
> > > > may be used from a custom IP (fpga) to communicate with the target
> > > > device (by read/write(reg and value)) using a special custom interf=
ace.
> > > >=20
> > > > The bus could also be physically the same of some well-known existi=
ng
> > > > interfaces (as parallel, lvds or other uncommon interfaces), but us=
ing
> > > > an uncommon/custom protocol over it.
> > > >=20
> > > > In concrete, actually bus-type is added to the backend since the
> > > > ad3552r DAC chip can be connected (for maximum speed) by a 5 lanes =
DDR
> > > > parallel bus (interface that i named QSPI, but it's not exactly a Q=
SPI
> > > > as a protocol), so it's a device-specific interface.
> > > >=20
> > > > With additions in this patchset, other frontends, of course not onl=
y
> > > > DACs, will be able to add specific busses and read/wrtie to the bus
> > > > as needed.
> > > >=20
> > > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > > ---
> > > > > > =C2=A0=C2=A0 Documentation/devicetree/bindings/iio/dac/adi,axi-=
dac.yaml | 9
> > > > > > +++++++++
> > > > > > =C2=A0=C2=A0 1 file changed, 9 insertions(+)
> > > > > >=20
> > > > > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-=
dac.yaml
> > > > > > b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > > > index a55e9bfc66d7..a7ce72e1cd81 100644
> > > > > > --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yam=
l
> > > > > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yam=
l
> > > > > > @@ -38,6 +38,15 @@ properties:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > You mentioned about new compatible strings, does the one currentl=
y
> > > > > listed in this binding support both bus types?
> > > You didn't answer this, and there's insufficient explanation of the
> > > "hardware" in this RFC, but I found this which is supposedly the
> > > backend:
> > > https://github.com/analogdevicesinc/hdl/tree/main/library/axi_ad3552r
> > > adi,axi-dac.yaml has a single compatible, and that compatible has
> > > nothing to do with "axi_ad3552r" as it is "adi,axi-dac-9.1.b". I woul=
d
> > > expect either justification for reuse of the compatible, or a brand n=
ew
> > > compatible for this backend, even if the driver can mostly be reused.
> > >=20
> > > Could you please link to whatever ADI wiki has detailed information o=
n
> > > how this stuff works so that I can look at it to better understand th=
e
> > > axes of configuration here?
> >=20
> > https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
> >=20
> > that has same structure and register set of the generic ADI AXI-DAC IP:
> > https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
> >=20
> >=20
> > > > > Making the bus type decision based on compatible only really make=
s sense
> > > > > if they're different versions of the IP, but not if they're diffe=
rent
> > > > > configuration options for a given version.
> > > > >=20
> > > > > > +=C2=A0 bus-type:
> > > > DAC IP on fpga actually respects same structure and register set, e=
xcept
> > > > for a named "custom" register that may use specific bitfields depen=
ding
> > > > on the application of the IP.
> > > To paraphrase:
> > > "The register map is the same, except for the bit that is different".
> > > If ADI is shipping several different configurations of this IP for
> > > different DACs, I'd be expecting different compatibles for each backe=
nd
> > > to be honest
> >=20
> > i am still quite new to this fpga-based implementations, at least for h=
ow
> > such IPs are actually interfacing to the linux subsystem, so i may miss
> > some point.
> >=20
> > About the "adi,axi-dac-9.1.b" compatible, the generic DAC IP register s=
et
> > is mostly the same structure of this ad3552r IP (links above), except f=
or
> > bitfields in the=C2=A0DAC_CUSTOM_CTRL register.
> >=20
> > My choice for now was to add a bus-type property.
> >=20
> > Not an HDL expert, but i think a different bus means, from an hardware =
point
> > of
> > view, a different IP in terms of internal fpga circuitry, even if not a=
s a
> > register-set.
>=20
> Depending on whether or not the unmodified driver can be used with this
> IP (so the QSPI bus stuff would need to be optional) then a fallback
> should be used given the degree of similarity. It, however, seems likely
> that is not the case, and without the QSPI bus there'd be no way to
> communicate with the device. Is there any reason to use this IP as a
> backend, without connecting the QSPI bus at all, leaving the ADC/DAC on
> a regular SPI bus?
>=20

Somewhere in my replies, I'm doing the exact same question to myself. We pr=
obably
need to speak with the FPGA folks but I guess (hope) they had a good reason=
 for this.

- Nuno S=C3=A1

