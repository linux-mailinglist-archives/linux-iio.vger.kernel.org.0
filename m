Return-Path: <linux-iio+bounces-12759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAC79DB168
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 03:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C66165A72
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 02:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4211F45038;
	Thu, 28 Nov 2024 02:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVViUJ5v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5E138DFC;
	Thu, 28 Nov 2024 02:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732760091; cv=none; b=DOqZ/Z7YxP9+vA6aZiEE65bluq429ypMnxujdbTO8EyNgcb/qJX5QngHWS67aN5hnqFWxQkfjgjPlLWg9UKuvPmuyPnjKx5grMBfI+Z9DyMGWnyPCr8FbMKv8tS9+Rf2BzEfJe3uyAHAY0AVQwoSm75844Zx8lVIXeJ/EtOdcn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732760091; c=relaxed/simple;
	bh=iTXRTO5/t9b+SiHLQegmxfbBLD+ZJOd1KUvlydOJn1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTIVwXK+4QP+ZmtHxEiHb2gkF3r4gyMmE+AmvGREdT6SG8eILBg5WrqymY1gT3xAl2B6q2fNujb01szpW6us1KJc9WDN7BM08JOIu4eIWlPVS5I7VzIZ+cu0QYCxWz62eIZr3Frl/ovnPHVCLhxm5dIuY5tAvSwsAte+kp4UHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVViUJ5v; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso53854966b.2;
        Wed, 27 Nov 2024 18:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732760087; x=1733364887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwS2jBVSzXTYuNe3+UBBZ+0Uj62YFOtE1/FiTJBmwPY=;
        b=UVViUJ5vaiPixXRlnF0DrRZn4j49nlr3USpCGQF6vDR5aRDS9Jhk8u0ZCho3TmFnYQ
         o32qo5VUWDkrv2oaof2fRYsDCFfrVovZByTlATMV7dVe6T0U3sRJs8Bj/ooVFL5qM9W9
         I4LxO3zKGnHg4c3D9wJsKSfNYqWzr0im5j3c8zslpWV6HjC6CnYA3EJPQKB5g3sHc9kW
         CcrmM0UBqnUxg3pAFCHq8cfZaUbYCsXqPHQlGq/+/gwHehO89vSrl3+uiOEA8ymRQRav
         hZGmab1YY3IFf5WE2ullForrBJ7Qxu1VcLrvfvbPiy/0nnxFLBL44hPfP9uryPLoX7z4
         YiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732760087; x=1733364887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwS2jBVSzXTYuNe3+UBBZ+0Uj62YFOtE1/FiTJBmwPY=;
        b=lukNzxlKvwJGetAucsqJcLsprk1Tgl0rvXSPfAG65ZwLFAIzACkdu9jnByq3rdi0AL
         4ZfYVGgefrsHIKCnvM3DPxDC5oaaJA2thjMmplB4NVK7P8PK+jc6TEFQTdj7ct0MHpYV
         sSDItdj0LYeNsbOQlRNUn6O/mWqKLUvuHtsNs8uhhdttUB8vmIie2M/Wkeo1Ip6Ndgaj
         c3d7nkVDBnPb+iQBe1xCWXHbFfJUdR9TJcRKyPTAvfm9WHbUfkOA2kX3u+Eh3xZchTAA
         m+qVET/SglfhFmz1KC5mmvKiCT9dxxX4gwXLVVsRA2S/yZReWUpYNZY3YG53VQDiJHtk
         P9gA==
