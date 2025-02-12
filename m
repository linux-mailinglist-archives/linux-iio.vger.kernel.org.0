Return-Path: <linux-iio+bounces-15477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E123A32FEB
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 20:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF521188285F
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 19:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8AF1FF619;
	Wed, 12 Feb 2025 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVcysn2w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974EC1FF1C2;
	Wed, 12 Feb 2025 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389161; cv=none; b=AJBDczdqgJROzWPnC35IZJevX91G2/1gcCrTfRgL93efVlvoOUJWakWM/nlyeU5DVIqz28hdaN/YLDSo2RM+ScVZvL9w33FQc2WJDrFGq+oRdenrc08up7qlkHqSOBY+vmZ6xs+rVG7tAKYMm2+47wCYX7eNOOLQHAYVXOfNJP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389161; c=relaxed/simple;
	bh=I8AOlYdmQKvdU1KNR6wPtF/+p1DRYAW7BVIpawuMeC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsU9hDw14i2gYehEBpS7Dzpw3sg3dQVffskKqcBH3oeOee28aV/qfuUyKruD4rO6sP1x0IjTYAqxLuCyrK4LWgj9qwRfzh0OYe3ImKJSZGvAuYatYDwz/OrWIoRYGnKqU5GpwhV2FvQvlZs6XpeJRK3Hpx/ZXdz9U3dAMlZ6oKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVcysn2w; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso20506f8f.3;
        Wed, 12 Feb 2025 11:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739389158; x=1739993958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1h3W4S29L15K8XjwMbfKSxqUPRZDwJp04JYAl+GqVlk=;
        b=bVcysn2wk986qtRQHaGkSSQ5PneHF8cUU2IHR/LH0fJABH55xC8yzRgIKGmg39nefP
         BHIIxNFWdq4omAG8RxiBXR+ELLWJc8Gtq0XNeaSEo2k3M/2kf3GTrZCpCY6BkhfQVdpT
         Z2unHmm/huMQEf9TBVvfbxmy3MFbhQY3u2M/Anm+yoR+KwUANTitGoLbhalocJfRe7pz
         MgqQgv/eFuiyVocPc0QkrD9OwzaJkr6zXlF9qQZxSnF7AC3UTGOu5hruIMXTAE6oZESW
         AlFOsi9dNXLVdzWnBIS6B0nnTlERZF1HOG9AH6oAcZnRIIIo7g0jzytRpNSuxCZWE+ii
         Nlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739389158; x=1739993958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1h3W4S29L15K8XjwMbfKSxqUPRZDwJp04JYAl+GqVlk=;
        b=gXy/Oj4G0R2kMoW78PqV3VSSRHXskijtxknyPrq/W9+WeR8lzojFsRYG5tj/O3gLbR
         ldzSVG3fm6hDjSqngiIhlog65dreEsky8vjYAeA8FJ09ZykKRs9Hh7jhXTY2MiEo6/VG
         CeJV+wPcZ5D3mpqcbTD2QxXYpmPd4ph+ZwFUS5VE28yBP8E0As0MFrCpD8ya+WQmzPlI
         Uy1GenK1IxZrjBPG6QpaMZKHsuSCCmo4KjNhR2Q8sM2tEYokOfwYaDG0qZ7N1POVtlUk
         DYtb9xCIr60NfsTpcgTurwL+Xya0R5LoujMlmMczHKjPTu2dMcXtJR2S3Zkp+IZ/Se8k
         qf3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSXu2xBQFE8vPThOx5+1tC4l+fdoFz0tx6CuThRHzBfjg5C6/wvTowOLPZy9rgUlNtES/aqpfg01cJ@vger.kernel.org, AJvYcCVk4wxeiLSvPcOlPjOShMdxfV0sXCeHKsD8rle7N259/40TsyUHe7+hULdSXPuMhCplk2GGG5bF3apvZGBY@vger.kernel.org, AJvYcCWbcjtjU1f83RHD4HFfWaXIl8/lO6Glt+EiLtNJeuE6uFeyDbyfCkDXYCSkM41iHm84VU5fdlX3rh67d9c=@vger.kernel.org, AJvYcCWm2/Ks+UcSPxDwm5DkB97S2sI+WGD5rfA7UBXnKf65wVIvpj/tCg7VK1TaW1beFTbxfF4vnslSKTGD@vger.kernel.org
