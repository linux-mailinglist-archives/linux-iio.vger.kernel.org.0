Return-Path: <linux-iio+bounces-22120-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EFEB1469F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 05:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A23B3AC91E
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 03:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE1F21CA13;
	Tue, 29 Jul 2025 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xnn6TC2v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A0ABA2D;
	Tue, 29 Jul 2025 03:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753758560; cv=none; b=DB6T9mx5Oyne4vZVkUKjRPRQ0bTU/UnmzeKfKaM+S5qo8AJP2+UlI2ZC995fpoujqa5c8FDUSEwO2cxcMtmowdybWsFgYJv7oBJe44pZ92foBYWvUyZOv4CHyG1H6HGhKBE36K/WPDSym0PVY3d3vGeHrVMVq/PVdqkM/Ki7JW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753758560; c=relaxed/simple;
	bh=voB8nxZG0JsraYF5bpcTovmRiiaGSdSGo2ys2dvzbto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9CrmN6PBaVoce655WhYciFZ9ZxLKlwLJ1sMUsoIRk+T1Rkht2wOywZgc+1iO7m94dd7F7yt92Kp1F+9SNNH3rYvDrooMju5SGYY92iJh1GwJVDx9rXbC6FUKQwC3ceYpa/W0k0B2uf3xt43tlzsAnxnNKh1lsHrmmqJAQChBP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xnn6TC2v; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2402774851fso18470795ad.1;
        Mon, 28 Jul 2025 20:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753758558; x=1754363358; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H/Boxl4Fu66xPvr2Oag07ot90KsvXFnNk2eJEF85IiI=;
        b=Xnn6TC2voUtmz1tCJtIXQAr2RgPAFrvKP4IT+mbrBu0QpjAkjWSztRKCQJUuxsBWwf
         qsuSXDZcsmMipjzRsx0IcBo4Cw3OuwG3EU1hUbdsnb8OnEUeDiJpe23R6k7LYMJAmb3l
         bRwJbrBCT5HvZ090TQHld8sHk60qBFsDXK5TIlKzcjYiHbM1M0ZXifMxYekBMZFTI1Mn
         OBHgo3jdJ6BoyJHRQxjDtGPD4yrxANv6o7/I+bli2kq3lYCH1KEQVHFsF9WtiCrh8xnH
         Z7E26n2yAJd3GjXLscPI9clliU37H4UuebkAgfCjN0q/LKjkZ/pz8GsyuWj6ZZdaGhZl
         RJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753758558; x=1754363358;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/Boxl4Fu66xPvr2Oag07ot90KsvXFnNk2eJEF85IiI=;
        b=Awv0ZiQnEyZdehH+AVUcA97mHIEwZ+y38c1eA2VNDwCq1Da7BxixVK5RvhO8J6zwJM
         ZzOQ+/QcJ9KmMPCleO2oQXgmNvYuTFQJ3NrneqsKeP5ypslMNxOGQSqZ8kJsF0eqJCG1
         ek6mt8BJIkoh6ErtEAqtnl9fJKQsiIKxymiV531C5XDAK93HkkazCUBGeHCj8EMHrIsj
         E20TXoV8yOSSqHvw8zXpe4RGimBF9QSV/dtD30aMrJvBWEj+EwD78mrtN0ExBoqypQsn
         Co5wSZlCBiZfpeNn4eKkDbl6/3n1zmJsAqf042SSx595pJazNl7edjZlW3FPRp203LWD
         ZxaA==
