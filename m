Return-Path: <linux-iio+bounces-9177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589E196D2DA
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 11:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85DA6B2331F
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 09:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C04C195FFA;
	Thu,  5 Sep 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9rPMZFd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869CB3F9D5;
	Thu,  5 Sep 2024 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527520; cv=none; b=RDmqAz9NoWcmfO62WwOpw71FU8hRDwJvguwBEKNGaqtOFuOeAu74jyi64yYwCPgrN7vRQxx3yb2/VGp/nop50EN/06vKLLPLVk566F3qoqhfxFttPuKsBq6qi1wAOQ6K5PZ/vabMGq/D/7xsYWa5yDD3EhIpzecpIL720ooDCFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527520; c=relaxed/simple;
	bh=WY9n2Jkas1whXstDJTsHRvRN9HWiIU2jbM2A08sLy74=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aGGwGq6UWjNhp5NXgiULWiE55ENwfRj+Nk31WtMu5uuao6mfIgUQFIKwGOIuXtpmcrNUul9Q7PUYvF5xqN+HcDPEA7nP7eAAB/0GBrerlDkCc7jacNuIGb9LPgZaBr1yQVl37YjEpJ8jZNQtprm92eGW5KS3D8gLFaOuR3pKi6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9rPMZFd; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8696e9bd24so78377366b.0;
        Thu, 05 Sep 2024 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725527517; x=1726132317; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WY9n2Jkas1whXstDJTsHRvRN9HWiIU2jbM2A08sLy74=;
        b=J9rPMZFdcUThTV1G1PL3UtRg2gbi+LKa+EseGxRz9q/1jQCzxuI+tFP2ZjIWHNsero
         TKmfeUWwW8/kTgGdAoB4XwbPTd40BFAbHumDbFWMCE7DwVx1K/GEbdlFMpvFQw/KapwW
         VjBscmhQIiolkRiIfUYcNOvXBP9fZD4ohOhb59ZYJmvtenoU/877Gulzl4WQHkMvHTJk
         vH6waawBCWyxQkyrFnjfk03v0Aft2SKT7b4rAbcde53V4fKCD77uKFVwWpLsmtsDM1h5
         aqCqTuzq2hgyf2jSEw6jH00XJm/cKHUOWTC14Suhkj4jM4Bycka7qZ4UaFC9JmkoIoKq
         tAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725527517; x=1726132317;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WY9n2Jkas1whXstDJTsHRvRN9HWiIU2jbM2A08sLy74=;
        b=Nma40ZYXs/nC4dC485ZQ6tkZpG35T1wrpH1OqRwkJKVw2WDS/RjyaUhE51zNBL0m3K
         DH3TbXFXaBd1cgSxpl9YMq8D9aObVht0VeuTe47mdpXcDlSoLEqk+oXSKzyc9UW1PB53
         oTjlWbn6o0OiEbxK5N4zN62ZQ+SSPtJnad1q5Z9nrPtBbeacoLRl8ndjlBMepVVPmKa7
         bMBb1f3fZAGbrDpgXMq9yYgHJSUjWA0e/NgFXia7taoK7nrm7cicaK7F6WeCkzfPzKg5
         gERKN10ct0LWmeyJupAAa9OkHCVMzyHv3A8wyfHcWk7+Ab/eD8eSyK3CrgfMvJPKfKdi
         aNjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAmOlFOFeY0j2m9iJJJzpwuhGOKFi9vV41RdASPtq6DopdBhg2XEXzmJc164yZsM/lejp5DsB6J16m@vger.kernel.org, AJvYcCVWtxgQndfQbaXiZOBhfGBOwsq/b9Vmw7LsnLPOOdcaG2p36uUquhHOkndIoClBASazPX9wdUHwF3GS@vger.kernel.org, AJvYcCXdA25LdjyzfY5DESHoYTVgE4xbViD6thLtrgzsoVXRpBjaETgdS5ANvmPVOC9tXtLpFcftcbDxJtBnYHeU@vger.kernel.org
X-Gm-Message-State: AOJu0YwGuHxdKld1gaWhlvB9a2UhyeAaQ3Fu/T3zygwtLEQ/I8w5wnsG
	1g79j2v0sePtK/XxPQq7VzHlfZE/rPqhej8eMKUHV6sRuq8FaybQ
