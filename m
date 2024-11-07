Return-Path: <linux-iio+bounces-11956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8339E9BFB1B
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 02:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1394B1F222AC
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 01:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6882CA9;
	Thu,  7 Nov 2024 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WseDPb/7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE304A28;
	Thu,  7 Nov 2024 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730941224; cv=none; b=DEcdX3ZfQyJr7UO4vkeyIQtmY6Nn/eKSup/ZOhNLJAFzeu/OPJYe8Bk5EJSxZxm8qe4Dz4D6bAca80MzToHfgh3F5cyR9iqqx6Ay4uSdzAoengYx088Ftz+LbpJoSzeyoSrCj3yRGNwF3O59VTgxkkTidxUJqs6unv7+vvNd478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730941224; c=relaxed/simple;
	bh=DgwDbGWVUYpIsW8NRexJ+VzDeyBTqJF2/dVf6oh9iGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psfT9bUtgWWnGr1lLiYjRXMY6iVpume1N5oYzbUXqDdb22HDq0LexIg3oPkN7JUd/gwkdrBOc+aL9dEYpTaXDWV4KsP164AuOB+R3GgwIUpEVRuz/D7T/5MIFvMW4UQpjG+/T1IPa8WEb8Vkt1e9Q7kN91QKHBZBHVcm55q67EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WseDPb/7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ed7d8d4e0so42276166b.1;
        Wed, 06 Nov 2024 17:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730941221; x=1731546021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Bscw2a5Di4J9nIUSX2reCBftf3EfivmNobXBBNgjok=;
        b=WseDPb/7Ee8mJ5jP1CXM0J0V8lngd8FefxHOT8rO48RfU6QT6FGfgtariEWQHUXeP/
         brpNJRRoGD8igWDZVIk45G3JxcOB/4U2uaQfN1ip7Z+hOc43rfrx1rDapEV2dtc6t1Gc
         UKxwMzHwUPn4oktd8xrg+RWnMD7anWSjHRgE9QVS97LANCKlj+P80cdBJKMV+Ri4kC16
         LNPy8WU5jH0vKb2/cEsAMngIF7BUsIK3AyqUqFWuLqCv1WNBmrvM/83HiK/vyEn9fNRo
         K/MRnubokwIEcH1Fi5qrUlaYzbPgg1ShbVQyKyXp83nDaYItKQL5lePzPvGuKQ8QD88q
         FinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730941221; x=1731546021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Bscw2a5Di4J9nIUSX2reCBftf3EfivmNobXBBNgjok=;
        b=BuvrWzX5gAVHD1sX0/G5lnkoTPT/uadO1nYqpdW50qhkuUrD+pW+eOoCjSFHTAHZ30
         B/aXAMOQHX0QyhdCIEzmUGkkkESF/aoPE8VrKePV1XSdFa2mr3B7TVgTuMhsY8WWrF6T
         tAi4hlG82JzIiAeHqM1svk1QV0Bu50HVgdiAtLmwtOXahrldeexbS6su9//K6j7D3Vbt
         6ss54FaQ8r1Qa/jYnqHmRJ/SOCNavgj/M6oBiSJ+PR8thzXSJh5daBpGQQ5edxOuilFk
         OYwb8XRNTfiqlfbGk3HiW0QKoc6yiElRgIwg85eMNRCp+AgHl2PIrk7hT2+bNoO6hwJF
         nI0g==
X-Forwarded-Encrypted: i=1; AJvYcCWg6c5NHLI2wQRbCytFW3ZrJ2+U/xsdVewuWBkFTn7FsuHAahZxQzm34dnhwbTsNAXPOELD+8WwgiRF@vger.kernel.org, AJvYcCWzMNmOuoKxBPYDu6DD+/8VlgIWAH+zbCuX2C7DiLzCPzdrsLC2jDHqMWTACjWYPmgP2+n4bpPVYoqK@vger.kernel.org, AJvYcCX/m+b6kL0UB3fYPdsd/PCt8B5oWPDUhPsyCQHZ00qDsOEcRA27MvQiCeT+gUfFjGDqx4HLPCdAB5G9G4Hr@vger.kernel.org
X-Gm-Message-State: AOJu0YzpD0eZWaKS8dqM8atfNpDrGSbUkm+JQSk1C+ELvsdjut0n+X/O
	Lp7dHVHFdI4qEhX8wrmNJ4j0+r/QwgrCZ0LWDF8e7/FfQcZn5ox5hiV/ycfvCnUGB5xLEYGfzp0
	9O3q3CKniKsugSQldb79PDNsG9Zk=
