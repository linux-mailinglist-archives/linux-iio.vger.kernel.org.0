Return-Path: <linux-iio+bounces-2345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B3984F9A1
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 17:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6702870AE
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FF453398;
	Fri,  9 Feb 2024 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+ppGx3h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6160B5221;
	Fri,  9 Feb 2024 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496293; cv=none; b=nvXR8fCSRGiEogkI4geQJtv7YgQdqZrktYkntfHmSyl6S1QPuXXb4BKFYkpi2pFp/fgg1PEbQtkZ/UWgfr0YmkAPkMrXEtX7SJGwHWnz0dBr5MwwO1oaX9sFE6WBbsztJfvVnGn3IsXm57sr+4SeK5BHWZKRvzby0kf2caLcqOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496293; c=relaxed/simple;
	bh=+Cn6hNsUr3XwwqA4lqgfLpCdRX7gH1FnrJIRGiACKqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obX9xJ1eiWy4j8v31V6hsQDYYYA+cBTR6lkUO9POm7nwMkSVuZ0KcZXGm4qRJTjtAuggVIJoIpJcSO/C79cRkxXC8ukLb6u9uOpJFfstJoET9yzLDURfCjKVbKd2bMR4B24tcnrSKeNmQFuk6vwr5Fx2IkwKTp2LTLqAgVl7lVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+ppGx3h; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a38a1a9e2c0so141567466b.3;
        Fri, 09 Feb 2024 08:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707496289; x=1708101089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhNi7XXUcHNqqlZG/SmRxe/hmWK8dnm/yjQ0RO9xrAw=;
        b=A+ppGx3hh0yX44LwStQCFysMD839b65sOBgK9+7VcDofgUNTUxWg2TCBFPoLZ+AP+1
         sc1oEquhlU0MfHtg+YYim0U4JBA3Cxyq1+G+NQ9GGPwGofmcrRmHTL2vNXfH7W55AtgA
         ZhXVd9Sj/4dCMcgFEK3gigFYox1O68XEF1+/zInIKpBHvVdsv9kT7jYcGPeUakvY6pEB
         71CmYoKyDaqRwHBTtYAgd67B/4zPs3kmYmjSxDjx+Z7+Z3sm+IUw+5Kt0/y2l2fdnHHi
         PinGcKCfNC2lleKe1dM9CeteivTZ9+oHBqirTDPrDhiDCUngAunnO4FXbzBv4abqc0So
         Q7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496289; x=1708101089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhNi7XXUcHNqqlZG/SmRxe/hmWK8dnm/yjQ0RO9xrAw=;
        b=LcpdGg+mSkCh/rOxC/ZmdJihfuOt+YC2LOXP9FW2V4G06hRcDq4WLjSZtLALOvXKy+
         lUuHGiU5DXIlEuIP7gMj3HcTB6UosvDLt1LyBNilltGXMIxTRt8UQTiuRV8NfzKPyqKi
         ZGZeWiOhh/9LLY0TE12Tu+5xYEJUu1Pm1+WVaAYm5QWy0zw3xbfrMw1gQtJpxUUOuySR
         Kh+B6hjSWrl3fh2DtgCq+T8nuNgk+uKYAgUeaphiFMyWhIMJqDMSxTJRjcxg74MBnm5S
         wEIxnZzS4XeRl7Z5mcOumMNEoqxZuqi0x8RYYONxPEGKt4YweNEFpASD6nzGmxnSPfRL
         PZcg==
X-Forwarded-Encrypted: i=1; AJvYcCVu7L2xH37eeAq7qyQwlgf4NffD+UL0UHiOEfEB+o1C6kJ6Ap+X9d5xCjbEn5XRAAhTnYAQ1vtl0fOHJOVQhWxMAQc1Mbkjw/gm0A==
X-Gm-Message-State: AOJu0YzutcAbkAf/VckEVkE9+4kNggRn+BTSn5msJESo3qSPZ7p/HTqF
	jEQv/cqK/VM9lUv4HiUmMbxckllH0+cZxqfxWuCj8xGidnTm9D104zNg+RElT8CwyOYBbAhHKz2
	geTv8Ds13eqG4P3iAlnoe79XQxZo=
X-Google-Smtp-Source: AGHT+IE9LZD0SC8N+bdtx7aKQ/oM5dgQj6DoNrLkVCLQpghb17s1YMlwAt7DV66ViD0jHkt9edcom0Nz/uofSaMlyJ0=
X-Received: by 2002:a17:906:33d1:b0:a39:34ff:d6ad with SMTP id
 w17-20020a17090633d100b00a3934ffd6admr1771509eja.7.1707496289390; Fri, 09 Feb
 2024 08:31:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-iio-backend-v10-0-3ed842064318@analog.com> <20240209-iio-backend-v10-5-3ed842064318@analog.com>
In-Reply-To: <20240209-iio-backend-v10-5-3ed842064318@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Feb 2024 18:30:53 +0200
Message-ID: <CAHp75VeqUnV33YF1WT9B0h=V_DpJBjwaH3g6AHiQQ-yDZBOyfg@mail.gmail.com>
Subject: Re: [PATCH v10 5/7] iio: add the IIO backend framework
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 5:26=E2=80=AFPM Nuno Sa <nuno.sa@analog.com> wrote:

...

> +struct iio_backend *devm_iio_backend_get(struct device *dev, const char =
*name)
> +{
> +       struct fwnode_handle *fwnode;
> +       struct iio_backend *back;
> +       unsigned int index;
> +       int ret;
> +
> +       if (name) {
> +               ret =3D device_property_match_string(dev, "io-backend-nam=
es",
> +                                                  name);
> +               if (ret < 0)
> +                       return ERR_PTR(ret);
> +               index =3D ret;
> +       } else {
> +               index =3D 0;
> +       }
> +
> +       fwnode =3D fwnode_find_reference(dev_fwnode(dev), "io-backends", =
index);
> +       if (IS_ERR(fwnode)) {
> +               dev_err_probe(dev, PTR_ERR(fwnode),
> +                             "Cannot get Firmware reference\n");
> +               return ERR_CAST(fwnode);
> +       }
> +
> +       guard(mutex)(&iio_back_lock);
> +       list_for_each_entry(back, &iio_back_list, entry) {
> +               if (!device_match_fwnode(back->dev, fwnode))
> +                       continue;

> +               fwnode_handle_put(fwnode);
> +               ret =3D __devm_iio_backend_get(dev, back);

This order makes me think about the reference counting. So, fwnode is
the one of the backend devices to which the property points to.
Another piece is the local (to this framework) list that keeps backend
devices. So, fwnode reference can be  dropped earlier, while the usual
pattern to interleave gets and puts in a chain. Dunno if above needs a
comment, reordering or nothing.

> +               if (ret)
> +                       return ERR_PTR(ret);
> +
> +               return back;
> +       }
> +
> +       fwnode_handle_put(fwnode);
> +       return ERR_PTR(-EPROBE_DEFER);

While thinking about the above, I noticed the room to refactor.

  list_for_each_entry(...) {
    if (...)
      break;
  }
  fwnode_handle_put(...);
  // Yes, we may use the below macro as the (global) pointers are
protected by a mutex.
  if (list_entry_is_head(...))
    return ERR_PTR(...);

  ret =3D __devm_iio_backend_get(...);
  ...

> +}

--=20
With Best Regards,
Andy Shevchenko

