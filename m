Return-Path: <linux-iio+bounces-20611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CECBAD9356
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 19:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AE416FC80
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 17:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72D1217727;
	Fri, 13 Jun 2025 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Utvw4WCZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90DC54739
	for <linux-iio@vger.kernel.org>; Fri, 13 Jun 2025 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834014; cv=none; b=Fhx14nj8hrwen0tyP3h9dFkqcOay5yAhCqSC3jMMfxt/E7DsXoWzLuUsLfsIOaK+0n2BC7w126FaHUcWygPIrXstkE+tBJOFRTgpo2d/OnBBFBhsDbjxuclXg8seN3h/WM3AY+3xVTQoqrjcDGwdGsoPDQ1tFOpDhZQsdWMCgkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834014; c=relaxed/simple;
	bh=qFHf05pLwIZBpGvazuZgcxkgWqabzO1YL2jAHuc/neA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PW+wQEc1ADIZJxs2Iv1p86/8HsC/Rs44Hxbk9bS9ZmdG6nd4/TC9meORlx2QuSQezEqrVz99/JgnqWrB/ZE0/xOdJ9iQv2Xmp/tnQ31sxg7CQDJ6JXu1E81B1uWwiE3aod8Yyd+g0+6KyQhnnU/a58tGcLGM+Wfs4aPkZE7RaWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Utvw4WCZ; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c09f8369cso836043a34.3
        for <linux-iio@vger.kernel.org>; Fri, 13 Jun 2025 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749834012; x=1750438812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W4PmbLTdx7bKxmJ58LSBL+52b6YKUjWHxLD3jkqTwUs=;
        b=Utvw4WCZi1urkBooRT1Cvxk+qwFRfZ65qKh2LkZ12mBRhfipGAdfquzUsR8jtmX/Bq
         ThQoKCxNxFHgoPYxD3nipFoxgW8EuDlwurwsLZ9/fFrHqqMnlyjcOkQzExEX2L5qb2gh
         g9mBbdxh+lNpAkNo6jJ79U7yjusivdMHLkK5vY75A1Sjw8TcCy+Sk4b9UEiWjaoICv3D
         phDSwyW7z7pTyVdTuai1qBlPwvj7943eAwbcOWtNcuMCO2EEur2/Y2LHyLwyK8nOjOH1
         Napiab14EHuueN/EXia+A70Ke97cS1mc6LmnCfDD20ChK3owKqygRp4kzB1qemed9+2s
         UFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749834012; x=1750438812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4PmbLTdx7bKxmJ58LSBL+52b6YKUjWHxLD3jkqTwUs=;
        b=KIl54PsHrwHtYm5eiEmCz+3NyzFWBrJ7LBrSCHqNJPWJ6YaM36NBlYXSj/Q4s939yf
         e1MY+DcbfO79rBImzf6dyUXyAKxK9AhMEOTW7mjVwd2HaNFqGgHh4zYNyz+mj3cafhy3
         6x8nUJf6aTCkiHAA337gQy7kgp+dvSY7t0qakRquJjrxEbYfOtPC+w1V2OgYJY/Ag+T1
         rCL9wByTMJCRsCJYwn9sxIq+mTWVLRkAviugR2aiu+YLKx9bm4QLC6yVx2KPMkNh1pQx
         1TapDW8Cc/NPHvXcnTcT6f854LT576j3JC+bjmuBJI7OeTiYem0f05k8MN18sSBT8KSC
         HmKg==
X-Forwarded-Encrypted: i=1; AJvYcCWvGXcglbdXtKbyxOLDkuaG+Kh4bZOAz98Cy5m5mg/iRjFxqSXJa77egK+IfGBdxQdK/ZiS774hbjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9oUkgJCFvcwS4/duBH1JSQ+Of0kDw335y55026wEvjY2qIFj3
	EJldkU3eQvoL76MrrrHL0/BLnfrK+My41fF74ZmiyO7GsfayVzv0cnpEHw6PqEPr6aY=
X-Gm-Gg: ASbGncv9OmhzNh+Mp4MdTCmjr7Oo8Dk2yY1TDEil3GX8sYNrQJuDBv9A93a8bppaXX6
	gCKrUJOrWVrfmdzEOfWP1QF4KMXtC/5qH7/4chq9IH3QfaGEXvlUQbABv0RklBTsrffYMKSxCRM
	T+z4ytua/oS3ufZNO8v7uPJVY6YHwwOOSFgzcQiay2YLJlVAB2rEncfgoq2qCBnkH8LyVVZ3dV2
	d09NcI7uElIdF/9Tzg5SAb/Jpzy/yMXWV2ndvciu65iSf55w1yEx/KMcx9q59hWJlOxQhg51YpC
	DHldcwsNyCP10E+NRCaemC8mf56Sf2Ard83j8aPc5E3dDHAFvp90LN/w/wmMI5weVzHuiJZPo+5
	vIFUCR+RpA+7YToMlJ1jG0d1xJ1o90eMHB85S
X-Google-Smtp-Source: AGHT+IE7h+SZVToKJUAin3fOr868BbMSOLFocQ+et42SsT9JMuC0JS5qAKXXAH1oH1f2QX3S8vjHvg==
X-Received: by 2002:a05:6830:210b:b0:72b:94a4:9143 with SMTP id 46e09a7af769-73a3626644bmr315551a34.2.1749834011794;
        Fri, 13 Jun 2025 10:00:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4647:c57:a73c:39d8? ([2600:8803:e7e4:1d00:4647:c57:a73c:39d8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a284ff5f4sm258694a34.43.2025.06.13.10.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 10:00:11 -0700 (PDT)
Message-ID: <46208c8d-8370-4b9e-bca1-7ede7ee9b078@baylibre.com>
Date: Fri, 13 Jun 2025 12:00:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: stm32-adc: Use dev_fwnode()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, jic23@kernel.org
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <0ec0fd5e-8fbe-43c4-8aad-f36d2872f280@baylibre.com>
 <20250612084627.217341-1-jirislaby@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250612084627.217341-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 3:46 AM, Jiri Slaby (SUSE) wrote:
> irq_domain_create_simple() takes fwnode as the first argument. It can be
> extracted from the struct device using dev_fwnode() helper instead of
> using of_node with of_fwnode_handle().
> 
> So use the dev_fwnode() helper.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno Sá" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: linux-iio@vger.kernel.org
> 
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


