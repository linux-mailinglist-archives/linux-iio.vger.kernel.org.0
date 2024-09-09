Return-Path: <linux-iio+bounces-9362-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B00970FEE
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 09:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C402AB22443
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 07:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FCE1AF4EB;
	Mon,  9 Sep 2024 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KanpwSc2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB5A2AF06;
	Mon,  9 Sep 2024 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867211; cv=none; b=iEw3w3Pt0+VyaqjEImwRYquxgshB7kyjNwI4RYiU7OSU4HhsACXiByqRpXtrIWBW9EFY1+1eKtjk3z+xlkHTD7G/90v/N/mG6D5uWBt+3zsiu+yIuZkS0T4jJEpscIkEFW6AOW383Cf89J7ZUwmrPrWvq6/80R0SAYkXITGOEDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867211; c=relaxed/simple;
	bh=SdVkFccpON+4Op+xhrwxc7Co0mJPVq5ImHr+xaENi4Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rLCEV9CvtdvAWVvSEv67/vFHWQSphcCdFddOIzPg9P8ZamFrRxcfnN1SFQ8Zta151vBLeMMqag/GHPjLyxGHVy8vh1qmAJ5C5+m12WpuQdb/ZE/+joBY7Y/AiLYbHhgVcRFf9X/YAQ2KGI0oMds/GMFjeavwPZLgJZbc/G+VaEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KanpwSc2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so16414635e9.1;
        Mon, 09 Sep 2024 00:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725867208; x=1726472008; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SdVkFccpON+4Op+xhrwxc7Co0mJPVq5ImHr+xaENi4Y=;
        b=KanpwSc2p+rlr8veQtylSw9Sy911woGiGvXL5lj5dHaCdDqA/XcMdORto3SHSWMOjC
         sizAMgqU29/p4+P+y2N1FMRIOf14QhsJrVi6VyzELOAHWAe2uZQpi9u8tjO/Y0OiZFJv
         /KSClplCASQFkxCmhIaIBrtPaY24rxBSlcra4NSTo19Ud4XFEF8MhSFJzAehei3cQHeE
         RwfHMt3q6EWTPm7NuSyVq9t/Er99feJ8yi6K1k+YVY27DydZ+A8XywcSOBWcSp0JwtSJ
         pKg6Tf4GPTYm5GB47Mr8n0A4WBaOKEVH1o4UfgJb78cSW6q2ppBtxxOwUzHJyk4Z+ZrM
         jMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725867208; x=1726472008;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdVkFccpON+4Op+xhrwxc7Co0mJPVq5ImHr+xaENi4Y=;
        b=e2ET3nIOhiifzQa9mE/RyxPVk52JtLmIOT4cr3Gamby8rHkaZaxocN7FTaasVlJ2e6
         k3a+LHXJDcqXftohCRnMjUR0EkMlnCoX5FETgIw+w22XAT/wUc3WjshYWTWFTg/t5Ht5
         W//W6F/WV07gFwsc5uCiBEVTePVwBij6ENRK9qkotXQIXJKPzbLYuV3EADDNFdcTJeoD
         ADH3UX6pTUpyOoU80iZ2TZd2H8sMhdLY8sXQ/ZtQmJYqrqHcW9/rcrJdunEati9ekiQ9
         CEQ2DpQM50gHnrXIFqabNrZ3HYEPW72M+DSDsjrALgeIUEAX0WILHSzVbT1ocDwonP0z
         jxsA==
X-Forwarded-Encrypted: i=1; AJvYcCVoA86ayv7QHqjGzExN/Z/+5idB25H8fj8NBF4d7CQxm6TgtUl/AX28+ZJz4baS0qC/DCkzINBwbgHNwpja@vger.kernel.org, AJvYcCXame1uYB9uszYF6yy0hm6HdoufcdjDw1B1UClsjU2dGna+hDKWIvBZ3fbd0HPdRnIfgWaN5cCJ6zaY@vger.kernel.org, AJvYcCXcS9NF31tZd9pCperqLFUciTumAt8MYF+5vxJWdkx8YeCp34f+IxDzVNYkI/kLrd6scx+AX7CRgaCt@vger.kernel.org
X-Gm-Message-State: AOJu0YyL3VTHVDrlxLkOC62Wm0WzOuiJB1p8othWw/J3x+hnmeLBVBTd
	LUS5zRWEpK4IX97fEp8UxbJ9qiqJnfrlobWh2QJxH9lMSTTQE8aS
X-Google-Smtp-Source: AGHT+IFw0nQPA1pCVypFI2j5+UA4yAaN95x/K1XAjQzoueWwoelXh1AvTdYq4hdHwvKPHGDbPBF8FA==
X-Received: by 2002:a05:600c:5128:b0:42c:b62c:9f36 with SMTP id 5b1f17b1804b1-42cb62ca18fmr20981125e9.5.1725867207380;
        Mon, 09 Sep 2024 00:33:27 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb2f86488sm47516715e9.15.2024.09.09.00.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:33:27 -0700 (PDT)
