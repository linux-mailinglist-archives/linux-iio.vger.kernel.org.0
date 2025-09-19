Return-Path: <linux-iio+bounces-24293-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568ECB8A2C2
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 17:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92942169F5A
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 15:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D203148BE;
	Fri, 19 Sep 2025 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="woZR/Vwe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B16238C36
	for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294332; cv=none; b=fhI2EoAEhggzKBYf4wLEDQ+F/DFipLv2ydNggV41N1tf3PnBFCGFx55DzR3AmcqDwWxvU0NkePUbLxFrpGltY/2L+U5yUNRVhRGhvR7Bj6bbLq/U620FbI17ma8BPtg2nFMATwceccRm/x+znQ3BOSEeVXz5S4p0blrwUl4QhKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294332; c=relaxed/simple;
	bh=uUO5CwNe87tHFiGJHfDcIkGWhy/VeqLMEjuLJD/XXms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmmTmXS72i6UkvnJM6HKt9YJBlenUqMa/S1SpA0joKrMquKMaHu77+IJX0kfGc+TUfgHZV2XIXy4Jj2FXCazV5yCU7DUIiFaR+OCl89T30yAUxUZcZWYDWFfn3YxmBcEu2bk6n4tKAt2ejkKKmivkyyNVzLWmL+yQRlyaW5vf0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=woZR/Vwe; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74c1251df00so1226714a34.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758294330; x=1758899130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Di+7QfVxJlM5N75ul507uuevWczBYUSs/W+lEnzOwXU=;
        b=woZR/VweK1NvvB6TIZua48lsV+oiangk7axDdMcsoK9f4wpnu3zmJGk0mXwEBvOeVA
         hijXr1T4zmRXHLqVp7VvL9w9sew8NlTvQ/n+RqssOo8QtJDIJ/2gro6lc9SDqqsWcSG+
         qoFfoEZoMVeqG5lK/Y3im6X6MQ9AiAMh0UM/2MWuF8KFXhiSDcMjh6irW4jF/DUZuf/i
         pNTlsPJLA3J837/IUr6F2h2VukF2RZylHItVPfRVUO+08N5grdPBif8suTYQqEf2dmUI
         nMNN8gEHdOs++8S2AJZTFlvuYmZSgiSpOlY+anD8fJslO92E0IYcKM1kFlsUnGj8KaAl
         JZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294330; x=1758899130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Di+7QfVxJlM5N75ul507uuevWczBYUSs/W+lEnzOwXU=;
        b=UgdAd6BRPwYVFDuao/RsFzwuby2kvdLJtGhudGv2SxyaW+JCUUfQuDDiCObu6vT6o9
         nWh+wku0apLnUxNIlI4QqZIkTzEkGpLYoSW3REo3QwAe3AmwC7gVch3Ml/gjQ8maVxri
         LsBmwEuTyJKlhV5YTn7YCPRr42+8/59pB2TH4L+SarFyfATtu/cxSpoo//+Zp5DLdRO2
         46JUQO9gRx6BnNcYSzm804K4KCzr1OdaUd19aRUdIBiQY/iRCC6rNdlXZTIia8FZ6KZd
         rCGJB7V/RZ98l8e9b86bZhiHCWaKEgzS8IZ+KmBMMJElfPnEg5EOqYYBXQlcuBwNhHep
         hK8g==
X-Forwarded-Encrypted: i=1; AJvYcCWOA1Q3gcX04xJgpxG9sXrWbM3royipgCaEz8O36tvnQYt9YuRsVZLgVskn3i2P6U6whGg605KT42c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxHaLaVZ/oafnaM3TFRVt1ngSTD+xIRUlGEu+fRlwSBu03U+LF
	WHE+M15NDsjrkCH5ymJu1h/UOHNalWia3cVAR+GTYERYvNN4isFL6jFqdAOYa+PaUvY=