X-Forwarded-Encrypted: i=1; AJvYcCUcktHfvR/GXO2pz5dRdQqHuM2oQ7IzLsHylehPqej3dkEZ/N7ynIxqyBTbV33e6zVg0Yt7o6SI0lI4JKro@vger.kernel.org, AJvYcCWck5/9zFsX2C2JwII9zgVSnto/abA5LzGDkggp+ufLbpDyoKRGxHC5QRQH9Re+LgcaPapG7F8aWHfX@vger.kernel.org, AJvYcCWyLrwUAZ4ynLOyextGOCuaJp89AeoWgyAmqupyAF1ozwxvIVyMGDjPcEVQUBdTpFHNzDJaryEpY84l@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6faL+14u0U0rlkZIKqIPZ5z/6KBUMZh84+nfCmKybeDgGd9Q2
	kiryz8MvWUrSrpU/ANOLR/7qSKRbpYez+e1EaGcscTVxMCtmXPGOrrNmu6t6LKzMRzuDlF7Yf02
	YcF+tLgC34VeHRZwFG+vqfrX9Bxg=
X-Gm-Gg: ASbGnctU7EPvp8ebl/GxIiYquD9exBDw1iPzNRYg2CET9y4/dmsCUalVStj0j6C44u7
	5LUZyDsvq0SNKByJczXJAzF8mzYdEZO0=
X-Google-Smtp-Source: AGHT+IECqtEuypmzVzh5m3cSewtJm2cpzImTdgNCpfYYp6unJMDltC+JYpo5NvQqw++o54ZmQD/SObo2UGlhbvs4t3M=
X-Received: by 2002:a17:906:18b1:b0:a99:89e9:a43d with SMTP id
 a640c23a62f3a-aa58103ddcbmr462588866b.39.1732760087280; Wed, 27 Nov 2024
 18:14:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106023916.440767-1-j2anfernee@gmail.com> <20241106023916.440767-2-j2anfernee@gmail.com>
 <6c20875c-4145-4c91-b3b5-8f70ecb126f0@amperemail.onmicrosoft.com>
 <CA+4VgcJD74ar9zQCj38M2w8FzGWpq+u5Z7ip9M7a1Lu7u8rojw@mail.gmail.com>
 <20241109134228.4359d803@jic23-huawei> <20241109142943.3d960742@jic23-huawei>
 <CA+4VgcJ=8wDWWnmgEt-UkEUfnfD8kGtHe44G5+dcRYt=KdwNfw@mail.gmail.com> <20241123144750.43eaa1c5@jic23-huawei>
In-Reply-To: <20241123144750.43eaa1c5@jic23-huawei>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Thu, 28 Nov 2024 10:14:10 +0800
Message-ID: <CA+4Vgc+rqnxne6saUgUO_kR6chX9+HZcb40_9dpO6p6KuskSAg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add binding for Nuvoton
 NCT720x ADCs
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>, avifishman70@gmail.com, 
	tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com, 
	yuenn@google.com, benjaminfair@google.com, lars@metafoo.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com, javier.carrasco.cruz@gmail.com, andy@kernel.org, 
	marcelo.schmitt@analog.com, olivier.moysan@foss.st.com, 
	mitrutzceclan@gmail.com, matteomartelli3@gmail.com, alisadariana@gmail.com, 
	joao.goncalves@toradex.com, marius.cristea@microchip.com, 
	mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com, 
	yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jonathan Cameron,

Thank you for your advice.

I would remove the "nvuoton,read-vin-data-size" property.

Read VIN info can use word read or byte read, and other registers
should use byte read.
If I use word read for VIN info and byte read for other registers,
I encounter an issue when I use regmap instead of i2c smbus API.

I need two regmap configs with val_bits 8/16.
After I call devm_regmap_init_i2c these two configs,
the error message:
"debugfs: Directory '5-001d' with parent 'regmap' already present!"

