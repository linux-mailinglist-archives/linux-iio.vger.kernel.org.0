Return-Path: <linux-iio+bounces-16934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1593DA6452C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 09:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5940717115E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 08:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D7A21D004;
	Mon, 17 Mar 2025 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbkBjope"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD821C9F1;
	Mon, 17 Mar 2025 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199738; cv=none; b=ifAdW0YXqlb+Tnrz+ajfpn70rAPhZyV4lKXZ4dRbQv+ZlGh/pgCLSc4r1wKKaTJyrRTKRV+YMOTEC01faBR2Fth7UGVvnfQS7ey8yOcihCdiKbLK3uOpq16JN5eSX6mkukunY3mAFm+5lsCYGl1DbboTzyd9hlvCdlfAo1cmQSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199738; c=relaxed/simple;
	bh=5YRSK7/kMdbdHj+6rcKNANI5ccwGPToBCiTHQMNwgiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqBoKcTjGsHtS7RyA2kzTySyr6uStb3CQaYMP5DHtPcunaPoDC6tPWs0iTJAVwbKwDcgveevC5e9VsSJC2FJJaNloYKopsCXw14/xWAGeRpXRw+DZTySaiBH+18zRXtxL1mq3fwNewkTZzFWGDFseLgbSQGL2DchqnJU9IAguUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbkBjope; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bf1d48843so39420771fa.2;
        Mon, 17 Mar 2025 01:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742199734; x=1742804534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8FRI6cy9CCt8b2M5LhQNzurCwCuZ436s4fIsfr2+0s=;
        b=KbkBjoper1YlosN1XEUA/zyyPXp057aySLx3GWcsfk2MX43VmMw6vylweyV81stj8r
         5dT/M+kDrpHatxtvoV3prjBfZ4L/rq9VD/bamkgrR0dOvW4071n9JbrFgXAmk95EklCv
         ySQH7Xns0YvivxGAFaFOTAbMmng05I8Xuz0q8ZyaF9ghcHekSjaqRq9p7qu8vm4Ay9WB
         qO157A3iV3ttZtttESLo4YgwYZABVneE3mqqXScRHzCW/gf23JMGzBjbrC/sSDo0h7V/
         pdIaCughE2KNdzrTng4kDP2h4W+9Ji0BOnSmCmaZtDNdFsk8QI5Gy4G7sSST6teqJmmq
         B2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742199734; x=1742804534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8FRI6cy9CCt8b2M5LhQNzurCwCuZ436s4fIsfr2+0s=;
        b=AjdPPdp5LndyIXjsOh3Mjh2PCNloM3GFD9MVLbEtD/8HVlUDzS5MP7KCpmPK7O1dy1
         YwDRjMjN51GMSOmu6HUxyLYz1ZYbCjWBxkmEG+RtOKJ5qBxHTYh/7qwaML1kKxBKXVIh
         CIjfte6AYw+GH4j2eaBgcBkoAftsno8rtrjt6iUH29XG6CLvq0/WNb/A3kKpHQR079g3
         NumPwlvDz1ixvuFEkTnzvVNwgtHphHf3Biaj1t7tiTYK2ROfItMsBaK3W7X4S1EnS4Kg
         mUtwPhiMYg+Xu9K4CBPotGbo1QA1mWh1L0+L+5GXzXODtvIZiuo/pFzDz5gzVhco5SPA
         EPKw==
