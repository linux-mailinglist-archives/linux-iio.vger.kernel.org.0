Return-Path: <linux-iio+bounces-19194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3901EAABF00
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 11:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304034A4966
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 09:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6588126FDAA;
	Tue,  6 May 2025 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTILdd0J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599AC191F8F;
	Tue,  6 May 2025 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523036; cv=none; b=rHMaMsqIFjT2d8ARbi6wZfGxzNx8On+yXMAuCiQhjbUvS5cjQ0EdOZKb79+/UzaVDbZ+5lW4Wpvj3Jgj9tgDvznyiyaKwLHQZgYEHatx9fRXk5QQYBVZB0DDRMnNQwcpyjmKXLfTksfbFEq66rpA2SQnguwhvLz2TIJ4a8aEImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523036; c=relaxed/simple;
	bh=ukJB50c9mMYqzCAtA+XXO+NPEMa+n2JUO6FB0u6yFpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C69aJvMhhtqrK4h8QzL3IsUWScL3xBw8C+zsIz+c4CKVKHuYIovYVzi95BbCY6yoPnaM+n27hHO1PxHyTwHWbNnSgHisrS/siSRxsfbzZzHbBV5z2fJ3gvtlMX+EF0TnbJRKnOy93pQ1a3CWl7vFL3Nc3gfrB2Rv//CS8mNxPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTILdd0J; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-549b116321aso6646379e87.3;
        Tue, 06 May 2025 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746523032; x=1747127832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=brki9Lw3Xd52LJhWPJClU7ze3qNpBlrJZZan0H+h80M=;
        b=MTILdd0JCYE1FzEF7PRDSoKlutvYCCV6eFk+xnt2zh1kcaCSbxStpU7qMk+ridTOTG
         9ytc525aoY8GMBv6owxJ+mhbtBsm354H91iAZMj/Dt4fXuyr4BcdMza+fBragYxrsuh/
         sVa+scjkpYeYMxolW7F3eNgS2KwE4ncO0ar2Ndx6lxnM/2XzkJn4aRs8Fx0rqB6zxifY
         6Nt33BP9o9WhM62DZ2+NElgf2OoOi/2VytYlZtHXRNNImvahBZebEVrlniRqlmDBrkNZ
         Pee+NeeyX/bsL+SsUDDRkoGsOpew3mdUB0kbjXoDVPag6H7jDKthr60HGatlJtKgDeSm
         enHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746523032; x=1747127832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brki9Lw3Xd52LJhWPJClU7ze3qNpBlrJZZan0H+h80M=;
        b=pZz9bFgSIqt6P/k0BDjY6L4UC70DHrdEYLEfF+Os79R8WZ1Z5XV7QFTW4RlT9hrgkg
         keQFEkOkecwTXo+nnZTMXt0ZZWtqqDEXUWbKLjHMJM0zJpcqCMZxfhSrv7vkpt1g305r
         0vWJcSMNs+kN3VsqENtDAaOR2HMsm8KGa4EnGW6RW2U8Xrg12S3gdl++lmz1CUkqA8b5
         tvjgO2ObU+/LqHknUKltOAGI5hY2YF5LYX+WXn2P4b/JJxEBG8zkJk6onJ23V5YpIUMG
         6d1JUUoExNDqJNCKkyoGPpR1GAgCuKkjLTCXM488pRNqL2B0MQ41DrcXqw7yCkwljRZg
         W9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYdrGS2DeS+jEQZahGxU4+2iVachNZsdyG3Tb6Mt0zzrDfqQjxtmgXa3/YODxlTjmQZMQ0oshIU3880fOr@vger.kernel.org, AJvYcCWKjpnu4C2EJVu8Fr0o3ZprK2y5JLjds9Ey3dXbuteX19qTVrpk6dowNr5ugGO0crqfNDmiJ29BrwsZ@vger.kernel.org, AJvYcCXonytdjF1Ie+y9NPwFpRRf4U9knd2yhTybqwWhAKWRKWiB57GaKTRnxca+vAnAFDuG9AkstawVAnW2@vger.kernel.org