X-Gm-Gg: ASbGncul5Q6WKTC8m2ezzbx2/aTQ9JsAvMVEzhurc2dRfKgbGZ+BL7mAUDAqDDZkkSv
	mvbr+RhEZyEu3O1P5YM6auWpMr3hAQlGKVlxLA87JqaeuZjhc6fKWPloWZXuO11mnABIUdZ8Lwo
	m/yu4dVIZfvY2IMpVTrPU9Pw+oXmkJWEGsLFIkolevQYpEOpHffXpaQfrJwMnkDMxEqJTT0pwXz
	9acArEPfETxzQqCcbc7pEUmmwhjuArrw/VgfcHeLnADmrm3lhrFY32+QhrnqCyrcl3MuPru8H0q
	VXrVVuQmp/H55s8zNh/GmStFCBiXr0IQ5JPU4bJsj4Xj4Rs7nd6WbyT18Z4aE40Ynd743NCjhJe
	dngCMQhLE2mUcyw3ivsksrxHoMKiVMFZSm3MqOIlNM/uGytNJv0dk1p5+ZPGwV1tgI5SWwsLQ6v
	Q=
X-Google-Smtp-Source: AGHT+IG08d5Vz/pDeKppQVqd3yfcz+3VBkwoo1u5Ijv/qxwiGp1N6zahOZ2QY1NxeZ4IhBE5UjoRGQ==
X-Received: by 2002:a05:6830:4902:b0:74b:7c40:357a with SMTP id 46e09a7af769-76f77d489e4mr1731055a34.18.1758294329709;
        Fri, 19 Sep 2025 08:05:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3838:157c:c9f9:2e3f? ([2600:8803:e7e4:1d00:3838:157c:c9f9:2e3f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625d8eec45csm1692036eaf.10.2025.09.19.08.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 08:05:29 -0700 (PDT)
Message-ID: <f16ea5eb-cbda-4788-956b-d41c2af51745@baylibre.com>
Date: Fri, 19 Sep 2025 10:05:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
To: Greg KH <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 sboyd@kernel.org, jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 arnd@arndb.de, srini@kernel.org, vkoul@kernel.org, kishon@kernel.org,
 sre@kernel.org, krzysztof.kozlowski@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org,
 casey.connolly@linaro.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-3-angelogioacchino.delregno@collabora.com>
 <t3uk3k4h3l53yajoe3xog2njmdn3jhkmdphv3c4wnpvcqniz4n@opgigzazycot>
 <aMlnp4x-1MUoModr@smile.fi.intel.com>
 <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
 <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>
 <er7dkmzutsu3ooegeihjzngi6l3hol5iaohecr3n5bolfse3tj@xeedlx2utwym>
 <aMxWzTxvMLsVWbDB@smile.fi.intel.com>
 <2025091925-thirsting-underuse-14ab@gregkh>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2025091925-thirsting-underuse-14ab@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/25 8:59 AM, Greg KH wrote:
> On Thu, Sep 18, 2025 at 10:00:29PM +0300, Andy Shevchenko wrote:
>> I,o.w. I principally disagree on putting MODULE_IMPORT_NS() into the header
>> file.
> 
> Yes, please never do that, it defeats the purpose of module namespaces
> completly.  If you don't want to have module namespaces, don't use them
> for your subsytem.  Don't use them and then make them moot by putting
> MODULE_IMPORT_NS() in the .h file for the symbols as that's pointless.
> 
> thanks,
> 
> greg k-h


Could someone suggest some additional explanation to add to
Documentation/core-api/symbol-namespaces.rst to explain the
reasoning behind this?

Right now, the only part of that document that say _why_ we have
module namespces says:

	That is useful for documentation purposes (think of the
	SUBSYSTEM_DEBUG namespace) as well as for limiting the
	availability of a set of symbols for use in other parts
	of the kernel.

So I don't see the connection between this explanation and and:

	[Putting MODULE_IMPORT_NS() into the header] defeats
	the purpose of module namespaces completely.

I am guilty of putting it in a header, so if I need to fix that
I would like to actually understand why first. Andy has mentioned
something about potential abuses, but without any example, I haven't
been able to understand what this would actually actually look like.
Or maybe there is some other reason that Greg is thinking of that
hasn't been mentioned yet?

