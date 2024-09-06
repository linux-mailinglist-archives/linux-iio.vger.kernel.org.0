Return-Path: <linux-iio+bounces-9242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F59096F3AE
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 13:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5811C244EA
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 11:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D66E1CE6EF;
	Fri,  6 Sep 2024 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpbhRyAK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3EB1CC888;
	Fri,  6 Sep 2024 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623607; cv=none; b=jH97LRWUQ2a43qgMbZCJH0u4h74f8xaqlyPe0UNPwUl9oIO6DmojzDpJo0C9SC7MWiQHAOTqBqjusvb74n/i6xxK9r++qeg3ClS8x3xVTwLJYxgd3p8BhKEwASBCm8/TTM51sOjLZf74SMK4rEHwwlfeMC9YvGIbOu81dEe199o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623607; c=relaxed/simple;
	bh=KSC9Nf3WlQGez4ngDNcCyUPpfpGRvdn+P7QJ9LxWO1c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ghbgci0Fn6RGaZ6H4Yw+kiabrMLtDuyilDQu/+BCMIjALOexuGcx3hYFdeUfAop78ZYtaZRzFtgVTZPAw6ZKZFSjyUgWyl42NheghgGt4aWkqGvvd/v3F1hSCRxduh0mresJyotQ9gsJalr7bPII0f137OnfkbdOTRroyByw1xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpbhRyAK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374bd0da617so1087604f8f.3;
        Fri, 06 Sep 2024 04:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725623604; x=1726228404; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KSC9Nf3WlQGez4ngDNcCyUPpfpGRvdn+P7QJ9LxWO1c=;
        b=fpbhRyAK4Y9HIqwFNudgoSV7WH7hTlQaieXH8VWXU+Cv63y6w8AWVaDmKLWRAQzcr0
         Mp34hIxIqM7uAacmx5IOJq4H7tVYo2mh6tk39irNQMH/7Lksg8nR1YzLmzuIUjp4IlCt
         D+ff9Vizo/N1VKs/zRCTfjE4Aia/pm5cME6mSjxq0tZqU7SPn0FO3XDXNyz8GIWwD4Qn
         BL3lAEC4Ym8r0u2611GOLAeMusgwSNOa5R8qvwWHGYF6MKwB+72W78AOQZg+qfIDaFVv
         glC8azMObWS3N8Aju7HY8xZavYGHYT9WF38TUByI7esCv36p4C458drDd4heKmBfC8b/
         n6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623604; x=1726228404;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KSC9Nf3WlQGez4ngDNcCyUPpfpGRvdn+P7QJ9LxWO1c=;
        b=skuxYClgF0CjU7C6xDADKDNff46/JioQeQ3B6pmOLouvcxFJIbDCu3tyr1mSVicCgv
         d9P9OqZJeQ1sEf9VXs0IajcMwbG36o1gvPEQ7cK3+pO2HqfO8KOqzCYGUTUyW9dZOYtN
         24btHlHOujMoC/4bjwdxT1BOz482KFekgIKNjFPPShXq54dkUnk1oPnTtISbRnMSWK6Q
         gE/twc+N0ofuZlqjuSYXdxb+lUjZRZpt8MZiQUbD61DU3iTBA2N4NdFktIDy5fUpOCZp
         eOZqQD7ZC7nE/gUQXHAwx2KcOIUAfUxLp3KiZHvajFlu4A86m8FDioofBpAwIVQnisHX
         8axQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqX99vjq3GhqbV0rgAo4ooEvlD4TBhMhr6lQ7HubryrLtsUq7botb3k1qHtNh6Fn448amK6osocK5NZyRb@vger.kernel.org, AJvYcCW0NWdrYJepEgd8CFrISxufAJxiw0deMDaBS+mpoFADADFP0wAUAtKDqBnJ/NILFe2yxtDeWND9G5hd@vger.kernel.org, AJvYcCXxn5F2f1iFsfq+i73j0nz/E2CYbr1GEi0EVZi8AgntJ77T3UHku8REsScSQjYgjk/WvtDeNNM7c2yn@vger.kernel.org
X-Gm-Message-State: AOJu0YxjDVRak2Mgo3IYXklQCFUQNU1R6lk896vJAc2s6eBqhIWTGcvw
	6wXLlueqJ5h53J29CtzqOaDYYocj7o5s4Z3ZLVeIIihekA+0Q5es