X-Gm-Message-State: AOJu0YziTAV45x3eiT+eAIXHruzoXRCpTyFP70k4/UFdkkDBM35fGNWl
	qGb+uXACJJs6KE+R246APffxWw/xCeARxdxTuXKrEVjBsRS3t4fP
X-Gm-Gg: ASbGnct3J/YP5nI0c7uS/R2iHjIH+3Wms/seiRD82xQMhUcSeSHxSlaY5j9p1vpAMO9
	5takw9ueQn0nrQgKtEANmCCwkRU3jnu/vkrCAQNJlh/cFgCR13Ia1YdtlNmTnzaQ75Do3Kej/qU
	IFO82QcnqcEDes43CDEzr9yQeaPmOxN79fo1KKccmVLbMNJ5lo1PF9mwgal//FRDAgdsxcSgF3p
	/U6/EcFZeVL5jDlC9XyngfQFaJzkZaNWZHq1MGuRbWOoFCo6rB2CoVyMGRc1WStOXN287qVbjuV
	MuJ8M5Tth2z07YOU8IDVknlmKXvTrDeg6dSwUxwOBFVvl5xB75I4LQ==
X-Google-Smtp-Source: AGHT+IFjiK3Xjle40kxRVFcwAY/YmTxjadceqPBaXXNCvckC71+6i2aXaHoevB+uXRpjTwevpD+Lyg==
X-Received: by 2002:a05:6512:31cb:b0:54e:819a:8345 with SMTP id 2adb3069b0e04-54fb4a62918mr823669e87.42.1746523032107;
        Tue, 06 May 2025 02:17:12 -0700 (PDT)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94c55ddsm1978017e87.91.2025.05.06.02.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 02:17:11 -0700 (PDT)
Message-ID: <f3abfc37-50cc-4bdd-bb19-0f0ece4466eb@gmail.com>
Date: Tue, 6 May 2025 12:17:10 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: light: add support for veml6046x00 RGBIR color
 sensor
To: Andreas Klinger <ak@it-klinger.de>
Cc: Jonathan Cameron <jic23@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 javier.carrasco.cruz@gmail.com, subhajit.ghosh@tweaklogic.com,
 muditsharma.info@gmail.com, arthur.becker@sentec.com,
 ivan.orlov0322@gmail.com
References: <20250316113131.62884-1-ak@it-klinger.de>
 <20250316113131.62884-3-ak@it-klinger.de>
 <20250317115005.72a539a0@jic23-huawei> <Z_I-qwzUrTNz1DZp@mail.your-server.de>
 <20250406120825.41b2575c@jic23-huawei>
 <ecb2844c-feb5-47d4-b4db-12171380a9cb@gmail.com>
 <aBkNHSxU4T8j4oMT@mail.your-server.de>
 <181472f0-5c00-4e1d-8f00-1d84b5c54685@gmail.com>
 <aBnINvJ0aS69kUI8@mail.your-server.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <aBnINvJ0aS69kUI8@mail.your-server.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/05/2025 11:28, Andreas Klinger wrote:
> Hi Matti,
> 
> Matti Vaittinen <mazziesaccount@gmail.com> schrieb am Di, 06. Mai 09:03:
>> On 05/05/2025 22:10, Andreas Klinger wrote:

>> Couldn't you still have used two different set of gain tables (one for each
>> PD size) if you chose to use the GTS?
> 
> Of course there are solutions for it and i was about to finish one with GTS as i
> saw that the driver will get simpler without. As i cannot use the nice features
> of GTS it turns out to use only the data structures and functions on it. But the
> data structures don't fit exactly to this sensor as we have gain and PD in two
> different regfields. So another table to translate the scale to the regfields is
> needed anyway.

Ah. Understood. Thanks for taking the time to explain :)

Yours,
	-- Matti

