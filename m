Return-Path: <linux-iio+bounces-7744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C479381BB
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 16:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63532281C50
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D498C139CFE;
	Sat, 20 Jul 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilK0ktA6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7F12C482;
	Sat, 20 Jul 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721486654; cv=none; b=aJL0ODyzB5yNLWp1nHG3R6JiyuGP8ovwuKpP7NezUrXGphF9gelzbjzSyAE5hHmLUEPz9zE3i18BqkEkKmhRIq/mAVtfnsIiHPn2UVEUJeVRLc1F4ATvDJ6y3/BzSVaGNmlLL6B95wz3gCxFcXVktDBgYrdfCvDSwRQ/SdViPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721486654; c=relaxed/simple;
	bh=v+gZG3usO/DmR0rpOJxO7l9Qj/H8jk4lp9ZYHjWpb+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUt5C8c88NgHvpCFbwczFJoDWA+WCI6abo9YtZES8yTMiIOkO2YC308QSv0RWmO+tjn3lCreGtc9H/PJSTQ/bRw8+ZDyZElbASWrcQToTRve9tLg38urJ/J28GTp7bqJG7lOqRQuz4GEmcomYNM0Y5WKdf9Ifmz33iVSX1om0DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilK0ktA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B9BC4AF09;
	Sat, 20 Jul 2024 14:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721486654;
	bh=v+gZG3usO/DmR0rpOJxO7l9Qj/H8jk4lp9ZYHjWpb+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ilK0ktA6ZLAk951396DgdXvFB32Rh+DFSdTgv06i7TDMpfhxScUlXKTtYRUmfS1kj
	 o2FHq56QT4Qppmh0d688paurRiCVU8r8siJ2KACbzXDTfIwT8qie9ZgABqqQjv220g
	 mbdgsx+08I1r+CYwD/lSL5Cs1CtzuPS9A9ERAh70Y3UmyTQ+8GLNvbqyCvlHh45Bcy
	 4zQ1yV/780LKYfbXnGllygLacwzHRE9tozX54rM8Yu6x4DS9Ry91IhjPEJNMujRzEf
	 VmYuvPvLjcY0T0vp5h545JDTzpPV61qVZocRINiGZ3akw/D2847zlPfhCwVdaefuBy
	 JAvpbpjsvCaSg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ea2f58448so3607893e87.1;
        Sat, 20 Jul 2024 07:44:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgwh6bwQSFWmC6KFb5/b3dcl8+sNSAhuVRn25kOwJqQyvy2dHcMjdwV5f0MigvvvCzfoDCBPUXfgyh5qkUZo8JdHt4zZVOCLXsUXyZceWC2YXiwD6ypvE0sFAg4cm2t7Ev2mB3dnfO
X-Gm-Message-State: AOJu0YxQ0IqtYDN9FXas6OHY3MehSkWl8PhO4Zq4U6bhx5hBsE5P5pxq
	H78xiUB6auSKEjDSTdQaNlwfZsHsuJ4n7RKuIet2TR24fouLAo6LoTDJptIV0uL+CAPii+ng4j3
	k/ehi+rBRB/X9pBQW3t5dp2MrDw==
X-Google-Smtp-Source: AGHT+IEHRjoDY5QJy5Br3QFNZGd5zUKVBUB/oSkuJKKmnHRva2WxJNL8L0zKeGgnUdfMECfbyxJ9iGIG5NAsm/+nz1w=
X-Received: by 2002:a05:6512:b1d:b0:52e:93d1:57a6 with SMTP id
 2adb3069b0e04-52ee539eb45mr8096778e87.6.1721486652481; Sat, 20 Jul 2024
 07:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714193709.543509-1-shreeya.patel@collabora.com> <20240720142236.22f8dbb2@jic23-huawei>
In-Reply-To: <20240720142236.22f8dbb2@jic23-huawei>
From: Rob Herring <robh@kernel.org>
Date: Sat, 20 Jul 2024 08:43:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ=WyTNxoJGm-7ZRDYuKPGDSDFCoThfqv=+6b=MQn=pQw@mail.gmail.com>
Message-ID: <CAL_JsqJ=WyTNxoJGm-7ZRDYuKPGDSDFCoThfqv=+6b=MQn=pQw@mail.gmail.com>
Subject: Re: [PATCH] iio: light: ltrf216a: Document the device name
To: Jonathan Cameron <jic23@kernel.org>
Cc: Shreeya Patel <shreeya.patel@collabora.com>, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 7:22=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 15 Jul 2024 01:07:09 +0530
> Shreeya Patel <shreeya.patel@collabora.com> wrote:
>
> > Compatible 'ltr,ltrf216a' is used by Valve's Steamdeck device
> > via the ACPI + PRP0001 mechanism.
> > Document the device name alognside the compatible.
> >
> > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Hi Shreeya,
>
> I'm guessing you used get_maintainers for this.  Always check that there
> isn't anyone else who should be added.
>
> Given the root of this was the discussion about dropping this undocumente=
d
> binding the DT maintainers and list should definitely be CC'd + Marek
> who was part of the earlier discussion.
>
> The fact that this isn't a typical ID from a Windows consumer device does
> change things a little, but I'd imagine a firmware update for the steamde=
ck
> is equally unlikely to happen in order to fix the vendor-id.
> (I was surprised to discover they provide windows drivers for it but
> not seeing the light sensor in the list)
>
> So my opinion is that we should keep this ID in place with an enhanced
> description.
>
> The other suggestion from the Krzysztof's thread was the risk of this get=
ting
> abused.  Perhaps we should specifically fail to probe if that ID is used =
and
> it's not an ACPI firmware?

Use of it can now not pass validation with dtschema. IMO, that's enough.

Rob

