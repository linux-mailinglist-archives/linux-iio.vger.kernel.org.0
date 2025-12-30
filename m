Return-Path: <linux-iio+bounces-27432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E6FCEACD1
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 23:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D34F7301B2FC
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 22:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B3F24DCE2;
	Tue, 30 Dec 2025 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmoUUN53"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4670E145B27
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767134903; cv=none; b=HKEV4smMAWTVokpeQJrQrQ6AlC6vMlz7kG7NRKnqYak/E4276HZa7r1JH1rk4YIRl4M1Gm2OtCL138191NG7vXkKUwEKQjariAE3ttxbh0L20gD8I//PsQKSiyih1m3ooFV74jOdVdItivUz7moiwQJXntZkiLPE5vz0/ao6A1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767134903; c=relaxed/simple;
	bh=2je5wPhw5+ZlYngfejHtJBbd/iBRaGw6zlXRFZehPIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBSY7nZTh0aK5Dme5XWq1zGEib7HcYj+nAIs8evH8Gb0rmcCCx3EEWJuLV+WjXB/kpznWFwiYNy0fj+O16RoTdH2OPZVGFWyUXQ8kd5tColm9U8PVplgql5MirgPLntdnrM59xWuU1xqLdQ4/dx62rWyyqUH0ImyKrB6dbfmPZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmoUUN53; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b76b5afdf04so1560427266b.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 14:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767134900; x=1767739700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2je5wPhw5+ZlYngfejHtJBbd/iBRaGw6zlXRFZehPIE=;
        b=MmoUUN53UI9uqt/50D2b5bB7CDAvADf9McE2tlj1m0eaNDzpo7BrYyBOgqmdtcoPfr
         D7UWuE/L8pS5dAglvO7dlZltxSr6FaGyQPitnnLv8GP0NSyNYU3F65xpFc9gqCa8iIwi
         ms69qzwfuRGzHY59v5cu/tfEONmw/x7FFmGZItFxhTlZ8jJwHBzdIzSI/ITkMKdubryY
         Bhnd3hAXfHQRDEQGVP3m2ljaAyiHgYZO3Kef4iMgejAU0a4QWhSP8SmVb2Y2BNug6XOM
         9OGi6b01s8joyCIsyLDElBAlQXlX9SQB5WIphYlYqUmEpsCItFP5z6X8avnhWa1Lk0bd
         oR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767134900; x=1767739700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2je5wPhw5+ZlYngfejHtJBbd/iBRaGw6zlXRFZehPIE=;
        b=SwR3Wd5jtWX6eSNS2Daf+dX4vEh1B+ICGbTT0uhQRKjcD5usjrVfXuOpmlg/tOKFf4
         l4oJizQXfmqcIjWbOX3rxtL0DoZdlhLi3S8B2hU3M0Q6RokOdFvdGjrdwV2yqysIY9uG
         wTMkIoNM4PqbTgxX+/gcDVtdhzxmq9n97/Nn5cvlUcMqkffo8MHOPwpLYVT65QRY3qik
         XU/l7GDKlijlIAhcAv/LuR4qXsdMuTKXiBk1oi+IZQzkkEQWQqZTsrPTOPvyvgOWTIdK
         KI17H5yFeacqr6mL07gDWQmYESTSo4KODh9k+M/7pPAFPA7rGgv3lkTf/U5tmcdZBJ8h
         1Yaw==
X-Forwarded-Encrypted: i=1; AJvYcCUCs5Yk+CANSCjOzPclHoS4OcRzf8fajX4B1wkmoItIdKotT5aZKw962b1Nw/FbwvDezyWfdMo6wjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8Q+XhxZLv+U78usujkDNM1Y1kAnqbu1TkhdKO9VYdKeJ+i4P
	9fedanHXXz4DMU47O7k+AWC4d4EVYF34gv1hzTK4Po2QWDiVJV4BhqLArlTwAWMgrrKm205vWAG
	7n5w8Doy4GGEP1Zp2dLi46fwiDfoSkUk=
X-Gm-Gg: AY/fxX7F3x8XOEGEw/uKYrxnLpvANblY3unGS/TA/mVHSsl/MlP6BEBTewX+qF22Uya
	L0QtRzSwVT/4NMQ64Rdd6rPQXtlJ2VqXdIyKur5tDKjX6vmHho1DceLyV7+im0FMyhmyYnwma3z
	o150vAHeUIIJRD70Igo4wNvTFt+TF5ujWdko8bKd7F+LMcM8cOPSZdn5RYqZm83hmNJzgbeUjd3
	JfmYv3CPadt+1SlgFeqjmwQ/qlVH684fs62eNUvvhnx0KrHbGP1YcsLjwQnYfX6V8zw3Tc6AYes
	ABVhtlAE/9yEQBPtGn5tG8WXvEUWBlfLw2xlwn6yu/hu3Zl8IXKRVKXSLKzysNd3QXzcypAW9lS
	55Xy0G4A=
X-Google-Smtp-Source: AGHT+IEDGoTQI7uKjBc49LAmZVoOmzDjVBgUzQPslVzBe/0D/d2lgEUVoI1oZyRs9ugb/qMJPIM0JKt3f51xPXsCt10=
X-Received: by 2002:a17:907:1c01:b0:b7d:22b1:2145 with SMTP id
 a640c23a62f3a-b8036f2a9f9mr3380566366b.23.1767134900417; Tue, 30 Dec 2025
 14:48:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230203459.28935-1-tomasborquez13@gmail.com> <20251230203459.28935-2-tomasborquez13@gmail.com>
In-Reply-To: <20251230203459.28935-2-tomasborquez13@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Dec 2025 00:47:43 +0200
X-Gm-Features: AQt7F2qPZCaEWiqlEPSM4kOdhk65I8FKSx9FO4nIhZZDWZWt7eP1ebu97mtSFYQ
Message-ID: <CAHp75VfBwsKMdksib_UDMGraoPREBHF-ttcxxBpKvpyV2bEQjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] staging: iio: ad9832: cleanup dev_err_probe()
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 10:35=E2=80=AFPM Tomas Borquez <tomasborquez13@gmai=
l.com> wrote:
>
> Cleanup dev_err_probe() by keeping messages consistent and adding
> error message for clock acquisition failure.

AFAICS this does two things, the second one is reuse of the temporary
variable for struct device.

--=20
With Best Regards,
Andy Shevchenko

