Return-Path: <linux-iio+bounces-13040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881E09E2E17
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 22:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34ED8B2784A
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 20:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E4718FC91;
	Tue,  3 Dec 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCOrFjlE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DE8170A1B;
	Tue,  3 Dec 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256031; cv=none; b=P4YH4AjI8wf3b7cZ6HORCkCrmgFQktJpO5TS21TpCQuEt6EBILxQbjS4YjhuNHL7pFySVuuElfKaXqZvdxjxNOQmg8eV38/4GhyZaRghEQOjLq4SlsHB8PIQ8LK6R34PgMbsH6tdjpG0nIbthDPlWnkFFFgufAU4RCabMCjKFyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256031; c=relaxed/simple;
	bh=6uAeWI2STg46YgvhSqTgmb3rOQBK6s5GRHhk8EF+tmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtZnSbIXoJw/61agaYjftV3J7Nnt35CIfHPYDx056aiPrv/ti6Up9wxZPdZjw6kPYB+tISYzR/zJAFsPsuilva+6SamMOiW06yM1POqp5DSGET0N34uxOkswzN6jfN0owKHejOjLsP+T6jH/f7X/MPEyfz3n6SxFeyMexMVdud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCOrFjlE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4349f160d62so50403005e9.2;
        Tue, 03 Dec 2024 12:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733256028; x=1733860828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPcFrDSFLv4qUbsRXPZLxGzQXYHN+6av9DLrdlqIt80=;
        b=DCOrFjlEkaOL+5Ikk/orgOzts4YwM00dpHcItzo3xw1ut0SRtxsxHdG3HcUwtqjate
         mTcq41DykwmjqHS4rUrb/F45C4BFP8FMbwmg0xbw7g/Ew4784LCFVkzaO4nkXolVEQXz
         dVJPdKy3Hl6gqyqEbwP+T0nPQsrVqPszJS7k+ZNy66cv6lTCMxtk+kweDR8AsihejV2F
         jOWp3HUVXnN+RdN51XPWyM/1XYzZzQV7bjg19G3SaChJvTZr+iudYk8VpkbIOC+3wnsD
         KB+4pkbqS5YC5YVvgeS4u7osWJplpV3cHJjy1HiS0KFK9Pr4h5x5cF1Xf7mrgrvjXSGL
         ykkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733256028; x=1733860828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPcFrDSFLv4qUbsRXPZLxGzQXYHN+6av9DLrdlqIt80=;
        b=HAn83PeZdYnM0WppT5SezR1kE6AwzkBJ75QgCgyv+uTwMuD+T/Cu8R/7yzpsqPJthQ
         zpVQ00rEBWOnIyQLehsbQJ43N2+VxlFcCa9lT4imwq1UB6aMUTIRpwrLBQmFVknd1FP3
         5gl/AxK1SUNZ8GMautWgfSG1K/nbEkZwCCF+Or5jH3TJpWlxzreFvhvNPypds7UYPEns
         Vb9obJ1F5smjKrv3w1gCiQAAFzM/P1lGqd5pZNh8QVumITAvNGD0I25m8k4LzZge77Eq
         +OGkrc9qPsuMOqti32DDpBwrq9Bgx9l3CteThVqRg423oL4c8YFBq4KUAFtGl/DCejsq
         6TUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZLkK2/GPoSyo5pMy46N5YnJ+reyEOke38aCkP6w6HcyTejGoHbvR7ZzC3Cc825ocUrGDMdSBikCmH@vger.kernel.org, AJvYcCWh/ELsjPHQ6czGVINPdWTw/bb/xX1EQkjsZS98zWbCXwNSqpgqwqMPhVwtgnDJybReWzDOyEvrWzQa@vger.kernel.org, AJvYcCWoggFBcAtCAXb5dvVjq+2voh9OmZp6M9UIYMTcKlhgrRq9dor/AIsVv55jlNqCSfUjpkC1wKxM7ti6+35Y@vger.kernel.org
