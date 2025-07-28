Return-Path: <linux-iio+bounces-22084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A3AB134F4
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 08:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CEE16C5EC
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 06:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1911C2222C2;
	Mon, 28 Jul 2025 06:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCrnNDKN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA7E2185AA;
	Mon, 28 Jul 2025 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753684423; cv=none; b=ldBa4f3yBztGMot6LrF1jkmoxFwjmF7aQVfoxQN9ufIuPWjaLMZ+j5bwpk2YqM5a1tqbs76tPLpdFu1a+t7gweSmfS5eNXgsE2u34+I4bh/61bgZ7dYNH8TYvrajOiOgDJeoU3bJ4XUiHjbtGOjoo+BjebyghAyeCCJ/7lsEZeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753684423; c=relaxed/simple;
	bh=NXmtPkpsI9DOkNG7xkMutzA58JXeOtft4Hp936H8kRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sNRN9VfQ0UVmMBg4MbwXNUjMUHqKRpaNx4Otomz3/2x88pStvlMB7lQpUBHlqT8fNhHSLWfuiHh7DE7U3S5VCvkM/rUPRDOW94ETL6bVb0VZZTh3mg87vKnG1zbtR0TLxnjNY9bXtIezMKlOflw4jrYL6/KyreedASO7XmIC9h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCrnNDKN; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55516abe02cso5108645e87.0;
        Sun, 27 Jul 2025 23:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753684420; x=1754289220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BdNOR8NXUxquHEOai7Jddyqm3K6j5St2h4nt9NmtQPk=;
        b=jCrnNDKNX1mdEKRqIcMhr3Rd2oHXkQYJbd8L4F5Lwt1hERwpLchIZ2+OrS3cEYeI/P
         oq/hOoYBGbzql+2lgeJsfnp4+ET9R2DI3zy0Z60ZhnpW7lYQKWKHPlD3XsTTZFJIpOOt
         pMsAt8Yny038rgMl47dFO7wXdcXkLeBNKpPZX7V6Ewv6EbWVPopoieJOnvGcuAts96lU
         stwazJkqKkP2HKKIx0mdIo76JkiB6liO7nycYFG9G1F9sDxljVtrGUenmTYAVcw/fBCt
         n/4B6fRWcdKriM6jtwp8BJb9L8U7LdyzQ+AG4qTNCxfBL6ZNhucSyz3TNUyMFSEM4zt1
         dEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753684420; x=1754289220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdNOR8NXUxquHEOai7Jddyqm3K6j5St2h4nt9NmtQPk=;
        b=BMxBoz+0S3L/E5B0CEMTuoOxuDuZJ1HxjJy6CyyyFl4pDUz42sTl4Z94keMG3g/WXA
         eM6m2liZ8SosDMWHV5h14Gn96xwmjVd/NJl0d9OR//GgDUWdoO4mMNvLe+FCiuqpELHl
         6gM1Z0iuDfMcsTZWl0bdIi7GzpBoSKISoS8xd3KSymer+gyDLJIZ76g7oiCQoSVxzwGn
         m7pcfbSnuvC1tO36wfcEBymheRARg55aV7YV2o/qkuDEmEcYekSMuyHPV89VuABwZT44
         V+Y+v86pWDDPez7W6Kvj3M7hNxut0mO/ch+SFkdr+OE90TiJoDMnhFSVNFDayGnZwE7N
         DQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJFgehUtlGjLgdMm6G1HCkUEGi4CG3oCm2IxZpbMlMRHtm3TzACnSNnQqqRU7poeQ/OKSo8LiWXbCQ@vger.kernel.org, AJvYcCW6G9u3rwxeSzVxhwtAP/dU9LfZ4AVOTyr1wheteR5+SF3jNJHHI9mx3jgDkS0ccjPrn8/F9QocVjuhtLUS1wGlJe0=@vger.kernel.org, AJvYcCWKC0KR2T5ozAakkR28Va8zlsKfHdxS9iApYK4oe4iwy+rJQKOYWP0DOJUYH6uP5Y07VNx48QL4hty8p32l@vger.kernel.org, AJvYcCXZbsturPkM1mozlIW6KWQ0rfHG0j0Y2DA+Zka9MV30+mMfyNmq1LkGOnD2GOwlPU1Vut8QtnEpggRQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyIFlcauO8Elef+V6uj/mQzzMjPYW3ReVubIpdji8RNGjdHDRnV
	47bPrTxuBxGekZOCKFb0/VYjVeGTOqu11iydkA11puVozq4D2qqhZXr2
X-Gm-Gg: ASbGnctu82y62rNazz5chpUE2sWAigj8Xc2UamzV8Pjow1zXXeGY9JoFTqAxUI8Q27p
	zTDxhH5GvqFXh+blzxZPnU7ffyavkwedoxvHKdsKDqhfG8FMF4F5niE7bk7fCX1ycRZKmM319O/
	XaN1P6qH1ZIWOERMZLTrp/WXcgODtDIgxM36l7qVkxgFRDt67cgYDhrbHcWS02Gtvk69+elRQks
	Zbit+DTBjYDBvUNxvS4rajENEQpZoJHZTJ9FZ90ryLzeMH41q8L6ay3otgzRwRXDkAID0bpt5ce
	jVOqGvhfdwWVZSJ/zQp6xX+ifOOgiwkuMRPnWAqH14aJ+bmj0GQklzD6exiAPICLKRGm4HtCzrk
	5ccLIPyIgXd4pWL7tU7vITm/qJW0dJV2RRIbxxtZKuWKy
X-Google-Smtp-Source: AGHT+IFFMGvFbpsHTpgyMTjNhjVZn0guX9tOqWVxwLzxKoFlR6LjQnKCPbPvhLmPFm3kqHCiJmT+Aw==
X-Received: by 2002:a05:6512:4028:b0:558:f939:4435 with SMTP id 2adb3069b0e04-55b558b8ed8mr4360723e87.13.1753684419849;
        Sun, 27 Jul 2025 23:33:39 -0700 (PDT)
Received: from [172.16.183.77] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b631a7e13sm1127133e87.76.2025.07.27.23.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 23:33:39 -0700 (PDT)
Message-ID: <272b1700-7ebd-4693-829f-8d842e6eece7@gmail.com>
Date: Mon, 28 Jul 2025 09:33:37 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: iio: Drop unused header includes in
 examples
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lucas Stankus <lucas.p.stankus@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, Dan Robertson <dan@dlrobertson.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Stefan Popa <stefan.popa@analog.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Stephan Gerhold <stephan@gerhold.net>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Alexandru Lazar <alazar@startmail.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>, David Heidelberg <david@ixit.cz>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2025 14:13, Krzysztof Kozlowski wrote:
> Drop includes of headers which example code does not use.  No functional
> impact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

FWIW:
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>