X-Google-Smtp-Source: AGHT+IEwreZv7xWtYxewqz8fwZuXeLBsN2ROlKnym3hdlInja4DPL2UQEEGQwvAfo9XZeYQ1duzF7A==
X-Received: by 2002:a17:907:97c3:b0:a7a:b1a8:6a2e with SMTP id a640c23a62f3a-a897f860feemr1886462666b.28.1725527516643;
        Thu, 05 Sep 2024 02:11:56 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a7b42d7d5sm12323066b.29.2024.09.05.02.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 02:11:56 -0700 (PDT)
Message-ID: <4bb5722003936371a661938d7238db195d2c0ad3.camel@gmail.com>
Subject: Re: [RFC PATCH 0/8] iio: dac: introducing ad3552r-axi
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
	 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown
	 <broonie@kernel.org>
Date: Thu, 05 Sep 2024 11:16:03 +0200
In-Reply-To: <20240903203935.358a1423@jic23-huawei>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	 <20240831123837.26a1070a@jic23-huawei>
	 <74e0b200-d4c0-4aa3-9ee6-f49ac3f1467d@baylibre.com>
	 <4a62ea7b-a8af-49e0-9718-30d927a69038@baylibre.com>
	 <20240903203935.358a1423@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-03 at 20:39 +0100, Jonathan Cameron wrote:
> On Tue, 3 Sep 2024 11:17:24 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > On 9/3/24 3:34 AM, Angelo Dureghello wrote:
> > > Hi Jonathan and all,
> > >=20
> > >=20
> > > On 31/08/24 1:38 PM, Jonathan Cameron wrote:=C2=A0=20
> > > > On Thu, 29 Aug 2024 14:31:58 +0200
> > > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > > > =C2=A0
> > > > > Hi, asking for comments for this patchset, that is mostly
> > > > > ready, at least feature-complete and functionally tested.
> > > > >=20
> > > > > I am introducing ad3552r-axi variant, controlled from a fpga-base=
d
> > > > > AXI IP, as a platform driver, using the DAC backend. The patchset=
 is
> > > > > actually based on linux-iio, since some needed DAC backend featur=
es
> > > > > was already there on that repo only, still to be merged in mainli=
ne.
> > > > >=20
> > > > > Comments i would like to ask are:
> > > > >=20
> > > > > - i added some devicetree bindings inside current ad3552r yaml,
> > > > > =C2=A0=C2=A0 device is the same, so i wouldn't create a different=
 yaml file.=C2=A0=20