Message-ID: <b9b952f6d73ee96f414d8bdb64fcf3dbfa625abd.camel@gmail.com>
Subject: Re: [RFC PATCH 0/8] iio: dac: introducing ad3552r-axi
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Mark Brown
 <broonie@kernel.org>
Date: Mon, 09 Sep 2024 09:37:35 +0200
In-Reply-To: <20240907151215.6f4c829c@jic23-huawei>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	 <20240831123837.26a1070a@jic23-huawei>
	 <74e0b200-d4c0-4aa3-9ee6-f49ac3f1467d@baylibre.com>
	 <4a62ea7b-a8af-49e0-9718-30d927a69038@baylibre.com>
	 <20240903203935.358a1423@jic23-huawei>
	 <4bb5722003936371a661938d7238db195d2c0ad3.camel@gmail.com>
	 <20240907151215.6f4c829c@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-09-07 at 15:12 +0100, Jonathan Cameron wrote:
> On Thu, 05 Sep 2024 11:16:03 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Tue, 2024-09-03 at 20:39 +0100, Jonathan Cameron wrote:
> > > On Tue, 3 Sep 2024 11:17:24 -0500
> > > David Lechner <dlechner@baylibre.com> wrote:
> > > =C2=A0=20
> > > > On 9/3/24 3:34 AM, Angelo Dureghello wrote:=C2=A0=20
> > > > > Hi Jonathan and all,
> > > > >=20
> > > > >=20
> > > > > On 31/08/24 1:38 PM, Jonathan Cameron wrote:=C2=A0=C2=A0=C2=A0=
=20
> > > > > > On Thu, 29 Aug 2024 14:31:58 +0200
> > > > > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > > > > > =C2=A0=C2=A0=20
> > > > > > > Hi, asking for comments for this patchset, that is mostly
> > > > > > > ready, at least feature-complete and functionally tested.
> > > > > > >=20
> > > > > > > I am introducing ad3552r-axi variant, controlled from a fpga-=
based
> > > > > > > AXI IP, as a platform driver, using the DAC backend. The patc=
hset
> > > > > > > is
> > > > > > > actually based on linux-iio, since some needed DAC backend
> > > > > > > features
> > > > > > > was already there on that repo only, still to be merged in
> > > > > > > mainline.
> > > > > > >=20
> > > > > > > Comments i would like to ask are:
> > > > > > >=20
> > > > > > > - i added some devicetree bindings inside current ad3552r yam=
l,
> > > > > > > =C2=A0=C2=A0 device is the same, so i wouldn't create a diffe=
rent yaml
> > > > > > > file.=C2=A0=C2=A0=C2=A0=20
> > > > > > Agreed. If same device, it's usually better to keep it in one f=
ile.
> > > > > > =C2=A0=C2=A0=20
> > > > > > > - if it's ok adding the bus-type property in the DAC backend:
> > > > > > > =C2=A0=C2=A0 actually, this platform driver uses a 4 lanes pa=
rallel bus,
> > > > > > > plus
> > > > > > > =C2=A0=C2=A0 a clock line, similar to a qspi. This to read an=
 write
> > > > > > > registers
> > > > > > > =C2=A0=C2=A0 and as well to send samples at double data rate.=
 Other DAC may
