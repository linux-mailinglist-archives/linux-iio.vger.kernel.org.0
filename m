Return-Path: <linux-iio+bounces-18832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8422EAA0CA4
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 15:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B3C189A984
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 13:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBBB2C3768;
	Tue, 29 Apr 2025 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7Be7M+E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676646B5;
	Tue, 29 Apr 2025 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931714; cv=none; b=kgEsQsFzJNjMBeULM7X4pM1arJgzY+6W+u6yfOH7qxKdtOk3c9xUqKrSqVkcSWC55trr0PQSGKhJn9ikuJjygmZljZC6YGYZ3kJGSeyAYQXXa6pzYDRyQPAyHHrHLdSmgps6oZtqRS8/edYAGZnp14XJmzP1DPxRf8kzqVkcrCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931714; c=relaxed/simple;
	bh=9XUl/LXiIktlNW1q9/vnC4qQzD2kKeTCQMYHbd5tRJI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pKWna2meZ1utPubRQ5sJk1HVGmm/oqHCpPDmS/b13txiGvQKsS2OVeiAOT93F5Jzf9/8zr3QqtHJiKyTsWSKzAE32zvkKT1N/R8eI4M/wLPK1iAmId5mXkuggWQnYQeOzejIhZm949DGPCRGWKKUEF/ibb+2wLaPMH/bZyka/KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7Be7M+E; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3913b539aabso3248332f8f.2;
        Tue, 29 Apr 2025 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745931711; x=1746536511; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qp9HP7nbkSv7owv4aq7x+RhtrBtHyhrIdnwgpagOH1o=;
        b=R7Be7M+Ex+En2qx2aL8iqmlg113rNi9MGnvncjRJA/I6OawJMvtWlueXvVTdrhkU1r
         sHASgiBXTaQOEih+9EDZ3jz8+gSMC+VbbvnTyuLj48TAvLAUiMxd85XvutIXytbmTbmp
         gFSua4PLqsjJ3jyIVGFEkjzS10W4M4u/UXYw6X50GgVEmyp94SDeDbYnwMc/xsolDm7C
         o5yoBmyl/lGvGYVNXn2B+tb9aPIo9v+JZbIy8fhv7aGMZ8ZjjMy4Fj0q4aRRdMU7Au2X
         zuA56/5wBeJYYgHjED3gsqiASIpN4mmAgrbI6KV6i+LoMDEYoLdpvDkrK9SL2LT+1OZC
         4p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745931711; x=1746536511;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qp9HP7nbkSv7owv4aq7x+RhtrBtHyhrIdnwgpagOH1o=;
        b=rqDU3devq4Vn97TzSQZx7tKxMCcqb2ZpuLSgyFD/U7lICWVOA53ejk8ue4BNYdwEBw
         uonYzqvDZWJj301DZ2QiX8zQflLE83Gu5SZlj05PByX71pwjySfGT6xORlje1wABt11D
         D5dnrRgnvKDAJ39utnP6mQ6aJDrU2fEwPnboxjvHhRA7iwfmkwLEjCPZJ1WuT/mI7BLa
         U7DT+lFw4RpafaogzzAZO0McpUejXTUAMy7dptsumaupy++9ukAl/G8/EJwjTAGTv/HT
         rR0DcSNsrrix45Ikmq1loZTO6U58GcAVonPIc0R7CL1deZd7SWuORHmzejBqyQZSjKBR
         WpOg==
X-Forwarded-Encrypted: i=1; AJvYcCVXkRKNSUmgaLB6gq7cHOdZklqVyJY6QFHTZhq3gRc39TqwMBoKb42rTaf4ZdLyeMPm4g+D8hIbwRtPVPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVSR0uckOAKm+dPNbAVIbSUDf3r5ZWkOQjanReUY/dcWh3H90g
	cAnqBVLHU4/xlgoLmyWr5TPOrvmqhScBL2Ikc5lJ96webLZ2BOgr
