Return-Path: <linux-iio+bounces-22923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 420F9B2A6C1
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 15:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF7474E3A54
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 13:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D0E218ABD;
	Mon, 18 Aug 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BVuujlT3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A0D2E2283
	for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524737; cv=none; b=o76Ra7sdYQXF7aPC3f91PHWlFmnISq9MJPeKPsJfU+FHQ1kwa/Cm8CaIJGbZ+ssxirZBbNOi84HZAOPxvXNsaARv5tbiw5v7ikYnorlO3Ai9p4aTSVzE6un53rGoKf1dtlvHW3X/KDBF7uPyh4hcYqNMl/+AAEKWoMhofnOSBDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524737; c=relaxed/simple;
	bh=STUgQqWAjMIDSo5i9CNXFPPNs8IXyZkPpT1rTamUjss=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W2C8aZwDUseBmWiasQ2HOR1N/4CkPg+5KNFUsHTnSPI65B/l2UqCjcddrDOEmrgLuW2t4HwPT6nOrE+uUNJtc8NyyZeOWb0THuHcOXcTVqbutdxT+e3tH5RY4CLDgVbnlcip8Xmg3FxmFbJ17zE6txXoI9fYlo6qRNkk+Sml8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BVuujlT3; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30cceaaecd8so1643278fac.2
        for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755524733; x=1756129533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=10gZZQnBGMVk+f8qeUN3o4WqLNCEED7akiLQmYC5IOc=;
        b=BVuujlT3Q63n/8JHdVtF2SjZ2L+RzHDNF6eZkZFWpqET/PmOeG/IzZX8QsL6loycTJ
         71sXQ5lvHqx2sxYv2jg+Ge3lDRW13u1XEAEdEjSrln4t+ZKyXayShFeUW944Ke6l0KEZ
         VfnplEN62blktyihRxTgGOBl2Yj6B0CBIrSZOo2cW1APcqrVoZ2J2sCONp1OfOhlNjBc
         5IKLsvKe3KRIxW28GgpYGXo2DNQrKsvHnOmGW0NFgHcWQeYpSsBb2yCqXsSghU/kssyh
         5oqC+SBhBaYxBRwEHon5kznX665yTcx1HhAkCAtfsXcEHS745J02o+q9rHJMYd+IK6RU
         wsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755524733; x=1756129533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10gZZQnBGMVk+f8qeUN3o4WqLNCEED7akiLQmYC5IOc=;
        b=FhpJFFHBEDMSVnWOeueH+32b3Jafh4783G8fnTqNSDbVbQOebJIEmHDHUp8xKCVWoh
         1MudcRkN16sv6OExzd4zJqtGqyFFdrT22s1kPZvqi1Wo/5r/Zmo1ktOfuifPh29q0vNA
         Gj6z8iA0yxowriiLKqNbPAMlkcOp7VOSplclhDgUCXc51V3a7pp1Boq9Ogjt7cZktXMM
         v3rxt6VPe48azckhfZ5XsWti2kn1aKj1Eu0aX+/V21WF/HR/RPnUsuPe58qKjcKrRq2f
         RPuUz+3HgZX6lYCxkxZYpi0oMpn4xm/JCtxA5SB2x7T0ouYcYM7yJzIf/YQd09tOS2vo
         DNBA==
X-Forwarded-Encrypted: i=1; AJvYcCXurcJznjY/APz82ET7sa6POyyxVnEvEM1x5t4689jb+EsNUrwKDYCBVcixruYWIeLBTnwhi5B1yQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuCB/Eh4Ne3+sVmpk5/PgTxxH3bSMO8HerVH7k+1I08d5njiI4
	78LG5jurNj6rXuy8RQztk75Hy+AJnXDLoVdQiwoxbKPjv4X8ke6XcbyWDoeE0JCXmUQ=
X-Gm-Gg: ASbGnctDtIVuLCG16qGUZ92bq49pANNKVTBK9WG8gDnYFCCI4RaxBFnv13Ru4r+6ah1
	shsvnuU+yR0QksF0rKuOGKaCPWfaFQuDRM2XVMCcvvNhKqwsMSxniMzIuZSZdcgPMxwLQvdoZbG
	Sn4jiofMHh6kOg5lk3Kx9L5Ruhc8ZprTrh/qZJV17XH1wh1bfDf9lgxYhbvBnyuNFw0anT1Xlaf
	adjr3xbbZUOBMm3q4ofbUO8Uhks+Yua8RTOZL8BD8o8oOJUaS4rxqvKt80vGIER9DoptZGkV7RS
	afWCNImzvmE8q6USaW7WdbLBG53PFsQhgJ3ICrW6527/6ckSf9O2RFXXa6Ghox88rjfQcAWGaGw
	3PT1072EC9duC60qlHI2WoY957/cIF9mv/320r1Gsm08fj2KslEbYRRE1XtffOID2ryI3nA/5nV
	0=
X-Google-Smtp-Source: AGHT+IHkEIqXEKYW0YNfPwdn51TV3aOxjzPemzFAD5aoQACwyHFGGzbO2hendQDxiUtyNr97EYzhxA==
X-Received: by 2002:a05:6871:7283:b0:30b:af6d:f92 with SMTP id 586e51a60fabf-310aaf6f1ecmr7757906fac.34.1755524733102;
        Mon, 18 Aug 2025 06:45:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73? ([2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439204e5easm1851721a34.38.2025.08.18.06.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:45:32 -0700 (PDT)
Message-ID: <6c323896-10b9-455a-ae8a-bbe1e2a80e5d@baylibre.com>
Date: Mon, 18 Aug 2025 08:45:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: iio: adc: add IIO backend support
To: Ioana Risteiu <Ioana.Risteiu@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Ramona Nechita <ramona.nechita@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818131253.8854-1-Ioana.Risteiu@analog.com>
 <20250818131253.8854-3-Ioana.Risteiu@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250818131253.8854-3-Ioana.Risteiu@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 8:12 AM, Ioana Risteiu wrote:
> Add the generic io-backends property to the AD7779 binding to enable
> support for the IIO backend framework.
> 
> Also add the adi,num-lanes property to set the number of lanes used by
> AD7779.
> 
> Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7779.yaml          | 35 ++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> index 044f92f39cfa..4a212c8bc9d3 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> @@ -80,11 +80,27 @@ properties:
>    reset-gpios:
>      maxItems: 1
>  
> +  io-backends:
> +    maxItems: 1
> +
> +  adi,num-lanes:
> +    description:
> +      Number of lanes on which the data is sent on the output when the data
> +      output interface is used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4]
> +    default: 4

Isn't 0 lanes wired up an option? I.e. it is possible to use the
chip in SPI-only mode. So it seems like 0 should be the default.