> > > > > > > =C2=A0=C2=A0 need "parallel" or "lvds" in the future.=C2=A0=
=C2=A0=C2=A0=20
> > > > > > If it is for register read + write as well, sounds to me like y=
ou
> > > > > > need
> > > > > > to treat this as a new bus type, possibly then combined with a
> > > > > > backend, or something similar to spi offload?
> > > > > >=20
> > > > > > What bus does this currently sit on in your DT bindings?
> > > > > > (add an example)=C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > >=20
> > > > > &amba {
> > > > >=20
> > > > > =C2=A0=C2=A0 =C2=A0ref_clk: clk@44B00000 {
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-clk=
gen-2.00.a";
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44B00000 0x10000=
>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #clock-cells =3D <0>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&clkc 15>, <&cl=
kc 15>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clock-names =3D "s_axi_aclk=
", "clkin1";
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clock-output-names =3D "ref=
_clk";
> > > > > =C2=A0=C2=A0 =C2=A0};
> > > > >=20
> > > > > =C2=A0=C2=A0 =C2=A0dac_tx_dma: dma-controller@0x44a30000 {
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-dma=
c-1.00.a";
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44a30000 0x10000=
>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #dma-cells =3D <1>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 interrupt-parent =3D <&intc=
>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <0 57 IRQ_TY=
PE_LEVEL_HIGH>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&clkc 15>;
> > > > >=20
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 adi,channels {
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 #size-ce=
lls =3D <0>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 #address=
-cells =3D <1>;
> > > > >=20
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dma-chan=
nel@0 {
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 reg =3D <0>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 adi,source-bus-width =3D <32>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 adi,source-bus-type =3D <0>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 adi,destination-bus-width =3D <32>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 adi,destination-bus-type =3D <1>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 };
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > =C2=A0=C2=A0 =C2=A0};
> > > > >=20
> > > > > =C2=A0=C2=A0 =C2=A0backend: controller@44a70000 {
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-dac=
-9.1.b";
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44a70000 0x1000>=
;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 dmas =3D <&dac_tx_dma 0>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 dma-names =3D "tx";
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #io-backend-cells =3D <0>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&ref_clk>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 bus-type =3D <1>;=C2=A0 /* =
IIO QSPI */
> > > > > =C2=A0=C2=A0 =C2=A0};
> > > > >=20
> > > > > =C2=A0=C2=A0 =C2=A0axi-ad3552r {
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,ad3552r=
";
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reset-gpios =3D <&gpio0 92 =
GPIO_ACTIVE_LOW>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 io-backends =3D <&backend>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 channel@0 {
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 reg =3D =
<0>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 adi,outp=
ut-range-microvolt =3D <(-10000000) (10000000)>;
> > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > =C2=A0=C2=A0 =C2=A0};=C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > Shouldn't the axi-ad3552r node be one level higher since it isn't
> > > > a memory-mapped device, but rather an external chip?=C2=A0=20
> > > Definitely not where it currently is..=C2=A0=20
> > > >=20
> > > > But based on the other feedback we got in this series and some
> > > > #devicetree IRC chat here is an alternate binding suggestion we
> > > > could consider.
> > > >=20
> > > > First, even though the FPGA IP block for use with AD3225R uses
> > > > the same register map as the AXI DAC IP block, some of the
> > > > registers behave differently, so it makes sense to have a
> > > > different compatible string rather than using the bus-type
> > > > property to tell the difference between the two IP blocks.
> > > > There are likely more differences than just the bus type.=C2=A0=20
> > >=20
> > > I'd be amazed if they managed to keep things that similar
> > > given totally different buses.
> > > =C2=A0=20
> >=20
> > Yeah, I was trying to avoid new compatibles as much as I can because th=
ings
> > can
> > get pretty confusing (with lots of new compatibles and quirks) pretty
> > quickly.
> > Typically yes, most designs have slight differences between them (with =
new
> > features and so on) but so far I was trying (thinking) to have those as=
 a
> > generic new backend op (plus a matching binding property if needed). Fo=
r
> > this
> > particular case, I'm fairly sure we could get away with the bus control=
ler
> > property and having different implementations depending on the bus bein=
g
> > implemented. For the other bits that might differ between designs (eg: =
DDR
> > support) is up to frontends to call it or not (depending on they having=
 that
> > feature or not).=20
>=20
> That breaks down if the backend you happen to be using (maybe a new
> one hasn't been written yet) is missing the DDR feature but the front end
> device can run with or without it.
> Unless the hardware makes this discoverable you'll have the backend drive=
r
> writing some enable bit that does nothing.
>=20
> Maybe it's a case of using fallback compatibles - so define more specific
> ones but with a fallback to one that doesn't provide the fancy features
> and only covers thins all IPs support.
>=20
> > Naturally we need that the IPs having DDR support to not have
> > the same thing supported in different registers but we do control that =
since
> > these are FPGA cores.
> >=20
> > All the above said, I'm fine with new compatibles but we need to draw a=
 line
> > when we add new ones. If the reasoning is the IP has some new bits or n=
ew
> > registers, then things can get very confusing (even more if we think ab=
out
> > fallback compatibles) as most of the new designs have some quirks (even=
 if
> > minimal). So I would say to add new compatibles when things get differe=
nt
> > enough
> > that a sane/generic API is not doable.
>=20
> If you can influence the IP designers, the usual solution to this is
> discoverability of features. So standard register that all IP carries tha=
t
> has flags for each feature that has ever been implemented.
>=20

That get's messy. We do have some flags for some of the more generic featur=
es
(I'm using them in the backends when available). But we have (and will have=
) so
many variations of these designs that it get's hard to get it right all the
time. And for thing like this bus quirk a flag itself may be not enough to
distinguish between different implementations...

Last time I spoke with the designers, they are thinking about just adding a=
 set
of custom registers that (always the same range I think) for these IPs and =
then
leave it up to the driver implementation to deal with the different
implementations of the registers. Not sure if it's the best approach but it
feels like they're getting tired of dealing with all the subtle changes bet=
ween
the different devices these IPs connect too :)

On the IIO backend "world", frontends are the ones with the knowledge of wh=
at
these custom registers could implement and so, it's very doable for backend=
s to
export a range of valid registers for frontends to "directly" (of course no=
t
reading/writing directly :)) access. Feels a bit hacky but also a bit
reasonable... Anyways, all of the above is still just speculation so not su=
re if
it will happen at all. Just some ramblings from me :)


> If not, best option is each IP gets a compatible but we assume fallbacks
> are fine until they aren't.
>=20

Yeah, Conor made some compelling arguments about using new compatibles. At
least, for the more complicated cases like this.

- Nuno S=C3=A1

