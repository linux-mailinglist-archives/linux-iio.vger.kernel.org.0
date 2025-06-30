Return-Path: <linux-iio+bounces-21148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471C2AED83E
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 11:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F099188E62F
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 09:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE58323B63D;
	Mon, 30 Jun 2025 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XUzJg0co"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D7B22156F
	for <linux-iio@vger.kernel.org>; Mon, 30 Jun 2025 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274658; cv=none; b=s9pA0UgammiG2KoSkwfWi/DgUiZXHadyZGqGCc/nuUNs37e4rbMaIgGOEyDU08w9dSE5qb+39M/URVHYy576QUxpjnqFjg/HpflSAC3iN0bn5wRfxD6S4+MC3J5Rndmp6aCLPyv7+UBpefXxGYB17IEs2ABeTcSlFzFc4VfNK9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274658; c=relaxed/simple;
	bh=wtv+LFHxuM9AWX0L6ikf56UwuRoDnrS0tJ6y5ORCVkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9piqDwnXtAsro8RsTlQf2oaIgmGutr23qLrhaEMmcZV+ntb9d134FsYSulAj1eSwbtlIOL445jJGIbVhENKO59KxJ2Clv+GDNVLqTzw7l8tMFIyDFY5aZDGErMOMON/vdey6oNpqj10WRPXk03c8Fs9bvbyHtsX1zzN9QPHVsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XUzJg0co; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0d758c3a2so695956166b.2
        for <linux-iio@vger.kernel.org>; Mon, 30 Jun 2025 02:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751274655; x=1751879455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1c7UVB+HsIrwMhQKzoKR+ElhzYVbyK56CpcLANHfHcs=;
        b=XUzJg0cojs/dxd+UBiRjXtZwrbSlJGH9jluzmCVpyoH2taWOlsFi575EFNHyrXYwtq
         aSfOhtvslDhj8Xy0TywNl+PGrRiuQKIYG4eXJOnLirBKiNCvepBBeyBF2ny0GOh/MJ+J
         abXLDkBBMv2mStLY+QemkOsTBwTeNLNeugABv25HCB/gnEwNQDHT3++ZK+fenyIOPkrB
         DojJKHlSn3TGDgVkrnFmox/KYfsunXTYZ/jpgtqFOujdE7LTESpDvESz0xtHOo5usBXE
         dp1MkgOU0z5XP6dMRnn7N+51d421NXPhW5cwQ/yv5fwQm1KsM0VMW6tlPaQCgzbwf/13
         NsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751274655; x=1751879455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1c7UVB+HsIrwMhQKzoKR+ElhzYVbyK56CpcLANHfHcs=;
        b=nxTQFm1geE3Uix4P57ufE8wDoK8dAxlpMoIj+ydxMT5AgDFFeqaxo2hpIiq97fCi+j
         ILnP/siXnwFIUhTa0TJuEdI/PpdCU0BFrNAVprN4oTVyIvLL/c4HHzqapslFr04scUeV
         VIFxyn8Tx4Ju7xz6kn/BsuESbZZZCOvWC22GrspWeWkClpZbeBTJwA3OX01nhCRjUlyA
         vgGLO+OjD0Xw538Qm2jnx4lZpgdDolKpKfoO19/MNqRTGxoATt7QmjCRnFy9b9ZnOaj9
         SSyeKy8Aro48JcR+mT5pLitGJ1tgC2GlOqHniTNCWMDri8as1YH5QKvMQeGUsiWbTuCq
         oBeA==
X-Forwarded-Encrypted: i=1; AJvYcCWRv82X+TRKgpYaMLu1YNIAE+U12/KcZN5AL3PXAC/PwZMD8FS92sljPCyP+GHr3K5bLYpwT0d1x/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWwxp4nQH5dCbn3jQZUE4PXq0XMjDq82k77NbTQmutsAnIUvQb
	zj7m5OXvZY+d0UkXjoRODOaehdtWHV6eEOEowdVoR4HlkbLLsaEwDNSt28nioFE/Qwo=
X-Gm-Gg: ASbGncvnE9iH9eQimmD/pNvodFvzZegNiDxom7nlt8Tr7ZFTsTZvrlQ4CkQmc+osdRW
	J3zPHYlD+8CmbLAqLU+t7Sv0Ie2/speecnFMz+tUlkrOZnBfls7ZpKCCNx9CLNHl6A6Up3rihvJ
	RM2BECVGOQ5aFZbZETGzThuJ/ioRlAzWRne5M/H+8PxgqdKYiUibWT1g65kDIKXX4wzRzw17r5M
	VkrUgdv3J9jXPJpKU8xwGdWEAfcM93j2y5/bEBS33ps2eZpPc2vEhiylFbpPohoZUDppv3SuPxH
	Fa8v44E/2PQW73vbJ0n50VeNtIPRWrNYW5MYlqfPigvzCDJhy4b6ZJn7IxoVUy2OLYDUbmDRqJG
	geWybG3uQjz2UWra6MTDaN9EBJ0v13cTiO7pb
