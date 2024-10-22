Return-Path: <linux-iio+bounces-10911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAED9A9507
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 02:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6511C21A49
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 00:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C8318E1A;
	Tue, 22 Oct 2024 00:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epMbfrj4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DCE322A;
	Tue, 22 Oct 2024 00:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729557522; cv=none; b=cENjINXmSYS1D3A5/tS5RQ/Z0t7bdkby428dS+SoQ+z4bCKrCyaHmg3EqhpNXsEVscrKONTClN69cv+pq4UUYYZ6cmjZLQA051eFUp0oO+SpeyNhWUo8d/aCo6ze6YGCmMFsrgQjZpqC3bqqsheQ6FUjfnbHVfNQH3lh2nqOriw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729557522; c=relaxed/simple;
	bh=ljRP45hZhcU5TIdoOUX/MFdLEpvuS4DRBUh5mJBPMLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXRWTHNInt9R378o/C3OuoJBtGVpzIAdHgOC1rtjqQTxfm/JDXrqF4ZzpnINhlrRqghysYvvOD945T5pDkbLdDOT9fTQMorCT+e5G4Dpnu4ONPGxJ7REfaHB7ytJrmYjU5O0H5zM/6DIW21x7elTXgh0ZMxMiM7HS8Da9/CcRlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epMbfrj4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e49ef3bb9so3565949b3a.1;
        Mon, 21 Oct 2024 17:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729557520; x=1730162320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=magtwdh/LfBPRMtVpw+N0PEp+2NPatDBY6KH3mR8XnA=;
        b=epMbfrj4EobW0qtiilcY2/+GveoJXuBLs052AjCbRRIstSz2pjK+KRyQLRF9HCUZUG
         n7eiP6sEqkxC1Zaw/ffLxAMG288uGUREEdbe/OF5nCkE05I4iQi80n8YrXvMVeDKk49Q
         6WgX54wtn83NasTY11LvHoFXgcwl0Hu0R3mYQGlNmEqW+NmzgB+xdJm/9Jzv7WhU50+M
         aLAaGt4qePFfyhl7sbLVdjpHNX0EFl4jNaOztCZP5yCqUOv8nXQQoRQGmZLkO6nrLJxK
         vsItUze0n5ZmU+nxrgkaiGvr8362h4Clw50s1QU0Ss2qliu8A8KzO7DgfBYmxDvDpn+D
         nhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729557520; x=1730162320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=magtwdh/LfBPRMtVpw+N0PEp+2NPatDBY6KH3mR8XnA=;
        b=QpHiI04MeQBNPbiK54GXkaFGX8nJxGBt3vTZ4Dkz6zTNhxUGrarjWO1CZlHLr6hQsF
         ZG5BHJMAxGSN9W7G+ftuIR4DLCbyNP6SVhCF32nTso7u/XHfY2bv6qmAZu6w7WcijnJV
         cRFHwGgi5yAWJjg7I+6efZLhmzKGym3EoJEqNaRPlClIUMTDNI4VWIx3R+t8Vce2w7W/
         dgigwU/wNZo9Lm6rAHCRL1OJw9nB2e3WCALa3SbAzSqjHCR8/bJZNtpDNkI6DYOrNSdi
         secmwVMjp6I/X7olhViErN7QdbRLbjd+VSDlb1WaPUzvqzo3MHJC54IYwPqLieEVIBK3
         brQA==
X-Forwarded-Encrypted: i=1; AJvYcCUKbP31mEMY06ZJHgx0secsFxtP2xzGsg7/o5NO6mlb81GW0eGJkVqiS1xK5XlOGkGggH1nLIPdn6pF@vger.kernel.org, AJvYcCWhCSUPO6fT58Mu9Y04yY1W63lQtCrNn3CYrTfWyym1dMaqKA9kJXgfAbrwS4tl/eIYYUoA+gjaX/sT@vger.kernel.org, AJvYcCXFeLm4+iBTNSMAzDCKdHRvQ2EahquEKBthfNmEwGYsUENIFzY9Tb0BR/27PRw7JjhvKWfP+ZB+G2ARXDy+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6FyfY7WkBzwVvpbLzFk3gcQfDt+rtoMwYVlI8ZeKFsopiMKK
	y+on0S/kq2A4pGTp9EWWxye4JmME/2PGRYsxWr8oFuuhwkO9O9dg
X-Google-Smtp-Source: AGHT+IHV8M9cBXnFbidcYyHefhv6RPjbtsN8XZLPfnMQLKyzNP9kmzIyA20Jtvdd6EaL6arRZgb+1w==
X-Received: by 2002:a05:6a00:270f:b0:71e:591d:cb4c with SMTP id d2e1a72fcca58-71edc132de9mr2016686b3a.1.1729557519596;
        Mon, 21 Oct 2024 17:38:39 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ff7fsm3517619b3a.71.2024.10.21.17.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 17:38:39 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:38:04 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Inochi Amaoto <inochiama@outlook.com>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH v5 3/3] riscv: dts: sophgo: Add SARADC description for
 Sophgo CV1800B
Message-ID: <b2dtsxyae5d4pueaz2ar5pl5b3c2mjg75hvj7rljtxgfd5wxer@bkxe2uls4en4>
References: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
 <20240829-sg2002-adc-v5-3-aacb381e869b@bootlin.com>
 <IA1PR20MB495323339EFB06E194204904BB902@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB495323339EFB06E194204904BB902@IA1PR20MB4953.namprd20.prod.outlook.com>

On Sat, Aug 31, 2024 at 08:49:22PM +0800, Inochi Amaoto wrote:
> On Thu, Aug 29, 2024 at 02:31:52PM GMT, Thomas Bonnefille wrote:
> > Add SARADC node for the Successive Approximation Analog to
> > Digital Converter used in Sophgo CV1800B SoC.
> > This patch only adds the active domain controller.
> > 
> > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > ---
> >  arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > index 891932ae470f..da1ac59e976f 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > @@ -133,6 +133,28 @@ portd: gpio-controller@0 {
> >  			};
> >  		};
> >  
> > +		saradc: adc@30f0000 {
> > +			compatible = "sophgo,cv1800b-saradc";
> > +			reg = <0x030f0000 0x1000>;
> > +			clocks = <&clk CLK_SARADC>;
> > +			interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			status = "disabled";
> > +
> 
> > +			channel@0 {
> > +				reg = <0>;
> > +			};
> > +
> > +			channel@1 {
> > +				reg = <1>;
> > +			};
> > +
> > +			channel@2 {
> > +				reg = <2>;
> > +			};
> 
> I think it may better to move channel definition to board file.
> 

It seems OK, let's drop my previous comment.

Reviewed-by: Inochi Amaoto <inochiama@gmail.com>

> > +		};
> > +
> >  		i2c0: i2c@4000000 {
> >  			compatible = "snps,designware-i2c";
> >  			reg = <0x04000000 0x10000>;
> > 
> > -- 
> > 2.46.0
> > 