> > > > Agreed. If same device, it's usually better to keep it in one file.
> > > > =C2=A0
> > > > > - if it's ok adding the bus-type property in the DAC backend:
> > > > > =C2=A0=C2=A0 actually, this platform driver uses a 4 lanes parall=
el bus, plus
> > > > > =C2=A0=C2=A0 a clock line, similar to a qspi. This to read an wri=
te registers
> > > > > =C2=A0=C2=A0 and as well to send samples at double data rate. Oth=
er DAC may
> > > > > =C2=A0=C2=A0 need "parallel" or "lvds" in the future.=C2=A0=20
> > > > If it is for register read + write as well, sounds to me like you n=
eed
> > > > to treat this as a new bus type, possibly then combined with a
> > > > backend, or something similar to spi offload?
> > > >=20
> > > > What bus does this currently sit on in your DT bindings?
> > > > (add an example)=C2=A0=20
> > >=20
> > >=20
> > > &amba {
> > >=20
> > > =C2=A0=C2=A0 =C2=A0ref_clk: clk@44B00000 {
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-clkgen-=
2.00.a";
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44B00000 0x10000>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #clock-cells =3D <0>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&clkc 15>, <&clkc 1=
5>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clock-names =3D "s_axi_aclk", "=
clkin1";
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clock-output-names =3D "ref_clk=
";
> > > =C2=A0=C2=A0 =C2=A0};
> > >=20
> > > =C2=A0=C2=A0 =C2=A0dac_tx_dma: dma-controller@0x44a30000 {
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-dmac-1.=
00.a";
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44a30000 0x10000>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #dma-cells =3D <1>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 interrupt-parent =3D <&intc>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <0 57 IRQ_TYPE_L=
EVEL_HIGH>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&clkc 15>;
> > >=20
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 adi,channels {
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 #size-cells =
=3D <0>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 #address-cel=
ls =3D <1>;
> > >=20
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dma-channel@=
0 {
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 reg =3D <0>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 adi,source-bus-width =3D <32>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 adi,source-bus-type =3D <0>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 adi,destination-bus-width =3D <32>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 adi,destination-bus-type =3D <1>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 };
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 };
> > > =C2=A0=C2=A0 =C2=A0};
> > >=20
> > > =C2=A0=C2=A0 =C2=A0backend: controller@44a70000 {
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-dac-9.1=
.b";
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44a70000 0x1000>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 dmas =3D <&dac_tx_dma 0>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 dma-names =3D "tx";
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #io-backend-cells =3D <0>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&ref_clk>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 bus-type =3D <1>;=C2=A0 /* IIO =
QSPI */
> > > =C2=A0=C2=A0 =C2=A0};
> > >=20
> > > =C2=A0=C2=A0 =C2=A0axi-ad3552r {
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,ad3552r";
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reset-gpios =3D <&gpio0 92 GPIO=
_ACTIVE_LOW>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 io-backends =3D <&backend>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 channel@0 {
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 reg =3D <0>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 adi,output-r=
ange-microvolt =3D <(-10000000) (10000000)>;
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 };
> > > =C2=A0=C2=A0 =C2=A0};=C2=A0=20
> >=20
> > Shouldn't the axi-ad3552r node be one level higher since it isn't
> > a memory-mapped device, but rather an external chip?
> Definitely not where it currently is..
> >=20
> > But based on the other feedback we got in this series and some
> > #devicetree IRC chat here is an alternate binding suggestion we
> > could consider.
> >=20
> > First, even though the FPGA IP block for use with AD3225R uses
> > the same register map as the AXI DAC IP block, some of the
> > registers behave differently, so it makes sense to have a
> > different compatible string rather than using the bus-type
> > property to tell the difference between the two IP blocks.
> > There are likely more differences than just the bus type.
>=20
> I'd be amazed if they managed to keep things that similar
> given totally different buses.
>=20

Yeah, I was trying to avoid new compatibles as much as I can because things=
 can
get pretty confusing (with lots of new compatibles and quirks) pretty quick=
ly.
Typically yes, most designs have slight differences between them (with new
features and so on) but so far I was trying (thinking) to have those as a
generic new backend op (plus a matching binding property if needed). For th=
is
particular case, I'm fairly sure we could get away with the bus controller
property and having different implementations depending on the bus being
implemented. For the other bits that might differ between designs (eg: DDR
support) is up to frontends to call it or not (depending on they having tha=
t
feature or not). Naturally we need that the IPs having DDR support to not h=
ave
the same thing supported in different registers but we do control that sinc=
e
these are FPGA cores.

All the above said, I'm fine with new compatibles but we need to draw a lin=
e
when we add new ones. If the reasoning is the IP has some new bits or new
registers, then things can get very confusing (even more if we think about
fallback compatibles) as most of the new designs have some quirks (even if
minimal). So I would say to add new compatibles when things get different e=
nough
that a sane/generic API is not doable.

> >=20
> > Second, technically, the AXI DAC IP block can't be used as
> > a generic SPI controller, so it wouldn't make sense to put
> > it in drivers/spi.
>=20
> I wonder if there is any precedence of restricted controllers
> for SPI?=C2=A0 (For i2c we have the smbus ones as a vaguely similar
> example). +CC Mark.
>=20
> > =C2=A0But, from wiring point of view, it could
> > still make sense to use SPI DT bindings since we have SPI
> > wiring. At the same time, the AXI DAC IP block is also
> > providing extra functionality in addition to the SPI bus
> > so it makes sense to keep the io-backend bindings for those
> > extra bits.
> >=20
> > =C2=A0=C2=A0=C2=A0 backend: spi@44a70000 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-dac-=
ad3225r";
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44a70000 0x1000>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmas =3D <&dac_tx_dma 0>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma-names =3D "tx";
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #io-backend-cells =3D <0>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&ref_clk>;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dac@0 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 comp=
atible =3D "adi,ad3552r";
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =
=3D <0>;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * Not sure how right this is - attempting to say that
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * the QSPI select pin is hardwired high, so the 4 SPI I/O
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * pins on the DAC are always functioning as SDIO0/1/2/3
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * as opposed to the usual 2 SDI/SDO pins and 2 unused.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi-=
3-wire;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi-=
tx-bus-width =3D <4>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi-=
rx-bus-width =3D <4>;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rese=
t-gpios =3D <&gpio0 92 GPIO_ACTIVE_LOW>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io-b=
ackends =3D <&backend>;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #add=
ress-cells =3D <1>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #siz=
e-cells =3D <0>;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chan=
nel@0 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 reg =3D <0>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 adi,output-range-microvolt =3D <(-10000000) (10000000=
)>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > =C2=A0=C2=A0=C2=A0 };
>=20
> That's definitely an improvement.=C2=A0 It's a little strange to have
> a reference back to the parent but I'm fine with that.
>=20

Agreed...

- Nuno S=C3=A1