X-Forwarded-Encrypted: i=1; AJvYcCUbsmq+5r0azoOWX4uCp7bAGa/mrs5lS1Wcalg2Z2JUVuvYk5LIh61Qb0pZ+VJ0Hi5BxZvCymLFhlzx@vger.kernel.org, AJvYcCW9kXIxRMt4qm+X6WkdNNyIbhIMeOwn580AeQyzUjo8oPAE/lLdpHg843gSGWwcbHt7ouDlAxOkZDfc@vger.kernel.org, AJvYcCWtCGVpddLCuXmYjm8ecs9Ud+SSZR08JmHI4JD0JnDQVX4vadLSigLhEo7EkTT3MwqsacsgZ0bCxgEjX6zz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrc4v0q4Z2JRmAbfeeKgJvpdWBPpy/ZrWyfumxESPu8eXOq7Ns
	5//qFOdBcI1QdmX3dh4zzO4k0Tekw6/CLA53YwNtTW26Dl6NoCUfqFPFX2NSMCE8
X-Gm-Gg: ASbGncsjbjtMdHgOQtmUS2EExG9WimudrMSpqGQrYVhRtvXvvVgM4/w0Bh4Fb9LmSlU
	ENZFEu3VSwVbuxnef/tZJ2pmKxrUTGJB75MYe9uRCcKSVPZS7Emrzxx3FW+j2M1742nfVwru3yd
	id/1oSBZHZxVrnUFIsU8KW9NNOz8rA8Uvbv4B55FeAngmT+hb/NzR5KQWF7F79zxvMwA2yhwPIs
	E2EBs2zMbggzX5CrwSPQ216Dkhlqn+pYL43hyMGlkIqyZw1FD8duq0/2PmrvNQnQoeNu7QG+6w4
	q7YSZjFlYC/3kRfZ7Xg15BRLO1d2ZE6vKZWUBkHC6O1bAv816/6vxQa19kpkv4ybOLnQ999y+j4
	BTZ3dIsfF/fqIPYRPrYv/Aw==
X-Google-Smtp-Source: AGHT+IE7/6r5+53tvDyEi0ZksrZje7lyaYHFB1SRu+zg1k/9pvR6PtB3VkjKQHbTcw5sHJAfpGB9FQ==
X-Received: by 2002:a17:902:f114:b0:23f:df69:af50 with SMTP id d9443c01a7336-23fdf69b14bmr97860585ad.34.1753758558168;
        Mon, 28 Jul 2025 20:09:18 -0700 (PDT)
Received: from dixit ([2401:4900:1c7e:9464:4ee2:7e58:1508:18c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2403c16fa8dsm27353025ad.156.2025.07.28.20.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 20:09:17 -0700 (PDT)
Date: Tue, 29 Jul 2025 08:39:08 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: magnetometer: document Infineon
 TLV493D 3D Magnetic sensor
Message-ID: <aIg7VKO_VXkbfUaA@dixit>
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
 <20250726-tlv493d-sensor-v6_16-rc5-v1-2-deac027e6f32@gmail.com>
 <175364805544.3130.15364114273761890479.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175364805544.3130.15364114273761890479.robh@kernel.org>

On Sun, Jul 27, 2025 at 03:27:39PM -0500, Rob Herring (Arm) wrote:
> 
> On Sat, 26 Jul 2025 15:07:02 +0530, Dixit Parmar wrote:
> > Document the bindings for Infineon TLV493D Low-Power 3D Magnetic Sensor
> > controlled by I2C interface. Main applications includes joysticks, control
> > elements (white goods, multifunction knops), or electric meters (anti
> > tampering).
> > 
> > The device can be configured in to different operating modes by optional
> > device-tree "mode" property. Also, the temperature sensing part requires
> > raw offset captured at 25°C and that can be specified by "temp-offset"
> > optional device-tree property.
> > 
> > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> > 
> > Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> > ---
> >  .../iio/magnetometer/infineon,tlv493d.yaml         | 57 ++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
>
Ack.
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Warning: Duplicate compatible "infineon,tlv493d-a1b6" found in schemas matching "$id":
> 	http://devicetree.org/schemas/iio/magnetometer/infineon,tlv493d.yaml#
> 	http://devicetree.org/schemas/trivial-devices.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml: 'example' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties', 'not', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select', '$ref']
> 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250726-tlv493d-sensor-v6_16-rc5-v1-2-deac027e6f32@gmail.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

