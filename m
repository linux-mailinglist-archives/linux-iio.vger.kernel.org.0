Return-Path: <linux-iio+bounces-22282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2D2B1A2D2
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 15:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BF13AB105
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F8525DD0C;
	Mon,  4 Aug 2025 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kr/GiFYd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C925DB0D;
	Mon,  4 Aug 2025 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312782; cv=none; b=FkcXHOOxGVxHP0aPZy+ZYKZugTnHKH07tMudd83AIQL6vbu4v9QJdcwV1ZbFahpUFnk1YVAOcGXAsck++lmju7RXTs8w1XOBd2rkBn06pawly+EPQeUH3qfLUK2YHYmpUV8MgQZKxHlpM/1vnv5pvZGqcZYppo+YCjyhRYePUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312782; c=relaxed/simple;
	bh=BZW1ZsIO9Hnt5qEUnhAI2ANB02CXuq6/ADxe8JFUJeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUfozTujd/Pb/pvOt1tACLd3s6p/cduDJzS5IXxvex3FG0TNdA8GMJsgYZxBPYsL6RcH9F1XmvUlKKD0U8l68qNuzMsg04kKXpteV15ENjFHM4qczBKw36LfaQ9PPfXrNMQ4yYKNexmGTnh2K7WEV471YjxuLY9K5pxuen3cjDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kr/GiFYd; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af9611d8ff7so235463966b.1;
        Mon, 04 Aug 2025 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754312779; x=1754917579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXG9AGrFinYmMiROAAb115udLcWZgKrApUBxNgWLPeU=;
        b=kr/GiFYdGsNP48aEv5W1ECjZV/5capYzB4b5QhGfIlQtV2o27fbzN79OG0Nmq5p3mL
         3gxIOwnF5hoIMk0O+/Hxi03e/u8vlGuscNqmOYXAOwV2R8YxuvdX2BG8Ov3xH/8UUOC+
         BXYGtzJKuGIL0zKBKPc/eTVCMyRPxpDEWe5lqapo0HfftbqRVMq0FOuBAM19nrSE6NjP
         0nGOz7N2QTbnkjBZO2J+xarjgcZCvg1VxPByCd0snGMJzvaO7lrvFvNRK9nuVSdic61u
         o5AylZsXqmcXzu+/1sFAphvQqh/NRaTFgcHYvGR7oqb8d9bWAqmYcNHFu3Ny5CQLGgB7
         ejjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754312779; x=1754917579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXG9AGrFinYmMiROAAb115udLcWZgKrApUBxNgWLPeU=;
        b=lQ+0RmyggLM77r6Hyl8pWopALPh7PWhXXkELbPNx0ZDOu058ZqLf+jRNHa6Ko1rEpS
         8R6YDvDW0vC2h1C1N8gbHHRAPqOiUxCqS5KQKnVuv2rmMExISpQOL39tjJh74/UTsJyo
         Pr9BEqlDBDynH8adNWdHtxTyOCmyed9KgiWKkOXeNJnIdy/fT6/d8Ex3D6KaO2ZIjHHA
         7cYFCBRT+pLbIpXivdDNpX4iBrxhykCBYwgm2SoT0seXmOZtaQQez1PHBOuUu4/eqIgK
         /j2uyz6WJyUBORGn/VX5i00YwuXspowMJJmreQ08n/9LBeuuVLXVsEtfzjZchIeej9tc
         mg1A==
X-Forwarded-Encrypted: i=1; AJvYcCWYHwxiKNtgKabkRS6D7O751/bA1z1vQqCCYuhcmHeHgEDck4cPtz6nO6xOF5pQUekWXfXvinPR60d7@vger.kernel.org, AJvYcCXLsnxhu8kU/3+gBU6o852B10GoFiDzJ7eeDg51pSzZ/cuGvnX6Mebjpom+cS7PNd0joPI0wXOMVmsR@vger.kernel.org, AJvYcCXqV7kLpTlebbyTaDEYaFy7rFNToIQqsqlbUc5jTluv9FDPQKinQpMXkDesdMlBnc6tC3LyzTpQsOR/A4pU@vger.kernel.org
X-Gm-Message-State: AOJu0YxBSqlCyIqa+QR9uSrk4XS/Q8dc6S9JyCJmFcYpzVv4YcQUUhk2
	hMfELG1Ohj5hcXM1UYtxum73Wu1SyNVcGxNwpCXJES1gEGhnbPjqb15ybUV8m46KL96OnayyNTB
	AlYnVac9yqBA1ZLC1Rm6d70lsnNhU3ZI=
