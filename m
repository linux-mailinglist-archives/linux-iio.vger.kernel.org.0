Return-Path: <linux-iio+bounces-10110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE9E98FDE3
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 09:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D16EAB225A8
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 07:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7A7135A79;
	Fri,  4 Oct 2024 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DS/0HvMN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867F81AB4
	for <linux-iio@vger.kernel.org>; Fri,  4 Oct 2024 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728027286; cv=none; b=CHvfWKoHnRg+7EEkipcbAOORLusU6c0HdLh+gS2qiWWVPZgVWA6TY7rHW98HiqEcJt71jjbk5sVkmrMCsY2lXC4RczQt6TNGzX+qLDmRmWHKUaONuqpzTJHoxL8YjvADGkUYFeBOTu3wqVw8uFUnj2jvraM5yYoZzn2I1Ke62CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728027286; c=relaxed/simple;
	bh=qnKJngIhxH2qKkZlANdqo2TVAMoAbY339ChpitTXjWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBpKu6QdgZDTMSETHABTJ3jSao4QGEhTDoJEoV7XR148RGPGwZVs/HQYxU9YOe0YQbw/dgfyc4IIACypBoBhMCifmT06VEOv6WvavbDIn1KfefMhjiD7x/qg6bqO/eHTL2KvthI5qfcKawJrPHX3JS6I7z73P4LdxuI3uQ2kIVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DS/0HvMN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so17756065e9.1
        for <linux-iio@vger.kernel.org>; Fri, 04 Oct 2024 00:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728027282; x=1728632082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GS0qee4Dr9zBFYyHFbF+n8hA/AdRBxswxsHNws6eERg=;
        b=DS/0HvMNv510rSqczHVgc1U/FZz1MkHp9a1VpqAJyv0gOUnZldStaR62MKGu32MDtz
         tqh5aHT9PiFNBTqyUrReOpy3keLNEbjGWGe5oJoqTOmByqVUuCR7x/sXj3kH8FV/NfBF
         ga1muPDbvZNuZR9oPfxeIkRsPLSilD9BNzYWKP6q1mtYDBQe1jsiYz/1l82TpBCMQZTC
         dsxLBpkjlp0xizLHl5okNX0+s0KRb8onrOtvq6yvjGLiOuOGGe/WkKUzY5Gn8pajkjTt
         83BuCCaTgrU9aWxGVGAeS/qGRJWvAPGOPMYCrB3TqJGc9gtuKwoD33YzUs/NG+Cx08Kq
         u3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728027282; x=1728632082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GS0qee4Dr9zBFYyHFbF+n8hA/AdRBxswxsHNws6eERg=;
        b=JbDHduq4cpvsyV15/XlkSAAd6lpK7yMPW1goImtBYy4I1a+A4nZtXq77GyE48qq3qk
         4bAifFieLDTS4/NCvOZMTpJho7QF8K1s/3ONPClnf8SkHoBdzZGa1eDP/HEiwmohMWd/
         32Mn1engbGBQz7S9yxHnSkj1I/Rlttuhszaee3mLMvCn+LJsrVBo4cqLkrvXhiNSFN0z
         /T4SWmo2/0Gx4oFe6NhX6NfYgE1v5P+o+B3Ew2p6KCL+g2WnBOZsEeR80rSPKMz8QU06
         KgwbGBSJXRSE/v6t7am6M2n2oEu1uVtPvUCcawC08LvLBRryzKYBvT2jobLzS2zO0Voz
         9U6A==
X-Forwarded-Encrypted: i=1; AJvYcCUSEMYqWi+mPlkXH5fKpaxQYQIdWAWCgzpR40+iEHAUtSQXQVKleSMGEPvlA2uMIxDB/8tLeh5Xt4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhjyFCx0p4Pq78IZg1zAIX2sOnhX+AyzYJkLT15LIlHP03QzyQ
	vs0To6nMsLQyAd5kzlHUcYShCm6hzZf91pGZ6EwLjYcrLjTlJPdJ43BhrCShD4c=
X-Google-Smtp-Source: AGHT+IEj4DCuoWSM5WAIE5JyIBBND08HEFzqdyuMahA96VYXnu+qJdDkIgKQRM07Ovg6cYhr1mRArQ==
X-Received: by 2002:a05:600c:3509:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-42f85aef6f8mr11996925e9.31.1728027281735;
        Fri, 04 Oct 2024 00:34:41 -0700 (PDT)
Received: from dfj (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d081f70b1sm2680774f8f.22.2024.10.04.00.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 00:34:41 -0700 (PDT)
Date: Fri, 4 Oct 2024 09:33:17 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: dlechner@baylibre.com, Nuno Sa <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	Mihail Chindris <mihail.chindris@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/11] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
Message-ID: <744n6dut2ayboh6gilavqy65bgljmu5sz5embvtxcq5v4fhp3f@pfud6d2hiplo>
References: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
 <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-3-ceb157487329@baylibre.com>
 <172799847830.1778120.2943655597402379925.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172799847830.1778120.2943655597402379925.robh@kernel.org>

Hi Rob,

On 03.10.2024 18:34, Rob Herring (Arm) wrote:
> 
> On Thu, 03 Oct 2024 19:29:00 +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add a new compatible and related bindigns for the fpga-based
> > "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> > 
> > The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> > generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> > mainly to reach high speed transfer rates using a QSPI DDR
> > (dobule-data-rate) interface.
> > 
> > The ad3552r device is defined as a child of the AXI DAC, that in
> > this case is acting as an SPI controller.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 49 +++++++++++++++++++++-
> >  1 file changed, 48 insertions(+), 1 deletion(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.example.dtb: dac@0: spi-max-frequency: 66000000 is greater than the maximum of 30000000
> 	from schema $id: http://devicetree.org/schemas/iio/dac/adi,ad3552r.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.example.dtb: dac@0: 'io-backends' does not match any of the regexes: '^channel@([0-1])$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/iio/dac/adi,ad3552r.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-3-ceb157487329@baylibre.com
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

before sending the patchset i did

make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
  CHKDT   Documentation/devicetree/bindings
  LINT    Documentation/devicetree/bindings
  DTC [C] Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dtb

no issues.
How can i detect the issue so ?

Thanks,
-- 

Regards,
  Angelo

