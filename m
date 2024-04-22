Return-Path: <linux-iio+bounces-4440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ABC8AD187
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 18:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D732281632
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 16:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DB2153805;
	Mon, 22 Apr 2024 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWb0EaOH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B115358A;
	Mon, 22 Apr 2024 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802000; cv=none; b=Iorawpd5tg/zbvJO77KdhuA/nfO0O0Vv4T0JLgYwWwaQdySUQbaAkpNGO1y3bAp0KAZSRE/83G+fKmp/PQinCJLlZY3M/wTX9dKhl99bohn1x//OZCwBH/IMsvgNnNvtWDp9QT2TuSm0Tx80SHnXCclPFHEXaLS8QQRGYTOTXcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802000; c=relaxed/simple;
	bh=/eV0QewYnR/TwjFPMQjJNA0f921srmGTRkXQHI3QFSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4jvdMHJKEWw1XHH2/yZ+yJOdCaBSKPOFPstkqXKJQB3jZFQVq4WR4IhD9bMCHGgA8sNXBOOSI1UIeMAcBoLUgSt+5gFZY12lT0sZSlCb5C8tCFCrwCcRU9KhNT/UxNUAhvCZVSsSQOsEuo0Db6MulKZSaTL8d6noTUPd+HjbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWb0EaOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DABC4AF08;
	Mon, 22 Apr 2024 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713802000;
	bh=/eV0QewYnR/TwjFPMQjJNA0f921srmGTRkXQHI3QFSE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AWb0EaOHHQZ3W4JAUhevEr1tphSXrfkxbakZEJthQyGmohfqtjWyE6PK0m9nIsf0T
	 JX7wzgkPvU/tlzqmr7jHmbqJCWwRyx+Dp/waWaHLPd7Fi2Qu0BOOMp0rYkar36adij
	 tcHUJYXpPs6JPMoD4hoCLl7TLMs5OQHi5VfPf2eSaPKit5hxMeVX9cIyvrB5m6cUwG
	 jy5VYJneH3Mnqh6sLY2rOxYvSVhrlVjCA1wUxOHBCom6G7XIxqqV+H4cMnRPJXxoFZ
	 Qq99vW4xqdDq9oY+Az1h0IwujB/mrcmJxe1ymr6I3K5avaNxT/f1PvoLZJALQ9Sq1i
	 OhGdaGB3phosw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a9ef9ba998so1057872eaf.1;
        Mon, 22 Apr 2024 09:06:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpmkFPckQIn2Z5DemKW5Vg7arDRB1QPnnGKTRZUnNkipFAS9pEwXaMmkbSRE31GF30uyP/XYep0lbkfTqSg1v2rlVWAUgxupLznowcXTS1CvEXbBRsAB+XVbzwa0KbUtepan6F0Q==
X-Gm-Message-State: AOJu0YzaDpdWobzlo1ESWUHGOSC5Ye32hh8SiCnpvRqXTp7H+JGWkdq/
	ipwLLuqauBAGfrfbPnXvsg11ho06qXhAzoncxOo7AoA0pOaIh1CIx/1gtlt9GkY+0SD0poCvyWi
	SsmdduAWOtse5C1CePSI0KgLm+Ug=
X-Google-Smtp-Source: AGHT+IFvGo3Yt8VKsQ4d5W7GHHGI3rINMk8s22NvSvikWf0cC7q1VGBPUSaHOolsGqrLZKyTMaYKfOG3oOeU+JaEe7I=
X-Received: by 2002:a4a:de19:0:b0:5a7:db56:915c with SMTP id
 y25-20020a4ade19000000b005a7db56915cmr11783826oot.1.1713801999673; Mon, 22
 Apr 2024 09:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422100218.7693-1-hdegoede@redhat.com>
In-Reply-To: <20240422100218.7693-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 18:06:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iHSiT=P4gawrvWE8y143Q-02Ps8WQKM9k9Z+TctL3kXw@mail.gmail.com>
Message-ID: <CAJZ5v0iHSiT=P4gawrvWE8y143Q-02Ps8WQKM9k9Z+TctL3kXw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] iio: accel: Share ACPI ROTM parsing between
 drivers and add it to mxc4005
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Sean Rhodes <sean@starlabs.systems>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-iio@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Mon, Apr 22, 2024 at 12:02=E2=80=AFPM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Hi All,
>
> Here is v2 of the patch series to refactor the ACPI ROTM orientation matr=
ix
> handling in kxcjk-1013 + bmc150-accel to share the code instead of having
> 2 copies and then also use the shared implementation in the mxc4005 drive=
r
> since some MXC6655 ACPI firmware nodes also include this.
>
> Changes in v2:
> - Add comment about the Microsoft specification for the "ROTM" ACPI metho=
d
>
> Regards,
>
> Hans
>
>
> Hans de Goede (4):
>   iio: accel: kxcjk-1013: Simplify ACPI ROTM mount matrix retreival
>   iio: accel: kxcjk-1013: Move ACPI ROTM parsing to new acpi-helpers.h
>   iio: bmc150-accel-core: Use acpi_read_mount_matrix() helper
>   iio: accel: mxc4005: Read orientation matrix from ACPI ROTM method
>
>  drivers/iio/accel/acpi-helpers.h      | 83 +++++++++++++++++++++++++++
>  drivers/iio/accel/bmc150-accel-core.c | 45 +--------------
>  drivers/iio/accel/kxcjk-1013.c        | 82 +-------------------------
>  drivers/iio/accel/mxc4005.c           | 24 ++++++++
>  4 files changed, 113 insertions(+), 121 deletions(-)
>  create mode 100644 drivers/iio/accel/acpi-helpers.h
>
> --

The series LGTM, so please feel free to add

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

to it.

Thanks!

