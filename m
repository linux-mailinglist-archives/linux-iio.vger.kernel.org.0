Return-Path: <linux-iio+bounces-19077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDC9AA8C53
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 08:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AA5171E86
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 06:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24851C5D5A;
	Mon,  5 May 2025 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYJ7XeHl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64921CD1F;
	Mon,  5 May 2025 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746426721; cv=none; b=LRUEPZTSH1Pgn8vHk58Z5TRIeDCJUiPvmashYFHldfW+cT6x6qQJAhK1j9uviP5+ApXJSxKDi1fFC2qBBRCvZPRsDXCyBMr77M22aq4OIdsRjZLz0YUhUnxVwpBaWf+EBx2fxiNWINuv3AxhlL1jMX6XisOYoIChoB5OhP/+N4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746426721; c=relaxed/simple;
	bh=pLPzBlyf0JZH7001qoNsYXmUrzPGpnZ9O2Z+t6rCYis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/UFBalhhTLDerlTTxxfFhFoEBBC4tKkVe9hxwJP3O2lYdCmcDbHa9r5mKMuNay1M1COqQbjQOv+TqHgqNZfExCBwEgMvNcDWJSRclAkEkdmwsWarhGbIUs0CnEaRD9sk1djgWqX6+pHTELqV+wgRKpSLcw79085qIosdD7b5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYJ7XeHl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so4791774f8f.3;
        Sun, 04 May 2025 23:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746426718; x=1747031518; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vbw24H8VZPhT6RaFHXravug60RkyZOpPel6aIWFUCJs=;
        b=DYJ7XeHlF7wg5VAZ5cgTqgLwA8LeojL3lzCmfWxdJGeRrO1BKHivLifXXXtY54mGB6
         poHkldz3hj9eb7ey8E/eqFo1IqByhzjApUHSQI/tH+45xhML/5zp6wRXZA+HTDLocCiy
         IQn3MnEvbyipg8q1QVuqE+obM708eISyXHkGHL6M5dBdbS+asvDX/pYLURKS3MrKwK28
         oByqAwtzL9E8kfRngK4inz1C0I6ze5rAAD233LGA84twPjopNdmM2MPETHTmE3VtmAs8
         Cn6vdbx46kePskC7KixLfOKoJzz0i5FaWpOQJNIjlntu/um1H3FHcusMUp5KMMMkOEpJ
         cyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746426718; x=1747031518;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbw24H8VZPhT6RaFHXravug60RkyZOpPel6aIWFUCJs=;
        b=p+gu1j80BdcJwSnpiqxilBxuWlQUfF+xabT1rtOUPR27KHBGMhcT1EYM5Yii0KbBxE
         /E8Okb4GbKNb7q07Aewrelof81EV6REEBJnZmmxOAG0I9OoqclMb1K5nQmL9aX2pp6aJ
         8UvGPQxuEzH6nwtaP/42bChpDCsctc5s+MTiz5n73MvBw+j87BtosQYw3lxfh+76j3jG
         KrnuC09ArQewcDbiyAbSYeLcsZLGNCpU5HImrGUi+v+IyGBksgJs1+JdgxVZFwV9QBCx
         4GsnXJ6NjLK27hcxaDWbC/3yA0R/aOwHMU0Eok8FpqdB0XeP8nQ/QAREXaGDmWZuXb/G
         ZZNA==
X-Forwarded-Encrypted: i=1; AJvYcCU0/jjkwu9ai6FqbhjrUcdbhzd+5WEVrhQjmnGwKwdC6E7PRv7rnHbog7thtA56em+UODTcNkR/b+Lm@vger.kernel.org, AJvYcCWWSh7wgdaS39mXNfjpTFC3GmJ8mp2YjldEI+zQLm7qJ3LqiC+TzsqDi5ByzzDCv3euhRuvK34xDAlNl1pB@vger.kernel.org, AJvYcCXdXPzXfcprlLSyhjvkhqKAxr98vGfncU+owKAZ2NkU/ANM6ARReBa58guFwa9rVkJbG8wmnqmCmSkn@vger.kernel.org
X-Gm-Message-State: AOJu0YySdRSGJtjUzcVOmP4XyJWLQzCJTPNPEZrUQyA9jMeAbI7VFCxe
	zkCEhc8LnQrnsDB0vh7DTdfmiti5xXxN9Ye/cqTbu66SOZeCObTxD8g2/yV6
X-Gm-Gg: ASbGnct232XwivSVjv53rmMacUQ7h+x9wa/bn9No9qT9s9TYqTAs1GDranI9n3U5e9P
	UyftMqWxzrRkPcbFK+1H2l9X2gg1gy82XtnEr7l6h3C9cJUXyiEWV+2xDdtfz5Cb+qVA0PJWrvW
	cPhQF83ub1ltKQ2g954JqaPf9obVfJumzrOYJvdxtQ/x5je39/FLSrAEneQdf7+KCTdLRk5NvSn
	PR8vGoDy+cadWDaziUCMqytIk/p+8IjpeN+UUgL9yNiCRD8DDIs9tJBtCtl3txCLL24csOLnhWd
	6P7NdVS14aRFY46DoPTUECZeF7T6WYgaVi3ag8OAKyR+BRfiYA2tPhluVGTNmaUaC321efi4ciI
	=
X-Google-Smtp-Source: AGHT+IH+jWYpjzofC8QlOzVATOlZIev/fhdc5IIXJQYEd7GBl2maEGzmnvfrNPAAYQ/6nH1CSw+EhA==
X-Received: by 2002:a05:6000:2a3:b0:3a0:85ad:5ed9 with SMTP id ffacd0b85a97d-3a09fd7a183mr3885284f8f.4.1746426718015;
        Sun, 04 May 2025 23:31:58 -0700 (PDT)
Received: from ubuntu2204 (207-pool1.nat.godollo.uni-mate.hu. [192.188.242.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0cc9sm9237518f8f.9.2025.05.04.23.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 23:31:57 -0700 (PDT)
Date: Mon, 5 May 2025 08:32:02 +0200
From: =?utf-8?B?VMOzdGggSsOhbm9z?= <gomba007@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: chemical: Document SEN0322
Message-ID: <vz5ndf6mojowehi5b6cz6ljsknnatxg6iomghndbt2ffdld3iu@nywmhejv6oge>
References: <20250428-iio-chemical-sen0322-v1-0-9b18363ffe42@gmail.com>
 <20250428-iio-chemical-sen0322-v1-1-9b18363ffe42@gmail.com>
 <9463c3b0-ce67-4c67-a8e9-91b4ffd09a58@kernel.org>
 <uju5lntp3hzibbrw6ej53xhgvkkpjory74l5et2jspwocuj2xr@bbterxtg3ba7>
 <20250504192701.6ceb9daf@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250504192701.6ceb9daf@jic23-huawei>

Hi!

> > > No other properties like supplies or configuration? If so, this could go
> > > to trivial-devices.  
> > 
> > I don't think so, I'll add it as a trivial-device then.
> 
> vcc-supply?

It has no switchable VCC supply.

Regards,
János

