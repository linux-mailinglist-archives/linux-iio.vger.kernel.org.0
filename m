Return-Path: <linux-iio+bounces-6881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2271F916216
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 11:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A9D1C20A55
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7A7149015;
	Tue, 25 Jun 2024 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/eJZurw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9435E6E614;
	Tue, 25 Jun 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306811; cv=none; b=XZ16nVWEIcWpO+I5dXOAu5a1Eflz0U5bJAOiBojDrIUyxxI/nPPWNff11hFf0RVMyqvnMWVY1VWeRAdVZ+Ky5KpBMswZgACPKEYOE+Rhs2wGVjt3/ZV11BTTGKr21HIfxB0lig75OxpYow6THUcXCCkHqq+Vdm39hPVBC07N7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306811; c=relaxed/simple;
	bh=sSCx3bNKipo0mbi+oLydQMGkdIjUEPEFksKnqSclEts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXgclSbKWyo5XMN0HhPXRtRUc/6eCgHtCDtzmUG3ma3TA7fowIUht3xVRojQqDuemAAznHoYqQw/h9y69YySOzq9QnDNAJUD66VyYUsbU041IxznJXC3mIFPnCx+H3XPwTQZcxhtiKMwCtpqiF/aqKkfmdosgg//81DelBfNr54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/eJZurw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70673c32118so1756463b3a.3;
        Tue, 25 Jun 2024 02:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719306809; x=1719911609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFUXIztaKwSfVhHDSApIXy3uEVPrRp1fUvtZ/DNoNy8=;
        b=Z/eJZurwydFakVyGGH8aiEFmV3RyLHnoopoCECXqvHSqxMLso865oJI+4Bg7ZUl0tV
         6HeP4eL+SAYG/KqaQUx4Li1v4YjJUO6ImTUL1+U0TUHEbWSSAX+T2WxyX8hOsOkofJSo
         ghrJR6/oQ5hV52DBnZdOujN1Rdh9PV0FYbk7oP7hnjxAlnoGOeHa1liLcrCOMGxviaJv
         Mm6FRXfMkvwVTl5gmW2UbGKmdpPv7+15LjT7t8AZVdgs+dUSZWhTIca4D6A2SiLdwQSR
         Nxvyn8xIZUzm3sprBpciLyL/l3tuXh/DyoNxEOhH8OcVsgM274EYW7aG1eFA5I1NmwT/
         +wbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719306809; x=1719911609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFUXIztaKwSfVhHDSApIXy3uEVPrRp1fUvtZ/DNoNy8=;
        b=KU7Jy6t3ejjjA9HeIgIDYbfRn78UF5tfU9iHDFEPgyyMrpgovQJ52mA9EnZyMipYIP
         7fPhHO4VLD48D+I/dV7UlnZkojEQjbiCoAYyBiXsBAb5amDN5grMpZIFgSl1027VT2he
         gCzPEFOv8KhLor+N33P1jAAZLjw6+tornGKstqd+b8ADuJECJfSDmkTll26ZGuQUi7gv
         Yb2ENxdQI1J1CL6JR6xX55Ers1Ko4fDcEflh2l+d3iVPR7agJ1DWcgCG+e/ya4N4VmpZ
         HUUQShUGp8e5QT+QZscc0FCREXpBvV5lHKsLT0RrQbllz6sVx3lPx8WdG2lUOYutRzmW
         20Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVkz/MfvRWiMwYB2P6Dh9gOrvqXiQZY9rlJQbeJKiEti5zZHazXc3kpzctgVPOwdqaYA/d5bVpnmDWka8h2xLEDyofTQ9oHN3Io9l3K1hQtQMdUKmH8il+pRyvsZBIWLDxznGoP2VDXBC+aCSEtMtEbWk6aeIZ2is/2V5dPZaGZcRss1w==
X-Gm-Message-State: AOJu0YwF2y99OHKgdb+BcgjtxhI1FFLIr9aDpNTOWpp0LNwpI+U0oy9c
	6S3L45eHErgRpWdWsRGy1EKjQIch/+gCu9plMDDkb3c4kj9/sfHO
X-Google-Smtp-Source: AGHT+IEW2CMNNaxZzpBQxPistTmZF+GN357r3PKCXrGvTrg3JJQAx/VN6wXy8UXEnBLZTTKmGAspOw==
X-Received: by 2002:a05:6a21:191:b0:1af:f8bd:1e4e with SMTP id adf61e73a8af0-1bcf7ff95e0mr6700645637.62.1719306808726;
        Tue, 25 Jun 2024 02:13:28 -0700 (PDT)
Received: from [100.90.230.39] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065698b90bsm7187139b3a.111.2024.06.25.02.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 02:13:22 -0700 (PDT)
Message-ID: <b9412b5e-069e-49cc-8a4e-b33babceb5e3@gmail.com>
Date: Tue, 25 Jun 2024 17:13:13 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, yasin.lee.x@outlook.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
References: <20240625-add-tyhx-hx9023s-sensor-driver-v7-0-b1d65b221811@gmail.com>
 <20240625-add-tyhx-hx9023s-sensor-driver-v7-2-b1d65b221811@gmail.com>
 <171928733216.1434276.10145662447261263501.robh@kernel.org>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <171928733216.1434276.10145662447261263501.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/6/25 11:48, Rob Herring (Arm) wrote:
> On Tue, 25 Jun 2024 10:15:11 +0800, Yasin Lee wrote:
>> A capacitive proximity sensor
>>
>> Acked-by: Conor Dooley <conor@kernel.org>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reported-by： "Rob Herring (Arm)" <robh@kernel.org>
>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
>> ---
>>   .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 107 +++++++++++++++++++++
>>   1 file changed, 107 insertions(+)
>>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml: single-channel: missing type definition
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240625-add-tyhx-hx9023s-sensor-driver-v7-2-b1d65b221811@gmail.com
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

Hi Conor,

Thanks for your reply.

The testing for this version needs to be based on the linux-next branch 
because the referenced `single-channel` only exists in linux-next.

Best regards,

Yasin



