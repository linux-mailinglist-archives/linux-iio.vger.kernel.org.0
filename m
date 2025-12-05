Return-Path: <linux-iio+bounces-26785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A074CA778D
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 12:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 874A130295C7
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 11:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF77F32F770;
	Fri,  5 Dec 2025 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6DPTGCS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BF32ED45
	for <linux-iio@vger.kernel.org>; Fri,  5 Dec 2025 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935613; cv=none; b=H5rvWvLEHu/0EPEayaxDD0F0ypMJf+yt5lzD/b6RSgO8S/Omcis7qOCTorPJUmPnt+xrrX0+3tF6zqs5a8y3+ttTGmZwmZUncbor+bwrGJ4CCJx/a9+Xw5oGpFFJ7dhb2RO8PKErROAbIch9oQ1VqLRtcdkohKbEysprGUjpDsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935613; c=relaxed/simple;
	bh=YJCejSSlp5BLiFi26SWpMkczGtydRQ5mSdIigPCD7qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S416EuTJYOBa4ZZ1+Q7KBJMjwMU7nkLx4+O9Y8uhq+YbAjnXvImqPRMuv6StJ38BS/2feXraOeCvfqSf+KiTTQDWChunXBLPBM5updwMam86xzlKjUHQ1yCekfiaMxpdodeIk2ZiCHCgoDKffAWqvKVJopIdu6cMgPEyeXHpbLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6DPTGCS; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so985823f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 03:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764935606; x=1765540406; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4oMXK/FjVegirY5SREBrXWKVrn6jX7f3cdMgqorSo9w=;
        b=Q6DPTGCS4Zi/CzaXKQrAHwKxVk0602h0hfMKHe/1NSlNq6gytywKufe/H/uXoSrIfh
         aZvKm84E94W6dBli9z2ZWSbBrH0sg/vKK0YVK2GwxIujtUjYRoJtZ+5p9gBmoVgAvEaT
         Nac5bZee27h+nuzQaRnhytc2sRDnKp4b/gCgA4pFatogtDtQDqaX9wDBXuSHczxc3wyx
         VoEStj3d2RehfqpLtMQdjXcPj+XhY0LQpJFOKLb6C6vbtaZaY+s3dVCcwkhpWJT8qixf
         Po3CgZt2VnYEHBLGpzmISzC38yZwxwYhXF03bN6fT3h0lZr4i8VuTdAIrqL8RnnT0cx8
         Iobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764935606; x=1765540406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4oMXK/FjVegirY5SREBrXWKVrn6jX7f3cdMgqorSo9w=;
        b=A96W+++YDygETm/9z4v7lZFz8Pn4apnzhE6+k5V1RPNOc2tsuKyYU0mDpKHvwI/1a6
         IO+92VHTI1wVwxVVNnh8M7qGCu/L+IeIxSow984i8KuckS9Rp3NA/QKhLX8pknUM2YFu
         HgxInSBm1vs6VT+qPJlDF3trqBCdNG3rqB4xfIB6M4DOxh2yuAGDHvhTIgpkT9IY4wgp
         fDoRuwnW2eDq6Q69e/eMVSfQH/WOGIya7alzGvuN3akuTMOgR/ly8YXzRmfC1irJhrt/
         tBcOZTKclItYGOVQJaimCPBn+KnuiASapd2mOlE8Zn3nAieBIxXXBhMHAU9iuINl0F2c
         xyGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3FurSnIqmRi9jHIR+l6HSBbDeyzC7ZPMu5iIJg80yCpZqXI6C9axpyGZ/QLYfJP1V/1Q+X86wxFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYp/vPKOjdoGoJbxPWDseGIRTUVA3g/+t5PuacUssZpb49BWTF
	dHZhQ2RlJvP6r1JV2wnkO/I78fyCiNpGtIa9lpRJxNfoWBoCHcmF5Y3M
X-Gm-Gg: ASbGncvGJgBLDIhpsEPso0fJiJbNmW4C99CnM2BJBIebvAu3cFi9gBlNP0W/Rjlpzjq
	/wuWtxbk9742R00TphBX2Nkp8Wb85R0b+BmoIszYDXRSk6JUs3DNFBWADa7PZne4NrHyffLUgI8
	wBvUgp6j+ZUDIUdFob1TEvO5WrJNyKVF+r9XgtQcTMzDC4xiV4N038Im5mUb68FxPi2qrrjoqoj
	DKPxSIJR3CyYv4G+lPEW/zwevpUB0mJpQdOjcQhB3QrumisOItgLYQ3bHoG1TZ6bO4n5u9hCJDD
	ZLKQb9YnAQNuLzf76226XBtLy+iY82BIKQuNDjxmpE+Gq7oLBn3Xe384vRTJDYlKQsWQS+chlPN
	J9SI/7A65ib3bhdQCZVJBFRG7oWRgrlVpwMsHCVdUWpP9jHteHmnhqlnX8/37ZHl3DTWIAkZ0FN
	tj90+4fz+IFdjvY55W2nwOQL+4nRHZ+EOjRHi+2KTXPrPYbUYl6J1RrYYAq4GOSMtDRMQ=
