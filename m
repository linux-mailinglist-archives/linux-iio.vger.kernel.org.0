Return-Path: <linux-iio+bounces-22225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25384B194FA
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 21:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C68D1731F9
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 19:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43381D63DF;
	Sun,  3 Aug 2025 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyUTKrLV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA30518BBAE
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754248876; cv=none; b=Z4z5wwHxqNP6l2J0Y8Rg+tY9Nvk60sPADwm3U+Bf8DBKJYLv8IS+E0Rw0onq0Z+FS1ekk2xhMlaAJVwb8XbFqKwv5ScRaT3S2yFOTBndmM5bC4r035zQGUpHSr38BRLdqIMOmJJRIS8h1FfnSuiyRc387pfKu7gcJcTb57rkqDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754248876; c=relaxed/simple;
	bh=QBMJMueDvrtUMuHHIpboasNNO6vhsbcenZh7RObkZ5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ER7G881QR+I1jRF4IxgDhyj5dLjaNvQjCzxdJL8yYk7Rgyn22D1yD+HFa6j/rOrJU5pq+T+h2ufg1U+tmTOwREJoJD6OWtamCgLG7M3XZfVTc+5E8c1zK22x5wdTzYdwkTENqPafKcmfAsfszPAfvaW3mxvF249U0eZeiN3b/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyUTKrLV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af967835d0aso57063066b.0
        for <linux-iio@vger.kernel.org>; Sun, 03 Aug 2025 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754248873; x=1754853673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ue7fOSHcDkOo0E3Gll7b0M0bGTz5OgRBsnNiJVKG6wI=;
        b=hyUTKrLVQNlJrtIf16bfkG65Z+TAiDjxTJ0ZGsIvdzDjhFX7BnJcaDqQ1Yk0sk5Sfe
         TxlXQuEibniiAt/F91TiF7BfNtMMy/TGtoAvQHBTdIQl9v9/f/C3axyRmi2HdbN5uArv
         lsPAz61iS6tRYSyeJx3Pily6yQz78br/TSS6aF4WVpHk503xCh4fhZf1Zek5fxiQ1LvQ
         GKA9O3LMiAbTqAqWWCY+ksuhbzlM/d6souZTi/5Jgb+yd1Q1LgUIHmj6d6JEfY0gLlWi
         gipjXqFsDGLxClQ/iZ/QJpvtBOgBjsP2BJ3JfpnLpQ2ZuPXQvhofdpd68DdjlkRQmpKi
         nyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754248873; x=1754853673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ue7fOSHcDkOo0E3Gll7b0M0bGTz5OgRBsnNiJVKG6wI=;
        b=qq4eoQJGhfai7UWl2PC9wHqJ8Nno6r+CBq4DlMbTh6x1PHWESLe16/a7RH7FtLSZbu
         170ita7qx7lTWGT6QU8CWdiUAQ0wAn67A26KHYzR1J3f7jMDF1VdlL+x/E32PG4LB3PK
         R9sEtKOGMFwi9/Mgsdyu4AjuqgGniDDKHXRFEK63nu7fGnZ7jCyD+2rRwCUITJN9ArWE
         5fG6BCdw3e9dd0TticE9n1WtyvGKatydqNn9T1AIOfZW4vEPIFJXt5XJ1t+loLxyKE6W
         LtZ3gh3Zn0SkhkxTynUx30rkl75/8iABcM9TomZ1Fkd6oI5NxJMd+oC8+xRHDrhr+5SO
         aVpQ==
X-Gm-Message-State: AOJu0Yw+PnF+CT26RDr9F387CUJFtk0Xb/ikxOugudT9M9rXUDpNcNnE
	38tNi5oxv0QyzD5zsYdXmZyrD8VtPxDrW0fwfGyJatWHwGGBC4iJ0Tyd2taGJdikpnyEg9/Rhry
	54mbn0P/2WnBBlHJ/sXaM7QYN3j55pAC/0C7ABy8=
X-Gm-Gg: ASbGncu4VUtJKAAZRtro0QktcO2b5ElGpDXGK2zVfCb1ZDFDdye6RLhftdGUP56rBGZ
	LSN1Hj9kUtVGEvY+6O7/z4/dFnabmYwClvilhtGwb4aPHA9vQH1AE/71RyHhWP/r0UcW/qRoc+E
	MjRSG74OCCs+3KcDeG5nNztA3F9LGLUnxzXSUL9ocM2N7MLSjzX40Cxj0b9Mp3aArvyTgz68E6X
	i9QLrzicNUV0ZY83Z8D
X-Google-Smtp-Source: AGHT+IFAVLC6003hmhYwItNH2TD7K7CVDSJ92LtJJqJjfMLJJzpRY+54+MAF8uJWJ4GhuUyZW4PR9Dk+qgMZY0uw1kI=
X-Received: by 2002:a17:907:724a:b0:ad8:9b5d:2c1e with SMTP id
 a640c23a62f3a-af940187813mr663876366b.29.1754248872729; Sun, 03 Aug 2025
 12:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017233022.238250-1-vassilisamir@gmail.com> <20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
In-Reply-To: <20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 3 Aug 2025 21:20:35 +0200
X-Gm-Features: Ac12FXy7gzpGs4z_ngRLHUbHNx3zri1UUUgYeK1ctDJ2BkuXERbnRun6FJwcfxk
Message-ID: <CAHp75VdXDG0JicC3XrwwAWqnSpnSMXNdHDB7QM6amwbzEvCm7w@mail.gmail.com>
Subject: Re: [bmp280 v1 0/6] Fixes and enhancements for the bmp280 driver
To: Achim Gratz <Achim.Gratz@stromeko.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 4:09=E2=80=AFPM Achim Gratz <Achim.Gratz@stromeko.de=
> wrote:
>
> With 6.13 a change was made to the bmp280 drivers to use MODE_FORCED

v6.13

> instead of MODE_NORMAL.  This broke userspace functionality: reading
> from sysfs interfaces no longer worked and an error was thrown
> "Measurement cycle didn't complete".  This series fixes the udnerlying

underlying

> bugs affecting the measurement time calculation and implements
> additional functionality not available for the BMx280 devices
> previously to allow the use of the sysfs interface in MODE_NORMAL
> again and control the corresponding parameters.  The implementation
> follows the already existing facilities for the BMx[35]80 devices even
> though the actual functionality of the BMx280 devices is slightly
> different.

This is interesting how you prepared the series. Please, don't drop
PATCH from the Subject prefix.

--=20
With Best Regards,
Andy Shevchenko

