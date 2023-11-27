Return-Path: <linux-iio+bounces-425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2227F9FFA
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 13:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE07E1C209F6
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 12:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC49220305;
	Mon, 27 Nov 2023 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="RAh260Gs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CDC10F;
	Mon, 27 Nov 2023 04:49:05 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id C373528EE6F;
	Mon, 27 Nov 2023 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1701089344;
	bh=cwI3GU5QJoO4WZeJ9HERDelXuedCeP382ih3gbwwNT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RAh260Gsp/50YvzL6LtuRInMnm75fhSYkHl26MnnD4o7eOLYSREw85VC5FCkcTXri
	 KoHC/yP2VnrzoN4vv7m4pk+sM9XpEmDJ/CMEM88NNIcA7KUCUfuAQeobLvBynnd4ge
	 gspr9WBW27T5ii76QZDVVh6L4IU3NsZoBq4/8zG0=
Date: Mon, 27 Nov 2023 14:49:02 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <ZWSQPrExmcT5kPit@sunspire>
References: <20231126101443.13880-1-petre.rodan@subdimension.ro>
 <8641e35a-d481-4c27-b450-9ee72ae769b5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8641e35a-d481-4c27-b450-9ee72ae769b5@linaro.org>

On Mon, Nov 27, 2023 at 09:06:54AM +0100, Krzysztof Kozlowski wrote:
> On 26/11/2023 11:14, Petre Rodan wrote:
> > +  honeywell,pmin-pascal:
> > +    description: |
> > +      Minimum pressure value the sensor can measure in pascal.
> > +      To be specified only if honeywell,pressure-triplet is set to "NA".
> > +    $ref: /schemas/types.yaml#/definitions/int32
> > +
> > +  honeywell,pmax-pascal:
> > +    description: |
> > +      Maximum pressure value the sensor can measure in pascal.
> > +      To be specified only if honeywell,pressure-triplet is set to "NA".
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Sent a pull request:
> https://github.com/devicetree-org/dt-schema/pull/118
> Once it get merged, both $ref could be dropped.

thank your for the PR.

in patternProperties, please also add the int32 type for pascal.
your patch seems to cover kilopascal only.

cheers,
peter


> 
> Best regards,
> Krzysztof
> 

-- 
petre rodan