Do you have any suggestions?

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2024=E5=B9=B411=E6=9C=8823=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8810:48=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Mon, 11 Nov 2024 15:45:03 +0800
> Yu-Hsian Yang <j2anfernee@gmail.com> wrote:
>
> > Dear Jonathan Cameron,
> >
> > For property read-vin-data-size, we have a internal discussion.
> >
> > For Nuvoton NCT7201/NCT7202 chip,
> > Take an example as to Vin1:
> > The VIN reading supports Byte read (One Byte) and Word read (Two Byte)
> >
> > For Byte read:
> > First read Index 00h to get VIN1 MSB, then read Index 0Fh Bit 3~7 to
> > get VIN1 LSB.
> > Index 0Fh is a shared LSB for all VINs.
> >
> > For Word read:
> > Read Index 00h and get 2 Byte (VIN1 MSB and VIN1 LSB).
> >
> > We would refer your suggestion,
> > we  declare a property named "nvuoton,read-vin-data-size" with default =
value 16
> > for user to use.
>
> Thanks for the info.  If the i2c controller allows word read
> then the right thing is to always use it.
>
> Just check for I2C_FUNC_SMBUS_READ_WORD_DATA with
> i2c_check_functionality()
>
> If it's supported use i2c_smbus_read_word_swapped()
> if not, do the i2c_smbus_read_byte() approach.
>
> We don't need to want this in DT as it is a property of the smbus
> controller, not this device.
>
> Jonathan
>
>
>
>
> >
> > Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2024=E5=B9=B411=E6=9C=889=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8810:29=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >
> > > On Sat, 9 Nov 2024 13:42:28 +0000
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > > On Wed, 6 Nov 2024 17:22:35 +0800
> > > > Yu-Hsian Yang <j2anfernee@gmail.com> wrote:
> > > >
> > > > > Dear Chanh Nguyen,
> > > > >
> > > > > Thank you for your response.
> > > > >
> > > > > Chanh Nguyen <chanh@amperemail.onmicrosoft.com> =E6=96=BC 2024=E5=
=B9=B411=E6=9C=886=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8812:58=E5=
=AF=AB=E9=81=93=EF=BC=9A
> > > > > >
> > > > > >
> > > > > >
> > > > > > On 06/11/2024 09:39, Eason Yang wrote:
> > > > > > > This adds a binding specification for the Nuvoton NCT7201/NCT=
7202
> > > > > > > family of ADCs.
> > > > > > >
> > > > > > > Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> > > > > > > ---
> > > > > > >   .../bindings/iio/adc/nuvoton,nct720x.yaml     | 47 ++++++++=
+++++++++++
> > > > > > >   MAINTAINERS                                   |  1 +
> > > > > > >   2 files changed, 48 insertions(+)
> > > > > > >   create mode 100644 Documentation/devicetree/bindings/iio/ad=
c/nuvoton,nct720x.yaml
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoto=
n,nct720x.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.=
yaml
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..3052039af10e
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct72=
0x.yaml
> > > > > > > @@ -0,0 +1,47 @@
> > > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > > > +%YAML 1.2
> > > > > > > +---
> > > > > > > +$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct720x.y=
aml#
> > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > +
> > > > > > > +title: Nuvoton nct7202 and similar ADCs
> > > > > > > +
> > > > > > > +maintainers:
> > > > > > > +  - Eason Yang <yhyang2@nuvoton.com>
> > > > > > > +
> > > > > > > +description: |
> > > > > > > +   Family of ADCs with i2c interface.
> > > > > > > +
> > > > > > > +properties:
> > > > > > > +  compatible:
> > > > > > > +    enum:
> > > > > > > +      - nuvoton,nct7201
> > > > > > > +      - nuvoton,nct7202
> > > > > > > +
> > > > > > > +  reg:
> > > > > > > +    maxItems: 1
> > > > > > > +
> > > > > > > +  read-vin-data-size:
> > > > > >
> > > > > > Is it generic property or vendor property? I tried to find in t=
he
> > > > > > https://github.com/torvalds/linux/tree/master/Documentation/dev=
icetree/bindings
> > > > > > , but it seems this property hasn't been used on other devices.
> > > > > >
> > > > > > If it is vendor property, then I think it should include a vend=
or
> > > > > > prefix. For examples:
> > > > > >
> > > > > > https://github.com/torvalds/linux/blob/master/Documentation/dev=
icetree/bindings/iio/adc/adi%2Cad7780.yaml#L50
> > > > > > https://github.com/torvalds/linux/blob/master/Documentation/dev=
icetree/bindings/iio/adc/fsl%2Cvf610-adc.yaml#L42
> > > > > > https://github.com/torvalds/linux/blob/master/Documentation/dev=
icetree/bindings/iio/adc/st%2Cstmpe-adc.yaml#L22
> > > > > >
> > > > > >
> > > > >
> > > > > I would add a vendor prefix for it.
> > > >
> > > > Why do we want this at all?  Is this device sufficiently high
> > > > performance that Linux will ever want to trade of resolution agains=
t
> > > > sampling speed?
> > > >
> > > > If so that seems like a policy control that belongs in userspace. N=
ote
> > > > that to support that in IIO I would want a strong justification for=
 why we dno't