X-Gm-Message-State: AOJu0YySYD5GTTPk81lPHb1JTYGjt/WociLt56f8RMwDhfQYVF1ewRxT
	fkY+dFlmq9/opHpx5IsK3rcmSbu22XsRdd8ZCaDQb63Stvtr7yDw
X-Gm-Gg: ASbGncsVfxNBS5Loi+VTQx/Og4+HFIlNaW4UxhTmfTIgZyCwEstaP/ugdQ39Ms51u3f
	Es0AVv0uBnUU5OHz/Z5aUYhx4jC4vSch7dcnAH0moE0R+XH9Ve0QTQueNNRLlBUNMyrwRYSiNws
	g9RGFdUlmK3WJDvCzvQnwxzaZ1nXaDXs1grAGinMJwwENkFRICh3uvwXJrkCxgJSVSseF6tlYGS
	mQiO+hAwl/kRbIdh3g13HL+dVTWVkThUYwukx1jch5/Nz4RtHlPIzCl5Gqx
X-Google-Smtp-Source: AGHT+IFqkRi3A0DxsdIwParZrxce5ddjcJdKQjPGSpkoTXuB4rouM4hIag2al4lXuSZEcgl1FfwkOg==
X-Received: by 2002:a5d:64e8:0:b0:385:f677:8594 with SMTP id ffacd0b85a97d-385fd419108mr3016367f8f.43.1733256027443;
        Tue, 03 Dec 2024 12:00:27 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:56d9:cf1e:faf4:54e1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385dc169d79sm14455575f8f.92.2024.12.03.12.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:00:26 -0800 (PST)
Date: Tue, 3 Dec 2024 21:00:24 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, ak@it-klinger.de,
	jic23@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	lars@metafoo.de, linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
	ajarizzo@gmail.com
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: pressure: bmp085: Add SPI
 interface
Message-ID: <Z09jWONoaH3R3XSX@vamoirid-laptop>
References: <20241202181907.21471-1-vassilisamir@gmail.com>
 <20241202181907.21471-2-vassilisamir@gmail.com>
 <173317237354.3142409.6212368803030680874.robh@kernel.org>
 <Z04u8eAvytu-y8LH@vamoirid-laptop>
 <e5960ea6-c3f3-4cb4-a93d-adff20a665e2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5960ea6-c3f3-4cb4-a93d-adff20a665e2@linaro.org>

On Tue, Dec 03, 2024 at 08:23:35AM +0100, Krzysztof Kozlowski wrote:
> On 02/12/2024 23:04, Vasileios Amoiridis wrote:
> > On Mon, Dec 02, 2024 at 02:46:13PM -0600, Rob Herring (Arm) wrote:
> >>
> >> On Mon, 02 Dec 2024 19:19:05 +0100, Vasileios Amoiridis wrote:
> >>> The BMP{2,3,5}80 and BME280 devices have an SPI interface, so include it
> >>> in the device-tree.
> >>>
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> >>> ---
> >>>  .../bindings/iio/pressure/bmp085.yaml         | 32 +++++++++++++++++++
> >>>  1 file changed, 32 insertions(+)
> >>>
> >>
> >> My bot found errors running 'make dt_binding_check' on your patch:
> >>
> >> yamllint warnings/errors:
> >>
> >> dtschema/dtc warnings/errors:
> >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/bmp085.example.dtb: pressure@0: interrupts: False schema does not allow [[25, 1]]
> > 
> > Hi Rob, Krzysztof,
> > 
> > The error is in the example, I put the tree from the I2C example to SPI
> > but I used bmp280 which is not supporting interrupts. Will be fixed.
> 
> 
> So you sent a patch with a known bug or just did not test?
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

Nothing of the two. I didn't test properly. I am trying to automate my
testing+sending patches process (Andy mentioned something similar in
another e-mail in this series). Do you have any advice/tool to propose
on how to automate this? It would be very welcome!

Sorry for the inconvenience in any case.

Cheers,
Vasilis

