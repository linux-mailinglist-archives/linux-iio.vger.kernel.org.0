Return-Path: <linux-iio+bounces-22483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A3FB1F04C
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 23:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CCE627F5B
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 21:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3614526A0E7;
	Fri,  8 Aug 2025 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQ5oHSQQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54929260583;
	Fri,  8 Aug 2025 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754689112; cv=none; b=a+CCCg9RNCGZFzS92I/VJO+LTwOJGVUAWSGhVMKG6muSCnkWLkiT8i4LVuj67QJ2uwxauXCUlGaDDEZR9FpZLWzAf9xx8tJC4OMiNu8VA5wl0Gi4mm8wVxL1E5w0RqkfDuXtsWzf32xD/kZwyeT09DDTlOi0ShQkCEcAbWpwFTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754689112; c=relaxed/simple;
	bh=6s3/ysQJVb7DOfxFgg9mDd8W+qdwLFwQCgzjRhjVCxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2IHJMcsGtebaOHM3TS3DcdlqLJSBd1hYlCJ5Ph1dm3v5zCo51J3mHgdttBKOoOm7b3K4HrKQ7trdNN/j9hOnlbO2M8ugZr6ltN0gil2flkJgqi8/xBWnqMHnl9fzHPie/5UfVYUwpCNZHh1oRJFgV1/4dC0OD48oQbLTLsUSAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQ5oHSQQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61530559887so4191955a12.1;
        Fri, 08 Aug 2025 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754689108; x=1755293908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Iv/YOCiSsrM6lLGZ1cQu87BoUe+nOMpnSM2Yd2lgVY=;
        b=ZQ5oHSQQRAeBY4MTKc6/PYSDpoYHrpLPvA2pru4COe2R9yVol2uvJnyYLggr4KJ4Bo
         eMpPbQxTJ5+0oXBTDDLJ088Y8XmMF4T/01LG5gbNGPGusUKuQ3l8eqDUsDTM7lCGtwt6
         a5M+uIaHAQj/XcFeqK5i+36KFVL4pnHncV4Ur5S3CZjQ9JaeYN85GJWPa9K3Rtgj2ZBK
         wPLYbZLfnn2M6seUS5ZBJQFs6P6/S/gZwcR6UnJ4QYSApPhfE4Uz7KMQX87ei3X51zpp
         yAKvR69pLHwJyyGzbmcLxmEMD/dfCK0stKTTYduhHnqh0Okh6tTcXncSQj93dtqu7FVc
         laAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754689108; x=1755293908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Iv/YOCiSsrM6lLGZ1cQu87BoUe+nOMpnSM2Yd2lgVY=;
        b=r7IN7n9qTGDIHnL1l/liElLDxMvkQceVZyzDlLRt+Aw3IBzv7j+Ck9EfD6kgRtXb3Q
         Zo4VM9+WIrZj/LNucVdL9va1ddKBZ2SgVzI0urzpU4ebg+re/j+WIxMhv58oCDmEznzz
         OGGvTF8ui6X0HsQX8kbNObSutXZ/dV07EfBgm5NNkWGKx6Rp3YUA3sMpRBlThhLdF8vM
         dvwXbXLKO+Zy3XQZiI/Hug8+y8GoUpXdUK5EGryK0Mh99vywq79j/oAG1RgVg6YCaWFw
         09/6580fqWLSldkdHxhYhc7f94kx8AiL0g+T9l1BpSiFg7ka6zyvnsTPs4ie9l7M3sbl
         lehQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg44I/6TeVU7m6zZJDhML5QtF8DGToNxfbtKLKQsAdxFjBDrEYgsnOgo/vnaR9sjgjBo7B6dkKCybDHQ+C@vger.kernel.org, AJvYcCUo6Nc3T+ITNbclm6qDraLPGMXCcrK41suJOIlmQp3uJbpTmw3N8ZmZHAWBV4U94JvnYj94FNSE2Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTk2c9x+Fisnlh4ogxk6inaZNtRapWjx8p47rc/VtMRNZVvQOX
	ZKLqqJhUF7tLeAFvcvXf47X60lwpcP8a7w6FM6MY0gMmoNkBptnPl4yvA4QV38P4xUJOZHIldZi
	WOex/0RAZq2tvMUKarfkCaHMcIiwfv5c=
X-Gm-Gg: ASbGncsiRzPAr9ksz6x2Y2s/8gd/7uhP1ixnE0duJnGdD24o4wYh7Kkq7yvGdd2BM3x
	zHO+dHajcMZBP/mQRXY+Ab/6Su0Rksr8cUrYnkS6hV45afKwXX/41ZAbSjgHYW9uz17LkJ7z219
	DaRr22nRsaNyX1uVGZg5rFhKrfZqpS7Z/XVW0TnopIStc0Gwk+kY2sNa+QLUDThCQXwzvHS1rVW
	tN0fAz2uA==
X-Google-Smtp-Source: AGHT+IHac0Of7aKvSKOepnJI4DbFa5dVMJEtDQVBawmUCvXOPBzFTMozaAkxQcaXJV6jBqAiPJtIBJWDAQAM718guJs=
X-Received: by 2002:a17:907:9706:b0:ae2:4630:7de4 with SMTP id
 a640c23a62f3a-af9c64beec3mr350596166b.34.1754689108361; Fri, 08 Aug 2025
 14:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-icm42pmreg-v2-0-a480279e7721@geanix.com> <20250808-icm42pmreg-v2-1-a480279e7721@geanix.com>
In-Reply-To: <20250808-icm42pmreg-v2-1-a480279e7721@geanix.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Aug 2025 23:37:51 +0200
X-Gm-Features: Ac12FXxl5I9Gt2GfcA-Rb2y964_ZjzDZC5HDrjoRJua7fwhVZ8Dm2WHhr0RlQEg
Message-ID: <CAHp75VdKNE0xD8xbJQ2RSCA=_MB9DMZtXRTCNkpdKdv8vW-Q-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio: imu: inv_icm42600: Simplify pm_runtime setup
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 5:58=E2=80=AFPM Sean Nyekjaer <sean@geanix.com> wrot=
e:
>
> Rework the power management in inv_icm42600_core_probe() to use
> devm_pm_runtime_set_active_enabled(), which simplifies the runtime PM
> setup by handling activation and enabling in one step.
> Remove the separate inv_icm42600_disable_pm callback, as it's no longer
> needed with the devm-managed approach.
> Using devm_pm_runtime_enable() also fixes the missing disable of
> autosuspend.
> Update inv_icm42600_disable_vddio_reg() to only disable the regulator if
> the device is not suspended i.e. powered-down, preventing unbalanced
> disables.
> Also remove redundant error msg on regulator_disable(), the regulator
> framework already emits an error message when regulator_disable() fails.
>
> This simplifies the PM setup and avoids manipulating the usage counter
> unnecessarily.

...

> +       struct device *dev =3D regmap_get_device(st->map);
>
> +       if (!pm_runtime_status_suspended(dev))
> +               regulator_disable(st->vddio_supply);

I would rather use positive conditional as it seems to me more scalable

>  }


--=20
With Best Regards,
Andy Shevchenko

