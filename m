Return-Path: <linux-iio+bounces-18240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048D3A935B5
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 11:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DE33B7E95
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CE126FD86;
	Fri, 18 Apr 2025 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWW9/nHk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973F26E152;
	Fri, 18 Apr 2025 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744970288; cv=none; b=NKh/pHt8x26Gbalwmk4NjpjU++2xgKIbASGbQCv+pVns3Ig0w7jhoQfiKX72SbLVToqVZB/IIFm0ZYtdusYkxUuOZDzRCQz7HEVY/zFr2QHu8Bcv3OezzVYGuc2MUBJqj0/zFhhRSElDLmSRS/EKTXF073QbLu0PJbbHeJFDdpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744970288; c=relaxed/simple;
	bh=MZXj9qBlnIA2yzDtfDE8dcexJS9N7Zn+xwzVBqTmIwI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GiivvjpwuVpcT+LuOQ4eGZdOfBpGG5E1L+4O1hbx3yuo4C9lCE4hlZselrd0E3qkWgTBk77tZLMQ1Bes88JLRpF+N8gHzlKnpsJWjOOC2XbFg0w+H3uhcRJ2xfW7gHNoKy/uvqxnPH1WGi7lddWWgGFVfkEo5UdKIrLwpizeHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWW9/nHk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso17652785e9.1;
        Fri, 18 Apr 2025 02:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744970285; x=1745575085; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wtxUdRpeKm+ANCEaoBOMbDJKRr89yLjZTB6s8COjTOE=;
        b=EWW9/nHkTKI3PnXS5XtOKLJn9hfO15oeXZVKucIezUn6fK5CS7UPjODmIvfzH6Ysji
         CONCKaZ2oqpnLPCi7lR/w/b7KKPNmR4qcvGtrr7AyFh+03EwbbfXiXcAI48R4TOcJQVr
         zLPo5Of2r4jxLQrEPx4T5Z/7vB31+wRaa9aIht39Qwrq+oHr3d0RKXYK+LxuJzUOYFxP
         M0FUJUhxf3ivlEyFN0eXm7i3cVAO+5IFjBm1M86qVIt2dyfwirnAgwr85XVdnM56wkYE
         CmznHQdUGziyoLFOGpbZ4jd0F+LnLmWHjqpZ73YqVE7NxJlj0mEH+/O7ehfpJtu6I8Ia
         w9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744970285; x=1745575085;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtxUdRpeKm+ANCEaoBOMbDJKRr89yLjZTB6s8COjTOE=;
        b=PkFRxgmTOa0lTlbwbLUEiQMoT12Msj0MHr/pzj4STNDlC35tcpXcINUCg6d5Le/ck5
         nDxE2gJAH+63y0Kv5oE7SzQwlEo5zXTz0OjY5GH0pdz931J4nbCdA2A9QU+GNYxK/OTR
         0PKXuP4tH9rP6h1u7cFHldHqQtlcvOrap5t0/qapjaMgPl1GRYWfsvLYQPPt51TE0FfE
         lxWnn6E1e+worDEkOzOot2KrUVPPxxKshKOk13ycJ/IZghFFKT0F+ThmuxFy4rZQK/IF
         53OHcVmpa+Xr4XQSTGAsY+0DGtPRBYPNyvhJrXs4roTBE/xfOKK86LltXF1WjGjn6A2a
         6n7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvfy75snGEV/OFK1XqZ9sT1mFvJdSe7h2MTQ6GFmQxTtq/y7xDamzt6DBZis9lGL8OIARNeCxAC3hgBr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc8BNTTeutiJXAhGO2BSXSSCcITsP/cpSHLZqyjHD6Wu7GUjql
	L8q50hvqXKLaX/OLdkPbd/zvfyuRMRBDWLVZH05kmcR8Uu8tnKQL
X-Gm-Gg: ASbGncsVUzSrTFvnZCaG4jp0ds6MeIx3T+0dS+yR7fjhugLsiyF0TLFGQ77pXFonCQH
	3eYIhgJukYhbc0WWtVLptoOP+VKRe97IqKdYAHRG3B6RzOqiQoY2MOfYiIlAlfLWVd4d37uxKdM
	U+Q0Z/10n5FhaHdPUXHd/I3nAc1BZX0AcPbcL640WElsu76TkfVqfs/cTNCwWA6eFdjniZvCDpm
	p0qED6kFgwB8XhGvBpCT3p62gPJWnDbVuxCpP9hTEQ5eDcrKB3IsJUIA0VDQ/qYDbcD6YheUPZB
	mqqyl6tQHF17ESS5/ou2AYNln8q5+aXibXaqSM0456T5kep8ZpALPV512rrRSM9gyRjg55dqtw8
	6PjUiunNeJh61vhs=
X-Google-Smtp-Source: AGHT+IE/FfCxx0tPuZ6qCUGNp5eZ3+6ZBuRbRtb7Q9/Aksg04+VnflJ6AYoHrsoEeblg0HGcmX6ZpQ==
X-Received: by 2002:a05:600c:a088:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-4406ab9767bmr23956205e9.10.1744970284863;
        Fri, 18 Apr 2025 02:58:04 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43be53sm2249042f8f.41.2025.04.18.02.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 02:58:04 -0700 (PDT)
Message-ID: <a1ce36c3dee60d3fa2a8b864f55371b0298d83fd.camel@gmail.com>
Subject: Re: [PATCH 4/8] iio: chemical: pms7003: use aligned_s64 for
 timestamp
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lars-Peter Clausen <lars@metafoo.de>,  Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Tomasz Duszynski <tduszyns@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,  Andreas Klinger
 <ak@it-klinger.de>, Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Date: Fri, 18 Apr 2025 09:58:25 +0100
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-4-eafac1e22318@baylibre.com>
References: 
	<20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	 <20250417-iio-more-timestamp-alignment-v1-4-eafac1e22318@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-17 at 11:52 -0500, David Lechner wrote:
> Follow the pattern of other drivers and use aligned_s64 for the
> timestamp. This will ensure that the timestamp is correctly aligned on
> all architectures.
>=20
> Also move the unaligned.h header while touching this since it was the
> only one not in alphabetical order.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

With the tag:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/chemical/pms7003.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms700=
3.c
> index
> d0bd94912e0a3492641acd955adbc2184f4a11b3..e05ce1f12065c65d14b66ab86e291fa=
b47805dec
> 100644
> --- a/drivers/iio/chemical/pms7003.c
> +++ b/drivers/iio/chemical/pms7003.c
> @@ -5,7 +5,6 @@
> =C2=A0 * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> =C2=A0 */
> =C2=A0
> -#include <linux/unaligned.h>
> =C2=A0#include <linux/completion.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/errno.h>
> @@ -19,6 +18,8 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/mutex.h>
> =C2=A0#include <linux/serdev.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> =C2=A0
> =C2=A0#define PMS7003_DRIVER_NAME "pms7003"
> =C2=A0
> @@ -76,7 +77,7 @@ struct pms7003_state {
> =C2=A0	/* Used to construct scan to push to the IIO buffer */
> =C2=A0	struct {
> =C2=A0		u16 data[3]; /* PM1, PM2P5, PM10 */
> -		s64 ts;
> +		aligned_s64 ts;
> =C2=A0	} scan;
> =C2=A0};
> =C2=A0
>=20


