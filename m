Return-Path: <linux-iio+bounces-26184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DF5C53923
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 18:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBD64500669
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 16:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8463342CB4;
	Wed, 12 Nov 2025 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jO46oGgS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DDD342539
	for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966360; cv=none; b=N0j6wcgL3jZPB9WJlvNBMjvQb3BTFZN6VU5t1zFTwc9NKx0VgNBBTKusQYHRis3bqpNq3e/IUXr3uusqOF3Pp4rlF+KfJHvur4XMXAq9kBf8vhVz0ven3osneQc/g2c8APdrskHl65hXMeHGYd3tNSu6W4iIlIgtkE+C6OgacKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966360; c=relaxed/simple;
	bh=vquyA6U0yVLVU87ffFxSvxSxY4DbgBQ5yYCH68Wc3l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRjG/kAYtmDzlm/7y1LOHEO5Y5tETgv6TejlRrlrbkZ9kfe+uNqjqN3hPbxgU6pNcZ81qcPj8uUIvucDfIpNRlF1Kr+BOdDCoH93c3OrLRpLmnE6m8AgVidt/d6Wei2l4lRZ6d43hajfnURH+yzRRI/E67uKrpD9LQAmiAplSsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jO46oGgS; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c70e53db41so575181a34.2
        for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 08:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762966356; x=1763571156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otKN6HaBW7TeFZXmhol1N0rafttZcw0ehXIldHQZRQU=;
        b=jO46oGgS/vM3MXXYczpi4QHmtXP4ZJ6G9q+Sfnq2whfaApDS5crM9wQfMGl7pYGSSF
         kS5DX/Ko2AXyYeJ1cwm2qjGLv6RlMafrr5J1cXTVxvacrsR6SW2gT6knsOQdYZAO6zSY
         d9Cgmf99MFjOpBDPnWQ8BW8GwOun1+B8s7WWmDVNjto8kTwxkkntu4+H/CsBP0F/arPK
         2Ry3hfnAzVIGT8YeflrPx+6zEc3djCRx3Vonriz2hNiJKY9YXrPjki+5youDgXgRqU+L
         twTzmcbLFregOVEXAm2a6AA1Vr0EaauKeBWqhA9Z1OTTlndzLeM2pdXl5x8Hz8/KaHQC
         9JdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966356; x=1763571156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otKN6HaBW7TeFZXmhol1N0rafttZcw0ehXIldHQZRQU=;
        b=P4Zx2uagPuo0Edf4aiTcP5pg4LFbU7DEcOycy4figolfcUWBxYyHhNQymYq57iW/R/
         nNZz6djwGwMdfneRUtHjbYhuaKvBE8W8crDRDqh4RA4qm2hDNwZCbj4+c9H4DpFf9Wo1
         gWcstb2sGrBULxrpfNESYJqLEk2GKFeBrECYjBEw9uwqDAu861SL3Nj8i68HsbooKU63
         6iiqgOIMyHOub2derrZLx5pe26T57sBP+ty/zAhfDLr3qld3ipOTpfcPKI0Up9MmDH+x
         1rHQyAk4VDFAxeTNzDEQnqnliORGZthfvGGACsk+pz2JeWKp3HsLZQ9Oy3zQELrjIFeW
         M3Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUo6XFtcUFqgjWnoBuAQu9VW45prmV7juZOfh3r9c9l2TammLKs7tzt/z0Z7zq73+Mcy/+JH8/oSB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxoFcYYaKbPQSlF6fsr3W2voa7Ze/3dJE9xL0xnpwr4cbtmw13
	EP1QjmWi0sAYJN7GVRSy/XTV0x5VJcJoWAoKJ3uIgTlFLlr+QYYBJKBPnGbg9ROdh7A=
X-Gm-Gg: ASbGncv6HbEVjU//Wyh4ovEr3LvQYbzOaKmotX8gs4WtzKB667iTC83T+N5n0e9JU7f
	il2fOKF6gsmFyIFZGPOswk8G6a+tZ4syG0s1mxfMJWFrgp1Awqfh8auc5S/fYGwsKIxyUjvGA+q
	5z+QwYE4zJVeVJu4JansitNs/ELojDyuHwN87Fs0KuxIr+uMcpzohsSaabccg5YOth7M1KzzAXx
	N51FAeQR9ueBPAB3RXqB8B6pS5Ck9e8E9DqZJrV+br0ZNEOCNlZTgPSfURd5EmSa00xCS75Tt2+
	9yKGCMCqVfNNKjavCnWk9ydNSAWAyppTEfc+NLMxWF4DHIDkdF9LO8DZdG8JX3p7nxyEbOpnRFW
	jMWhmAooEusIj321hhQ3nyHzzhnSvNxO6/Ael+RxWDlsWFcq04mcND/PCFRGNOrPYjOGgutTT5J
	E3qixU2OpHjOSDMcAlhFfC9pQY0Tkh5+LWgRiLDIyM8QfmD9WVhw==
X-Google-Smtp-Source: AGHT+IEzlLhnjrljziZsPJD+6TFphu87RW7odVOmHqBJgKS1HNWc+2CO5ak3CF5B+KTraiO0uH2Sxw==
X-Received: by 2002:a05:6808:1b07:b0:450:3c49:519 with SMTP id 5614622812f47-450743f38afmr1702472b6e.7.1762966355944;
        Wed, 12 Nov 2025 08:52:35 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d404:301b:b985:c499? ([2600:8803:e7e4:500:d404:301b:b985:c499])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57ec231sm8495588eaf.17.2025.11.12.08.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:52:35 -0800 (PST)
Message-ID: <b18db31d-47e5-44bb-a671-c8d8a9f2cd82@baylibre.com>
Date: Wed, 12 Nov 2025 10:52:34 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: spi: Add spi-buses property
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-1-2098c12d6f5f@baylibre.com>
 <20251021142129.GA34073-robh@kernel.org>
 <14ae0769-341b-4325-b925-7bba6d57bbdf@baylibre.com>
 <20251030135126.GA3749313-robh@kernel.org>
 <f731ebd7-6494-45f5-861d-05a2926cc5fa@baylibre.com>
 <aRIbBVNzo-7EYJbl@finisterre.sirena.org.uk>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aRIbBVNzo-7EYJbl@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/25 11:04 AM, Mark Brown wrote:
> On Thu, Oct 30, 2025 at 05:42:44PM -0500, David Lechner wrote:
>> On 10/30/25 8:51 AM, Rob Herring wrote:
> 
>>> But it can't really be 2 independent buses/controllers unless the ADC 
>>> has 2 completely independent interfaces, right?
> 
>> Correct.
> 
>> The proposed property really only concerns the data lines (tx/rx). It doesn't
>> care if there is 1 or 2 SCLK lines and it doesn't care if there is only 1 CS
>> line.
> 
>> So maybe spi-data-buses would be a better name for the property? Or
>> spi-data-ports (using the NXP FlexSPI controller docs terminology)?
>> Or spi-data-channels?
> 
> This bindings discussion seems to have stalled out?

Yes, it seems so. I sent a v2 with with the property changed to "spi-data-buses"
in hopes that that it would be good enough, or if not, get the conversation going
again. [1]

[1]: https://lore.kernel.org/linux-iio/20251107-spi-add-multi-bus-support-v2-1-8a92693314d9@baylibre.com/