X-Google-Smtp-Source: AGHT+IFl5HjqKgtqh+fb58lJhfu7d1Mkenyc6sw3dP4clRYllNpnSYITsEytxbyKR15bszKvq0csZg==
X-Received: by 2002:a05:6000:4007:b0:378:7e94:d613 with SMTP id ffacd0b85a97d-37889682ae1mr1785635f8f.42.1725623603696;
        Fri, 06 Sep 2024 04:53:23 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374ba593876sm17883712f8f.5.2024.09.06.04.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:53:23 -0700 (PDT)
Message-ID: <058937fa93d484f3e81807d08a39bd8dfd3358e8.camel@gmail.com>
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
Date: Fri, 06 Sep 2024 13:53:22 +0200
In-Reply-To: <1928d0ce-cad9-4737-880e-3759c47fddbc@kernel.org>
References: 
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-5-87d669674c00@baylibre.com>
	 <boahpvyzzmocnnpae2u6meub34yvqr2q3v5pzf2egp2fretlwk@ibas62hdypwo>
	 <fd3f4874-b410-4e98-acba-d0fac041a40e@baylibre.com>
	 <1928d0ce-cad9-4737-880e-3759c47fddbc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-06 at 11:37 +0200, Krzysztof Kozlowski wrote:
> On 06/09/2024 11:11, Angelo Dureghello wrote:
> > Hi Krzysztof,
> >=20
> > On 06/09/24 9:22 AM, Krzysztof Kozlowski wrote:
> > > On Thu, Sep 05, 2024 at 05:17:35PM +0200, Angelo Dureghello wrote:
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> > > > Add a new compatible for the ad3552r variant of the generic DAC IP.
> > > >=20
> > > > The ad3552r DAC IP variant is very similar to the generic DAC IP,
> > > > register map is the same, but some register fields are specific to
> > > > this IP, and also, a DDR QSPI bus has been included in the IP.
> > > >=20
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > ---
> > > > =C2=A0 Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml |=
 1 +
> > > > =C2=A0 1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.=
yaml
> > > > b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > index a55e9bfc66d7..c0cccb7a99a4 100644
> > > > --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > > @@ -24,6 +24,7 @@ properties:
> > > > =C2=A0=C2=A0=C2=A0 compatible:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,axi-dac-9.1.b
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,axi-dac-ad3552r
> > > I am sorry, but what is the product here? It looks like either wrong
> > > order or even completely redundant. What is ad3552r?
> > >=20
> > > And why versions are mixed with real products but without any
> > > compatibility. What does the version express in such case?
> >=20
> > dac-ad3552r IP (fpga) is a variant of the dac IP, very similar,
> > about the version, it still reads as 9.1.b
> >=20
> > so i can eventually change it to:
> >=20
> > adi,axi-dac-ad3552-9.1.b
> >=20
> > Should be more correct.
>=20
> No. First ad3552r is the product, so axi-dac is redundant. Second why
> adding versions if you have product names? Versioning was allowed
> because apparently that's how these are called, but now it turns out it
> is not version but names.
>=20

Let me try to explain on how this whole thing works...

We have a generic FPGA IP called axi-dac (same story is true for the other =
axi-adc
IP) which adds some basic and generic capabilities like DDS (Direct digital
synthesis) and the generic one is the compatible existing now. This IP is a=
 so called
IIO backend because it then connects to a real converter (in this case DACs=
)
extending it's capabilities and also serving as an interface between anothe=
r block
(typical DMA as this is used for really high speed stuff) and the device. N=
ow,
depending on the actual device, we may need to add/modify some features of =
the IP and
this is what's happening for the ad3552r DAC (it's still build on top of th=
e base
generic axi-adc). And in this design the IP is also acting as a qspi contro=
ller for
actually controlling the configuration of the device while, typically, IIO =
backends
are meant to only care about the dataplane. With all of this, there are dis=
cussions
still happening on the RFC (Angelo was too fast with this version) between =
using
different properties or new compatibles for changes so significant like thi=
s on the
generic IP. See the thread where Conor is also involved.

> Third, versions are useless if you do not use them as fallbacks.
>=20

In this particular case we can't use the generic IP as a fallback since wit=
hout the
bus controller feature the device can't really work. But it can happen we i=
ncrease
the version on the generic core and use the existing version as fallback=
=20

> Something this is really broken and I don't know if the binding or this
> patch.

Having said the above, I'm really not sure if what we have is the best appr=
oach but
these are also early days (upstream) for this so we should still be able to=
 change
things if we need too. I'm fairly sure there's still no one relying on this=
 so we
should be able to change things in a breaking way (if we need to be that ex=
treme).

Thanks!
- Nuno S=C3=A1