X-Gm-Gg: ASbGncupq+4OTZiyHXgfLjk2K1mCxg0dP+YlVoo/3/6wwBrpKOy2inFzaQ+61VaC+u/
	cI14QPbGeLoJKigiw1zLuSz3D56wwfZvJMraPqkBLXA/p6gATcpl0lHT/VABg9/DQw7mNimHYZf
	fi+LhsQ9NfKltvEnL7GqwRhg3rWVo1UsqDTHUBvq36pgZBLHso1aAvR3SC80suyVJNBYnNreCBG
	M4Ryp7Shg==
X-Google-Smtp-Source: AGHT+IHaNA7ufYU5FGCTtMM+oPSCdoPGzfWaTkq5/1dcIXFW8X4peIybcOF0xM7Krq4hTjQcrGB4SCyrnLvydlfHGoI=
X-Received: by 2002:a17:907:1b25:b0:ae7:73b6:19a5 with SMTP id
 a640c23a62f3a-af91bc5f255mr1632375366b.10.1754312778465; Mon, 04 Aug 2025
 06:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804100219.63325-1-varshini.rajendran@microchip.com> <20250804100219.63325-3-varshini.rajendran@microchip.com>
In-Reply-To: <20250804100219.63325-3-varshini.rajendran@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Aug 2025 15:05:42 +0200
X-Gm-Features: Ac12FXwsws8uL2WACME0UJrimsaN3CYrhO21JJ9_MU4uMd-Fpc3BM8qrxFMwToo
Message-ID: <CAHp75VffH+tpqP3J+x-ybiwe2O6Mqm6PkaxTrVBgByMpS4Q26w@mail.gmail.com>
Subject: Re: [PATCH 02/15] nvmem: microchip-otpc: rework to access packets
 based on tag
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: eugen.hristev@linaro.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, 
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, srini@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 12:03=E2=80=AFPM Varshini Rajendran
<varshini.rajendran@microchip.com> wrote:
>
> Rework the driver to change the packet access technique based on the TAG
> instead of the currently in use "id".
>
> Since there is no way of knowing the OTP memory mapping in advance or the
> changes it can go through with time, the id based approach is not reliabl=
e.
> Accessing the packets based on the associated tags is a fail-proof
> approach. This method is aided by adding a table of contents to store the
> payload information which makes it easier to traverse through the OTP
> memory and read the data of the intended packet. The stride of the nvmem
> device is adjusted to 1 to support the TAG being treated as an offset.
> The only reliable way to recognize a packet without being aware of the
> flashed contents of the OTP memory is the TAG of the packet.

...

> +struct mchp_otpc_payload_info {
> +       u32 id;
> +       u32 packet_offset;
> +       u32 payload_length;
> +       u32 packet_type;
> +       u32 packet_tag;

Just wondering if these are okay to be in CPU endianess, i.o.w. is
this part of the protocol to HW, or is it simply Linux driver holding
values?

> +};

...

> +/**
> + * mchp_otpc_read() - Read the OTP packets and fill the buffer based on =
the TAG
> + *                   of the packet treated as the offset.
> + * @priv: Pointer to device structure.
> + * @off: offset of the OTP packet to be read. In this case, the TAG of t=
he
> + *      corresponding packet.
> + * @val: Pointer to data buffer
> + * @bytes: length of the buffer
> + *
> + * A value of zero will be returned on success, a negative errno will be
> + * returned in error cases.

kernel-doc validator is not happy: Missing Return section.

>   */

...

> -       packet =3D mchp_otpc_id_to_packet(otpc, off / 4);
> +

Seems like a stray change (adding a blank line).

> +       packet =3D mchp_otpc_tag_to_packet(otpc, off);
>         if (!packet)
>                 return -EINVAL;

...

> +       writel_relaxed(0UL, otpc->base + MCHP_OTPC_AR);

Does UL give any value  / make any sense here?

...

> +       if (size =3D=3D 0) {
> +               dev_err(otpc->dev, "Cannot access OTP memory !\n");
> +               if (!emul_enable)
> +                       dev_err(otpc->dev, "Boot packet not configured & =
Emulation mode not enabled !\n");

Stray space before the exclamation mark in both messages.

> +       }

--=20
With Best Regards,
Andy Shevchenko

