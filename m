Return-Path: <linux-iio+bounces-16203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FB7A49FDB
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 18:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EBE3A87B6
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D21276038;
	Fri, 28 Feb 2025 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1Bc1gJj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996512755FE;
	Fri, 28 Feb 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762458; cv=none; b=DnkBdbPQOONF8aOD4UGu09/30hMsjc/6WzADSZJpMo03mtNwfeOmCKyXLX5UPNSOdfNzb5vVtXfqVxJX+8r0A9ocBFCBnc3lAb34b9HDVqDw1iwjGbFB9FUG2i154C6tbKQf24PID6a5LXewz2G8A9o9QbLffDenFgqqSXFhZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762458; c=relaxed/simple;
	bh=uz7YWAd8O0uBi8Im2yha/KDIrRaCObz+LjL/VNUp47k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGNzEvZ0XriCLUh7s+igj7Eq0eEtcToYdsHeViI21PZG0qR6xNvf2G+lqXPuMJ0705iBIGmbl9EusYBhybbSyixUw3oR3DXSeq54YUKD4xVRMA+jTYpC4ZeKskqaTDFXRnevI6Z8qAY9lYPC6HOLt4BQRLMbzRKMUWYvTeGjKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1Bc1gJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EDEC4CEE2;
	Fri, 28 Feb 2025 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740762458;
	bh=uz7YWAd8O0uBi8Im2yha/KDIrRaCObz+LjL/VNUp47k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V1Bc1gJjVvY8uePckrHl2AFcrmUlPiqmSt+OKYDZaaYAJRwiCi7f0yG9+fWABXU+G
	 5mDN83OtUY092ZtJNVZ7g5fiq40tlGcK6KT5FUYAlbUikn9TLl7XAZy7tpFucqLjpR
	 xHQJr6rEUrjVcvVH2MeWvnY9qymeF6QoGzQkMVrWWw0LQho2OfjP5wydZF69WBOXIY
	 Y1P79tmbbAWlev1lftPgkAbmrCpT5K4GQoq7zcrnMQO6Vt/mKR5+kBSVH1Qu2n7CDU
	 2n70Q8nmFGdOThFtacF8TESbv4hy5Lm0kP8rRqr3sCrUxZ1XVp3BORJEyhg9ZHC/9B
	 Ew3pJIqBi0btQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso3673353a12.3;
        Fri, 28 Feb 2025 09:07:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4z+oQOwoz7KcyFzKXDMPCUKkClptUU4OuZBlHGkV4zkAwNe/zhrXzwTyS9zXMir+wtRm9JH5byYcZ@vger.kernel.org, AJvYcCU8L6MpuP7+vYtwGIk2chjas5zAWjodIw7LEVawutWmaz6ZLwt4TcfCMQXye2E8rxCRSkb5uitnnwR5KUktGvdViyg=@vger.kernel.org, AJvYcCWW7e+ix+tPXZ+r9jdH+JlzoQZAbIYLpF43ZfAV9Z5uKG9OQvfySnE4nXjuykCtgINQoghfbDMa2mKqxw==@vger.kernel.org, AJvYcCX+iOIcy3t5WgbqElNC2DOfTu0CIDI1brJ/wWdwZXBuysQpNJvHMC0K34LYpF8SQfvWwxJDHHaqmVuW@vger.kernel.org, AJvYcCXAuFNx6SEryydDx9BpN6o1p/wPJf6ldWtiDJsVID3lMyNJpAE+O7upnKFJb4QXlfsSbjqje+dzqyBcxFw3@vger.kernel.org
X-Gm-Message-State: AOJu0YxqohbsEWkh02xd4yj6yk+wGhITAhdVki5cpSdI7PMBZ9SI2vqr
	4h6x70re5WzOWFQece+b2749ZKYmISgLRYHnENgC9DaKtLMTpb7z8FdfFn6pZGUSpA9M7lPLRee
	rDoCn7eQldU+4IQmNY36rgujiJw==
X-Google-Smtp-Source: AGHT+IEHPy1qvm3dSI803ZGj26xFQwAtPW1n1+HYVcZOF+85YFAZAlcsJm1lq/IdmNqWRFeTlLzx0+mxXPel52yDr9A=
X-Received: by 2002:a05:6402:40c7:b0:5e4:c532:d69d with SMTP id
 4fb4d7f45d1cf-5e4d6926964mr3829294a12.0.1740762456471; Fri, 28 Feb 2025
 09:07:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740421248.git.mazziesaccount@gmail.com> <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
In-Reply-To: <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 28 Feb 2025 11:07:24 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+av-fptMQqBeVieKwA9c7+uUCaqZMLGu-RVJzWZ_7+Vg@mail.gmail.com>
X-Gm-Features: AQ5f1Jq19gEh952WMm9N8aBYMg7AK4rciiMO8rsTCtZsR8RobHuwRIGj0QbQL8Y
Message-ID: <CAL_Jsq+av-fptMQqBeVieKwA9c7+uUCaqZMLGu-RVJzWZ_7+Vg@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] property: Add device_get_child_node_count_named()
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Guillaume Stols <gstols@baylibre.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Matteo Martelli <matteomartelli3@gmail.com>, 
	Alisa-Dariana Roman <alisadariana@gmail.com>, 
	Ramona Alexandra Nechita <ramona.nechita@analog.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 12:33=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> There are some use-cases where child nodes with a specific name need to
> be parsed. In a few cases the data from the found nodes is added to an
> array which is allocated based on the number of found nodes. One example
> of such use is the IIO subsystem's ADC channel nodes, where the relevant
> nodes are named as channel[@N].
>
> Add a helper for counting device's sub-nodes with certain name instead
> of open-coding this in every user.
>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Revision history:
> v3 =3D> v4:
>  - New patch as suggested by Jonathan, see discussion in:
> https://lore.kernel.org/lkml/20250223161338.5c896280@jic23-huawei/
> ---
>  drivers/base/property.c  | 28 ++++++++++++++++++++++++++++
>  include/linux/property.h |  2 ++
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index c1392743df9c..3f85818183cd 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -945,6 +945,34 @@ unsigned int device_get_child_node_count(const struc=
t device *dev)
>  }
>  EXPORT_SYMBOL_GPL(device_get_child_node_count);
>
> +/**
> + * device_get_child_node_count_named - number of child nodes with given =
name
> + *
> + * Scan device's child nodes and find all the nodes with a specific name=
 and
> + * return the number of found nodes. Potential '@number' -ending for sca=
nned
> + * names is ignored. Eg,
> + * device_get_child_node_count(dev, "channel");
> + * would match all the nodes:
> + * channel { }, channel@0 {}, channel@0xabba {}...
> + *
> + * @dev: Device to count the child nodes for
> + *
> + * Return: the number of child nodes with a matching name for a given de=
vice.
> + */
> +unsigned int device_get_child_node_count_named(const struct device *dev,
> +                                              const char *name)

I think this should be implemented as
fwnode_get_child_node_count_named() with the device variant being just
a wrapper.

Rob