X-Forwarded-Encrypted: i=1; AJvYcCUMRLt3QDFx4oo7Lv1eFsRmEvHgGKQvcUZLyxpAjvyyr9tAkSe/hm41hhEt8Tr+qnIZVZdDxrMtVm5gDA==@vger.kernel.org, AJvYcCUiBWECvoGQabUFV+ZbffOODESlRymoVMZyzjC657Nw/lIKNenujUIoGri1QRNQjtI15QReuF1/qI3i32nN@vger.kernel.org, AJvYcCV1SZ0Uznavogk+oGzAb8APKCSjY6bTbn4DgRpG5rEQQQ56WIzNpJPC5gLEkaEdAcqSjOgl/xrSUoAX@vger.kernel.org, AJvYcCVn/tVl2cfXS2Vk1zJayfOrbZ3Nnc6dRNZUPjeUiXxcQ+wfcolS942Gmg5MVTRSyFvQOE03snr/4weV3mCZ6cQoJc4=@vger.kernel.org, AJvYcCW2zTe9yDaDojhaB+xfSQNnLepsm2Io6CgG5KtHUJJWayW1KuhpnUrOEWnsOFQCodQe2o6CC0MrwWFv@vger.kernel.org
X-Gm-Message-State: AOJu0YznyyIiJZLW5K261wA9sWwTVzdWdmLeijXY22DHIRyTRbWA5+8i
	jpHw0TuYHwm1E+gaHeHPpQ5aEQ40WZNYVwWlqIwmsN8mcSE+v30g
X-Gm-Gg: ASbGncsU2vsZqhCY2jXQ2oloHKzo49SN2kk+Pm4Q/yWekBaCIm9HtYdM6HMH/b3WHBE
	XCibrxLSU3ZviZrvJrnpoGKTq+DT7hatZC5D9UvYtTkwcDAntyjw5MVq4bc9cUx3wLJi/ai1jCd
	KG3c6252ku8Ki0PWv25wXIhCzn37ttaz0DvG8lQXUYEbseOcdthI31xV/RQxOy0fhgN3YD7cAMP
	czeaaiEstfio+R/fxSILkZdfSBjOYCzCqFUFjX6LFL4jtaYQ6bFvxCU2OUFpn7tsJDpEFw068Fj
	EMv0pcFjl5O3cmLKuSz9nh4jLEDSR+1+zwBxgHQsNY16SL6jS9o78tjIHuKC2Si1C/Ykuy6svu8
	a/FCcMLv7izSDonbza2JcyGuMWg==
X-Google-Smtp-Source: AGHT+IHBKGlUlP46i1muxXD2BoUJCo9oeQCMBPNLoYtEWkTjbhR1aqc3+f20CvsiTwirEb5eGG/pEA==
X-Received: by 2002:a2e:be06:0:b0:30c:1fc4:418e with SMTP id 38308e7fff4ca-30c4a8d225bmr66527681fa.26.1742199733797;
        Mon, 17 Mar 2025 01:22:13 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1c2233sm15370161fa.69.2025.03.17.01.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 01:22:13 -0700 (PDT)
Message-ID: <66a93de8-f5a2-4ffd-9c97-c646934cc90d@gmail.com>
Date: Mon, 17 Mar 2025 10:22:11 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/10] iio: adc: add helpers for parsing ADC nodes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <c8899e8c535a1d93cd7588b7c160eb0fae5d26d2.1741849323.git.mazziesaccount@gmail.com>
 <20250316093752.0eacaa16@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250316093752.0eacaa16@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/03/2025 11:38, Jonathan Cameron wrote:
> On Thu, 13 Mar 2025 09:18:18 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> There are ADC ICs which may have some of the AIN pins usable for other
>> functions. These ICs may have some of the AIN pins wired so that they
>> should not be used for ADC.
>>
>> (Preferred?) way for marking pins which can be used as ADC inputs is to
>> add corresponding channels@N nodes in the device tree as described in
>> the ADC binding yaml.
>>
>> Add couple of helper functions which can be used to retrieve the channel
>> information from the device node.
> I suspect we'll need the addition of an optional trailing timestamp
> channel at somepoint. But we can add that when we need it as only
> matters for drivers doing iio_push_to_buffers_with_timestamp()

This is true. That'll enable using this for devices with buffers - which 
is not possible right now as most buffer users do timestamps. I'll leave 
adding the parameter to first buffered user though, but I think it's 
good to say out loud this is doable :) Thanks!

> Otherwise no additional comments from me.

Yours,
	-- Matti

