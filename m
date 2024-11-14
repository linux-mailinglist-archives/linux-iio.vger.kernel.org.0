Return-Path: <linux-iio+bounces-12259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 301E99C8CEF
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 15:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EDA1F21C86
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 14:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F9C39FF3;
	Thu, 14 Nov 2024 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcC/fXbN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F181C1F60A;
	Thu, 14 Nov 2024 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594937; cv=none; b=b5Ex5q6xTdgcC2Ni5hu9gTmXJ2MdxYUL4E/QvVzbC7ZZymzlIQe9Zl+GCThzpBpB+NB9sjHPRoE8aQBCCsncNXX0oGpraEXJMq8z0KXbRD6R0DUHVHTQx2dXxNP3ynd2OYmobuctHODZwlMJnGKjsuLiSwOt1Wh4e5pmIYLQr5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594937; c=relaxed/simple;
	bh=z7tjh4aS3LtuFvx381OwVjVKqDQWbxj9dQ96ffC7VJs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=MKG9C9TtzolzprW44YIa9VR4HgolfqWGGkvhifpTAK2v/qloAynbEQWnNHLS9OSVYKrwFWh/A4LbvjrsiLVD98r52KU+8qbqtwdwHgSUmaFMmoAiiqtFOv2q/EYSM28ou3/vlel4g3uNEoQu8jet23UwGCqS0F60opQ32d2Yo2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcC/fXbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434A8C4CECD;
	Thu, 14 Nov 2024 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731594936;
	bh=z7tjh4aS3LtuFvx381OwVjVKqDQWbxj9dQ96ffC7VJs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=HcC/fXbNTlpvdnE6a/iAT0KwY1GGJzNq6zepkAc7R+jzDU+DAUuw/0JIvUYtGjnuj
	 qeoNWENjONmR1DOF/QSh9pDJ1uTlJrkf/WH291ZxyQ1u7/5JUo1//aLQ3T/ytx7HeQ
	 yd0LPLSHXxCU+mu4FWxOOzy8bWD0dwqvY3mab3rpVID8otWvhoWkiMKBwXn8AXz/Sx
	 O+VfyOgi6xf7ORdqVRr9J+750LwRbg5Vgh5iXryaZONK79+jlJM6BW5KmscrlHVnal
	 UH/G54HQlb0BrVmEZE9PXVP270696Xw2fSDGpuFNVVXIeupNH15jBT2rolKrSqbx6O
	 JCgdXjiwGWZ6A==
Date: Thu, 14 Nov 2024 08:35:34 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Kim Seer Paller <kimseer.paller@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-iio@vger.kernel.org
To: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
In-Reply-To: <20241114130340.7354-2-ciprian.hegbeli@analog.com>
References: <20241114130340.7354-1-ciprian.hegbeli@analog.com>
 <20241114130340.7354-2-ciprian.hegbeli@analog.com>
Message-Id: <173159493449.4168533.9910621025953686531.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: frequency: Add ADF4382


On Thu, 14 Nov 2024 15:03:10 +0200, Ciprian Hegbeli wrote:
> The ADF4382A is a high performance, ultralow jitter, Frac-N PLL
> with integrated VCO ideally suited for LO generation for 5G applications
> or data converter clock applications. The high performance
> PLL has a figure of merit of -239 dBc/Hz, low 1/f Noise and
> high PFD frequency of 625MHz in integer mode that can achieve
> ultralow in-band noise and integrated jitter. The ADF4382A can
> generate frequencies in a fundamental octave range of 11.5 GHz to
> 21 GHz, thereby eliminating the need for sub-harmonic filters. The
> divide by 2 and 4 output dividers on the part allow frequencies to
> be generated from 5.75GHz to 10.5GHz and 2.875GHz to 5.25GHz
> respectively.
> 
> Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> ---
>  .../bindings/iio/frequency/adi,adf4382.yaml   | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4382.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/frequency/adi,adf4382.example.dtb: frequency@0: 'adi,charge-pump-current' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/frequency/adi,adf4382.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241114130340.7354-2-ciprian.hegbeli@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


