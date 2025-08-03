Return-Path: <linux-iio+bounces-22227-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB27B194FE
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 21:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50A3C7A1E18
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 19:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B621E1DFC;
	Sun,  3 Aug 2025 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICmzbBND"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E64211F
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754249256; cv=none; b=r5YOu6SIKYcJEhiOzCLgP8NDtfdG0N5qOX+Zle92IeSIdPjebRVJj9FUSbDu0JztFAUxHKxhP23wVNWME11cvZheO2sTYlWD2UgjduIAvVU30ZHeAWMnvAkE65mW9TM/3vu7+7wjzLpuQBKgplf77pfjBw3GNijhDrabyRQUxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754249256; c=relaxed/simple;
	bh=ih+VbjEfvtdAKfd5XI3qnOVIbMQl5r1GPo+7mbIl6Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXdzqyjJpb+6k6TOqHq1SxEJTXVElgLfo8lAQDMv44lHpSnaWi66+yDL5tRVpx5ZXMVo0QJX0klqrw/SLiFPiTRd0Ovx13e0j4yC0yEavFBgD68JSp1hK1k8x30QVb8dzlAqvz4XsdLMe0k/4om0ua9dSOv2I5O2cDbQ7x4/lWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICmzbBND; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af937728c3eso378520566b.0
        for <linux-iio@vger.kernel.org>; Sun, 03 Aug 2025 12:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754249253; x=1754854053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ih+VbjEfvtdAKfd5XI3qnOVIbMQl5r1GPo+7mbIl6Mk=;
        b=ICmzbBND6fVd1PjJdrFea8unOlSkc/W3KPiBDEYeCNUpa0XpomjqzM9miVWuac7N7b
         ZRlNtIMOgSl2T5XOER9yjZfXmMHykVd2Mz4ELRh0G3hr5zfntDE+dyz7OW44qn4tUTdb
         51f303v3sBPBPeRB3XsMK0EgPecGni5GwmrvvWGXlkvjC+Rnys305bedPSVcQXkDXTdH
         4xXoG4/4pindhyjavdzoynW8EIr8RGnv4xUjdeCyhrz8RtzN4kEElZRH+Vyb4R1QxY5U
         SWq+Nnl5vRAXkUaC44DC99OZ7c5hruNweSXW6sV18DOmBx4H5L8djH4DbInJwY9e7dtM
         Q9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754249253; x=1754854053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ih+VbjEfvtdAKfd5XI3qnOVIbMQl5r1GPo+7mbIl6Mk=;
        b=DKHQw/arY5/EmBu4CxUwXl5mOwOvmYZSOa1SVFLQGjTPPU/Mu12iE2gBBDuOg9cFbL
         w7WO3pOLHCnwmc5Vwvut6qHr0OtbQd2V62HSbTo43YUKU/IhvqWb+laRRva5rIVABa1b
         IrQlo08CKwq29QDleM8pWf/8mAiNcnILKcnMz0XSmRn8wTWQcWcXk7WcV48c3r8GNfVs
         vwMegWaX3vZRgR+u06ft6F6CNvUzPbxLH3Z4vyGXeBQJmpspLojZgWMPQb5Z5+oEYVrY
         yBq3fjsmdlqhelkFZUzd/t8PSnq3Ovb6nheBK9Ry4b18+g/zCpUCdHYG2wEkRoFDIBeV
         /ETg==
X-Gm-Message-State: AOJu0YxknRa4GtdvuOsIZ+CSUX9icoAA+OBQWGX6CgjaQw/rbQLSS226
	OxlS7dox4VZkryOoK9PVGnUq8PrLwVNAgnA+ki5sVtdwkjJWqAqdMYyNnag+s+tHVBwAKiaezef
	Qd6bDKfABA70VXLiXYbh0E2hzmM8PD5s=
X-Gm-Gg: ASbGncsHlqW63+LFt66HhzKG2YYMOJhz9qmS0x8JFKgFE8N7PvseGlrdLPXxsQV3lEI
	CaZNPOQrWMUqcnUE1YWqsEwbIIDR5HGlSX/9Pf6zUVi621RBrc0J6dL45WvUTulNxcrdMgNLfQa
	N7IOvHrU7dxybKv0Lz4ZTr91fZnJCUE3gFFIS2QoC8J3p72b6pmepeBcNlXLqSEBWrwcldiAlbH
	AwX4qmO4Q==
X-Google-Smtp-Source: AGHT+IFg5gyF8Wf46xVF2XMycbHzi0u+t2NqSS0IbSXpkjiOZZbQ5H9p2Wp9VhuiOHhUkSrx+3WV/0KBb4OehWTsPeA=
X-Received: by 2002:a17:907:728d:b0:ae3:ee3a:56ee with SMTP id
 a640c23a62f3a-af940775115mr726384566b.3.1754249253302; Sun, 03 Aug 2025
 12:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802164436.515988-1-jic23@kernel.org> <20250802164436.515988-11-jic23@kernel.org>
In-Reply-To: <20250802164436.515988-11-jic23@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 3 Aug 2025 21:26:57 +0200
X-Gm-Features: Ac12FXyDA2AmeZoLBdjgZNSXQwAt-3lRAJlycfXu-JUml0iIu-p-YFtP8nPdBOo
Message-ID: <CAHp75VeBhA=Vn2cxxZXJV+p3yg_5_4z-V2XUiFnneNvEz2+uvg@mail.gmail.com>
Subject: Re: [PATCH 10/16] iio: light: max44000: Use iio_push_to_buffers_with_ts()
 to allow source size runtime check
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Abhash Jha <abhashkumarjha123@gmail.com>, Astrid Rost <astrid.rost@axis.com>, 
	=?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>, 
	Gwendal Grignou <gwendal@chromium.org>, Christian Eggers <ChristianEggersceggers@arri.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 6:46=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:


The below (here and in the other patches) reads incomplete. Yes, I
understand that the first sentence is in the Subject, but to me
repeating it here makes things clearer.

> Also move the structure used as the source to the stack as it is only 16
> bytes and not the target of an DMA or similar.

--=20
With Best Regards,
Andy Shevchenko

