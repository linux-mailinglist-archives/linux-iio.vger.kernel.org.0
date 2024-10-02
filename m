Return-Path: <linux-iio+bounces-10001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D703998CF5D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 11:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DFF1F22D87
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 09:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E255197A88;
	Wed,  2 Oct 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDrXgSh9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C1C197545;
	Wed,  2 Oct 2024 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859612; cv=none; b=DQk1mLVUnQ/ZjQkphezcR60PLZ1uVTItUZiGttRhrfxPF63d/mbfHL3W3MX2Q9qjdTvQ0KxRRD+VlCraLQNirVCPfdlOmvp4PqWmnD0Uc1oOLGgJPplHk6/4hNZneIcWHD4WmJ9sBb+K9/cIcVMxM5/CZ4Fia9w9ooF44de001o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859612; c=relaxed/simple;
	bh=EzRP31FZjJ6ZU3j6B+YFljSn5PBdPySJYwYZxlxh1qI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hLAJmxx/5B/tJZDdNxuDP7hKWhQYqNIkBUOuxkB1QK/gKa3w2gBTT4hTgK7Vv03nuqIg9p1c75YSzSYwB+t+ZLAUXo/SmivprANtOPCkrU/qlIC8lu8668k5UaGon7UjRHM654SY/UIqduiFHhjYJG6s51LNUv5gsRyMufcm62E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDrXgSh9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d2daa2262so734436266b.1;
        Wed, 02 Oct 2024 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727859608; x=1728464408; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EzRP31FZjJ6ZU3j6B+YFljSn5PBdPySJYwYZxlxh1qI=;
        b=SDrXgSh9lVkxbaxODZiVj7c9jm1Ks7GRCI/o/DqEC5iuyXh0EBrnUZErfYxF80rnzU
         UDb4W8rfF8jy02G695M7XYSOd8PXKB5ajxFNZRjQu7UPvPmzk2IQE8s5mQ6NjFjeIMQy
         eiDCI9yPFEEWsu3Xkd7FqMS9yj9SbBRLTZtLKGmhSqkM/qWSKxn0A7Ef91hfCIy65IY3
         mB4uRgCG1hXNIbKeGmvmbAUqofAtV4f4K1yv1hZoQuUw8NOh2GK/VuQkT2ZL3nidXQQC
         dNSK0jtqPU0rlvGE7sYpYyHgG318W+NObK+FuA664+h/Wk+N3MaPxjsbjjuIlCUXBXk5
         LTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859608; x=1728464408;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EzRP31FZjJ6ZU3j6B+YFljSn5PBdPySJYwYZxlxh1qI=;
        b=EMRP1FWbEBH/sNeSVfavLzvN1MUEg3MZKStdvc0BLsRvspIJeK/fSLRZg99kdWUCTe
         lmj+qrOMgSM7V5dIArAkvp1RI+REvVmhXM1EmScWDccOuN/rTbHujzdAWCaHcYpnTgtV
         gNDmPwjhRXmAitCETWTsqDzWuBZ5yfkko0FFkAtRfFnR0vAJo9YdsNywyaRGaNeqqJ9g
         95dhTYFuIksddEvy/u6P0qegPX07ZJmtHsRV/GUkBTpfRh1LYYY82O0BAduOGpR+rU16
         Ys5UZ7etuk2aFMg/yax+vh5rdLPU+WFFY0jpwJ1DuFGBkNp/N1wlQfcfLgOceNMLIU6+
         ++Og==
X-Forwarded-Encrypted: i=1; AJvYcCUCBdYXNnavNlZwzDBHkz9UXKuTdsAFubFMIjhhMIhb3ZSVrL81Q95N8StgOiX803CPEC1SvPFSyxIM@vger.kernel.org, AJvYcCX3uD7LNmTx5Aa66N4iKtyX8LOab0M4fZmQnZYd81DfuwLPRAZQqaR9gdG8c8Zlejmt0sQIN7DYc+OZ@vger.kernel.org, AJvYcCXhxaoN7rHBed0kiUCpn5lQNwnqQgZOyiCej/TUM+kdzgKK43OcBtcMbAlaoGOCTklNsUTDhLmoEr2iExTf@vger.kernel.org
X-Gm-Message-State: AOJu0YxsU0dhZSoRY3i947Jkhewof71p+wDzJWdfYBY9HZFbAcIyRbQR
	oh+Lize63Ct9tCcV+Sr/S64eTszvZC9ywOEA+hkh3kyZ3Ue/DgXQ
