Return-Path: <linux-iio+bounces-9240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF5196F317
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 13:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51C61C23BAD
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E421CB323;
	Fri,  6 Sep 2024 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjNoWoJ+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320DA1C8FC7;
	Fri,  6 Sep 2024 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622133; cv=none; b=fIYE4oT1cag1qYaDS2R/ap2H4jRUygWGrqOCq3k99q0ImP8V5JgTM+410WH+XORg/Qob3fhHo+9XQl91/RYdAlLg607hsvstRZv9Zty2li4vPmy/ofbyEYg7LtAnqRh4PmD30wrLrXyH+i+kW/Xf3uJDGFkxkNGB8KVd41DxaJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622133; c=relaxed/simple;
	bh=h2BwmsLqnBZi/O0rfSrzNQtY6RpexflVeJk38tkZrCc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dyJQ6BLTDr3Ap75nOhc1oHV+CEA41wUtGn5J0SXh5jEG/gSW2rjl3Ue92Uptm+ktwwRUZv9HHKhUaZVF1/oay5kZQOD5p5edKXVhMBZdO3C33yy9KlAFNmCAXhqM+kA4a1Lg2BeXHHmZQWP8H1s9KWcm7jkgUrXXgDfD1pD4pAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjNoWoJ+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42ca573fd5aso2797735e9.3;
        Fri, 06 Sep 2024 04:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725622129; x=1726226929; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h2BwmsLqnBZi/O0rfSrzNQtY6RpexflVeJk38tkZrCc=;
        b=mjNoWoJ+TBuW/kEMnGnHNB2jf5UzhQ2Js5vKwxTMSe24dpI/cXuwVB33upsmkM0H3T
         NZhZyQ5rwPeCC9+s7bv7UgGTRjzMivTsQGZk8TrBlHiWTzeHcqgHV10vRIDwuVc9QENd
         X+HwDWmF6YtA1WPibiW0nMDESSfDUcoZj8BFNs9stc3wAGM32WEx3WYCqAdOqHQ8U7QU
         0nwAEDeGINkYjHm86zISdgfYpyudpPVSljYFGY4k7ilPhre9AvSqq6SxzdJH1CyPTL/l
         sw0Mb2ejRwDqw/IHKuvQ/0DqL02JN2l6YitGQRreJ8TOmbIgiLBvFcU9MJH18AyhU+no
         KH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725622129; x=1726226929;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2BwmsLqnBZi/O0rfSrzNQtY6RpexflVeJk38tkZrCc=;
        b=Ymt2Y8K+qROdOAxuF75eS/iNYwRLhG3WfW8keQM80J1/7YcL0vf9js3n1S/AGpnM8X
         kCXOkcxxjSl763TgH6ciMkDWISm1EZLSDAqha/1Ae+ojwT4s/4uSXHKNMylmVgrHh+LQ
         HfK5F/aXS1hZxMu0Cw5nm+si75h0BF0uWxtIf4M3IjkNTheusJSf+RfC5vKz/dUSoVBn
         ziSBKvqjcEQaPBzY382uG8MDqJGkpc6ARuqiQrlUma6OMgeVIfjEllu+Xhzx+eKfrLgA
         Ld5chizTp6xE8Eb+Yetz5Vi6kRPP18KZC9E3L46My7A1GeyIMzgCTC1qEPsHOJ5ZKhNn
         RO9A==
X-Forwarded-Encrypted: i=1; AJvYcCUOTWpRKv2okS9MAwK9b1ZGZ0OkAvIV7qqI4chZJn1CvENMB48Dmney4XlumzONK865zJ40EHkxTXqc@vger.kernel.org, AJvYcCVGK5ckTjc4Fj5A8OfcFObvD/Kcz5kS7yZQKN1LgwUsk7uGVVHFqKRg5X38gPQ4F3KyDN511P5KuLKF@vger.kernel.org, AJvYcCVwnEiA4BBpKYBy7R25sc1YR5eX20Div60enWYnmTQt1/5msWozEVvoYdrIrzdJhKFnTX0GIBaOuwHj41mX@vger.kernel.org
X-Gm-Message-State: AOJu0YwOeNt3x/nmpZExJsAqL8MsAOCKvZ56setG1N+h7Yb6kVAqUHTU
	29TTS+gHsIb+Guo9Oa7uXoqyKuPoBgJNyPU/HYkg4cJ8p0TasF5E
X-Google-Smtp-Source: AGHT+IFqDdBT74KUeRHDqybxr+c6MGdsKLZfH4U5iX63KW9ptnbblWxA4TMe/lj9qkE07U6CJeoqnw==
X-Received: by 2002:adf:cd8f:0:b0:374:c2e9:28ad with SMTP id ffacd0b85a97d-378895c32c8mr1703051f8f.1.1725622128539;
        Fri, 06 Sep 2024 04:28:48 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3788954e91csm1643810f8f.37.2024.09.06.04.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:28:48 -0700 (PDT)
