Return-Path: <linux-iio+bounces-2046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99C8842416
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 12:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404361F21D15
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 11:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8034367A1F;
	Tue, 30 Jan 2024 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Lze2ElgB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B991679E4
	for <linux-iio@vger.kernel.org>; Tue, 30 Jan 2024 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615347; cv=none; b=qdxdEjZROukGvGXBw+h/N6UfAFnLIdelCQmZXC0hxDM3qTVHC9y6H2OoilTXD0+v+eRXj9YqcMUnYEHi4OnuaRph8cIIBCsoroJHjCu6DFn10X/MHlvIS5+/Qpt2mmOqbPqnpcPsSjyNgiyYMY9Frz4wzL7+DKvk70VszZOOykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615347; c=relaxed/simple;
	bh=djJj9XRuv56D+Yf0tvte/Y0cLXHAVntDU34fYEL78oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tia+9Bq1+x3Z0eNLZM2fbiegCuAdh3XkVcOLeOEMCgpRTSUfhmAbXOY7gGD/GAP9ruHvh0aIjr19ls0dcXtuP2t2BKoybogOg/Gs51/ggD8whSJ489vhrQ85v0GjoYe+yRLCDMjinea0z+CziFKwrjbydfa2+Lz5MEZ0OrLeZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Lze2ElgB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d50d0c98c3so39449165ad.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jan 2024 03:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706615344; x=1707220144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/i4SzQBJoQr/W4/YDTog7lCCv9zfgdmkWanXeduZ2I=;
        b=Lze2ElgBX2tXPOvb0d3CaA+Z5+31LuiWq7aoIXScg9+N89zoJ+LRi7iv/cEigbPMgb
         E8bFqKjLQ0BSY0sJ0zg9LRcus2vOfa8VkLXM3ML1zyOzL5AI+JCAZaAE9eqpYtD7G6oJ
         hpKNUKnFliya23fgSerjr0tKCd7KYVZT6C+Qaa3YaRwZVJsszroiDGQe+Q5qPpnEk4gV
         dChpG/MCF3ooP4YczpbZlSTi2LKMsaW5RJc1ulPqkuKR4BnoBGCOF0JshVfs/NtfsuAZ
         CrnnHxx/IDPT6ka1nYM806+bkauCel42Mgqc0Eiy5jE4oIXNqFaBb3b8YKpjzyW8CdYK
         FIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706615344; x=1707220144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/i4SzQBJoQr/W4/YDTog7lCCv9zfgdmkWanXeduZ2I=;
        b=eCbpFNerxgQ08OPMAVTOsrkl9QplfHwmpUUPVXLfLTXTm6BJBdFes0Ja4TM1USxkZN
         5+bNu6To7kAYEwGBFYZRWgfJqkHGfP5OGMinHKoasoBJOHIX844dxawpDXiyifeSTWsl
         WJa55yJEdPYUeebNOeYz6PrcEu2bU55Dk+r7ehc3qcJRRKmnU/+mS3O8B/X7/D7qmufX
         5goJRCZZ41wVMkzJAnkTelUPaYk/r6WADaLHxS76KEHPF0QWpnGuF+4cWlWNJYeXbpUv
         y2a3kwXiIVJTWu3OqFhn6gbfOtVvCoGPBX3GpeVbLDSepJfcpGYoI0+IooqRLdvDFtUE
         RfLA==
X-Gm-Message-State: AOJu0YyBahFGvzLWf9S5rrPCbMohSWcPaGvGI0hWbqQ7xzXxpWucUuT9
	2/H4FnHw4z33zQISETAzIV4vfzutAMtk4oU4chQUC9g+b3MZ2Jn89gd8eUrUdnCsE2KvlCTd5vo
	3vOI/LN0uodFexLiSiMhX0++yPOnTrWFoF2rEwg==
X-Google-Smtp-Source: AGHT+IH77ZXfkrGtYR4l5SkakOL1AXdRhX+06Z4lEU8XqFeiImXFjxCQGZeFc+X+5lQM13TrnKG+PTTtrEkaQCnpWRk=
X-Received: by 2002:a17:90a:cc06:b0:295:3d98:68fd with SMTP id
 b6-20020a17090acc0600b002953d9868fdmr1399215pju.28.1706615343870; Tue, 30 Jan
 2024 03:49:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130111830.4016002-1-naresh.solanki@9elements.com> <49bb7b5b-4186-83cc-7e1e-4892c7e8b6ef@axentia.se>
In-Reply-To: <49bb7b5b-4186-83cc-7e1e-4892c7e8b6ef@axentia.se>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Tue, 30 Jan 2024 17:18:53 +0530
Message-ID: <CABqG17g70GDU3_DbJbEnu4-9a3aJBSFFXuYKBEG8MJpVfOjMGg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: iio: afe: voltage-divider: Add io-channel-cells
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	mazziesaccount@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Peter,


On Tue, 30 Jan 2024 at 17:12, Peter Rosin <peda@axentia.se> wrote:
>
> Hi!
>
> 2024-01-30 at 12:18, Naresh Solanki wrote:
> > voltage-divider is always an iio consumer at the same time it is
> > optionally an iio provider.
> > Hence add #io-channel-cells
> > Also update example.
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >  .../bindings/iio/afe/voltage-divider.yaml          | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > index dddf97b50549..09f10d7c4e02 100644
> > --- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > +++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > @@ -39,6 +39,13 @@ properties:
> >      description: |
> >        Channel node of a voltage io-channel.
> >
> > +  '#io-channel-cells':
> > +    description:
> > +      In addition to consuming the measurement services of an ADC,
>
> It doesn't really need to be an ADC. Anything with a voltage output
> channel works (in theory). But sure, normally it would be an ADC...
Ack
>
> > +      the voltage divider can act as an provider of measurement
>
> a provider
Ack

Will update as:
  '#io-channel-cells':
    description:
      In addition to consuming the measurement services of an a voltage output
      channel the voltage divider can act as a provider of measurement
      services to other devices.
    const: 1

Regards,
Naresh
>
> Cheers,
> Peter
>
> > +      services to other devices.
> > +    const: 1
> > +
> >    output-ohms:
> ...

