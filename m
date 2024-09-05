Return-Path: <linux-iio+bounces-9181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F4596D3F3
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 11:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FA01C20A69
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 09:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B061991B0;
	Thu,  5 Sep 2024 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK0bb7+M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7627194AC7;
	Thu,  5 Sep 2024 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529603; cv=none; b=j3hVVTvQR9k7GJ1hc2wzqNEY+mzb/URTl+SgfqaI8tksh+IiCxBn6dwiHeVRbUVB/baMDAS85E60caw1cfPSHAsfnXDdY90pzTpBV4nY67rJ1QhNP8H7TGA9dI62SLcrIF1rS7mUt47CxMfnK2SdaDL7jzpFIUebs8dVnDbxyao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529603; c=relaxed/simple;
	bh=hfyLaFfMkYpNRtL4fR5wRcnbCnNmAquAnd9wooE+JoY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QA6km7BvSm3+shaLs39Ug4fig5eQTS4ZnMUDdUPoz+FGGv1atFmhLwyU9Vt0yP9eZTXCXlKo9YZrqeJ6a6BS1//2HZE2pCSeCgEvPIrqCTCVZTuBuu8W+mGKg596ijQ0lThUtMzxfTwk6Z53rGc25lH6gDkHBAGYmn9qrBYMD3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK0bb7+M; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-533de5a88f8so411052e87.3;
        Thu, 05 Sep 2024 02:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725529600; x=1726134400; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hfyLaFfMkYpNRtL4fR5wRcnbCnNmAquAnd9wooE+JoY=;
        b=lK0bb7+MkXqw+yoSznoZF5ONQGHdIvLO7gUKa48JDDLwqVV0DK9zErn3sxf3IvSRQB
         X3MRtQ1Xuih1AAotKvu5nwKryGwrrCOvf/S34OQh29Ra7sUOJiAVwHxVeKXMCGTuggTI
         C4VlTWJ0jdDJoKbZ/GG9+xzogAKf8XvvJsmcfe/8m7PLfsNb7urIcBVZ4YBp90G1semf
         kE8ww1wPEoy5V4FinB9OpRhKZ/8R2QTIdKP0ItKWPej8SN3N1oscUUuvAwPVsT2iC/xM
         7FJ1bwAebLeejgV6/AW3seLmMhcw+m/G5r3VIdVpJW+I4wLUFfmFYDcGPdJ2TVYoEcyj
         g4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725529600; x=1726134400;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfyLaFfMkYpNRtL4fR5wRcnbCnNmAquAnd9wooE+JoY=;
        b=b67m8CTqYH890D+p5+oBBiUGzxq1TTCCylH13DacGGmStdQkaxbKzOYKo1cuoxTo0A
         qcxJrpZ1/z8SbekCVOsmxjTijjxSaIpnFvvc9XTxLE5KhJ+7DrkgR/3I3D/Zr8lbf3AL
         h6DRGtZaAvMWvdVDvNJf103/7rDhXJvVaKMyXrlyOn1Ir9dFLuui9J+gWUYuC+q70UUF
         zYyG2Jq+/rl/sWyBgVcg9NN0Q9+LMse2HIPftGB/dN98gVussmQlD7ZxzI737Ut2523T
         D8PHGrU+Sg9/S5CpC7sYin083u2JK+i9SChGWcvl9BvmAcjAyjSRnFWabqKNxQwdfx9j
         RGXg==
X-Forwarded-Encrypted: i=1; AJvYcCVzUn0iB9tOv/c4qAKkl0oa2nmzu+ClhH55fWOxIDCJtHJOdfeq9a4J8Jh5QGXW5yN1qF7KdyZPKdy/@vger.kernel.org, AJvYcCXe6TFWPnWX3HNjVKB3pD0HJXdAoysGmNX5NFQvmySLsvpwjyvhXFFxSwtD9NZ87c0MdBI7xgG2LiYzPXD7@vger.kernel.org, AJvYcCXyrhY1ijd8nbRe/yK3c9b8CEWL+NUVU3S7nbx0kPpfcC02f4+9sTw4SDwsCBBMFs1hOYCwNo3bPlY7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy29fuLilkIOr4b3iEBfpoi2H+L9U47qXKrAk/uhVrAFVWrZEm
	kJt3MvdR3oAPQ264gPFhV2ziEIyQUpAuQ126sFATvCFXLm0Ws1WZ
X-Google-Smtp-Source: AGHT+IFo1Up3OyHVy39h81UAR8Z2KOYVfLj1evigl5cnWjFtkgT8ubvK5n+0l8M/bVE8AJc4AjVq0Q==
X-Received: by 2002:ac2:568f:0:b0:536:14a1:d645 with SMTP id 2adb3069b0e04-53614a1d756mr1333730e87.44.1725529598877;
        Thu, 05 Sep 2024 02:46:38 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d290sm111882666b.116.2024.09.05.02.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 02:46:38 -0700 (PDT)
Message-ID: <642d61b23c58d9b846e42badb2f2d97691c92144.camel@gmail.com>
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
Date: Thu, 05 Sep 2024 11:50:45 +0200
In-Reply-To: <20240830-quilt-appointee-4a7947e84988@spud>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	 <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
	 <20240829-stopwatch-morality-a933abb4d688@spud>
	 <d4eddc24-9192-4a4a-ac67-4cfbd429a6a9@baylibre.com>
	 <20240830-quilt-appointee-4a7947e84988@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-30 at 16:33 +0100, Conor Dooley wrote:
> On Fri, Aug 30, 2024 at 10:19:49AM +0200, Angelo Dureghello wrote:
> > Hi Conor,
> >=20
> > On 29/08/24 5:46 PM, Conor Dooley wrote:
> > > On Thu, Aug 29, 2024 at 02:32:02PM +0200, Angelo Dureghello wrote:
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> > > > Add bus property.
> > > RFC it may be, but you do need to explain what this bus-type actually
> > > describes for commenting on the suitability of the method to be
> > > meaningful.
> >=20
> > thanks for the feedbacks,
> >=20
> > a "bus" is intended as a generic interface connected to the target,
> > may be used from a custom IP (fpga) to communicate with the target
> > device (by read/write(reg and value)) using a special custom interface.
> >=20
> > The bus could also be physically the same of some well-known existing
> > interfaces (as parallel, lvds or other uncommon interfaces), but using
> > an uncommon/custom protocol over it.
> >=20
> > In concrete, actually bus-type is added to the backend since the
> > ad3552r DAC chip can be connected (for maximum speed) by a 5 lanes DDR
> > parallel bus (interface that i named QSPI, but it's not exactly a QSPI
> > as a protocol), so it's a device-specific interface.
> >=20
> > With additions in this patchset, other frontends, of course not only
> > DACs, will be able to add specific busses and read/wrtie to the bus
> > as needed.
> >=20
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > ---
> > > > =C2=A0 Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml |=
 9
> > > > +++++++++
> > > > =C2=A0 1 file changed, 9 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.=
yaml
> > > > b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > index a55e9bfc66d7..a7ce72e1cd81 100644
> > > > --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > @@ -38,6 +38,15 @@ properties:
> > > > =C2=A0=C2=A0=C2=A0 clocks:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > You mentioned about new compatible strings, does the one currently
> > > listed in this binding support both bus types?
>=20
> You didn't answer this, and there's insufficient explanation of the
> "hardware" in this RFC, but I found this which is supposedly the
> backend:
> https://github.com/analogdevicesinc/hdl/tree/main/library/axi_ad3552r
> adi,axi-dac.yaml has a single compatible, and that compatible has
> nothing to do with "axi_ad3552r" as it is "adi,axi-dac-9.1.b". I would
> expect either justification for reuse of the compatible, or a brand new
> compatible for this backend, even if the driver can mostly be reused.
>=20

Hi Conor,

So most of these designs have some changes (even if minimal) in the registe=
r map
and the idea (mine actually) with this backend stuff was to keep the backen=
d
driver (axi-dac/adc) with the generic compatible since all the (different)
functionality is basically defined by the frontend they connect too and tha=
t
functionality is modeled by IIO backend ops. For some more
significant/fundamental differences in the IP like this bus controller kind=
 of
thing, we would add have proper FW properties. The main idea was kind of us=
ing
the frontend + generic backend combo so no need for new compatibles for eve=
ry
new design.

It's still early days (at least upstream) for these IP cores and the backen=
d
code so if you say that we should have new compatibles for every new design=
 that
has some differences in the register map (even if minimal), I'm of course f=
ine
with it. I've done it like this because I was (am) kind of afraid for thing=
s to
get complicated fairly quickly both in the bindings and driver (well maybe =
not
in the driver). OTOH, it can simplify things a lot as it's way easier to
identify different implementations of the IP directly in the driver so we h=
ave
way more flexibility.

> Could you please link to whatever ADI wiki has detailed information on
> how this stuff works so that I can look at it to better understand the
> axes of configuration here?
>=20
> > >=20
> > > Making the bus type decision based on compatible only really makes se=
nse
> > > if they're different versions of the IP, but not if they're different
> > > configuration options for a given version.
> > >=20
> > > > +=C2=A0 bus-type:
> >=20
> > DAC IP on fpga actually respects same structure and register set, excep=
t
> > for a named "custom" register that may use specific bitfields depending
> > on the application of the IP.
>=20
> To paraphrase:
> "The register map is the same, except for the bit that is different".
> If ADI is shipping several different configurations of this IP for
> different DACs, I'd be expecting different compatibles for each backend
> to be honest.

Yes, pretty much we have a generic core with most of the designs being base=
d on
it but with some slight differences. At least for the new ones, almost all =
of
them have slight deviations from the generic/base core.

> If each DAC specific backend was to have a unique compatible, would the
> type of bus used be determinable from it? Doesn't have to work for all
> devices from now until the heath death of the universe, but at least for
> the devices that you're currently aware of?
>=20

My original idea was to have a bus controller boolean for this core at leas=
t for
now that we only have one bus type (so we could assume qspi in the driver).=
 If
the time comes we need to add support for something else, then we would nee=
d
another property to identify the type.

> > > If, as you mentioned, there are multiple bus types, a non-flag proper=
ty
> > > does make sense. However, I am really not keen on these "forced" nume=
rical
> > > properties at all, I'd much rather see strings used here.
>=20
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +=C2=A0=C2=A0=C2=A0 description: |
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Configure bus type:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 0: none
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 1: qspi
>=20
> Also, re-reading the cover letter, it says "this platform driver uses a 4
> lanes parallel bus, plus a clock line, similar to a qspi."
> I don't think we should call this "qspi" if it is not actually qspi,
> that's just confusing.
>=20

Just by looking at the datasheet it feels like typical qspi to be honest. A=
nd,
fwiw, even if not really qspi, this is how the datasheet names the interfac=
e.

- Nuno S=C3=A1
> >=20