Message-ID: <663d8fb31af246d30c0bace18dce6b988a06d0ba.camel@gmail.com>
Subject: Re: [PATCH RFC 4/8] dt-bindings: iio: dac: add adi axi-dac bus
 property
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlechner@baylibre.com
Date: Fri, 06 Sep 2024 13:28:47 +0200
In-Reply-To: <20240906-reveler-waggle-8a7043690633@squawk>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	 <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
	 <20240829-stopwatch-morality-a933abb4d688@spud>
	 <d4eddc24-9192-4a4a-ac67-4cfbd429a6a9@baylibre.com>
	 <20240830-quilt-appointee-4a7947e84988@spud>
	 <642d61b23c58d9b846e42badb2f2d97691c92144.camel@gmail.com>
	 <20240906-reveler-waggle-8a7043690633@squawk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-06 at 09:50 +0100, Conor Dooley wrote:
> On Thu, Sep 05, 2024 at 11:50:45AM +0200, Nuno S=C3=A1 wrote:
> > On Fri, 2024-08-30 at 16:33 +0100, Conor Dooley wrote:
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
> > > >=20
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
> > > > > > =C2=A0 Documentation/devicetree/bindings/iio/dac/adi,axi-dac.ya=
ml | 9
> > > > > > +++++++++
> > > > > > =C2=A0 1 file changed, 9 insertions(+)
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
> > > > > > =C2=A0=C2=A0=C2=A0 clocks:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > You mentioned about new compatible strings, does the one currentl=
y
> > > > > listed in this binding support both bus types?
> > >=20
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
> >=20
> > Hi Conor,
> >=20
> > So most of these designs have some changes (even if minimal) in the reg=
ister map
> > and the idea (mine actually) with this backend stuff was to keep the ba=
ckend
> > driver (axi-dac/adc) with the generic compatible since all the (differe=
nt)
> > functionality is basically defined by the frontend they connect too and=
 that
> > functionality is modeled by IIO backend ops. For some more
> > significant/fundamental differences in the IP like this bus controller =
kind of
> > thing, we would add have proper FW properties. The main idea was kind o=
f using
> > the frontend + generic backend combo so no need for new compatibles for=
 every
> > new design.
> >=20
> > It's still early days (at least upstream) for these IP cores and the ba=
ckend
> > code so if you say that we should have new compatibles for every new de=
sign that
> > has some differences in the register map (even if minimal), I'm of cour=
se fine
> > with it. I've done it like this because I was (am) kind of afraid for t=
hings to
> > get complicated fairly quickly both in the bindings and driver (well ma=
ybe not
> > in the driver). OTOH, it can simplify things a lot as it's way easier t=
o
> > identify different implementations of the IP directly in the driver so =
we have
> > way more flexibility.
>=20
> Most of my opinion on this from a usability perspective for your
> customers, rather than how the kernel is going to handle it. If a user
> is inserting a preconfigured instance of the IP, for a specific ADC or
> DAC, into their design I think it makes more sense to have a compatible,
> rather than expect the user to reverse engineer how the IP has been
> configured and which properties they should select. My own policy for
> Microchip's stuff is that if something has a name or entry in the IP
> catalogue then it should have a dedicated compatible, even if it is just =
a
> preconfigured version of some other IP block and I guess what I am
> saying here is an extension of that.
>=20

Hmm, indeed the above makes sense...

> I suspect that in many cases the specific compatible won't be required,
> and a fallback to the generic one will suffice for the driver, and it
> would only be for cases like this, that have "significant/fundamental
> differences" that the driver would need the specific one.
>=20

Hopefully yes :)

> >=20
> > > Could you please link to whatever ADI wiki has detailed information o=
n
> > > how this stuff works so that I can look at it to better understand th=
e
> > > axes of configuration here?
> > >=20
> > > > >=20
> > > > > Making the bus type decision based on compatible only really make=
s sense
> > > > > if they're different versions of the IP, but not if they're diffe=
rent
> > > > > configuration options for a given version.
> > > > >=20
> > > > > > +=C2=A0 bus-type:
> > > >=20
> > > > DAC IP on fpga actually respects same structure and register set, e=
xcept
> > > > for a named "custom" register that may use specific bitfields depen=
ding
> > > > on the application of the IP.
> > >=20
> > > To paraphrase:
> > > "The register map is the same, except for the bit that is different".
> > > If ADI is shipping several different configurations of this IP for
> > > different DACs, I'd be expecting different compatibles for each backe=
nd
> > > to be honest.
> >=20
> > Yes, pretty much we have a generic core with most of the designs being =
based on
> > it but with some slight differences. At least for the new ones, almost =
all of
> > them have slight deviations from the generic/base core.
> >=20
> > > If each DAC specific backend was to have a unique compatible, would t=
he
> > > type of bus used be determinable from it? Doesn't have to work for al=
l
> > > devices from now until the heath death of the universe, but at least =
for
> > > the devices that you're currently aware of?
> > >=20
> >=20
> > My original idea was to have a bus controller boolean for this core at =
least for
> > now that we only have one bus type (so we could assume qspi in the driv=
er). If
> > the time comes we need to add support for something else, then we would=
 need
> > another property to identify the type.
>=20
> With a specific compatible, you can "easily" add different defaults. So
> the other devices could default to no bus when a bus related property is
> required and this one could default to qspi. But unless there are
> ADCs/DACs that have a backend that can be configured with different
> types of bus, a property for this wouldn't be needed - the compatible
> and match data would suffice.
>=20

Agreed...

- Nuno S=C3=A1

> > > > >=20