X-Google-Smtp-Source: AGHT+IHdNvnjXL5q8HfpcQZhBBNXQtsioIOWss3mO0XxfLcNH80l7LIr+tOD3OdeR6nXCiJ/vaE7xw==
X-Received: by 2002:a17:907:7ba8:b0:a8d:4845:de57 with SMTP id a640c23a62f3a-a98f82533b0mr225334966b.26.1727859608036;
        Wed, 02 Oct 2024 02:00:08 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c299f5a9sm833025866b.225.2024.10.02.02.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:00:07 -0700 (PDT)
Message-ID: <f9a2b74f371fb4b02486ad7426c57b75739438f3.camel@gmail.com>
Subject: Re: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com
Date: Wed, 02 Oct 2024 11:00:06 +0200
In-Reply-To: <20241001192913.5b848dfc@jic23-huawei>
References: 
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
	 <gojq6ardhvt6vcs2kawdhdn2cj6qbpzp4p5mjjgwsypuatm5eo@3u6k4q7le46s>
	 <418a8a9b-3bcf-4b8f-92a0-619a3bf26ab5@baylibre.com>
	 <e8af0f3f-a09c-42d7-b8ca-dd633539af73@kernel.org>
	 <0279203b6cd9f1312d9c03654c262c04ac12fbd9.camel@gmail.com>
	 <fa27dc74-7b1f-4ef5-81dc-cc434da4ff89@kernel.org>
	 <c721861809c17776c0fe89ead331b6e2e6b9d4b4.camel@gmail.com>
	 <28834db1-3e9e-47f4-b00e-a548589d77e9@kernel.org>
	 <20240929115919.0318034c@jic23-huawei>
	 <ae4cfdfb9880e0a833c105fcb9e9442ef04f461b.camel@gmail.com>
	 <h7ajn5c7f4d7xtjd6jwayen2v5go2vyciwfebikoxlnksodvd2@4dph5nxigi56>
	 <20240930160947.00007c8a@Huawei.com>
	 <80eb0949508d31a55f2b8ab999210a7c7cd5cbe2.camel@gmail.com>
	 <20241001192913.5b848dfc@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-01 at 19:29 +0100, Jonathan Cameron wrote:
> On Tue, 01 Oct 2024 10:23:45 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Mon, 2024-09-30 at 16:09 +0100, Jonathan Cameron wrote:
> > > On Mon, 30 Sep 2024 15:22:01 +0200
> > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > > =C2=A0=20
> > > > On 30.09.2024 09:20, Nuno S=C3=A1 wrote:=C2=A0=20
> > > > > On Sun, 2024-09-29 at 11:59 +0100, Jonathan Cameron wrote:=C2=A0=
=C2=A0=C2=A0=20
> > > > > > On Sat, 28 Sep 2024 14:20:29 +0200
> > > > > > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > > On 25/09/2024 13:55, Nuno S=C3=A1 wrote:=C2=A0=C2=A0=C2=A0=
=20
> > > > > > > > On Wed, 2024-09-25 at 09:22 +0200, Krzysztof Kozlowski wrot=
e:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > On 24/09/2024 14:27, Nuno S=C3=A1 wrote:=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=20
> > > > > > > > > > On Tue, 2024-09-24 at 10:02 +0200, Krzysztof Kozlowski =
wrote:=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > > On 23/09/2024 17:50, Angelo Dureghello wrote:=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > > Hi Krzysztof,
> > > > > > > > > > > >=20
> > > > > > > > > > > > On 22/09/24 23:02, Krzysztof Kozlowski wrote:=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > > > On Thu, Sep 19, 2024 at 11:20:00AM +0200, Angelo
> > > > > > > > > > > > > Dureghello
> > > > > > > > > > > > > wrote:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > > > > From: Angelo Dureghello <adureghello@baylibre.c=
om>
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > There is a version AXI DAC IP block (for FPGAs)=
 that