X-Google-Smtp-Source: AGHT+IHyVq1TxDr3VEMt1d+mdj1M0HSV8r65o6SHKi+8hiPBA1XHe+HyzivannicYdrPR2vI4N8sHQ==
X-Received: by 2002:adf:cf0f:0:b0:42f:84ed:ce5d with SMTP id ffacd0b85a97d-42f84ede0b9mr1636999f8f.28.1764935605767;
        Fri, 05 Dec 2025 03:53:25 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:123e:4501:9c51:c3b7:65d6:48d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfeadesm8509514f8f.10.2025.12.05.03.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 03:53:25 -0800 (PST)
Date: Fri, 5 Dec 2025 12:53:23 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 9/9] iio: adc: ad4062: Add GPIO Controller support
Message-ID: <egl65ctlz2umzcdzf7ke5c2hnd33ghudklmf4pdgnp64vnzjg3@rpqrludyv4p2>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-9-a375609afbb7@analog.com>
 <aSQ2JUN05vmMQC1I@smile.fi.intel.com>
 <rk4hmupbrb5ugxft6upj7ru43x3z7ybrobax45rorpwbcwleh6@vzxrr3m7r6ep>
 <aSgX9nMBwBtAlSyj@smile.fi.intel.com>
 <3izg5lyxjye24pvzoibk4tmnxbdfokr53abkpbjo5epqjoz55j@6wc7i4wsgwkt>
 <CAHp75VfLd46xt_2W35gjoTCoh+PqExL-faZ8snhzfOx=65qXWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfLd46xt_2W35gjoTCoh+PqExL-faZ8snhzfOx=65qXWw@mail.gmail.com>

On Fri, Dec 05, 2025 at 12:21:31AM +0200, Andy Shevchenko wrote:
> On Thu, Dec 4, 2025 at 11:38 PM Jorge Marques <gastmaier@gmail.com> wrote:
> > On Thu, Nov 27, 2025 at 11:20:54AM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 26, 2025 at 04:55:41PM +0100, Jorge Marques wrote:
> > > > On Mon, Nov 24, 2025 at 12:40:37PM +0200, Andy Shevchenko wrote:
> > > > > On Mon, Nov 24, 2025 at 10:18:08AM +0100, Jorge Marques wrote:
> 
> ...
> 
> > > > > > +       return reg_val == AD4062_GP_STATIC_HIGH ? 1 : 0;
> > > > >
> > > > >   return !!(reg_val == AD4062_GP_STATIC_HIGH);
> > > > >
> > > > > also will work.
> > > > >
> > > >     return reg_val == AD4062_GP_STATIC_HIGH;
> > >
> > > Hmm... This will include implicit bool->int. The !! guarantees values 0 or 1,
> > > but I don't remember about implicit bool->int case.
> 
> > I don't think the implicit bool->int is an issue, grepping `return .* == .*;`
> > matches a few methods that return int.
> 
> Yes, the Q here is the value of true _always_ be promoted to 1?
> 
Hi Andy,

The relational operator result has type int (c99 6.5.9 Equality
operators); and when any scalar value is converted to _Bool, the result
is 0 if the value compares equal to 0; otherwise, the result is 1 (c99
6.3.1.2).
https://www.dii.uchile.cl/~daespino/files/Iso_C_1999_definition.pdf

No conversion warnings even when forcing _Bool type.
There are many usages like this, for example:

drivers/iio/accel/adxl313_core.c @ int adxl313_is_act_inact_ac()
drivers/iio/light/opt4060.c @ int opt4060_read_event_config()
drivers/iio/light/tsl2772.c @ int tsl2772_device_id_verify()
lib/zstd/compress/zstd_fast.c @ int ZSTD_match4Found_branch()

I cannot find many legitimate usage of relational operator with the
double negation.
  git ls-files | xargs grep -s 'return !!' | grep '=='

> > Experimenting with the _Bool type (gcc 15, clang 19, any std version),
> >
> >         int main()
> >         {
> >             int a = 1;
> >             int b = 2;
> >
> >             return (_Bool)(a == b);
> >         }
> >
> > with
> > gcc -Wall -W -pedantic -std=c23 -c test.c
> > clang -Wall -Wextra -Wbool-conversion -std=c11 -O2 test.c
> >
> > also doesn't raise warnings.
> 
> Of course, because before even looking into warnings the entire code
> degrades to return 0. I.o.w., the test case is not correct. But don't
> hurry up to fix it, you won't get warnings anyway, it's all about C
> standard and not about (in)correctness of the code. See above.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
Best Regards,
Jorge

