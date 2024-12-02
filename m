Return-Path: <linux-iio+bounces-12979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DCB9E0EC4
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 23:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FAA0B271A3
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCCF1DF977;
	Mon,  2 Dec 2024 22:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnCVeJrO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BDF1DF976;
	Mon,  2 Dec 2024 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733177081; cv=none; b=GL07qPIb2COKIgsKlxAvkj/PqY/9k4ghKQ7nLs0YbGdnh3INhgrWVAdTg8zJb71duy7ot8UOrE6cSFV+ilyIOd5t+gEO04yoD4iEikepo86u8kpvmr0AB8vFnkZ+fIhedj6oa5myW3CI7k6Zdi4JjwoekjGnUKWvzhaSBpIbDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733177081; c=relaxed/simple;
	bh=IQYtcZimnewUA/3iIw3dNG6GT6kosQnHidtn2o5SOKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qb1sAorn/gC8Qdv55ASNy+bqtNe+e/+w+2VqGkOIeILLNTwOz7suw639FTJ137+jgkhYwzhrBDYDIYK8Apk8HGtbNtoNgTEAAmaDuf/nnoQ/EJ0x61QztOLu97/qFm2xolIX2WkRWOwgFHemDlouKnleIPYtjUHlsy7UwXU8rb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnCVeJrO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a95095efso34135245e9.0;
        Mon, 02 Dec 2024 14:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733177077; x=1733781877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxkoI8JehpmApWy8LfGoHEoX//j2ioIUeFccLSzzy3k=;
        b=SnCVeJrOmtQY37pdxfP+I9CqF+koxDeAEr3f70uU3IxLFRTdWJOR5Ghy0DWz7Fm2tB
         wilrciiwBBW/hipfg9U/tN+YIpulay/krSn9UrklT8xLjL620pQBbCx5gVrBYPGJmpFy
         ZbeK3Ek5R5H4U6AvEqQBTBVskLtGELfC/Od7P0fp10feGVgRBhGWpKgWwOk24z7e81gT
         pv2jlRqKx9gZpRZ14vQmFoLtR9sMNQksfOcwLOKWiC+jE4UfrxRw8un594WNywHR5757
         VH36ScvMJIYtIUj/mw38Jh/w3CzpUgnYTUPQb7ISvDrS3YzXhFw7jWzJBayITjoh1ZjM
         tyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733177077; x=1733781877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxkoI8JehpmApWy8LfGoHEoX//j2ioIUeFccLSzzy3k=;
        b=tRwkxaedAoFJEeBnVl4j3j3pmg8eyyuiKHOTROpYqRmSEC8w1t3yOTiNQ78COvMKSy
         UyJAEBZNz0kdrZ/rEertM0YSQwdz9jalCwg5panEoxcJCiq4W6xyMABeCLk45m4OCPh4
         zawgYUUoiCki9Qq5yf1h79hNrugtVOF+Nd9kHes1gR7XWT8pmkYz4JEvMQhscX8OJ2Yf
         P5qDi4ZaI0qyw861fK+c7BP8BguRy9BRskvc11WzDiu33x8h7XFRTedGYwpNZwxo2bkN
         eRAJoqBw7QctkTPvynWfrsU5FKDwxTkWg/TwmNdkmS9DG5fA68LEKcCKHPCP3Rxd4zRT
         cNFA==
X-Forwarded-Encrypted: i=1; AJvYcCU+2+vmBdUIoUmC/OJ7db5jqyi9icVucLzL3ehyAt+eXeOTDPK9lmUJGaMhnNBAzJyWXjUdZjzuJzSdoKKU@vger.kernel.org, AJvYcCUP8YBboB3RE3nRxPBLmJZWF355w8/z9QagS4f3JfiifvsH5+sPtBF9BBsML01rlw57valmpg2pWiOZ@vger.kernel.org, AJvYcCXU3X29dobkmc5dnQICn5aCxCudF0L9hPoIA+2C8UshelrhdkctvXlmWI6eyJaMyCDhXzJBEUcGsXzB@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ66LzC+Wv4lqkRMaiuT++75QbGu8Hj9gvZEszWyDDHXTe5BNK
	JSczx0KNDYGJ+dPBvWK1XbbaxP0vWkVs5vpiqpfJbl2IP0VUBLkF
X-Gm-Gg: ASbGnctnxdwVjxVKD3X6P7qsOtzODrdqiuhYQDaW+bFvtoURduhMP6RwtbrywzyJ1C1
	utDe9AriA77S+RVs5lYWOoOL4etIcYPwY8JFLBv73HLVemBLs2cX8pe82B0WyFX9lqtoKLkrg4m
	VeUpOtXzb/pHF8dzRv2mMlCoPfiOWzo0tAxGlCDzISsrBdLttFBVJSfKFAjXYfJ7sRXpQ5Z4AM+
	WX5Frkh7yfIQqo6PG7RMtXckqu0+Q4A0sYXXMaZNc07ulay+0vf87KPsXth
X-Google-Smtp-Source: AGHT+IHNvLdUacd8s8rO3mW7SGcWQEHo7MyreUAMqNwXFASE1/YWIbyCM3RRrZY6nsWHAlTdSVWFWw==
X-Received: by 2002:a05:6000:154e:b0:385:f349:ffe5 with SMTP id ffacd0b85a97d-385f34a030fmr4467145f8f.29.1733177076950;
        Mon, 02 Dec 2024 14:04:36 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:ea8a:93ec:a066:eb25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b9a9679bsm132704705e9.13.2024.12.02.14.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 14:04:35 -0800 (PST)
Date: Mon, 2 Dec 2024 23:04:33 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: ak@it-klinger.de, jic23@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, lars@metafoo.de,
	linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org, ajarizzo@gmail.com
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: pressure: bmp085: Add SPI
 interface
Message-ID: <Z04u8eAvytu-y8LH@vamoirid-laptop>
References: <20241202181907.21471-1-vassilisamir@gmail.com>
 <20241202181907.21471-2-vassilisamir@gmail.com>
 <173317237354.3142409.6212368803030680874.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173317237354.3142409.6212368803030680874.robh@kernel.org>

On Mon, Dec 02, 2024 at 02:46:13PM -0600, Rob Herring (Arm) wrote:
> 
> On Mon, 02 Dec 2024 19:19:05 +0100, Vasileios Amoiridis wrote:
> > The BMP{2,3,5}80 and BME280 devices have an SPI interface, so include it
> > in the device-tree.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  .../bindings/iio/pressure/bmp085.yaml         | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/bmp085.example.dtb: pressure@0: interrupts: False schema does not allow [[25, 1]]

Hi Rob, Krzysztof,

The error is in the example, I put the tree from the I2C example to SPI
but I used bmp280 which is not supporting interrupts. Will be fixed.

Cheers,
Vasilis

> 	from schema $id: http://devicetree.org/schemas/iio/pressure/bmp085.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241202181907.21471-2-vassilisamir@gmail.com
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