> > > > > > > > > > > > > > provides
> > > > > > > > > > > > > > a physical bus for AD3552R and similar chips, a=
nd acts
> > > > > > > > > > > > > > as
> > > > > > > > > > > > > > an SPI controller.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > For this case, the binding is modified to inclu=
de some
> > > > > > > > > > > > > > additional properties.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Signed-off-by: Angelo Dureghello
> > > > > > > > > > > > > > <adureghello@baylibre.com>
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > =C2=A0 .../devicetree/bindings/iio/dac/adi,ad35=
52r.yaml=C2=A0=C2=A0 |
> > > > > > > > > > > > > > 42
> > > > > > > > > > > > > > ++++++++++++++++++++++
> > > > > > > > > > > > > > =C2=A0 1 file changed, 42 insertions(+)
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > diff --git
> > > > > > > > > > > > > > a/Documentation/devicetree/bindings/iio/dac/adi=
,ad3552r.
> > > > > > > > > > > > > > yaml
> > > > > > > > > > > > > > b/Documentation/devicetree/bindings/iio/dac/adi=
,ad3552r.
> > > > > > > > > > > > > > yaml
> > > > > > > > > > > > > > index 41fe00034742..aca4a41c2633 100644
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > a/Documentation/devicetree/bindings/iio/dac/adi=
,ad3552r.
> > > > > > > > > > > > > > yaml
> > > > > > > > > > > > > > +++
> > > > > > > > > > > > > > b/Documentation/devicetree/bindings/iio/dac/adi=
,ad3552r.
> > > > > > > > > > > > > > yaml
> > > > > > > > > > > > > > @@ -60,6 +60,18 @@ properties:
> > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/t=
ypes.yaml#/definitions/uint32
> > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum: [0, 1, 2, =
3]
> > > > > > > > > > > > > > =C2=A0=20
> > > > > > > > > > > > > > +=C2=A0 io-backends:
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0 description: The iio backen=
d reference.
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 An example back=
end can be found at
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > > > > > https://analogdevicesinc.github.io/hdl/library/=
axi_ad3552r/index.html
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +=C2=A0 adi,synchronous-mode:
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0 description: Enable waiting=
 for external