X-Gm-Message-State: AOJu0YwpvKmS52aRnclwxdmNA73/HrSsSgYn9NuxGrj9nywaRzjbshUb
	e99l0vyzNfMbwpbBVEraWe1YwnPg3rT9jiRAGeVDUpo2XbMEaNwrdsgO3UyT5Vuo1GLGJY0ZE2P
	B7ttqaJi8sntsz+K0L4slRnF2KUeMNQ==
X-Gm-Gg: ASbGncuP1OC7pwsFB1mf3DSjugdI7EpdLn1fIUDm7O/DB1bzl2RLOm5xI/9hnRcotAX
	JfYxufLOc3EKpPXWm3XapPk41OPKshEjb6v0SNDd/GNjGT2WyFzqVL2IGfMg19+/mEDNud5OKkg
	==
X-Google-Smtp-Source: AGHT+IEjG1XPRvRNHEbKQo4iudN1perzPfRwChzed4m/qluB45urO9kTA7eaxqktr7sDSGCbI3mqKAo33n/TRwZ54kA=
X-Received: by 2002:adf:f604:0:b0:38d:eb33:7f7e with SMTP id
 ffacd0b85a97d-38f24512d7fmr536633f8f.36.1739389157641; Wed, 12 Feb 2025
 11:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212064657.5683-1-clamor95@gmail.com> <20250212064657.5683-2-clamor95@gmail.com>
 <20250212-unwritten-compile-7011777a11b3@spud>
In-Reply-To: <20250212-unwritten-compile-7011777a11b3@spud>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 12 Feb 2025 21:39:06 +0200
X-Gm-Features: AWEUYZkzpsGK3aIyCXnWMUG5iedmUJrw1WifBjDI9f7kv_5fnGYIPROZWeLjNMQ
Message-ID: <CAPVz0n0xR_nGPdWn800H=HhMCPqnRUhqP-s1P4eMhtpZdxpxzg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: light: al3010: add al3000a support
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Emil Gedenryd <emil.gedenryd@axis.com>, 
	Arthur Becker <arthur.becker@sentec.com>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Per-Daniel Olsson <perdaniel.olsson@axis.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
	Ivan Orlov <ivan.orlov0322@gmail.com>, David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 12 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 21:20 Cono=
r Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Feb 12, 2025 at 08:46:55AM +0200, Svyatoslav Ryhel wrote:
> > AL3000a is an ambient light sensor quite closely related to
> > exising AL3010 and can re-use exising schema for AL3010.
>
> Quite close you say, but the driver is entirely different it seems. How
> closely related is the hardware itself?
>

Well, I can simply duplicate al3010 or al3320a schema if re-using
schema is not allowed. AL3000a has no available datasheet online.
Downstream code for al3000a and al3010 seems to have same principles,
apart from light measurements.

> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/light/dynaimage,al3010.yaml     | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/light/dynaimage,al30=
10.yaml b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
> > index a3a979553e32..6db4dfd5aa6c 100644
> > --- a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
> > +++ b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
> > @@ -4,14 +4,16 @@
> >  $id: http://devicetree.org/schemas/iio/light/dynaimage,al3010.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >
> > -title: Dyna-Image AL3010 sensor
> > +title: Dyna-Image AL3000a/AL3010 sensor
> >
> >  maintainers:
> >    - David Heidelberg <david@ixit.cz>
> >
> >  properties:
> >    compatible:
> > -    const: dynaimage,al3010
> > +    enum:
> > +      - dynaimage,al3010
> > +      - dynaimage,al3000a
> >
> >    reg:
> >      maxItems: 1
> > --
> > 2.43.0
> >