> > > > just set it to 16 always. We just go for maximum resolution in the =
vast majority
> > > > of drivers that support control of this.
> > > I'd misunderstood what this is. It's a control no what the i2c word s=
ize is.
> > > Do we actually care about supporting rubbish i2c controllers?  How ma=
ny
> > > can't do a word access?
> > >
> > > If you do it should be detected from the controller rather than in DT=
.
> > >
> > > >
> > > >
> > > > >
> > > > > > > +    description: number of data bits per read vin
> > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > +    enum: [8, 16]
> > > > > > > +
> > > > > > > +required:
> > > > > > > +  - compatible
> > > > > > > +  - reg
> > > > > > > +  - read-vin-data-size
> > > > > > > +
> > > > > > > +additionalProperties: false
> > > > > > > +
> > > > > > > +examples:
> > > > > > > +  - |
> > > > > > > +    i2c {
> > > > > > > +        #address-cells =3D <1>;
> > > > > > > +        #size-cells =3D <0>;
> > > > > > > +
> > > > > > > +        nct7202@1d {
> > > > > >
> > > > > > I think the Node name should follow
> > > > > > https://devicetree-specification.readthedocs.io/en/latest/chapt=
er2-devicetree-basics.html#generic-names-recommendation
> > > > > >
> > > > > >
> > > > > > For some examples that were merged before
> > > > > >
> > > > > > https://github.com/torvalds/linux/blob/master/Documentation/dev=
icetree/bindings/iio/adc/adi%2Cad7091r5.yaml#L102
> > > > > > https://github.com/torvalds/linux/blob/master/Documentation/dev=
icetree/bindings/iio/adc/maxim%2Cmax1238.yaml#L73
> > > > > > https://github.com/torvalds/linux/blob/master/Documentation/dev=
icetree/bindings/iio/adc/ti%2Cadc081c.yaml#L49
> > > > > >
> > > > >
> > > > > I would change it for the node naming.
> > > > >
> > > > > > > +            compatible =3D "nuvoton,nct7202";
> > > > > > > +            reg =3D <0x1d>;
> > > > > > > +            read-vin-data-size =3D <8>;
> > > > > > > +        };
> > > > > > > +    };
> > > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > > index 91d0609db61b..68570c58e7aa 100644
> > > > > > > --- a/MAINTAINERS
> > > > > > > +++ b/MAINTAINERS
> > > > > > > @@ -2746,6 +2746,7 @@ L:      openbmc@lists.ozlabs.org (moder=
ated for non-subscribers)
> > > > > > >   S:  Supported
> > > > > > >   F:  Documentation/devicetree/bindings/*/*/*npcm*
> > > > > > >   F:  Documentation/devicetree/bindings/*/*npcm*
> > > > > > > +F:   Documentation/devicetree/bindings/iio/adc/nuvoton,nct72=
0x.yaml
> > > > > > >   F:  Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.=
yaml
> > > > > > >   F:  arch/arm/boot/dts/nuvoton/nuvoton-npcm*
> > > > > > >   F:  arch/arm/mach-npcm/
> > > > > >
> > > >
> > > >
> > >
>