> > > > > > > > > > > > > > synchronization
> > > > > > > > > > > > > > signal.
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Some AXI IP con=
figuration can implement a dual-IP
> > > > > > > > > > > > > > layout,
> > > > > > > > > > > > > > with
> > > > > > > > > > > > > > internal
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wirings for str=
eaming synchronization.
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0 type: boolean
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 '#address-cells':
> > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: 1
> > > > > > > > > > > > > > =C2=A0=20
> > > > > > > > > > > > > > @@ -128,6 +140,7 @@ patternProperties:
> > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 - custom-output-range-config
> > > > > > > > > > > > > > =C2=A0=20
> > > > > > > > > > > > > > =C2=A0 allOf:
> > > > > > > > > > > > > > +=C2=A0 - $ref: /schemas/spi/spi-peripheral-pro=
ps.yaml#
> > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 - if:
> > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prop=
erties:
> > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 compatible:
> > > > > > > > > > > > > > @@ -238,4 +251,33 @@ examples:
> > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 };
> > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +=C2=A0 - |
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0 axi_dac: spi@44a70000 {
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 com=
patible =3D "adi,axi-ad3552r";=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > > > That is either redundant or entire example should=
 go to
> > > > > > > > > > > > > the
> > > > > > > > > > > > > parent
> > > > > > > > > > > > > node,
> > > > > > > > > > > > > if this device is fixed child of complex device (=
IOW,
> > > > > > > > > > > > > adi,ad3552r
> > > > > > > > > > > > > cannot
> > > > > > > > > > > > > be used outside of adi,axi-ad3552r).=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > >=20
> > > > > > > > > > > > ad3552r can still be used by a generic "classic" sp=
i
> > > > > > > > > > > > controller (SCLK/CS/MISO) but at a slower samplerat=
e, fpga
> > > > > > > > > > > > controller only (axi-ad3552r) can reach 33MUPS.=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > >=20
> > > > > > > > > > > OK, then this is just redundant. Drop the node. Paren=
t example
> > > > > > > > > > > should
> > > > > > > > > > > contain the children, though.=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=20
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg=
 =3D <0x44a70000 0x1000>;
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma=
s =3D <&dac_tx_dma 0>;
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma=
-names =3D "tx";
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #io=
-backend-cells =3D <0>;
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clo=
cks =3D <&ref_clk>;
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #ad=
dress-cells =3D <1>;
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #si=
ze-cells =3D <0>;
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dac=
@0 {
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,ad3552r";
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 reg =3D <0>;
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 reset-gpios =3D <&gpio0 92 0>;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=20
> > > > > > > > > > > > > Use standard defines for GPIO flags.=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > >=20
> > > > > > > > > > > > fixed, thanks
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 io-backends =3D <&axi_dac>;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=20
> > > > > > > > > > > > > Why do you need to point to the parent? How much =
coupled
> > > > > > > > > > > > > are
> > > > > > > > > > > > > these
> > > > > > > > > > > > > devices? Child pointing to parent is not usually =
expected,
> > > > > > > > > > > > > because
> > > > > > > > > > > > > that's obvious.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > >=20
> > > > > > > > > > > >=20
> > > > > > > > > > > > "io-backends" is actually the way to refer to the b=
ackend
> > > > > > > > > > > > module,
> > > > > > > > > > > > (used already for i.e. ad9739a),
> > > > > > > > > > > > it is needed because the backend is not only acting=
 as spi-
> > > > > > > > > > > > controller,
> > > > > > > > > > > > but is also providing some APIs for synchronization=
 and bus
> > > > > > > > > > > > setup
> > > > > > > > > > > > support.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > But if backend is the parent, then this is redundant.=
 You can
> > > > > > > > > > > take
> > > > > > > > > > > it
> > > > > > > > > > > from the child-parent relationship. Is this pointing =
to other
> > > > > > > > > > > devices
> > > > > > > > > > > (non-parent) in other ad3552r configurations?
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > >=20
> > > > > > > > > > The backend is a provider-consumer type of API. On the =
consumer
> > > > > > > > > > side
> > > > > > > > > > (which
> > > > > > > > > > is the
> > > > > > > > > > driver the child node will probe on), we need to call
> > > > > > > > > > devm_iio_backend_get()
> > > > > > > > > > to get
> > > > > > > > > > the backend object (which obviously is the parent). For=
 that,
> > > > > > > > > > 'io-
> > > > > > > > > > backends'
> > > > > > > > > > is being=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > >=20
> > > > > > > > > You described the driver, so how does it matter? Driver c=
an call
> > > > > > > > > get_backend_from_parent(), right? Or
> > > > > > > > > get_backend_from_fwnode(parent)?=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=20
> > > > > > > >=20
> > > > > > > > Well yes, just stating what the framework (also in terms of
> > > > > > > > bindings) is
> > > > > > > > expecting. Of course that on the driver side we can paper a=
round it
> > > > > > > > the
> > > > > > > > way we
> > > > > > > > want. But my main point was that we can only paper around i=
t if we
> > > > > > > > use
> > > > > > > > code that
> > > > > > > > is meant not to be used.
> > > > > > > >=20
> > > > > > > > And, FWIW, I was (trying) replying to your comment
> > > > > > > >=20
> > > > > > > > "You can take it from the child-parent relationship"
> > > > > > > >=20
> > > > > > > > Again, we can only do that by introducing new code or use c=
ode
> > > > > > > > that's not
> > > > > > > > meant
> > > > > > > > to be used. The way we're supposed to reference backends is=
 by
> > > > > > > > explicitly
> > > > > > > > using
> > > > > > > > the proper FW property.
> > > > > > > >=20
> > > > > > > > Put it in another way and a completely hypothetical case. I=
f we have
> > > > > > > > a spi
> > > > > > > > controller which happens to export some clock and one of it=
's
> > > > > > > > peripherals
> > > > > > > > ends
> > > > > > > > up using that clock, wouldn't we still use 'clocks' to refe=
rence
> > > > > > > > that
> > > > > > > > clock?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > >=20
> > > > > > > I asked how coupled are these devices. Never got the answer a=
nd you
> > > > > > > are
> > > > > > > reflecting with question. Depends. Please do not create hypot=
hetical,
> > > > > > > generic scenarios and then apply them to your one particular =
opposite
> > > > > > > case.=C2=A0=C2=A0=C2=A0=20
> > > > > >=20
> > > > > > I'll throw a possible clarifying question in here.=C2=A0 Could =
we use this
> > > > > > device with a multimaster SPI setup such that the control is on=
 a
> > > > > > conventional
> > > > > > SPI controller (maybe a qspi capable one), and the data plane o=
nly goes
> > > > > > through
> > > > > > a specific purpose backend?=C2=A0 If so, then they are not tigh=
tly coupled
> > > > > > and
> > > > > > the reference makes sense.=C2=A0 Putting it another way, the di=
fference
> > > > > > between
> > > > > > this case and all the prior iio-backend bindings is the control=
 and
> > > > > > dataplanes
> > > > > > use the same pins.=C2=A0 Does that have to be the case at the h=
ost end?=C2=A0 If
> > > > > > it
> > > > > > does,
> > > > > > then the reference isn't strictly needed and this becomes a bit=
 like
> > > > > > registering a single device on an spi bus or an i2c bus dependi=
ng on who
> > > > > > does the registering (which is down to the parent in DT).
> > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > So, we currently have two drivers (with a new one being added in =
this
> > > > > series)
> > > > > for the same device:
> > > > >=20
> > > > > 1) A SPI one tied to a typical spi controller. This is the "low s=
peed"
> > > > > implementation and does not use backends;
> > > > > 2) The new platform device that is connected like this to the bac=
kend.
> > > > >=20
> > > > > So yes, my understanding (but Angelo should know better :)) is th=
at they
> > > > > are
> > > > > tightly coupled. Putting it in another way, the new platform devi=
ce is
> > > > > very much
> > > > > specific to this parent (and yeah, this is a very special usecase=
 where
> > > > > control
> > > > > and data planes are controlled by the IIO backend) and should not=
 exist
