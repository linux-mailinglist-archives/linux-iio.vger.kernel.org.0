Return-Path: <linux-iio+bounces-23658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A252B40A56
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 18:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA871BA24BF
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14805335BC6;
	Tue,  2 Sep 2025 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pNrYgng5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4587633A039
	for <linux-iio@vger.kernel.org>; Tue,  2 Sep 2025 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829669; cv=none; b=JCJ6adfCvVcbm35Vv/fYMXh/N4jfNqEEzpf2uOz8SK/OW2vabQoZhDrdXhByuflRepxhdaH850XmfFKc6dxIVfvUWcjIDtdkH0xwv5hSE7Izt2YbG8DINhxsRaLvA/PgvPsJ8K1ujbisbFqFjVYeBoVqJ+Uv40xe6rKNCNZwDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829669; c=relaxed/simple;
	bh=8KakwUs9w5uQvGgO/qlDwkwrRh3Xy+4LJjuL9JHcF0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFJDqILg7WOZnQNvgK9kOFQRgxbwJtx7QgD6pjYiZrOq4dIsPFW3gD4aY7vqO+EIEBOELsAOYZ0TvdQV18EeVPQvMnTv3+RtWGE6Rio3pKTcfShN1L8ypBtKFDjX/l3OnZvJ2PHImqkozexu6BDuPdDR111ax5jWUm1ypeT55CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pNrYgng5; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-315a297f9a3so4125748fac.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Sep 2025 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756829667; x=1757434467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orpAkwTVPv0MXV/WFbE/DlQx4Btx9fD1+LN7AwDL8Gw=;
        b=pNrYgng5VkHbge51BJrgQOSJXXBOQ9yTih/kdJK7TsKE9W82xKC7IMP7X6cspiJsMn
         Y+zamkWQTw6MmVvVY9W1o32M1yxKmUcS3Zp5g6x6OP1V40ek9aGUILwyRn2kTlp336DU
         cvG9/x6FhvCmqi5nb3NAyHZn3qIiuK1ok0K+ABqyA6UatndfyQAqFvUKRwRf4aE9S8S6
         IrhszJsYSr1eZ7eXe8CQ48zJAloCEFp6Y8nNPX36dOc07G4kYrpg8gTP3kaKGAvjMU9m
         bhoJN1TLsuSZ23R7Wl3wQFJPpjH+fxLXgr156uXSDy/zs02qYgxNou6lKlccsYHXhB3W
         dVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756829667; x=1757434467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orpAkwTVPv0MXV/WFbE/DlQx4Btx9fD1+LN7AwDL8Gw=;
        b=mwj+PgaaYzZg1qYHSnX/umvpAeiMzDavoSJS5Nv+Rk77CRmN7KmgIbFebZ4mmevTG5
         w7EzGx0fI752VFpj5yL9CfNQ0MUFHHrdiWZ/6Wu9iJVwx8B4MCVs6ScYFmSJs4O3Ipoy
         +2MLV1vHprZp1rN5omu3gVz9LkPpo+Vz5eiqW8sqGYiMfhHmh3/xtdyT/B2/lBaypJmz
         CtgnRnfxfQFuCdDs3jLGfGwdSLMCCiLS5C0gSPp7wx9JdwWVYPQA/gKBHSW4qlvcKskY
         Dxz1vtIMFYLyLyrQLs8WpGwpDislyJOH59395vH4TKd1kwybpZ8/amvg7JhSNVrYcHqB
         uv4A==
X-Gm-Message-State: AOJu0YzBjmMDDPtihFyvZMcIhl3rqI9pEYHWmYIDDS6TLXBtKhkmXuAF
	ALIVXZ57w/77f2X8IJAUNlFJosswGnZA0XbTMo9SBeanUSa1vASz39goXQ7l0wBtz7E=
X-Gm-Gg: ASbGncucKYAJu2SGocIjNEbQ2H/yJ7Nb5ppQ3NGCkiw8etJSkDRqrkqk+Bkm87775fx
	3oiuad1YPjXCurJkXFsCh3c7fn+VikoKA74DFbDsem14QjVRtKP2ES9RkZ8lvI4f7JO2LubSuYQ
	+MLZ/ooGDCigjZ9X1Rh2xT6MHQ0EeUl9MU6lCUTSrMtvfZZbnm+PhnDo7CbPlPzDSFnHq1vz0RD
	BUJK1aGVlc392EVoKNRBE8dB/fLpnbndTKEePLJu3PPLa4emVB9Dthb/QJSU7rEHMmdHw2TmcCY
	kA6Z0rQbJqtl6RKbwza5S28FeyHuGqm3ivrcVrBESB6bawezCIq8bEW+S2lGJxpoz4ndnrHlJ0j
	1977BElZjViRDvgJxRQ+RyPT9m8RH9Mq7hVff5sj2CNZpeGlnpzVT3s3DjW/Fv9y0f8g51hx1LT
	sBFv5h6Tw=
X-Google-Smtp-Source: AGHT+IHB37pcMO9SvxflO6nxfgdfZB75H4/9Hbmwe3wEDcRmLYziIE5DuNRF1BQ5nD2UEoJR+WoasQ==
X-Received: by 2002:a05:6870:17a3:b0:315:a68c:d90b with SMTP id 586e51a60fabf-31963345786mr5936179fac.23.1756829667146;
        Tue, 02 Sep 2025 09:14:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d95:114e:b6f:bf5b? ([2600:8803:e7e4:1d00:8d95:114e:b6f:bf5b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745743b03d9sm1649626a34.30.2025.09.02.09.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 09:14:26 -0700 (PDT)
Message-ID: <4fbceae8-012f-498b-b5ed-77705448d0c6@baylibre.com>
Date: Tue, 2 Sep 2025 11:14:25 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] dt-bindings: iio: accel: bosch,BMA220 improvements
To: Petre Rodan <petre.rodan@subdimension.ro>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
 <20250901194742.11599-2-petre.rodan@subdimension.ro>
 <9b5bb45d-75ba-4674-9c4d-b04766496447@kernel.org> <aLcVK-YzlcqaKV_M@lipo>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aLcVK-YzlcqaKV_M@lipo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 11:02 AM, Petre Rodan wrote:
> 
> hello,
> 
> On Tue, Sep 02, 2025 at 07:57:03AM +0200, Krzysztof Kozlowski wrote:
>> <form letter>
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC. It might happen, that command when run on an older
>> kernel, gives you outdated entries. Therefore please be sure you base
>> your patches on recent Linux kernel.
> 
> I'm using the bleeding edge togreg branch of the iio tree, git pulled yesterday.
> I indeed missed devicetree@ while manually copy-pasting from get_maintainer.pl on the bindings patch. I wish that script would provide a valid rfc822 email header instead of it's current verbose output.
> 
IIRC, the --no-rolestats option will fix that.

Suggest to use b4 or other tools to automate this.

