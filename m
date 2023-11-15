Return-Path: <linux-iio+bounces-78-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D9C7EC4B2
	for <lists+linux-iio@lfdr.de>; Wed, 15 Nov 2023 15:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF3E1F27340
	for <lists+linux-iio@lfdr.de>; Wed, 15 Nov 2023 14:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1E7286B5;
	Wed, 15 Nov 2023 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8IVTWIe"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE7C210FF;
	Wed, 15 Nov 2023 14:08:59 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37888C5;
	Wed, 15 Nov 2023 06:08:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so10552562a12.0;
        Wed, 15 Nov 2023 06:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700057336; x=1700662136; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KHUQzg0dp0be+P6JgeHvZyPAQ+M1sBpTzeKwEMmPMok=;
        b=T8IVTWIe5Wa/pJBZWnO6vOfFv3eCRK2CansSmWycr7lXHQdrezx+jc8YpxRjT+MPT8
         OvyuCX81sliQChLMp8XI2cqGqWz2NmzD/WqTjjhvpHAJUv60WNz+ySHeRme1dbi6RK4Y
         n7RkDNHAiQLWRZ2o//hxBXhYkEkRmXrcL7XD/Cpo8n+6bIvSN1zBzujhBqrquusifvwc
         rOjuZ3AFV0m5GiAuIYQh+TloU90RQjIuvkjOU8efQTz9gSWZrVKbnoeBup1upCumn+W5
         lbSRj8qEnfMjVheBUrohuB46+/vTJDGviN0ps9CRtoSRmPCaJebFXm/Ds7EG4XqIM+EZ
         QumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700057336; x=1700662136;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KHUQzg0dp0be+P6JgeHvZyPAQ+M1sBpTzeKwEMmPMok=;
        b=fITD/q2D3zNrOUQhyh3Y+GlUOC2uW/yF4HFoOsouQZv9LlEdbd67rPKBqx5YhyFA/c
         VRD9h4psxbAwinZr4GDIeHF8NVxMZ11G7Nm0hYjnq/66HKFDiS5vTebKfRufRoM9mB80
         7r4zPz8ux3/1yzwyE+7soYBbWoExmLwo02hSmeZN1DhVzfOunus01JxJZLOcXsY2DCHl
         XzXi9KxAGQuGES9OjiQJbsUKs8UHhDQMWfhpSDBO/TZMOEc13KFMDZp56OCwmR9F5gOX
         6hYSJSHxelatXM7onADD0RQIoW7u9dP3yS01Tkl6hDorjHXmFEz95d70i+CzDr0AflI8
         hdYg==
X-Gm-Message-State: AOJu0YzfYHlgWV0zfZBtvhriCMjyu2kZ0bTNHzrW9/nz0TltF+VdQoEG
	5EuuTVPtAVwD7Wv6Lt3yiCM=
X-Google-Smtp-Source: AGHT+IGrzZIkAYi2JF8i1WqGL4h4riwxs4YUQytddEiJgFf1ACyRDrAN2JLfxFnXVwnKQfQtqrnHEg==
X-Received: by 2002:a05:6402:518e:b0:543:5c2f:e0e6 with SMTP id q14-20020a056402518e00b005435c2fe0e6mr9798917edd.17.1700057336314;
        Wed, 15 Nov 2023 06:08:56 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id k21-20020aa7c395000000b0053f10da1105sm6538409edq.87.2023.11.15.06.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:08:56 -0800 (PST)
Message-ID: <2085e9ebc38433defea1ca270c59b2b0d72806dd.camel@gmail.com>
Subject: Re: [PATCH v2 2/4] iio: adc: ad7192: Use device api
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Alisa-Dariana Roman <alisadariana@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Alisa-Dariana Roman <alisa.roman@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,  Alexandru Tachici
 <alexandru.tachici@analog.com>, Jonathan Cameron <jic23@kernel.org>
Date: Wed, 15 Nov 2023 15:08:55 +0100
In-Reply-To: <20231114200533.137995-3-alisa.roman@analog.com>
References: <20231114200533.137995-1-alisa.roman@analog.com>
	 <20231114200533.137995-3-alisa.roman@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-14 at 22:05 +0200, Alisa-Dariana Roman wrote:
> Replace of.h and corresponding functions with preferred device specific
> functions.
>=20
> Also replace of_device_get_match_data() with
> spi_get_device_match_data().
>=20
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>=20

Reviewed-by: Nuno Sa <nuno.sa@analog.com>


