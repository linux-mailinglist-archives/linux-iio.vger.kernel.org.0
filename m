Return-Path: <linux-iio+bounces-19291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8CDAAF967
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 14:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128D317C720
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 12:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B203224AE4;
	Thu,  8 May 2025 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A/BO6B2q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD951F4161
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706231; cv=none; b=UHrq8Eel1WIo1df7eR8oQvibuuWDpzD7nfkvTLMYYjZlzDeO2C+SBMJFA333sjJMTcTeICFwZ3afSiR5nkzkChlrlgzl3vdBSzlB8tCy3urNqy+q/sjPK9/ET9RGBtCc6a/J9exAG4fp1uzyzXt4CcI54cs3YOsLtUi3paAxb0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706231; c=relaxed/simple;
	bh=c2UydYRiZABjDwi1OkGZ49SkeDVc0eAIDOarIMlelG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxLYalItcWXujCde7lpWcCLWfF7ES0O0quwTEcirCd6RJtwCwmMSp1Rm8ws6qnBGzfrmxs7bbjr2ShU+mID7SoY2onWQ+m5QCfiPvQD4hEZOohzABrgB/Gq/G92CC/12AwJYWZKhn1zaGVohsOYDaYHgmTbL8YScEjuqkPo2dsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=A/BO6B2q; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so9245285e9.1
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 05:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746706227; x=1747311027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCr/fASoQ9d+Wzr6jsBtaRUDuMYmgQ3mva/5+I8JLbU=;
        b=A/BO6B2qBFWOU+YWTUQj/o1grCfVdHdHzIRFQfHAkYlZjuVLD2ixhduspLPdR10AQ+
         rGW68TZuo62SqqBbgYk1DBItRoKPHf9mo+UU3/viaEFqXeP24PLXllzPfsH5kvJkRZQq
         Pi5ekNQ6oopSaEcvj6drgHXDnUBOJQeIi0i012ewClcuF5yEtyLl57dTzqkdaFCVnEwe
         bTmSX3q0gugohF5+HkFvk0JO651NtY+D6TsiwGIwWXd0kFqtxN00u1gNR8WK46aQKMu5
         m9/dkOxJwK/c3TScq/TR8BlRLQv/SdMqWteIHbC+HRooFL/1h+YNhjBLOddEc6GvHgt1
         9QGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746706227; x=1747311027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCr/fASoQ9d+Wzr6jsBtaRUDuMYmgQ3mva/5+I8JLbU=;
        b=mXe7gpj6D5tPyXfp6/Hv6G4MOSrhXYf1E707pKJXaqkQGVBMiMatbrHM6n+yz6X7PT
         HANZzOa402VomTt8MOFXSLjD2IHj1ZoaI8xXBvpR9O2wvdd6teXbRTL3w6dquf9Rh2xQ
         4Rt0cbeOEhlx8uv2UVXaJzVpU5y3yFhW1jGZSy/oDgM//r1Kh3hpcxyq57FeSaPuofN9
         X59OpGjmhuhpifX2PhyUIQCkVeuM/qgdkHXr4eDERCwa+EPz6b07ew0grdtWQi0i/xGb
         9UWYG026/ziQLajOdWKDbkEGAhBTffYSWIberzpWk39v0OrGJRv1Gn/BJZdqlJE0kfGu
         t5YA==
X-Forwarded-Encrypted: i=1; AJvYcCUrA71b5lHKTf1yxWcekLBAqRQWTjftHVwWA+BdF4u0s8niSLZLQ8wVib7Afi1r4U/9rtblqHgx+T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnK9PdDlYbO3R/IcIW3Z7i3M5oZPGBpXc9XI/TX6BOJ62g3gq9
	aqlvcKN+FaXQTa9rMPR1rhyjCmlEM9XINxHFLgo78lbGGT6PCNI2RuhmzlHsyUc=
X-Gm-Gg: ASbGncvDfXAMSfnsgfalZ/cRJalORmxBjLgrag2Oot6jwEl/S7QylnytUxdlzpMBOti
	oXpKA7375qs5HFl9hOEfW4Zd0ywG+27eUPoLZz3xPYeEURKPulTiaMrE5rTOASltr6SMcrOyUgZ
	J0u0vcfbIvbtRWg3All2uatYKW2AShQKTW81ddOoGBgP9jmvQGvJNE5nNLz5qgkupGuTSfaHZ0a
	/XU8z3e1tbzNxOsU7pxcWCbo0452QhgFXn321K+Cj4vtxu3ND20zi5MiWOwKMypEThD+gNdin9K
	8ZUmkAKAfe3EfdMHjoAvA0n4AegUC7xkQquL7Jws1AEp9o/Ty3VULcoIyvZM8MHcewDerW0bPgP
	Cq7N/4xI=
X-Google-Smtp-Source: AGHT+IGfsmdkVxEPUXpvMPfmbVXBe5hRiXLdwuPpS5TCsEgIhe2fGLTYlh6QBdkZtFblzbFt29O9eg==
X-Received: by 2002:a05:600c:4eca:b0:441:a715:664a with SMTP id 5b1f17b1804b1-441d44dd0c6mr49544275e9.20.1746706227250;
        Thu, 08 May 2025 05:10:27 -0700 (PDT)
Received: from archlinux (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd38179csm34813465e9.39.2025.05.08.05.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 05:10:26 -0700 (PDT)
Date: Thu, 8 May 2025 14:09:12 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Michael Hennerich <michael.hennerich@analog.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] dt-bindings: iio: adc: adi,ad7606: add gain
 calibration support
Message-ID: <bttbhfjxwtfc4rxqde5rc6s6gqpgutsya4s2mezjl5t37yuuoh@lgayj2yp2mva>
References: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
 <20250508-wip-bl-ad7606-calibration-v4-4-91a3f2837e6b@baylibre.com>
 <174670267187.3889412.7858960687511929039.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174670267187.3889412.7858960687511929039.robh@kernel.org>

Hi Rob,

On 08.05.2025 06:11, Rob Herring (Arm) wrote:
> 
> On Thu, 08 May 2025 12:06:08 +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add gain calibration support by a per-channel resistor value.
> > 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 29 ++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> 
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250508-wip-bl-ad7606-calibration-v4-4-91a3f2837e6b@baylibre.com
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

I am getting no errors at all by:

make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc
make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml

Regards,
angelo