X-Google-Smtp-Source: AGHT+IHSIeQT9vubg7ty3SAYjKWXRCTIIes7pGvCiElDqr0P60O1t2IH6UmM7NTCRBTOe/LJ4VStqbhbpKJlDEUdzCU=
X-Received: by 2002:a17:906:6a1e:b0:a77:c95e:9b1c with SMTP id
 a640c23a62f3a-a9e654f89b5mr2052327166b.27.1730941221116; Wed, 06 Nov 2024
 17:00:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106023916.440767-1-j2anfernee@gmail.com> <20241106023916.440767-2-j2anfernee@gmail.com>
 <6c20875c-4145-4c91-b3b5-8f70ecb126f0@amperemail.onmicrosoft.com> <20241106-humid-unwired-1d3fa1f50469@spud>
In-Reply-To: <20241106-humid-unwired-1d3fa1f50469@spud>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Thu, 7 Nov 2024 08:59:44 +0800
Message-ID: <CA+4VgcJ9TgDAK6Q0RqBWhiT115nPGHNesYGKKpQyBCgC=rx+BQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add binding for Nuvoton
 NCT720x ADCs
To: Conor Dooley <conor@kernel.org>
Cc: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>, avifishman70@gmail.com, 
	tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com, 
	yuenn@google.com, benjaminfair@google.com, jic23@kernel.org, lars@metafoo.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com, javier.carrasco.cruz@gmail.com, andy@kernel.org, 
	marcelo.schmitt@analog.com, olivier.moysan@foss.st.com, 
	mitrutzceclan@gmail.com, matteomartelli3@gmail.com, alisadariana@gmail.com, 
	joao.goncalves@toradex.com, marius.cristea@microchip.com, 
	mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com, 
	yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Conor Dooley,

Thank you for your response.

NCT7201 supports 8 voltage monitor inputs while NCT7202 supports 12
voltage monitor inputs.
NCT7201 and NCT7202 provide SMBus to access the internal register, and
support SMBus byte write and byte/word read protocols.

Conor Dooley <conor@kernel.org> =E6=96=BC 2024=E5=B9=B411=E6=9C=887=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:13=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Nov 06, 2024 at 11:58:06AM +0700, Chanh Nguyen wrote:
> >
> >
> > On 06/11/2024 09:39, Eason Yang wrote:
> > > This adds a binding specification for the Nuvoton NCT7201/NCT7202
> > > family of ADCs.
> > >
> > > Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> > > ---
> > >   .../bindings/iio/adc/nuvoton,nct720x.yaml     | 47 ++++++++++++++++=
+++
> > >   MAINTAINERS                                   |  1 +
> > >   2 files changed, 48 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoto=
n,nct720x.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720=
x.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
> > > new file mode 100644
> > > index 000000000000..3052039af10e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
> > > @@ -0,0 +1,47 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct720x.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Nuvoton nct7202 and similar ADCs
> > > +
> > > +maintainers:
> > > +  - Eason Yang <yhyang2@nuvoton.com>
> > > +
> > > +description: |
> > > +   Family of ADCs with i2c interface.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - nuvoton,nct7201
> > > +      - nuvoton,nct7202
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  read-vin-data-size:
> >
> > Is it generic property or vendor property? I tried to find in the
> > https://github.com/torvalds/linux/tree/master/Documentation/devicetree/=
bindings
> > , but it seems this property hasn't been used on other devices.
> >
> > If it is vendor property, then I think it should include a vendor prefi=
x.
> > For examples:
> >
> > https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/iio/adc/adi%2Cad7780.yaml#L50
> > https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/iio/adc/fsl%2Cvf610-adc.yaml#L42
> > https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/iio/adc/st%2Cstmpe-adc.yaml#L22
>
> An explanation of why it cannot be determined from the compatible would
> also be good. Two compatibles and two values makes me a little
> suspicious!

