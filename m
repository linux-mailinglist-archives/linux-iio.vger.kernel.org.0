Return-Path: <linux-iio+bounces-26771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFCCCA514F
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 20:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 850643059883
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 19:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2112F83B7;
	Thu,  4 Dec 2025 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chI4oH1v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F33830FC18
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875515; cv=none; b=gYWtNg5BzY2/2+URmSE5KdqWForRDGSBwRj5Gza9o655abosXz2Dvjci5YdXFSPJSh8INH6EWIJB8mrVIRlxYSmTN62g08SgC+bo7F0SqLlxpN2nevqiUW6qcWYLeF1C2Wvj9oZzlUIBYCbrwEKHogFfBIx7YQCwVaxQwv6HVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875515; c=relaxed/simple;
	bh=ujlEpuqFkjM91yvzfWppiDY+/pnrYLM9we7vMe33gqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpHQKVJULfQUS/EVi3dcWM+n+kVXjEeiWkRDXWo4HLaBoLe6oFK+wtzJrwTFEDkfFv5cR4J9hRISqQeRLYyooM4L08+V5uu/isqkHEm+Ic7RVn0afmjnkYx8pn3ptm4dMPQos40K0hxUfQuCt4JSEGqJB9MoOoLj6eiabc/J2OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chI4oH1v; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b735e278fa1so232944866b.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 11:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764875512; x=1765480312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujlEpuqFkjM91yvzfWppiDY+/pnrYLM9we7vMe33gqk=;
        b=chI4oH1vuUwAMM3L0xT3IUi8h3yqlTeC51WSCvvSVaaQqJCJJXMa6KqGVp4yRR8xTB
         d/vgczpBRo5iUYQFUBKARiYFUz/EGn1vF74tfRC1lx8V2OtkOYL5ajYSIw/mRbAGpPGj
         KCftCVQLjUkdcJDRxz/t4wrJ2jbpY+Mal0aje2dpSL+iiBG88RhJgxDz+F58cH9/mk2b
         uiPUpoUkZfNK75jR87IBOg792iP6ux/Kg77lthl8T/7jb74KiB2s8G2BewTGANbDnU2O
         2BeKaryHdY6usvVO7grFtUXGOU8nfhu/Zqhr8ZQjPl0oppvPBmAo69vITkmiE4jjxizg
         3eFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764875512; x=1765480312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ujlEpuqFkjM91yvzfWppiDY+/pnrYLM9we7vMe33gqk=;
        b=HlZPXH5PhHR5nWysLLJ1MGoQL+c9515ets8dldp/B/sjuZpDcV6oz0CH5IJGIuFVy2
         LjKsgBzqLbIJPFpAxUKTZFkbpORFMnDo2z+G33jlRyRnAX3HRY4/qmpTDzlghh7pNscv
         zqNIUEQv2CQXWzA1GEDTwpbL1EZfFpati3tD+QUOc146uPDakwnRPxcGp4rXYKyDv6St
         9YR148a3hbTfKbx5rOz32SfAaA6zuLNkT/m/F5pIeWHOvZeXnSt5OSIOVWJoiKNF2xFx
         J2iUUUMErqw5GLOEkHi79GIvbZIvgk22J/i+a6B4Z6a4YocEUdBwYK9gF2jEdPjuUWBG
         1/8g==
X-Gm-Message-State: AOJu0YwRAzRDG0qb+Rc1jZ65MOBwc0eeDCx7uoRIhwT6wmmXlsQkrUKW
	MRWfXN4JdC8xBj5ECnAQu4Ngcx3UjD+43sfoOsnIPT+6DP9+EQ3hUHIb169L+t6xPKNBiNapQR7
	7XIbL8pApkGwEsP3wrizTsBb5QGIFz/o=
X-Gm-Gg: ASbGnct7XY8zM3bGJh+I8GnkWoMuPoZ6vov0VGUScGPLGFS/udMyQUl6eNwcvX5cqLJ
	eqpyjMc6eQaSstSfyL3BHxhr05vxfFipUC2JeMhHzi7/tvINc4H6NS955pIcdZV2uDsWlvhEJEI
	fBCxITvudW1mqNFzEnwTVJx7r+ArsdDfXFc3iPPADcdhhIRPIUutu1NWCqlJkuc5hWVxNb+9LJ3
	5Qnil7qM1gxmGRHKgOEZtdb2g2rPaEARx3Xa+Go/UiL1v5QRF79WqepN0/oQwcXD8F5pZXUVv24
	Z8jCzakSKXbNnMuwiuHglAP5p61Q7tkZ7MrP/TFyMqzdfDPcqLvrmW755sdkC3THUcbgEkk=
X-Google-Smtp-Source: AGHT+IHP5cGGpPuP5CKWqrfX+1T6rdoItXnUs1JMrWkSkUtnnOAOGxhRg2oTK4RKTslD9L5EV5K5JoBfMEpRPwGlers=
X-Received: by 2002:a17:907:844:b0:b76:69d6:f9fe with SMTP id
 a640c23a62f3a-b79ec6ec82cmr442096766b.60.1764875512156; Thu, 04 Dec 2025
 11:11:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com> <20251204-iio-axi-adc-minor-change-v1-2-2d441d6c5b65@analog.com>
In-Reply-To: <20251204-iio-axi-adc-minor-change-v1-2-2d441d6c5b65@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Dec 2025 21:11:15 +0200
X-Gm-Features: AWmQ_bkhgykDrKUXqhhSZEfA0qgzCIAxtW53ff2Tbrrn7Fo3mkils3AHGIG0gYU
Message-ID: <CAHp75Vc46cy7vGPAHksFB5QT0Mc_ztGaODtyLeEQHveNrYKg=Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: adi-axi-adc: Turn dev_info() into dev_dbg()
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 5:23=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:

> We should not abuse logging and logging a successful probe is clearly
> abuse. Turn it into dev_dbg().
>
> If it turns out the IP version is that relevant we can make it easy to
> get through a new debugfs interface later on.

Hmm... This prints a version information. Does the user have different
means to get the same information?

--=20
With Best Regards,
Andy Shevchenko

