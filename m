Return-Path: <linux-iio+bounces-17596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7526CA7A4DA
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 16:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CFE3BB02B
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 14:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1920B250C15;
	Thu,  3 Apr 2025 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSPNUcdG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85671250C1A;
	Thu,  3 Apr 2025 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689379; cv=none; b=XMNA3dWgIV9MhPPCRAQ3d8c6HzGAfulGdVPoO/KD4TdBkP11pAHedNxqeYUETOzR9jkkFpmclifpcoGHS2hza8x+YLXSS/w4Gpsc8rV9v9HTZTs4mRTyCLCIz5FuulAvujvLy+X+lNdIhxJAi+TUPBvLHN6U0LzJK0aBNqzEd7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689379; c=relaxed/simple;
	bh=DZL+IcQ5DVyD5+vgddwK1LITbtPnt58fksxz6Q/slnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Asg66ESbS57UISTpqMimB8+U1rLxWrTQaC9Tqo5eLMTT66E8AvCcff9K94gEM+xxK4ohoQavQR0IBS8iaDkJU/3At+MBtg4bmVG45DRD6FiwqHk3jWfzpZvceK+p8AJJQQNV+L8xs1yZD6DD7HxKUeXdYofUCkGEseLKG67aYrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSPNUcdG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso886237a91.1;
        Thu, 03 Apr 2025 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743689378; x=1744294178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgLIPOgjO+4Gtz9uWMW47y6AgutNbQcH7sc+seuGtK4=;
        b=JSPNUcdGx/yM1+qJHK/ikP0T+C2iI2nw/DQ88CXrt9YNm0UnjqAFL8sWIOKmH1KLIX
         /b0cHP0A3G1uwEK53hjCbMfoy+y93Th88m/wbA6h1c2IuzhuuY/xg6ozSTW7uL2K6eQU
         U04oJaU67ybzrQlt901AL4kwGX5nLNE+a41Jlcj74Yl2OQzct7FvWJr7K+DaZRkoFPww
         jrXvLZnpE/8VHxUNRD2XdGf8JVlhKGCXvZpfypNR+Pv3Conumk12EXmAUa0s2Zu41Yn5
         9GEZaF/ouI7Ue+m89SJ2NYtlfoCHYZPZIU2K0bXYCF0Owi4Si78rrxjOJz1iSaLOLfDY
         lGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743689378; x=1744294178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgLIPOgjO+4Gtz9uWMW47y6AgutNbQcH7sc+seuGtK4=;
        b=ZY8GJIc6epWrErDdS003EBW2UR/cIyCKWEsgSkP40jRfqVdZSR8aRQ1lZOW8x0FJNg
         X6PEgZRRWNZWeWdVP1vkzn/cX1xHROhF16rzsbWY5aP8v7N4LMV1MicCE3ERPqyN7Bys
         ue3bSc7aKZsg1iT9OnY2LgOEradCjhWfTWnAxzlyRU7CdplJMKbRVuTLq/pwzXFVvHjP
         U92D/if85gkv8Tkz0l+71PkronaFRSnn0gkMFNqHFW8YKsG6J4T1Yd/qAkiparG2JX0Y
         nVqPqkqnDB/4j0WNKECxqJUvzV/XBjxmIFOLG3x9ATU7MWKHbsWMyk8wvdgG3yVkfARz
         rZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0xEEHZ1+5CcBdhFh2WHHbzJTkMMLO94usM+M6obgaDbjnKTpwD5gjDyjt3CYbwSdiLf2fafDs6QlM@vger.kernel.org, AJvYcCVOTIJMP9ALdK/uONqBGmh7glvpqIUnMzbI9XZpbD0Ux7FZ9uRp7QlMfvfx2CJMIw7M+LsUlt8PfTY3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4rPXHRaKB3pnR3/qJUR+8FYwSqgNGDfHIdoh5D28O25Risdn4
	N7cTd44yrYOMavgluP13Gilb2jNkUxOIaOxny6S9SFKRPxXwT5OrPpPX1J1/Qeb3IQNc1ZW4XTp
	ZTonZtLX6jhnjhbh+aqEzyQj9DYiE0gzX5tU=
X-Gm-Gg: ASbGncuFP61lB9BZlZL1syj3wkVQ44TEWlWtkOVl8BXUkSpyI2pobGZsmW8HG4fm9Bn
	HTLmJi8Ox+nxO4Dc2K7BkBrfJhw7yJU0qac81OAc0mVvB2OV6alqS5+00Kcc4gjrWYG2ZXjU5fP
	k8fAbVFf5rrmREM/fPFc1G5p83lzw=
X-Google-Smtp-Source: AGHT+IFoZpcMywnaS2mRwYVI8L/R3NuCjWvp8MO3Z21H4tZRH0PC83Ij5D25TsgorSXh32lXrVl+/bawT5D6hsIZ2is=
X-Received: by 2002:a17:90b:1f91:b0:2ff:693a:7590 with SMTP id
 98e67ed59e1d1-305321705f1mr35076708a91.33.1743689377600; Thu, 03 Apr 2025
 07:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403053225.298308-1-gye976@gmail.com> <20250403053225.298308-4-gye976@gmail.com>
 <e8167849-57e7-44cf-bf35-5313e54908d5@kernel.org>
In-Reply-To: <e8167849-57e7-44cf-bf35-5313e54908d5@kernel.org>
From: gyeyoung <gye976@gmail.com>
Date: Thu, 3 Apr 2025 23:09:26 +0900
X-Gm-Features: AQ5f1Jrg13cpPMNX-6s5f6-NeloDH6EGHq33MiXITjzaIAC7XTyjXvKlI2q6BEI
Message-ID: <CAKbEzntcF9XHg4hitV1WnOcZe2=yVk+W5wghvY1VeHjZeZqymQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] ABI: iio: add new ABI doc for mhz19b
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	lars@metafoo.de, gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 4:51=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 03/04/2025 07:32, Gyeyoung Baek wrote:
> > Add support for winsen MHZ19B CO2 sensor.
> >
> > Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-mh=
z19b
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b b/=
Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
> > new file mode 100644
> > index 000000000000..6cdfd34be016
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
> > @@ -0,0 +1,7 @@
> > +What:                /sys/bus/iio/devices/co2_range
>
> Incomplete path
>
> > +Date:                April 2025
>
> Not possible. This will be probably June.
>
> > +KernelVersion:       6.14
>
> No way you can put ABI into version already released. It's impossible.
> That's v6.16.

sorry, I'll read the kernel doc more carefully.

Thanks,
Gyeyoung