X-Gm-Gg: ASbGncvV89EseGjkfEomE9wbwyNyg39Mj8s0Bin+xbA4cRTUtCQSLjDG3a7y24sr89R
	iNaQt3+QyQ5NDKCQ/9b6aTj9Wuw8apM7U49XGLSOJLJSzGK8T+f/lgzrgQY8B7yEpPGOafIOF5P
	lO4xY4rdorOGbsz1OSD+bdwNcUec4IoNu4Za6qmeMFYgCJ+4sndHxk5Ab8GLmqzt/Pp9pJ3EVG8
	Bp5nL5HUk8SxLI85JwZx2aT6hrpemWgdm5AX/vF0ezw7WAu+MEyOODFYBYxMYZtfUkrsEsBJ+6h
	97j7ADLViK5wFXRiPuug3yoVDRTz2T7LZoWpsBuchaCguE1+n0cvUHO7b89PxxVfJkOKDOD9z/B
	/K9Pkf8yLlOiZGH9O45hwBAI=
X-Google-Smtp-Source: AGHT+IHQ/LxRi4ZmDdF0/EQ+UxccGKgU9aS8ne9lwu+oC/6zRbNc3sixaJGwSpKcs0c7HJfWXg8SSA==
X-Received: by 2002:a05:6000:40cb:b0:390:f394:6271 with SMTP id ffacd0b85a97d-3a07ab85dc3mr10084113f8f.43.1745931710417;
        Tue, 29 Apr 2025 06:01:50 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2e0414sm192661985e9.40.2025.04.29.06.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:01:50 -0700 (PDT)
Message-ID: <d7f00a8c9d4da6f780c1ec067be2702fa0e60ea1.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7606: explicit timestamp alignment
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Apr 2025 14:01:54 +0100
In-Reply-To: <20250428-iio-adc-ad7606-fix-buffer-alignment-v1-1-88dfc57e5df0@baylibre.com>
References: 
	<20250428-iio-adc-ad7606-fix-buffer-alignment-v1-1-88dfc57e5df0@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-28 at 21:17 -0500, David Lechner wrote:
> Use struct with aligned_s64 timestamp to make timestamp alignment
> explicit. Technically, what we have works because for all known
> architectures, IIO_DMA_MINALIGN is a multiple of __alignof__(s64).
> But this way, we don't have to make people read the comments to know
> why there are extra elements in each buffer.
>=20
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7606.h | 13 ++++++++-----
> =C2=A01 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index
> 89d49551eaf515bab9706c12bff056dfcb707b67..441e62c521bcbea69b4f70bb2d55f65=
334d2
> 2276 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -155,12 +155,15 @@ struct ad7606_state {
> =C2=A0	/*
> =C2=A0	 * DMA (thus cache coherency maintenance) may require the
> =C2=A0	 * transfer buffers to live in their own cache lines.
> -	 * 16 * 16-bit samples + 64-bit timestamp - for AD7616
> -	 * 8 * 32-bit samples + 64-bit timestamp - for AD7616C-18 (and
> similar)
> +	 * 16 * 16-bit samples for AD7616
> +	 * 8 * 32-bit samples for AD7616C-18 (and similar)
> =C2=A0	 */
> -	union {
> -		u16 buf16[20];
> -		u32 buf32[10];
> +	struct {
> +		union {
> +			u16 buf16[16];
> +			u32 buf32[8];
> +		};
> +		aligned_s64 timestamp;
> =C2=A0	} data __aligned(IIO_DMA_MINALIGN);
> =C2=A0	__be16				d16[2];
> =C2=A0};
>=20
> ---
> base-commit: b475195fecc79a1a6e7fb0846aaaab0a1a4cb2e6
> change-id: 20250428-iio-adc-ad7606-fix-buffer-alignment-9fcde71687dc
>=20
> Best regards,

