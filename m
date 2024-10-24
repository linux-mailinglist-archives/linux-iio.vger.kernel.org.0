Return-Path: <linux-iio+bounces-11051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61E69ADC61
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 08:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771BC28515E
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 06:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E3E18990D;
	Thu, 24 Oct 2024 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rJhx8LlQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD06F305;
	Thu, 24 Oct 2024 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729752070; cv=none; b=p+beNj6IIb/JmNtACAEf3d6jeAl0vncUfnJGWAy1t/vEEn/VJJkOxyXdN7xlIb2C8SmthTf5EccKdSFU7TZ/6fIF51VzqJNJKp5WndtwE3KjX6z3Ute1KjR6OTN0szpMS6xqrZKhpQqCwn9qs8T9QA+sF/8eb2tSbb60HoSy/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729752070; c=relaxed/simple;
	bh=bc6iJeWXEaxOjG4jKgwzgxdbpD8V7c42zt7De09e2Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ly5pKVk838XrlneWJtjDt8P3xQHx1WtWIP+ooK7VMB079RC8uzXSZCwjT2i/SKM7bNnyJEy+PCT/D0JnW0QvXdIa2/FIIXgQ+IQksNjBLva5gGTFGDFmGJ+s8VbkXhnHNR2s5+JR1MJY2p0pGrQvQwvD2HFKED6hgPDnpJR4M3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rJhx8LlQ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <ae3213db-4edb-4fba-8f9d-c6f283735e9f@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1729752059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACl2tqbewGvJw92CJ4kNP9tneHmagPklyabSFXr2GmQ=;
	b=rJhx8LlQ6zR+RekM8VyNLFoBhSVFfoGrxtQ9asWXTZGponDEH5hcveOXdXrXe/F0xSkEPG
	8zU+BM3zjaiPnugA2aL5pXTCSUu0q99M/hItuQ5KajoHJF19niXpnDU3tCw52GFnHOTR9A
	uDX/4CFqgsCDNuc8IhjzcVC+fvJsjgSRAWX1T+bg3JkYT6IK+w5g0Cl96le8WhNKD8/kdB
	ISKDx/cZ1YzTgSj116TRf2/NsYvYZh6dMTsAzSzDSJ2fzQxv6pFfwG206ywOKDpeBpWf4H
	Tm77zzglh29h+vOr5QaF/Q2f9tDgyVnvpi+P+aX17AtsuN9Vag/MSpz3OeZkIg==
Date: Thu, 24 Oct 2024 13:40:50 +0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/6] iio: imu: bmi270: Add support for BMI260
To: Justin Weiss <justin@justinweiss.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 Alex Lanzano <lanzano.alex@gmail.com>, Furkan Kardame
 <f.kardame@manjaro.org>, 'Roman Gilg' <romangg@manjaro.org>
References: <20241020220011.212395-1-justin@justinweiss.com>
 <20241020220011.212395-5-justin@justinweiss.com>
 <87msiwm90s.fsf@justinweiss.com>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <87msiwm90s.fsf@justinweiss.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 22/10/24 22:50, Justin Weiss wrote:
 > I couldn't find a shipping device with a bmi260 using the 10EC5280 ACPI
 > ID. Some prototype devices with the bmi260 may have used them:
 > https://lore.kernel.org/all/
 > CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com/

The Arch wiki has some recordings of that. Most likely got fixed in 
newer BIOSs to the BMI0XXX coding.

https://wiki.archlinux.org/title/AYA_NEO_2021#IMU_(Accelerometer_+_Gyro)
https://wiki.archlinux.org/title/GPD_Win_Max#IMU_(Accelerometer_+_Gyro)

On 22/10/24 22:50, Justin Weiss wrote:
> I can't find any evidence of BOSC0260 being used, besides existing in
> the Windows driver. As suggested in an earlier review, I added it here
> to encourage people looking at this driver in the future to use the
> correct ACPI ID.

Based on the BIOS code from the OrangePi Neo the default value was 
10EC5280 which got commented out and replaced by BMI0260. For BIOS v1.19 
however OrangePi will use BOSC0260. I might provide a new DSDT dump as 
soon as I get the newer BIOS from the vendor.

-- 
Best, Philip

