Return-Path: <linux-iio+bounces-27324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFCBCD760B
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 23:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95595301F8E9
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 22:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5254830C637;
	Mon, 22 Dec 2025 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX2Ly3f/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488623D7CA
	for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766443857; cv=none; b=Jqya7+ZviaALh/mt/2h+Wk9shzbiLMToMjdTdxeNyr4JvPI7+FNkGvEnsE77Ryrsm7paEjxmh0Ob1BRSAwwuhZUX4zqQ2/+2m0VfVvgvkwxkVduq9dyVtCgXglBDnJv361DpHzjflHgxHzVOv24a/hiKEwyiEySQVCPvoqoYaRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766443857; c=relaxed/simple;
	bh=RzSww950eW72X9C0Oyyu85GpbJERYyT2MUe8Y88fdaA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=XInNMuT8Dlwm9rys0gntyTAS8cDrZDAQ3J0oYf5HRXJZLliscIThLK4ESfK8w/e6Cz/O0+Ll7rlDUqTvgK3UsEp3ZHzPXZKWMxaKwdp+aGuhFdwu80/6fcZ+I0iNPyzAalQdPi3wk+D6yyOGrZnMm4BNOHWFS2o0B94ODvpd8CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX2Ly3f/; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-93f5667f944so2649779241.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 14:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766443854; x=1767048654; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzSww950eW72X9C0Oyyu85GpbJERYyT2MUe8Y88fdaA=;
        b=YX2Ly3f/vwNWzRp/hHO6oIyr6kHu0NSNW+roXmXWxzmfjmeTVv5ebBcyamA+zOQFmq
         6fG7wFrxzRnnpEOn2f2XlLn1Z3Et2kfgy9GOeSgvA8TLMswowPBLy8nNlBRXAP6yHsbu
         pqnsmT6Tyb/ZUqt4N0XxJMQ8gaaisP3cZBQGmRfhQ5x2quTT+yxJ16+Xq0hAf1uSfKXm
         2wRdbStfXSHi0u/FwiDYWEMyyj6DmXjSsP/1JT00OvEOPJ9us4pfhBtHsYcRJBGl5j+D
         jgxFMqc7OVYpKj0yslRfclADF6/mwl+VWjuZwA917M9q5EBRXwZkczUg79n7i2mY3Jbc
         JU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766443854; x=1767048654;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RzSww950eW72X9C0Oyyu85GpbJERYyT2MUe8Y88fdaA=;
        b=VP7mPpPip5GWJ+WByutgySPo2Va/bLTHL2jzD0NANlLm8SvdSJX4LKw5gUhfkihaUQ
         /7oQqENIf8cx2kuOX2h8KCDynCg0quaMDem/1eTEIyOveRPMCPckYid1f8p8msO8kzh0
         9AaTbo8e+cvZd1445ldNrgIfYbR7ChjazmD3LO6riVGCvLa8eT88kkMz7rHfuxXvLXJH
         d+8Jw0bIlgQ8Bn4I1zmSkLLjkfNcdVloyCev/UEfVy8h8iFFD1nMzNylPq3+dzt1hnoL
         TUx7TO0X3WuGHf6GSyKJAqulkGXsqwR5+mr7UpuPxr9umoMGGnD/I3p1NV/SOo9sjQAH
         iFCw==
X-Forwarded-Encrypted: i=1; AJvYcCXykM0TM/LOMI1qh3AKZfE06gD58yIRI9upGERJBjBJfwj7BZKEAZVXBxR+u5dXKoudtSXk18T7CjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDHY8+vxijIEPtNB4+p5wnONZbY6W9hUO3h+z5M5E7+EZeRkx1
	7WBQuz/aiJuH3hbJfSGkmawe0Iahdl5qECBZTp9ExK9+YnP6JNkePsxZ
X-Gm-Gg: AY/fxX4vc3uho+jx0Aqj+hhbayyqjt7PgvJx+TPPdTlC98sb7IMCt3Hkj3QaBgTJsEY
	rmQt533kHld8ZR2W1M2L+qcLAuQjzjayaAvBfS+age57WQbtOZnc+JBUCGSRvsfUljH+Oct5o0O
	y1gToCdGWa3JCgv5gibKmymGdHmyxSTyzjzjO9UXeP4RI0KLNAp789tVtytHngU/Npw9NvhLp5H
	rxVQhw8xDBTA2ZqbS+Q4A5bxQhT+EzjOAh5vlCPjMXEafCX04k1WaLhh7v7+PifEYmmgwkW0s/j
	Wz/bl4NCI9ar2W+W4OwBxjK/RTd5+MV/STDvPhvaeENfq+LsCbUvLAW+JlzxyhZg7jlhV0/AEpN
	jCkQdCqqqxVKtmkSCJGPCATGY4KqVcpE43/IflLqKg4mJs95AFTy4p4r4B67KA7IWZmjsRGKEiA
	r3Fnpn
X-Google-Smtp-Source: AGHT+IEtjqJ+IJYK0MT8jOtY0wj46KAN8QvGo3BiDSKvbuLac1bW+PMocHFXvhd7kIBYsOPMGQjRIA==
X-Received: by 2002:a05:6102:c52:b0:5db:e0fe:985c with SMTP id ada2fe7eead31-5eb1a67f585mr3880573137.10.1766443854448;
        Mon, 22 Dec 2025 14:50:54 -0800 (PST)
Received: from localhost ([2800:bf0:61:1127:ab87:5602:531c:8dfb])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-943415169cdsm3412875241.0.2025.12.22.14.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 14:50:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Dec 2025 17:50:43 -0500
Message-Id: <DF542YRSDA0T.1HEBLMS3VBS0V@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Kurt Borja"
 <kuurtb@gmail.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v2 1/7] iio: core: Add and export __iio_dev_mode_lock()
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
 <20251211-lock-impr-v2-1-6fb47bdaaf24@gmail.com>
 <aTxdOiDFqyT8oA3t@smile.fi.intel.com>
In-Reply-To: <aTxdOiDFqyT8oA3t@smile.fi.intel.com>

On Fri Dec 12, 2025 at 1:21 PM -05, Andy Shevchenko wrote:
> On Thu, Dec 11, 2025 at 09:45:19PM -0500, Kurt Borja wrote:
>> Add infallible wrappers around the internal IIO mode lock.
>>=20
>> As mentioned in the documentation, this is not meant to be used by
>> drivers, instead this will aid in the eventual addition of cleanup
>> classes around conditional locks.
>
> ...
>
>> +EXPORT_SYMBOL_GPL(__iio_dev_mode_lock);
>
>> +EXPORT_SYMBOL_GPL(__iio_dev_mode_unlock);
>
> Put them to "IIO_CORE" namespace.

I will!

Thanks for your comments. If this gets no more comments for a couple of
days I'll send v3 including the rest of your suggestions.

--=20
 ~ Kurt