X-Google-Smtp-Source: AGHT+IEkCjklJgOVn9m2h0ZYB9RYj1O2BKk8vmPV0JoHQsw1aXV4Ln/c1FHctMmon20dE6hzBNg4oA==
X-Received: by 2002:a17:907:7e95:b0:adb:469d:2246 with SMTP id a640c23a62f3a-ae34fd89929mr1069995666b.17.1751274654602;
        Mon, 30 Jun 2025 02:10:54 -0700 (PDT)
Received: from archlinux (host-87-14-238-240.retail.telecomitalia.it. [87.14.238.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363a9a8sm635407166b.33.2025.06.30.02.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 02:10:53 -0700 (PDT)
Date: Mon, 30 Jun 2025 11:09:02 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: adc: adi,ad7606: fix dt_schema
 validation warning
Message-ID: <epswbthrftxecrgm2rjkag6yxkpegr7boodzpjqfx675gghziy@p7dy7cns2ot6>
References: <20250526-wip-bl-ad7606-dtschema-fixes-v2-1-9bd56d039489@baylibre.com>
 <20250531170448.2be25330@jic23-huawei>
 <20250629171908.122a5163@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629171908.122a5163@jic23-huawei>

Hi Jonathan,

sorry, could you merge this, or do you need the hash fix ? 

Regards,
angelo

On 29.06.2025 17:19, Jonathan Cameron wrote:
> On Sat, 31 May 2025 17:04:48 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Mon, 26 May 2025 15:19:08 +0200
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > 
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > 
> > > Fix following dt_schema warning when offload is used:
> > > 
> > >   DTC [C] arch/arm/boot/dts/xilinx/zynq-zed-adv7511-ad7606.dtb
> > > /home/angelo/dev-baylibre/linux-iio/arch/arm/boot/dts/xilinx/zynq-zed-adv7511-ad7606.dtb: adc@0: 'oneOf' conditional failed, one must be fixed:
> > > 	'interrupts' is a required property
> > > 	'io-backends' is a required property
> > > 	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#
> > > 
> > > There isn't any reason that we couldn't have interrupts wired up at the
> > > same time we are using io-backends or SPI offload, so dropping off the
> > > related "oneOf" block entirely.
> > > 
> > > Fixes: ccf8c3f106a2 ("dt-bindings: iio: adc: adi,ad7606: add SPI offload properties")  
> > That ID seems to be wrong.   Probably down to the messy rebase I had to do pre pull
> > request.  Fixed up to be 81fe5529e812
> > 
> > Applied to the fixes-togreg-for-6.16 branch that will become fixes-togreg after rc1
> > is available to rebase on.
> I guess something related to the rebase I had to do just before the last
> merge window caused it, but that Fixes sha is wrong.
> 
> 
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---
> > > Fix dt_schema validation warning.
> > > 
> > > Link: https://lore.kernel.org/linux-iio/20250408-wip-bl-ad3552r-fixes-v4-0-b33c0264bd78@baylibre.com
> > > ---
> > > Changes in v2:
> > > - Change removing the related oneOf block. 
> > > - Link to v1: https://lore.kernel.org/r/20250523-wip-bl-ad7606-dtschema-fixes-v1-1-d9147fb2a199@baylibre.com
> > > ---
> > >  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 6 ------
> > >  1 file changed, 6 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > > index 29f12d650442b8ff2eb455306ce59a0e87867ddd..1a5209139e1338f803c66ad2b4d63ad53cc11d96 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > > @@ -223,12 +223,6 @@ allOf:
> > >        - required:
> > >            - pwms
> > >  
> > > -  - oneOf:
> > > -      - required:
> > > -          - interrupts
> > > -      - required:
> > > -          - io-backends
> > > -
> > >    - if:
> > >        properties:
> > >          compatible:
> > > 
> > > ---
> > > base-commit: 3964c6e5877f054497ffccc7d00f8f7add307d0d
> > > change-id: 20250523-wip-bl-ad7606-dtschema-fixes-5e6ab342e043
> > > 
> > > Best regards,  
> > 
> > 
> 

