Return-Path: <linux-iio+bounces-12835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EED9DEDA4
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 00:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB89281B61
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 23:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BB11993B7;
	Fri, 29 Nov 2024 23:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSFUTWnF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD75D15530F;
	Fri, 29 Nov 2024 23:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732924153; cv=none; b=sINLAT4RXDsDqv8JBUS3hAJ/43Fv5NZ1/zz6ivkhcMSXeXAVVN8BNvq3d9yZC8n1WkqS48stMDP8I91GYQ8zNZ9/6T1CgOK1r+Jw9djsiLYxMAJXo3OA4AfVhpKxz35B7hH9I+lrIpSg0GHy4exFIVxoxWBcp7y+KkIGTr5j7Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732924153; c=relaxed/simple;
	bh=51YpBxvSQQfUdje1OLas0kJs1kgWwhRPqjA54x5LtKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1zOphPEL2iCEgYY3pjxhdADCaVc1Li5ll8gQgFAVZTuMFNH7opwGJNsKFrW95SsjbSg/LDBJXO+iZlduopZluylXAvT4T2kvcZWY7H8Y0YdXkMRSFhn7XpVbkphrhdPOVIglZuHlVzfyzCt96XxIX3kW2RuCr+O69KBv/B4Hrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSFUTWnF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so21728795e9.0;
        Fri, 29 Nov 2024 15:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732924150; x=1733528950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vfaDw92u4txZitjsYZcVMgrbZBRL5XET1CdnRmns/Pg=;
        b=VSFUTWnFwRYUX8jCQ772lihEmGYi8Xigyu7kcDeRo5wxanZlMLhTL2C+TbtKzo4P8B
         vg30Tk9wwrT3cDTSD2ff7vesijiebP/gMJ+cD4djwHFQP7XRDD/2pCeLLTZBVHZeU74v
         mnH3+8xBPJWG9fhUng+S+2i1Odsgr541soRKU1GGRPFbAqD6fmvb1m9Wzgv6Dsk+u0/G
         LWI9ZBic9kYIiJcZ0zy8MKwhM1p1PYyupp1mLeahK5vtOtL//wC+/r+gL5Nks3IUCwwE
         qMyc5w8dgFHKp25yZ1J+zyNIoO5TzvxiIxdZOXKb3NShGwvgYDsoZe9aaRdvVNhIEYwi
         ssUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732924150; x=1733528950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfaDw92u4txZitjsYZcVMgrbZBRL5XET1CdnRmns/Pg=;
        b=cCwB5SzoYblCOTNVDJdoKBV0cm5uDsXypezf/BDzViQSk2Mdc0MR/eau+VM+oEhOuH
         /zgma53/gArePY8d6NG2DWMVEiOy69mgUP3yiu9gPk0194WXlaZet99QXWB6VMPBtoNf
         +yoaJaiZ/G0kaLFyUKCBCUGgW7xHjzVkOlunTMlu7TivJbxjADEYGlmfraM0yGRsDzTg
         n7axak3sKQB/gi01iD+TW/gMaHPeHTLR8gR39gH2ZwxcE8j97tMOzZsUNmz7khucpfE9
         739Z5fZ1+x0PslSmm17VrTg46mJw86Jv+Az+7XyvlPNZtENsdkZM4AfCiOQpk6+CIVtW
         AJEg==
X-Forwarded-Encrypted: i=1; AJvYcCUSe0cuXgsNRW7k94X/aIQYl2k8WyfTs+3SXxAjctlwFvIYKu+w2aptSSe6P2R9vXI46IbiQ5qtmLU6@vger.kernel.org, AJvYcCV9PDetNlSqSqXDb/Kxb6v5G9pcJS0+R6kwEOKcdxXReDkfHMKmVnG6/KmQRQQL6y/wm7kp5Q+MegxJ@vger.kernel.org, AJvYcCXEFdo07DLuU+1/EMn1aMnQt72dFLIQ0mwcp1GJlymgStr5AGRPo+yqTQQ+KQLMNGoeKzbudjoifC2dyRVi@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQsIIwVuJge118s/Fe6fmvCLkqOBxIfYzunowL+hktRwHjEsD
	aeNMnJZZN5kWeSDKuXHIMrnlYuLUqrIJ5vsVn3BGmf94XLDef2Xn
X-Gm-Gg: ASbGncvudAiejFjV2GgvZbaE7pn+rty5hHRli0C6yY0nc6h30t7sXgz+DmRhrdujJcJ
	9ImVrDkpvRxcH6vKXzqip/GPz9EaemEHeGtJZeV04rdWA8YoQKXBaeeBIaZtk4tf+X79fYbbcWx
	yuz1DyoxCpgvyzrRn3OSdaLWw1zBcUGfJ5/Wq84w9BovSv6/iCgS4J4YT/q1ym85LFTkmocEQ0M
	4Gu4vxXMp1z8T03rOc4+KFrpaFt3d+bP1nuSoYN3HGxUF2j/KNvI1TiHBU=
X-Google-Smtp-Source: AGHT+IHlPH+xPhK/nEDSppS0sGmCJetCs6A+aaQ6XxJdoV17gvSW13ZyEIZe1DRKRBFLnQMOUj7QIg==
X-Received: by 2002:a05:600c:4e8a:b0:42c:b52b:4335 with SMTP id 5b1f17b1804b1-434a9dc3e80mr148422845e9.10.1732924149587;
        Fri, 29 Nov 2024 15:49:09 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:2250:4c83:a8d5:547])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dc99b3sm66655105e9.24.2024.11.29.15.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 15:49:08 -0800 (PST)
Date: Sat, 30 Nov 2024 00:49:06 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: bosch,bme680: Move from
 trivial-devices and add supplies
Message-ID: <Z0pS8sQOfkQBKEId@vamoirid-laptop>
References: <20241128193246.24572-1-vassilisamir@gmail.com>
 <20241128193246.24572-2-vassilisamir@gmail.com>
 <wdtkd73brhfotps4crpbpgdvtzrc25xr3bq2au2d3uzrl5pwz2@7ssawm3gyyfo>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wdtkd73brhfotps4crpbpgdvtzrc25xr3bq2au2d3uzrl5pwz2@7ssawm3gyyfo>

On Fri, Nov 29, 2024 at 08:12:21AM +0100, Krzysztof Kozlowski wrote:
> On Thu, Nov 28, 2024 at 08:32:44PM +0100, Vasileios Amoiridis wrote:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        bme680@77 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> E.g. gas-sensor
> 
> Same in other places.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
>

Hi Krzysztof,

Thank you very much for the review! I will fix it in the next version.

Cheers,
Vasilis