> > > > > with it.=C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > ad3552r device can be coupled to the axi-ad3552r controller or to a=
 generic=20
> > > > spi controler.
> > > >=20
> > > > We have actually 2 drivers, SPI and platform (for AXI controller, i=
n this
> > > > patch).
> > > >=20
> > > > Scenario 1 (SPI):
> > > > ad3522r can hypotetically work with whatever simple spi controller =
that can
> > > > read/write registers in raw mode. On simple SPI (CS, SCLK, MOSI), d=
ue to
> > > > ad3552r
> > > > chip limitation of 66Mhz clock, the maximum 33MUPS (16 bit samples)=
 cannot
> > > > be
> > > > reached. Some QSPI DDR controller seems to be around, in that case,=
 ad3552r
> > > > may work extending the SPI driver.=20
> > > >=20
> > > > Scenario 2 (AXI):
> > > > From an hardware-only point ov view axi-ad3552r IP acts as QSPI+DDR
> > > > controller
> > > > plus some additional features for stream synchronization.
> > > > From a sowftware point of view, really different from a spi control=
ler
> > > > driver.
> > > > It's just a backend with APIes that can be called from the child dr=
iver.=C2=A0=20
> > >=20
> > > Potential? scenario 3 is the one that interested me.
> > >=20
> > > ad3552 double wired to a normal SPI controller (so like option 1) and
> > > to a an offload engine (so like option 2).=C2=A0 With a few pull up r=
esistors
> > > (cs and clk?) and some care it should electrically work I think.
> > > In that case we'd need the io-backend reference because the parent
> > > would be the option 1 like SPI bus and the io-backend would not be
> > > the parent.
> > >=20
> > > _______________________
> > > Host=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI MOSI=C2=A0=C2=A0=C2=A0 |=
-------------------\
> > > hard=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI MISO 0-3|---------------=
-\=C2=A0 |
> > > QSPI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI CLK=C2=A0=C2=A0=C2=A0=C2=
=A0 |--------------\=C2=A0 | |
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI CS=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |----------\=C2=A0=C2=A0=C2=A0 | | |
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 | | |
> > > FPGA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 | | |=C2=A0=C2=A0 |
> > > Soft=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI MOSI=C2=A0=C2=A0=C2=A0 |=
-----------|---|-|-x---|
> > > QSPI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI MISO 0-3|-----------|---=
|-x-----|=C2=A0 DAC
> > > Offload=C2=A0=C2=A0=C2=A0 SPI CLK=C2=A0=C2=A0=C2=A0=C2=A0 |----------=
-|---x-------|
> > > with DDR=C2=A0=C2=A0 SPI CS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |----------=
-x-----------|
> > > _______________________|
> > >=20
> > > Makes all sorts of assumptions about the SPI controllers being design=
ed
> > > for multi controllers on the same SPI buses but I'm not aware of a re=
ason
> > > you can't do that.
> > >=20
> > > As the only control message that would need to go over the offload en=
gine
> > > would be the exit DDR (I think) that might be hard coded into a sligh=
tly
> > > simpler soft IP along with the bulk data transfer stuff.
> > > =C2=A0=20
> >=20
> > Not even sure if DDR would be a problem. Right now, I __think__ we need=
 to
> > enable DDR both the peripheral and on the backend. On the peripheral we=
 could
> > use the control link on the non offload controller. On the offload cont=
roller,
> > we would set it through IIO backend and that would be a backend config =
and not
> > go over the bus.
>=20
> It's the path back to SDR that I wasn't sure about as it might need a
> DDR register write?

Ah yeah, I see what you mean now. Yeah, that one access would likely have t=
o go
through the offload capable controller.

- Nuno S=C3=A1



