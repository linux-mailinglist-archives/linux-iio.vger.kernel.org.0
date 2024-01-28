Return-Path: <linux-iio+bounces-1998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 284E083FA01
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 22:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4AAB2175D
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 21:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0937B3BB5F;
	Sun, 28 Jan 2024 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rW3MjNl0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254573C689
	for <linux-iio@vger.kernel.org>; Sun, 28 Jan 2024 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706476277; cv=none; b=k+f/Dld11fHQfEOS1KJPF7U5wzChFtC7/RtRmpKUYMgf+SHiaQU4YbRJ7NcJJJsJZF2sNsMBpkEiiFaoeRW00aeYOhdLm0mJ75PhFP5Z7CK7qs0gOEikLp5f/jxhHEdHV1f776Jb0AU9s6oN+7a2i21auF23PQ8kKPycysTm5PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706476277; c=relaxed/simple;
	bh=s9i81gNuIuQa+DtBxXx7xqCUjIn23uFBzT9SThjsPGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPWIScmyYNYUM0/qBEOv4Sv/EZSGlupCThB8YEy1KolvsfeI9oo7d/4590LxgE9JtuGS+WxB6x2Wa2XwEX2XCIOe2wIJudZvQQLc3/3Ssc8A1Tv4RKhAdiGzQxB/FLTo8FGKaKMCmoccMv+Ip6zwZBBeMZLgpd5T665tbPreXuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rW3MjNl0; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf3a04ea1cso26454561fa.2
        for <linux-iio@vger.kernel.org>; Sun, 28 Jan 2024 13:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706476273; x=1707081073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peVh1mIiiiPwBDheeU6AKxoE9AuWZtwYKN/fPYN/I84=;
        b=rW3MjNl0Wwy0ig7MCXKXjjL7MwZiCLcDLFewXBQRdjo/w2fpNPlwURiHBoon1TGaSU
         L65ZSGnuEQBdBNQBfAah/EeFb0wnVHG+PDBXVHsOLk3xhDbeid2IGJlwIlMgXQdNEVLe
         ETzZBdVTPUxMW/nVVGBETrkJV1oda4slxhkkE/UBxW/LHVhocA68RJ7Hr3BiA9km+uDK
         LnJ1BTNYuG+4pv/7NaeHc+JhcdtO77hSxU7q0x3aG0bC7mS7G6+aVIJ4h1koCUigNcwV
         PIgGSxY7Lrqwl6+Rv+AgiU2U29Opemv6oAPQ1VEx66xn9UvD1WHkwSjzWDo0yvFJnYDa
         Lljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706476273; x=1707081073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peVh1mIiiiPwBDheeU6AKxoE9AuWZtwYKN/fPYN/I84=;
        b=jRPPYyOqXqZkZ6hfz93V8rwsJ5MxGZgmw0et9Rq5/q56YJT7GZ2bdDypp4Q7yszmyg
         sJNgyB6SagArD0aXYbM87z/kt5J+qQmpgw5fOlMeU+l5asVsxgaOi4RFWX+zhPKTz2FS
         gx+W0s7aT9Y7CsrVpuBX2kJ5ZzAWkxoKxEcsUVWnVMkE+rXDmqVo/4jAM6QkLAgWR3tm
         SSFfa5B33oVfaO8FoeKOr51Z7+EDCmdsOur0oi1BdZF4g+T8jCyPhvU12OTtzYE6IO4O
         6TOHg+i6QM3NrHnH8HRkVrnZ0u6T5pTP5yL+QVh76L72U6r4sdvkj9bAeZk2JOL+P96A
         lpEw==
X-Gm-Message-State: AOJu0Yxkly4tfaLfJW0+IIaYGE+VkMcKHFnm6GDAGGqLL6MJxnSPzgXp
	UJJ/hByNySHmsUiKT3PafB8VFnbrldv7CAylvN4q61ZBIIOEIUO/sVvpied79Yje+KuDx0UvuYS
	45N256LtnvRyuC5KkZjfSals9AbLnFD65WlGWuw==
X-Google-Smtp-Source: AGHT+IHIL30fwTfhVmLPDMbUlLjqFquvTBy4PT3bXPMF1NzbRVB5b0xREHv4i2/gEHQ1ifeP3yKYSTr4iSLmU6EmoDM=
X-Received: by 2002:a2e:b282:0:b0:2cd:7830:5796 with SMTP id
 2-20020a2eb282000000b002cd78305796mr2470463ljx.5.1706476273004; Sun, 28 Jan
 2024 13:11:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128160542.178315-1-jic23@kernel.org> <20240128160542.178315-3-jic23@kernel.org>
In-Reply-To: <20240128160542.178315-3-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 28 Jan 2024 15:11:01 -0600
Message-ID: <CAMknhBEL3cv4L0A-W=_1EcDmD3Cj8apheDcpnqjyJjKBZuPYew@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] of: Introduce for_each_child_of_node_scoped() to
 automate of_node_put() handling
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Sumera Priyadarsini <sylphrenadin@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 10:06=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> To avoid issues with out of order cleanup, or ambiguity about when the
> auto freed data is first instantiated, do it within the for loop definiti=
on.
>
> The disadvantage is that the struct device_node *child variable creation
> is not immediately obvious where this is used.
> However, in many cases, if there is another definition of
> struct device_node *child; the compiler / static analysers will notify us
> that it is unused, or uninitialized.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/linux/of.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 50e882ee91da..f822226eac6d 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1434,6 +1434,12 @@ static inline int of_property_read_s32(const struc=
t device_node *np,
>         for (child =3D of_get_next_available_child(parent, NULL); child !=
=3D NULL; \
>              child =3D of_get_next_available_child(parent, child))
>
> +#define for_each_child_of_node_scoped(parent, child) \
> +       for (struct device_node *child __free(device_node) =3D           =
 \
> +            of_get_next_child(parent, NULL);                           \
> +            child !=3D NULL;                                            =
 \
> +            child =3D of_get_next_available_child(parent, child))

Doesn't this need to match the initializer (of_get_next_child)?
Otherwise it seems like the first node could be a disabled node but no
other disabled nodes would be included in the iteration.

It seems like we would want two macros, one for each variation,
analogous to for_each_child_of_node() and
for_each_available_child_of_node().


> +
>  #define for_each_of_cpu_node(cpu) \
>         for (cpu =3D of_get_next_cpu_node(NULL); cpu !=3D NULL; \
>              cpu =3D of_get_next_cpu_node(cpu))
> --
> 2.43.0
>
>

